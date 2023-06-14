Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6F96D73069C
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Jun 2023 20:04:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234371AbjFNSEl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Jun 2023 14:04:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37370 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231723AbjFNSEi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Jun 2023 14:04:38 -0400
Received: from mail-lf1-x12d.google.com (mail-lf1-x12d.google.com [IPv6:2a00:1450:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B4D71FCA
        for <linux-kernel@vger.kernel.org>; Wed, 14 Jun 2023 11:04:36 -0700 (PDT)
Received: by mail-lf1-x12d.google.com with SMTP id 2adb3069b0e04-4f4b2bc1565so9035639e87.2
        for <linux-kernel@vger.kernel.org>; Wed, 14 Jun 2023 11:04:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1686765875; x=1689357875;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=bog4gp9IhAVDvicWdI6GPIr4GVAQWTg0cHq5IKswNFk=;
        b=Cj+kfzZrrM/ZWqq4BcJF4oRr0xz8aECNTiha8VP6xM8nBur/+kL7C1O1pn11SBWwxx
         VLj0mH5B+XcgsOtbpMJIA9FRIq7T++hm0TK6/3maKHS2KnPBgEPY8WXhPRcwnljw3rCm
         UaALuKJSlLsTHlczaIxUXd2P/kMisBkJxN63bKrXdeolnXpoIUzbYqyB88umPHNUVLJc
         XbVOHMr9DVwz+vMZVbmg4AwhYgPGC1GFZSID2j16WHG2+er/QKY/BLJdaClykPXjTAV4
         hJpWyTNMkTg9HELkMRL1/QG6/6yhp2De6o9AipeFDncEhl/rcJODtJhR9VAXsHaK4N3a
         Txag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686765875; x=1689357875;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=bog4gp9IhAVDvicWdI6GPIr4GVAQWTg0cHq5IKswNFk=;
        b=a4yP+toGtptjpJv1qFFvFqfG1Kh730XkdyMYmhyyLQiIFlFf1VaXta309nbSaUH8us
         owIZypxCAlkMSOYr3QVScpQBeGk26Jx+QJncheHGcLZaSGLCY/8As6jl0E7uuMS38iSZ
         Zf0FK3orUts6wHTI+DVxIHlghez+uQgasYf+GySrpRghywlosZoaZLuQAs5m6hI9CwVt
         xxV2dK4D85QlZOuJBAz2vaLtzTEEabzydo4n+DbS5Ag7NbWoJ6dVRrH1vlUhSZcdZpq+
         6bZ+DpCHweBIu9yA3wBxGh5AYEG7cbd5YzZ2URHw0zLWPtwCUv5mplRhTiYY4hVmBThW
         WCMg==
X-Gm-Message-State: AC+VfDy80jwkK98/qrCVT7mMig1AzDmv6BsFRCDxbmvagmyrUkFEpARs
        DaeLjtCkV+qHCaOdtc2kO+QReA==
X-Google-Smtp-Source: ACHHUZ7axmEeaXNrGJVWIh8JHp3aZg1tJeDGzERk4LkPCA+q9ZmyjdjxZJoIQmV12vK+tAg3VJJSFg==
X-Received: by 2002:a19:5f0e:0:b0:4f4:d83e:4141 with SMTP id t14-20020a195f0e000000b004f4d83e4141mr9350421lfb.50.1686765874578;
        Wed, 14 Jun 2023 11:04:34 -0700 (PDT)
Received: from [192.168.1.101] (abyj190.neoplus.adsl.tpnet.pl. [83.9.29.190])
        by smtp.gmail.com with ESMTPSA id l18-20020a19c212000000b004eff1f7f206sm2224053lfc.9.2023.06.14.11.04.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Jun 2023 11:04:34 -0700 (PDT)
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
Subject: [PATCH v6 00/22] Restructure RPM SMD ICC
Date:   Wed, 14 Jun 2023 20:04:19 +0200
Message-Id: <20230526-topic-smd_icc-v6-0-263283111e66@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIACMBimQC/33PTWrDMBAF4KsErauif8td9R4lFI00igWuFKTUp
 ATfvXJ2xdTLN/C9mXmQhjVhI2+nB6m4pJZK7sG8nIifXL4gTaFnIpiQTAtDb+WaPG1f4TN5T8E
 KLkdlncZAugHXkEJ12U9d5e957sNrxZjuzyUf556n1G6l/jx3Lnyb/le/cMooh2jRGCO9wvc5Z
 VfLa6kXslUt4pCLzlGPUgEbguVyx+Uhl53rCEOQI9hBxR1Xh1xtHJwVYCKAEzuuD7nejkfn2Bg
 Ys+Lv7+u6/gIc6v//vAEAAA==
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
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Stephan Gerhold <stephan@gerhold.net>
X-Mailer: b4 0.12.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1686765872; l=6624;
 i=konrad.dybcio@linaro.org; s=20230215; h=from:subject:message-id;
 bh=G4+hKUovQ8Bf7Uod3WWsfrhuUqaphsYJEe+4h0gILuE=;
 b=il5VF/nWI+73x6ieMVF2AR8DQQaJa2w6T3+QYLzE6gXCwIsvcsuC6DuRQjgfze8r17qMidTk4
 9y0Sh9Ov4cHDzc51wMDPNCZ9xdLGlTCapljYWNX/wxqrAonqdfsAK6+
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
Changes in v6:
- Fix argument naming in "Add rpmcc handling skeleton code"
- Fix missing clk.h and reorder patch "Add missing headers in icc-rpm.h",
  drop Dmitry's rb
- Pick up tags
- Link to v5: https://lore.kernel.org/r/20230526-topic-smd_icc-v5-0-eeaa09d0082e@linaro.org

Changes in v5:
- Pass RPM context id to qcom_icc_rpm_set_bus_rate()
- Fix min_t call cutting off bits 32-63 in set() path
- Pick up tags
- Link to v4: https://lore.kernel.org/r/20230526-topic-smd_icc-v4-0-5ba82b6fbba2@linaro.org

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
      interconnect: qcom: Add missing headers in icc-rpm.h
      interconnect: qcom: Fold smd-rpm.h into icc-rpm.h
      interconnect: qcom: smd-rpm: Add rpmcc handling skeleton code
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
 drivers/interconnect/qcom/icc-rpm.c             | 220 +++++++++--------
 drivers/interconnect/qcom/icc-rpm.h             |  56 ++++-
 drivers/interconnect/qcom/msm8916.c             |   5 +-
 drivers/interconnect/qcom/msm8939.c             |   6 +-
 drivers/interconnect/qcom/msm8974.c             |   2 +-
 drivers/interconnect/qcom/msm8996.c             |  10 +-
 drivers/interconnect/qcom/qcm2290.c             |   8 +-
 drivers/interconnect/qcom/qcs404.c              |   5 +-
 drivers/interconnect/qcom/sdm660.c              |   8 +-
 drivers/interconnect/qcom/smd-rpm.c             |  23 +-
 drivers/interconnect/qcom/smd-rpm.h             |  15 --
 drivers/soc/qcom/smd-rpm.c                      |  17 +-
 include/dt-bindings/interconnect/qcom,rpm-icc.h |  13 +
 include/linux/soc/qcom/smd-rpm.h                |  20 +-
 17 files changed, 455 insertions(+), 344 deletions(-)
---
base-commit: b16049b21162bb649cdd8519642a35972b7910fe
change-id: 20230526-topic-smd_icc-b8213948a5ed

Best regards,
-- 
Konrad Dybcio <konrad.dybcio@linaro.org>

