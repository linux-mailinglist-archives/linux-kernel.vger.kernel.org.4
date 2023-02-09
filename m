Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0EFD568FE1F
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Feb 2023 04:52:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232846AbjBIDwa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Feb 2023 22:52:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45224 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231842AbjBIDw2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Feb 2023 22:52:28 -0500
Received: from out30-131.freemail.mail.aliyun.com (out30-131.freemail.mail.aliyun.com [115.124.30.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 272842B09A
        for <linux-kernel@vger.kernel.org>; Wed,  8 Feb 2023 19:52:26 -0800 (PST)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R281e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046049;MF=jefflexu@linux.alibaba.com;NM=1;PH=DS;RN=3;SR=0;TI=SMTPD_---0VbENU2w_1675914744;
Received: from localhost(mailfrom:jefflexu@linux.alibaba.com fp:SMTPD_---0VbENU2w_1675914744)
          by smtp.aliyun-inc.com;
          Thu, 09 Feb 2023 11:52:24 +0800
From:   Jingbo Xu <jefflexu@linux.alibaba.com>
To:     dhowells@redhat.com, linux-cachefs@redhat.com
Cc:     linux-kernel@vger.kernel.org
Subject: [PATCH] fscache: offer the right volume key when printing
Date:   Thu,  9 Feb 2023 11:52:24 +0800
Message-Id: <20230209035224.8317-1-jefflexu@linux.alibaba.com>
X-Mailer: git-send-email 2.19.1.6.gb485710b
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-9.9 required=5.0 tests=BAYES_00,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is a trivial fix as the first slot of volume->key[] actually stores
the length of the volume key.

Signed-off-by: Jingbo Xu <jefflexu@linux.alibaba.com>
---
 fs/fscache/cookie.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/fscache/cookie.c b/fs/fscache/cookie.c
index bce2492186d0..ea13697a8556 100644
--- a/fs/fscache/cookie.c
+++ b/fs/fscache/cookie.c
@@ -46,7 +46,7 @@ void fscache_print_cookie(struct fscache_cookie *cookie, char prefix)
 	pr_err("%c-cookie V=%08x [%s]\n",
 	       prefix,
 	       cookie->volume->debug_id,
-	       cookie->volume->key);
+	       cookie->volume->key + 1);
 
 	k = (cookie->key_len <= sizeof(cookie->inline_key)) ?
 		cookie->inline_key : cookie->key;
-- 
2.19.1.6.gb485710b

