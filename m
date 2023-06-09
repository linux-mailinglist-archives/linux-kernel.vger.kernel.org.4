Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 93E2772A44B
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Jun 2023 22:19:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231739AbjFIUTW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Jun 2023 16:19:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60512 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231352AbjFIUTT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Jun 2023 16:19:19 -0400
Received: from mail-lf1-x132.google.com (mail-lf1-x132.google.com [IPv6:2a00:1450:4864:20::132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 19706E4E
        for <linux-kernel@vger.kernel.org>; Fri,  9 Jun 2023 13:19:17 -0700 (PDT)
Received: by mail-lf1-x132.google.com with SMTP id 2adb3069b0e04-4f65779894eso1832733e87.1
        for <linux-kernel@vger.kernel.org>; Fri, 09 Jun 2023 13:19:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1686341955; x=1688933955;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=sdIYwlKceBgYC+N9fRwUszhw4BX6aPSp6RBZQ9P/Ti0=;
        b=lj8wWKoQnVy/VhgfQD/y/wYw3AIRhMFsHIMX4SLLjnph/cUMDy1gGhn/LnWEPsMZw2
         eWVMTliGbNF12XEfXd5tJItarl4M+G+X9Z2FgkQIE4xunFwVw3Qk9XMHiht6lqNJCB+w
         u1sXE+AMQvlGG6mukyut4YMt3+c3Ci40IjCzQC3oVuLbX0STxJQJxWIpH43Bed/1xNmk
         HV1a4njPusA/VMPNoSFJWD9spQN8Uv9tKXBCJDrUpZZIvtfqHo5JDKHBHl1lJurwoEfZ
         jL+y18fEuHRvqx8/qdJupdMSWNhomR5aqiPD1HrstjSBNBxjamPLhKOzNIR+guRq+Pum
         UYEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686341955; x=1688933955;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=sdIYwlKceBgYC+N9fRwUszhw4BX6aPSp6RBZQ9P/Ti0=;
        b=UAoOaGHjIREQUbKvTQY5t5C9hh+lyKs0TcYC7Gj0KMwHdb470qU1RkOK9GLUKFbtyR
         AdnY/1EmP6m1aS73mcZxKNs4e353Z7Gc3Fg1ZmPkrQH2sPVXjWukGv0xgNtEa8cwWqj3
         LkvuQZBCB78xzRr9COzBVfnlsJe1BgJ01lFTC35S/GBudMEZU2S+vlBkzeMCKCt40zLa
         nAgt0ki8VAmDwNgN6ILzQ05H8/rJMm6OOLTIOz14ibTjJbKoPDQFESljGU+WnxivASw9
         2ur0upOs9jG9Ayik7DQTqTbPxkxNm9pOfWNNpUrY+rlpvN2hJVBxzywfpLrllr93gS+B
         nrhQ==
X-Gm-Message-State: AC+VfDz/7HZpcAmjdanK7lutuU9iZyoHQ1DbufMm7Jpfsgf1Bs5VGESp
        CNNxlXJPOY1dmxOVcbpU4QecwQ==
X-Google-Smtp-Source: ACHHUZ729FgVImbP3+bzW2KIwIhxOihS91E/smBNxVZQRhhzqLQMpg2ARlb0bzpFKIOZ/D5ZXZKIjg==
X-Received: by 2002:a05:6512:3e15:b0:4f3:a526:6fd2 with SMTP id i21-20020a0565123e1500b004f3a5266fd2mr949318lfv.16.1686341955299;
        Fri, 09 Jun 2023 13:19:15 -0700 (PDT)
Received: from [192.168.1.101] (abyj190.neoplus.adsl.tpnet.pl. [83.9.29.190])
        by smtp.gmail.com with ESMTPSA id b18-20020ac25632000000b004f628eb7884sm641349lff.232.2023.06.09.13.19.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Jun 2023 13:19:14 -0700 (PDT)
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
Subject: [PATCH v2 00/22] Restructure RPM SMD ICC
Date:   Fri, 09 Jun 2023 22:19:05 +0200
Message-Id: <20230526-topic-smd_icc-v2-0-e5934b07d813@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIADmJg2QC/3WNQQ6CMBBFr0JmbQ0t0KAr72GIacsAk2BLpkg0p
 He3snf5XvL/2yEiE0a4FjswbhQp+AzqVICbjB9RUJ8ZVKmqslFarGEhJ+Kzf5BzwrZKVpe6NQ3
 2kDfWRBSWjXdTXvnXPGe5MA70PiL3LvNEcQ38OZqb/Nl/95sUpZB2aFFrXbkabzN5w+EceIQup
 fQF8a0zZ8AAAAA=
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Georgi Djakov <djakov@kernel.org>,
        Leo Yan <leo.yan@linaro.org>, Evan Green <evgreen@chromium.org>
Cc:     Marijn Suijten <marijn.suijten@somainline.org>,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-clk@vger.kernel.org, linux-pm@vger.kernel.org,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Stephan Gerhold <stephan@gerhold.net>
X-Mailer: b4 0.12.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1686341953; l=4861;
 i=konrad.dybcio@linaro.org; s=20230215; h=from:subject:message-id;
 bh=vFiP9vIROTYaXe+Eii+OPNiUwBo8phYnrkzg7uqdXO4=;
 b=aQb1MqVaJPPweVfLXQf5tt30v5CfFPMcwoUcfa4luWwSvMgeZNgEgQad7bnKDHw0uDdopSDd3
 d8nB+ab8YGyCKKn5yXSwvEvho0dNxxQbaLGldKqGZkblbx2boPGEk+u
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
Changes in v2:
- Sort entries properly in "Add missing headers in icc-rpm.h"
- Fix the check for no clocks on a given provider
- Replace "Divide clk rate by src node bus width" with a proper fix
- Add "Set correct bandwidth through RPM bw req"
- Split "Add QCOM_SMD_RPM_STATE_NUM" into 2 logical changes
- Move "Separate out interconnect bus clocks" a bit later in the series
- Link to v1: https://lore.kernel.org/r/20230526-topic-smd_icc-v1-0-1bf8e6663c4e@linaro.org

---
Konrad Dybcio (22):
      soc: qcom: smd-rpm: Add QCOM_SMD_RPM_STATE_NUM
      soc: qcom: smd-rpm: Use tabs for defines
      clk: qcom: smd-rpm: Move some RPM resources to the common header
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
      clk: qcom: smd-rpm: Separate out interconnect bus clocks
      interconnect: qcom: icc-rpm: Fix bucket number
      interconnect: qcom: icc-rpm: Set bandwidth on both contexts
      interconnect: qcom: icc-rpm: Set correct bandwidth through RPM bw req
      interconnect: qcom: icc-rpm: Fix bandwidth calculations

 drivers/clk/qcom/clk-smd-rpm.c             | 300 ++++++++++++-----------------
 drivers/interconnect/qcom/Makefile         |   2 +-
 drivers/interconnect/qcom/icc-rpm-clocks.c |  66 +++++++
 drivers/interconnect/qcom/icc-rpm.c        | 212 ++++++++++----------
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
 15 files changed, 427 insertions(+), 322 deletions(-)
---
base-commit: 53ab6975c12d1ad86c599a8927e8c698b144d669
change-id: 20230526-topic-smd_icc-b8213948a5ed

Best regards,
-- 
Konrad Dybcio <konrad.dybcio@linaro.org>

