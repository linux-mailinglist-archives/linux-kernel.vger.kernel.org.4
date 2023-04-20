Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BDD866E9C66
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Apr 2023 21:19:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231224AbjDTTTa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Apr 2023 15:19:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44332 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231954AbjDTTTZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Apr 2023 15:19:25 -0400
Received: from smtp.smtpout.orange.fr (smtp-11.smtpout.orange.fr [80.12.242.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E8B755B8
        for <linux-kernel@vger.kernel.org>; Thu, 20 Apr 2023 12:19:08 -0700 (PDT)
Received: from pop-os.home ([86.243.2.178])
        by smtp.orange.fr with ESMTPA
        id pZo7pjZIVLbpDpZo8pVyl8; Thu, 20 Apr 2023 21:19:05 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wanadoo.fr;
        s=t20230301; t=1682018345;
        bh=xEO8CI9H9WDO+PWu0PIXBsB8fTZqe2/3Shi9OjFKgUE=;
        h=From:To:Cc:Subject:Date;
        b=d7DupFV1mk554xgT7ZmeBZ2PilYiuqaqFgfYq0DWlJN6USgDG1I1rM+fUGT1I363i
         O6Rw+b7pIRwd+G7hHsbBPvD9a0gZyfvMFh5utXc3AgnRd6snMLZXdBEl3SAZ9jH1N/
         PTCrhMoNKF1fojEC6NgjF+l/Y+meLDIoemkomHDNCrAPIpYYnyV0SZFyHm7w4KDV/S
         ZBzejECVQ4bEAMlYRl6Yc5LKHSUvXbvYUiEzsKf+WSk8t8W8XPosEqA0iSLF9xAqn+
         IkSAonHcDssNK8l5dglnOu4/0H6AJnvH7OyGZYElA122UtSW2eSe/CrrSE+rUgEbFB
         tb5Hu+LNwIv+w==
X-ME-Helo: pop-os.home
X-ME-Auth: Y2hyaXN0b3BoZS5qYWlsbGV0QHdhbmFkb28uZnI=
X-ME-Date: Thu, 20 Apr 2023 21:19:05 +0200
X-ME-IP: 86.243.2.178
From:   Christophe JAILLET <christophe.jaillet@wanadoo.fr>
To:     Yoshinori Sato <ysato@users.sourceforge.jp>,
        Rich Felker <dalias@libc.org>,
        John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
Cc:     linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        linux-sh@vger.kernel.org
Subject: [PATCH v2] sh: sq: Use the bitmap API when applicable
Date:   Thu, 20 Apr 2023 21:19:03 +0200
Message-Id: <a51e9f32c19a007f4922943282cb12c89064440d.1681671848.git.christophe.jaillet@wanadoo.fr>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Using the bitmap API is less verbose than hand writing it.
It also improves the semantic.

Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
---
v2:
   - synch with latest linux-next because of 80f746e2bd0e which fixes a bug
---
 arch/sh/kernel/cpu/sh4/sq.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/arch/sh/kernel/cpu/sh4/sq.c b/arch/sh/kernel/cpu/sh4/sq.c
index 27f2e3da5aa2..d289e99dc118 100644
--- a/arch/sh/kernel/cpu/sh4/sq.c
+++ b/arch/sh/kernel/cpu/sh4/sq.c
@@ -372,7 +372,6 @@ static struct subsys_interface sq_interface = {
 static int __init sq_api_init(void)
 {
 	unsigned int nr_pages = 0x04000000 >> PAGE_SHIFT;
-	unsigned int size = (nr_pages + (BITS_PER_LONG - 1)) / BITS_PER_LONG;
 	int ret = -ENOMEM;
 
 	printk(KERN_NOTICE "sq: Registering store queue API.\n");
@@ -382,7 +381,7 @@ static int __init sq_api_init(void)
 	if (unlikely(!sq_cache))
 		return ret;
 
-	sq_bitmap = kcalloc(size, sizeof(long), GFP_KERNEL);
+	sq_bitmap = bitmap_zalloc(nr_pages, GFP_KERNEL);
 	if (unlikely(!sq_bitmap))
 		goto out;
 
@@ -393,7 +392,7 @@ static int __init sq_api_init(void)
 	return 0;
 
 out:
-	kfree(sq_bitmap);
+	bitmap_free(sq_bitmap);
 	kmem_cache_destroy(sq_cache);
 
 	return ret;
@@ -402,7 +401,7 @@ static int __init sq_api_init(void)
 static void __exit sq_api_exit(void)
 {
 	subsys_interface_unregister(&sq_interface);
-	kfree(sq_bitmap);
+	bitmap_free(sq_bitmap);
 	kmem_cache_destroy(sq_cache);
 }
 
-- 
2.34.1

