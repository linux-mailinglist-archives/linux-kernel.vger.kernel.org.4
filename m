Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8A6D272E4D2
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Jun 2023 16:03:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242530AbjFMODP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Jun 2023 10:03:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57026 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239955AbjFMODL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Jun 2023 10:03:11 -0400
Received: from mail-lj1-x229.google.com (mail-lj1-x229.google.com [IPv6:2a00:1450:4864:20::229])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C0A21F4
        for <linux-kernel@vger.kernel.org>; Tue, 13 Jun 2023 07:03:09 -0700 (PDT)
Received: by mail-lj1-x229.google.com with SMTP id 38308e7fff4ca-2b1b8593263so68036051fa.2
        for <linux-kernel@vger.kernel.org>; Tue, 13 Jun 2023 07:03:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1686664988; x=1689256988;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=fgkWRSFPd0yuD0FGNaR13nds2yAxVTwu7JL5XkNXpyk=;
        b=zHRXGuIuBd+yORTqRycH2QnjeEOxY2V7UnUyoRU01wMPDcAx3F1buHnlmfPm0uOy2N
         6f8vCg/96QYp7+M9m8cVxHbr8m5kkkXMjub5BvRNov0Lg2OL18nUhqtPy9ZoMK3x6l7o
         9H9NuFEtjDhNUOE7Ly3X64OT+MMlIu9zCOHihcabAfZwYqpEbHOnNiZyxZd92urL3yH0
         k8SfpVvmrS4tqu2470z1qpe/7zPMZo+eHrUhR9RS2thNnsksRB1AN4dlrjI4nK/SHCPM
         imGT5XGydOjhpeFjmz4O5l28uyhU637HwYZ1mJDN9YLizOXB9EVhhx3hb7y/0SDDA4lB
         0GAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686664988; x=1689256988;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=fgkWRSFPd0yuD0FGNaR13nds2yAxVTwu7JL5XkNXpyk=;
        b=ApqO8YcvSeDf0umIePbdqCSVLmSYLRxgSDf3rosxTxkHNXGvphXDA/Ybe79UFkCann
         kLDTzXTgv1CL90xvYfyZYehmxWp8My5qh0jTWKpyXc0Vd6aS4R/LDAUASz9JKvEeoHxQ
         eo3DNnSwL10KxyknNMf8Mz++s72zOr80DiKrl/Uz1QTMsyCIql+aAirDWRXGGK0IoC99
         7WwJttr1IoneSnLcisF7eNx74iofttSwhwIN9Sx5sZLxXLUIrCU3PUja5adEs2x2+4/Q
         EbqSQVRa2EV7Q1m/CfL+TVVXaKLuFLNGWiv9kmCTDiWY2itrggBpfWtwlCM+REM/PIFX
         h/aQ==
X-Gm-Message-State: AC+VfDwJBJZ32GVZwZbZwZzpP8WrJ7xP1ywEbY+t40Mb//TkwsUX+EKh
        yVZzfECQfE1BTPubE+J/VR2B0w==
X-Google-Smtp-Source: ACHHUZ6zTU5wN3YPGfxLYadXb5CUKxNEAqCy7iL6N7ZCNbxg6Ynd/e9WzAiE+zpbR9yKsCfY2xEUiQ==
X-Received: by 2002:a2e:6a09:0:b0:2b1:ecac:91d3 with SMTP id f9-20020a2e6a09000000b002b1ecac91d3mr4570823ljc.25.1686664987908;
        Tue, 13 Jun 2023 07:03:07 -0700 (PDT)
Received: from [192.168.1.101] (abyj190.neoplus.adsl.tpnet.pl. [83.9.29.190])
        by smtp.gmail.com with ESMTPSA id a18-20020a05651c011200b002b32af2e9c6sm901490ljb.116.2023.06.13.07.03.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Jun 2023 07:03:07 -0700 (PDT)
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
Subject: [PATCH v4 00/22] Restructure RPM SMD ICC
Date:   Tue, 13 Jun 2023 16:03:00 +0200
Message-Id: <20230526-topic-smd_icc-v4-0-5ba82b6fbba2@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIABR3iGQC/33NywrCMBQE0F+RrI00j7apK/9DRPK4tRdqUpIal
 NJ/N7oT0eUMnJmFJIgIiew3C4mQMWHwJcjththB+wtQdCUTXnFR1byhc5jQ0nR1Z7SWGsWZ6KT
 SNThSjNEJqIna26EofxvHUk4Rery/T46nkgdMc4iP92dmr/bXfGa0osz0CpqmEVbCYUSvY9iFe
 CGvqcz/cl441J2QpmqdYuKLi79cFF73pnWiM6qV/Qdf1/UJcZ4+kj4BAAA=
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Georgi Djakov <djakov@kernel.org>,
        Leo Yan <leo.yan@linaro.org>,
        Evan Green <evgreen@chromium.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>
