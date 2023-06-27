Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 595CC7404D9
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Jun 2023 22:20:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230498AbjF0UUR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Jun 2023 16:20:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40134 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231370AbjF0UT4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Jun 2023 16:19:56 -0400
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [213.167.242.64])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9304130D5;
        Tue, 27 Jun 2023 13:19:28 -0700 (PDT)
Received: from umang.jainideasonboard.com (85-160-38-115.reb.o2.cz [85.160.38.115])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id B9B5A31FA;
        Tue, 27 Jun 2023 22:15:57 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1687896958;
        bh=XFgDh+fTQMRiqKvrJjuyeVA6evMq+BgXAzNfMVVf5k4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=YgfQ/hYxACcrzpQ6qGDoqppJzlq4vaKzImYQQfZ4ZvOlo0JDSP6lEPNAvjz1Tm8GR
         TOfti7N/dvhd7b1xH2GDF5AWl2hMkm608zhAg1Gr8a37UYgEW5aaPUGTG+3WE4u6fu
         lF+bpcrTKzw5Ltx4hG3r1KLE/rPBl2KjF8A7KDC8=
From:   Umang Jain <umang.jain@ideasonboard.com>
To:     linux-staging@lists.linux.dev,
        linux-rpi-kernel@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-media@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     stefan.wahren@i2se.com, gregkh@linuxfoundation.org,
        f.fainelli@gmail.com, athierry@redhat.com, error27@gmail.com,
        dave.stevenson@raspberrypi.com, kieran.bingham@ideasonboard.com,
        laurent.pinchart@ideasonboard.com,
        Umang Jain <umang.jain@ideasonboard.com>
Subject: [PATCH v8 4/5] staging: bcm2835-audio: Register bcm2835-audio with vchiq_bus_type
Date:   Tue, 27 Jun 2023 22:16:27 +0200
Message-Id: <20230627201628.207483-5-umang.jain@ideasonboard.com>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20230627201628.207483-1-umang.jain@ideasonboard.com>
References: <20230627201628.207483-1-umang.jain@ideasonboard.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Similar to how bcm2385-camera device is registered, register the
bcm2835-audio with vchiq_bus_type as well.

Signed-off-by: Umang Jain <umang.jain@ideasonboard.com>
---
 .../vc04_services/bcm2835-audio/bcm2835.c       | 17 ++++++++---------
 .../interface/vchiq_arm/vchiq_arm.c             |  6 +-----
 2 files changed, 9 insertions(+), 14 deletions(-)

diff --git a/drivers/staging/vc04_services/bcm2835-audio/bcm2835.c b/drivers/staging/vc04_services/bcm2835-audio/bcm2835.c
index 00bc898b0189..f81a9a4fbd5d 100644
--- a/drivers/staging/vc04_services/bcm2835-audio/bcm2835.c
+++ b/drivers/staging/vc04_services/bcm2835-audio/bcm2835.c
@@ -1,12 +1,12 @@
 // SPDX-License-Identifier: GPL-2.0
 /* Copyright 2011 Broadcom Corporation.  All rights reserved. */
 
-#include <linux/platform_device.h>
-
 #include <linux/init.h>
 #include <linux/slab.h>
 #include <linux/module.h>
 
+#include "../interface/vchiq_arm/vchiq_arm.h"
+#include "../interface/vchiq_arm/vchiq_device.h"
 #include "bcm2835.h"
 
 static bool enable_hdmi;
@@ -268,9 +268,9 @@ static int snd_add_child_devices(struct device *device, u32 numchans)
 	return 0;
 }
 
-static int snd_bcm2835_alsa_probe(struct platform_device *pdev)
+static int snd_bcm2835_alsa_probe(struct vchiq_device *device)
 {
-	struct device *dev = &pdev->dev;
+	struct device *dev = &device->dev;
 	int err;
 
 	if (num_channels <= 0 || num_channels > MAX_SUBSTREAMS) {
@@ -292,20 +292,20 @@ static int snd_bcm2835_alsa_probe(struct platform_device *pdev)
 
 #ifdef CONFIG_PM
 
-static int snd_bcm2835_alsa_suspend(struct platform_device *pdev,
+static int snd_bcm2835_alsa_suspend(struct vchiq_device *device,
 				    pm_message_t state)
 {
 	return 0;
 }
 
-static int snd_bcm2835_alsa_resume(struct platform_device *pdev)
+static int snd_bcm2835_alsa_resume(struct vchiq_device *device)
 {
 	return 0;
 }
 
 #endif
 
-static struct platform_driver bcm2835_alsa_driver = {
+static struct vchiq_driver bcm2835_alsa_driver = {
 	.probe = snd_bcm2835_alsa_probe,
 #ifdef CONFIG_PM
 	.suspend = snd_bcm2835_alsa_suspend,
@@ -315,9 +315,8 @@ static struct platform_driver bcm2835_alsa_driver = {
 		.name = "bcm2835_audio",
 	},
 };
-module_platform_driver(bcm2835_alsa_driver);
+module_vchiq_driver(bcm2835_alsa_driver);
 
 MODULE_AUTHOR("Dom Cobley");
 MODULE_DESCRIPTION("Alsa driver for BCM2835 chip");
 MODULE_LICENSE("GPL");
-MODULE_ALIAS("platform:bcm2835_audio");
diff --git a/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_arm.c b/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_arm.c
index 79d4d0eeb5fb..75da37fa6372 100644
--- a/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_arm.c
+++ b/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_arm.c
@@ -67,8 +67,6 @@ int vchiq_susp_log_level = VCHIQ_LOG_ERROR;
 DEFINE_SPINLOCK(msg_queue_spinlock);
 struct vchiq_state g_state;
 
-static struct platform_device *bcm2835_audio;
-
 struct vchiq_drvdata {
 	const unsigned int cache_line_size;
 	struct rpi_firmware *fw;
@@ -139,6 +137,7 @@ struct vchiq_pagelist_info {
  * the interface.
  */
 static const char *const vchiq_devices[] = {
+	"bcm2835_audio",
 	"bcm2835-camera",
 };
 
@@ -1849,8 +1848,6 @@ static int vchiq_probe(struct platform_device *pdev)
 		goto error_exit;
 	}
 
-	bcm2835_audio = vchiq_register_child(pdev, "bcm2835_audio");
-
 	for (i = 0; i < ARRAY_SIZE(vchiq_devices); i++) {
 		err = vchiq_device_register(&pdev->dev, vchiq_devices[i]);
 		if (err)
@@ -1868,7 +1865,6 @@ static int vchiq_probe(struct platform_device *pdev)
 
 static void vchiq_remove(struct platform_device *pdev)
 {
-	platform_device_unregister(bcm2835_audio);
 	bus_for_each_dev(&vchiq_bus_type, NULL, NULL, vchiq_device_unregister);
 	vchiq_debugfs_deinit();
 	vchiq_deregister_chrdev();
-- 
2.39.1

