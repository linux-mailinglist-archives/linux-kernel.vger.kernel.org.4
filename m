Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 53AF97073A2
	for <lists+linux-kernel@lfdr.de>; Wed, 17 May 2023 23:14:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229736AbjEQVOb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 May 2023 17:14:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52000 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229483AbjEQVO3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 May 2023 17:14:29 -0400
Received: from mail-lj1-x233.google.com (mail-lj1-x233.google.com [IPv6:2a00:1450:4864:20::233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8173D6A5F
        for <linux-kernel@vger.kernel.org>; Wed, 17 May 2023 14:14:27 -0700 (PDT)
Received: by mail-lj1-x233.google.com with SMTP id 38308e7fff4ca-2ac87e7806aso12711801fa.3
        for <linux-kernel@vger.kernel.org>; Wed, 17 May 2023 14:14:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1684358066; x=1686950066;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=JPQ+rxAnNr1pVtpS1IHn9dDua1A7Qd2hNKqGcwb9dQQ=;
        b=Z3vy5qB7/QBsm8S6SBwDmzDEXHj21xPdDWha1wlxG8U3MfOJ7EX2C+Khs2PMRdyDEw
         n0ukKwfA5rI59IHpYodR1KRBzlT9C2sPMWAcAYwzm/9vAtrbbU3bi+FRgw78S8abuJcf
         D47wm/px/hDkG3kQewdCHRYGmVBkujmaLKU6UyeFUM7DiHUXGHdA4FeyTg1sg1yuDBoQ
         euhQZ/3aCQjELcHCyKxu7Ng8LkfIR+jJEXe1uWpK42HMG+ypJrW+8rEUefYZE/PNS5dP
         I9um0KxIkR09tlG8g7A3j5QZNSrddsiN0n0WCRRQ2Q9Zg6M/7/6cBUtL+Ob72pjFII0Z
         R5kw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684358066; x=1686950066;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=JPQ+rxAnNr1pVtpS1IHn9dDua1A7Qd2hNKqGcwb9dQQ=;
        b=alXe+m+sY7QISJJHSFhhcOl8GMIHmo6R9bYwDVnBfclLBDEDrYmJG1EF90paRvSi2k
         DgDtRkocIzxRtUJzLM1RFOAj0fLe22M4y88Im2sTDuUz1aIK5pYrvDF0/687Nggvrw9H
         nw+LuilZCw+NIBFBxITjbzN2/LDa+QVDhuVmJVONB3ApPyBEYSZppmk32zpQRReZLM49
         uwyNkBCcu3znh+wb6QP6OSlp9XOITWGjtJlY5OGycbgTCodxPcw+Oe5W4Wp9LuB9D5RX
         XSeYh+il+ud4EkExmMnyUw0ozMfDmXFKOkOtRpDL7C7vXWffH40WC8Fu7XcEaiXGQu+Z
         dMtg==
X-Gm-Message-State: AC+VfDz0ixES2zV7+Fb4NYS4qHW8HuLgiej5iPyIw19AJ7VV+uXzMoch
        OP5tg3ssBFpMqOBs7RoXTFi59g==
X-Google-Smtp-Source: ACHHUZ6IYfWNpgIpg23wGVmgZXdHrH4316gOOx8Pep2fndWYlETsGZ7IA07vnz2nQtI4iIKz7rVwhg==
X-Received: by 2002:a2e:9819:0:b0:2aa:41a1:cd70 with SMTP id a25-20020a2e9819000000b002aa41a1cd70mr9867131ljj.3.1684358065749;
        Wed, 17 May 2023 14:14:25 -0700 (PDT)
Received: from [192.168.1.101] (abxi58.neoplus.adsl.tpnet.pl. [83.9.2.58])
        by smtp.gmail.com with ESMTPSA id l5-20020a2e8345000000b002ac88e29049sm4781142ljh.43.2023.05.17.14.14.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 May 2023 14:14:25 -0700 (PDT)
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
Subject: [PATCH v3 00/17] Venus QoL / maintainability fixes
Date:   Wed, 17 May 2023 23:14:13 +0200
Message-Id: <20230228-topic-venus-v3-0-6092ae43b58f@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAKVDZWQC/32NywqDMBBFf0WybkpMfCRd9T9KFzFO64AkkmhoE
 f+9o7tC6fJcOOeuLEFESOxSrCxCxoTBE6hTwdxg/RM49sRMCqmElJrPYULHM/gl8VaAVZ1rm0Z
 rRkZnE/AuWu8GcvwyjjROER74Oi5ud+IB0xzi+3jM5b7+jueSC15rJ53WSldgriN6G8M5xCfbQ
 1n+kSXJvan7sjKVce23vG3bB31ruw35AAAA
To:     Stanimir Varbanov <stanimir.k.varbanov@gmail.com>,
        Vikash Garodia <quic_vgarodia@quicinc.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Dikshita Agarwal <dikshita@qti.qualcomm.com>,
        Bryan O'Donoghue <bryan.odonoghue@linaro.org>,
        Mansur Alisha Shaik <mansur@codeaurora.org>,
        Jonathan Marek <jonathan@marek.ca>,
        Hans Verkuil <hans.verkuil@cisco.com>,
        Dikshita Agarwal <quic_dikshita@quicinc.com>
Cc:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        Stanimir Varbanov <stanimir.varbanov@linaro.org>,
        linux-media@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Marijn Suijten <marijn.suijten@somainline.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Vikash Garodia <quic_vgarodia@quicinc.com>,
        stable@vger.kernel.org
X-Mailer: b4 0.12.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1684358064; l=4446;
 i=konrad.dybcio@linaro.org; s=20230215; h=from:subject:message-id;
 bh=DXJG1cPYd9kdnwIW4oXv+iZufWBsr/dePoRiztA9KTM=;
 b=Xsmq1HD5usln3psyNw8k+1wHdlqT8jW7G/dRsvSMfsVt1ckofgbHcphDKv/GpEjhFZmgKqgLI
 k2ehP30MiVzAbn0CqOwLG9ke6x5RgMSdwLT13I32ALJOamXy30zQOR5
X-Developer-Key: i=konrad.dybcio@linaro.org; a=ed25519;
 pk=iclgkYvtl2w05SSXO5EjjSYlhFKsJ+5OSZBjOkQuEms=
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

v2 -> v3:
- Rephrase "Write to VIDC_CTRL_INIT after unmasking interrupts" commit msg
- Drop "Remap bufreq fields on HFI6XX"
- Rephrase "Introduce VPU version distinction" commit msg
- Better explain "Leave a clue for homegrown porters"
- Drop incorrect fixes tags/rephrase version check alternations
- Drop AR50L/IRIS1 from if-conditions, they'll be introduced separately
- pick up tags
- rebase on next-20230517 (no effective changes)

v2: https://lore.kernel.org/r/20230228-topic-venus-v2-0-d95d14949c79@linaro.org

v1 -> v2:
- Move "Write to VIDC_CTRL_INIT after unmasking interrupts" up and add
  a Fixes tag & Cc stable
- Reword the comment in "Correct IS_V6() checks"
- Move up "media: venus: Remap bufreq fields on HFI6XX", add Fixes and
  Cc stable
- Use better English in "Use newly-introduced hfi_buffer_requirements
  accessors" commit message
- Mention "Restrict writing SCIACMDARG3 to Venus V1/V2" doesn't seem to
  regress SM8250 in the commit message
- Pick up tags (note: I capitalized the R in Dikshita's 'reviewed-by'
  and removed one occurrence of random '**' to make sure review tools
  like b4 don't go crazy)
- Handle AR50_LITE in "Assign registers based on VPU version"
- Drop /* VPUn */ comments, they're invalid as explained by Vikash
- Take a different approach to the sys_idle problem in patch 1

v1: https://lore.kernel.org/r/20230228-topic-venus-v1-0-58c2c88384e9@linaro.org

Currently upstream assumes all (well, almost all - see 7280 or CrOS
specific checks) Venus implementations using the same version of the
Hardware Firmware Interface can be treated the same way. This is
however not the case.

This series tries to introduce the groundwork to start differentiating
them based on the VPU (Video Processing Unit) hardware type, fixes a
couple of issues that were an effect of that generalized assumption
and lays the foundation for supporting 8150 (IRIS1) and SM6115/QCM2290
(AR50 Lite), which will hopefully come soon.

Tested on 8250, but pretty please test it on your boards too!

Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
---
Konrad Dybcio (17):
      media: venus: hfi_venus: Only consider sys_idle_indicator on V1
      media: venus: hfi_venus: Write to VIDC_CTRL_INIT after unmasking interrupts
      media: venus: Introduce VPU version distinction
      media: venus: Add vpu_version to most SoCs
      media: venus: firmware: Leave a clue about obtaining CP VARs
      media: venus: hfi_venus: Sanitize venus_boot_core() per-VPU-version
      media: venus: core: Assign registers based on VPU version
      media: venus: hfi_venus: Sanitize venus_halt_axi() per-VPU-version
      media: venus: hfi_venus: Sanitize venus_isr() per-VPU-version
      media: venus: hfi_venus: Sanitize venus_cpu_and_video_core_idle() per-VPU-version
      media: venus: hfi_venus: Sanitize venus_cpu_idle_and_pc_ready() per-VPU-version
      media: venus: firmware: Correct IS_V6() checks
      media: venus: hfi_platform: Check vpu_version instead of device compatible
      media: venus: vdec: Sanitize vdec_set_work_route() per-VPU-version
      media: venus: Introduce accessors for remapped hfi_buffer_reqs members
      media: venus: Use newly-introduced hfi_buffer_requirements accessors
      media: venus: hfi_venus: Restrict writing SCIACMDARG3 to Venus V1/V2

 drivers/media/platform/qcom/venus/core.c           |  7 ++-
 drivers/media/platform/qcom/venus/core.h           | 15 ++++++
 drivers/media/platform/qcom/venus/firmware.c       | 22 ++++++--
 drivers/media/platform/qcom/venus/helpers.c        |  7 +--
 drivers/media/platform/qcom/venus/hfi_helper.h     | 61 +++++++++++++++++++---
 drivers/media/platform/qcom/venus/hfi_msgs.c       |  2 +-
 .../media/platform/qcom/venus/hfi_plat_bufs_v6.c   | 22 ++++----
 drivers/media/platform/qcom/venus/hfi_platform.c   |  2 +-
 drivers/media/platform/qcom/venus/hfi_venus.c      | 45 ++++++++--------
 drivers/media/platform/qcom/venus/vdec.c           | 10 ++--
 drivers/media/platform/qcom/venus/vdec_ctrls.c     |  2 +-
 drivers/media/platform/qcom/venus/venc.c           |  4 +-
 drivers/media/platform/qcom/venus/venc_ctrls.c     |  2 +-
 13 files changed, 139 insertions(+), 62 deletions(-)
---
base-commit: 065efa589871e93b6610c70c1e9de274ef1f1ba2
change-id: 20230228-topic-venus-70ea3bc76688

Best regards,
-- 
Konrad Dybcio <konrad.dybcio@linaro.org>

