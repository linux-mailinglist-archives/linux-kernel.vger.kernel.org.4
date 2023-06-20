Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D6340736ED4
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Jun 2023 16:38:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233367AbjFTOip (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Jun 2023 10:38:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45498 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233392AbjFTOi2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Jun 2023 10:38:28 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5FF0A172B
        for <linux-kernel@vger.kernel.org>; Tue, 20 Jun 2023 07:38:19 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E67616127D
        for <linux-kernel@vger.kernel.org>; Tue, 20 Jun 2023 14:38:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0506CC433C8;
        Tue, 20 Jun 2023 14:38:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1687271898;
        bh=r01Ce+uFN5l69uwQajJdVCAt0c3WpiUEnlsvOOYEMa8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=svs41yi6oaWZeeC6/Ryxenj1XnC0Rbb8E7tRjVu8pX2CXPcsnsojqjPZBSQo/Mgw5
         vcW2pGhbZnxK0WlNw1xRKPSj6S06tVSHC0hwpOvwMYOIFo+8+5JguS8/myEPCi5E0t
         ZIr5zkDde4bYkzH4fdksU6ItLabxH0rtizCmUUSA=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Ivan Orlov <ivan.orlov0322@gmail.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Michal Simek <michal.simek@amd.com>,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        linux-arm-kernel@lists.infradead.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: [PATCH 8/9] xilinx_hwicap: make icap_class a static const structure
Date:   Tue, 20 Jun 2023 16:37:59 +0200
Message-ID: <20230620143751.578239-17-gregkh@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230620143751.578239-10-gregkh@linuxfoundation.org>
References: <20230620143751.578239-10-gregkh@linuxfoundation.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2451; i=gregkh@linuxfoundation.org; h=from:subject; bh=/cyDMgy52LAJMOSZNEeNJ5NFiqDPHi3FK27Ni2u6me8=; b=owGbwMvMwCRo6H6F97bub03G02pJDCkTdx7gZzz158bZT2UKbaxJJ39ySizelqmeHXs0Uc+1r Vj1VMeejlgWBkEmBlkxRZYv23iO7q84pOhlaHsaZg4rE8gQBi5OAZiIXAfDgv32fOfZXk/smF+l 8PfjRgX38uN7LjEsuNlin+hw9/nb4CMPbzyTkDGp/HhNEwA=
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
memory, move the icap_class structure to be declared at build time
placing it into read-only memory, instead of having to be dynamically
allocated at load time.

Cc: Arnd Bergmann <arnd@arndb.de>
Cc: Michal Simek <michal.simek@amd.com>
Cc: Benjamin Tissoires <benjamin.tissoires@redhat.com>
Cc: Ivan Orlov <ivan.orlov0322@gmail.com>
Cc: linux-arm-kernel@lists.infradead.org
Suggested-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Ivan Orlov <ivan.orlov0322@gmail.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/char/xilinx_hwicap/xilinx_hwicap.c | 14 +++++++++-----
 1 file changed, 9 insertions(+), 5 deletions(-)

diff --git a/drivers/char/xilinx_hwicap/xilinx_hwicap.c b/drivers/char/xilinx_hwicap/xilinx_hwicap.c
index a46f637da959..527153313a30 100644
--- a/drivers/char/xilinx_hwicap/xilinx_hwicap.c
+++ b/drivers/char/xilinx_hwicap/xilinx_hwicap.c
@@ -113,7 +113,9 @@ static DEFINE_MUTEX(hwicap_mutex);
 static bool probed_devices[HWICAP_DEVICES];
 static struct mutex icap_sem;
 
-static struct class *icap_class;
+static const struct class icap_class = {
+	.name = "xilinx_config",
+};
 
 #define UNIMPLEMENTED 0xFFFF
 
@@ -687,7 +689,7 @@ static int hwicap_setup(struct device *dev, int id,
 		goto failed3;
 	}
 
-	device_create(icap_class, dev, devt, NULL, "%s%d", DRIVER_NAME, id);
+	device_create(&icap_class, dev, devt, NULL, "%s%d", DRIVER_NAME, id);
 	return 0;		/* success */
 
  failed3:
@@ -730,7 +732,7 @@ static int hwicap_remove(struct device *dev)
 	if (!drvdata)
 		return 0;
 
-	device_destroy(icap_class, drvdata->devt);
+	device_destroy(&icap_class, drvdata->devt);
 	cdev_del(&drvdata->cdev);
 	iounmap(drvdata->base_address);
 	release_mem_region(drvdata->mem_start, drvdata->mem_size);
@@ -856,7 +858,9 @@ static int __init hwicap_module_init(void)
 	dev_t devt;
 	int retval;
 
-	icap_class = class_create("xilinx_config");
+	retval = class_register(&icap_class);
+	if (retval)
+		return retval;
 	mutex_init(&icap_sem);
 
 	devt = MKDEV(XHWICAP_MAJOR, XHWICAP_MINOR);
@@ -882,7 +886,7 @@ static void __exit hwicap_module_cleanup(void)
 {
 	dev_t devt = MKDEV(XHWICAP_MAJOR, XHWICAP_MINOR);
 
-	class_destroy(icap_class);
+	class_unregister(&icap_class);
 
 	platform_driver_unregister(&hwicap_platform_driver);
 
-- 
2.41.0

