Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4EACD736EC5
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Jun 2023 16:38:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233317AbjFTOiA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Jun 2023 10:38:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44864 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231272AbjFTOh6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Jun 2023 10:37:58 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D76595
        for <linux-kernel@vger.kernel.org>; Tue, 20 Jun 2023 07:37:57 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 030926126D
        for <linux-kernel@vger.kernel.org>; Tue, 20 Jun 2023 14:37:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 075CAC433C0;
        Tue, 20 Jun 2023 14:37:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1687271876;
        bh=YE9m+nJJxh6aOa03h/WHgHWu9OpOX6QmULhfRkMKaCk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=PSBem03Ddue+jvEKN2DbbsjQDXD4szBbGdpInvvIfNsny2r1ZP0rQVoxudmxTgEYn
         Y3CTO1mfIzHRky5iVK5Z0O0wbu78eYKyQC/UO8IjSI57NPBxO3l20cibVHggJ/zPjN
         l7rE2Xuh8hRikViB0U5C0Hg5VWF3m2uvneqRepmo=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Ivan Orlov <ivan.orlov0322@gmail.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: [PATCH 2/9] dsp56k: make dsp56k_class a static const structure
Date:   Tue, 20 Jun 2023 16:37:53 +0200
Message-ID: <20230620143751.578239-11-gregkh@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230620143751.578239-10-gregkh@linuxfoundation.org>
References: <20230620143751.578239-10-gregkh@linuxfoundation.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2151; i=gregkh@linuxfoundation.org; h=from:subject; bh=eDeV6EZT0WbX/n0zteTSKFxR5yU/pGMS0Gd2MNY4l2g=; b=owGbwMvMwCRo6H6F97bub03G02pJDCkTd+4/sFjwv/+6ugn/eHVMkvlMPPJa/vodf7T9WqT7V cX7Fh8CO2JZGASZGGTFFFm+bOM5ur/ikKKXoe1pmDmsTCBDGLg4BWAiu1YxzHebcq6D5WzUtnXB 7ikPnToqyy9uYWeYn6Oim7y/dtHtiUr7NCynZ3G+DvwhBAA=
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
memory, move the dsp56k_class structure to be declared at build time
placing it into read-only memory, instead of having to be dynamically
allocated at boot time.

Cc: Arnd Bergmann <arnd@arndb.de>
Suggested-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Ivan Orlov <ivan.orlov0322@gmail.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/char/dsp56k.c | 18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

diff --git a/drivers/char/dsp56k.c b/drivers/char/dsp56k.c
index b3eaf3e5ef2e..bda27e595da1 100644
--- a/drivers/char/dsp56k.c
+++ b/drivers/char/dsp56k.c
@@ -101,7 +101,9 @@ static struct dsp56k_device {
 	int tx_wsize, rx_wsize;
 } dsp56k;
 
-static struct class *dsp56k_class;
+static const struct class dsp56k_class = {
+	.name = "dsp56k",
+};
 
 static int dsp56k_reset(void)
 {
@@ -493,7 +495,7 @@ static const char banner[] __initconst = KERN_INFO "DSP56k driver installed\n";
 
 static int __init dsp56k_init_driver(void)
 {
-	int err = 0;
+	int err;
 
 	if(!MACH_IS_ATARI || !ATARIHW_PRESENT(DSP56K)) {
 		printk("DSP56k driver: Hardware not present\n");
@@ -504,12 +506,10 @@ static int __init dsp56k_init_driver(void)
 		printk("DSP56k driver: Unable to register driver\n");
 		return -ENODEV;
 	}
-	dsp56k_class = class_create("dsp56k");
-	if (IS_ERR(dsp56k_class)) {
-		err = PTR_ERR(dsp56k_class);
+	err = class_register(&dsp56k_class);
+	if (err)
 		goto out_chrdev;
-	}
-	device_create(dsp56k_class, NULL, MKDEV(DSP56K_MAJOR, 0), NULL,
+	device_create(&dsp56k_class, NULL, MKDEV(DSP56K_MAJOR, 0), NULL,
 		      "dsp56k");
 
 	printk(banner);
@@ -524,8 +524,8 @@ module_init(dsp56k_init_driver);
 
 static void __exit dsp56k_cleanup_driver(void)
 {
-	device_destroy(dsp56k_class, MKDEV(DSP56K_MAJOR, 0));
-	class_destroy(dsp56k_class);
+	device_destroy(&dsp56k_class, MKDEV(DSP56K_MAJOR, 0));
+	class_unregister(&dsp56k_class);
 	unregister_chrdev(DSP56K_MAJOR, "dsp56k");
 }
 module_exit(dsp56k_cleanup_driver);
-- 
2.41.0

