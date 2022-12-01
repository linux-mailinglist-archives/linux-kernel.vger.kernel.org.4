Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CE2E663EA88
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Dec 2022 08:50:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229685AbiLAHuY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Dec 2022 02:50:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58648 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229512AbiLAHuX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Dec 2022 02:50:23 -0500
Received: from out30-8.freemail.mail.aliyun.com (out30-8.freemail.mail.aliyun.com [115.124.30.8])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CEB44442F4
        for <linux-kernel@vger.kernel.org>; Wed, 30 Nov 2022 23:50:21 -0800 (PST)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R291e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018045176;MF=jefflexu@linux.alibaba.com;NM=1;PH=DS;RN=4;SR=0;TI=SMTPD_---0VW7bQwL_1669881018;
Received: from localhost(mailfrom:jefflexu@linux.alibaba.com fp:SMTPD_---0VW7bQwL_1669881018)
          by smtp.aliyun-inc.com;
          Thu, 01 Dec 2022 15:50:19 +0800
From:   Jingbo Xu <jefflexu@linux.alibaba.com>
To:     xiang@kernel.org, chao@kernel.org, linux-erofs@lists.ozlabs.org
Cc:     linux-kernel@vger.kernel.org
Subject: [PATCH] erofs: split inline data reading and tail zeroing in fscache mode
Date:   Thu,  1 Dec 2022 15:50:18 +0800
Message-Id: <20221201075018.27925-1-jefflexu@linux.alibaba.com>
X-Mailer: git-send-email 2.19.1.6.gb485710b
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-9.9 required=5.0 tests=BAYES_00,
        ENV_AND_HDR_SPF_MATCH,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,
        USER_IN_DEF_SPF_WL autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Prior to this patch, the INLINE routine will also zero the tail part of
the folio.  This is reasonable since currently for each file, only the
tail part over EROFS_BLKSIZ boundary is stored as tail packing format,
and thus the tail part in the same folio is treated as EOF and shall be
zeroed.

Since we have supported large folios now and
erofs_fscache_data_read_slice() can be called multiple times for each
folio or folio range, for tail packing format, we can defer zeroing the
EOF part to the UNMAPPED routine in the next calling of
erofs_fscache_data_read_slice().  This cleanup makes the INLINE routine
focusing on reading inline data, while zeroing is left to the UNMAPPED
routine.

Besides, make the naming consistent among INLINE/UNMAPPED/MAPPED
routines.

Signed-off-by: Jingbo Xu <jefflexu@linux.alibaba.com>
---
This relies on the codebase of [1].
[1] https://lore.kernel.org/all/20221201074256.16639-2-jefflexu@linux.alibaba.com/
---
 fs/erofs/fscache.c | 30 ++++++++++++++----------------
 1 file changed, 14 insertions(+), 16 deletions(-)

diff --git a/fs/erofs/fscache.c b/fs/erofs/fscache.c
index f14886c479bd..b416a586d94e 100644
--- a/fs/erofs/fscache.c
+++ b/fs/erofs/fscache.c
@@ -203,7 +203,7 @@ static int erofs_fscache_data_read_slice(struct erofs_fscache_request *primary)
 	struct erofs_map_dev mdev;
 	struct iov_iter iter;
 	loff_t pos = primary->start + primary->submitted;
-	size_t count;
+	size_t size;
 	int ret;
 
 	map.m_la = pos;
@@ -214,7 +214,7 @@ static int erofs_fscache_data_read_slice(struct erofs_fscache_request *primary)
 	if (map.m_flags & EROFS_MAP_META) {
 		struct erofs_buf buf = __EROFS_BUF_INITIALIZER;
 		erofs_blk_t blknr;
-		size_t offset, size;
+		size_t offset;
 		void *src;
 
 		/* For tail packing layout, the offset may be non-zero. */
@@ -226,27 +226,24 @@ static int erofs_fscache_data_read_slice(struct erofs_fscache_request *primary)
 		if (IS_ERR(src))
 			return PTR_ERR(src);
 
-		iov_iter_xarray(&iter, READ, &mapping->i_pages, pos, PAGE_SIZE);
+		iov_iter_xarray(&iter, READ, &mapping->i_pages, pos, size);
 		if (copy_to_iter(src + offset, size, &iter) != size) {
 			erofs_put_metabuf(&buf);
 			return -EFAULT;
 		}
-		iov_iter_zero(PAGE_SIZE - size, &iter);
 		erofs_put_metabuf(&buf);
-		primary->submitted += PAGE_SIZE;
-		return 0;
+		goto out;
 	}
 
-	count = primary->len - primary->submitted;
+	size = primary->len - primary->submitted;
 	if (!(map.m_flags & EROFS_MAP_MAPPED)) {
-		iov_iter_xarray(&iter, READ, &mapping->i_pages, pos, count);
-		iov_iter_zero(count, &iter);
-		primary->submitted += count;
-		return 0;
+		iov_iter_xarray(&iter, READ, &mapping->i_pages, pos, size);
+		iov_iter_zero(size, &iter);
+		goto out;
 	}
 
-	count = min_t(size_t, map.m_llen - (pos - map.m_la), count);
-	DBG_BUGON(!count || count % PAGE_SIZE);
+	size = min_t(size_t, map.m_llen - (pos - map.m_la), size);
+	DBG_BUGON(!size || size % PAGE_SIZE);
 
 	mdev = (struct erofs_map_dev) {
 		.m_deviceid = map.m_deviceid,
@@ -256,14 +253,15 @@ static int erofs_fscache_data_read_slice(struct erofs_fscache_request *primary)
 	if (ret)
 		return ret;
 
-	req = erofs_fscache_req_chain(primary, count);
+	req = erofs_fscache_req_chain(primary, size);
 	if (IS_ERR(req))
 		return PTR_ERR(req);
 
 	ret = erofs_fscache_read_folios_async(mdev.m_fscache->cookie,
-			req, mdev.m_pa + (pos - map.m_la), count);
+			req, mdev.m_pa + (pos - map.m_la), size);
 	erofs_fscache_req_put(req);
-	primary->submitted += count;
+out:
+	primary->submitted += size;
 	return ret;
 }
 
-- 
2.19.1.6.gb485710b

