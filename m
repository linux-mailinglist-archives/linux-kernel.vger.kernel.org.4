Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5F2F472AA81
	for <lists+linux-kernel@lfdr.de>; Sat, 10 Jun 2023 11:13:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231833AbjFJJNG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 10 Jun 2023 05:13:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33056 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229761AbjFJJNE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 10 Jun 2023 05:13:04 -0400
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com [IPv6:2a00:1450:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 58EEF3A98
        for <linux-kernel@vger.kernel.org>; Sat, 10 Jun 2023 02:13:03 -0700 (PDT)
Received: by mail-ej1-x632.google.com with SMTP id a640c23a62f3a-977c8423dccso769752466b.1
        for <linux-kernel@vger.kernel.org>; Sat, 10 Jun 2023 02:13:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1686388382; x=1688980382;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=el5t90CX0KZg71r46Aq58k54+iI17+shn/UMUNopsqg=;
        b=vyZHYGkzfoQFiksS2nO9MCLsI4oWI8oIDoMCiYbDQBfFmuFFn4A6OtLOy+DaTw8W6K
         /jQURkeJNjvHhzUzaF+4Mntf/OsbwSdLEqt6U5alv05OJxgvqZRQbMliqb2NUF2/nRpo
         qq36oSJhzCuqd2byp4w4TEFqx/5nsR+fQVsmMYPo2MijngwnxtwCdoCYSFIrCpMXhwe4
         nStfU0z/j4rcTy/J61LeJxtBgoHFUR2TWIaAQkLxMevFdBgDj7bKv9DA7MLmxwyfr2UQ
         TpC97pYtzE39afHUviXBsKzPB9vg+w88NrX7ecG1RCs9j4o9uE+S/DA9yP17ADNcwj32
         7pGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686388382; x=1688980382;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=el5t90CX0KZg71r46Aq58k54+iI17+shn/UMUNopsqg=;
        b=Kx8XS5e0ANZzOeHPnb7mEB5ezzJE46P5TQiBO5SaWsrU0935m2KegZKCckgd7PCQx/
         Ev1slDKtRSTDzbQbCdEFrsF1zr1Tsl++QFLbYRB4SeOTGYxtXFAB7x0cDy/9EiKevavn
         6Nkl2rmdL1cfWPtaQ/vL7+DIt6PVfu4+KhMpFtTorVP2Vp5+3ECsY6/NalgTxKxv363E
         AdstJEVJYkTHBMX7g2K/V+Ls9tEV0vHGwp9cUOh9R/Snthx9piVmvGi3fibVj0AIu/AM
         bAb6pX8MnWBFaqaEMI5CP27C7ir+a1GZ8DiytwUU4lkBp+K3GtJl4Rn2/NTC9rQa6sRn
         NA0A==
X-Gm-Message-State: AC+VfDxL6K2yPaeXL/02QcMeYb7g2rjbbtXYExYyiHB/1LzlfK002jCj
        HGLfqXHRx0pp0voaLYrLUZdetA==
X-Google-Smtp-Source: ACHHUZ4Dv2xzIY5s4ZpE8GvaEA/T+zxaJeqRlsL+nIBhW18zrjRMuyKw4lwlg0Drr7r2jioTo7bLpg==
X-Received: by 2002:a17:907:7202:b0:970:28c:f960 with SMTP id dr2-20020a170907720200b00970028cf960mr4219760ejc.17.1686388381629;
        Sat, 10 Jun 2023 02:13:01 -0700 (PDT)
Received: from krzk-bin.. ([178.197.219.26])
        by smtp.gmail.com with ESMTPSA id b7-20020a170906038700b009787b18c253sm2347012eja.181.2023.06.10.02.13.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 10 Jun 2023 02:13:01 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Linus Walleij <linus.walleij@linaro.org>
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        linux-arm-msm@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-gpio@vger.kernel.org,
        linux-kernel@vger.kernel.org, Krzysztof Kozlowski <krzk@kernel.org>
Subject: [GIT PULL] pinctrl: dt-bindings: qcom: for v6.5
Date:   Sat, 10 Jun 2023 11:12:58 +0200
Message-Id: <20230610091258.4903-1-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following changes since commit ac9a78681b921877518763ba0e89202254349d1b:

  Linux 6.4-rc1 (2023-05-07 13:34:35 -0700)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/krzk/linux-dt.git tags/qcom-pinctrl-6.5

for you to fetch changes up to 647c16ac7b15fc8fe6ab679690ac2ffe7c53abd3:

  dt-bindings: pinctrl: qcom,sm7150-tlmm: simplify with unevaluatedProperties (2023-05-12 18:23:51 +0200)

----------------------------------------------------------------
Qualcomm pinctrl Devicetree bindings changes for v6.5

Simplify remaining bindings with usage of unevaluatedProperties.  This
will have the same functional effect with less code.

----------------------------------------------------------------
Krzysztof Kozlowski (4):
      dt-bindings: pinctrl: qcom,ipq9574-tlmm: simplify with unevaluatedProperties
      dt-bindings: pinctrl: qcom,sc8280xp-tlmm: simplify with unevaluatedProperties
      dt-bindings: pinctrl: qcom,qcm2290-tlmm: simplify with unevaluatedProperties
      dt-bindings: pinctrl: qcom,sm7150-tlmm: simplify with unevaluatedProperties

 .../devicetree/bindings/pinctrl/qcom,ipq9574-tlmm.yaml       | 11 +----------
 .../devicetree/bindings/pinctrl/qcom,qcm2290-tlmm.yaml       | 11 +----------
 .../devicetree/bindings/pinctrl/qcom,sc8280xp-tlmm.yaml      | 12 +-----------
 .../devicetree/bindings/pinctrl/qcom,sm7150-tlmm.yaml        | 11 +----------
 4 files changed, 4 insertions(+), 41 deletions(-)
