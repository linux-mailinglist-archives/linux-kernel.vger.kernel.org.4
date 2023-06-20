Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EBCFA736ED5
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Jun 2023 16:38:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233330AbjFTOis (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Jun 2023 10:38:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45322 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233371AbjFTOi3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Jun 2023 10:38:29 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 482B619B9
        for <linux-kernel@vger.kernel.org>; Tue, 20 Jun 2023 07:38:22 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B61E7612CE
        for <linux-kernel@vger.kernel.org>; Tue, 20 Jun 2023 14:38:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C55D3C433CA;
        Tue, 20 Jun 2023 14:38:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1687271901;
        bh=SBqR0b/G7NdQJEKcKs88hL5JacXmXZMe/k0Egq41e/4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=jCixr9sUu60TyJnN7hJpLHQfwGbO5RrBRSvaTfpbQr0FEMyN2FMIpubV3lU22NcxB
         fCjiOIwlmVzgzI1042LHWeFqT4Ai/NuaflTBjpph0LasJEW7TWjyWzrrHEWqRuczBM
         WqIb/DIk5OyhTswFudsvwmgkniZhcifeBMbFcHaE=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Ivan Orlov <ivan.orlov0322@gmail.com>,
        Eli Billauer <eli.billauer@gmail.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: [PATCH 9/9] char: xillybus: make xillybus_class a static const structure
Date:   Tue, 20 Jun 2023 16:38:00 +0200
Message-ID: <20230620143751.578239-18-gregkh@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230620143751.578239-10-gregkh@linuxfoundation.org>
References: <20230620143751.578239-10-gregkh@linuxfoundation.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2566; i=gregkh@linuxfoundation.org; h=from:subject; bh=LzwP0BkjV3W+sXqBaEm9wchHpeRuVoG6aFsdXlWGz6g=; b=owGbwMvMwCRo6H6F97bub03G02pJDCkTdx4o+vnvW0DA7hL7zQWfZumynZ2Wb/I8Mkj3S+3zE y7ltzhedcSyMAgyMciKKbJ82cZzdH/FIUUvQ9vTMHNYmUCGMHBxCsBEPNgY5plpfJsT2HJ94rtZ Pe9Z+Uxda5afbWWYpy3W4CaVvriS1+r93+M7HPtXfNgtCwA=
X-Developer-Key: i=gregkh@linuxfoundation.org; a=openpgp; fpr=F4B60CC5BF78C2214A313DCB3147D40DDB2DFB29
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ivan Orlov <ivan.orlov0322@gmail.com>

Now that the driver core allows for struct class to be in read-only
memory, move the xillybus_class structure to be declared at build time
placing it into read-only memory, instead of having to be dynamically
allocated at load time.

Cc: Eli Billauer <eli.billauer@gmail.com>
Cc: Arnd Bergmann <arnd@arndb.de>
Suggested-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Ivan Orlov <ivan.orlov0322@gmail.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/char/xillybus/xillybus_class.c | 21 ++++++++-------------
 1 file changed, 8 insertions(+), 13 deletions(-)

diff --git a/drivers/char/xillybus/xillybus_class.c b/drivers/char/xillybus/xillybus_class.c
index 89926fe9d813..c92a628e389e 100644
--- a/drivers/char/xillybus/xillybus_class.c
+++ b/drivers/char/xillybus/xillybus_class.c
@@ -23,7 +23,9 @@ MODULE_LICENSE("GPL v2");
 
 static DEFINE_MUTEX(unit_mutex);
 static LIST_HEAD(unit_list);
-static struct class *xillybus_class;
+static const struct class xillybus_class = {
+	.name = "xillybus",
+};
 
 #define UNITNAMELEN 16
 
@@ -121,7 +123,7 @@ int xillybus_init_chrdev(struct device *dev,
 		len -= namelen + 1;
 		idt += namelen + 1;
 
-		device = device_create(xillybus_class,
+		device = device_create(&xillybus_class,
 				       NULL,
 				       MKDEV(unit->major,
 					     i + unit->lowest_minor),
@@ -152,7 +154,7 @@ int xillybus_init_chrdev(struct device *dev,
 
 unroll_device_create:
 	for (i--; i >= 0; i--)
-		device_destroy(xillybus_class, MKDEV(unit->major,
+		device_destroy(&xillybus_class, MKDEV(unit->major,
 						     i + unit->lowest_minor));
 
 	cdev_del(unit->cdev);
@@ -193,7 +195,7 @@ void xillybus_cleanup_chrdev(void *private_data,
 	for (minor = unit->lowest_minor;
 	     minor < (unit->lowest_minor + unit->num_nodes);
 	     minor++)
-		device_destroy(xillybus_class, MKDEV(unit->major, minor));
+		device_destroy(&xillybus_class, MKDEV(unit->major, minor));
 
 	cdev_del(unit->cdev);
 
@@ -242,19 +244,12 @@ EXPORT_SYMBOL(xillybus_find_inode);
 
 static int __init xillybus_class_init(void)
 {
-	xillybus_class = class_create("xillybus");
-
-	if (IS_ERR(xillybus_class)) {
-		pr_warn("Failed to register xillybus class\n");
-
-		return PTR_ERR(xillybus_class);
-	}
-	return 0;
+	return class_register(&xillybus_class);
 }
 
 static void __exit xillybus_class_exit(void)
 {
-	class_destroy(xillybus_class);
+	class_unregister(&xillybus_class);
 }
 
 module_init(xillybus_class_init);
-- 
2.41.0

