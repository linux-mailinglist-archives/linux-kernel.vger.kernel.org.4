Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F0ECD73A02B
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Jun 2023 13:57:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230456AbjFVL5x (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Jun 2023 07:57:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51204 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229930AbjFVL5v (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Jun 2023 07:57:51 -0400
Received: from mail-lf1-x133.google.com (mail-lf1-x133.google.com [IPv6:2a00:1450:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 396671738
        for <linux-kernel@vger.kernel.org>; Thu, 22 Jun 2023 04:57:50 -0700 (PDT)
Received: by mail-lf1-x133.google.com with SMTP id 2adb3069b0e04-4f870247d6aso6804818e87.0
        for <linux-kernel@vger.kernel.org>; Thu, 22 Jun 2023 04:57:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1687435068; x=1690027068;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=3vLvgCImQ9a6c8UHP9511WNjq7ZpYfkFoY/txai7EhQ=;
        b=m7bH1SNkbu9RFfe81Rnm7hMLSLrrvUeoEb+fhqZlYXBD9tvTNeeh66t2oEW9BRTWME
         OXJhjxdWDIkD9RQXvL1B7G2TP0HsgcY9w/vvEmzdSq0M7mh5WPf0Vee+Q/NMGBbeFkiz
         cYofI8tmuydbWk5hI/WAvHb44JgvKpqZI00ELSij8Z/giAW0ZhkmSOa5/LE+RlH478tD
         cR7xn/KG0n0+Jc1Dq9xriH7o0XqXblngtH2iuyCAQmkdMIkDqJcSyahZk7nWzzOROv6u
         XKy3LxwxI9ftNgDEz5kCzJ8hOZgEBWwUdJ99J7Umcpun8qV91JKLd9aaLE6ahvmCNdkt
         exqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687435068; x=1690027068;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=3vLvgCImQ9a6c8UHP9511WNjq7ZpYfkFoY/txai7EhQ=;
        b=EFvhB4bmggLJb1/D3Gt2ZSH9O3Y6Pp9ZrhYHUPi0sgrix91+yXTII+kk7gkHbvxjMA
         munjNiV/b1mzVES+gm5GWqRNbaAB3RFDQejQnlbKLp/6k22OdE6AK3fHkAZzZmSCyK+e
         XTd5X7SSUY8iHfCUf/nv9l0s3ymKDazM8U9xh4PGOW3MqJJbSo+BSYHHfuvDtOK2e/6k
         cm1wzJ7L2ucBly89hABfM6W3LmJmmhfTh2ITvQHGGD1JX0QMevCocxWQLXuDz3VFihBf
         x8RSQhhAlnYQJKMz2+bj+cmnkWLsM1NgkcYaXcJElR0aj3/c15RBCUs6jfdx9ctCp90P
         gV3Q==
X-Gm-Message-State: AC+VfDwBSYlWxL567wdOXCjlwNqL55RfTSC1HrBI890sQXL69pb3SAdS
        LmjiMHFHC2Dv83BanUQ1rRHiyg==
X-Google-Smtp-Source: ACHHUZ75TQv59aPcG+cUl0gm+4IQIcCIW0/2JpOMmCtweguyXGnApY1koGY2jnPFPAc4RCNh6R6QyA==
X-Received: by 2002:a05:6512:3286:b0:4f8:7127:9b9d with SMTP id p6-20020a056512328600b004f871279b9dmr1166186lfe.37.1687435068388;
        Thu, 22 Jun 2023 04:57:48 -0700 (PDT)
Received: from [192.168.1.101] (abyl165.neoplus.adsl.tpnet.pl. [83.9.31.165])
        by smtp.gmail.com with ESMTPSA id eq21-20020a056512489500b004f4c3feb9fbsm1099235lfb.61.2023.06.22.04.57.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Jun 2023 04:57:48 -0700 (PDT)
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
Subject: [PATCH 0/9] MSM8998 clk cleanups and fixups
Date:   Thu, 22 Jun 2023 13:57:40 +0200
Message-Id: <20230622-topic-8998clk-v1-0-5b7a0d6e98b1@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIADQ3lGQC/x2NQQqDMBAAvyJ77kJMRBO/UnpI0lUXQ5TEloL4d
 5ceZ2CYEyoVpgpjc0KhL1feskD7aCAuPs+E/BYGrbRRvdZ4bDtHtM7ZmFbsTDs4209GKQvSBF8
 JQ/E5LlLlT0oi90IT//6T5+u6bmFhcrt0AAAA
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
        Konrad Dybcio <konrad.dybcio@linaro.org>
X-Mailer: b4 0.12.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1687435067; l=1563;
 i=konrad.dybcio@linaro.org; s=20230215; h=from:subject:message-id;
 bh=beSw4DerolKlnlu7guVjHR7VZCdVcgsNzWLv04yx0RQ=;
 b=dmTfAs5cKF5NrvBkeFPCusReqVMFWBp/0hRrk9aYHwz75DJmkGWnJPX/Oj2+o2SaWp6w7ePHK
 i3dGNgZsQh9B+YeOuoMrV2nd7npc73BDOyCcDhcbbylQw8vMwVvny8O
X-Developer-Key: i=konrad.dybcio@linaro.org; a=ed25519;
 pk=iclgkYvtl2w05SSXO5EjjSYlhFKsJ+5OSZBjOkQuEms=
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
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
Konrad Dybcio (9):
      dt-bindings: clk: qcom,gcc-msm8998: Add missing GPU/MMSS GPLL0 legs
      dt-bindings: clock: qcom,mmcc: Add GPLL0_DIV for MSM8998
      clk: qcom: gcc-msm8998: Control MMSS and GPUSS GPLL0 outputs properly
      clk: qcom: mmcc-msm8998: Properly consume GPLL0 inputs
      clk: qcom: gpucc-msm8998: Use the correct GPLL0 leg with old DTs
      clk: qcom: gcc-msm8998: Don't check halt bit on some branch clks
      clk: qcom: gcc-msm8998: Don't poke at some BIMC GPU clocks
      arm64: dts: qcom: msm8998: Use the correct GPLL0 leg for GPUCC
      arm64: dts: qcom: msm8998: Use the correct GPLL0_DIV leg for MMCC

 .../devicetree/bindings/clock/qcom,mmcc.yaml       |  2 +
 arch/arm64/boot/dts/qcom/msm8998.dtsi              |  8 +-
 drivers/clk/qcom/gcc-msm8998.c                     | 92 ++++++++++++++--------
 drivers/clk/qcom/gpucc-msm8998.c                   |  2 +-
 drivers/clk/qcom/mmcc-msm8998.c                    | 35 ++------
 include/dt-bindings/clock/qcom,gcc-msm8998.h       |  3 +
 6 files changed, 80 insertions(+), 62 deletions(-)
---
base-commit: c87d46a9e8ebd2f2c3960927b1d21687096d1109
change-id: 20230622-topic-8998clk-4317986f3008

Best regards,
-- 
Konrad Dybcio <konrad.dybcio@linaro.org>

