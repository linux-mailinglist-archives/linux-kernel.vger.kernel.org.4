Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B19C6687A9B
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Feb 2023 11:46:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232651AbjBBKqn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Feb 2023 05:46:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42410 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232835AbjBBKqb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Feb 2023 05:46:31 -0500
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com [IPv6:2a00:1450:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4065E885C4
        for <linux-kernel@vger.kernel.org>; Thu,  2 Feb 2023 02:45:52 -0800 (PST)
Received: by mail-wm1-x331.google.com with SMTP id c4-20020a1c3504000000b003d9e2f72093so3397943wma.1
        for <linux-kernel@vger.kernel.org>; Thu, 02 Feb 2023 02:45:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=1S7GOszrEZV+HX9A+lXMpAYlO9S8MYR5SJFYyv5hqaw=;
        b=No27QxsRZjEYUVuE32+QlRkb99VmZHzR1SlJzD7hSssoPLhVS+Gu5YQT+rIxdQu8nm
         fHxk+k7IjnxpCe0IpGxvqblDVXK0RGOYyZXCantSrQNn0B/ai9vhdQlHVxGz1pfZ5Kjx
         sl8VGbUXgeI/91FU0cbBBYg+qIFPlQ2NeRHS+835aOgmgcAYTN03LDeyqetVgakvQLTt
         0PMs3kM2s4aZHmofLRRd+SM7quHRII4wgny688bnlrp4i7Iq5ZLzNVDGd7F53SxuSiyq
         gaFyP09Dw6fJG120exGtIyybdhfmrPdPedepwtUhMvoUkl5bVMx9lOyh1BWqKEAns8TI
         dZog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=1S7GOszrEZV+HX9A+lXMpAYlO9S8MYR5SJFYyv5hqaw=;
        b=lW5vn8k/yQqPgZ92YKT0x9vJVgo9dOLK3bAFErvOmCOiGLRW6AYkMqfi4SFjLkkW5D
         8sT0zNy9dhaJ/069QMPmw+DNq1caGjssxbTFchWjvg9IUe9Hg+Gwf9O3lZupO2B4ETf5
         c/NW1rsYgo8VB45qlTzuTaKF0NF204HuMv3msglujv4XIgvhacrG79Q9D0FiA30r6pk0
         blRKtpNsibfpwRHwImqfx7whwbfBfXCt2c6tVNxPpFj6Fu75gpUgPsmEeTD69BxSmBSl
         NUSmLwMWYzikhV5S+4+eRW16TfIyoS51S6ZFYtA5oMspLYmcQVtJG/vUpsc3sOaHIGEH
         Za+g==
X-Gm-Message-State: AO0yUKWI6ZcHO/c+8mIC9UnOMEnIFCu0p+ff2ZnQY8nmLJ5ry9neBkb/
        2fM7sbHM0XYWMUCzSBhOdEZ5kg==
X-Google-Smtp-Source: AK7set/Oq31zEmAFRK4vryQlCvrv9RAh1BRcLKqLqnktxp1QRAOZbgXLLynrLgmrE2E5H5r+moe7Dw==
X-Received: by 2002:a05:600c:4f03:b0:3dd:e86e:8827 with SMTP id l3-20020a05600c4f0300b003dde86e8827mr5358569wmq.4.1675334750510;
        Thu, 02 Feb 2023 02:45:50 -0800 (PST)
Received: from krzk-bin.. ([178.197.216.144])
        by smtp.gmail.com with ESMTPSA id n24-20020a05600c181800b003dc3f195abesm4307329wmp.39.2023.02.02.02.45.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Feb 2023 02:45:50 -0800 (PST)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Stephan Gerhold <stephan@gerhold.net>,
        Vinod Koul <vkoul@kernel.org>,
        Vladimir Lypak <vladimir.lypak@gmail.com>,
        Luca Weiss <luca@z3ntu.xyz>, Iskren Chernev <me@iskren.info>,
        linux-arm-msm@vger.kernel.org, linux-gpio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH v2 00/10] pinctrl/ARM/arm64: qcom: correct TLMM gpio-ranges and GPIO pin names
Date:   Thu,  2 Feb 2023 11:44:42 +0100
Message-Id: <20230202104452.299048-1-krzysztof.kozlowski@linaro.org>
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

Hi,

Changes since v1:
1. Match the driver's ngpios (so usually include the ufs-reset where
   applicable). Several patches were dropped, other rewritten.
2. Add tags

Best regards,
Krzysztof

Krzysztof Kozlowski (10):
  dt-bindings: pinctrl: qcom,msm8226: correct GPIO name pattern
  dt-bindings: pinctrl: qcom,msm8909: correct GPIO name pattern and
    example
  dt-bindings: pinctrl: qcom,sm6375: correct GPIO name pattern and
    example
  dt-bindings: pinctrl: qcom,msm8953: correct GPIO name pattern
  dt-bindings: pinctrl: qcom,sdx55: correct GPIO name pattern
  dt-bindings: pinctrl: qcom,msm8994: correct number of GPIOs
  dt-bindings: pinctrl: qcom: correct gpio-ranges in examples
  ARM: dts: qcom: sdx55: correct TLMM gpio-ranges
  arm64: dts: qcom: msm8953: correct TLMM gpio-ranges
  arm64: dts: qcom: sm6115: correct TLMM gpio-ranges

 .../devicetree/bindings/pinctrl/qcom,msm8226-pinctrl.yaml   | 2 +-
 .../devicetree/bindings/pinctrl/qcom,msm8909-tlmm.yaml      | 4 ++--
 .../devicetree/bindings/pinctrl/qcom,msm8953-pinctrl.yaml   | 2 +-
 .../devicetree/bindings/pinctrl/qcom,msm8994-pinctrl.yaml   | 6 +++---
 .../devicetree/bindings/pinctrl/qcom,sdx55-pinctrl.yaml     | 2 +-
 .../devicetree/bindings/pinctrl/qcom,sm6375-tlmm.yaml       | 4 ++--
 .../devicetree/bindings/pinctrl/qcom,sm8250-pinctrl.yaml    | 2 +-
 .../devicetree/bindings/pinctrl/qcom,sm8350-tlmm.yaml       | 2 +-
 arch/arm/boot/dts/qcom-sdx55.dtsi                           | 2 +-
 arch/arm64/boot/dts/qcom/msm8953.dtsi                       | 2 +-
 arch/arm64/boot/dts/qcom/sm6115.dtsi                        | 2 +-
 11 files changed, 15 insertions(+), 15 deletions(-)

-- 
2.34.1

