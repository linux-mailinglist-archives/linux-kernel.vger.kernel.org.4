Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 608E6729B9C
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Jun 2023 15:29:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240822AbjFIN3e (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Jun 2023 09:29:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48462 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240524AbjFIN3a (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Jun 2023 09:29:30 -0400
Received: from mx1.tq-group.com (mx1.tq-group.com [93.104.207.81])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4916530D6;
        Fri,  9 Jun 2023 06:29:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tq-group.com; i=@tq-group.com; q=dns/txt; s=key1;
  t=1686317369; x=1717853369;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Ln5MOgUZB7SbgB086cTfTL+ICqhAXe3k6EqP7XZziOE=;
  b=C/3ASJ+vFhbzVsMTXEGMdOxb8JNm8AKcdz1W8kuXxYHLeV1RW1cqbdL1
   qkA+WnYAkMFmZVfyDiBML1M0x5MdJ/XSiTz5v14jbwg2x6AGkyqYhoC3e
   UPgxiWBvE7QvzoEnxOxvkI5ICxjLZv+wlVaWBl+o4I1T8cF5l5RcUsjlr
   aToCVai6HWToJ6M1g8g9orjiAQuhYghJr2yp75sOfvrrMrebhBH4Kb2kD
   q5EHv7peIcx3bU2lsky9jz+VowumPmhd4JhZVsJbtveclLdrav9ZQPsdq
   eXW83PdBOLq1ORBeLwEE4JPNQs/4KDXE7cnbPv0V5UUMEi2OjO4txjn7/
   w==;
X-IronPort-AV: E=Sophos;i="6.00,229,1681164000"; 
   d="scan'208";a="31366204"
Received: from unknown (HELO tq-pgp-pr1.tq-net.de) ([192.168.6.15])
  by mx1-pgp.tq-group.com with ESMTP; 09 Jun 2023 15:29:22 +0200
Received: from mx1.tq-group.com ([192.168.6.7])
  by tq-pgp-pr1.tq-net.de (PGP Universal service);
  Fri, 09 Jun 2023 15:29:23 +0200
X-PGP-Universal: processed;
        by tq-pgp-pr1.tq-net.de on Fri, 09 Jun 2023 15:29:23 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tq-group.com; i=@tq-group.com; q=dns/txt; s=key1;
  t=1686317363; x=1717853363;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Ln5MOgUZB7SbgB086cTfTL+ICqhAXe3k6EqP7XZziOE=;
  b=ILTMkl6YNCx36luKpIz/KI2LcO1cKQwcp6M2dN3+XVnhIS63N65y+Jde
   44K01Dsp7srhtHMKBXD7Oe+raH/rJkY6HbGsBCWmtwpusINkrxKntlLoO
   5vPZ4gVeJwXFvx4i2MJW8uEHdApqJlb11PsfEJ2H/Z7YmfiBa8pFx1lC2
   Y8WwztRIQodJ6NEnQ4uyVl3WQEKNd3ZvpzoYKvCMQ9ZmIq8gPbpP7w8JK
   k3dAD1jtI2W/Lch5eEht986Wp2VsHNFKW4tV0RSPvJ3UoC/5s1mipeJtd
   D/r2BnpAfMPe47vDB1FHCWAxpxrdzTIHowTP2M82KWGKICNHkZKyVHOS2
   g==;
X-IronPort-AV: E=Sophos;i="6.00,229,1681164000"; 
   d="scan'208";a="31366203"
Received: from vtuxmail01.tq-net.de ([10.115.0.20])
  by mx1.tq-group.com with ESMTP; 09 Jun 2023 15:29:22 +0200
Received: from steina-w.tq-net.de (unknown [10.123.53.21])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by vtuxmail01.tq-net.de (Postfix) with ESMTPSA id A4D16280090;
        Fri,  9 Jun 2023 15:29:22 +0200 (CEST)
From:   Alexander Stein <alexander.stein@ew.tq-group.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>, Marek Vasut <marex@denx.de>
Cc:     Alexander Stein <alexander.stein@ew.tq-group.com>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        NXP Linux Team <linux-imx@nxp.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux@ew.tq-group.com
Subject: [PATCH 3/3] arm64: defconfig: Enable i.MX93 devices
Date:   Fri,  9 Jun 2023 15:29:15 +0200
Message-Id: <20230609132915.634338-4-alexander.stein@ew.tq-group.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230609132915.634338-1-alexander.stein@ew.tq-group.com>
References: <20230609132915.634338-1-alexander.stein@ew.tq-group.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        UPPERCASE_50_75,URIBL_BLOCKED autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

These drivers are used on i.MX93 based devices.

Signed-off-by: Alexander Stein <alexander.stein@ew.tq-group.com>
---
 arch/arm64/configs/defconfig | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/arm64/configs/defconfig b/arch/arm64/configs/defconfig
index 8d850be05835f..0c2ee173a8730 100644
--- a/arch/arm64/configs/defconfig
+++ b/arch/arm64/configs/defconfig
@@ -425,6 +425,7 @@ CONFIG_TOUCHSCREEN_GOODIX=m
 CONFIG_TOUCHSCREEN_ELAN=m
 CONFIG_TOUCHSCREEN_EDT_FT5X06=m
 CONFIG_INPUT_MISC=y
+CONFIG_INPUT_BBNSM_PWRKEY=m
 CONFIG_INPUT_PM8941_PWRKEY=y
 CONFIG_INPUT_PM8XXX_VIBRATOR=m
 CONFIG_INPUT_TPS65219_PWRBUTTON=m
@@ -674,6 +675,7 @@ CONFIG_SUNXI_WATCHDOG=m
 CONFIG_NPCM7XX_WATCHDOG=y
 CONFIG_IMX2_WDT=y
 CONFIG_IMX_SC_WDT=m
+CONFIG_IMX7ULP_WDT=m
 CONFIG_QCOM_WDT=m
 CONFIG_MESON_GXBB_WATCHDOG=m
 CONFIG_MESON_WATCHDOG=m
@@ -1088,6 +1090,7 @@ CONFIG_RTC_DRV_ARMADA38X=y
 CONFIG_RTC_DRV_PM8XXX=m
 CONFIG_RTC_DRV_TEGRA=y
 CONFIG_RTC_DRV_SNVS=m
+CONFIG_RTC_DRV_BBNSM=m
 CONFIG_RTC_DRV_IMX_SC=m
 CONFIG_RTC_DRV_MT6397=m
 CONFIG_RTC_DRV_XGENE=y
@@ -1396,6 +1399,7 @@ CONFIG_ARM_SPE_PMU=m
 CONFIG_ARM_DMC620_PMU=m
 CONFIG_HISI_PMU=y
 CONFIG_NVMEM_IMX_OCOTP=y
+CONFIG_NVMEM_IMX_OCOTP_ELE=m
 CONFIG_NVMEM_IMX_OCOTP_SCU=y
 CONFIG_NVMEM_LAYERSCAPE_SFP=m
 CONFIG_NVMEM_MESON_EFUSE=m
-- 
2.34.1

