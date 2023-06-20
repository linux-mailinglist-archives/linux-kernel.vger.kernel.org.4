Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D6310736ED2
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Jun 2023 16:38:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233401AbjFTOid (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Jun 2023 10:38:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45100 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233331AbjFTOiV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Jun 2023 10:38:21 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F1F9E9
        for <linux-kernel@vger.kernel.org>; Tue, 20 Jun 2023 07:38:13 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 63EDD612B3
        for <linux-kernel@vger.kernel.org>; Tue, 20 Jun 2023 14:38:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6E9DFC433C8;
        Tue, 20 Jun 2023 14:38:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1687271892;
        bh=tFkotdkhiC7Dc/uydpF48UD6by1VX5xbM1E1VxLhda0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=UqAnlJ9QkMtCwDmB0JEbxrxHh3Qj6O86MGD6zjrUOyLLbHs2hxj3MFzVJ3nS+izzc
         ug0nB1Zy/JN3CuqZsYQ2jX2mA1W4UQLTcFFYRTIiYpbnx9U1sInk9iuXAFWeikXDR2
         mcpxQm5Si1xgd30uHooD+sDpZ4Ju9KEwosYfVfMA=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Ivan Orlov <ivan.orlov0322@gmail.com>,
        Sudip Mukherjee <sudipm.mukherjee@gmail.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: [PATCH 6/9] ppdev: make ppdev_class a static const structure
Date:   Tue, 20 Jun 2023 16:37:57 +0200
Message-ID: <20230620143751.578239-15-gregkh@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230620143751.578239-10-gregkh@linuxfoundation.org>
References: <20230620143751.578239-10-gregkh@linuxfoundation.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2563; i=gregkh@linuxfoundation.org; h=from:subject; bh=RScdqnuDgdDIu1FDdnJ5Y/jzLaX0n+VXhC5pKgEW+3U=; b=owGbwMvMwCRo6H6F97bub03G02pJDCkTdx6oTfUT8Z37627IZK5t2kcC29Y6Z1wyyzp8u9Tc4 8Crkq9XO2JZGASZGGTFFFm+bOM5ur/ikKKXoe1pmDmsTCBDGLg4BWAiZjwM87R3lF9zncQ3XSkx lWnzu2luJZ+uZTIsmLeSW+D4qfmCuS/3P/rLduFs+tercgA=
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
memory, move the ppdev_class structure to be declared at build time
placing it into read-only memory, instead of having to be dynamically
allocated at load time.

Cc: Sudip Mukherjee <sudipm.mukherjee@gmail.com>
Cc: Arnd Bergmann <arnd@arndb.de>
Suggested-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Ivan Orlov <ivan.orlov0322@gmail.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/char/ppdev.c | 19 ++++++++++---------
 1 file changed, 10 insertions(+), 9 deletions(-)

diff --git a/drivers/char/ppdev.c b/drivers/char/ppdev.c
index 81ed58157b15..4c188e9e477c 100644
--- a/drivers/char/ppdev.c
+++ b/drivers/char/ppdev.c
@@ -773,7 +773,9 @@ static __poll_t pp_poll(struct file *file, poll_table *wait)
 	return mask;
 }
 
-static struct class *ppdev_class;
+static const struct class ppdev_class = {
+	.name = CHRDEV,
+};
 
 static const struct file_operations pp_fops = {
 	.owner		= THIS_MODULE,
@@ -794,7 +796,7 @@ static void pp_attach(struct parport *port)
 	if (devices[port->number])
 		return;
 
-	ret = device_create(ppdev_class, port->dev,
+	ret = device_create(&ppdev_class, port->dev,
 			    MKDEV(PP_MAJOR, port->number), NULL,
 			    "parport%d", port->number);
 	if (IS_ERR(ret)) {
@@ -810,7 +812,7 @@ static void pp_detach(struct parport *port)
 	if (!devices[port->number])
 		return;
 
-	device_destroy(ppdev_class, MKDEV(PP_MAJOR, port->number));
+	device_destroy(&ppdev_class, MKDEV(PP_MAJOR, port->number));
 	devices[port->number] = NULL;
 }
 
@@ -841,11 +843,10 @@ static int __init ppdev_init(void)
 		pr_warn(CHRDEV ": unable to get major %d\n", PP_MAJOR);
 		return -EIO;
 	}
-	ppdev_class = class_create(CHRDEV);
-	if (IS_ERR(ppdev_class)) {
-		err = PTR_ERR(ppdev_class);
+	err = class_register(&ppdev_class);
+	if (err)
 		goto out_chrdev;
-	}
+
 	err = parport_register_driver(&pp_driver);
 	if (err < 0) {
 		pr_warn(CHRDEV ": unable to register with parport\n");
@@ -856,7 +857,7 @@ static int __init ppdev_init(void)
 	goto out;
 
 out_class:
-	class_destroy(ppdev_class);
+	class_unregister(&ppdev_class);
 out_chrdev:
 	unregister_chrdev(PP_MAJOR, CHRDEV);
 out:
@@ -867,7 +868,7 @@ static void __exit ppdev_cleanup(void)
 {
 	/* Clean up all parport stuff */
 	parport_unregister_driver(&pp_driver);
-	class_destroy(ppdev_class);
+	class_unregister(&ppdev_class);
 	unregister_chrdev(PP_MAJOR, CHRDEV);
 }
 
-- 
2.41.0

