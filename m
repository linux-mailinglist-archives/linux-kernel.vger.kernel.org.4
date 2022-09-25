Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D897D5E91D0
	for <lists+linux-kernel@lfdr.de>; Sun, 25 Sep 2022 11:19:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231527AbiIYJTg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 25 Sep 2022 05:19:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55016 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231345AbiIYJT2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 25 Sep 2022 05:19:28 -0400
Received: from mail-lj1-x231.google.com (mail-lj1-x231.google.com [IPv6:2a00:1450:4864:20::231])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 376E42A40B
        for <linux-kernel@vger.kernel.org>; Sun, 25 Sep 2022 02:19:25 -0700 (PDT)
Received: by mail-lj1-x231.google.com with SMTP id p5so4417410ljc.13
        for <linux-kernel@vger.kernel.org>; Sun, 25 Sep 2022 02:19:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date;
        bh=Kh4ohBClFTW8SISoua2UPjYn75Z/RLcWY2qmsPjXMGk=;
        b=In1i2WrMAdWUD4Yjb9rw987UsjLzIy0bikgDJLA2wElQg/JUe9MpvEnsMuefyBbuwY
         2dmWEpGUOkfrLj+PdGsh4Km2gh+xS6SfRyU75fOcvY3O4EWkRmi6oHKMOgJJ8xPNUc6+
         7rqjA6NgnRkZ3hGOfrVNqDKk0o4mdA8wImUPfwIJqirS305f1ApVpOPDKaiy1vq3r5SR
         irj9jcvknKGYCUvO962Dwd8pI5HjNlC1/I1UHQFCjXK0urXUGqUHNu3ttlg/sHK+NM99
         y8BW1jXVwec9BYBerdGT95b1uCIymojy72k3fhcpX3N00YWpknqnxR3mT/WHwV1WxK/Y
         O9sw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date;
        bh=Kh4ohBClFTW8SISoua2UPjYn75Z/RLcWY2qmsPjXMGk=;
        b=U0zSGpJpipB6+FHgBs1s9mdsEUy5JLMXEaTcAVro4pp6E2QSksIXQIw0Flaos4tGGX
         grbfyFEfEhr/523SN7Zc6/JppNzs9tiIgBnfqbMwojGiDIGOF+rAWz3hUtsh653RR2dC
         EI7csiC/CeD+yR4905Jsp1aJcA+Y7LP5acZ8PI/S0jdJSFnXLyJU1RDRxQk3yagPUXuM
         0ae9Iee2T8OZMlsid2EuUzKEyQDINLccYGEHFTXl9yEBl9aNJ1N3EK1Dz0+dxCFLt1qr
         dxOrk9ZZAgXC1XZykgpXKn52ii3HNuNwDJpJGXIh9HKohWNaoXCZWIBDrYVKFSXzoGXF
         esjg==
X-Gm-Message-State: ACrzQf05xOqPk5XcFb8+LbKB9Wc2kKOa2vggWIFlIagrUD2aF/abLYCP
        3hWEYaQ33FhR82IHmCc6Y03I+A==
X-Google-Smtp-Source: AMsMyM6wqp2MkyLFvkveAn5x8yYzg7V0MmQn8AXsiGRkqiaTRMXdGXnYtUy4olhoDFk/ZWMJnjkEsA==
X-Received: by 2002:a2e:94c7:0:b0:265:6126:6562 with SMTP id r7-20020a2e94c7000000b0026561266562mr5667961ljh.150.1664097563485;
        Sun, 25 Sep 2022 02:19:23 -0700 (PDT)
Received: from krzk-bin.. (78-11-189-27.static.ip.netia.com.pl. [78.11.189.27])
        by smtp.gmail.com with ESMTPSA id p1-20020a2ea4c1000000b00261b4df9ec4sm2023455ljm.138.2022.09.25.02.19.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 25 Sep 2022 02:19:22 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Russell King <linux@armlinux.org.uk>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, linux-arm-msm@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH 1/2] ARM: qcom_defconfig: enable rest of ARMv7 SoCs pinctrl drivers
Date:   Sun, 25 Sep 2022 11:19:19 +0200
Message-Id: <20220925091920.34891-1-krzysztof.kozlowski@linaro.org>
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

Enable rest of ARMv7 SoCs pin controller drivers.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 arch/arm/configs/qcom_defconfig | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/arch/arm/configs/qcom_defconfig b/arch/arm/configs/qcom_defconfig
index 7d8b6884fd00..4971de49be36 100644
--- a/arch/arm/configs/qcom_defconfig
+++ b/arch/arm/configs/qcom_defconfig
@@ -131,14 +131,20 @@ CONFIG_PINCTRL_APQ8064=y
 CONFIG_PINCTRL_APQ8084=y
 CONFIG_PINCTRL_IPQ4019=y
 CONFIG_PINCTRL_IPQ8064=y
+CONFIG_PINCTRL_MSM8226=y
 CONFIG_PINCTRL_MSM8660=y
 CONFIG_PINCTRL_MSM8960=y
+CONFIG_PINCTRL_MDM9607=y
 CONFIG_PINCTRL_MDM9615=y
 CONFIG_PINCTRL_MSM8X74=y
+CONFIG_PINCTRL_MSM8909=y
+CONFIG_PINCTRL_MSM8916=y
+CONFIG_PINCTRL_MSM8976=y
 CONFIG_PINCTRL_QCOM_SPMI_PMIC=y
 CONFIG_PINCTRL_QCOM_SSBI_PMIC=y
 CONFIG_GPIOLIB=y
 CONFIG_PINCTRL_SDX55=y
+CONFIG_PINCTRL_SDX65=y
 CONFIG_GPIO_SYSFS=y
 CONFIG_POWER_RESET=y
 CONFIG_POWER_RESET_MSM=y
-- 
2.34.1

