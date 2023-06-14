Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C76B972FA50
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Jun 2023 12:22:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238956AbjFNKW0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Jun 2023 06:22:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34940 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238903AbjFNKWW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Jun 2023 06:22:22 -0400
Received: from mail-lj1-x229.google.com (mail-lj1-x229.google.com [IPv6:2a00:1450:4864:20::229])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 416B01BC5
        for <linux-kernel@vger.kernel.org>; Wed, 14 Jun 2023 03:22:19 -0700 (PDT)
Received: by mail-lj1-x229.google.com with SMTP id 38308e7fff4ca-2b1af9ef7a9so6851991fa.1
        for <linux-kernel@vger.kernel.org>; Wed, 14 Jun 2023 03:22:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1686738137; x=1689330137;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=szSQucIK3ncRKPsQw9RYLfCbPW0KNM9RYtqOhVqKhe4=;
        b=skOijsAw7vxYIUOFNFRQc05GDc53ZBkZe16t9R0wONa9Hy2tV6iVL0ABzGQ5x21HhA
         8DkmtIFlMxr4cljzZ6CYq22ojYR62zCogBc3n6mn8O8FlcbNMRXV3R2uQE49vVs8pTtj
         hTwoRDDlWCp8Ox3CYBUbyVP5jD60AiM4WP/3sCibDvxvvRP38tzYYS1et7eSrnpLLrYr
         0uG//CV7EDDfR3LT+rASjFxaOUAPTdJB6YuSSgcr+M4QNubSz0B1b1kQgsfm4tUc9GkR
         jkOJwF3n/VKvXDOPUvwpPjuLHKTm/l3ZcNSYNeCwgOMi3oswT1jqRePwZ2+RK/WqdM1v
         ub3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686738137; x=1689330137;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=szSQucIK3ncRKPsQw9RYLfCbPW0KNM9RYtqOhVqKhe4=;
        b=GW30mgZVoAjxDWMn1MzC9S63PjPYCQJLQhrUPBHeA54ja78B/PU65y95N2Xy57v7Ht
         e+uMZRQmVsR0TDeDOYkR9T46D42h19T4fh3aR5RD8xkJx1hOttH/N/o1s3i1tdkGw67X
         OeJEjGakb7+9qVNQLlG4p7rvN6bTdU6rv2YN6HZ9zDVfrMqvLrsP7gWYkLokoGqbqo0e
         i0c5wS1rQyTJSutvGKxY7WquLMb4j8eb2HDJZMB4KYXpfXBB6TABPQ0KXz0ksMhRZjse
         EZCy/GzHjpTj/t/pkxYksYE0Ft+qjR+eeK9Aq+futFpG9f+Q0Ydl1voUhOR6zdkl/xBJ
         3fOw==
X-Gm-Message-State: AC+VfDxyQkz7tsLF3rEN/hZUkkJsKLI30oPHOzUC/ZX5HxUvAUjsHkQX
        d4uh+SmKade3KrgxF4iq+v/lNQ==
X-Google-Smtp-Source: ACHHUZ4ZGVnY9riBZLKM8y2Gv+54qTynM3Jva+aCMsBwj4FWJM1oHbl8p8CVb5FKRBdc/JA0HnCdOw==
X-Received: by 2002:a2e:9056:0:b0:2b3:4c4b:4472 with SMTP id n22-20020a2e9056000000b002b34c4b4472mr543640ljg.47.1686738137330;
        Wed, 14 Jun 2023 03:22:17 -0700 (PDT)
Received: from [192.168.1.101] (abyj190.neoplus.adsl.tpnet.pl. [83.9.29.190])
        by smtp.gmail.com with ESMTPSA id m2-20020a2eb6c2000000b002b20d8f270asm2520057ljo.74.2023.06.14.03.22.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Jun 2023 03:22:17 -0700 (PDT)
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
Subject: [PATCH v5 00/22] Restructure RPM SMD ICC
Date:   Wed, 14 Jun 2023 12:22:11 +0200
Message-Id: <20230526-topic-smd_icc-v5-0-eeaa09d0082e@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIANOUiWQC/33NzWrDMBAE4FcJOlfF+rXcU9+jlKKVVvGCKwUpN
 S3B7145txLq4wx8MzfWsBI29nK6sYorNSq5B/N0YmH2+YycYs9MDlINRlp+LRcKvH3GDwqBg5N
 CTdp5g5F1A74hh+pzmLvKX8vSy0vFRN/3k7f3nmdq11J/7p+r2Nv/5lfBBy4gObTWqqDxdaHsa
 3ku9cz2qVUectk5mklpGMbohHrg6pCrzk2CMaoJ3KjTA9eHXO8cvJNgE4CXf/i2bb9Tt50LfQE
 AAA==
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1686738135; l=6341;
 i=konrad.dybcio@linaro.org; s=20230215; h=from:subject:message-id;
 bh=CNEGFScbum+K4IB2q7UcAHiJ+m57fesNvbD3iZfECoQ=;
 b=FfFoOdYP/+LcgUZcj6qhsIkyOy09MqmocdvHR1A6F6h/g3rQO6LMe+EmxaPLi7wZXV+Wy54pn
 +YvA6g2mYUQD5m9wcZWnGLpTHpjf5/oggDMsEGzoDM/z3ZgFdLbE+N/
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
 drivers/interconnect/qcom/icc-rpm.c             | 219 +++++++++--------
 drivers/interconnect/qcom/icc-rpm.h             |  55 ++++-
 drivers/interconnect/qcom/msm8916.c             |   4 +-
 drivers/interconnect/qcom/msm8939.c             |   5 +-
 drivers/interconnect/qcom/msm8974.c             |   2 +-
 drivers/interconnect/qcom/msm8996.c             |   9 +-
 drivers/interconnect/qcom/qcm2290.c             |   7 +-
 drivers/interconnect/qcom/qcs404.c              |   4 +-
 drivers/interconnect/qcom/sdm660.c              |   7 +-
 drivers/interconnect/qcom/smd-rpm.c             |  23 +-
 drivers/interconnect/qcom/smd-rpm.h             |  15 --
 drivers/soc/qcom/smd-rpm.c                      |  17 +-
 include/dt-bindings/interconnect/qcom,rpm-icc.h |  13 +
 include/linux/soc/qcom/smd-rpm.h                |  20 +-
 17 files changed, 454 insertions(+), 337 deletions(-)
---
base-commit: 1f6ce8392d6ff486af5ca96df9ded5882c4b6977
change-id: 20230526-topic-smd_icc-b8213948a5ed

Best regards,
-- 
Konrad Dybcio <konrad.dybcio@linaro.org>

