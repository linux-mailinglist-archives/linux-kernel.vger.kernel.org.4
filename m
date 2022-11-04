Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 16893619E67
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Nov 2022 18:22:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231417AbiKDRWB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Nov 2022 13:22:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34404 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230035AbiKDRV7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Nov 2022 13:21:59 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA1CFAE5A;
        Fri,  4 Nov 2022 10:21:58 -0700 (PDT)
Received: from IcarusMOD.eternityproject.eu (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 0C36B6602989;
        Fri,  4 Nov 2022 17:21:55 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1667582516;
        bh=R/MBlJBNY8EYBt6oZqjxP8TEcbb7lnlRlY2DZ7434zU=;
        h=From:To:Cc:Subject:Date:From;
        b=Ku0bwUVtf5oKlMLP0ahGkM/AFF1NVvTK4xSv08D6bDpoArwk7fNUVX4up8i7p+YS6
         WYrOAkqaccZpd+oaLAiY6Ar/q++RvqReKQX4DoxIjAmVuVNG4GjKc1P9nsptV/qTry
         fO/9xoBfP6Fe2KUuOnbg0KciaFngjlPyxceVz0aygW5fdg0kTOe207ImIimWwaj+8I
         c/JLmjU7DXdI1qr+B8jWvJ7lVkPiq+U3fNvcRPvcf3wQ03oottMi2qAEsC+bClQ0EW
         inX+4W/B9XPKzo6kWvJgQBTRMCKkOHDjQ557fzpi6e/7KlREFMyxoq6MVsZM7R5LBv
         wiLqQNjOVMKAg==
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
To:     agross@kernel.org
Cc:     andersson@kernel.org, konrad.dybcio@somainline.org,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        lee@kernel.org, ulf.hansson@linaro.org,
        srinivas.kandagatla@linaro.org, jic23@kernel.org, lars@metafoo.de,
        keescook@chromium.org, tony.luck@intel.com, gpiccoli@igalia.com,
        bhupesh.sharma@linaro.org, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mmc@vger.kernel.org, linux-iio@vger.kernel.org,
        linux-hardening@vger.kernel.org, marijn.suijten@somainline.org,
        kernel@collabora.com, luca@z3ntu.xyz, a39.skl@gmail.com,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
Subject: [PATCH 0/9] MSM8956/76 and Sony Xperia X / X Compact support
Date:   Fri,  4 Nov 2022 18:21:13 +0100
Message-Id: <20221104172122.252761-1-angelogioacchino.delregno@collabora.com>
X-Mailer: git-send-email 2.37.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series adds basic support for MSM8976 and its lower spec variant
MSM8956, along with two devices: the Sony Xperia X and X Compact.

For now, even though I do have a tree in which these two devices are
fully booting, only a basic console boot is provided as the rest is
awaiting cleanup and some more dependencies.
Especially every device requiring IOMMU support, like MDSS, MDP and
Adreno GPU cannot work with the current qcom_iommu driver, as it
needs some code to get the ASIDs right for MSM8956/76.

This series depends on [1].

Tested on both Xperia X and X Compact.

[1]: https://patchwork.kernel.org/project/linux-arm-msm/list/?series=690889

AngeloGioacchino Del Regno (7):
  dt-bindings: iio: qcom-spmi-vadc: Add definitions for USB DP/DM VADCs
  dt-bindings: soc: qcom: qcom,smd-rpm: Use qcom,smd-channels on MSM8976
  dt-bindings: mmc: sdhci-msm: Document compatible for MSM8976
  dt-bindings: mfd: qcom,tcsr: Add compatible for MSM8976
  arm64: dts: qcom: Add configuration for PM8950 peripheral
  arm64: dts: qcom: Add DTS for MSM8976 and MSM8956 SoCs
  arm64: dts: qcom: Add support for SONY Xperia X/X Compact

Marijn Suijten (2):
  dt-bindings: nvmem: Add compatible for MSM8976
  dt-bindings: arm: qcom: Document msm8956 and msm8976 SoC and devices

 .../devicetree/bindings/arm/qcom.yaml         |   10 +
 .../devicetree/bindings/mfd/qcom,tcsr.yaml    |    1 +
 .../devicetree/bindings/mmc/sdhci-msm.yaml    |    1 +
 .../bindings/nvmem/qcom,qfprom.yaml           |    1 +
 .../bindings/soc/qcom/qcom,smd-rpm.yaml       |    1 +
 arch/arm64/boot/dts/qcom/Makefile             |    2 +
 .../qcom/msm8956-sony-xperia-loire-kugo.dts   |   36 +
 .../qcom/msm8956-sony-xperia-loire-suzu.dts   |   17 +
 .../dts/qcom/msm8956-sony-xperia-loire.dtsi   |  269 ++++
 arch/arm64/boot/dts/qcom/msm8956.dtsi         |   18 +
 arch/arm64/boot/dts/qcom/msm8976.dtsi         | 1208 +++++++++++++++++
 arch/arm64/boot/dts/qcom/pm8950.dtsi          |  165 +++
 include/dt-bindings/iio/qcom,spmi-vadc.h      |    3 +
 13 files changed, 1732 insertions(+)
 create mode 100644 arch/arm64/boot/dts/qcom/msm8956-sony-xperia-loire-kugo.dts
 create mode 100644 arch/arm64/boot/dts/qcom/msm8956-sony-xperia-loire-suzu.dts
 create mode 100644 arch/arm64/boot/dts/qcom/msm8956-sony-xperia-loire.dtsi
 create mode 100644 arch/arm64/boot/dts/qcom/msm8956.dtsi
 create mode 100644 arch/arm64/boot/dts/qcom/msm8976.dtsi
 create mode 100644 arch/arm64/boot/dts/qcom/pm8950.dtsi

-- 
2.37.2

