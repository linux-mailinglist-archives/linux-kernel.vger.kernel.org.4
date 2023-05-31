Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 19848717FC9
	for <lists+linux-kernel@lfdr.de>; Wed, 31 May 2023 14:22:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235410AbjEaMWg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 May 2023 08:22:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33416 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229765AbjEaMWe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 May 2023 08:22:34 -0400
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com [IPv6:2a00:1450:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 05A79123
        for <linux-kernel@vger.kernel.org>; Wed, 31 May 2023 05:22:33 -0700 (PDT)
Received: by mail-wm1-x335.google.com with SMTP id 5b1f17b1804b1-3f60e536250so6773905e9.1
        for <linux-kernel@vger.kernel.org>; Wed, 31 May 2023 05:22:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1685535751; x=1688127751;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=+hlItBZSa8qJMMaCDwSxrKtteXj1iXy2B/zXCOUIhkI=;
        b=O5XTdtzfbB9EPm/UAT4dvJk29SfhxgWZq6XzK5iQvxKuIkEwW5hmJ4WrAuKTB+8rTC
         R0A0WeKY1H+cAmnKq+My2RZ3+pCHGC1Oas0GmkDCLgtIpkHT6MhtkggumKVOa9+MCU6I
         BOtFcWHXDbfu8jBbjnrif4rb0cKiLDkzkBa+2X8iJsm8t79PCirZnjOVB2/T48U0qkqd
         zuC3IGJCrs6juZMubqFeocp9msU5OyoZz1Oc3D0LN70JLfOeu33RnCXQsgR7wkHx7+ve
         9rAnw3xOAamSI6ttmuj2j3Utz2GkA2FjZ1k3sD0wP/mAMsfe1CG7yi3wFH/GCkRKvs+H
         Pp8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685535751; x=1688127751;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+hlItBZSa8qJMMaCDwSxrKtteXj1iXy2B/zXCOUIhkI=;
        b=ZkG9eeUyBtut7AdncY1Oaf3tsCqI/HNi1g+RLKwZgklNA3ad2Nqa3rcjdHQtl04PD6
         dHxMtaoCffsC6c1UG6tBbCLFaLYj5cfDfM8242HRh3R5VuZIwk3NrCg7FVBb2Aw0yE9B
         BpX8viAku8cKRjbAQ5aiWgMwxyfA3nh1LeRKK0pj+bG+OFuOARHeiuSpAmTHvbW43w/w
         jcNqfCxfscgpZJGiMnvqBwF0y42RG9P9NAGE7P4QO+UK4P02Pfa4rd41v6Xqlh+lNWLk
         4Tc+44TIhaccYEfuXjwZsgEbn4j3NlZZvGJCFh1U3s/NfqvL98oq4wZXxzdbMHnFDJfY
         iolg==
X-Gm-Message-State: AC+VfDxg3/afq6on0WXuRrz0YdnTuNHZKHgANrHhBCaZS8ntVrGLjCUK
        hNAHbaLy0jPTDI86Dxg9iCDTcw==
X-Google-Smtp-Source: ACHHUZ4GFuR2ifUDLAIF6/6enGSlV92VU2gn1fcrxoIfGAyVHBNiQyrpozCa9Br08r7n0uwPm8HiYQ==
X-Received: by 2002:a1c:6a0a:0:b0:3f6:3486:1391 with SMTP id f10-20020a1c6a0a000000b003f634861391mr4291324wmc.13.1685535751243;
        Wed, 31 May 2023 05:22:31 -0700 (PDT)
Received: from arrakeen.starnux.net ([2a01:e0a:982:cbb0:52eb:f6ff:feb3:451a])
        by smtp.gmail.com with ESMTPSA id n7-20020adfe347000000b00309382eb047sm6637954wrj.112.2023.05.31.05.22.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 31 May 2023 05:22:30 -0700 (PDT)
From:   Neil Armstrong <neil.armstrong@linaro.org>
Subject: [PATCH v2 0/4] arm64: qcom: sm8550: enable PMIC devices
Date:   Wed, 31 May 2023 14:22:23 +0200
Message-Id: <20230525-topic-sm8550-upstream-pm8550-lpg-dt-v2-0-a3b890604c49@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAP87d2QC/5WPQQ6DIBREr9Kw7m8Q/Wq76j0aFwioJAgE1LQx3
 r1oN926fLN4M7OSqIJWkTwuKwlq0VE7m4BdL0QM3PYKtExMGGU5RYYwOa8FxLFGpDD7OAXFR/A
 /Nr4HOYHIswJRMtaxkiRTy6OCNnArhuSyszEp9EF1+n1Uv5rEg46TC59jyZLt6bnSJQMKLdZFL
 ivkJcufRlse3M2Ffh9xXlZIlFVJ04s7/Zc127Z9AYIIaDA5AQAA
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1627;
 i=neil.armstrong@linaro.org; h=from:subject:message-id;
 bh=KL6QyPg63cMU5N+qVVw/DznqwEpOJlcW5JwBk19/9zA=;
 b=owEBbQKS/ZANAwAKAXfc29rIyEnRAcsmYgBkdzwE4zS2k1BuY/kN4sQV0jN0DpjHlwbjK3D/EyQC
 LTv5D+yJAjMEAAEKAB0WIQQ9U8YmyFYF/h30LIt33NvayMhJ0QUCZHc8BAAKCRB33NvayMhJ0ccED/
 4u2kcI+Dd1zixfhzz7gpeTAuv8R53saMTtZ7PWU6DfCIRTraW6cNY2gNdGGT28WciBv59pm5NUE3d2
 ARJnUVdU8e90WxEP//OikBa48kMKPQNcxw9slVH0IIDIJAEmAZ38Vs6HMAXGmo05NLgt1eaCZBFHiw
 apH8TBXKS1Xho41mecxLhV00KcYvF1LRfvwFXRWVDfP9KIg4o3/9S1UBjW5S3nK9Vripg8wbhtcGf0
 iEfWFqX2v+MzP+gcrsHwlubBgrg6x2u3j/Fcy/SPCvXqL4Xj7SSzMgk9dnFh9Y3qJURca8Da5LiS9H
 CmuacqnN5A4dRuqrWwsuJZlUUfWKfaRhEKhhGC1+2YqhI6q6JxYcaqJ2qj2lrptgCinzYNO1Yq+srf
 g4uKdmTYKFTb/cBAZ/OM0YpBH8rMwbC73kDp30kBvVkLJKvVr4PkRuO74NtzcJhuybBgxX8tHFesMF
 zflybsozPxqP296OcncVL8OTYEV8+XTvi6mzSYuNoO81B5n2iY05jfaMMqTd4oh+KOrCsGlMRIuKrQ
 o2LTMQsSV6nDC6XQo+y1E8Fom8FkQBlhaRF6cI0B42zv/sE97mvGdPRGYeZss69s+24O9iYl04kD2G
 XXL3qLm3CMRZ6gpHzaDMjxmxSymLHQkNfW6umUai1doo2caf6vGWptQMSJPw==
X-Developer-Key: i=neil.armstrong@linaro.org; a=openpgp;
 fpr=89EC3D058446217450F22848169AB7B1A4CFF8AE
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
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

Depends on:
- [1] PWM bindings, merged by Lee
- [2] functional fix
- [3] & [4] QRD flash DT changes merged by Bjorn

[1] https://lore.kernel.org/all/20230522-topic-sm8550-upstream-pm8550-lpg-v2-1-c5117f1d41f9@linaro.org/
[2] https://lore.kernel.org/r/20230515162604.649203-1-quic_bjorande@quicinc.com
[3] https://lore.kernel.org/r/20230516150202.188655-3-krzysztof.kozlowski@linaro.org
[4] https://lore.kernel.org/r/20230516150202.188655-2-krzysztof.kozlowski@linaro.org

Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
---
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
base-commit: 388a38fadd00565867bda40c3b87c3a983bfb83d
change-id: 20230525-topic-sm8550-upstream-pm8550-lpg-dt-c31455d22f26

Best regards,
-- 
Neil Armstrong <neil.armstrong@linaro.org>

