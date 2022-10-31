Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6DCBD613266
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Oct 2022 10:19:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230115AbiJaJTJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Oct 2022 05:19:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49660 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230085AbiJaJTC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Oct 2022 05:19:02 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id AE3F8BE3F
        for <linux-kernel@vger.kernel.org>; Mon, 31 Oct 2022 02:18:59 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id B60CC1FB;
        Mon, 31 Oct 2022 02:19:05 -0700 (PDT)
Received: from pierre123.arm.com (unknown [10.57.7.107])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id C5BF23F703;
        Mon, 31 Oct 2022 02:18:57 -0700 (PDT)
From:   Pierre Gondois <pierre.gondois@arm.com>
To:     linux-kernel@vger.kernel.org
Cc:     pierre.gondois@arm.com, Rob.Herring@arm.com,
        Matthias Brugger <matthias.bgg@gmail.com>,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org
Subject: [PATCH 00/20] Update cache properties for arm64 DTS
Date:   Mon, 31 Oct 2022 10:18:48 +0100
Message-Id: <20221031091848.530938-1-pierre.gondois@arm.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Align arm64 DTS to the DeviceTree specification v0.3 regarding
cache properties. The patch-set mainly adds 'cache-level' or
'cache' compatibility properties.
For one qcom DTS, level 1 cache nodes are removed as they should
be in the cpu nodes.

On another node, it seems that the 'cache-unified' is under-used.
cache-unified:
  If present, specifies the cache has a unified or-
  ganization. If not present, specifies that the
  cache has a Harvard architecture with separate
  caches for instructions and data.
Only a few l2 cache nodes have this property, and in the absence
of [|d|i]-cache-size properties (or other), the cache is assumed to be
split.

The l2 cache of the Rockchip RK3308 platform is thus assumed to be
split:
l2: l2-cache {
	compatible = "cache";
	cache-level = <2>;
};
when the platform datasheet advertises a unified cache.

No modification/check was made to correct that due to the lack of
cache information for most platforms.

