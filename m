Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F35A46B2924
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Mar 2023 16:50:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231529AbjCIPuL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Mar 2023 10:50:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58062 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231344AbjCIPuF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Mar 2023 10:50:05 -0500
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com [IPv6:2a00:1450:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7215FF28B6
        for <linux-kernel@vger.kernel.org>; Thu,  9 Mar 2023 07:50:03 -0800 (PST)
Received: by mail-ed1-x536.google.com with SMTP id cw28so8830706edb.5
        for <linux-kernel@vger.kernel.org>; Thu, 09 Mar 2023 07:50:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1678377002;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BcQHpyuRa8telS2z61Wu0G0Mj91kmKtPrkTuDj0nJzc=;
        b=bKQLs3Cao3Qr+7xgoWm8wqxFjz9Pk8Dra+NzlXub+7IgfcIT46ZANSF/ssMPKeZmVF
         Y0SZ50fRLK37ycP/Pp8cACIt6eN7h9vwfK/5ktc1q3FFkz/dlTAdqcrRowJcqI1WcKm8
         1ChtptJDOMl02FVZws7evuh0c9B3b7EZFLCYNnqQZW2JWMh7GfvA/IbH75xawmvOLTec
         TvllrrTVu2/2+7J9yLatuG/npcvN0AhQ+y9x/BcIALMBVyouugrHH7kHXBYNUlpG7aOY
         tTIauB6SOtwQEKsgX93/sQe3FLQ2BDiUUp7121+UuyRaecyRIBNZ4hkEFRyShevppIDk
         ZC8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678377002;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BcQHpyuRa8telS2z61Wu0G0Mj91kmKtPrkTuDj0nJzc=;
        b=zy+5VoN2DdOBnTPDKIHgkvgRQEb9+O7VRG3bKoPRCW+ohazYgz+FHVWJ7J0mQEe5j5
         mkHlIo/w5eOpnodUErIet0ah/vG9w/3xE5tNgHtG5Yjwg68TfRngMc6yhvaGQQGS4xlO
         w7gbipXx2/LdWPlF0vv+vrLZ1yRRCp67c63ZQsZ441spgMQFfs8DD6kgRCUhmhRQZVVr
         rNNLxfDliQf7b1FGW9QoMz6LDDpiAgBCnbBpG33dTQTpB2p8VIhh5liSGKnqQazt2nj5
         Yjbbggy5JUt5CsW331s0Tn5F27mgHi5eVBHXhEE/zHiCKZ+awvdK17wF3/9kVxesZFXt
         Ilqw==
X-Gm-Message-State: AO0yUKVv2vK0IBA86CO4XsQgYay/mGgJvMltTP+50/NlUsUaZYja8Dne
        wF1IrEb9fRHcyp1uc3ZbcJk9Dw==
X-Google-Smtp-Source: AK7set92zrvqbxYZohYM0hs5HGDmbaIHAgjbHr4KGcYksm+XO3vASQwOfpAgPYu1+j5QhqH6lLogUQ==
X-Received: by 2002:a17:907:3e8f:b0:8b1:779c:a8b1 with SMTP id hs15-20020a1709073e8f00b008b1779ca8b1mr28652540ejc.5.1678377001945;
        Thu, 09 Mar 2023 07:50:01 -0800 (PST)
Received: from krzk-bin.. ([2a02:810d:15c0:828:7ee2:e73e:802e:45c1])
        by smtp.gmail.com with ESMTPSA id h17-20020a17090634d100b008ee5356801dsm8981683ejb.187.2023.03.09.07.50.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Mar 2023 07:50:01 -0800 (PST)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Bjorn Andersson <andersson@kernel.org>,
        Andy Gross <agross@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        linux-arm-msm@vger.kernel.org, linux-gpio@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH 3/4] pinctrl: qcom: lpass-lpi: allow glitch-free output GPIO
Date:   Thu,  9 Mar 2023 16:49:48 +0100
Message-Id: <20230309154949.658380-3-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230309154949.658380-1-krzysztof.kozlowski@linaro.org>
References: <20230309154949.658380-1-krzysztof.kozlowski@linaro.org>
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

When choosing GPIO function for pins, use the same glitch-free method as
main TLMM pinctrl-msm.c driver in msm_pinmux_set_mux().  This replicates
the commit d21f4b7ffc22 ("pinctrl: qcom: Avoid glitching lines when we
first mux to output") to LPASS pin controller with same justification.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 drivers/pinctrl/qcom/pinctrl-lpass-lpi.c | 28 ++++++++++++++++++++++++
 1 file changed, 28 insertions(+)

diff --git a/drivers/pinctrl/qcom/pinctrl-lpass-lpi.c b/drivers/pinctrl/qcom/pinctrl-lpass-lpi.c
index bd32556d75a5..fdb6585a9234 100644
--- a/drivers/pinctrl/qcom/pinctrl-lpass-lpi.c
+++ b/drivers/pinctrl/qcom/pinctrl-lpass-lpi.c
@@ -19,6 +19,8 @@
 
 #include "pinctrl-lpass-lpi.h"
 
+#define MAX_NR_GPIO		23
+#define GPIO_FUNC		0
 #define MAX_LPI_NUM_CLKS	2
 
 struct lpi_pinctrl {
@@ -30,6 +32,7 @@ struct lpi_pinctrl {
 	char __iomem *slew_base;
 	struct clk_bulk_data clks[MAX_LPI_NUM_CLKS];
 	struct mutex slew_access_lock;
+	DECLARE_BITMAP(ever_gpio, MAX_NR_GPIO);
 	const struct lpi_pinctrl_variant_data *data;
 };
 
@@ -100,6 +103,28 @@ static int lpi_gpio_set_mux(struct pinctrl_dev *pctldev, unsigned int function,
 		return -EINVAL;
 
 	val = lpi_gpio_read(pctrl, pin, LPI_GPIO_CFG_REG);
+
+	/*
+	 * If this is the first time muxing to GPIO and the direction is
+	 * output, make sure that we're not going to be glitching the pin
+	 * by reading the current state of the pin and setting it as the
+	 * output.
+	 */
+	if (i == GPIO_FUNC && (val & LPI_GPIO_OE_MASK) &&
+	    !test_and_set_bit(group, pctrl->ever_gpio)) {
+		u32 io_val = lpi_gpio_read(pctrl, group, LPI_GPIO_VALUE_REG);
+
+		if (io_val & LPI_GPIO_VALUE_IN_MASK) {
+			if (!(io_val & LPI_GPIO_VALUE_OUT_MASK))
+				lpi_gpio_write(pctrl, group, LPI_GPIO_VALUE_REG,
+					       io_val | LPI_GPIO_VALUE_OUT_MASK);
+		} else {
+			if (io_val & LPI_GPIO_VALUE_OUT_MASK)
+				lpi_gpio_write(pctrl, group, LPI_GPIO_VALUE_REG,
+					       io_val & ~LPI_GPIO_VALUE_OUT_MASK);
+		}
+	}
+
 	u32p_replace_bits(&val, i, LPI_GPIO_FUNCTION_MASK);
 	lpi_gpio_write(pctrl, pin, LPI_GPIO_CFG_REG, val);
 
@@ -394,6 +419,9 @@ int lpi_pinctrl_probe(struct platform_device *pdev)
 	if (!data)
 		return -EINVAL;
 
+	if (WARN_ON(data->npins > MAX_NR_GPIO))
+		return -EINVAL;
+
 	pctrl->data = data;
 	pctrl->dev = &pdev->dev;
 
-- 
2.34.1

