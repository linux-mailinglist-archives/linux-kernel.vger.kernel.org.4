Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 907FF695D6E
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Feb 2023 09:48:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231698AbjBNIsd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Feb 2023 03:48:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50506 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229609AbjBNIsb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Feb 2023 03:48:31 -0500
Received: from out30-110.freemail.mail.aliyun.com (out30-110.freemail.mail.aliyun.com [115.124.30.110])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C2DA1717B
        for <linux-kernel@vger.kernel.org>; Tue, 14 Feb 2023 00:48:29 -0800 (PST)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R521e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018045176;MF=jefflexu@linux.alibaba.com;NM=1;PH=DS;RN=4;SR=0;TI=SMTPD_---0VbfArM._1676364506;
Received: from localhost(mailfrom:jefflexu@linux.alibaba.com fp:SMTPD_---0VbfArM._1676364506)
          by smtp.aliyun-inc.com;
          Tue, 14 Feb 2023 16:48:27 +0800
From:   Jingbo Xu <jefflexu@linux.alibaba.com>
To:     dhowells@redhat.com, linux-cachefs@redhat.com
Cc:     jlayton@kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] cachefiles: fix calculation of the number of needed blocks
Date:   Tue, 14 Feb 2023 16:48:26 +0800
Message-Id: <20230214084826.79561-1-jefflexu@linux.alibaba.com>
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

The number of needed blocks shall be measured with block size rather
than PAGE_SIZE.

Fixes: 047487c947e8 ("cachefiles: Implement the I/O routines")
Signed-off-by: Jingbo Xu <jefflexu@linux.alibaba.com>
---
 fs/cachefiles/io.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/fs/cachefiles/io.c b/fs/cachefiles/io.c
index 175a25fcade8..09605891cf85 100644
--- a/fs/cachefiles/io.c
+++ b/fs/cachefiles/io.c
@@ -565,7 +565,7 @@ int __cachefiles_prepare_write(struct cachefiles_object *object,
 	 * space, we need to see if it's fully allocated.  If it's not, we may
 	 * want to cull it.
 	 */
-	if (cachefiles_has_space(cache, 0, *_len / PAGE_SIZE,
+	if (cachefiles_has_space(cache, 0, *_len >> cache->bshift,
 				 cachefiles_has_space_check) == 0)
 		return 0; /* Enough space to simply overwrite the whole block */
 
@@ -597,7 +597,7 @@ int __cachefiles_prepare_write(struct cachefiles_object *object,
 	return ret;
 
 check_space:
-	return cachefiles_has_space(cache, 0, *_len / PAGE_SIZE,
+	return cachefiles_has_space(cache, 0, *_len >> cache->bshift,
 				    cachefiles_has_space_for_write);
 }
 
-- 
2.19.1.6.gb485710b

