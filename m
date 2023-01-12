Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 728D16678F4
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Jan 2023 16:21:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239635AbjALPVX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Jan 2023 10:21:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38238 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240246AbjALPU5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Jan 2023 10:20:57 -0500
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C74B650F43
        for <linux-kernel@vger.kernel.org>; Thu, 12 Jan 2023 07:13:11 -0800 (PST)
Received: from notapiano.myfiosgateway.com (unknown [IPv6:2600:4041:5b1a:cd00:524d:e95d:1a9c:492a])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: nfraprado)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 5C6236602D8E;
        Thu, 12 Jan 2023 15:13:08 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1673536390;
        bh=3I7GRdum8hBzhIgYNw9/pBTx5mC+mLGjCGvmsD9CzGk=;
        h=From:To:Cc:Subject:Date:From;
        b=emjg/aGsZzqAQRpou+KCDlAHohWHqowgj8ixxWdMLpNu5wlSM40cktTMQ22sB8Rke
         E3DmAP0ZtS7MgKJolw/NSnYvfe/6CWjTc2aNzXYznuAMcQJ1Ux+MR6gj813Ls9TnYe
         mp+T4mXwswh/9izn/rla131cknJHyJfuK25p8NTulskgZVwThZ8d22Lr4WMWjj5FL9
         swTrntRDv45kY39tie3VtfEr7qUqDpewNESZRnbznUMJ6GsV/fjBNZOO6Yrz60U6DT
         32N2xWPUvc4f/1H1Ig+VD4hlRtm+hQIk9euABPCrF9tjPKtqdqGNcVm0fmSn4ne1Nc
         XwFrc0SeRPeiA==
From:   =?UTF-8?q?N=C3=ADcolas=20F=2E=20R=2E=20A=2E=20Prado?= 
        <nfraprado@collabora.com>
To:     Matthias Brugger <matthias.bgg@gmail.com>
Cc:     kernel@collabora.com,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        =?UTF-8?q?N=C3=ADcolas=20F=2E=20R=2E=20A=2E=20Prado?= 
        <nfraprado@collabora.com>, Arnd Bergmann <arnd@arndb.de>,
        Bjorn Andersson <quic_bjorande@quicinc.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Marcel Ziswiler <marcel.ziswiler@toradex.com>,
        Shawn Guo <shawnguo@kernel.org>, Will Deacon <will@kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH] arm64: defconfig: Enable missing configs for mt8192-asurada
Date:   Thu, 12 Jan 2023 10:12:38 -0500
Message-Id: <20230112151238.1930126-1-nfraprado@collabora.com>
X-Mailer: git-send-email 2.39.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        UPPERCASE_50_75 autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Enable missing configs in the arm64 defconfig to get all devices probing
on mt8192-asurada based machines.

The devices enabled are: MediaTek Bluetooth USB controller, MediaTek
PCIe Gen3 MAC controller, MT7921E wireless adapter, Elan I2C Trackpad,
MediaTek SPI NOR flash controller, Mediatek SPMI Controller, ChromeOS EC
regulators, MT6315 PMIC, MediaTek Video Codec, MT8192 sound cards,
ChromeOS EC rpmsg communication, all MT8192 clocks.

Support for DMA Restricted Pool is also enabled since it is used by the
WiFi card on this platform.

REGULATOR_CROS_EC is enabled as builtin since it powers the MMC
controller for the SD card, making it required for booting on some
setups.

By enabling the support for all of this platform's devices on the
defconfig we make it effortless to test the relevant hardware both by
developers as well as CI systems like KernelCI.

Signed-off-by: Nícolas F. R. A. Prado <nfraprado@collabora.com>

---

 arch/arm64/configs/defconfig | 25 +++++++++++++++++++++++++
 1 file changed, 25 insertions(+)

diff --git a/arch/arm64/configs/defconfig b/arch/arm64/configs/defconfig
index f3053e7018fe..4e806d8068f6 100644
--- a/arch/arm64/configs/defconfig
+++ b/arch/arm64/configs/defconfig
@@ -196,6 +196,7 @@ CONFIG_BT_HIDP=m
 CONFIG_BT_LEDS=y
 # CONFIG_BT_DEBUGFS is not set
 CONFIG_BT_HCIBTUSB=m
+CONFIG_BT_HCIBTUSB_MTK=y
 CONFIG_BT_HCIUART=m
 CONFIG_BT_HCIUART_LL=y
 CONFIG_BT_HCIUART_BCM=y
@@ -231,6 +232,7 @@ CONFIG_PCIE_ALTERA_MSI=y
 CONFIG_PCI_HOST_THUNDER_PEM=y
 CONFIG_PCI_HOST_THUNDER_ECAM=y
 CONFIG_PCIE_ROCKCHIP_HOST=m
+CONFIG_PCIE_MEDIATEK_GEN3=m
 CONFIG_PCIE_BRCMSTB=m
 CONFIG_PCI_IMX6=y
 CONFIG_PCI_LAYERSCAPE=y
@@ -403,6 +405,7 @@ CONFIG_BRCMFMAC=m
 CONFIG_MWIFIEX=m
 CONFIG_MWIFIEX_SDIO=m
 CONFIG_MWIFIEX_PCIE=m
+CONFIG_MT7921E=m
 CONFIG_WL18XX=m
 CONFIG_WLCORE_SDIO=m
 CONFIG_INPUT_EVDEV=y
@@ -411,6 +414,7 @@ CONFIG_KEYBOARD_GPIO=y
 CONFIG_KEYBOARD_SNVS_PWRKEY=m
 CONFIG_KEYBOARD_IMX_SC_KEY=m
 CONFIG_KEYBOARD_CROS_EC=y
