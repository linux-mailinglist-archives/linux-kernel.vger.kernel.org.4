Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 749F96546AA
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Dec 2022 20:33:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235737AbiLVTdd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Dec 2022 14:33:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56976 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235543AbiLVTd0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Dec 2022 14:33:26 -0500
Received: from relay02.th.seeweb.it (relay02.th.seeweb.it [IPv6:2001:4b7a:2000:18::163])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 421AE17A80;
        Thu, 22 Dec 2022 11:33:25 -0800 (PST)
Received: from localhost.localdomain (94-209-172-39.cable.dynamic.v4.ziggo.nl [94.209.172.39])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by m-r1.th.seeweb.it (Postfix) with ESMTPSA id 1D62220169;
        Thu, 22 Dec 2022 20:33:23 +0100 (CET)
From:   Marijn Suijten <marijn.suijten@somainline.org>
To:     phone-devel@vger.kernel.org, Will Deacon <will@kernel.org>,
        Joerg Roedel <joro@8bytes.org>,
        Bjorn Andersson <andersson@kernel.org>
Cc:     ~postmarketos/upstreaming@lists.sr.ht,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@somainline.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Martin Botka <martin.botka@somainline.org>,
        Jami Kettunen <jami.kettunen@somainline.org>,
        Marijn Suijten <marijn.suijten@somainline.org>,
        Lux Aliaga <they@mint.lgbt>,
        Robin Murphy <robin.murphy@arm.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Thierry Reding <treding@nvidia.com>,
        Melody Olvera <quic_molvera@quicinc.com>,
        Bhupesh Sharma <bhupesh.sharma@linaro.org>,
        Douglas Anderson <dianders@chromium.org>,
        linux-arm-kernel@lists.infradead.org, iommu@lists.linux.dev,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org
Subject: [PATCH v5 0/4] arm64: dts: qcom: sm6125: Enable APPS SMMU
Date:   Thu, 22 Dec 2022 20:32:50 +0100
Message-Id: <20221222193254.126925-1-marijn.suijten@somainline.org>
X-Mailer: git-send-email 2.39.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add APPS SMMU to SM6125 dtsi and use it in SDHCI/USB nodes.

Changes since v4:

- Use hexadecimal 0x0 for iommu mask;
- Add sm6125 to the dt-bindings list without clocks, now depending on:
  https://lore.kernel.org/linux-arm-kernel/20221222092355.74586-1-krzysztof.kozlowski@linaro.org/

v4: https://lore.kernel.org/linux-arm-msm/20221216215819.1164973-1-marijn.suijten@somainline.org/T/#u


Changes since v3:

- Drop driver patch in favour of using generic qcom,smmu-500 compatible;
- Add patches that use apps_smmu in USB and SDHCI nodes, reconfiguring
  their streamID which otherwise gets lost (from the bootloader) as soon
  as SMMU probes, breaking their functionality;
- Rebased on next-20221216 to solve dt-bindings conflict.

v3: https://lore.kernel.org/linux-iommu/20210612094606.89576-2-martin.botka@somainline.org/T/#u

AngeloGioacchino Del Regno (1):
  arm64: dts: qcom: sm6125: Add IOMMU context to DWC3

Marijn Suijten (1):
  arm64: dts: qcom: sm6125: Add apps_smmu with streamID to SDHCI 1/2
    nodes

Martin Botka (2):
  dt-bindings: arm-smmu: Document smmu-500 binding for SM6125
  arm64: dts: qcom: sm6125: Configure APPS SMMU

 .../devicetree/bindings/iommu/arm,smmu.yaml   |  2 +
 arch/arm64/boot/dts/qcom/sm6125.dtsi          | 76 +++++++++++++++++++
 2 files changed, 78 insertions(+)

--
2.39.0

