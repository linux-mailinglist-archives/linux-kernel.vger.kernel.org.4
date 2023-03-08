Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 75BAE6B13F7
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Mar 2023 22:35:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230019AbjCHVfr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Mar 2023 16:35:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52368 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229952AbjCHVfp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Mar 2023 16:35:45 -0500
Received: from mail-lf1-x133.google.com (mail-lf1-x133.google.com [IPv6:2a00:1450:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2BDB2B4F6B
        for <linux-kernel@vger.kernel.org>; Wed,  8 Mar 2023 13:35:38 -0800 (PST)
Received: by mail-lf1-x133.google.com with SMTP id t11so23133061lfr.1
        for <linux-kernel@vger.kernel.org>; Wed, 08 Mar 2023 13:35:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1678311336;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Yx3K8KXfYeN1w6FBBGidGftrh4dFPASfNQz/HmCNuJ8=;
        b=Ul/itAD16p+95xv4fGh1OJ/KR0f+oFGvCtotcuPrQfa9VgDxo/A1SAp8F8YDoqwI74
         lVMCy44wkwYFZrHNnvBe7mF09/7GMZMXoTLpoUXWyZo8B1i1HmY/AC3OF87f+JEf4iho
         /pyGCdDxL79VrH9tEx0hkVm7r3OdTo5f2D3FUuLW5N8v1z4i2Th7+amOUygNV/x1K2/E
         mkQ+DWU8tI9DkyWqZfrkoD57JA8JBgHiPiLEFmGJsFPuDgZjRwfqmdjevLUjoKhsokZI
         7S2Alegth4zMb/Kuw56A3tsYZSlvVVSwloT8xA/mMBLH+oZwXUxfQfaN3MmSnihcj8G3
         mxOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678311336;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Yx3K8KXfYeN1w6FBBGidGftrh4dFPASfNQz/HmCNuJ8=;
        b=X9K4ioy7jwZGBDyQ4csqnLLorMLOnUBgCrwMMQtsV5ZiHhuwwldXSuh9PF8q1PYqYE
         MMahbueLKfMo69JtG00cmLljjaKoqBjoXnjbkuQeqxPP/UkvicI8LhAkl1PENTeyj8DE
         mzLl/yv45SYSdmK7U7wjeMhOp1XKD3Y6jZdZYaRP09VKUc1EEcpZWNOO18klZNHcYUQ5
         vMUhEkVxuqbNDEncfwfGsxGsNHW8VdlbkQacASuJAieJ7E0j8ohJjH4Hf6CaawDBx5uO
         6XHk1eIJvncISrE630r57+Hlx4O4AFW/J7OOAMJRHpS32gNqN3dG2GhYJ960riEJul0Q
         uFhA==
X-Gm-Message-State: AO0yUKXV+yKgpUeywsLgpHWrLVkR8wTQjLnrG9Dq8hORRykrhiooiQp2
        vIY3yY5zbJ6hzkvr8Yo8+04UEA==
X-Google-Smtp-Source: AK7set/DjKLJA19+zcHCwu+AW5vV0IYu8eoUU+rBhf2JR453NmNf/hM7fz8BUXz4HDuZGxsjiI4ESQ==
X-Received: by 2002:ac2:48a7:0:b0:4da:ae47:6615 with SMTP id u7-20020ac248a7000000b004daae476615mr5800547lfg.49.1678311336396;
        Wed, 08 Mar 2023 13:35:36 -0800 (PST)
Received: from [192.168.1.101] (abyj16.neoplus.adsl.tpnet.pl. [83.9.29.16])
        by smtp.gmail.com with ESMTPSA id u7-20020ac243c7000000b004dc4d26c324sm2467479lfl.143.2023.03.08.13.35.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Mar 2023 13:35:35 -0800 (PST)
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
Subject: [PATCH RFT v2 00/14] SMD RPMCC sleep preparations
Date:   Wed, 08 Mar 2023 22:35:16 +0100
Message-Id: <20230303-topic-rpmcc_sleep-v2-0-ae80a325fe94@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAJT/CGQC/32NQQrCMBBFr1JmbSRNwVJXrjyAuJMi02TSBmISJ
 rUopXc39ADyV+9/Pm+FTOwow7lagWlx2cVQQB0q0BOGkYQzhUFJ1cgSMcfktOD00vqZPVES5tQ
 ims42slZQfgNmEgNj0FN5hrf3pUxM1n120QNu1zv0pZxcniN/d/lS79Mfz1ILKUynLdpuUC22F
 +8CcjxGHqHftu0HCyZurc0AAAA=
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        devicetree@vger.kernel.org,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Shawn Guo <shawn.guo@linaro.org>,
        Taniya Das <quic_tdas@quicinc.com>
X-Mailer: b4 0.12.1
X-Developer-Signature: v=1; a=ed25519-sha256; t=1678311334; l=2646;
 i=konrad.dybcio@linaro.org; s=20230215; h=from:subject:message-id;
 bh=ag6sS2vNWieo5YFXrKuNAA3nF1wtvbbIdfAZ+4LnBg4=;
 b=872IBcUN9ZTJYbHMIDpj9icWsfsYZZXpj4dUIVgvkburRlwinDvLaWezNUvaqPTK6LEF2H5Gj73+
 FO+gbPVbBcZRRL+aTA/MEpZhZWRq3u23wIVoPxogJ9LsAbIBCrES
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

v1 -> v2:
- Use CLK_IS_CRITICAL instead of leaving a clk enable vote, expand macros
  to do so
- Fix the keepalive clocks for 8998 & 660 (CNoC -> PNoC, it was
  confusingly named cnoc_periph downstream)
- Introduce .determinte_rate to ensure we don't set keepalive clocks'
  rates below 19.2 MHz
- Add a (!conditional!) way to test the ultimate goal of all these changes
  by essentially enabling unused clk cleanup through a dt property (for
  legacy reasons)

v2 was tested on:

- MSM8996 Sony Kagura (can disable unused)
- MSM8998 Sony Maple (can disable unused with OOT icc)
- SM6375 Sony PDX225 (can disable unused with OOT icc)

v1: https://lore.kernel.org/r/20230303-topic-rpmcc_sleep-v1-0-d9cfaf9b27a7@linaro.org

This series brings support for a couple of things necessary for the full
system idle on SMD RPM SoCs, namely unused clk shutdown and keepalive
votes (permanent active votes that are required on certain clocks for the
platform to function).

Tested on MSM8996 and SM6375, does not seem to introduce any additional
regressions.

Keepalive clocks for other platforms were gathered by digging in old
downstream kernels, please give them a test.

Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
---
Konrad Dybcio (11):
      dt-bindings: clock: qcom,rpmcc: Add a way to enable unused clock cleanup
      clk: qcom: smd-rpm_ Make __DEFINE_CLK_SMD_RPM_BRANCH_PREFIX accept flags
      clk: qcom: smd-rpm: Make DEFINE_CLK_SMD_RPM_BRANCH_A accept flags
      clk: qcom: smd-rpm: Make BI_TCXO_AO critical
      clk: qcom: smd-rpm: Make __DEFINE_CLK_SMD_RPM_PREFIX accept flags
      clk: qcom: smd-rpm: Separate out a macro for defining an AO clock
      clk: qcom: smd-rpm: Add support for keepalive votes
      clk: qcom: smd-rpm: Introduce DEFINE_CLK_SMD_RPM_BUS_KEEPALIVE
      clk: qcom: smd-rpm: Hook up PCNoC_0 keep_alive
      clk: qcom: smd-rpm: Hook up CNoC_1 and SNoC_2 keep_alive
      arm64: dts: qcom: msm8996: Enable rpmcc unused clk disablement

Shawn Guo (3):
      clk: qcom: smd-rpm: Add .is_enabled hook
      clk: qcom: smd-rpm: Add .is_prepared hook
      clk: qcom: smd-rpm: Mark clock enabled in clk_smd_rpm_handoff()

 .../devicetree/bindings/clock/qcom,rpmcc.yaml      |   6 +
 arch/arm64/boot/dts/qcom/msm8996.dtsi              |   1 +
 drivers/clk/qcom/clk-smd-rpm.c                     | 133 +++++++++++++++------
 3 files changed, 106 insertions(+), 34 deletions(-)
---
base-commit: fc31900c948610e7b5c2f15fb7795832c8325327
change-id: 20230303-topic-rpmcc_sleep-d67aad9f3012

Best regards,
-- 
Konrad Dybcio <konrad.dybcio@linaro.org>

