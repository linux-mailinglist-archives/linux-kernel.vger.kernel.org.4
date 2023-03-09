Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E00266B291C
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Mar 2023 16:50:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230504AbjCIPuE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Mar 2023 10:50:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57994 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229629AbjCIPuD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Mar 2023 10:50:03 -0500
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com [IPv6:2a00:1450:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB372F28A4
        for <linux-kernel@vger.kernel.org>; Thu,  9 Mar 2023 07:50:01 -0800 (PST)
Received: by mail-ed1-x529.google.com with SMTP id cy23so8722845edb.12
        for <linux-kernel@vger.kernel.org>; Thu, 09 Mar 2023 07:50:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1678377000;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=5hDw377R+3WveEHHISt0O+B0HNboj//Q7JnZS8WCHQk=;
        b=xFOeIBq/oenmpZgse9ypMIySBxHojJR+priTRx4ns8SVP7D39nQ6GWvynrSpoOZ5R4
         HsKcT908aKbyY+mWmwZRF55bt35KR1yKcW6++DQauTZLH6LO5XQhIsgcSLObp6gQi6hm
         a3C1Phim93FONjhxlLRQF8vnGyv5kEKRKyqqR4+hFR4Sgk3etvYPV7Q2wgf+quQeWcXe
         hxC2Ucy6M/FWI8NXM4FSsbi4SSEtTGBa+kYiuwRsDKUcCqugBKPlLx+sYmJ/K9BI1x47
         dyALpaqG6NJ6cPLoOigP4lVhPtGskb7OAMXxdEwptXITcYfMfg+ad/t27LGV1Lpt5K5d
         pncA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678377000;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=5hDw377R+3WveEHHISt0O+B0HNboj//Q7JnZS8WCHQk=;
        b=eM28eGUTtlpMXkzpJzZ/zCV3qnnMXk9Bs6m5JFAbvBxdvpT2jYf9rc30IwifoHC8L4
         XZH6JavOT1yeZWa9qQQMh8TDkmo6oPF0/I3gTckQoNYAYtpIgQ78c27K7StwZ9WfVu7l
         QS3pl5oT4aC2FBhnnBaBkOQFgBy42Z0zsekUgEu1/NhRbLXCLjhcTnkI8LMT4f/RkEoO
         z7jO1UL6RXc0a+BBmVszJF9k7b50tXUfw+EBIczEwls6XpG+WsIfzjDI/bzjCB2M6d66
         7+pjpu6hOxkQeIUtEz9mGZTG+j+Z4QUwlYuqZIFxWo3tXGrwK6Yf7uXRPzYvFx3j+Afm
         jbmA==
X-Gm-Message-State: AO0yUKU5Kn5vBA4jLnFi6Kc4bCQPgMfMBAm/SPZ+AAU7u/lDqDLBPUfs
        dC5tonmvwFLV8RAebz2DmvPiZXXu61L7RTG2YJM=
X-Google-Smtp-Source: AK7set+ShI583mjtu+t07MzMAYJ711BR0WtRErkuBFVx28IQ6paK6KKAKh5e4gkiWKvsgXlvtUbldw==
X-Received: by 2002:a17:906:a1c5:b0:906:3373:cfe9 with SMTP id bx5-20020a170906a1c500b009063373cfe9mr21147766ejb.10.1678377000203;
        Thu, 09 Mar 2023 07:50:00 -0800 (PST)
Received: from krzk-bin.. ([2a02:810d:15c0:828:7ee2:e73e:802e:45c1])
        by smtp.gmail.com with ESMTPSA id h17-20020a17090634d100b008ee5356801dsm8981683ejb.187.2023.03.09.07.49.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Mar 2023 07:49:59 -0800 (PST)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Bjorn Andersson <andersson@kernel.org>,
        Andy Gross <agross@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        linux-arm-msm@vger.kernel.org, linux-gpio@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        stable@vger.kernel.org
Subject: [PATCH 1/4] pinctrl: qcom: lpass-lpi: set output value before enabling output
Date:   Thu,  9 Mar 2023 16:49:46 +0100
Message-Id: <20230309154949.658380-1-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

As per Hardware Programming Guide, when configuring pin as output,
set the pin value before setting output-enable (OE).  Similar approach
is in main SoC TLMM pin controller.

Cc: <stable@vger.kernel.org>
Fixes: 6e261d1090d6 ("pinctrl: qcom: Add sm8250 lpass lpi pinctrl driver")
Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 drivers/pinctrl/qcom/pinctrl-lpass-lpi.c | 14 +++++++++-----
 1 file changed, 9 insertions(+), 5 deletions(-)

diff --git a/drivers/pinctrl/qcom/pinctrl-lpass-lpi.c b/drivers/pinctrl/qcom/pinctrl-lpass-lpi.c
index 87920257bb73..27fc8b671954 100644
--- a/drivers/pinctrl/qcom/pinctrl-lpass-lpi.c
+++ b/drivers/pinctrl/qcom/pinctrl-lpass-lpi.c
@@ -221,6 +221,15 @@ static int lpi_config_set(struct pinctrl_dev *pctldev, unsigned int group,
 		}
 	}
 
+	/*
+	 * As per Hardware Programming Guide, when configuring pin as output,
+	 * set the pin value before setting output-enable (OE).
+	 */
+	if (output_enabled) {
+		val = u32_encode_bits(value ? 1 : 0, LPI_GPIO_VALUE_OUT_MASK);
+		lpi_gpio_write(pctrl, group, LPI_GPIO_VALUE_REG, val);
+	}
+
 	val = lpi_gpio_read(pctrl, group, LPI_GPIO_CFG_REG);
 
 	u32p_replace_bits(&val, pullup, LPI_GPIO_PULL_MASK);
@@ -230,11 +239,6 @@ static int lpi_config_set(struct pinctrl_dev *pctldev, unsigned int group,
 
 	lpi_gpio_write(pctrl, group, LPI_GPIO_CFG_REG, val);
 
-	if (output_enabled) {
-		val = u32_encode_bits(value ? 1 : 0, LPI_GPIO_VALUE_OUT_MASK);
-		lpi_gpio_write(pctrl, group, LPI_GPIO_VALUE_REG, val);
-	}
-
 	return 0;
 }
 
-- 
2.34.1

