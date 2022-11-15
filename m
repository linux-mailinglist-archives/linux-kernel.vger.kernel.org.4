Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D683F62955D
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Nov 2022 11:11:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238266AbiKOKLi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Nov 2022 05:11:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60390 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238182AbiKOKLg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Nov 2022 05:11:36 -0500
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF741F0B;
        Tue, 15 Nov 2022 02:11:34 -0800 (PST)
Received: from IcarusMOD.eternityproject.eu (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 2E6E266023A6;
        Tue, 15 Nov 2022 10:11:32 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1668507093;
        bh=kZb3JWtliFai/b1ZuQh7QxCIbxt8MwDeQ3HbQ09qJuE=;
        h=From:To:Cc:Subject:Date:From;
        b=U0GScTKQsbrxt3MWYMhL54sVhSRfyw38v9sRjI2VyQ4ET0WN36mQkKEwK1L0HB452
         fRR2bNX6T6NwQf/4RGa8Wy1FEh5km1KIP4suzEt8ducXJsDDIwgk7cKKn48jqYzPlw
         eZ0DaQc8OcggEK6DmQIb1UNbaR9u+JZZnMoYgwgJyT8QUfWhHOK0pXAljpbGBgsKXv
         1pS7FDxTJ2rUsKToB9dKPfBfGNrttPnB5Y/on/fCosmsYwdw7jTiPLlwQkVXhNW860
         CrMMA/VkIV1UAWxv8wiVGU39rFbeS2s668Wuzc4EukrJ3mi/YPvPhRCmJQOAPtDtge
         FOUpCVK+J0oUw==
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
Subject: [PATCH v3 0/6] Add support for Qualcomm's legacy IOMMU v2
Date:   Tue, 15 Nov 2022 11:11:16 +0100
Message-Id: <20221115101122.155440-1-angelogioacchino.delregno@collabora.com>
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
  dt-bindings: iommu: qcom,iommu: Document qcom,ctx-num property
  iommu/qcom: Use the asid read from device-tree if specified
  iommu/qcom: Properly reset the IOMMU context
  iommu/qcom: Index contexts by asid number to allow asid 0
  dt-bindings: iommu: qcom,iommu: Document QSMMUv2 and MSM8976
    compatibles
  iommu/qcom: Add support for QSMMUv2 and QSMMU-500 secured contexts

 .../devicetree/bindings/iommu/qcom,iommu.txt  |  9 +++
 drivers/iommu/arm/arm-smmu/qcom_iommu.c       | 78 +++++++++++++++----
 2 files changed, 70 insertions(+), 17 deletions(-)

-- 
2.38.1

