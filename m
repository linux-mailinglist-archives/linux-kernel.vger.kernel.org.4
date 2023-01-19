Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 46CFC673793
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Jan 2023 12:56:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229982AbjASL4m (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Jan 2023 06:56:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60090 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231191AbjASL4G (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Jan 2023 06:56:06 -0500
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [IPv6:2001:4b98:dc2:55:216:3eff:fef7:d647])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C761C7571A;
        Thu, 19 Jan 2023 03:55:56 -0800 (PST)
Received: from ideasonboard.com (unknown [IPv6:2401:4900:1c80:b229:a6c1:a673:925f:1ed6])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id 070E6904;
        Thu, 19 Jan 2023 12:55:48 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1674129355;
        bh=uZuQczGfDRTm2FbFGCRtYHZ2H2t2F5DLf4cTVA+nP50=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=sLxOQqAFe4hmnbCtr83R9gj8QPuIhN9OTi8dOXV7cQc1Ni+AooAN/NOcUVWFltQaL
         NUQgUS8zOakQardnSw45Uxy7c1oHImS4q5aKjYZRhSg8Xzo0415LsPeHOB5mnmR2ml
         IIEUn/Ttfq4MDpqgPQzbt5JgIOw2+QVgUwwLa4CU=
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
Subject: [PATCH v5 5/6] staging: vc04_services: interface: Drop include Makefile directive
Date:   Thu, 19 Jan 2023 17:25:02 +0530
Message-Id: <20230119115503.268693-6-umang.jain@ideasonboard.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20230119115503.268693-1-umang.jain@ideasonboard.com>
References: <20230119115503.268693-1-umang.jain@ideasonboard.com>
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

Drop the include directive they can break the build one only wants to
build a subdirectory. Replace with "../" for the includes, in the
interface/ files instead.

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
2.38.1

