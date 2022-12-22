Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DDEAA654670
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Dec 2022 20:15:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235392AbiLVTPu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Dec 2022 14:15:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46094 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235397AbiLVTPn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Dec 2022 14:15:43 -0500
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [IPv6:2001:4b98:dc2:55:216:3eff:fef7:d647])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E2EC28E3F;
        Thu, 22 Dec 2022 11:15:38 -0800 (PST)
Received: from umang.jainideasonboard.com (unknown [IPv6:2401:4900:1f3f:d076:4da6:b729:f032:ed0a])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id 5558AD1D;
        Thu, 22 Dec 2022 20:15:31 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1671736536;
        bh=UfLBAATkzD9U4stHiW/1mzjiTeAr0HmtQX04bnFhvF8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=aITi7TmA0EOroVzsJ9FqxJ9gy86SyUVUC++vZHXksel5bCRccVmDOWyJ1AKMjRP6l
         eWO0vHChMq/M/Zu1NQDBBqlHF54SlBUCc0nG7AFaTKZPdlgPte+Kr2UxaiYctcWfkh
         Dv/0GvVDWBScvp380GaZb/IE9nRaPY5XoK7Dch6s=
From:   Umang Jain <umang.jain@ideasonboard.com>
To:     linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-staging@lists.linux.dev,
        linux-rpi-kernel@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Adrien Thierry <athierry@redhat.com>,
        Stefan Wahren <stefan.wahren@i2se.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Dan Carpenter <error27@gmail.com>,
        Nicolas Saenz Julienne <nsaenz@kernel.org>,
        Phil Elwell <phil@raspberrypi.com>,
        Dave Stevenson <dave.stevenson@raspberrypi.com>,
        Kieran Bingham <kieran.bingham@ideasonboard.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Umang Jain <umang.jain@ideasonboard.com>
Subject: [PATCH v2 4/4] staging: vchiq: Rework child platform device (un)register
Date:   Fri, 23 Dec 2022 00:45:00 +0530
Message-Id: <20221222191500.515795-5-umang.jain@ideasonboard.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20221222191500.515795-1-umang.jain@ideasonboard.com>
References: <20221222191500.515795-1-umang.jain@ideasonboard.com>
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

This patch reworks how the child platform devices are (un)registered
by the vchiq driver. It drops the global references to the child platform
devices thereby reducing the scope of platform device access to probe()
function only. It does so, by maintaining an array of platform device
names and registering each of them through vchiq_register_child().
In addition to that, any new child platform device can be
(un)regsitered easily by just appending to the child platform devices'
array.

For platform device unregisterion, device_for_each_child() helper is
used to call vchiq_unregister_child() on each of the child platform
device of vchiq driver.

This is part of an effort to address TODO item "Get rid of all non
essential global structures and create a proper per device structure"

Signed-off-by: Umang Jain <umang.jain@ideasonboard.com>
---
 .../interface/vchiq_arm/vchiq_arm.c           | 28 ++++++++++++-------
 1 file changed, 18 insertions(+), 10 deletions(-)

diff --git a/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_arm.c b/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_arm.c
index ba34e4d603d4..d04dbea833ac 100644
--- a/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_arm.c
+++ b/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_arm.c
@@ -65,9 +65,6 @@ int vchiq_susp_log_level = VCHIQ_LOG_ERROR;
 DEFINE_SPINLOCK(msg_queue_spinlock);
 struct vchiq_state g_state;
 
-static struct platform_device *bcm2835_camera;
-static struct platform_device *bcm2835_audio;
-
 struct vchiq_drvdata {
 	const unsigned int cache_line_size;
 	struct rpi_firmware *fw;
@@ -1763,7 +1760,7 @@ static const struct of_device_id vchiq_of_match[] = {
 };
 MODULE_DEVICE_TABLE(of, vchiq_of_match);
 
-static struct platform_device *
+static void
 vchiq_register_child(struct platform_device *pdev, const char *name)
 {
 	struct platform_device *child;
@@ -1773,10 +1770,18 @@ vchiq_register_child(struct platform_device *pdev, const char *name)
 	if (IS_ERR(child)) {
 		dev_warn(&pdev->dev, "%s not registered\n", name);
 		platform_device_put(child);
-		child = NULL;
 	}
+}
 
-	return child;
+static int
+vchiq_unregister_child(struct device *dev, void *data)
+{
+	struct platform_device *pdev;
+
+	pdev = to_platform_device(dev);
+	platform_device_unregister(pdev);
+
+	return 0;
 }
 
 static int vchiq_probe(struct platform_device *pdev)
@@ -1784,6 +1789,10 @@ static int vchiq_probe(struct platform_device *pdev)
 	struct device_node *fw_node;
 	const struct of_device_id *of_id;
 	struct vchiq_drvdata *drvdata;
+	const char *const vchiq_devices[] = {
+		"bcm2835_audio",
+		"bcm2835-camera",
+	};
 	int err;
 
 	of_id = of_match_node(vchiq_of_match, pdev->dev.of_node);
@@ -1826,8 +1835,8 @@ static int vchiq_probe(struct platform_device *pdev)
 		goto error_exit;
 	}
 
-	bcm2835_camera = vchiq_register_child(pdev, "bcm2835-camera");
-	bcm2835_audio = vchiq_register_child(pdev, "bcm2835_audio");
+	for (unsigned int i = 0; i < ARRAY_SIZE(vchiq_devices); i++)
+		vchiq_register_child(pdev, vchiq_devices[i]);
 
 	return 0;
 
@@ -1839,8 +1848,7 @@ static int vchiq_probe(struct platform_device *pdev)
 
 static int vchiq_remove(struct platform_device *pdev)
 {
-	platform_device_unregister(bcm2835_audio);
-	platform_device_unregister(bcm2835_camera);
+	device_for_each_child(&pdev->dev, NULL, vchiq_unregister_child);
 	vchiq_debugfs_deinit();
 	vchiq_deregister_chrdev();
 
-- 
2.38.1

