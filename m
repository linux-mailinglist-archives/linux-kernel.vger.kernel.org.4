Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DFC5A7242B5
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Jun 2023 14:44:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237691AbjFFMoi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Jun 2023 08:44:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43502 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237681AbjFFMog (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Jun 2023 08:44:36 -0400
Received: from mail-lj1-x234.google.com (mail-lj1-x234.google.com [IPv6:2a00:1450:4864:20::234])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6DAA410FD
        for <linux-kernel@vger.kernel.org>; Tue,  6 Jun 2023 05:44:08 -0700 (PDT)
Received: by mail-lj1-x234.google.com with SMTP id 38308e7fff4ca-2b1c5a6129eso33391021fa.2
        for <linux-kernel@vger.kernel.org>; Tue, 06 Jun 2023 05:44:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1686055446; x=1688647446;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=uDe9yWm7FDRgHENi0EyWVPZ2Kw85wZtNhtSyOm6/4EE=;
        b=mwcfACuJoEZNKneJcZ43Cp79swDuvm7SrEQ6jXsd2EwNJK2STQC9b73iBc4f7UOEx8
         6AAuUoOFyM15y3/pnSI6usxTjFayvA+hRcM60Re+pGCRmLgUK7TVZS4/gHaCceB8tk3b
         WwwEeM/PJ87yx2obApx0WHCGlznns2xINKv64cpJK6Fx87szU8N4ETJh5v2BC65ni34b
         7QldRLRU3IU9q7GRVc/xR8RtDSXqwsVZPFkh91dflzB3/fshm+akjUgo3yBb1FY0iOVx
         il9PORYTYR915tmUt1Oa0UE43EjhKjmuQnCmO50W2pjbzj65HPu/umE7N7oO0mbrnP/5
         rMWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686055446; x=1688647446;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=uDe9yWm7FDRgHENi0EyWVPZ2Kw85wZtNhtSyOm6/4EE=;
        b=eiyEpFuUXv7ejGEoTLldOdkrcOpZ8qPhTjRUOBJXCxTPLDOH4mXsLDwXtOnJbca/Dr
         6aK0XZFUYaGbM2OO2qzsNOkhjBm8vN1J+tC9vootgAxNk48E0+YCn1C5gwxqpu9qFKDV
         M9XUfaZVPqifUJAgRQnL0L+MWhQ4gSBzvLeb8PHmY8H2QnB5RC9w9RYT2XA1jENF4NFQ
         Ax2jnrVd4OLvKhTZzFXfzBFP8f5+nMyXHIoSJ89QFarYJGoHmDL2Ofmz7jstW+zt1WuB
         osERF/3/ZD9sEZR8Lt+b4v49uXvEccWR9w4mfGfk71lB2mwKfQcMp8iyMLA8ZVIhVZU0
         9ttA==
X-Gm-Message-State: AC+VfDyUeBqw4xu4z6njok/vSzGKSAc8LDZ+pZSmV8+coYpZs9yHH/Im
        lzndzs0vKGucuAScYV6q4ujWew==
X-Google-Smtp-Source: ACHHUZ5QqhGUqNb2yD+U/39kOWKg1VeFrzId9zYsCF32Jzz1w04Ocfwl4yLG3gYnKVTtNlEAlYIBHA==
X-Received: by 2002:a2e:b0e1:0:b0:2b0:4c72:98ff with SMTP id h1-20020a2eb0e1000000b002b04c7298ffmr1083056ljl.7.1686055446572;
        Tue, 06 Jun 2023 05:44:06 -0700 (PDT)
Received: from [192.168.1.101] (abyl150.neoplus.adsl.tpnet.pl. [83.9.31.150])
        by smtp.gmail.com with ESMTPSA id u23-20020a2e9f17000000b002a9ebff8431sm1830823ljk.94.2023.06.06.05.44.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Jun 2023 05:44:06 -0700 (PDT)
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
Subject: [PATCH v6 00/12] SM63(50|75) DPU support
Date:   Tue, 06 Jun 2023 14:43:51 +0200
Message-Id: <20230411-topic-straitlagoon_mdss-v6-0-dee6a882571b@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAcqf2QC/42Oy2rDMBREfyVoXRVZb2fV/yihyLpXtsCVguSYl
 uB/r5xVSxb1cgbmnLmTiiViJefTnRRcY405taBfTsRPLo1II7RMOOOCya6jS75GT+tSXFxmN+a
 cPj6hVmqDkN55UMg1aevBVaRDcclPbZ9u89zKa8EQvx6690vLU6xLLt8P+8r39n/RyimjQgffN
 Z3mXL3NMbmSX3MZd/ExgAIMRgTFest+A/ZXqzj4RDRQb4UBPQjVaXgCyYMg2UDaokGuwDDsnkD
 qIEjtj3o7SODBAPwFbdv2A5a1HjDwAQAA
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
        Joerg Roedel <joro@8bytes.org>,
        Conor Dooley <conor+dt@kernel.org>
Cc:     Marijn Suijten <marijn.suijten@somainline.org>,
        linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
        freedreno@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        iommu@lists.linux.dev, Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>
X-Mailer: b4 0.12.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1686055444; l=4174;
 i=konrad.dybcio@linaro.org; s=20230215; h=from:subject:message-id;
 bh=boLoG8rL7D1hV5a4prC+37/bhZnhm3gDXdsQwkKVQg0=;
 b=lD+tWC5iuFDg1MEolqAgo2hDOU8MFlyjiP8TbhVIvPOTFVPjg0zirv0kINyBQLLDsUseJ5bVC
 CZHOHul+7VnBE6n4pk/c2bFQc6dKqINcAMWoAoNTw4fmpVJ6KdsCAjI
X-Developer-Key: i=konrad.dybcio@linaro.org; a=ed25519;
 pk=iclgkYvtl2w05SSXO5EjjSYlhFKsJ+5OSZBjOkQuEms=
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

v5 -> v6:
- Drop unnecessary items: level in bindings
- Use INTF_SC7180_MASK for 6375 to avoid enabling DPU_INTF_DATA_COMPRESS on DPU6
- Pick up tags

v5: https://lore.kernel.org/r/20230411-topic-straitlagoon_mdss-v5-0-998b4d2f7dd1@linaro.org

v4 -> v5:
- Rebase on next-20230522 (drop regdma, drop external dependencies)
- Reuse sdm845_vbif
- Resize non-DSI INTFs to 0x280 (no TE block)
- Fix up 6375 mdss bindings example
- Rewrite reasoning of dropping the QoS LUT entry in
  "drm/msm/dpu: Add SM6350 support"
- pick up tags
- add DSC blocks for both SoCs

No more dependency on INTFTE (merged)

v4: https://lore.kernel.org/r/20230411-topic-straitlagoon_mdss-v4-0-68e7e25d70e1@linaro.org

v3 -> v4:
- Drop adding new QoS LUT entries
- Add safe_lut_tbl for both SoCs

Depends on:
- https://lore.kernel.org/linux-arm-msm/20230411-dpu-intf-te-v4-0-27ce1a5ab5c6@somainline.org/

v3: https://lore.kernel.org/r/20230411-topic-straitlagoon_mdss-v3-0-9837d6b3516d@linaro.org

v2 -> v3:
- Don't duplicate qcm2290_lm_sblk
- Use DEFAULT_DPU_LINE_WIDTH defines
- Fix up sspp clk assignments for sm6350
- Add 6350-6375-common QoS data straight to the common file
  instead of moving it around after adding it
- Fix up iommu compatible order before adding new entries
- Reuse sm6350 msm_mdss_data for sm6375
- INTF_SC7180_MASK -> INTF_SC7280_MASK (enable HCTL) on 6375
- use double tabs in catalog headers
- remove one unused entry in 6350 dpu_qos_lut_entry
- add missing tear IRQs, drop INTF0 irq on 6375
- don't overduplicate DPU bindings, reuse 7180
- Pick up tags
- Rebase on INTF_TE v4 and next-20230504

Depends on:
- https://lore.kernel.org/linux-arm-msm/20230411-dpu-intf-te-v4-0-27ce1a5ab5c6@somainline.org/

v2: https://lore.kernel.org/r/20230411-topic-straitlagoon_mdss-v2-0-5def73f50980@linaro.org

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
Konrad Dybcio (12):
      dt-bindings: display/msm: dsi-controller-main: Add SM6350
      dt-bindings: display/msm: dsi-controller-main: Add SM6375
      dt-bindings: display/msm: sc7180-dpu: Describe SM6350 and SM6375
      dt-bindings: display/msm: Add SM6350 MDSS
      dt-bindings: display/msm: Add SM6375 MDSS
      drm/msm/dpu: Add SM6350 support
      drm/msm: mdss: Add SM6350 support
      drm/msm/dpu: Add SM6375 support
      drm/msm: mdss: Add SM6375 support
      iommu/arm-smmu-qcom: Sort the compatible list alphabetically
      iommu/arm-smmu-qcom: Add SM6375 DPU compatible
      iommu/arm-smmu-qcom: Add SM6350 DPU compatible

 .../bindings/display/msm/dsi-controller-main.yaml  |   4 +
 .../bindings/display/msm/qcom,sc7180-dpu.yaml      |  23 ++-
 .../bindings/display/msm/qcom,sm6350-mdss.yaml     | 213 ++++++++++++++++++++
 .../bindings/display/msm/qcom,sm6375-mdss.yaml     | 215 +++++++++++++++++++++
 .../gpu/drm/msm/disp/dpu1/catalog/dpu_6_4_sm6350.h | 173 +++++++++++++++++
 .../gpu/drm/msm/disp/dpu1/catalog/dpu_6_9_sm6375.h | 139 +++++++++++++
 drivers/gpu/drm/msm/disp/dpu1/dpu_hw_catalog.c     |   6 +
 drivers/gpu/drm/msm/disp/dpu1/dpu_hw_catalog.h     |   2 +
 drivers/gpu/drm/msm/disp/dpu1/dpu_kms.c            |   2 +
 drivers/gpu/drm/msm/msm_mdss.c                     |  10 +
 drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c         |   6 +-
 11 files changed, 790 insertions(+), 3 deletions(-)
---
base-commit: 6db29e14f4fb7bce9eb5290288e71b05c2b0d118
change-id: 20230411-topic-straitlagoon_mdss-8f34cacd5e26

Best regards,
-- 
Konrad Dybcio <konrad.dybcio@linaro.org>

