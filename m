Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D9D6C74621A
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jul 2023 20:20:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230167AbjGCSUP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Jul 2023 14:20:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42656 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229980AbjGCSUN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Jul 2023 14:20:13 -0400
Received: from mail-lj1-x22a.google.com (mail-lj1-x22a.google.com [IPv6:2a00:1450:4864:20::22a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C695E5B
        for <linux-kernel@vger.kernel.org>; Mon,  3 Jul 2023 11:20:11 -0700 (PDT)
Received: by mail-lj1-x22a.google.com with SMTP id 38308e7fff4ca-2b5c2433134so59915511fa.0
        for <linux-kernel@vger.kernel.org>; Mon, 03 Jul 2023 11:20:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1688408409; x=1691000409;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=3709e8fFO7E8llHUHqUI0y08/wPoh5pT/hkxw+53yrA=;
        b=xlbJbUEX5Yd1k6PCD+ZYtC53K72Yd0PHdVCAy7vEuq16XkVIL+lMFsFw1n3acu0oFf
         QphUw8hLNrjcSvp2kR/WRKI+Sef2rfV8uiwOhQU3wzzxED5dwcKZN2IPmJTKHzYV0W8g
         XHaOPq4MvvRet0J9Bf+zA/UFQeKCqPCR2yW9BXduaILBZzKM1KalFbfxmnKzeGFk+2wl
         1QpUAfJKXc6SOUKEaceuiswtw6j6fxph55L30BEj9VWgWEdYqtMOCY3ZeSTvVz4hrfyx
         qbK2+7tNF68yqWQsme5hygBypd0PFZX+tcIMKdpQM9w/ktCgn8qJYnnktuz+VeBuv9i+
         c94w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688408409; x=1691000409;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=3709e8fFO7E8llHUHqUI0y08/wPoh5pT/hkxw+53yrA=;
        b=MuAJbMkhL6DLcYBYWH+LGL4JzW9C7vhAhelvhR+IG0fHtoqJ20kb6fHGX7GW6dT6rl
         wtddKUTf2uVL+ekiskXHAvTJipBIvQSUHGbU8qB33hcnXPzNrYytchL4iqtyVoz8JQYN
         doYRZZGKiXynkz4Z3CLuJpIWCuGBbbEVf1n3RGHXbc1Vl5WKqaVL+KtR4ApVEiH/sxr8
         8pkoZC+u4TlfxyR+gUtMn1fWZ1u67DkXR1L0BpPJDA5pR2qnSiD6ipyrtwHdwAu4xElQ
         YMxXIzl1JCvy+eFQYmQNdmjRLGREEoqVSGiqvZrHwZKJB2N65Cwr9JvaGBPIkwf/oUvv
         BIew==
X-Gm-Message-State: ABy/qLb9LmQxb0RurlHopq/K0NTUH/4qusJLpyfRLh+S2zNFw39bmHvA
        DyzhhZ3ISQx2rQ/wtx1zAER255jrr5TN9hJbVEgaNA==
X-Google-Smtp-Source: APBJJlGlQkOPQixu2L4tRQl8VLKaygBQZqyviz+FiZtst2YTgudx5n1zzFiZEjQMQEy/J956gCnpNA==
X-Received: by 2002:a2e:800b:0:b0:2b6:cbdb:790c with SMTP id j11-20020a2e800b000000b002b6cbdb790cmr3658759ljg.1.1688408409514;
        Mon, 03 Jul 2023 11:20:09 -0700 (PDT)
Received: from [192.168.1.101] (abyj26.neoplus.adsl.tpnet.pl. [83.9.29.26])
        by smtp.gmail.com with ESMTPSA id s9-20020a2e9c09000000b002b6995f38a2sm4946224lji.100.2023.07.03.11.20.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Jul 2023 11:20:09 -0700 (PDT)
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
Subject: [PATCH v2 0/8] MSM8998 clk cleanups and fixups
Date:   Mon, 03 Jul 2023 20:20:04 +0200
Message-Id: <20230622-topic-8998clk-v2-0-6222fbc2916b@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAFQRo2QC/3WNwQ6DIBAFf8Vw7jaArUJP/Y/GA+CqmxIwYE0b4
 7+Xeu9xJnlvNpYxEWZ2qzaWcKVMMRSQp4q5yYQRgfrCTHJZ80ZKWOJMDpTWyvknXGrRatUMNee
 KlY01GcEmE9xUVuHlfZFzwoHeR+TRFZ4oLzF9juYqfvbf/SqAw9W2hvcNamXF3VMwKZ5jGlm37
 /sXqei9+8AAAAA=
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Jeffrey Hugo <quic_jhugo@quicinc.com>,
        Taniya Das <tdas@codeaurora.org>
Cc:     Marijn Suijten <marijn.suijten@somainline.org>,
        linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Rob Herring <robh@kernel.org>
X-Mailer: b4 0.12.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1688408407; l=1720;
 i=konrad.dybcio@linaro.org; s=20230215; h=from:subject:message-id;
 bh=phlPM9Cc876D80OS9Sc/anPCogRjxlTnuuGA5rJzqPI=;
 b=7dmYnDCVVvlGri8VIWKTTOkbE9P5gWVFlLT8wuUmBrmzdbLf5oD70Fg+iauFZMgQz+tdBHbiu
 RIbMXQauebHDezcAG0E87N7GJs3nlC2z11esmEwvb5TPh9dEDmMlAAx
X-Developer-Key: i=konrad.dybcio@linaro.org; a=ed25519;
 pk=iclgkYvtl2w05SSXO5EjjSYlhFKsJ+5OSZBjOkQuEms=
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The MSM8998 clock controller drivers have some rough edges around whether
and how Linux should touch them, which this series tries to sand down
a bit.

MSM8998 maple seems not to explode, please give it a spin on your boards.

Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
---
Changes in v2:
- Pick up tags (thanks a lot Jeffrey for testing)
- Drop patch "Don't poke at some BIMC GPU clocks"
- Link to v1: https://lore.kernel.org/r/20230622-topic-8998clk-v1-0-5b7a0d6e98b1@linaro.org

---
Konrad Dybcio (8):
      dt-bindings: clk: qcom,gcc-msm8998: Add missing GPU/MMSS GPLL0 legs
      dt-bindings: clock: qcom,mmcc: Add GPLL0_DIV for MSM8998
      clk: qcom: gcc-msm8998: Control MMSS and GPUSS GPLL0 outputs properly
      clk: qcom: mmcc-msm8998: Properly consume GPLL0 inputs
      clk: qcom: gpucc-msm8998: Use the correct GPLL0 leg with old DTs
      clk: qcom: gcc-msm8998: Don't check halt bit on some branch clks
      arm64: dts: qcom: msm8998: Use the correct GPLL0 leg for GPUCC
      arm64: dts: qcom: msm8998: Use the correct GPLL0_DIV leg for MMCC

 .../devicetree/bindings/clock/qcom,mmcc.yaml       |  2 +
 arch/arm64/boot/dts/qcom/msm8998.dtsi              |  8 ++-
 drivers/clk/qcom/gcc-msm8998.c                     | 64 +++++++++++++++++++++-
 drivers/clk/qcom/gpucc-msm8998.c                   |  2 +-
 drivers/clk/qcom/mmcc-msm8998.c                    | 35 +++---------
 include/dt-bindings/clock/qcom,gcc-msm8998.h       |  3 +
 6 files changed, 80 insertions(+), 34 deletions(-)
---
base-commit: 296d53d8f84ce50ffaee7d575487058c8d437335
change-id: 20230622-topic-8998clk-4317986f3008

Best regards,
-- 
Konrad Dybcio <konrad.dybcio@linaro.org>

