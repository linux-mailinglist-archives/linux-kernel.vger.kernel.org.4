Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CD3A0638634
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Nov 2022 10:28:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229922AbiKYJ2t (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Nov 2022 04:28:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45260 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229871AbiKYJ22 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Nov 2022 04:28:28 -0500
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB53A222BB;
        Fri, 25 Nov 2022 01:28:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1669368504; x=1700904504;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=Wzwmhe1tAJXVDVxgspmjOf4RzyKkfCj4R+nMlHGJos8=;
  b=dcMxsgzS+J1wjQfB1wt4NC632r/WZPuOF4+DsiVMZIms1Mnz5hVezLuf
   SgJUS96g0oWxgD9wUvutFR+jaoPo08g+lQ/+uqvpe93odydm23blLZ8Fq
   ucHGe8xpH7HfLv1q0b027OrP2FByQQFYLg98fNK6Qurkawum3Yo9W1ls6
   1+HMwi2qDr4P77aTAbaEJmlTjtbCQj/dGg0/obQJmAZah/ZDOH4VDnhQu
   amuIRD74kzpCj0MX9rD6vtTpaupDq/GXol8ojBdJD3FQio3YUShYGI1md
   9PsRwUHTIWAWjbrZfC3Q/9K3l8MXqXm87JKiLgVcAvVkefyJRTGx0O69B
   A==;
X-IronPort-AV: E=Sophos;i="5.96,193,1665471600"; 
   d="scan'208";a="190492699"
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa5.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 25 Nov 2022 02:28:23 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.12; Fri, 25 Nov 2022 02:28:22 -0700
Received: from ROB-ULT-M18282.microchip.com (10.10.115.15) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server id
 15.1.2507.12 via Frontend Transport; Fri, 25 Nov 2022 02:28:21 -0700
From:   Eugen Hristev <eugen.hristev@microchip.com>
To:     <claudiu.beznea@microchip.com>
CC:     <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <linux-media@vger.kernel.org>,
        Eugen Hristev <eugen.hristev@microchip.com>
Subject: [PATCH] ARM: configs: switch to new MICROCHIP_ISC driver
Date:   Fri, 25 Nov 2022 11:28:12 +0200
Message-ID: <20221125092812.446379-1-eugen.hristev@microchip.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The ATMEL_ISC and ATMEL_XISC have been deprecated and moved to staging.
Use the new MICROCHIP_ISC/MICROCHIP_XISC symbols which are the
replacement drivers.

Signed-off-by: Eugen Hristev <eugen.hristev@microchip.com>
---

Hi,

This should go in 6.2, after the media subsystem new features will be merged.
The tree here :
https://git.linuxtv.org/media_stage.git/
... contains the patches that are destined for 6.2 and perform the
move of the ISC drivers to staging:

https://git.linuxtv.org/media_stage.git/commit/?id=55927c98a2c88019e23353a87f44032107ca2854

Hence this patch has to go in the same kernel version to allow the current
defconfigs that use the ISC to switch to the new driver.
(The old driver won't be selected anymore since it depends on
MEDIA_DEPRECATED , so that symbol has to be selected first to select the
old driver which is now in staging )

Thanks

 arch/arm/configs/multi_v7_defconfig | 6 +++---
 arch/arm/configs/sama5_defconfig    | 2 +-
 arch/arm/configs/sama7_defconfig    | 2 +-
 3 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/arch/arm/configs/multi_v7_defconfig b/arch/arm/configs/multi_v7_defconfig
index b61b2e3d116b..d1686bc40e5d 100644
--- a/arch/arm/configs/multi_v7_defconfig
+++ b/arch/arm/configs/multi_v7_defconfig
@@ -663,11 +663,11 @@ CONFIG_USB_VIDEO_CLASS=m
 CONFIG_V4L_PLATFORM_DRIVERS=y
 CONFIG_V4L_MEM2MEM_DRIVERS=y
 CONFIG_VIDEO_ASPEED=m
-CONFIG_VIDEO_ATMEL_ISC=m
-CONFIG_VIDEO_ATMEL_XISC=m
 CONFIG_VIDEO_ATMEL_ISI=m
-CONFIG_VIDEO_MICROCHIP_CSI2DC=m
 CONFIG_VIDEO_MMP_CAMERA=m
+CONFIG_VIDEO_MICROCHIP_ISC=m
+CONFIG_VIDEO_MICROCHIP_XISC=m
+CONFIG_VIDEO_MICROCHIP_CSI2DC=m
 CONFIG_VIDEO_TEGRA_VDE=m
 CONFIG_VIDEO_RENESAS_CEU=m
 CONFIG_VIDEO_RCAR_VIN=m
diff --git a/arch/arm/configs/sama5_defconfig b/arch/arm/configs/sama5_defconfig
index 877bbe7b777e..f89fd4e0d10a 100644
--- a/arch/arm/configs/sama5_defconfig
+++ b/arch/arm/configs/sama5_defconfig
@@ -150,8 +150,8 @@ CONFIG_MEDIA_PLATFORM_SUPPORT=y
 CONFIG_MEDIA_USB_SUPPORT=y
 CONFIG_USB_VIDEO_CLASS=m
 CONFIG_V4L_PLATFORM_DRIVERS=y
-CONFIG_VIDEO_ATMEL_ISC=y
 CONFIG_VIDEO_ATMEL_ISI=y
+CONFIG_VIDEO_MICROCHIP_ISC=y
 CONFIG_VIDEO_MT9V032=m
 CONFIG_VIDEO_OV2640=m
 CONFIG_VIDEO_OV5640=m
diff --git a/arch/arm/configs/sama7_defconfig b/arch/arm/configs/sama7_defconfig
index 8f28c9d443f0..cc42cea77f38 100644
--- a/arch/arm/configs/sama7_defconfig
+++ b/arch/arm/configs/sama7_defconfig
@@ -140,7 +140,7 @@ CONFIG_MEDIA_SUPPORT_FILTER=y
 CONFIG_MEDIA_CAMERA_SUPPORT=y
 CONFIG_MEDIA_PLATFORM_SUPPORT=y
 CONFIG_V4L_PLATFORM_DRIVERS=y
-CONFIG_VIDEO_ATMEL_XISC=y
+CONFIG_VIDEO_MICROCHIP_XISC=y
 CONFIG_VIDEO_MICROCHIP_CSI2DC=y
 CONFIG_VIDEO_IMX219=m
 CONFIG_VIDEO_IMX274=m
-- 
2.25.1

