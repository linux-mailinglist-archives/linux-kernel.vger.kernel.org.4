Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 50BED632F5E
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Nov 2022 22:51:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232118AbiKUVvU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Nov 2022 16:51:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39684 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231896AbiKUVu3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Nov 2022 16:50:29 -0500
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [213.167.242.64])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F569E0753;
        Mon, 21 Nov 2022 13:50:24 -0800 (PST)
Received: from umang.jainideasonboard.com (unknown [103.86.18.138])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id 86E2774C;
        Mon, 21 Nov 2022 22:50:18 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1669067422;
        bh=ab/M/OIelsZJVM+cOrB1iuAvkOA5/zw0fpy5r81fmTE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ONnGRiFazzcorUmfvsOxWLnHizKIjiis8UEo/8G7e5n0+w+65WQjdKzR6yvUifnkK
         BGHYlId7R51m216htZxItp5XlDdK3dkMMUaZc3GhvsBa6DCo2PqmlTN5/ivh9Y64ha
         7LjXIZwAiSj2yjCUl+JZQYnmw9VVyhP/wSI/LPuw=
From:   Umang Jain <umang.jain@ideasonboard.com>
To:     linux-media@vger.kernel.org, kernel-list@raspberrypi.com,
        linux-kernel@vger.kernel.org, linux-rpi-kernel@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org,
        linux-staging@lists.linux.dev,
        Broadcom internal kernel review list 
        <bcm-kernel-feedback-list@broadcom.com>
Cc:     Dave Stevenson <dave.stevenson@raspberrypi.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Naushir Patuck <naush@raspberrypi.com>,
        David Plowman <david.plowman@raspberrypi.com>,
        Kieran Bingham <kieran.bingham@ideasonboard.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Umang Jain <umang.jain@ideasonboard.com>
Subject: [PATCH 14/14] staging: vc04_services: vchiq: Load bcm2835_isp driver from vchiq
Date:   Tue, 22 Nov 2022 03:17:22 +0530
Message-Id: <20221121214722.22563-15-umang.jain@ideasonboard.com>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <20221121214722.22563-1-umang.jain@ideasonboard.com>
References: <20221121214722.22563-1-umang.jain@ideasonboard.com>
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

From: Naushir Patuck <naush@raspberrypi.com>

bcmn2835_isp is a platform driver dependent on vchiq,
therefore add the load/unload functions for it to vchiq.

Signed-off-by: Naushir Patuck <naush@raspberrypi.com>
Signed-off-by: Umang Jain <umang.jain@ideasonboard.com>
---
 drivers/staging/vc04_services/interface/vchiq_arm/vchiq_arm.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_arm.c b/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_arm.c
index 642fdbc0d654..2d070f80a170 100644
--- a/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_arm.c
+++ b/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_arm.c
@@ -67,6 +67,7 @@ struct vchiq_state g_state;
 
 static struct platform_device *bcm2835_camera;
 static struct platform_device *bcm2835_audio;
+static struct platform_device *bcm2835_isp;
 static struct platform_device *vcsm_cma;
 
 struct vchiq_drvdata {
@@ -1836,6 +1837,7 @@ static int vchiq_probe(struct platform_device *pdev)
 	vcsm_cma = vchiq_register_child(pdev, "vcsm-cma");
 	bcm2835_camera = vchiq_register_child(pdev, "bcm2835-camera");
 	bcm2835_audio = vchiq_register_child(pdev, "bcm2835_audio");
+	bcm2835_isp = vchiq_register_child(pdev, "bcm2835-isp");
 
 	return 0;
 
@@ -1847,6 +1849,7 @@ static int vchiq_probe(struct platform_device *pdev)
 
 static int vchiq_remove(struct platform_device *pdev)
 {
+	platform_device_unregister(bcm2835_isp);
 	platform_device_unregister(bcm2835_audio);
 	platform_device_unregister(bcm2835_camera);
 	platform_device_unregister(vcsm_cma);
-- 
2.37.3

