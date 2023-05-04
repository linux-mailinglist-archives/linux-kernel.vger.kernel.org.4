Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A36E56F667E
	for <lists+linux-kernel@lfdr.de>; Thu,  4 May 2023 10:01:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229907AbjEDIBc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 May 2023 04:01:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43370 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229913AbjEDIBa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 May 2023 04:01:30 -0400
Received: from mail-lj1-x22a.google.com (mail-lj1-x22a.google.com [IPv6:2a00:1450:4864:20::22a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BFFB82728
        for <linux-kernel@vger.kernel.org>; Thu,  4 May 2023 01:01:27 -0700 (PDT)
Received: by mail-lj1-x22a.google.com with SMTP id 38308e7fff4ca-2a7b02615f1so2183241fa.0
        for <linux-kernel@vger.kernel.org>; Thu, 04 May 2023 01:01:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1683187286; x=1685779286;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=UKfCQ7oGwGPPqXZQ3aJ0ZDJ1Cq02ffMWgWKavhP3FMk=;
        b=OCbpz2/JL1GKJRn1a0KJVijPSjPYlLyMDv8bEl5Ox0lliaW3pnTjLN4TyPnmJ0m7P/
         UoTMo3Nlc0Ks9VwxZ0Jm8l5dJOcO7x80W0UAN3yn2RmETo41GqV6YDtlzakWGV6R+U2L
         lzUQMwJ7P9koytIoJWukoBvR8+eF1Mg/yEfUxApYsuC2R8zQ0/to46epQc+DXobk+ohp
         soJtyJ+1VzFkcvnPZ4zeH2FYF12rnsbmmXKwMCHi5kVPfERJh70GRM5N3upZ6qU7j55k
         pkfQ+lOZejmm+lxNQvTpIivH8hHGo85XFpFqDssoZAxJGpjhTQfD/jbA+DwLvO4aJQ3o
         Yr/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683187286; x=1685779286;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=UKfCQ7oGwGPPqXZQ3aJ0ZDJ1Cq02ffMWgWKavhP3FMk=;
        b=ky8mlqW9pc0VzA9RwA/wOsWXvugnKUe1V9U29GZ3p+072TAdFSqy2akMjEIuuln+1I
         Pn34WtJUpMiC1PBh/ueTy0n4EkqXfevJ2EuAxAuxJvMCEWxbxJU1VdswfT431AFjDx7v
         IKs7pKTzf1dFJlMTjNeGsdx1R1ohAso0kHSFdNrPqi/GQd5LRwSJaAspv9UMEucthvkK
         QFRqWeeHJOG71NEEZEUeP6i+Mx+ztcJpQd1QXxRtVHb5C+wohn8nSm7EDIREb/t5vhS0
         +MU94dlyefjSDKIE+LpX09qZoC/9Q4j08523Phjez8IQgdqo5aJi/RCd0UcV33HuW6Hz
         ovbg==
X-Gm-Message-State: AC+VfDwwyDYZeb0H9lXz6SNdwtLdSmJcoU/RFLjSb0QeeqyqAiqNcvgR
        vnshuQrMxCvS7WwewrGsB4M6Wg==
X-Google-Smtp-Source: ACHHUZ7am1RRkZ8Sc7m+l2FmARoz8//M3blPO+LwbYWvDuPgp0QcQozPU0DQCGq7Ct2XY8F3WtGDIw==
X-Received: by 2002:a2e:8242:0:b0:2a8:d146:12cd with SMTP id j2-20020a2e8242000000b002a8d14612cdmr708401ljh.17.1683187285974;
        Thu, 04 May 2023 01:01:25 -0700 (PDT)
Received: from [192.168.1.101] (abyl248.neoplus.adsl.tpnet.pl. [83.9.31.248])
        by smtp.gmail.com with ESMTPSA id n26-20020ac2491a000000b004edc512515fsm917165lfi.47.2023.05.04.01.01.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 May 2023 01:01:25 -0700 (PDT)
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
Subject: [PATCH v2 00/18] Venus QoL / maintainability fixes
Date:   Thu, 04 May 2023 10:00:56 +0200
Message-Id: <20230228-topic-venus-v2-0-d95d14949c79@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIADlmU2QC/22NQQ6CMBBFr0Jm7ZhSFEZW3sOwKHWESUhLWmg0h
 LtbWbt8L/n/bRA5CEdoiw0CJ4niXQZ9KsCOxg2M8swMWulKaU24+FksJnZrxEaxqXrb1DUR5EV
 vImMfjLNj3rh1mrKcA7/kfSQeXeZR4uLD5yim8mf/n6cSFV7JaktU0YVv90mcCf7swwDdvu9fX
 jO8IbwAAAA=
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1683187284; l=3947;
 i=konrad.dybcio@linaro.org; s=20230215; h=from:subject:message-id;
 bh=g8caXHzolWKJFFUH0lTGkLSyyvJcODU6gNhXgru7KZw=;
 b=RSVmsgJ0YO3P5dGd36GiY9k/kLomJabqfxZTeBEzwhNlP+IniWLWwfZ+VPb0xn1U8j/0asU1q
 Bor1BqUPEffBC3Koiz0GgzR0alRK167TZ3qyh0LhP09bRGkE2PbV7md
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
Konrad Dybcio (18):
      media: venus: hfi_venus: Only consider sys_idle_indicator on V1
      media: venus: hfi_venus: Write to VIDC_CTRL_INIT after unmasking interrupts
      media: venus: Remap bufreq fields on HFI6XX
      media: venus: Introduce VPU version distinction
      media: venus: Add vpu_version to most SoCs
      media: venus: firmware: Leave a clue for homegrown porters
      media: venus: hfi_venus: Sanitize venus_boot_core() per-VPU-version
      media: venus: core: Assign registers based on VPU version
      media: venus: hfi_venus: Fix version checks in venus_halt_axi()
      media: venus: hfi_venus: Fix version checks in venus_isr()
      media: venus: hfi_venus: Fix version check in venus_cpu_and_video_core_idle()
      media: venus: hfi_venus: Fix version check in venus_cpu_idle_and_pc_ready()
      media: venus: firmware: Correct IS_V6() checks
      media: venus: hfi_platform: Check vpu_version instead of device compatible
      media: venus: vdec: Fix version check in vdec_set_work_route()
      media: venus: Introduce accessors for remapped hfi_buffer_reqs members
      media: venus: Use newly-introduced hfi_buffer_requirements accessors
      media: venus: hfi_venus: Restrict writing SCIACMDARG3 to Venus V1/V2

 drivers/media/platform/qcom/venus/core.c           | 11 ++--
 drivers/media/platform/qcom/venus/core.h           | 15 ++++++
 drivers/media/platform/qcom/venus/firmware.c       | 19 +++++--
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
 13 files changed, 138 insertions(+), 64 deletions(-)
---
base-commit: 92e815cf07ed24ee1c51b122f24ffcf2964b4b13
change-id: 20230228-topic-venus-70ea3bc76688

Best regards,
-- 
Konrad Dybcio <konrad.dybcio@linaro.org>

