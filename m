Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EE025715B5D
	for <lists+linux-kernel@lfdr.de>; Tue, 30 May 2023 12:20:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231406AbjE3KUK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 May 2023 06:20:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51790 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231304AbjE3KUH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 May 2023 06:20:07 -0400
Received: from mail-lf1-x12d.google.com (mail-lf1-x12d.google.com [IPv6:2a00:1450:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6729EC9
        for <linux-kernel@vger.kernel.org>; Tue, 30 May 2023 03:20:05 -0700 (PDT)
Received: by mail-lf1-x12d.google.com with SMTP id 2adb3069b0e04-4f3a9ad31dbso4875275e87.0
        for <linux-kernel@vger.kernel.org>; Tue, 30 May 2023 03:20:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1685442003; x=1688034003;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=3mCrqWltv1neqVqCpZo0gfCGWXLEFNOguKdIUsP/Fuo=;
        b=eeVzdLBgnCbIQSDvehs4g2Y1udKY5OVVr8yEIkmYaeA1N5ub/4ihUzU6fmNAvUKK7s
         XHKRENGifZXrMQM7Mbf+9eZJOoEjJq3shnqpjS8kPhIv6qEpIX9KMPxqXBIQFQ7Jbh3i
         dF/NXF2cNNltXaKVDP7iyi7Cejo5WGtwdYYtRBuT895s2OznKWYVHYZeJuBkQvTngsVo
         h1z6fF8fpM4aLcgJu8Er/jR4qwdduW/81vJQxoaPo4smDVM2/iiuR3x0tk1lRPTzAL1S
         EenFsxKGxZmxrdIERAbaD3Gl4biKpuQEtviH30vyYrylDYOPV52nJvtglRe7mcDD/yyf
         /A8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685442003; x=1688034003;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=3mCrqWltv1neqVqCpZo0gfCGWXLEFNOguKdIUsP/Fuo=;
        b=KJbc1/27CQOwL6GwxvM3XbefNLjxky5Q+cwPGCh4qke7Aho6MZso1XMt1ZSA6gda19
         s8ro3MDnQFrEu0/nvFyW+CSt0KBGNYCQJ/iqFanvWtiTVQ427tJTcaIvjNP4C1A73cWY
         kcf1aiB9IJH7ChTk+S6G9RPbYIQusgWOWFeQ2CXqkbynAosqfm7SRvQ+G/ctSanOzoOY
         FF01A5UJ/SIPqnDavaJDSL/Pwl3/JAc+pvC3xFWOJ3vJyVC9qGJ3JMOFyq1L96UTq09Z
         9KFI66fk+QS4S3EAA9mP4siPu/8wmZK0WgHTj3agf6ueWbKq5sLbfgPcYrRE3viVQg03
         owsg==
X-Gm-Message-State: AC+VfDxiRnmDY8A/fkypOEkdIYcU90Uf3v23YOZQy0MZ31iKn+1toefg
        EDQUQp4/Uh5DWklZze6Vw4tOtw==
X-Google-Smtp-Source: ACHHUZ6LzQiKwm5NNt92+vL6PmntTJMXHFhIRImesVTAXXaH7iQjNZfL0vVIup8Tp0aQwOvgtVtgCw==
X-Received: by 2002:ac2:489a:0:b0:4eb:2d47:602 with SMTP id x26-20020ac2489a000000b004eb2d470602mr492112lfc.59.1685442003660;
        Tue, 30 May 2023 03:20:03 -0700 (PDT)
Received: from [192.168.1.101] (abyj77.neoplus.adsl.tpnet.pl. [83.9.29.77])
        by smtp.gmail.com with ESMTPSA id c25-20020ac24159000000b004cc8196a308sm290902lfi.98.2023.05.30.03.20.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 May 2023 03:20:02 -0700 (PDT)
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
Subject: [PATCH 00/20] Restructure RPM SMD ICC
Date:   Tue, 30 May 2023 12:19:59 +0200
Message-Id: <20230526-topic-smd_icc-v1-0-1bf8e6663c4e@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAM/NdWQC/x2N0QqDMAwAf0XyvIDWOXS/MkTaNNOAq9KoDMR/X
 9jjHRx3gnIWVngWJ2Q+RGVJBtWtAJp8GhklGoMrXV027oHbsgqhfuIgRBhaV9XdvfUNR7AmeGU
 M2SearEr7PJtcM7/l+5+8+uv6AYV8eQR0AAAA
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Georgi Djakov <djakov@kernel.org>,
        Leo Yan <leo.yan@linaro.org>, Evan Green <evgreen@chromium.org>
Cc:     Marijn Suijten <marijn.suijten@somainline.org>,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-clk@vger.kernel.org, linux-pm@vger.kernel.org,
        Konrad Dybcio <konrad.dybcio@linaro.org>
X-Mailer: b4 0.12.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1685442001; l=4253;
 i=konrad.dybcio@linaro.org; s=20230215; h=from:subject:message-id;
 bh=Km9sqvTozptxIsrlMv2khmSR+d/xI6LidkhWc28eWlY=;
 b=edruqj25akE940gqlnj49Rt1V4+E+Q47AlcTzS0rDBPMGy9OF2dB70oLMRr+Vcmxh6OSYy2Tq
 DHYY4zhupelB+URtlh6a5cxUEV7zkaCNSzJKMQeAB4IFLGq5zj6D/H4
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

This series reshuffles things around, moving the management of SMD RPM
bus clocks to the interconnect framework where they belong. This helps
us solve a couple of issues:

1. We can work towards unused clk cleanup of RPMCC without worrying
   about it killing some NoC bus, resulting in the SoC dying.
   Deasserting actually unused RPM clocks (among other things) will
   let us achieve "true SoC-wide power collapse states", also known as
   VDD_LOW and VDD_MIN.

2. We no longer have to keep tons of quirky bus clock ifs in the icc
   driver. You either have a RPM clock and call "rpm set rate" or you
   have a single non-RPM clock (like AHB_CLK_SRC) or you don't have any.

3. There's less overhead - instead of going through layers and layers of
   the CCF, ratesetting comes down to calling max() and sending a single
   RPM message. ICC is very very dynamic so that's a big plus.

The clocks still need to be vaguely described in the clk-smd-rpm driver,
as it gives them an initial kickoff, before actually telling RPM to
enable DVFS scaling.  After RPM receives that command, all clocks that
have not been assigned a rate are considered unused and are shut down
in hardware, leading to the same issue as described in point 1.

We can consider marking them __initconst in the future, but this series
is very fat even without that..

Apart from that, it squashes a couple of bugs that really need fixing..

--- MERGING STRATEGY ---
If Stephen and Georgi agree, it would be best to take all of this through
the qcom tree, as it touches on heavily intertwined components and
introduces compile-time dependencies between icc and clk drivers.

Tested on SM6375 (OOT), MSM8998 (OOT), MSM8996.

MSM8974 conversion to common code and modernization will be handled separately.

Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
---
Konrad Dybcio (20):
      soc: qcom: smd-rpm: Add QCOM_SMD_RPM_STATE_NUM
      clk: qcom: smd-rpm: Move some RPM resources to the common header
      clk: qcom: smd-rpm: Separate out interconnect bus clocks
      clk: qcom: smd-rpm: Export clock scaling availability
      interconnect: qcom: icc-rpm: Introduce keep_alive
      interconnect: qcom: icc-rpm: Allow negative QoS offset
      interconnect: qcom: Fold smd-rpm.h into icc-rpm.h
      interconnect: qcom: smd-rpm: Add rpmcc handling skeleton code
      interconnect: qcom: Add missing headers in icc-rpm.h
      interconnect: qcom: Define RPM bus clocks
      interconnect: qcom: sdm660: Hook up RPM bus clk definitions
      interconnect: qcom: msm8996: Hook up RPM bus clk definitions
      interconnect: qcom: qcs404: Hook up RPM bus clk definitions
      interconnect: qcom: msm8939: Hook up RPM bus clk definitions
      interconnect: qcom: msm8916: Hook up RPM bus clk definitions
      interconnect: qcom: qcm2290: Hook up RPM bus clk definitions
      interconnect: qcom: icc-rpm: Control bus rpmcc from icc
      interconnect: qcom: icc-rpm: Fix bucket number
      interconnect: qcom: icc-rpm: Set bandwidth on both contexts
      interconnect: qcom: Divide clk rate by src node bus width

 drivers/clk/qcom/clk-smd-rpm.c             | 300 ++++++++++++-----------------
 drivers/interconnect/qcom/Makefile         |   2 +-
 drivers/interconnect/qcom/icc-rpm-clocks.c |  66 +++++++
 drivers/interconnect/qcom/icc-rpm.c        | 183 ++++++++++--------
 drivers/interconnect/qcom/icc-rpm.h        |  55 ++++--
 drivers/interconnect/qcom/msm8916.c        |   4 +-
 drivers/interconnect/qcom/msm8939.c        |   5 +-
 drivers/interconnect/qcom/msm8974.c        |   2 +-
 drivers/interconnect/qcom/msm8996.c        |   9 +-
 drivers/interconnect/qcom/qcm2290.c        |   7 +-
 drivers/interconnect/qcom/qcs404.c         |   4 +-
 drivers/interconnect/qcom/sdm660.c         |   7 +-
 drivers/interconnect/qcom/smd-rpm.c        |  39 +++-
 drivers/interconnect/qcom/smd-rpm.h        |  15 --
 include/linux/soc/qcom/smd-rpm.h           |  22 ++-
 15 files changed, 424 insertions(+), 296 deletions(-)
---
base-commit: 8c33787278ca8db73ad7d23f932c8c39b9f6e543
change-id: 20230526-topic-smd_icc-b8213948a5ed

Best regards,
-- 
Konrad Dybcio <konrad.dybcio@linaro.org>

