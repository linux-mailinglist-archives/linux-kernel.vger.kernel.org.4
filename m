Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C05FE6259FD
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Nov 2022 13:02:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233641AbiKKMCK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Nov 2022 07:02:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60450 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233653AbiKKMCG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Nov 2022 07:02:06 -0500
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E6547C8F7;
        Fri, 11 Nov 2022 04:02:04 -0800 (PST)
Received: from IcarusMOD.eternityproject.eu (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id B36476602A58;
        Fri, 11 Nov 2022 12:02:00 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1668168122;
        bh=6sm7RpVkIvUIpbMZQhVAr1igZdcFWx2OWANx/W4c5y8=;
        h=From:To:Cc:Subject:Date:From;
        b=n7HigNHbgCVZCADC6QcYiymCcuHH8bFZLUOXYYb+QLVpYJj/HbLKMTAEs3tNdGuV6
         FLxeFZhQLh2U4+MPwz/+j5BNDCUUlfs+d/Tqpy8/1uUAwJylk8xKiHe9ZnHGafuLcl
         h3lHy9NSlOCWPyhBhS7iI1iuRU45/KF/eAC4Ju34nRXWJaaT5id5Q+vEKyA3JnYcE6
         2rIXWwrh1kGgOFzghfCwXoZhj4DkUaYyjWdeTpvIgjE1Dd5WGYK3TH8VOupbwEFObJ
         Pdog4zszM6x7FUxqde/Ya2QwdwoKR/YLh9IqdHsFO4/H6FJxnWKn4E+HoQpdPWGRpf
         HNjZr/PEZpfgA==
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
To:     agross@kernel.org
Cc:     andersson@kernel.org, konrad.dybcio@linaro.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, jassisinghbrar@gmail.com,
        srinivas.kandagatla@linaro.org, jic23@kernel.org, lars@metafoo.de,
        keescook@chromium.org, tony.luck@intel.com, gpiccoli@igalia.com,
        evgreen@chromium.org, gregkh@linuxfoundation.org,
        a39.skl@gmail.com, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-iio@vger.kernel.org, linux-hardening@vger.kernel.org,
        marijn.suijten@somainline.org, kernel@collabora.com,
        luca@z3ntu.xyz,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
Subject: [PATCH v2 00/11] MSM8956/76 and Sony Xperia X / X Compact support
Date:   Fri, 11 Nov 2022 13:01:45 +0100
Message-Id: <20221111120156.48040-1-angelogioacchino.delregno@collabora.com>
X-Mailer: git-send-email 2.38.1
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


Changes in v2:
 - Removed commits from v1 that were picked already
 - Added MSM8976 to socinfo and qcom,ids
 - Added a commit to fix ordering in qfprom yaml
 - Fix KPSS mailbox documentation to allow syscon on 8976
 - Various fixes from series v1 feedback (thanks!)

AngeloGioacchino Del Regno (9):
  dt-bindings: iio: qcom-spmi-vadc: Add definitions for USB DP/DM VADCs
  dt-bindings: nvmem: Fix qcom,qfprom compatibles enum ordering
  dt-bindings: sram: qcom,imem: Document MSM8976
  dt-bindings: mailbox: qcom: Allow syscon on
    qcom,msm8976-apcs-kpss-global
  dt-bindings: arm: qcom,ids: Add SoC IDs for MSM8956 and MSM8976
  soc: qcom: socinfo: Add MSM8956/76 SoC IDs to the soc_id table
  arm64: dts: qcom: Add configuration for PM8950 peripheral
  arm64: dts: qcom: Add DTS for MSM8976 and MSM8956 SoCs
  arm64: dts: qcom: Add support for SONY Xperia X/X Compact

Marijn Suijten (2):
  dt-bindings: nvmem: Add compatible for MSM8976
  dt-bindings: arm: qcom: Document msm8956 and msm8976 SoC and devices

 .../devicetree/bindings/arm/qcom.yaml         |   10 +
 .../mailbox/qcom,apcs-kpss-global.yaml        |    2 +-
 .../bindings/nvmem/qcom,qfprom.yaml           |    3 +-
 .../devicetree/bindings/sram/qcom,imem.yaml   |    1 +
 arch/arm64/boot/dts/qcom/Makefile             |    2 +
 .../qcom/msm8956-sony-xperia-loire-kugo.dts   |   35 +
 .../qcom/msm8956-sony-xperia-loire-suzu.dts   |   17 +
 .../dts/qcom/msm8956-sony-xperia-loire.dtsi   |  282 ++++
 arch/arm64/boot/dts/qcom/msm8956.dtsi         |   18 +
 arch/arm64/boot/dts/qcom/msm8976.dtsi         | 1198 +++++++++++++++++
 arch/arm64/boot/dts/qcom/pm8950.dtsi          |  165 +++
 drivers/soc/qcom/socinfo.c                    |    2 +
 include/dt-bindings/arm/qcom,ids.h            |    2 +
 include/dt-bindings/iio/qcom,spmi-vadc.h      |    3 +
 14 files changed, 1738 insertions(+), 2 deletions(-)
 create mode 100644 arch/arm64/boot/dts/qcom/msm8956-sony-xperia-loire-kugo.dts
 create mode 100644 arch/arm64/boot/dts/qcom/msm8956-sony-xperia-loire-suzu.dts
 create mode 100644 arch/arm64/boot/dts/qcom/msm8956-sony-xperia-loire.dtsi
 create mode 100644 arch/arm64/boot/dts/qcom/msm8956.dtsi
 create mode 100644 arch/arm64/boot/dts/qcom/msm8976.dtsi
 create mode 100644 arch/arm64/boot/dts/qcom/pm8950.dtsi

-- 
2.38.1