Cc:     Marijn Suijten <marijn.suijten@somainline.org>,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-clk@vger.kernel.org, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Stephan Gerhold <stephan@gerhold.net>
X-Mailer: b4 0.12.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1686664985; l=6104;
 i=konrad.dybcio@linaro.org; s=20230215; h=from:subject:message-id;
 bh=f4ve/r5dOx6VGwd2ZbygUbCzlofyl0BUKmt3Opqvf44=;
 b=2ywBgLO92trnU5XePfddi6Ac6Xr37EsS/ZjMv8v03lI4L7b66oU2vmCijK3IQHzZg/qS8W0FR
 OhBh3P95LsbBkxQ6PcJzeop4KXcVbTyGQbj6skmFziRj8SCwW1ryzLK
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
Changes in v4:
- Only set clk rate on a context if necessary
- Mention qcom,icc.h is not the correct header in "Control bus rpmcc form icc"
- Fix the bindings (BIT vs 1<<)
- Fix one more wrong use of qcom,icc.h in "Fix bucket numer" and uninclude it
- Drop "Allow negative QoS offset" (will be handled separately)
- Export icc clocks descriptions to unbreak =m builds
- Pick up tags
- Link to v3: https://lore.kernel.org/r/20230526-topic-smd_icc-v3-0-5fb7d39b874f@linaro.org

Changes in v3:
- Use devm_clk_get_optional and only get() the clock once
- Drop unnecessary NULL-checks for qp->bus_clk
- Handle ARM32 CCF limitations, add an explicit comment about them
- Use Stephan's alternative rpmcc readiness check
- Fix one more wrong usage of QCOM_ICC_NUM_BUCKETS in icc-rpm.h
- Introduce new dt-bindings for icc rpm tags
- Mention the rpm tags situation in the commit message of
  "Fix bucket number"
- Pick up tags
- Link to v2: https://lore.kernel.org/r/20230526-topic-smd_icc-v2-0-e5934b07d813@linaro.org

Changes in v2:
- Sort entries properly in "Add missing headers in icc-rpm.h"
- Fix the check for no clocks on a given provider
- Replace "Divide clk rate by src node bus width" with a proper fix
- Add "Set correct bandwidth through RPM bw req"
- Split "Add QCOM_SMD_RPM_STATE_NUM" into 2 logical changes
- Move "Separate out interconnect bus clocks" a bit later in the series
- Link to v1: https://lore.kernel.org/r/20230526-topic-smd_icc-v1-0-1bf8e6663c4e@linaro.org

---
Konrad Dybcio (21):
      dt-bindings: interconnect: Add Qcom RPM ICC bindings
      soc: qcom: smd-rpm: Add QCOM_SMD_RPM_STATE_NUM
      soc: qcom: smd-rpm: Use tabs for defines
      clk: qcom: smd-rpm: Move some RPM resources to the common header
      interconnect: qcom: icc-rpm: Introduce keep_alive
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
      clk: qcom: smd-rpm: Separate out interconnect bus clocks
      interconnect: qcom: icc-rpm: Fix bucket number
      interconnect: qcom: icc-rpm: Set bandwidth on both contexts
      interconnect: qcom: icc-rpm: Set correct bandwidth through RPM bw req
      interconnect: qcom: icc-rpm: Fix bandwidth calculations

Stephan Gerhold (1):
      soc: qcom: smd-rpm: Move icc_smd_rpm registration to clk-smd-rpm

 drivers/clk/qcom/clk-smd-rpm.c                  | 312 +++++++++++-------------
 drivers/interconnect/qcom/Makefile              |   2 +-
 drivers/interconnect/qcom/icc-rpm-clocks.c      |  77 ++++++
 drivers/interconnect/qcom/icc-rpm.c             | 217 ++++++++--------
 drivers/interconnect/qcom/icc-rpm.h             |  55 ++++-
 drivers/interconnect/qcom/msm8916.c             |   4 +-
 drivers/interconnect/qcom/msm8939.c             |   5 +-
 drivers/interconnect/qcom/msm8974.c             |   2 +-
 drivers/interconnect/qcom/msm8996.c             |   9 +-
 drivers/interconnect/qcom/qcm2290.c             |   7 +-
 drivers/interconnect/qcom/qcs404.c              |   4 +-
 drivers/interconnect/qcom/sdm660.c              |   7 +-
 drivers/interconnect/qcom/smd-rpm.c             |  24 +-
 drivers/interconnect/qcom/smd-rpm.h             |  15 --
 drivers/soc/qcom/smd-rpm.c                      |  17 +-
 include/dt-bindings/interconnect/qcom,rpm-icc.h |  13 +
 include/linux/soc/qcom/smd-rpm.h                |  20 +-
 17 files changed, 453 insertions(+), 337 deletions(-)
---
base-commit: 1f6ce8392d6ff486af5ca96df9ded5882c4b6977
change-id: 20230526-topic-smd_icc-b8213948a5ed

Best regards,
-- 
Konrad Dybcio <konrad.dybcio@linaro.org>

