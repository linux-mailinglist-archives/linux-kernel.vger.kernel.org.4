Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5FCEF651C8C
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Dec 2022 09:44:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233267AbiLTIoc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Dec 2022 03:44:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50408 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229563AbiLTIoW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Dec 2022 03:44:22 -0500
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [213.167.242.64])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E06DF165A2;
        Tue, 20 Dec 2022 00:44:21 -0800 (PST)
Received: from umang.jainideasonboard.com (unknown [IPv6:2401:4900:1f3e:7d24:3f0:3e81:fb16:ab4d])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id 243D1706;
        Tue, 20 Dec 2022 09:44:12 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1671525858;
        bh=1triUCa/aX1cYKetnYSka1IIP/TJdArJ7sRBk19dSjE=;
        h=From:To:Cc:Subject:Date:From;
        b=lW6yOsRXaEEx7EtzlV+p0HcHDs9Va6mi7dEkWRHKKe8cKrRZwhjZRHNid6j1USFHA
         8AO69cPVPSrllg21zx36nnafR2zRlujrn+3nth3/4Z4aRrtEIPAxRFk2P+AYUmmUFF
         kDbbBETAD4XBebiRSoQFlB5a4nGnCAE5bR5PtL3c=
From:   Umang Jain <umang.jain@ideasonboard.com>
To:     linux-staging@lists.linux.dev,
        linux-rpi-kernel@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-media@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Stefan Wahren <stefan.wahren@i2se.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Adrien Thierry <athierry@redhat.com>,
        Dan Carpenter <error27@gmail.com>,
        Nicolas Saenz Julienne <nsaenz@kernel.org>,
        Phil Elwell <phil@raspberrypi.com>,
        Dave Stevenson <dave.stevenson@raspberrypi.com>,
        Kieran Bingham <kieran.bingham@ideasonboard.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Umang Jain <umang.jain@ideasonboard.com>
Subject: [PATCH] staging: vc04_services: vchiq_arm: Create platform_device per device
Date:   Tue, 20 Dec 2022 14:14:04 +0530
Message-Id: <20221220084404.19280-1-umang.jain@ideasonboard.com>
X-Mailer: git-send-email 2.38.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Create a proper per device platorm_device structure for all the child
devices that needs to be registered by vchiq platform driver. Replace
the vchiq_register_child() with platform_add_devices() to register the
child devices.

This is part of an effort to address TODO item "Get rid of all non
essential global structures and create a proper per device structure"

Signed-off-by: Umang Jain <umang.jain@ideasonboard.com>
---
 .../interface/vchiq_arm/vchiq_arm.c           | 59 ++++++++++---------
 1 file changed, 31 insertions(+), 28 deletions(-)

diff --git a/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_arm.c b/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_arm.c
index 22de23f3af02..fa42ea3791a7 100644
--- a/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_arm.c
+++ b/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_arm.c
@@ -65,8 +65,29 @@ int vchiq_susp_log_level = VCHIQ_LOG_ERROR;
 DEFINE_SPINLOCK(msg_queue_spinlock);
 struct vchiq_state g_state;
 
-static struct platform_device *bcm2835_camera;
-static struct platform_device *bcm2835_audio;
+static u64 vchiq_device_dmamask = DMA_BIT_MASK(32);
+
+static struct platform_device bcm2835_camera = {
+	.name		= "bcm2835-camera",
+	.id		= PLATFORM_DEVID_NONE,
+	.dev		= {
+		.dma_mask	= &vchiq_device_dmamask,
+	}
+};
+
+static struct platform_device bcm2835_audio = {
+	.name		= "bcm2835_audio",
+	.id		= PLATFORM_DEVID_NONE,
+	.dev		= {
+		.dma_mask	= &vchiq_device_dmamask,
+	}
+
+};
+
+static struct platform_device *vchiq_devices[] __initdata = {
+	&bcm2835_camera,
+	&bcm2835_audio,
+};
 
 struct vchiq_drvdata {
 	const unsigned int cache_line_size;
@@ -1763,28 +1784,6 @@ static const struct of_device_id vchiq_of_match[] = {
 };
 MODULE_DEVICE_TABLE(of, vchiq_of_match);
 
-static struct platform_device *
-vchiq_register_child(struct platform_device *pdev, const char *name)
-{
-	struct platform_device_info pdevinfo;
-	struct platform_device *child;
-
-	memset(&pdevinfo, 0, sizeof(pdevinfo));
-
-	pdevinfo.parent = &pdev->dev;
-	pdevinfo.name = name;
-	pdevinfo.id = PLATFORM_DEVID_NONE;
-	pdevinfo.dma_mask = DMA_BIT_MASK(32);
-
-	child = platform_device_register_full(&pdevinfo);
-	if (IS_ERR(child)) {
-		dev_warn(&pdev->dev, "%s not registered\n", name);
-		child = NULL;
-	}
-
-	return child;
-}
-
 static int vchiq_probe(struct platform_device *pdev)
 {
 	struct device_node *fw_node;
@@ -1832,8 +1831,11 @@ static int vchiq_probe(struct platform_device *pdev)
 		goto error_exit;
 	}
 
-	bcm2835_camera = vchiq_register_child(pdev, "bcm2835-camera");
-	bcm2835_audio = vchiq_register_child(pdev, "bcm2835_audio");
+	err = platform_add_devices(vchiq_devices, ARRAY_SIZE(vchiq_devices));
+	if (err) {
+		dev_warn(&pdev->dev, "Failed to add vchiq child devices");
+		goto error_exit;
+	}
 
 	return 0;
 
@@ -1845,8 +1847,9 @@ static int vchiq_probe(struct platform_device *pdev)
 
 static int vchiq_remove(struct platform_device *pdev)
 {
-	platform_device_unregister(bcm2835_audio);
-	platform_device_unregister(bcm2835_camera);
+	for (unsigned int i = 0; i < ARRAY_SIZE(vchiq_devices); i++)
+		platform_device_unregister(vchiq_devices[i]);
+
 	vchiq_debugfs_deinit();
 	vchiq_deregister_chrdev();
 
-- 
2.38.1

