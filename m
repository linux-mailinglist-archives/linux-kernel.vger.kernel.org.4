Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6B34C6ADF76
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Mar 2023 14:01:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229932AbjCGNBw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Mar 2023 08:01:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33024 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229611AbjCGNBq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Mar 2023 08:01:46 -0500
Received: from mail-lf1-x129.google.com (mail-lf1-x129.google.com [IPv6:2a00:1450:4864:20::129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D9CA7DBD
        for <linux-kernel@vger.kernel.org>; Tue,  7 Mar 2023 05:01:43 -0800 (PST)
Received: by mail-lf1-x129.google.com with SMTP id i9so16947016lfc.6
        for <linux-kernel@vger.kernel.org>; Tue, 07 Mar 2023 05:01:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1678194102;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=kAKt9oLN/3E5C6T5cNeSMYOM4tUix3c4gih76FZI0vA=;
        b=IahDkcbRQh6PRKBga5k1xpkX1K12Pac+lBTOjur4Ti0gLOjDDwv1ebWjja2Amzvrhm
         AVSfZeAxWC3H+QVzUX4wJh3PQPOP+uPGPtASewchwgX8v1WgPcJSxGgVQgBCroTPB/mg
         HsMcEAxc695nc9l0DXFd6VCs9bT1zMaTsLnPVxLrfyQiZz305RiOFq5NmWZFETCwTxTc
         9oRwQCpKs9+s2PIOpFs5WN8r4hx5aUJWzDWusUYGb0WLaHKFd0dV7mYbeEp0kMuhqCe6
         Y2KZ83aFKHOAIT87E8HKO9M7AnhXKP18iZf56tRgRKqvRaMDaK5wzV+2K9LsK8WYusBs
         wuiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678194102;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=kAKt9oLN/3E5C6T5cNeSMYOM4tUix3c4gih76FZI0vA=;
        b=PttKR4QaQtkKHLdcu5hCfxi/g6CgkABMYIHuhA2cM2TYloKYEXAH8GqJDGNDIXoK3G
         C0jn532tIM+bMsYTY+fJbA1pmD54IWdyBvSY9z1PZtiuMkIWjIvrs5WoHj0QqXzOoKg3
         RpEQiufSR7vJHJNIWIx8HSfHDXKJ8GY+Vv4y4t5QhusleaOLCN1/emHq9afSRok7I7Vo
         lY8vv9TbH8oHZhNFOwhFj0BZb9Bm/YTgYY9KIWBk+vKE3vQEcSVOzHWFTJYcKM5wLubi
         57otdHDvcz4qBDI4cUzivZNhrn9oUwLmJrUQ64aTSXcH0M/ITMJu9lUME8ght/qwNHpx
         a11w==
X-Gm-Message-State: AO0yUKXhmqMFBRDE50i0+HYijs8MmJtNL9dAMvbDcyfky8/k7x1kWyH1
        W/ewiQN7CyKaUQ2OlS2xFJxLUA==
X-Google-Smtp-Source: AK7set8z/qcx87HDZWoD6FwIXZM8Cu3r1uLjF3xt83ugybLjz1wVUQBna8yb7yA/JzAybC+nxf9qHQ==
X-Received: by 2002:ac2:446b:0:b0:4d5:831a:1af8 with SMTP id y11-20020ac2446b000000b004d5831a1af8mr4246862lfl.40.1678194101601;
        Tue, 07 Mar 2023 05:01:41 -0800 (PST)
Received: from [192.168.1.101] (abyj16.neoplus.adsl.tpnet.pl. [83.9.29.16])
        by smtp.gmail.com with ESMTPSA id u2-20020ac248a2000000b004cc5e97d356sm2048265lfg.148.2023.03.07.05.01.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Mar 2023 05:01:41 -0800 (PST)
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
Subject: [PATCH v3 00/10] Fix DSI host idx detection on HW revision clash
Date:   Tue, 07 Mar 2023 14:01:38 +0100
Message-Id: <20230307-topic-dsi_qcm-v3-0-8bd7e1add38a@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIALI1B2QC/x2N0QqDMAxFf0XybKBYxsRfkSE1TWdAq2tUBuK/L
 +zxnMvhXqBchBW66oLCp6is2cDXFdAU8ptRojE0rvHOuyfu6yaEUWX40IIPis6TTalNYM0YlHE
 sIdNkVT7m2eRWOMn3f9K/7vsHASMEV3QAAAA=
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
        Konrad Dybcio <konrad.dybcio@linaro.org>
X-Mailer: b4 0.12.1
X-Developer-Signature: v=1; a=ed25519-sha256; t=1678194100; l=2768;
 i=konrad.dybcio@linaro.org; s=20230215; h=from:subject:message-id;
 bh=w8f97gizhKeQlAufN/gAw/Y5LqIn6pMqeGASKnoEWho=;
 b=eOnovxHa4VCfpFjQWjo/7ouKcm1gRhvXoxkVoIem0sV72MWp0RQkRWdMHfoK464VMtQQ+jCEmvl8
 xv1AhdMGB6qQcL0Lqc6wVBgRMxS0VmSQ/b3zjT9XMv3HuJRhyP+u
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
 .../bindings/display/msm/qcom,sm6115-mdss.yaml     |   8 +-
 arch/arm64/boot/dts/qcom/sm6115.dtsi               |   2 +-
 drivers/gpu/drm/msm/dsi/dsi.c                      |   6 +-
 drivers/gpu/drm/msm/dsi/dsi_cfg.c                  | 161 ++++++++-------------
 drivers/gpu/drm/msm/dsi/dsi_cfg.h                  |   6 +-
 drivers/gpu/drm/msm/dsi/dsi_host.c                 |  14 +-
 7 files changed, 82 insertions(+), 121 deletions(-)
---
base-commit: dc837c1a5137a8cf2e9432c1891392b6a66f4d8d
change-id: 20230307-topic-dsi_qcm-5cd03c230f8f

Best regards,
-- 
Konrad Dybcio <konrad.dybcio@linaro.org>

