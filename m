Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ECDDD6233EA
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Nov 2022 20:50:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231879AbiKITuY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Nov 2022 14:50:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48422 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231863AbiKITuW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Nov 2022 14:50:22 -0500
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 799AF643F
        for <linux-kernel@vger.kernel.org>; Wed,  9 Nov 2022 11:50:21 -0800 (PST)
Received: from notapiano.myfiosgateway.com (zone.collabora.co.uk [167.235.23.81])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: nfraprado)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 561616601615;
        Wed,  9 Nov 2022 19:50:16 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1668023419;
        bh=Am2BB1j8T2ilLUNl75Tl9cl3+vw221TjiqNaMkrQsQY=;
        h=From:To:Cc:Subject:Date:From;
        b=jzN0JHKBBpzF2JNU3AkqAN9n8Hib9ajBfdzfecKJ25B9nUAKSOBPaasCE6vjTl97N
         uN1e/jFXl/uBe7W8c82VxOdm0ApC+994P08LjT7P/m+ZJIfZNgWrB7++PxLOfqsIu0
         059fxI9gA0rSHq1lcrIwCPxI01iCCxDQjWP73GBkNasvS4WPAbpRYzy1IbPUMhtoEh
         9rpWOP8+DWz61mA7k7CDc7xbh2uHOqJgUtQviVWkVjeLvA/rpFAuTZOPyH9h+6sdB/
         Uk0rNZRPQUYIwqu3BNb6LWeh/DoeInm83r05y51IkM3M3ck6QAgIVy/+2rxiSptcXF
         G1ddugxzCzgYA==
From:   =?UTF-8?q?N=C3=ADcolas=20F=2E=20R=2E=20A=2E=20Prado?= 
        <nfraprado@collabora.com>
To:     Matthias Brugger <matthias.bgg@gmail.com>
Cc:     kernel@collabora.com,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        =?UTF-8?q?N=C3=ADcolas=20F=2E=20R=2E=20A=2E=20Prado?= 
        <nfraprado@collabora.com>, Arnd Bergmann <arnd@arndb.de>,
        Bjorn Andersson <andersson@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Marcel Ziswiler <marcel.ziswiler@toradex.com>,
        Mark Brown <broonie@kernel.org>,
        Shawn Guo <shawnguo@kernel.org>, Vinod Koul <vkoul@kernel.org>,
        Will Deacon <will@kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2] arm64: defconfig: Enable missing configs for mt8183-jacuzzi-juniper
Date:   Wed,  9 Nov 2022 14:50:12 -0500
Message-Id: <20221109195012.1231059-1-nfraprado@collabora.com>
X-Mailer: git-send-email 2.38.1
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
on the mt8183-kukui-jacuzzi-juniper machine.

The devices enabled are: ATH10K SDIO wireless adapter, Elan touchscreen,
cr50 TPM, MediaTek SPI controller, JPEG video decoder, ANX7625 DSI/DPI
to DP bridge (used for the internal display), MT8183 sound cards, SCP
co-processor, MediaTek Global Command Engine (controlled by CMDQ
driver), MediaTek Smart Voltage Scaling (SVS) engine, CCI frequency
and voltage scaling, AUXADC thermal sensors.

All symbols are enabled as modules with the exception of SPI, which is
enabled as builtin since on some platforms like mt8195-cherry, the
ChromeOS Embedded Controller is connected through SPI and it is
responsible for the regulators powering the MMC controller used for the
SD card, and thus SPI support is required for booting.

By enabling the support for all of this machine's devices on the
defconfig we make it effortless to test the relevant hardware both by
developers as well as CI systems like KernelCI.

Signed-off-by: Nícolas F. R. A. Prado <nfraprado@collabora.com>

---
Related KernelCI links:
[1] https://github.com/kernelci/kernelci-core/pull/1352
[2] https://github.com/kernelci/bootrr/pull/22

v1: https://lore.kernel.org/all/20221108232228.1177199-1-nfraprado@collabora.com

Changes in v2:
- Squashed all commits into a single one

 arch/arm64/configs/defconfig | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/arch/arm64/configs/defconfig b/arch/arm64/configs/defconfig
index 226bb30ea7e2..14ce97d78662 100644
--- a/arch/arm64/configs/defconfig
+++ b/arch/arm64/configs/defconfig
@@ -392,6 +392,7 @@ CONFIG_USB_NET_PLUSB=m
 CONFIG_USB_NET_MCS7830=m
 CONFIG_ATH10K=m
 CONFIG_ATH10K_PCI=m
+CONFIG_ATH10K_SDIO=m
 CONFIG_ATH10K_SNOC=m
 CONFIG_WCN36XX=m
 CONFIG_ATH11K=m
@@ -412,6 +413,7 @@ CONFIG_KEYBOARD_CROS_EC=y
 CONFIG_INPUT_TOUCHSCREEN=y
 CONFIG_TOUCHSCREEN_ATMEL_MXT=m
 CONFIG_TOUCHSCREEN_GOODIX=m
+CONFIG_TOUCHSCREEN_ELAN=m
 CONFIG_TOUCHSCREEN_EDT_FT5X06=m
 CONFIG_INPUT_MISC=y
 CONFIG_INPUT_PM8941_PWRKEY=y
@@ -462,6 +464,10 @@ CONFIG_IPMI_HANDLER=m
 CONFIG_IPMI_DEVICE_INTERFACE=m
 CONFIG_IPMI_SI=m
 CONFIG_TCG_TPM=y
