Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 84A8D63D47C
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Nov 2022 12:29:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234662AbiK3L3W (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Nov 2022 06:29:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51406 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230326AbiK3L3R (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Nov 2022 06:29:17 -0500
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com [IPv6:2a00:1450:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 20D6AEE17
        for <linux-kernel@vger.kernel.org>; Wed, 30 Nov 2022 03:29:15 -0800 (PST)
Received: by mail-ej1-x630.google.com with SMTP id ml11so15679609ejb.6
        for <linux-kernel@vger.kernel.org>; Wed, 30 Nov 2022 03:29:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=aS1gk2uoG81MJ4RrDrVUYhXDPzm8Wlyn8u+uwHSYkNU=;
        b=lXbbMvokdweKCajm3+r9f1K/dalND9hnMjwboobz/tDqSoqo+i1xdM3Xb/qlbCdPKh
         8Gs8Hjfaxxf9QX0vV53Yr684NiVqT+xzpz9cUDWZG3ZlOH2kYEvJgp2zpZXY1TAzSmsH
         m7XKz+EfAuRPHePCLI3m5HGYESbMrftjc63BMnTd+78OQPOqdUpeTf/SDhc0swcwsmhj
         Eu4L7HFJlB9KRx2W3V7aluWFGEt42ayI2jxPZI6fv1NOHMQNJCEL3TIc4jhOt9+WvaQ4
         PpXve3hP1dztfeOMzzkz3Nlulojf+pkj7M6NadaQTRvq8kkewEnTuNEArutcpA+QpwKW
         kB6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=aS1gk2uoG81MJ4RrDrVUYhXDPzm8Wlyn8u+uwHSYkNU=;
        b=fG9tpndNrxUPIqzLl7tkCU9Ma6kR8w2CihEZn/4/5Noz8P0tpwWMluESkh3qcganRb
         DEjFHtkEPKB0Sc/erTkG4tYI3ceBt3thmSAvsyfMH2XAGUj3EyqVP+TTNJeB6oWMJr0p
         3UThbJsaG66vKaLgqnvqt3xErLMg7mxxyoF55wEvLoWADphrSDIV/iX5AhDVlDSVHANu
         eZnBnjVSqlgZHQ8AMfCto6u2GkNHkLsp+xA/Qw591gN4zyUY3/DvOkqmMRPjCRSkYcnh
         HzGSqDBta3MwNVq+mGeP7Cwk6+P3p+2T4/Tndb5FpTWGU+ZqKgca5XePnH4A7rSU8Z8I
         IGRg==
X-Gm-Message-State: ANoB5pkK9Eg+DttYGylRPJHpI9j0++FCZB8nzizVFK0JDOBc67FiwcEN
        lMJQ5swbs8sNdDcqr8tytNpQYg==
X-Google-Smtp-Source: AA0mqf67k30y1xGQTnfJpSPT5PuOe1ruU+yQYT27ym+jrjf1SvHeccAuA4t51vZJ4fvB7ae6y19IIw==
X-Received: by 2002:a17:906:a884:b0:7bd:15a6:27e8 with SMTP id ha4-20020a170906a88400b007bd15a627e8mr20757232ejb.78.1669807754285;
        Wed, 30 Nov 2022 03:29:14 -0800 (PST)
Received: from hackbox.lan ([94.52.112.99])
        by smtp.gmail.com with ESMTPSA id x10-20020a1709060a4a00b007c073be0127sm521593ejf.202.2022.11.30.03.29.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Nov 2022 03:29:13 -0800 (PST)
From:   Abel Vesa <abel.vesa@linaro.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Mike Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        devicetree@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-clk@vger.kernel.org
Subject: [PATCH v4 0/9] clk: qcom: Add support for SM8550
Date:   Wed, 30 Nov 2022 13:28:43 +0200
Message-Id: <20221130112852.2977816-1-abel.vesa@linaro.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patchset adds clock support for the Qualcomm SM8550 SoC,
It adds support for the new type of PLL, the TCSR clock controller
driver, support for configurable poll timeout, the RPMh clocks
and the bindings.

Changes since v3:
 * Dropped the GDSC configurable poll timeout patch, like Stephen
   suggested
 * Added Krzysztof's R-b tag to TCSRCC and GCC binding patches

To: Andy Gross <agross@kernel.org>
To: Bjorn Andersson <andersson@kernel.org>
To: Konrad Dybcio <konrad.dybcio@linaro.org>
To: Michael Turquette <mturquette@baylibre.com>
To: Stephen Boyd <sboyd@kernel.org>
To: Rob Herring <robh+dt@kernel.org>
To: Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc: linux-arm-msm@vger.kernel.org
Cc: linux-clk@vger.kernel.org
Cc: devicetree@vger.kernel.org
Cc: linux-kernel@vger.kernel.org

Abel Vesa (9):
  dt-bindings: clock: Add SM8550 GCC clocks
  dt-bindings: clock: Add SM8550 TCSR CC clocks
  clk: qcom: gdsc: Increase status poll timeout
  clk: qcom: Add LUCID_OLE PLL type for SM8550
  clk: qcom: Add GCC driver for SM8550
  dt-bindings: clock: Add RPMHCC for SM8550
  dt-bindings: clock: qcom,rpmh: Add CXO PAD clock IDs
  clk: qcom: rpmh: Add support for SM8550 rpmh clocks
  clk: qcom: Add TCSR clock driver for SM8550

 .../bindings/clock/qcom,rpmhcc.yaml           |    1 +
 .../bindings/clock/qcom,sm8550-gcc.yaml       |   62 +
 .../bindings/clock/qcom,sm8550-tcsrcc.yaml    |   45 +
 drivers/clk/qcom/Kconfig                      |   15 +
 drivers/clk/qcom/Makefile                     |    2 +
 drivers/clk/qcom/clk-alpha-pll.c              |   16 +
 drivers/clk/qcom/clk-alpha-pll.h              |    5 +
 drivers/clk/qcom/clk-rpmh.c                   |  110 +-
 drivers/clk/qcom/gcc-sm8550.c                 | 3388 +++++++++++++++++
 drivers/clk/qcom/gdsc.c                       |    3 +-
 drivers/clk/qcom/tcsrcc-sm8550.c              |  193 +
 include/dt-bindings/clock/qcom,rpmh.h         |    2 +
 include/dt-bindings/clock/qcom,sm8550-gcc.h   |  231 ++
 .../dt-bindings/clock/qcom,sm8550-tcsrcc.h    |   18 +
 14 files changed, 4070 insertions(+), 21 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/clock/qcom,sm8550-gcc.yaml
 create mode 100644 Documentation/devicetree/bindings/clock/qcom,sm8550-tcsrcc.yaml
 create mode 100644 drivers/clk/qcom/gcc-sm8550.c
 create mode 100644 drivers/clk/qcom/tcsrcc-sm8550.c
 create mode 100644 include/dt-bindings/clock/qcom,sm8550-gcc.h
 create mode 100644 include/dt-bindings/clock/qcom,sm8550-tcsrcc.h

-- 
2.34.1