Pierre Gondois (20):
  arm64: dts: Update cache properties for amd
  arm64: dts: Update cache properties for amlogic
  arm64: dts: Update cache properties for apm
  arm64: dts: Update cache properties for arm
  arm64: dts: Update cache properties for broadcom
  arm64: dts: Update cache properties for exynos
  arm64: dts: Update cache properties for freescale
  arm64: dts: Update cache properties for hisilicon
  arm64: dts: Update cache properties for lg
  arm64: dts: Update cache properties for marvell
  arm64: dts: Update cache properties for mediatek
  arm64: dts: Update cache properties for microchip
  arm64: dts: Update cache properties for nuvoton
  arm64: dts: Update cache properties for nvidia
  arm64: dts: Update cache properties for qcom
  arm64: dts: Update cache properties for realtek
  arm64: dts: Update cache properties for renesas
  arm64: dts: Update cache properties for rockchip
  arm64: dts: Update cache properties for synaptics
  arm64: dts: Update cache properties for tesla

 arch/arm64/boot/dts/amd/amd-seattle-cpus.dtsi |  9 +++
 arch/arm64/boot/dts/amlogic/meson-a1.dtsi     |  1 +
 arch/arm64/boot/dts/amlogic/meson-axg.dtsi    |  1 +
 arch/arm64/boot/dts/amlogic/meson-g12a.dtsi   |  1 +
 arch/arm64/boot/dts/amlogic/meson-g12b.dtsi   |  1 +
 arch/arm64/boot/dts/amlogic/meson-gx.dtsi     |  1 +
 arch/arm64/boot/dts/amlogic/meson-sm1.dtsi    |  1 +
 arch/arm64/boot/dts/apm/apm-shadowcat.dtsi    |  4 ++
 arch/arm64/boot/dts/apm/apm-storm.dtsi        |  4 ++
 arch/arm64/boot/dts/arm/foundation-v8.dtsi    |  1 +
 arch/arm64/boot/dts/arm/rtsm_ve-aemv8a.dts    |  1 +
 .../boot/dts/arm/vexpress-v2f-1xv7-ca53x2.dts |  1 +
 .../boot/dts/broadcom/bcm4908/bcm4908.dtsi    |  1 +
 .../boot/dts/broadcom/bcmbca/bcm4912.dtsi     |  1 +
 .../boot/dts/broadcom/bcmbca/bcm63146.dtsi    |  1 +
 .../boot/dts/broadcom/bcmbca/bcm63158.dtsi    |  1 +
 .../boot/dts/broadcom/bcmbca/bcm6813.dtsi     |  1 +
 .../boot/dts/broadcom/bcmbca/bcm6856.dtsi     |  1 +
 .../boot/dts/broadcom/bcmbca/bcm6858.dtsi     |  1 +
 .../boot/dts/broadcom/northstar2/ns2.dtsi     |  1 +
 .../boot/dts/broadcom/stingray/stingray.dtsi  |  4 ++
 arch/arm64/boot/dts/exynos/exynos5433.dtsi    |  2 +
 arch/arm64/boot/dts/exynos/exynos7.dtsi       |  1 +
 .../arm64/boot/dts/freescale/fsl-ls1028a.dtsi |  1 +
 .../arm64/boot/dts/freescale/fsl-ls1043a.dtsi |  1 +
 .../arm64/boot/dts/freescale/fsl-ls1046a.dtsi |  1 +
 .../arm64/boot/dts/freescale/fsl-ls2080a.dtsi |  4 ++
 .../arm64/boot/dts/freescale/fsl-ls2088a.dtsi |  4 ++
 arch/arm64/boot/dts/freescale/imx8ulp.dtsi    |  1 +
 arch/arm64/boot/dts/freescale/s32g2.dtsi      |  2 +
 arch/arm64/boot/dts/freescale/s32v234.dtsi    |  2 +
 arch/arm64/boot/dts/hisilicon/hi3660.dtsi     |  2 +
 arch/arm64/boot/dts/hisilicon/hi6220.dtsi     |  2 +
 arch/arm64/boot/dts/hisilicon/hip05.dtsi      |  4 ++
 arch/arm64/boot/dts/hisilicon/hip06.dtsi      |  4 ++
 arch/arm64/boot/dts/hisilicon/hip07.dtsi      | 16 ++++++
 arch/arm64/boot/dts/lg/lg1312.dtsi            |  1 +
 arch/arm64/boot/dts/lg/lg1313.dtsi            |  1 +
 arch/arm64/boot/dts/marvell/ac5-98dx25xx.dtsi |  1 +
 .../boot/dts/marvell/armada-ap806-dual.dtsi   |  1 +
 .../boot/dts/marvell/armada-ap806-quad.dtsi   |  2 +
 .../boot/dts/marvell/armada-ap807-quad.dtsi   |  2 +
 arch/arm64/boot/dts/mediatek/mt8192.dtsi      |  3 +
 arch/arm64/boot/dts/mediatek/mt8195.dtsi      |  3 +
 arch/arm64/boot/dts/microchip/sparx5.dtsi     |  1 +
 .../boot/dts/nuvoton/nuvoton-npcm845.dtsi     |  1 +
 arch/arm64/boot/dts/nvidia/tegra194.dtsi      | 10 ++++
 arch/arm64/boot/dts/nvidia/tegra210.dtsi      |  1 +
 arch/arm64/boot/dts/nvidia/tegra234.dtsi      | 30 ++++++++++
 arch/arm64/boot/dts/qcom/msm8953.dtsi         | 56 -------------------
 arch/arm64/boot/dts/qcom/sc7180.dtsi          |  9 +++
 arch/arm64/boot/dts/qcom/sc7280.dtsi          |  9 +++
 arch/arm64/boot/dts/qcom/sc8280xp.dtsi        |  9 +++
 arch/arm64/boot/dts/qcom/sdm845.dtsi          |  9 +++
 arch/arm64/boot/dts/qcom/sm6125.dtsi          |  2 +
 arch/arm64/boot/dts/qcom/sm6350.dtsi          |  9 +++
 arch/arm64/boot/dts/qcom/sm8150.dtsi          |  9 +++
 arch/arm64/boot/dts/qcom/sm8250.dtsi          |  9 +++
 arch/arm64/boot/dts/qcom/sm8350.dtsi          |  9 +++
 arch/arm64/boot/dts/qcom/sm8450.dtsi          |  9 +++
 arch/arm64/boot/dts/realtek/rtd1293.dtsi      |  1 +
 arch/arm64/boot/dts/realtek/rtd1295.dtsi      |  1 +
 arch/arm64/boot/dts/realtek/rtd1296.dtsi      |  1 +
 arch/arm64/boot/dts/realtek/rtd1395.dtsi      |  1 +
 arch/arm64/boot/dts/realtek/rtd16xx.dtsi      |  2 +
 arch/arm64/boot/dts/renesas/r9a07g043.dtsi    |  1 +
 arch/arm64/boot/dts/renesas/r9a07g044.dtsi    |  1 +
 arch/arm64/boot/dts/renesas/r9a07g054.dtsi    |  1 +
 arch/arm64/boot/dts/rockchip/rk3308.dtsi      |  1 +
 arch/arm64/boot/dts/rockchip/rk3328.dtsi      |  1 +
 arch/arm64/boot/dts/synaptics/berlin4ct.dtsi  |  1 +
 arch/arm64/boot/dts/tesla/fsd.dtsi            |  1 +
 72 files changed, 238 insertions(+), 56 deletions(-)

-- 
2.25.1

