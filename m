Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 510A7736ECF
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Jun 2023 16:38:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233361AbjFTOiQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Jun 2023 10:38:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45112 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233344AbjFTOiN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Jun 2023 10:38:13 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D6576170F
        for <linux-kernel@vger.kernel.org>; Tue, 20 Jun 2023 07:38:07 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 6637A6124C
        for <linux-kernel@vger.kernel.org>; Tue, 20 Jun 2023 14:38:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 78BE0C433C0;
        Tue, 20 Jun 2023 14:38:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1687271886;
        bh=NNeBnpMh0VKltZp3X6U483e9x1db0PB3xLQaZRMH63g=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ZZ41ux87hcYbKBEoQJRWGlh09O0QJ9Tv7sYNj/GDVwttzaawLeyUFHk3MpHDVLzwi
         AkazbBqxfDcb4h/Qel30sUKnpfroQk/wknIyjH+lH9yyFJ1O4Tt6aBvmkDF71H2mqv
         ch65RmdQLcI6SqqxVRgHLRqifdWTmaISOJGx9+Fs=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Ivan Orlov <ivan.orlov0322@gmail.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: [PATCH 4/9] /dev/mem: make mem_class a static const structure
Date:   Tue, 20 Jun 2023 16:37:55 +0200
Message-ID: <20230620143751.578239-13-gregkh@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230620143751.578239-10-gregkh@linuxfoundation.org>
References: <20230620143751.578239-10-gregkh@linuxfoundation.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1765; i=gregkh@linuxfoundation.org; h=from:subject; bh=m32deV9O3pdxzflG4VVrQWKJ6v1wRrZW/H2pWLSYWM4=; b=owGbwMvMwCRo6H6F97bub03G02pJDCkTd+5/cGnfjBVPg9PezJxQW2L9JDywsy32zR+vBoG/w SfV7VkXd8SyMAgyMciKKbJ82cZzdH/FIUUvQ9vTMHNYmUCGMHBxCsBEtqUzLFjp8/2bc5/xP8UL egrz0i/P0VfcKsowT7fsqwlTact081mskY8sOaUYNvAKAwA=
X-Developer-Key: i=gregkh@linuxfoundation.org; a=openpgp; fpr=F4B60CC5BF78C2214A313DCB3147D40DDB2DFB29
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ivan Orlov <ivan.orlov0322@gmail.com>

Now that the driver core allows for struct class to be in read-only
memory, move the mem_class structure to be declared at build time
placing it into read-only memory, instead of having to be dynamically
allocated at load time.

Cc: Arnd Bergmann <arnd@arndb.de>
Suggested-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Ivan Orlov <ivan.orlov0322@gmail.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/char/mem.c | 15 +++++++++------
 1 file changed, 9 insertions(+), 6 deletions(-)

diff --git a/drivers/char/mem.c b/drivers/char/mem.c
index f494d31f2b98..2f944522f18f 100644
--- a/drivers/char/mem.c
+++ b/drivers/char/mem.c
@@ -753,20 +753,23 @@ static char *mem_devnode(const struct device *dev, umode_t *mode)
 	return NULL;
 }
 
-static struct class *mem_class;
+static const struct class mem_class = {
+	.name		= "mem",
+	.devnode	= mem_devnode,
+};
 
 static int __init chr_dev_init(void)
 {
+	int retval;
 	int minor;
 
 	if (register_chrdev(MEM_MAJOR, "mem", &memory_fops))
 		printk("unable to get major %d for memory devs\n", MEM_MAJOR);
 
-	mem_class = class_create("mem");
-	if (IS_ERR(mem_class))
-		return PTR_ERR(mem_class);
+	retval = class_register(&mem_class);
+	if (retval)
+		return retval;
 
-	mem_class->devnode = mem_devnode;
 	for (minor = 1; minor < ARRAY_SIZE(devlist); minor++) {
 		if (!devlist[minor].name)
 			continue;
@@ -777,7 +780,7 @@ static int __init chr_dev_init(void)
 		if ((minor == DEVPORT_MINOR) && !arch_has_dev_port())
 			continue;
 
-		device_create(mem_class, NULL, MKDEV(MEM_MAJOR, minor),
+		device_create(&mem_class, NULL, MKDEV(MEM_MAJOR, minor),
 			      NULL, devlist[minor].name);
 	}
 
-- 
2.41.0

