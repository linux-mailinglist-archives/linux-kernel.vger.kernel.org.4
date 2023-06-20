Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D7545736ECE
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Jun 2023 16:38:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233333AbjFTOiM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Jun 2023 10:38:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44896 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233122AbjFTOiG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Jun 2023 10:38:06 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1368C1709
        for <linux-kernel@vger.kernel.org>; Tue, 20 Jun 2023 07:38:05 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9CD6A6127D
        for <linux-kernel@vger.kernel.org>; Tue, 20 Jun 2023 14:38:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AED7EC433C8;
        Tue, 20 Jun 2023 14:38:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1687271884;
        bh=aL+zPU+4ql5HlCKxKr8ENZd/vHFVLtnUtN7tBrGgRrc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=zHbhCU7a8ubHXxx2tXw676Qo8kSg0qM21ETCGWViK7U/G1YrVzaNBaAt6zkhBhwI6
         VeA4gqzq5gxQO60/AoZWnYcp2/QcBpbZlim5i1/tVVYE2YlOfdcAJXpFwdNelhw7Th
         amGQth1g1gGTNis66+yJcveIYVfPSGpGNjDZu7tc=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Ivan Orlov <ivan.orlov0322@gmail.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: [PATCH 3/9] char: lp: make lp_class a static const structure
Date:   Tue, 20 Jun 2023 16:37:54 +0200
Message-ID: <20230620143751.578239-12-gregkh@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230620143751.578239-10-gregkh@linuxfoundation.org>
References: <20230620143751.578239-10-gregkh@linuxfoundation.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2420; i=gregkh@linuxfoundation.org; h=from:subject; bh=d1GSl0pDYIsh4omT1MKF3Zrqgoaggl/D/FsxIzUumgQ=; b=owGbwMvMwCRo6H6F97bub03G02pJDCkTd+7fYH1le9033YBEy3vNh9Kqt7kKNRakvX6vWfJuv 8qs51XVHbEsDIJMDLJiiixftvEc3V9xSNHL0PY0zBxWJpAhDFycAjCRxQoM88ssC1fOmvLPe8aR dP9+a1nuXC+X7QwLmlb7Z6XMmXXaioXfke3DzwUi7x1fAgA=
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
memory, move the lp_class structure to be declared at build time
placing it into read-only memory, instead of having to be dynamically
allocated at load time.

Cc: Arnd Bergmann <arnd@arndb.de>
Suggested-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Ivan Orlov <ivan.orlov0322@gmail.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/char/lp.c | 18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

diff --git a/drivers/char/lp.c b/drivers/char/lp.c
index 70cfc5140c2c..2f171d14b9b5 100644
--- a/drivers/char/lp.c
+++ b/drivers/char/lp.c
@@ -145,7 +145,9 @@ static struct lp_struct lp_table[LP_NO];
 static int port_num[LP_NO];
 
 static unsigned int lp_count = 0;
-static struct class *lp_class;
+static const struct class lp_class = {
+	.name = "printer",
+};
 
 #ifdef CONFIG_LP_CONSOLE
 static struct parport *console_registered;
@@ -932,7 +934,7 @@ static int lp_register(int nr, struct parport *port)
 	if (reset)
 		lp_reset(nr);
 
-	device_create(lp_class, port->dev, MKDEV(LP_MAJOR, nr), NULL,
+	device_create(&lp_class, port->dev, MKDEV(LP_MAJOR, nr), NULL,
 		      "lp%d", nr);
 
 	printk(KERN_INFO "lp%d: using %s (%s).\n", nr, port->name,
@@ -1004,7 +1006,7 @@ static void lp_detach(struct parport *port)
 		if (port_num[n] == port->number) {
 			port_num[n] = -1;
 			lp_count--;
-			device_destroy(lp_class, MKDEV(LP_MAJOR, n));
+			device_destroy(&lp_class, MKDEV(LP_MAJOR, n));
 			parport_unregister_device(lp_table[n].dev);
 		}
 	}
@@ -1049,11 +1051,9 @@ static int __init lp_init(void)
 		return -EIO;
 	}
 
-	lp_class = class_create("printer");
-	if (IS_ERR(lp_class)) {
-		err = PTR_ERR(lp_class);
+	err = class_register(&lp_class);
+	if (err)
 		goto out_reg;
-	}
 
 	if (parport_register_driver(&lp_driver)) {
 		printk(KERN_ERR "lp: unable to register with parport\n");
@@ -1072,7 +1072,7 @@ static int __init lp_init(void)
 	return 0;
 
 out_class:
-	class_destroy(lp_class);
+	class_unregister(&lp_class);
 out_reg:
 	unregister_chrdev(LP_MAJOR, "lp");
 	return err;
@@ -1115,7 +1115,7 @@ static void lp_cleanup_module(void)
 #endif
 
 	unregister_chrdev(LP_MAJOR, "lp");
-	class_destroy(lp_class);
+	class_unregister(&lp_class);
 }
 
 __setup("lp=", lp_setup);
-- 
2.41.0

