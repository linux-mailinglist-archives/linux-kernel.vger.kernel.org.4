Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C2AF3625DB1
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Nov 2022 15:59:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234838AbiKKO7y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Nov 2022 09:59:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59462 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234769AbiKKO7b (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Nov 2022 09:59:31 -0500
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1486F63BAB;
        Fri, 11 Nov 2022 06:59:28 -0800 (PST)
Received: from IcarusMOD.eternityproject.eu (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 8C5256602A42;
        Fri, 11 Nov 2022 14:59:25 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1668178766;
        bh=rIbdrDLpaw733WmSJUzHjZVOC/s/a21X3HVN9JEDUQg=;
        h=From:To:Cc:Subject:Date:From;
        b=gRunAnsOxtpt0SV/yPwoIRgHX+Teq96lqbE8crX33X59OyMg8EikW3XPRJ2dMGDSu
         ZrRpm0DpvU1UzlOlrR++OvIwY1o8Ua8zr7kPNb3Pqkv5pw8qzks9FbtSY5QDVv1+Rk
         Uij8xi3KsyMBEAzbPdgLFzy61Zn7WRtxxDHWUPeuORw/nbwFe0pAgDB0A4yIlHdd0q
         TPniwDDzzM2DUpo38hXCf1/otHQ8fa2k3AEc/SImetjXmMoBQmGLD/xDFickBWUBqo
         uPL6j9qzEUJ9zhtsovJl2zDS2+LHzeoBeSSjSDL+QajqWDMIgZ1gAOgd6kAH77jn8o
         QVI8Riga8+IPA==
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
To:     agross@kernel.org
Cc:     andersson@kernel.org, konrad.dybcio@linaro.org, joro@8bytes.org,
        will@kernel.org, robin.murphy@arm.com, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, robdclark@gmail.com,
        linux-arm-msm@vger.kernel.org, iommu@lists.linux.dev,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        marijn.suijten@somainline.org, kernel@collabora.com,
        luca@z3ntu.xyz, a39.skl@gmail.com, phone-devel@vger.kernel.org,
        ~postmarketos/upstreaming@lists.sr.ht,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
Subject: [PATCH v2 0/8] Add support for Qualcomm's legacy IOMMU v2
Date:   Fri, 11 Nov 2022 15:59:11 +0100
Message-Id: <20221111145919.221159-1-angelogioacchino.delregno@collabora.com>
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

This series adds support for handling "v2" firmware's IOMMU, found
on at least MSM8956 and MSM8976 (some other SoCs also need the same
but I honestly don't remember which ones precisely).

This is strictly required to get functional IOMMUs on these SoCs.

I'm sorry for not performing a much needed schema conversion on
qcom,iommu.txt, but I really didn't have time to do that :-(

This series was tested on Sony Xperia X and X Compact (MSM8956):
ADSP, LPASS, Venus, MSS, MDP and GPU are happy :-)

Changes in v2:
 - Added back Marijn's notes (sorry man!)
 - Added ARM_SMMU_CB_FSRRESTORE definition
 - Changed context bank reset to properly set FSR and FSRRESTORE

AngeloGioacchino Del Regno (8):
  dt-bindings: iommu: qcom,iommu: Document qcom,ctx-num property
  iommu/qcom: Use the asid read from device-tree if specified
  iommu/arm-smmu: Add definition for ARM_SMMU_CB_FSRRESTORE
  iommu/qcom: Properly reset the IOMMU context
  iommu/qcom: Index contexts by asid number to allow asid 0
  dt-bindings: iommu: qcom,iommu: Document QSMMU v2 compatibles
  iommu/qcom: Add support for QSMMUv2 and QSMMU-500 secured contexts
  dt-bindings: iommu: qcom,iommu: Document MSM8976 compatible

 .../devicetree/bindings/iommu/qcom,iommu.txt  | 11 ++-
 drivers/iommu/arm/arm-smmu/arm-smmu.h         |  1 +
 drivers/iommu/arm/arm-smmu/qcom_iommu.c       | 78 +++++++++++++++----
 3 files changed, 71 insertions(+), 19 deletions(-)

-- 
2.38.1

