Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 899D66E69DB
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Apr 2023 18:43:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232563AbjDRQnu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Apr 2023 12:43:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55266 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231296AbjDRQnp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Apr 2023 12:43:45 -0400
Received: from mail.z3ntu.xyz (mail.z3ntu.xyz [128.199.32.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 716E861BA;
        Tue, 18 Apr 2023 09:43:44 -0700 (PDT)
Received: from [192.168.178.23] (unknown [62.108.10.64])
        by mail.z3ntu.xyz (Postfix) with ESMTPSA id 90FE3CA680;
        Tue, 18 Apr 2023 16:43:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=z3ntu.xyz; s=z3ntu;
        t=1681836222; bh=IoEHW2vYqFAvOyNYJ41zV5ypb+S+GJlspgvRVAfUAF4=;
        h=From:Date:Subject:References:In-Reply-To:To:Cc;
        b=lYd3SNAOLT8PrOo8DLK7uRxoYn2XZZmiQUUrTg+cBJjqH26kSZtxKrU1yHu7Ui6yE
         agP/o9t7y4enm/CE2N1IzEpZopRvBvZWW4NUPjjb2hiYxYSaTYBFKjKk8HO3X4oHIO
         uqAew62Zh4m2OTgNQcrMm7eduzRino7lB0BA3gqc=
From:   Luca Weiss <luca@z3ntu.xyz>
Date:   Tue, 18 Apr 2023 18:43:18 +0200
Subject: [PATCH v2 2/8] pinctrl: qcom: spmi-gpio: Add PMI632 support
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230414-pmi632-v2-2-98bafa909c36@z3ntu.xyz>
References: <20230414-pmi632-v2-0-98bafa909c36@z3ntu.xyz>
In-Reply-To: <20230414-pmi632-v2-0-98bafa909c36@z3ntu.xyz>
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
        Stephen Boyd <sboyd@kernel.org>,
        Jonathan Corbet <corbet@lwn.net>
Cc:     linux-arm-msm@vger.kernel.org, linux-gpio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-leds@vger.kernel.org, linux-iio@vger.kernel.org,
        linux-doc@vger.kernel.org, Luca Weiss <luca@z3ntu.xyz>
X-Mailer: b4 0.12.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=948; i=luca@z3ntu.xyz;
 h=from:subject:message-id; bh=IoEHW2vYqFAvOyNYJ41zV5ypb+S+GJlspgvRVAfUAF4=;
 b=owEBbQKS/ZANAwAIAXLYQ7idTddWAcsmYgBkPsi3ZwH0Grfw+endy5WJ3r/UqRHoJ8mLZfVi7
 lN5Xi8uc96JAjMEAAEIAB0WIQQ5utIvCCzakboVj/py2EO4nU3XVgUCZD7ItwAKCRBy2EO4nU3X
 VjVHD/9HxZfcF8rVbPKhDaGSuN/MHmVxlIFGMumR7OGITEzxq/DYc/WXw4MbdlkpEq4c5+jSHjB
 PfCltOv0LseH3xNx9bSuxIS5ehhmyixVIUqwkiNjVhiDGEh55FOfotTyK5LNhYFM83Fnbue9fa3
 ujxAOpClYsonNnxt/i32iq3UagojmEtV6rBix8ElGKLrnMuKxCIbznpotSE+Ko4csoIUREpfyWJ
 jeSRuj6auZF93gBJCbByXCTLjXiFNKbUzvxYtVMUpJl52Q3Pi5ekYymv8WTqknJ497uKri3egIc
 pATwppabwhe2qkrYU7yfrtA26AJkK/TytTCIjKBCYDe8UVXMU8PO1+BNbFBjAEgqF/TH9KO9deW
 E5QVoZOQQHYGMJo3DFJHuH9KmYHKqMA5w3I5E+GP1yXTnEAPsIEzJsfLDlPf5ABgUUEd310OQKd
 HMosCYGVgarYyEJENQ2XyIv2EjQk1wro7L/YFaun8srw4/DoL7P/TTbD49//+2+yLIwMGjjZWWP
 FXpbjgNAXtr6APS34Ne77Gkqp+KVHrZKsTrSzNz0i7AgdinweQLGm78YLGAyvMRWQScuEknBO0A
 ek66yjcU4SpZvjaMCLokeRJqRQuKjArc99gfXbyW7k0Hd/jNLIOM5CLOSfxqmOVZU7NPLsMXXc6
 0IEv5ZOvc3Mvxwg==
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

Add support for the 8 GPIOs found on PMI632.

Signed-off-by: Luca Weiss <luca@z3ntu.xyz>
---
 drivers/pinctrl/qcom/pinctrl-spmi-gpio.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/pinctrl/qcom/pinctrl-spmi-gpio.c b/drivers/pinctrl/qcom/pinctrl-spmi-gpio.c
index 0d94175b34f8..43c7857c06a5 100644
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

