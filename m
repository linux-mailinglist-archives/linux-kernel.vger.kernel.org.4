Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E2B1C687F9A
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Feb 2023 15:11:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232148AbjBBOLv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Feb 2023 09:11:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57170 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231695AbjBBOLo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Feb 2023 09:11:44 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F187B8FB7E
        for <linux-kernel@vger.kernel.org>; Thu,  2 Feb 2023 06:11:42 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 7502B61B63
        for <linux-kernel@vger.kernel.org>; Thu,  2 Feb 2023 14:11:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6D28FC433EF;
        Thu,  2 Feb 2023 14:11:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1675347101;
        bh=975b4kPA+NLq0YmeXLwxMZvqYcj3aaM9QWDIE/DupWk=;
        h=From:To:Cc:Subject:Date:From;
        b=SXvYC5vW2/L1O1Nmo3J3G2R2uHvLHPxvr+dq4MsIg5JINzOumTQvcanJNMoRNI6kc
         au35FOqbILogiDGy/cksnHKxUE41nkziisq/3G3XgOEexLL9+9hsIB6/PZOf6oNyQT
         f/ygnynDxAqGmFnATDmvaxW/V98Q7bHemdVr3LLc=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-staging@lists.linux.dev
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Paulo Miguel Almeida <paulo.miguel.almeida.rodenas@gmail.com>,
        Dan Carpenter <error27@gmail.com>,
        Sidong Yang <realwakka@gmail.com>,
        Liu Shixin <liushixin2@huawei.com>,
        =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>, linux-kernel@vger.kernel.org
Subject: [PATCH] staging: pi433: fix memory leak with using debugfs_lookup()
Date:   Thu,  2 Feb 2023 15:11:38 +0100
Message-Id: <20230202141138.2291946-1-gregkh@linuxfoundation.org>
X-Mailer: git-send-email 2.39.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=2772; i=gregkh@linuxfoundation.org; h=from:subject; bh=975b4kPA+NLq0YmeXLwxMZvqYcj3aaM9QWDIE/DupWk=; b=owGbwMvMwCRo6H6F97bub03G02pJDMm3j8zytqh9Wbmqb4ewgPrVYxwNlXwHpz9ft/HQw8lLV/aL L1X42BHLwiDIxCArpsjyZRvP0f0VhxS9DG1Pw8xhZQIZwsDFKQATMQ9gWHBL+vyp15oGrUJyT9rm5l 1gfMhg/Jphnl3WP23VaZxSEhErxFp5J53ucV9xHwA=
X-Developer-Key: i=gregkh@linuxfoundation.org; a=openpgp; fpr=F4B60CC5BF78C2214A313DCB3147D40DDB2DFB29
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When calling debugfs_lookup() the result must have dput() called on it,
otherwise the memory will leak over time.  To make things simpler, just
call debugfs_lookup_and_remove() instead which handles all of the logic
at once.  This requires saving off the root directory dentry to make
creation of individual device subdirectories easier.

Cc: Paulo Miguel Almeida <paulo.miguel.almeida.rodenas@gmail.com>
Cc: Dan Carpenter <error27@gmail.com>
Cc: Sidong Yang <realwakka@gmail.com>
Cc: Liu Shixin <liushixin2@huawei.com>
Cc: "Uwe Kleine-König" <u.kleine-koenig@pengutronix.de>
Cc: linux-staging@lists.linux.dev
Cc: linux-kernel@vger.kernel.org
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/staging/pi433/pi433_if.c | 11 +++++------
 1 file changed, 5 insertions(+), 6 deletions(-)

diff --git a/drivers/staging/pi433/pi433_if.c b/drivers/staging/pi433/pi433_if.c
index d4e06a3929f3..b59f6a4cb611 100644
--- a/drivers/staging/pi433/pi433_if.c
+++ b/drivers/staging/pi433/pi433_if.c
@@ -55,6 +55,7 @@
 static dev_t pi433_dev;
 static DEFINE_IDR(pi433_idr);
 static DEFINE_MUTEX(minor_lock); /* Protect idr accesses */
+static struct dentry *root_dir;	/* debugfs root directory for the driver */
 
 static struct class *pi433_class; /* mainly for udev to create /dev/pi433 */
 
@@ -1306,8 +1307,7 @@ static int pi433_probe(struct spi_device *spi)
 	/* spi setup */
 	spi_set_drvdata(spi, device);
 
-	entry = debugfs_create_dir(dev_name(device->dev),
-				   debugfs_lookup(KBUILD_MODNAME, NULL));
+	entry = debugfs_create_dir(dev_name(device->dev), root_dir);
 	debugfs_create_file("regs", 0400, entry, device, &pi433_debugfs_regs_fops);
 
 	return 0;
@@ -1333,9 +1333,8 @@ static int pi433_probe(struct spi_device *spi)
 static void pi433_remove(struct spi_device *spi)
 {
 	struct pi433_device	*device = spi_get_drvdata(spi);
-	struct dentry *mod_entry = debugfs_lookup(KBUILD_MODNAME, NULL);
 
-	debugfs_remove(debugfs_lookup(dev_name(device->dev), mod_entry));
+	debugfs_lookup_and_remove(dev_name(device->dev), root_dir);
 
 	/* free GPIOs */
 	free_gpio(device);
@@ -1408,7 +1407,7 @@ static int __init pi433_init(void)
 		return PTR_ERR(pi433_class);
 	}
 
-	debugfs_create_dir(KBUILD_MODNAME, NULL);
+	root_dir = debugfs_create_dir(KBUILD_MODNAME, NULL);
 
 	status = spi_register_driver(&pi433_spi_driver);
 	if (status < 0) {
@@ -1427,7 +1426,7 @@ static void __exit pi433_exit(void)
 	spi_unregister_driver(&pi433_spi_driver);
 	class_destroy(pi433_class);
 	unregister_chrdev(MAJOR(pi433_dev), pi433_spi_driver.driver.name);
-	debugfs_remove_recursive(debugfs_lookup(KBUILD_MODNAME, NULL));
+	debugfs_remove(root_dir);
 }
 module_exit(pi433_exit);
 
-- 
2.39.1

