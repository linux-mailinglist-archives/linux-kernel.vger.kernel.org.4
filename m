Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0D99A72C9CF
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Jun 2023 17:23:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237997AbjFLPXD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Jun 2023 11:23:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50136 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232814AbjFLPXA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Jun 2023 11:23:00 -0400
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com [IPv6:2a00:1450:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C37B21B8
        for <linux-kernel@vger.kernel.org>; Mon, 12 Jun 2023 08:22:58 -0700 (PDT)
Received: by mail-wm1-x329.google.com with SMTP id 5b1f17b1804b1-3f6e13940daso46525385e9.0
        for <linux-kernel@vger.kernel.org>; Mon, 12 Jun 2023 08:22:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1686583377; x=1689175377;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Uuj0XULtFaQvAuryQsrKeMY0XLRwJecu37s7Jri30GU=;
        b=rxeKG198QHG4ADhFMnEXxJct6s32p5YodueNk1XzgcqP4fNL6Ypdnze7OBnOnJaG8j
         VZW81nFHAEny4x35s0LouP5OTg+nE6Plg/jOyFFcbi+4wGr3sN2UH5zDWNw9dJQgkEHg
         qF5rnmeZwaOtEP08AnTrW8blcCSC320YZUQhXQpHMZg4mNylSdWmjeq01QAtHCg/btDR
         JQp2SbstKco5erVgrf6aVrWEL65gvEO3mWGmCz/OQ7+0/3KJS7JNEUeUtcfIvAb//O1A
         WT81C2dXfxZHUrKI8Od8DnOroQZXA8miSgkBEtMRlsJ/Kp7VOne00hBzNQgV0QXpGCew
         0+iQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686583377; x=1689175377;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Uuj0XULtFaQvAuryQsrKeMY0XLRwJecu37s7Jri30GU=;
        b=iIRx4J0TnnTung/YVMzEtKJ492I7dORTkAL9bSNYGVHNiR+5uE58MOxopI8uzvktAO
         R7tkvw6xybWczSLwyGD/JzYdnOxtrjTAovNqwHHWziE5TvBIsWpmoSHjIB/nLhgl5noG
         +9dULJhDHP0CzJYUwvmLlMcvr8loDe0RbL/H6D61GEpusCwZ61YQY32XIZk8hyt05PJv
         x7k+HXJ0gxwUMoFPM3ErucHtL4ElMDISxR+i5JR+xR2IM1Pku32AQZqY4cs6uBgKNVrl
         UxnCusI+CHJ1wpvs9BG0mY1Skm7H9XcieQMY9tOCfqFqpgp9zXEq5srgxu33QjaOWGCI
         mtEQ==
X-Gm-Message-State: AC+VfDzJmPfyINbITwwQlWU1AxpqGP/OD0vq5ceJskQVPMVv4Meok62s
        67Rmh8z9oA98xFHmJ3vXPIC65A==
X-Google-Smtp-Source: ACHHUZ4+8Wc/LhkGQI5K7JEa4ang2eelkn6xRDnu4fOn7Eq0LoQO/Vi5kALxMojL4fgHB8Xo7vKGow==
X-Received: by 2002:a05:600c:255:b0:3f6:53a:6665 with SMTP id 21-20020a05600c025500b003f6053a6665mr8009562wmj.19.1686583377055;
        Mon, 12 Jun 2023 08:22:57 -0700 (PDT)
Received: from arrakeen.starnux.net ([2a01:e0a:982:cbb0:52eb:f6ff:feb3:451a])
        by smtp.gmail.com with ESMTPSA id l7-20020a7bc347000000b003f4248dcfcbsm11876512wmj.30.2023.06.12.08.22.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Jun 2023 08:22:56 -0700 (PDT)
From:   Neil Armstrong <neil.armstrong@linaro.org>
Subject: [PATCH v4 0/4] arm64: qcom: sm8550: enable PMIC devices
Date:   Mon, 12 Jun 2023 17:22:48 +0200
Message-Id: <20230525-topic-sm8550-upstream-pm8550-lpg-dt-v4-0-a288f24af81b@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAEg4h2QC/53PQW7DIBAF0KtErDsVngEHZ9V7VFlgwDaSAwgcK
 1Xkuxenm1ZdJcs/i/f/3Flx2bvCToc7y271xcdQg3g7MDPpMDrwtmaGHIlLlLDE5A2Ui5KSwzW
 VJTt9gfST5zSCXcBQI6S0iAO2rEq9Lg76rIOZqhWu81yPKbvB3x7Vn+eaJ1+WmL8eS9Zmvz5Xu
 jbAoZdKkD1K3SJ9zD7oHN9jHvcRz2PCSntsef2i47+xfe2KLyzEimrqVcdbLozo/qH0AkoVVQr
 JOUEDDeYPum3bN9HeT0LjAQAA
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>
Cc:     linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Neil Armstrong <neil.armstrong@linaro.org>
X-Mailer: b4 0.12.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1559;
 i=neil.armstrong@linaro.org; h=from:subject:message-id;
 bh=Xg44Q0NEL8frWaOLXdk+yFgGi/1YYP5AYukfj8+ycW8=;
 b=owEBbQKS/ZANAwAKAXfc29rIyEnRAcsmYgBkhzhMZdPDEnFjLZ5hp8RgXNs+zeoS+++3yMCAKcpN
 EC4QyQmJAjMEAAEKAB0WIQQ9U8YmyFYF/h30LIt33NvayMhJ0QUCZIc4TAAKCRB33NvayMhJ0eB6EA
 C8LcR6rK3VkoylF4vMMSMIHmFd0poQCe8xecbJTHo4il9cKVaB8CT3fqU7AxPyCtHCt3BlGGMVZO7Y
 hNaQOb1eJl+6PARDErfaPyRN1Gt1cn0UhVZg4xtEofk6Hsz9hg48O4SFLwXXRfqoD+TjH6gYU18ySd
 u3jUdrsz8qOTmp59QgrPQ8O0xWd/tzFsFvi0f4oUtu9Ms1+aY9xlt1vMxHkF+f2AmC/1xGMQgtIikC
 YTgDIQSE4v3wH1QajOQ3sfCDuXsXtN4Dc1dOBftfiAdJVJ7HeXRQnyRDaIBIPOlGgabgGJY/wZxqvh
 Xeh6x1fYddgkPLAxwtXS3ns9kzMB5hS9umlebRY32nve1Y2Fhdyxm4vxvRaM0CzGE1e/utALDHTo+7
 u6kdzglctd0ncQMFW47AlI7eYQecapMoLD/LojUCERzBEbaoXbQ8LvWa36KKku/oYzj56F4JVga396
 gJgVrnTl4NKQRvp9X/GWR3NY19HzssCQfsolMq1p3ZUvEFUyTp196ICmgydoPW13A/rsoC8oi/SCqt
 vGprrujZSDu0oS4yBCwsDqGh81nO8bdaTLSHanimb6hqzxsaz5yERq8R6VvvxbsgnfoMflN4CYoqu1
 gK9WgF3jcPYKXqlBjXfOsH4oV9qI2wcE/viC4jyZIcet8UrN4mfAzHV8vcgQ==
X-Developer-Key: i=neil.armstrong@linaro.org; a=openpgp;
 fpr=89EC3D058446217450F22848169AB7B1A4CFF8AE
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This enables the following PMIC devices:
- PWM RGB LED
- RTC
- Volume and Power buttons

on the SM8550 boards.

No dependencies when applied on next-20230609

Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
---
Changes in v4:
- rebased on next-20230609
- Link to v3: https://lore.kernel.org/r/20230525-topic-sm8550-upstream-pm8550-lpg-dt-v3-0-8823ee43f3fc@linaro.org

Changes in v3:
- Added all review tags
- Fixed pinctrl-names/-0 order in last patch
- Link to v2: https://lore.kernel.org/r/20230525-topic-sm8550-upstream-pm8550-lpg-dt-v2-0-a3b890604c49@linaro.org

Changes in v2:
- Always enable RTC in a new patch
- Drop patch enabling RTC on boards
- Move PON names to meet alphabetical order
- Link to v1: https://lore.kernel.org/r/20230525-topic-sm8550-upstream-pm8550-lpg-dt-v1-0-4d5d7602f290@linaro.org

---
Neil Armstrong (4):
      arm64: dts: qcom: pm8550: add PWM controller
      arm64: dts: qcom: sm8550-qrd: add notification RGB LED
      arm64: dts: qcom: pmk8550: always enable RTC PMIC device
      arm64: dts: qcom: sm8550-qrd: enable PMIC Volume and Power buttons

 arch/arm64/boot/dts/qcom/pm8550.dtsi    | 10 ++++++
 arch/arm64/boot/dts/qcom/pmk8550.dtsi   |  1 -
 arch/arm64/boot/dts/qcom/sm8550-qrd.dts | 63 +++++++++++++++++++++++++++++++++
 3 files changed, 73 insertions(+), 1 deletion(-)
---
base-commit: 53ab6975c12d1ad86c599a8927e8c698b144d669
change-id: 20230525-topic-sm8550-upstream-pm8550-lpg-dt-c31455d22f26

Best regards,
-- 
Neil Armstrong <neil.armstrong@linaro.org>

