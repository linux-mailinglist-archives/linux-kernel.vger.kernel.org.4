Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DE3726E9ED4
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Apr 2023 00:31:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232418AbjDTWb1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Apr 2023 18:31:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49522 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231994AbjDTWbZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Apr 2023 18:31:25 -0400
Received: from mail-lj1-x22a.google.com (mail-lj1-x22a.google.com [IPv6:2a00:1450:4864:20::22a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4CCD030F7
        for <linux-kernel@vger.kernel.org>; Thu, 20 Apr 2023 15:31:23 -0700 (PDT)
Received: by mail-lj1-x22a.google.com with SMTP id 38308e7fff4ca-2a8ba23a2abso9170001fa.2
        for <linux-kernel@vger.kernel.org>; Thu, 20 Apr 2023 15:31:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1682029881; x=1684621881;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=iMnuWFGrM/PJwZOBdpXu7uMemkHRjRrJAO+mKqn+Jmk=;
        b=aQsMXg/NOus9+GeChd10f8ubKVxsiA78PImgqubhQEHY5WoCIbJu4YybU8rMVoSuld
         uy6BpwEjlBXe/EP6hWAOmUFcLsbq5W1icBVy9URUpeXff8kscJrMtnZiKt+Ajf5IdIFJ
         vrRDdKhokID2wOPcpfWBkWd/LRpOW1f/ToPU/5A/isgSkUyUdhl152A2D1aI3KMyv1cj
         DrsjbhjpflFGNoH+DKn1HqtZIgr/Kj7oV68qQA18810aCMr5F5gvXlVUuIrQvIw9NUCT
         Tvglrbhi/EtIJ5qDidlI2tZhQIFozwjBpjB4S/c7FBx3iPRjGbBCVs4WtnHoi44/sKU/
         rtGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682029881; x=1684621881;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=iMnuWFGrM/PJwZOBdpXu7uMemkHRjRrJAO+mKqn+Jmk=;
        b=CSMtPd2awJ+8M7Z/LppimqHgR4Li1wGQD9WHUJNSwZIqEOJ8NEKtD2Ik+QbsHc/bXF
         fYya3Ysf5kKLIAJrTv/pTAwTuHH7tCV1KDdDmKtzX1S5Pv5xis7DunUZoR2yvLBDzU34
         Bg9suO+5FyqF6GMS+XYzf3tHcMRVPAeGz9aRwldHx+JFDaJKY0J6QYLN6b7rWL7ihjkx
         J/Mse0nmtwklOiwMiTgJ0IMSBeiur1e7Zv1V+G9OO80iiKfwiZsQmZED0sZ9z+SjnAOs
         jZ5THZ5eYyDnfcxbpFTHhz2Ra0ysmOCp7dZ+BdGf+N+qvi3RV5Q16e6BDiUlCf0KwAtn
         9B9g==
X-Gm-Message-State: AAQBX9fLbUifA+VQaRDXHP9E5nTw79Ed+/gzBPa3cKIGOlLljclwmVQO
        hNSEn+YTP8YDNbbrH4gSYFX/kw==
X-Google-Smtp-Source: AKy350ZchB20U9dl/pPfuLW+KcxMRjqr9dfU+8ds5x9ciZBLjLgvH9CvctlFQjn361GPRBpjNUyrnw==
X-Received: by 2002:ac2:46f9:0:b0:4eb:40d4:e0d2 with SMTP id q25-20020ac246f9000000b004eb40d4e0d2mr917031lfo.38.1682029881593;
        Thu, 20 Apr 2023 15:31:21 -0700 (PDT)
Received: from [192.168.1.101] (abyj144.neoplus.adsl.tpnet.pl. [83.9.29.144])
        by smtp.gmail.com with ESMTPSA id w8-20020ac25d48000000b004eedb66983csm324256lfd.273.2023.04.20.15.31.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Apr 2023 15:31:21 -0700 (PDT)
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
Subject: [PATCH v2 00/13] SM63(50|75) DPU support
Date:   Fri, 21 Apr 2023 00:31:09 +0200
Message-Id: <20230411-topic-straitlagoon_mdss-v2-0-5def73f50980@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAC69QWQC/4WNWwqDMBAAryL5boquD0q/eo8iJcZVF9JEdtPQI
 t69qRfo5wwMsylBJhR1LTbFmEgo+AxwKpRdjJ9R05hZQQl12VSVjmElqyWyoejMHIJ/PEcRfZn
 qxho7tgidyvVgBPXAxtsl9/7lXJYr40TvY3fvMy8kMfDnuCf42f+jBLrUdTfZKu86gPbmyBsO5
 8Cz6vd9/wKUXfip1AAAAA==
To:     Rob Clark <robdclark@gmail.com>,
        Abhinav Kumar <quic_abhinavk@quicinc.com>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Sean Paul <sean@poorly.run>, David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Krishna Manikandan <quic_mkrishn@quicinc.com>,
        Will Deacon <will@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Joerg Roedel <joro@8bytes.org>
Cc:     Marijn Suijten <marijn.suijten@somainline.org>,
        linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
        freedreno@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        iommu@lists.linux.dev, Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>
X-Mailer: b4 0.12.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1682029879; l=2429;
 i=konrad.dybcio@linaro.org; s=20230215; h=from:subject:message-id;
 bh=adALUm2UDCuq+jHiF5r/gGrJmlODjVUWz+k4+ab309g=;
 b=/nzsoNRh05ssUpKUu6os3JNQO8PfbruXwKRIX2V2kNWnyhJDQ0rvJRZ62p8t4kMlbM/yaNOLOWjg
 xCPJJiuWAxaRmTiAW3QO8qBjR0fRzd5jjjsP6RDamuXawInqU///
X-Developer-Key: i=konrad.dybcio@linaro.org; a=ed25519;
 pk=iclgkYvtl2w05SSXO5EjjSYlhFKsJ+5OSZBjOkQuEms=
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

v1 -> v2:
- Rebase on the DPU catalog rework and INTF_TE
- Fix QSEED(3L/4) discrepancies
- Fixed DMA/cursor discrepancies for 6350
- No deduplication, that's gonna be handled in catalogrework 2:
  "the return of the catalogrework"
- Split MDSS & DPU binding additions
- Drop "Allow variable SSPP/INTF_BLK size", that got in w/ the rework
- Split MDSS and DPU additions
- Pick up Rob's acks

Depends on (and based on): https://lore.kernel.org/linux-arm-msm/20230411-dpu-intf-te-v2-0-ef76c877eb97@somainline.org/T/#t

v1: https://lore.kernel.org/linux-arm-msm/20230211122656.1479141-1-konrad.dybcio@linaro.org/

Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
---
Konrad Dybcio (13):
      dt-bindings: display/msm: dsi-controller-main: Add SM6350
      dt-bindings: display/msm: dsi-controller-main: Add SM6375
      dt-bindings: display/msm: Add SM6350 DPU
      dt-bindings: display/msm: Add SM6350 MDSS
      dt-bindings: display/msm: Add SM6375 DPU
      dt-bindings: display/msm: Add SM6375 MDSS
      drm/msm/dpu: Add SM6350 support
      drm/msm: mdss: Add SM6350 support
      drm/msm/dpu: Add SM6375 support
      drm/msm: mdss: Add SM6375 support
      iommu/arm-smmu-qcom: Add SM6375 DPU compatible
      iommu/arm-smmu-qcom: Add SM6350 DPU compatible
      iommu/arm-smmu-qcom: Sort the compatible list alphabetically

 .../bindings/display/msm/dsi-controller-main.yaml  |   4 +
 .../bindings/display/msm/qcom,sm6350-dpu.yaml      |  94 +++++++++
 .../bindings/display/msm/qcom,sm6350-mdss.yaml     | 214 ++++++++++++++++++++
 .../bindings/display/msm/qcom,sm6375-dpu.yaml      | 106 ++++++++++
 .../bindings/display/msm/qcom,sm6375-mdss.yaml     | 216 +++++++++++++++++++++
 .../gpu/drm/msm/disp/dpu1/catalog/dpu_6_4_sm6350.h | 186 ++++++++++++++++++
 .../gpu/drm/msm/disp/dpu1/catalog/dpu_6_9_sm6375.h | 152 +++++++++++++++
 drivers/gpu/drm/msm/disp/dpu1/dpu_hw_catalog.c     |  15 ++
 drivers/gpu/drm/msm/disp/dpu1/dpu_hw_catalog.h     |   4 +
 drivers/gpu/drm/msm/disp/dpu1/dpu_kms.c            |   2 +
 drivers/gpu/drm/msm/msm_mdss.c                     |  19 ++
 drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c         |   6 +-
 12 files changed, 1016 insertions(+), 2 deletions(-)
---
base-commit: eaf6956f6dfdbba2c53a668248f8213b9e01bc51
change-id: 20230411-topic-straitlagoon_mdss-8f34cacd5e26

Best regards,
-- 
Konrad Dybcio <konrad.dybcio@linaro.org>