+CONFIG_TCG_TIS=m
+CONFIG_TCG_TIS_SPI=m
+CONFIG_TCG_TIS_SPI_CR50=y
+CONFIG_TCG_TIS_I2C_CR50=m
 CONFIG_TCG_TIS_I2C_INFINEON=y
 CONFIG_I2C_CHARDEV=y
 CONFIG_I2C_MUX=y
@@ -505,6 +511,7 @@ CONFIG_SPI_IMX=m
 CONFIG_SPI_FSL_DSPI=y
 CONFIG_SPI_MESON_SPICC=m
 CONFIG_SPI_MESON_SPIFC=m
+CONFIG_SPI_MT65XX=y
 CONFIG_SPI_ORION=y
 CONFIG_SPI_PL022=y
 CONFIG_SPI_ROCKCHIP=y
@@ -617,6 +624,7 @@ CONFIG_BRCMSTB_THERMAL=m
 CONFIG_EXYNOS_THERMAL=y
 CONFIG_TEGRA_SOCTHERM=m
 CONFIG_TEGRA_BPMP_THERMAL=m
+CONFIG_GENERIC_ADC_THERMAL=m
 CONFIG_QCOM_TSENS=y
 CONFIG_QCOM_SPMI_ADC_TM5=m
 CONFIG_QCOM_SPMI_TEMP_ALARM=m
@@ -701,6 +709,7 @@ CONFIG_USB_VIDEO_CLASS=m
 CONFIG_V4L_PLATFORM_DRIVERS=y
 CONFIG_SDR_PLATFORM_DRIVERS=y
 CONFIG_V4L_MEM2MEM_DRIVERS=y
+CONFIG_VIDEO_MEDIATEK_JPEG=m
 CONFIG_VIDEO_QCOM_CAMSS=m
 CONFIG_VIDEO_QCOM_VENUS=m
 CONFIG_VIDEO_RCAR_ISP=m
@@ -763,6 +772,7 @@ CONFIG_DRM_SII902X=m
 CONFIG_DRM_SIMPLE_BRIDGE=m
 CONFIG_DRM_THINE_THC63LVD1024=m
 CONFIG_DRM_TI_SN65DSI86=m
+CONFIG_DRM_ANALOGIX_ANX7625=m
 CONFIG_DRM_I2C_ADV7511=m
 CONFIG_DRM_I2C_ADV7511_AUDIO=y
 CONFIG_DRM_CDNS_MHDP8546=m
@@ -805,6 +815,9 @@ CONFIG_SND_SOC_IMX_SGTL5000=m
 CONFIG_SND_SOC_IMX_SPDIF=m
 CONFIG_SND_SOC_FSL_ASOC_CARD=m
 CONFIG_SND_SOC_IMX_AUDMIX=m
+CONFIG_SND_SOC_MT8183=m
+CONFIG_SND_SOC_MT8183_MT6358_TS3A227E_MAX98357A=m
+CONFIG_SND_SOC_MT8183_DA7219_MAX98357A=m
 CONFIG_SND_MESON_AXG_SOUND_CARD=m
 CONFIG_SND_MESON_GX_SOUND_CARD=m
 CONFIG_SND_SOC_QCOM=m
@@ -1113,6 +1126,7 @@ CONFIG_ARM_SMMU_V3=y
 CONFIG_MTK_IOMMU=y
 CONFIG_QCOM_IOMMU=y
 CONFIG_REMOTEPROC=y
+CONFIG_MTK_SCP=m
 CONFIG_QCOM_Q6V5_ADSP=m
 CONFIG_QCOM_Q6V5_MSS=m
 CONFIG_QCOM_Q6V5_PAS=m
@@ -1130,8 +1144,10 @@ CONFIG_RASPBERRYPI_POWER=y
 CONFIG_FSL_DPAA=y
 CONFIG_FSL_MC_DPIO=y
 CONFIG_FSL_RCPM=y
+CONFIG_MTK_CMDQ=m
 CONFIG_MTK_DEVAPC=m
 CONFIG_MTK_PMIC_WRAP=y
+CONFIG_MTK_SVS=m
 CONFIG_QCOM_AOSS_QMP=y
 CONFIG_QCOM_COMMAND_DB=y
 CONFIG_QCOM_CPR=y
@@ -1182,6 +1198,7 @@ CONFIG_ARCH_TEGRA_234_SOC=y
 CONFIG_TI_SCI_PM_DOMAINS=y
 CONFIG_ARM_IMX_BUS_DEVFREQ=m
 CONFIG_ARM_IMX8M_DDRC_DEVFREQ=m
+CONFIG_ARM_MEDIATEK_CCI_DEVFREQ=m
 CONFIG_EXTCON_PTN5150=m
 CONFIG_EXTCON_USB_GPIO=y
 CONFIG_EXTCON_USBC_CROS_EC=y
@@ -1189,6 +1206,7 @@ CONFIG_RENESAS_RPCIF=m
 CONFIG_IIO=y
 CONFIG_EXYNOS_ADC=y
 CONFIG_MAX9611=m
+CONFIG_MEDIATEK_MT6577_AUXADC=m
 CONFIG_QCOM_SPMI_VADC=m
 CONFIG_QCOM_SPMI_ADC5=m
 CONFIG_ROCKCHIP_SARADC=m
-- 
2.38.1

