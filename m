Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8FC4B69DCB2
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Feb 2023 10:17:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233887AbjBUJRc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Feb 2023 04:17:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56290 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233861AbjBUJR0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Feb 2023 04:17:26 -0500
Received: from out30-113.freemail.mail.aliyun.com (out30-113.freemail.mail.aliyun.com [115.124.30.113])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A18108693
        for <linux-kernel@vger.kernel.org>; Tue, 21 Feb 2023 01:17:24 -0800 (PST)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R161e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046060;MF=jefflexu@linux.alibaba.com;NM=1;PH=DS;RN=6;SR=0;TI=SMTPD_---0VcBkPn9_1676971040;
Received: from localhost(mailfrom:jefflexu@linux.alibaba.com fp:SMTPD_---0VcBkPn9_1676971040)
          by smtp.aliyun-inc.com;
          Tue, 21 Feb 2023 17:17:21 +0800
From:   Jingbo Xu <jefflexu@linux.alibaba.com>
To:     xiang@kernel.org, chao@kernel.org, linux-erofs@lists.ozlabs.org
Cc:     huyue2@coolpad.com, zhujia.zj@bytedance.com,
        linux-kernel@vger.kernel.org
Subject: [PATCH 1/2] erofs: pass accurate blob size to prepare_ondemand_read()
Date:   Tue, 21 Feb 2023 17:17:18 +0800
Message-Id: <20230221091719.126127-2-jefflexu@linux.alibaba.com>
X-Mailer: git-send-email 2.19.1.6.gb485710b
In-Reply-To: <20230221091719.126127-1-jefflexu@linux.alibaba.com>
References: <20230221091719.126127-1-jefflexu@linux.alibaba.com>
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

To make fscache mode support PAGE_SIZE larger than 4KB, the blob image
size may be small than the multiples of PAGE_SIZE (as erofs block size
is no larger than 4KB), while the file range of the blob requested to
read is multiples of PAGE_SIZE and may be larger than the blob image
size.

Therefore we need the accurate blob size, so that the EOF part could be
distinguished and zero-filled then.

Signed-off-by: Jingbo Xu <jefflexu@linux.alibaba.com>
---
 fs/erofs/fscache.c | 13 +++++++++++--
 1 file changed, 11 insertions(+), 2 deletions(-)

diff --git a/fs/erofs/fscache.c b/fs/erofs/fscache.c
index 87ff35bff8d5..f7a1e147d0f4 100644
--- a/fs/erofs/fscache.c
+++ b/fs/erofs/fscache.c
@@ -125,7 +125,7 @@ static int erofs_fscache_read_folios_async(struct fscache_cookie *cookie,
 
 	DBG_BUGON(len > req->len - req->submitted);
 
-	ret = fscache_begin_read_operation(cres, cookie);
+	ret = fscache_begin_wait_operation(cres, cookie, FSCACHE_WANT_READ);
 	if (ret)
 		return ret;
 
@@ -134,8 +134,17 @@ static int erofs_fscache_read_folios_async(struct fscache_cookie *cookie,
 		size_t slen = len - done;
 		unsigned long flags = 1 << NETFS_SREQ_ONDEMAND;
 
+		if (sstart >= cookie->object_size) {
+			iov_iter_xarray(&iter, ITER_DEST, &req->mapping->i_pages,
+					lstart + done, slen);
+			iov_iter_zero(slen, &iter);
+			done += slen;
+			continue;
+		}
+
+		slen = min_t(size_t, slen, cookie->object_size - sstart);
 		source = cres->ops->prepare_ondemand_read(cres,
-				sstart, &slen, LLONG_MAX, &flags, 0);
+				sstart, &slen, cookie->object_size, &flags, 0);
 		if (WARN_ON(slen == 0))
 			source = NETFS_INVALID_READ;
 		if (source != NETFS_READ_FROM_CACHE) {
-- 
2.19.1.6.gb485710b

