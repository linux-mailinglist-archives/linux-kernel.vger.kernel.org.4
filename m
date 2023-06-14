Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D515F715F86
	for <lists+linux-kernel@lfdr.de>; Tue, 30 May 2023 14:31:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231611AbjE3Mb3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 May 2023 08:31:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57368 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230343AbjE3MbX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 May 2023 08:31:23 -0400
Received: from mail-lj1-x233.google.com (mail-lj1-x233.google.com [IPv6:2a00:1450:4864:20::233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C8D73135
        for <linux-kernel@vger.kernel.org>; Tue, 30 May 2023 05:30:55 -0700 (PDT)
Received: by mail-lj1-x233.google.com with SMTP id 38308e7fff4ca-2af2958db45so45057261fa.1
        for <linux-kernel@vger.kernel.org>; Tue, 30 May 2023 05:30:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1685449839; x=1688041839;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=mM7Jz0mpFc9F7VQ75gYzJLA8egHJEnLGa+xgLus3Meg=;
        b=L3UCcbWRjZdIUk9bofbPj8741KWX1qPMmsh4N+RNqapeZhyQhrvAqob+OvEYC8htWk
         fOtkD/0wVbSQhfjOFKkuD7oCOsL4FQYNgLyxv4776ef4HVfNYCC8KBR+DcKNhQVQZd7h
         86LHNfVSbdqr/RHXyeJjchxg5/nvSo6+UdStm/4K/0RbtggooqZKaujJFW8c/YctrjZ8
         BrA/82xDWCAhxAmwgGfaWnbtR3wTXuuyGbZF4s0XzKjPponge+bJoPuzksu2ocTCjgtO
         edElyHQOz3ly33eQiKGs0A/LGaRXejKyN0exmcou6yg39CbsAWm4JOI6fjcFFzKd8OSC
         4Gug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685449839; x=1688041839;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=mM7Jz0mpFc9F7VQ75gYzJLA8egHJEnLGa+xgLus3Meg=;
        b=Oll8gIIrT09VytwNLcsQHR4sYJQOO8DXn3vpyAZXzBOV7ZbW4l0M2E/iJbVCLCb6kV
         1JkKr9WnG4oOsktirzIC8/fPom3mFeBAC7DH3eliOhvbFoBoS9aXFiY6YUlr7+G0qiMi
         0C+3Ct/4N6ZPClowloevknMpXqSUd1962SM08JF/M7pf1LNtobzN5KZvXW2Is+K2wn6M
         zDzrkJyKNFm4gfgBPWZbV8bweJvsUefctN2VKQalMVT0Z42tzQBO0dEASxy18ZS0n4n+
         SDYbKAzCNFmpRH9IwBijV3J4I7k6cfldQz04Ox/8JZn4iUAFXOMJXKgyffDPCSwGWWc3
         gsmg==
X-Gm-Message-State: AC+VfDw0ZWSdiXm6BNMibIR/faqwgNqCgm3ajHj5uXRWep622AFKpT2a
        Q6Og09s3rHNRUNF6e14f42I4kw==
X-Google-Smtp-Source: ACHHUZ4enNxJ4AIlPJiaCYu/JLIxdKbrPKtGJVCnoov4LMJ4lyrtWg+NVVGjyGb9kbb/WmVk/SNvkg==
X-Received: by 2002:a2e:8302:0:b0:2a8:bc82:5f8f with SMTP id a2-20020a2e8302000000b002a8bc825f8fmr795140ljh.9.1685449838777;
        Tue, 30 May 2023 05:30:38 -0700 (PDT)
Received: from [192.168.1.101] (abyj77.neoplus.adsl.tpnet.pl. [83.9.29.77])
        by smtp.gmail.com with ESMTPSA id u18-20020a2e91d2000000b002a8b8baf542sm2854814ljg.126.2023.05.30.05.30.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 May 2023 05:30:38 -0700 (PDT)
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
Subject: [PATCH v4 00/17] Venus QoL / maintainability fixes
Date:   Tue, 30 May 2023 14:30:34 +0200
Message-Id: <20230228-topic-venus-v4-0-feebb2f6e9b8@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAGvsdWQC/33NQQ6DIBQE0KsY1qVBQIWueo+mC8CvkhgwoKSN8
 e5Fd00blzPJm1lRhGAholuxogDJRutdDvxSIDMo1wO2bc6IEsoIpQLPfrIGJ3BLxA0BxbRp6lo
 IlIVWEbAOypkhG7eMYy6nAJ19HRePZ86DjbMP7+MxlXv7fzyVmOBKGGqEYIKDvI/WqeCvPvRoH
 0r0BNOMW1m1JZdcmuYXsxPMMq6JpAo405XovvC2bR+lHTgVNgEAAA==
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1685449837; l=4983;
 i=konrad.dybcio@linaro.org; s=20230215; h=from:subject:message-id;
 bh=GzggsN2nMZHk+5zCOLvOhBzcYDD9jMl6Z663enA8WEM=;
 b=UkyLQExaf4jwinZAu16ll2AhBFr7wHxO6zrPSHRlhHHYYE/Yt/9lBejb8Jdec++j0UYAwf6i/
 YRCKsypzbLsDN7b1fEbRgWZJ9fN+SfYBGvd25c5x6tJERJzypkWtfbj
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

v3 -> v4:
- Rebase on Stanimir's venus-for-next-v6.5
- Collapse 2 identical if-statements in "Sanitize venus_boot_core()
  per-VPU-version"
- Reword "Assign registers based on VPU version"
- Check for IS_IRIS2_1() instead of wrongly checking for core->use_tz,
  update commit msg in "media: venus: firmware: Correct IS_V6() checks"
- Access correct struct fields in "Use newly-introduced
  hfi_buffer_requirements accessors", drop Bryan's r-b

v3: https://lore.kernel.org/r/20230228-topic-venus-v3-0-6092ae43b58f@linaro.org

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
      media: venus: firmware: Sanitize per-VPU-version
      media: venus: hfi_platform: Check vpu_version instead of device compatible
      media: venus: vdec: Sanitize vdec_set_work_route() per-VPU-version
      media: venus: Introduce accessors for remapped hfi_buffer_reqs members
      media: venus: Use newly-introduced hfi_buffer_requirements accessors
      media: venus: hfi_venus: Restrict writing SCIACMDARG3 to Venus V1/V2

 drivers/media/platform/qcom/venus/core.c           |  7 ++-
 drivers/media/platform/qcom/venus/core.h           | 15 ++++++
 drivers/media/platform/qcom/venus/firmware.c       | 18 +++++--
 drivers/media/platform/qcom/venus/helpers.c        |  7 +--
 drivers/media/platform/qcom/venus/hfi_helper.h     | 61 +++++++++++++++++++---
 drivers/media/platform/qcom/venus/hfi_msgs.c       |  2 +-
 .../media/platform/qcom/venus/hfi_plat_bufs_v6.c   | 22 ++++----
 drivers/media/platform/qcom/venus/hfi_platform.c   |  2 +-
 drivers/media/platform/qcom/venus/hfi_venus.c      | 42 +++++++--------
 drivers/media/platform/qcom/venus/vdec.c           | 10 ++--
 drivers/media/platform/qcom/venus/vdec_ctrls.c     |  2 +-
 drivers/media/platform/qcom/venus/venc.c           |  4 +-
 drivers/media/platform/qcom/venus/venc_ctrls.c     |  2 +-
 13 files changed, 133 insertions(+), 61 deletions(-)
---
base-commit: 9f9f8ca6f012d25428f8605cb36369a449db8508
change-id: 20230228-topic-venus-70ea3bc76688

Best regards,
-- 
Konrad Dybcio <konrad.dybcio@linaro.org>

