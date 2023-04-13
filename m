Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EA5BF6E182E
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Apr 2023 01:19:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231178AbjDMXT2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Apr 2023 19:19:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51954 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229625AbjDMXTX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Apr 2023 19:19:23 -0400
Received: from mail.z3ntu.xyz (mail.z3ntu.xyz [128.199.32.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 655ADE42;
        Thu, 13 Apr 2023 16:18:57 -0700 (PDT)
Received: from [192.168.178.23] (unknown [62.108.10.64])
        by mail.z3ntu.xyz (Postfix) with ESMTPSA id 9CC35D0C36;
        Thu, 13 Apr 2023 23:18:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=z3ntu.xyz; s=z3ntu;
        t=1681427893; bh=HcTHX83+QMV3YucT0aCNnzAc4Whibfo3LY2KHsCfrkI=;
        h=From:Date:Subject:References:In-Reply-To:To:Cc;
        b=OF8cWS53T+6066sujXfS0khXFCK9/Q68aY7+Ln7WIt4o8NII7KQfvcD2YyztWWIlM
         p+nE24H0OBf7FVpvt12xnnE/7k2H4/2ZPUd1RmlHBsxwUsTwQeU2c5Ohi3iNPaUNAI
         SMHcMY6l9kRAL2H+2iNqjUAe1kR2I61zyYyyd93g=
From:   Luca Weiss <luca@z3ntu.xyz>
Date:   Fri, 14 Apr 2023 01:17:46 +0200
Subject: [PATCH 2/8] pinctrl: qcom: spmi-gpio: Add PMI632 support
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230414-pmi632-v1-2-fe94dc414832@z3ntu.xyz>
References: <20230414-pmi632-v1-0-fe94dc414832@z3ntu.xyz>
In-Reply-To: <20230414-pmi632-v1-0-fe94dc414832@z3ntu.xyz>
To:     ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Pavel Machek <pavel@ucw.cz>, Lee Jones <lee@kernel.org>,
        Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Stephen Boyd <sboyd@kernel.org>
Cc:     linux-arm-msm@vger.kernel.org, linux-gpio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-leds@vger.kernel.org, linux-iio@vger.kernel.org,
        Luca Weiss <luca@z3ntu.xyz>
X-Mailer: b4 0.12.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=948; i=luca@z3ntu.xyz;
 h=from:subject:message-id; bh=HcTHX83+QMV3YucT0aCNnzAc4Whibfo3LY2KHsCfrkI=;
 b=owEBbQKS/ZANAwAIAXLYQ7idTddWAcsmYgBkOI2uXy+FWc8JZFlKj7GgodHPwBXGfBBiIo+83
 NbtrIiQQRmJAjMEAAEIAB0WIQQ5utIvCCzakboVj/py2EO4nU3XVgUCZDiNrgAKCRBy2EO4nU3X
 VqBCD/92DOezFgvV5TKj9vXY7vZo3r0V+Lq9gP+TQIV3G79eFKyVzW+9kjK4HlzhsV6siORz3kG
 5BHqoKgxbd75VHObVL1xUUc00r+UIr+ivLWxwTlv4I+IZiKvDIzqsJBgy8ey35kk6IyzhIjF/Tq
 Y0LLa+W8Fi5n2ux9eD6BQgxUOJFGi/FhPzktRjNRkEdsPVYC9mLvfFDtB6XBO0lSDvodoLrRKoD
 hRX6UfmPS54eErJV4Wh+umoIo5k6jIrbOKJzLna3fMPTnHhvWxSP3196+lijgHk/VFOXgwg8dqT
 YFMD14//gL233GjrwWSxDjHr9S1FqXJtPAquct3xWQmdIpLbxwPqUyBtQu0Jkwv8dhW1gO6NYPj
 JAJqZS0GHCiQ8yvwGxyU26YtZ0udCRS8eQFKJMbABHr8Ku8BEVpSJcaFlmEI9Qe/kTnNVapiY8t
 A0ImnoCH7n2g+Eg74zyMEQaQlFzs7jJdzlFRUo1x0V/7gPcpb6zRAuhbj8RwiDt3U9zXnTADDNc
 aOlbRx6PJ9f2GblUCcHfBkR9rlkxRL3aQV5MPfa+u+76uz0pasF5lqA9ECf19JA9agc11BldXT0
 mgtettYih1H/hCSIub7prw1p3b9wFhGm/wVE8rCiAnHbsxMIr7HcRok6XovVLv9JMqNvsNB6IIv
 q+a3heyxiQWJhEw==
X-Developer-Key: i=luca@z3ntu.xyz; a=openpgp;
 fpr=BD04DA24C971B8D587B2B8D7FAF69CF6CD2D02CD
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add support for the 8 GPIOs found on PMI632.

Signed-off-by: Luca Weiss <luca@z3ntu.xyz>
---
 drivers/pinctrl/qcom/pinctrl-spmi-gpio.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/pinctrl/qcom/pinctrl-spmi-gpio.c b/drivers/pinctrl/qcom/pinctrl-spmi-gpio.c
index ea3485344f06..40cab13e5a83 100644
--- a/drivers/pinctrl/qcom/pinctrl-spmi-gpio.c
+++ b/drivers/pinctrl/qcom/pinctrl-spmi-gpio.c
@@ -1232,6 +1232,7 @@ static const struct of_device_id pmic_gpio_of_match[] = {
 	{ .compatible = "qcom,pm8994-gpio", .data = (void *) 22 },
 	{ .compatible = "qcom,pm8998-gpio", .data = (void *) 26 },
 	{ .compatible = "qcom,pma8084-gpio", .data = (void *) 22 },
+	{ .compatible = "qcom,pmi632-gpio", .data = (void *) 8 },
 	{ .compatible = "qcom,pmi8950-gpio", .data = (void *) 2 },
 	{ .compatible = "qcom,pmi8994-gpio", .data = (void *) 10 },
 	{ .compatible = "qcom,pmi8998-gpio", .data = (void *) 14 },

-- 
2.40.0

