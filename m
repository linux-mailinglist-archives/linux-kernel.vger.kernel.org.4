Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 73550675EBC
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Jan 2023 21:12:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230159AbjATUMD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Jan 2023 15:12:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57046 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230057AbjATUMB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Jan 2023 15:12:01 -0500
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [IPv6:2001:4b98:dc2:55:216:3eff:fef7:d647])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E607AC41D0;
        Fri, 20 Jan 2023 12:11:45 -0800 (PST)
Received: from umang.jainideasonboard.com (unknown [103.251.226.6])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id 310F9104C;
        Fri, 20 Jan 2023 21:11:38 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1674245504;
        bh=foOzqx8i0GwXFtcfRogUR42Bcu3qNaPa5Xq+4eZ5fIE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=WVYCcrYJavyX4YwixmDS7AXxUgXGBClSZQqMX/C0QO2IXVtVsXM9vExqz6yAwIs7c
         rl0//1OQYdbc5k1HreEnw2drUV/atpOw2/FObrDjsAz7n1OJQuYFedetR6elpgFsxJ
         07kKCZ27c0C1qCN9kZzcvJlbg8dZT9u6b/5ALp84=
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
        Dave Stevenson <dave.stevenson@raspberrypi.com>,
        Kieran Bingham <kieran.bingham@ideasonboard.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Paul Elder <paul.elder@ideasonboard.com>,
        Umang Jain <umang.jain@ideasonboard.com>
Subject: [PATCH v6 5/6] staging: vc04_services: interface: Drop include Makefile directive
Date:   Sat, 21 Jan 2023 01:41:03 +0530
Message-Id: <20230120201104.606876-6-umang.jain@ideasonboard.com>
X-Mailer: git-send-email 2.39.0
In-Reply-To: <20230120201104.606876-1-umang.jain@ideasonboard.com>
References: <20230120201104.606876-1-umang.jain@ideasonboard.com>
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

Drop the include directive. They can break the build, when one only
wants to build a subdirectory. Replace with "../" for the includes,
in the interface/ files instead.

Suggested-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Umang Jain <umang.jain@ideasonboard.com>
---
 drivers/staging/vc04_services/Makefile                         | 2 --
 drivers/staging/vc04_services/interface/vchiq_arm/vchiq_core.h | 2 +-
 .../staging/vc04_services/interface/vchiq_arm/vchiq_ioctl.h    | 3 ++-
 3 files changed, 3 insertions(+), 4 deletions(-)

diff --git a/drivers/staging/vc04_services/Makefile b/drivers/staging/vc04_services/Makefile
index 1fd191e2e2a5..44794bdf6173 100644
--- a/drivers/staging/vc04_services/Makefile
+++ b/drivers/staging/vc04_services/Makefile
@@ -15,5 +15,3 @@ obj-$(CONFIG_SND_BCM2835)		+= bcm2835-audio/
 obj-$(CONFIG_VIDEO_BCM2835)		+= bcm2835-camera/
 obj-$(CONFIG_BCM2835_VCHIQ_MMAL)	+= vchiq-mmal/
 
-ccflags-y += -I $(srctree)/$(src)/include
-
diff --git a/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_core.h b/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_core.h
index 3c198eb1c77a..ec1a3caefaea 100644
--- a/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_core.h
+++ b/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_core.h
@@ -10,8 +10,8 @@
 #include <linux/kref.h>
 #include <linux/rcupdate.h>
 #include <linux/wait.h>
-#include <linux/raspberrypi/vchiq.h>
 
+#include "../../include/linux/raspberrypi/vchiq.h"
 #include "vchiq_cfg.h"
 
 /* Do this so that we can test-build the code on non-rpi systems */
diff --git a/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_ioctl.h b/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_ioctl.h
index 96f50beace44..17550831f86c 100644
--- a/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_ioctl.h
+++ b/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_ioctl.h
@@ -5,7 +5,8 @@
 #define VCHIQ_IOCTLS_H
 
 #include <linux/ioctl.h>
-#include <linux/raspberrypi/vchiq.h>
+
+#include "../../include/linux/raspberrypi/vchiq.h"
 
 #define VCHIQ_IOC_MAGIC 0xc4
 #define VCHIQ_INVALID_HANDLE (~0)
-- 
2.39.0

