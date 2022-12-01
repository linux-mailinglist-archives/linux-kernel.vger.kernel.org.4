Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7571A63EE94
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Dec 2022 11:59:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231230AbiLAK7p (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Dec 2022 05:59:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40382 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230430AbiLAK7L (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Dec 2022 05:59:11 -0500
Received: from out30-44.freemail.mail.aliyun.com (out30-44.freemail.mail.aliyun.com [115.124.30.44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 27790AD9AD
        for <linux-kernel@vger.kernel.org>; Thu,  1 Dec 2022 02:58:32 -0800 (PST)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R111e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018045168;MF=jefflexu@linux.alibaba.com;NM=0;PH=DS;RN=4;SR=0;TI=SMTPD_---0VW8aXKh_1669892309;
Received: from localhost(mailfrom:jefflexu@linux.alibaba.com fp:SMTPD_---0VW8aXKh_1669892309)
          by smtp.aliyun-inc.com;
          Thu, 01 Dec 2022 18:58:30 +0800
From:   Jingbo Xu <jefflexu@linux.alibaba.com>
To:     xiang@kernel.org, chao@kernel.org, linux-erofs@lists.ozlabs.org
Cc:     linux-kernel@vger.kernel.org
Subject: [PATCH v2] erofs: split inline data reading and tail zeroing in fscache mode
Date:   Thu,  1 Dec 2022 18:58:29 +0800
Message-Id: <20221201105829.90692-1-jefflexu@linux.alibaba.com>
X-Mailer: git-send-email 2.19.1.6.gb485710b
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-9.9 required=5.0 tests=BAYES_00,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        UNPARSEABLE_RELAY,USER_IN_DEF_SPF_WL autolearn=ham autolearn_force=no
        version=3.4.6
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
v2: rename 'size' to 'count' to make git diff statistics more cleaner,
while v1 renames 'count' to 'size'

v1: https://lore.kernel.org/all/20221201075018.27925-1-jefflexu@linux.alibaba.com/
---
 fs/erofs/fscache.c | 16 +++++++---------
 1 file changed, 7 insertions(+), 9 deletions(-)

diff --git a/fs/erofs/fscache.c b/fs/erofs/fscache.c
index f14886c479bd..c9bf59aac5ac 100644
--- a/fs/erofs/fscache.c
+++ b/fs/erofs/fscache.c
@@ -214,35 +214,32 @@ static int erofs_fscache_data_read_slice(struct erofs_fscache_request *primary)
 	if (map.m_flags & EROFS_MAP_META) {
 		struct erofs_buf buf = __EROFS_BUF_INITIALIZER;
 		erofs_blk_t blknr;
-		size_t offset, size;
+		size_t offset;
 		void *src;
 
 		/* For tail packing layout, the offset may be non-zero. */
 		offset = erofs_blkoff(map.m_pa);
 		blknr = erofs_blknr(map.m_pa);
-		size = map.m_llen;
+		count = map.m_llen;
 
 		src = erofs_read_metabuf(&buf, sb, blknr, EROFS_KMAP);
 		if (IS_ERR(src))
 			return PTR_ERR(src);
 
-		iov_iter_xarray(&iter, READ, &mapping->i_pages, pos, PAGE_SIZE);
-		if (copy_to_iter(src + offset, size, &iter) != size) {
+		iov_iter_xarray(&iter, READ, &mapping->i_pages, pos, count);
+		if (copy_to_iter(src + offset, count, &iter) != count) {
 			erofs_put_metabuf(&buf);
 			return -EFAULT;
 		}
-		iov_iter_zero(PAGE_SIZE - size, &iter);
 		erofs_put_metabuf(&buf);
-		primary->submitted += PAGE_SIZE;
-		return 0;
+		goto out;
 	}
 
 	count = primary->len - primary->submitted;
 	if (!(map.m_flags & EROFS_MAP_MAPPED)) {
 		iov_iter_xarray(&iter, READ, &mapping->i_pages, pos, count);
 		iov_iter_zero(count, &iter);
-		primary->submitted += count;
-		return 0;
+		goto out;
 	}
 
 	count = min_t(size_t, map.m_llen - (pos - map.m_la), count);
@@ -263,6 +260,7 @@ static int erofs_fscache_data_read_slice(struct erofs_fscache_request *primary)
 	ret = erofs_fscache_read_folios_async(mdev.m_fscache->cookie,
 			req, mdev.m_pa + (pos - map.m_la), count);
 	erofs_fscache_req_put(req);
+out:
 	primary->submitted += count;
 	return ret;
 }
-- 
2.19.1.6.gb485710b

