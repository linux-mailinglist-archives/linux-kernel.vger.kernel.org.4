Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ED50862B746
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Nov 2022 11:11:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232971AbiKPKLs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Nov 2022 05:11:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46500 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231301AbiKPKLp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Nov 2022 05:11:45 -0500
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0FAA41FCEA
        for <linux-kernel@vger.kernel.org>; Wed, 16 Nov 2022 02:11:44 -0800 (PST)
Received: by mail-wr1-x42e.google.com with SMTP id bs21so29087434wrb.4
        for <linux-kernel@vger.kernel.org>; Wed, 16 Nov 2022 02:11:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=cc:to:message-id:date:from:content-transfer-encoding:mime-version
         :subject:from:to:cc:subject:date:message-id:reply-to;
        bh=2sXMPjyYlEjI2B4Rlkp7SFAQqHOI8ZKcd3a/TQ7z30o=;
        b=Gxzs4tsDE0+FP+wW1pfIp50r9zP6o78+feeCdIiM41l3zs3Vk7HYcqPpVge4ESuXwI
         yj+Ar2zg8pmyDoTU9OcRXMiLPCP+cvmTUnTntyZlCDGcJAO9FxIXPVjz0e0vz49/xewO
         n+e7WTuaxj3DkQgJyZyy0kKv1ujONjvua3TPY4OT0m5uYzbCM0+XhJBdnEVvh3ZiD8HR
         JrH+xgsjtqqMt+TUzBxL96PRXXXE1Sq0e/+WTdQ36vQYNYoiUXpOI85/KLFfYw7P589s
         43olaDdf49r/yZU8JMILZ9GtjAKX0InNz0Pa7fgQSqXT5CLvi2NHDMQzCKoXc9c8sdzx
         +DhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:message-id:date:from:content-transfer-encoding:mime-version
         :subject:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=2sXMPjyYlEjI2B4Rlkp7SFAQqHOI8ZKcd3a/TQ7z30o=;
        b=RKwzBx3qHrG/w2q0mX758663/bh8tw7axGTaQIJmp9M/63aCU6aQyQYvMQQVu44F/i
         mviaSk0KPXkAAEIg8UtiUNXkagNsCqWud3JMb/YSz8OzTSVpXDUJCM6istod1HxEMRJF
         rG2krGlz0Pt/ZYo8gr2zQhQg2HBB3n3uiSjQnPwET7TTuO2dCsxtOq3PZr9fJeA0+xot
         R7pB0tkdPOvgUuDk7qQfGJJmnfMyC6LpNlnmnMqLjgf+tC4OsDsfzgnSzGP7edf+7C3f
         BQm+yo8yrSDiVUrpcVYEjtbYgyKW1Thi1t6yU84n158joGF3j4rgu5YiGmZNrhuUlpy5
         iyqA==
X-Gm-Message-State: ANoB5pnw7vh8XDF+7/5YWUpIQwPgEMBzBnowmuYj5k4HVWfot7Vtj9pu
        YGdSb1tvjP7Uvhy2Jxu7tJK7KQ==
X-Google-Smtp-Source: AA0mqf4/okQIcXHsn8/0v1t7nIrZA6mDr+ohIbIQdxlqgvxuf7KXViaPZQrirc2BdsFInvRGsWS6TQ==
X-Received: by 2002:adf:cd10:0:b0:22e:c2a6:d00d with SMTP id w16-20020adfcd10000000b0022ec2a6d00dmr13486833wrm.29.1668593502580;
        Wed, 16 Nov 2022 02:11:42 -0800 (PST)
Received: from arrakeen.starnux.net ([2a01:e0a:982:cbb0:8261:5fff:fe11:bdda])
        by smtp.gmail.com with ESMTPSA id h12-20020a05600c350c00b003c6bd91caa5sm1741752wmq.17.2022.11.16.02.11.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Nov 2022 02:11:42 -0800 (PST)
Subject: [PATCH 0/7] qcom: add support for SPMI PMICs found on SM8550 platforms
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-b4-tracking: H4sIAFG3dGMC/w3MQQqEMAwAwK9IzhswZQtbf1PboAEbpdG9iH83x7nMDcZd2GAabuj8F5NdHfQZoK
 xZF0apbghjCET0Rc292dl3XdDaL8YRr8PNuaEdTbCGklLiEmsh8GXOxjj3rGX1R69te54Xmoe7KXYA AAA=
From:   Neil Armstrong <neil.armstrong@linaro.org>
Date:   Wed, 16 Nov 2022 11:11:29 +0100
Message-Id: <20221114-narmstrong-sm8550-upstream-spmi-v1-0-6338a2b4b241@linaro.org>
To:     Andy Gross <agross@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Lee Jones <lee@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Stephen Boyd <sboyd@kernel.org>
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org,
        Neil Armstrong <neil.armstrong@linaro.org>,
        linux-gpio@vger.kernel.org
X-Mailer: b4 0.10.1
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The SM8550 based platforms sports a bunch of new PMICs:
- pm8550
- pm8550b
- pm8550ve
- pm8550vs
- pmk8550
- pmr735d
- pm8010

With GPIO support on:
- pm8550
- pm8550b
- pm8550ve
- pm8550vs
- pmk8550
- pmr735d

This documents bindings for those SPMI PMIC and adds compatible in the
PMIC pinctrl driver for GPIO support.

To: Andy Gross <agross@kernel.org>
To: Bjorn Andersson <andersson@kernel.org>
To: Konrad Dybcio <konrad.dybcio@somainline.org>
To: Lee Jones <lee@kernel.org>
To: Rob Herring <robh+dt@kernel.org>
To: Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
To: Stephen Boyd <sboyd@kernel.org>
To: Linus Walleij <linus.walleij@linaro.org>
Cc: linux-arm-msm@vger.kernel.org
Cc: devicetree@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Cc: linux-gpio@vger.kernel.org
Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>

---
Neil Armstrong (7):
      dt-bindings: mfd: qcom,spmi-pmic: document pm8550, pm8550b, pm8550ve, pm8550vs & pmk8550
      dt-bindings: mfd: qcom,spmi-pmic: document pm8010
      dt-bindings: mfd: qcom,spmi-pmic: document pmr735d
      dt-bindings: pinctrl: qcom,pmic-gpio: document pm8550, pm8550b, pm8550ve, pm8550vs & pmk8550
      dt-bindings: pinctrl: qcom,pmic-gpio: document pmr735d
      pinctrl: qcom: spmi-gpio: add support for pm8550 gpio control
      pinctrl: qcom: spmi-gpio: add support for pmr735d gpio control

 .../devicetree/bindings/mfd/qcom,spmi-pmic.yaml        |  7 +++++++
 .../devicetree/bindings/pinctrl/qcom,pmic-gpio.yaml    | 18 ++++++++++++++++++
 drivers/pinctrl/qcom/pinctrl-spmi-gpio.c               |  6 ++++++
 3 files changed, 31 insertions(+)
---
base-commit: 3c1f24109dfc4fb1a3730ed237e50183c6bb26b3
change-id: 20221114-narmstrong-sm8550-upstream-spmi-d2c999ec5dc1

Best regards,
-- 
Neil Armstrong <neil.armstrong@linaro.org>