+CONFIG_MOUSE_ELAN_I2C=m
 CONFIG_INPUT_TOUCHSCREEN=y
 CONFIG_TOUCHSCREEN_ATMEL_MXT=m
 CONFIG_TOUCHSCREEN_GOODIX=m
@@ -513,6 +517,7 @@ CONFIG_SPI_FSL_DSPI=y
 CONFIG_SPI_MESON_SPICC=m
 CONFIG_SPI_MESON_SPIFC=m
 CONFIG_SPI_MT65XX=y
+CONFIG_SPI_MTK_NOR=m
 CONFIG_SPI_ORION=y
 CONFIG_SPI_PL022=y
 CONFIG_SPI_ROCKCHIP=y
@@ -528,6 +533,7 @@ CONFIG_SPI_TEGRA210_QUAD=m
 CONFIG_SPI_TEGRA114=m
 CONFIG_SPI_SPIDEV=m
 CONFIG_SPMI=y
+CONFIG_SPMI_MTK_PMIF=m
 CONFIG_PINCTRL_MAX77620=y
 CONFIG_PINCTRL_SINGLE=y
 CONFIG_PINCTRL_OWL=y
@@ -674,6 +680,7 @@ CONFIG_REGULATOR_FIXED_VOLTAGE=y
 CONFIG_REGULATOR_AXP20X=y
 CONFIG_REGULATOR_BD718XX=y
 CONFIG_REGULATOR_BD9571MWV=y
+CONFIG_REGULATOR_CROS_EC=y
 CONFIG_REGULATOR_FAN53555=y
 CONFIG_REGULATOR_GPIO=y
 CONFIG_REGULATOR_HI6421V530=y
@@ -681,6 +688,7 @@ CONFIG_REGULATOR_HI655X=y
 CONFIG_REGULATOR_MAX77620=y
 CONFIG_REGULATOR_MAX8973=y
 CONFIG_REGULATOR_MP8859=y
+CONFIG_REGULATOR_MT6315=m
 CONFIG_REGULATOR_MT6358=y
 CONFIG_REGULATOR_MT6359=y
 CONFIG_REGULATOR_MT6360=y
@@ -714,6 +722,7 @@ CONFIG_V4L_PLATFORM_DRIVERS=y
 CONFIG_SDR_PLATFORM_DRIVERS=y
 CONFIG_V4L_MEM2MEM_DRIVERS=y
 CONFIG_VIDEO_MEDIATEK_JPEG=m
+CONFIG_VIDEO_MEDIATEK_VCODEC=m
 CONFIG_VIDEO_QCOM_CAMSS=m
 CONFIG_VIDEO_QCOM_VENUS=m
 CONFIG_VIDEO_RCAR_ISP=m
@@ -827,6 +836,8 @@ CONFIG_SND_SOC_IMX_AUDMIX=m
 CONFIG_SND_SOC_MT8183=m
 CONFIG_SND_SOC_MT8183_MT6358_TS3A227E_MAX98357A=m
 CONFIG_SND_SOC_MT8183_DA7219_MAX98357A=m
+CONFIG_SND_SOC_MT8192=m
+CONFIG_SND_SOC_MT8192_MT6359_RT1015_RT5682=m
 CONFIG_SND_MESON_AXG_SOUND_CARD=m
 CONFIG_SND_MESON_GX_SOUND_CARD=m
 CONFIG_SND_SOC_QCOM=m
@@ -1070,6 +1081,7 @@ CONFIG_VIDEO_MAX96712=m
 CONFIG_CHROME_PLATFORMS=y
 CONFIG_CROS_EC=y
 CONFIG_CROS_EC_I2C=y
+CONFIG_CROS_EC_RPMSG=m
 CONFIG_CROS_EC_SPI=y
 CONFIG_CROS_EC_CHARDEV=m
 CONFIG_COMMON_CLK_RK808=y
@@ -1092,6 +1104,18 @@ CONFIG_CLK_IMX8QXP=y
 CONFIG_CLK_IMX8ULP=y
 CONFIG_CLK_IMX93=y
 CONFIG_TI_SCI_CLK=y
+CONFIG_COMMON_CLK_MT8192_AUDSYS=y
+CONFIG_COMMON_CLK_MT8192_CAMSYS=y
+CONFIG_COMMON_CLK_MT8192_IMGSYS=y
+CONFIG_COMMON_CLK_MT8192_IMP_IIC_WRAP=y
+CONFIG_COMMON_CLK_MT8192_IPESYS=y
+CONFIG_COMMON_CLK_MT8192_MDPSYS=y
+CONFIG_COMMON_CLK_MT8192_MFGCFG=y
+CONFIG_COMMON_CLK_MT8192_MMSYS=y
+CONFIG_COMMON_CLK_MT8192_MSDC=y
+CONFIG_COMMON_CLK_MT8192_SCP_ADSP=y
+CONFIG_COMMON_CLK_MT8192_VDECSYS=y
+CONFIG_COMMON_CLK_MT8192_VENCSYS=y
 CONFIG_COMMON_CLK_QCOM=y
 CONFIG_QCOM_A53PLL=y
 CONFIG_QCOM_CLK_APCS_MSM8916=y
@@ -1398,6 +1422,7 @@ CONFIG_CRYPTO_DEV_HISI_SEC2=m
 CONFIG_CRYPTO_DEV_HISI_ZIP=m
 CONFIG_CRYPTO_DEV_HISI_HPRE=m
 CONFIG_CRYPTO_DEV_HISI_TRNG=m
+CONFIG_DMA_RESTRICTED_POOL=y
 CONFIG_CMA_SIZE_MBYTES=32
 CONFIG_PRINTK_TIME=y
 CONFIG_DEBUG_KERNEL=y
-- 
2.39.0

