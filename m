Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 874C46AD179
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Mar 2023 23:26:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229770AbjCFW0W (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Mar 2023 17:26:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53286 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229516AbjCFW0U (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Mar 2023 17:26:20 -0500
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E3A36E6A4
        for <linux-kernel@vger.kernel.org>; Mon,  6 Mar 2023 14:26:19 -0800 (PST)
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 326MQ4ZC015094;
        Mon, 6 Mar 2023 16:26:04 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1678141564;
        bh=1Tkn3NiXzHBAzRuym2bHG1Hh89FzXxzi48RLvIbu5Cs=;
        h=From:To:CC:Subject:Date;
        b=kuPpyfcbzROuwXsgr4yThL+OvAkqO3IjSJDT6/g9ogi2SVa3Ks0akGAdaoGaRv9Zf
         i/UMcI3bYB0Vxs51o8XhLv6LSewVNTu1UyLMlViIBuae5fuj8SqZScULsny6vbc+5p
         RKbc0YHEZJw5UvrzxgSAbTCa5urNl5ECNrmPD88E=
Received: from DLEE108.ent.ti.com (dlee108.ent.ti.com [157.170.170.38])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 326MQ4VK044758
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 6 Mar 2023 16:26:04 -0600
Received: from DLEE101.ent.ti.com (157.170.170.31) by DLEE108.ent.ti.com
 (157.170.170.38) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.16; Mon, 6
 Mar 2023 16:26:04 -0600
Received: from fllv0040.itg.ti.com (10.64.41.20) by DLEE101.ent.ti.com
 (157.170.170.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.16 via
 Frontend Transport; Mon, 6 Mar 2023 16:26:04 -0600
Received: from ula0226330.dal.design.ti.com (ileaxei01-snat.itg.ti.com [10.180.69.5])
        by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id 326MQ4gg044763;
        Mon, 6 Mar 2023 16:26:04 -0600
From:   Andrew Davis <afd@ti.com>
To:     Russell King <linux@armlinux.org.uk>, Arnd Bergmann <arnd@arndb.de>
CC:     <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, Andrew Davis <afd@ti.com>
Subject: [PATCH] ARM: multi_v7_defconfig: Enable OMAP audio/display support
Date:   Mon, 6 Mar 2023 16:26:04 -0600
Message-ID: <20230306222604.14574-1-afd@ti.com>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We would like to support some additional OMAP class devices using the
common multi_v7_defconfig. To start, enable some audio/display related
modules:

DRM_OMAP/OMAP5_DSS_HDMI: For base DRM display support.
DRM_TI_TFP410: Used as a display bridge for several EVM's panels.
DRM_TI_TPD12S015: HDMI encoder on several OMAP/Sitara EVMs.
SND_SOC_TLV320AIC3X_I2C: For I2C attached TLV320AIC3x codecs.

Signed-off-by: Andrew Davis <afd@ti.com>
---
 arch/arm/configs/multi_v7_defconfig | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/arch/arm/configs/multi_v7_defconfig b/arch/arm/configs/multi_v7_defconfig
index 084cc612ea23..06f5fb9137ba 100644
--- a/arch/arm/configs/multi_v7_defconfig
+++ b/arch/arm/configs/multi_v7_defconfig
@@ -711,6 +711,8 @@ CONFIG_ROCKCHIP_INNO_HDMI=y
 CONFIG_DRM_ATMEL_HLCDC=m
 CONFIG_DRM_RCAR_DU=m
 CONFIG_DRM_SUN4I=m
+CONFIG_DRM_OMAP=m
+CONFIG_OMAP5_DSS_HDMI=y
 CONFIG_DRM_MSM=m
 CONFIG_DRM_FSL_DCU=m
 CONFIG_DRM_TEGRA=y
@@ -734,6 +736,8 @@ CONFIG_DRM_SII9234=m
 CONFIG_DRM_SIMPLE_BRIDGE=m
 CONFIG_DRM_TOSHIBA_TC358764=m
 CONFIG_DRM_TOSHIBA_TC358768=m
+CONFIG_DRM_TI_TFP410=m
+CONFIG_DRM_TI_TPD12S015=m
 CONFIG_DRM_I2C_ADV7511=m
 CONFIG_DRM_I2C_ADV7511_AUDIO=y
 CONFIG_DRM_STI=m
@@ -822,6 +826,7 @@ CONFIG_SND_SOC_SGTL5000=m
 CONFIG_SND_SOC_STI_SAS=m
 CONFIG_SND_SOC_TLV320AIC32X4=m
 CONFIG_SND_SOC_TLV320AIC32X4_I2C=m
+CONFIG_SND_SOC_TLV320AIC3X_I2C=m
 CONFIG_SND_SOC_WM8960=m
 CONFIG_SND_SOC_WM8962=m
 CONFIG_SND_SOC_WM8978=m
-- 
2.39.2

