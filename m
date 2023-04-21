Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E2CBA6EB405
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Apr 2023 23:57:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233689AbjDUV5P (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Apr 2023 17:57:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44414 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232058AbjDUV5D (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Apr 2023 17:57:03 -0400
Received: from mail.z3ntu.xyz (mail.z3ntu.xyz [128.199.32.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 40A941BD6;
        Fri, 21 Apr 2023 14:57:01 -0700 (PDT)
Received: from [192.168.178.23] (unknown [62.108.10.64])
        by mail.z3ntu.xyz (Postfix) with ESMTPSA id 9775BCEB77;
        Fri, 21 Apr 2023 21:56:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=z3ntu.xyz; s=z3ntu;
        t=1682114189; bh=kARpF42x0a3Ol3hkdLTct9brZ7ygU/8j2A4lKB9TSv4=;
        h=From:Date:Subject:References:In-Reply-To:To:Cc;
        b=Gsk0VQqEgTTb50ebWdPGEEAnq2KtAd8E+kURS9XcDYhQx+omvAP8aKyuUmglVVhII
         iLCoLII1J/C8+FAbSznMXIam4O5PixyHa71srhXQNmyK9tRbWhkXJna+hez/3+XI7O
         gdGTNPbVDwhZ4kpwBzEdhP4fZg/jF+F96qDZVmYk=
From:   Luca Weiss <luca@z3ntu.xyz>
Date:   Fri, 21 Apr 2023 23:56:21 +0200
Subject: [PATCH 2/3] pinctrl: qcom: spmi-gpio: Add PM8953 support
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230421-pm8953-gpio-v1-2-3d33e2de47e3@z3ntu.xyz>
References: <20230421-pm8953-gpio-v1-0-3d33e2de47e3@z3ntu.xyz>
In-Reply-To: <20230421-pm8953-gpio-v1-0-3d33e2de47e3@z3ntu.xyz>
To:     ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     linux-arm-msm@vger.kernel.org, linux-gpio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Luca Weiss <luca@z3ntu.xyz>
X-Mailer: b4 0.12.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=979; i=luca@z3ntu.xyz;
 h=from:subject:message-id; bh=kARpF42x0a3Ol3hkdLTct9brZ7ygU/8j2A4lKB9TSv4=;
 b=owEBbQKS/ZANAwAIAXLYQ7idTddWAcsmYgBkQwaL9fLrouqWGfHrkJj525FY2yYIP4nAeMc2e
 tlqdtMX2X+JAjMEAAEIAB0WIQQ5utIvCCzakboVj/py2EO4nU3XVgUCZEMGiwAKCRBy2EO4nU3X
 VsLOEACBoR5dtbAeSqEemXnxA3tGdW0pt0dBKJn+xCfEhurE4UE7eZDy7JgdeTSZxBb4sUvfIKK
 f589BNs1QCO8ozEXcz025JoZ6T4TA9aFqTqp15qw245+jG8WxPpQMOJsLJ3mBcl13bcuggWxpTy
 gpyC4euSNcEP9apz6yzA/nIvvjFDx5ohuz0eXvDAv53vE+8CvRUf82ce+bzmMESmfiQyjPa7dgJ
 YT20kKzdXkSyeAcl9Xbp9UxVc5qcCFf8IbmPo135VT8X4kOiOeuGqrmVcoVYL2PUa29Q3W345ot
 2OGl6783szwokGTYA5vCFlzdf0e8GXwW6FuwaVexcTabcjT7aUT+xe9sm4FRvDTfCDnUy9Zorpo
 6P+uWJ13YKrXFbWwtaDObWYXHf6E7vvUQ6ul7+4yjF+9pO4Mhu5+GPicQDhtMIq4WDuGDX7hy3L
 c/hL8bwiK5+m6KWT0/RbWYo+sMld9arCJ0bwEZ6hpD92jDfkdHS2gQRypS+A2EPPQwlx9nKsddV
 RFnxZOYCOXjZ/JCqHLXkmfrCg/48p403rlV6Df03EV9cRIZ4491Tq+3KUMASZ3E5s0YLvN1DDuW
 s3w42YqEs9rmhqgNP7i7AoIFaagKBUbqGkLYzvQj+1DbHDcLIKV6B8gpDLJMN3VT5rUp6myMJwb
 JE/hTpcf4oIeMwQ==
X-Developer-Key: i=luca@z3ntu.xyz; a=openpgp;
 fpr=BD04DA24C971B8D587B2B8D7FAF69CF6CD2D02CD
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add support for the 8 GPIOs found on PM8953.

Signed-off-by: Luca Weiss <luca@z3ntu.xyz>
---
 drivers/pinctrl/qcom/pinctrl-spmi-gpio.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/pinctrl/qcom/pinctrl-spmi-gpio.c b/drivers/pinctrl/qcom/pinctrl-spmi-gpio.c
index 43c7857c06a5..b4cd66886f29 100644
--- a/drivers/pinctrl/qcom/pinctrl-spmi-gpio.c
+++ b/drivers/pinctrl/qcom/pinctrl-spmi-gpio.c
@@ -1229,6 +1229,8 @@ static const struct of_device_id pmic_gpio_of_match[] = {
 	{ .compatible = "qcom,pm8941-gpio", .data = (void *) 36 },
 	/* pm8950 has 8 GPIOs with holes on 3 */
 	{ .compatible = "qcom,pm8950-gpio", .data = (void *) 8 },
+	/* pm8953 has 8 GPIOs with holes on 3 and 6 */
+	{ .compatible = "qcom,pm8953-gpio", .data = (void *) 8 },
 	{ .compatible = "qcom,pm8994-gpio", .data = (void *) 22 },
 	{ .compatible = "qcom,pm8998-gpio", .data = (void *) 26 },
 	{ .compatible = "qcom,pma8084-gpio", .data = (void *) 22 },

-- 
2.40.0

