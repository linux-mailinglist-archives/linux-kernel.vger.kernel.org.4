Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 83303625BF7
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Nov 2022 14:59:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234169AbiKKN7M (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Nov 2022 08:59:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59392 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234087AbiKKN6j (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Nov 2022 08:58:39 -0500
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CCC7671F17;
        Fri, 11 Nov 2022 05:55:38 -0800 (PST)
Received: from IcarusMOD.eternityproject.eu (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 8716D6602A52;
        Fri, 11 Nov 2022 13:55:36 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1668174937;
        bh=LijwJ0RmVh6sVYM4cnacY5afmNKiiWA/4pJEZ0mBzwQ=;
        h=From:To:Cc:Subject:Date:From;
        b=f/magWOmTbhaJ7yOcrdCB4vpTY14fooCQ/4z27+btrWXNyNHwv/aWjxw0S1FNLy1G
         TPIVRfjBbBofRrxZlxOM4P+GCBwAh+fcILKUptzUytv4k6pEDCTras99c8eVlT3GLS
         slUQtbuSPcaRSDGxNAZwRq60CyP7uDMbOF5FOXvobRkeoWVz8CSSsRcYsoIG9PLh5A
         13M6VbGJnS0ie8xytrni0gT21WP++DhhXisPz3Dzc7S8x6G8kqAUzEObJX7w4uGMc4
         nDYRUiozqlVMkIppqUih4kjxmQoF3kK7msnvjR6Oe4dHF7I3XIVZENr2RN1y+BroWQ
         4PT6RqnGH3OIQ==
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
Subject: [PATCH 0/7] Add support for Qualcomm's legacy IOMMU v2
Date:   Fri, 11 Nov 2022 14:55:18 +0100
Message-Id: <20221111135525.204134-1-angelogioacchino.delregno@collabora.com>
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

AngeloGioacchino Del Regno (7):
  dt-bindings: iommu: qcom,iommu: Document qcom,ctx-num property
  iommu/qcom: Use the asid read from device-tree if specified
  iommu/qcom: Properly reset the IOMMU context
  iommu/qcom: Index contexts by asid number to allow asid 0
  dt-bindings: iommu: qcom,iommu: Document QSMMU v2 compatibles
  iommu/qcom: Add support for QSMMUv2 and QSMMU-500 secured contexts
  dt-bindings: iommu: qcom,iommu: Document MSM8976 compatible

 .../devicetree/bindings/iommu/qcom,iommu.txt  | 11 ++-
 drivers/iommu/arm/arm-smmu/qcom_iommu.c       | 77 +++++++++++++++----
 2 files changed, 69 insertions(+), 19 deletions(-)

-- 
2.38.1

