Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 892AB6E3B66
	for <lists+linux-kernel@lfdr.de>; Sun, 16 Apr 2023 21:05:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229546AbjDPTFo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 16 Apr 2023 15:05:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52836 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229484AbjDPTFn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 16 Apr 2023 15:05:43 -0400
Received: from smtp.smtpout.orange.fr (smtp-22.smtpout.orange.fr [80.12.242.22])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 066DC1FC3
        for <linux-kernel@vger.kernel.org>; Sun, 16 Apr 2023 12:05:40 -0700 (PDT)
Received: from pop-os.home ([86.243.2.178])
        by smtp.orange.fr with ESMTPA
        id o7gupnSP89ijuo7gupFud6; Sun, 16 Apr 2023 21:05:39 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=orange.fr;
        s=t20230301; t=1681671939;
        bh=IVg6fEiAUlOm4eZf7hYcoOgAhxCwgPubM+tzVphnhWA=;
        h=From:To:Cc:Subject:Date;
        b=stcSMDrgerXIwGDnWbFTpJLich5sCmokXWajyYm+hTqyDWD1ySwkL80AfExFKq7Ei
         bK7BYo5b4Ff1B5tdqZJ7aT4fjEPnexivEfJdFVzbqv4PvnmheT9h9rNayHAowfz+eL
         I7KhMpmN21W8PHSti6gf5HunswVUeua7UZMD622kE+ajo0Gx/GResTiROqKUMaLiGj
         ZwAFborjvoKnKsSUh7W5DzJOMwo7G3zmDosgiDOU9DO76gwcWXiXMHHNc9i1KErbXZ
         LM/Ozs44yreCoWTzUahIRG2KBDIzvxCOaxg6ReIfKxz3nYp08I7njdCD+HvUpjLfhM
         v+cg+PSIV0JPA==
X-ME-Helo: pop-os.home
X-ME-Auth: Y2hyaXN0b3BoZS5qYWlsbGV0QHdhbmFkb28uZnI=
X-ME-Date: Sun, 16 Apr 2023 21:05:39 +0200
X-ME-IP: 86.243.2.178
From:   Christophe JAILLET <christophe.jaillet@wanadoo.fr>
To:     Yoshinori Sato <ysato@users.sourceforge.jp>,
        Rich Felker <dalias@libc.org>,
        John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
Cc:     linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        linux-sh@vger.kernel.org
Subject: [PATCH RESEND] sh: sq: Use the bitmap API when applicable
Date:   Sun, 16 Apr 2023 21:05:14 +0200
Message-Id: <071e9f32c19a007f4922903282c9121898641400.1681671848.git.christophe.jaillet@wanadoo.fr>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Using the bitmap API is less verbose than hand writing them.
It also improves the semantic.

Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
---
This is a resend of [1].

Now cross-compile tested with CONFIG_CPU_SUBTYPE_SH7770=y

[1]: https://lore.kernel.org/all/521788e22ad8f7a5058c154f068b061525321841.1656142814.git.christophe.jaillet@wanadoo.fr/
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
 
-	sq_bitmap = kzalloc(size, GFP_KERNEL);
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

