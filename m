Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C9C73736869
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Jun 2023 11:53:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232583AbjFTJxv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Jun 2023 05:53:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60792 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232520AbjFTJxQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Jun 2023 05:53:16 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 32C9A2112;
        Tue, 20 Jun 2023 02:51:33 -0700 (PDT)
Received: from IcarusMOD.eternityproject.eu (unknown [IPv6:2001:b07:2ed:14ed:c5f8:7372:f042:90a2])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 004026602242;
        Tue, 20 Jun 2023 10:51:30 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1687254691;
        bh=uwyXNF91v6sGa/spbsQK7wgAPR7kXwSg3iM/Za/E/Xk=;
        h=From:To:Cc:Subject:Date:From;
        b=BPG4e43Bc1WYfvc9ppgzIf3ZLFkS/kDzOrzHj1Bb+188214CDobn964KQShkW99jc
         gw+qld4zJq4vDmwoM0ett2hIaLJtNR752pRFX8amyiwdp5vdfcnitygfeHhxguPmkg
         sQ/pGm1BZNWMqb/MhkGo82mfhsQutaZE9HzQjTtkd3nVuuesxQWWfNZGF92ibeupnp
         hhyT91I6tubjw9X2/113WaghEqrhKaDumwaDgTuShtsAj/9UP9i/C9HdBG0rbmkEdh
         Q2LKk+j5VxWWHKQU4+zLIS7TKW079pox5c0Cu+CIk5TZ+hCSQGgG52C2qZeTWgx4oY
         f6lHArq+I2p+Q==
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
To:     agross@kernel.org
Cc:     andersson@kernel.org, konrad.dybcio@linaro.org,
        dmitry.baryshkov@linaro.org, joro@8bytes.org, will@kernel.org,
        robin.murphy@arm.com, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        robdclark@gmail.com, linux-arm-msm@vger.kernel.org,
        iommu@lists.linux.dev, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>, kernel@collabora.com
Subject: [PATCH v4 0/6] Add support for Qualcomm's legacy IOMMU v2
Date:   Tue, 20 Jun 2023 11:51:21 +0200
Message-Id: <20230620095127.96600-1-angelogioacchino.delregno@collabora.com>
X-Mailer: git-send-email 2.40.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
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

Changes in v4:
 - Rebase over next-20230619
 - Rewrite qcom,iommu.txt changes to qcom,iommu.yaml
 - Changed reset writes to only disable CB through CB_SCTLR
   and reset CB_FSR and CB_FAR
 - Addressed misc reviewer's comments

Changes in v3:
 - Removed useless FSRRESTORE reset and definition as pointed
   out in Robin Murphy's review
 - Fixed qcom,iommu.txt changes: squashed MSM8976 compatible
   string addition with msm-iommu-v2 generics addition

Changes in v2:
 - Added back Marijn's notes (sorry man!)
 - Added ARM_SMMU_CB_FSRRESTORE definition
 - Changed context bank reset to properly set FSR and FSRRESTORE

AngeloGioacchino Del Regno (6):
  dt-bindings: iommu: qcom,iommu: Add qcom,ctx-num property
  iommu/qcom: Use the asid read from device-tree if specified
  iommu/qcom: Disable and reset context bank before programming
  iommu/qcom: Index contexts by asid number to allow asid 0
  dt-bindings: iommu: qcom,iommu: Add QSMMUv2 and MSM8976 compatibles
  iommu/qcom: Add support for QSMMUv2 and QSMMU-500 secured contexts

 .../devicetree/bindings/iommu/qcom,iommu.yaml | 22 +++++--
 drivers/iommu/arm/arm-smmu/qcom_iommu.c       | 62 ++++++++++++++-----
 2 files changed, 64 insertions(+), 20 deletions(-)

-- 
2.40.1

