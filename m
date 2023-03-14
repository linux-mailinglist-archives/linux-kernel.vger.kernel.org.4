Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D38E86B9382
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Mar 2023 13:18:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232064AbjCNMRs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Mar 2023 08:17:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58724 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232059AbjCNMPd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Mar 2023 08:15:33 -0400
Received: from mail-lf1-x133.google.com (mail-lf1-x133.google.com [IPv6:2a00:1450:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD59FA2189
        for <linux-kernel@vger.kernel.org>; Tue, 14 Mar 2023 05:14:35 -0700 (PDT)
Received: by mail-lf1-x133.google.com with SMTP id i28so19774106lfv.0
        for <linux-kernel@vger.kernel.org>; Tue, 14 Mar 2023 05:14:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1678796046;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=C+k0ggqNg/FIAuwP95P/wKnFGsJ4cmP3bum+BKgvOzA=;
        b=vXO1OmjOWBHjONOqEL1VvCON9/CyyU4xspVhcDGkI1Uhvllw08UT69oHAj7ydB2DtS
         /zBnJ9HHTS2DJKlKJM0/meZmbXMlqejccYbFuliIvTkmAPACwJFd0HUevTqfaYzJZ4y/
         79hiPSXhgAoNTRxecg+/LAPB6EcF+c+hzgZa0EPNLRTeu377ioDZkoECMS9IjbK4T8zi
         1QODD7xFTI1msBdpkrT2VfbO8kjC1dxqoIUBxl7hagzB1OvasMtMwPVrWN/MNiXFZTYg
         4mhHWJd4/QrzxgZ4SDGMb+yH5kpJEPWc4igAmnRltDgXOoKa+I1GiBiIm1TKuEiwwXdy
         1+Ug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678796046;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=C+k0ggqNg/FIAuwP95P/wKnFGsJ4cmP3bum+BKgvOzA=;
        b=RsXdBP6miqNnJLAppKzgrmWdEfaQQhuzQQLKAfTCWGY/x7QPmHopadwm26aZZwfRZx
         zWIPTKPCvLCNWu8R7hMYMszJ6VNCkDDX65aGR0TGvtq9F8hHcNUY9xkcg/LNnATQR54c
         O1VKRqwopbMayHvOLBXxYRjDRwipThrjTMNL3RUufcmtORkBvXtdPIz2c0ZEd6mlpHQN
         pBxqj4wrQ+oKNXIMEM3GSP47XRZlI0bU/4YZ8RkFt8P/CeN7prHi8QO88BCtesQqzIb5
         aEpxuAfhgdz68QS9n5d1I3zZ/UP5UTqrXSC/t73gGTxy++1adIm6GjB376ktiqqOflKV
         bwTw==
X-Gm-Message-State: AO0yUKUCFtGoloGCU3hwxtW3EhJtM2xKhhkLqdjnJtlyKuVpyNStypBB
        XdeVsqf8PXawN9+mQsGttU1YyQ==
X-Google-Smtp-Source: AK7set9Bnoudh78ePtZWrbJ1zS2t1w31qWyDUf+FgRlkvpDHYAK3ItGS2HClWH4+OUwsIWOu3pDxgQ==
X-Received: by 2002:a05:6512:931:b0:4e8:4abf:f19d with SMTP id f17-20020a056512093100b004e84abff19dmr674719lft.15.1678796045929;
        Tue, 14 Mar 2023 05:14:05 -0700 (PDT)
Received: from [192.168.1.101] (abyj16.neoplus.adsl.tpnet.pl. [83.9.29.16])
        by smtp.gmail.com with ESMTPSA id s4-20020a19ad44000000b004dda87ecae3sm379058lfd.246.2023.03.14.05.14.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Mar 2023 05:14:05 -0700 (PDT)
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
Subject: [PATCH v4 00/10] Fix DSI host idx detection on HW revision clash
Date:   Tue, 14 Mar 2023 13:13:38 +0100
Message-Id: <20230307-topic-dsi_qcm-v4-0-54b4898189cb@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAPJkEGQC/3WNwQ6CMBBEf8Xs2TWVaiCe/A9DTGkX2ARb3CLRE
 P7dlbvHN5M3s0AmYcpw2S0gNHPmFBVO+x343sWOkIMyFKawxpoSpzSyx5D5/vQPPPtgrNeqrVp
 Qp3GZsBEXfa9WfA2DhqNQy+/t5FYr95ynJJ/tc7a/9N/8bNFg1YSSji4EW7nrwNFJOiTpoF7X9
 QvdRMN5wAAAAA==
To:     Rob Clark <robdclark@gmail.com>,
        Abhinav Kumar <quic_abhinavk@quicinc.com>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Sean Paul <sean@poorly.run>, David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Krishna Manikandan <quic_mkrishn@quicinc.com>,
        Bryan O'Donoghue <bryan.odonoghue@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>
Cc:     Rob Herring <robh@kernel.org>, linux-arm-msm@vger.kernel.org,
        dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Marijn Suijten <marijn.suijten@somainline.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>
X-Mailer: b4 0.12.1
X-Developer-Signature: v=1; a=ed25519-sha256; t=1678796043; l=3183;
 i=konrad.dybcio@linaro.org; s=20230215; h=from:subject:message-id;
 bh=BYokI6ZreFXVs100jAx3BZsaxlrxbRc7xS9fJR8oTMM=;
 b=4XTWXmSHSxRYILva9b14FDjaxy5kJQ61Ew4xkhp3Ky6B82T258cVGGkh2Fwx2JHtexgFj2ejaTzR
 44k6bw4gATY2RlPmyv9JykSwxLqfHzIM94uZNEb4c0h59JPZfAxA
X-Developer-Key: i=konrad.dybcio@linaro.org; a=ed25519;
 pk=iclgkYvtl2w05SSXO5EjjSYlhFKsJ+5OSZBjOkQuEms=
X-Spam-Status: No, score=-0.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_SORBS_HTTP,RCVD_IN_SORBS_SOCKS,SPF_HELO_NONE,SPF_PASS,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

v3 -> v4:
- Use the shiny new compatible in the 6115 bindings example [9/10]
- Remove the leftover include and header definition [6, 7/10]
- Deduplicate the qcm2290 clks/regs in the common deduplication commit
  instead of doing it separately
- Pick up tags
- Rebase on next-20230314 (nothing seems to have changed fwiw)

v3: https://lore.kernel.org/r/20230307-topic-dsi_qcm-v3-0-8bd7e1add38a@linaro.org

v2 -> v3:
- Merge with [1], I should have done that earlier..
  - Squash 6115 compatible patches into one
- Pick up tags (except Rob's ack in 6115 compatible addition, as it was changed)
- Use b4 (sorry if you got an incomplete set of messages before..)

[1] https://lore.kernel.org/linux-arm-msm/145066db-5723-6baa-237d-7c2b8fd476d9@linaro.org/
v2: https://lore.kernel.org/linux-arm-msm/20230213121012.1768296-1-konrad.dybcio@linaro.org/

v1 -> v2:
- squash the 2d-array-ification and fixing up the logic into one patch
- drop num_variants, loop over VARIANTS_MAX*DSI_MAX unconditionally
- drop inadequate Fixes: tags
- pick up rbs

v1: https://lore.kernel.org/linux-arm-msm/20230211115110.1462920-1-konrad.dybcio@linaro.org/

Some DSI host versions are implemented on multiple SoCs which use
vastly different register maps. This messes with our current
assumptions of being able to map {dsi0, dsi1} to {reg0, reg1}.
Solve that by adding a way of specifying multiple sets of base
registers and try comparing them against the register specified in DT
until we find a match.

This removes the need for the QCM2290-specific compatible which was
used in the SM6115 DT (which uses DSIv2.4.1, just like SC7180).
The series also takes care of that.

Tested on SM6115P Lenovo Tab P11 and SM8350 PDX215

Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
---
Konrad Dybcio (10):
      dt-bindings: display/msm: dsi-controller-main: Fix deprecated QCM2290 compatible
      drm/msm/dsi: Get rid of msm_dsi_config::num_dsi
      drm/msm/dsi: Fix DSI index detection when version clash occurs
      drm/msm/dsi: dsi_cfg: Deduplicate identical structs
      drm/msm/dsi: dsi_cfg: Merge SC7180 config into SDM845
      drm/msm/dsi: Switch the QCM2290-specific compatible to index autodetection
      drm/msm/dsi: Remove custom DSI config handling
      dt-bindings: display/msm: dsi-controller-main: Fix deprecated compatible
      dt-bindings: display/msm: dsi-controller-main: Add SM6115
      arm64: dts: qcom: sm6115: Use the correct DSI compatible

 .../bindings/display/msm/dsi-controller-main.yaml  |   6 +-
 .../bindings/display/msm/qcom,sm6115-mdss.yaml     |  10 +-
 arch/arm64/boot/dts/qcom/sm6115.dtsi               |   2 +-
 drivers/gpu/drm/msm/dsi/dsi.c                      |   7 +-
 drivers/gpu/drm/msm/dsi/dsi_cfg.c                  | 161 ++++++++-------------
 drivers/gpu/drm/msm/dsi/dsi_cfg.h                  |   9 +-
 drivers/gpu/drm/msm/dsi/dsi_host.c                 |  14 +-
 7 files changed, 83 insertions(+), 126 deletions(-)
---
base-commit: ec0fa9a0a6fac454745c930bdb8619d0a354bac9
change-id: 20230307-topic-dsi_qcm-5cd03c230f8f

Best regards,
-- 
Konrad Dybcio <konrad.dybcio@linaro.org>

