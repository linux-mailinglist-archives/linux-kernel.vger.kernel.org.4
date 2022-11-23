Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 37E6163633C
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Nov 2022 16:20:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238266AbiKWPUc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Nov 2022 10:20:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56524 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238751AbiKWPUL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Nov 2022 10:20:11 -0500
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1BB589209C
        for <linux-kernel@vger.kernel.org>; Wed, 23 Nov 2022 07:20:10 -0800 (PST)
Received: by mail-wr1-x433.google.com with SMTP id x17so16418627wrn.6
        for <linux-kernel@vger.kernel.org>; Wed, 23 Nov 2022 07:20:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KN2/QtlLjs6UFWl8nj+yt8+0EJtSW1V4HYBBliOcWZU=;
        b=vASi9wIAwi7NyOC+JAIYezcqoYjpHTurwdRxp58vNKtT/4omMKwrmGjE4iTV4anhri
         OJ3CM7aGpLB27L5O5GqxOED2u/yexkYN4wsEXNzjZuzMkTFQu59j9vq/w736GI7M5chL
         8y/1Wa0MNkKXH5jGV/k/4bfpeya3yHS2n2kzJTV8UY6znWO40gXSj8DkTQ+QzvbTWKJ+
         R/YQToWISv9XZzJjG4lBeIAdS03dghBBllawSeVm4JvqFp9iFvh7jg8/OjotIGeMNHzJ
         OLnH40F1wkeq0asTs4sNHdU+cXlN25BQcNHxdb3ASAmiGVw7FZBmO0zwp4sx5CCT3Fp6
         d49g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KN2/QtlLjs6UFWl8nj+yt8+0EJtSW1V4HYBBliOcWZU=;
        b=NQuugKMQJTJMqO19s+Qd0b5muLw7rwYs2fi492IWftIqjMRVm8m0UJPzqaMw6wRGF1
         eHWN8ufCfQA0W0qPiQy/AUSPb98azD4T6drgwYFuWKNQn59SYKZebkWRybxlfFYIsnXP
         UPxJb7SeK0UV81rEtD65B2bxhSy37Tnqidfm8+M8Glf7D9Wej4H1dG2GlJOE3djOahy4
         oAMfxd7B0tTZCEEQjWbKKCrvTyFlPfZ9isOc9Lm11HA/JjL05I4jBIzXG+rulFvLj5VO
         x7SXW0ghF6qO7tc3MgMOpd898CKFNeanVqUnYJDhw8g+Jh62hwDflGWRf9rGgLlUboss
         KejQ==
X-Gm-Message-State: ANoB5plMa1lh9RSs5ieBPaMBU/m8iTxLQnl51O4q/Kyn5yk8MLiaJec2
        JOB4y1OPmNkP15rtiRi28PIFAw==
X-Google-Smtp-Source: AA0mqf682lXAmgko7RMtxcHSFtApXR2SzqfBO+7Ao5r3yKfKG1PzE/P+1F7t9fIu2vjjipJtd/QXCQ==
X-Received: by 2002:a5d:52d0:0:b0:241:c340:d1ea with SMTP id r16-20020a5d52d0000000b00241c340d1eamr10748919wrv.434.1669216809572;
        Wed, 23 Nov 2022 07:20:09 -0800 (PST)
Received: from localhost.localdomain ([94.52.112.99])
        by smtp.gmail.com with ESMTPSA id l10-20020adff48a000000b002366ded5864sm16764914wro.116.2022.11.23.07.20.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Nov 2022 07:20:09 -0800 (PST)
From:   Abel Vesa <abel.vesa@linaro.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        devicetree@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>,
        Neil Armstrong <neil.armstrong@linaro.org>
Subject: [PATCH v2 3/4] pinctrl: qcom: add support for i2c specific pull feature
Date:   Wed, 23 Nov 2022 17:20:00 +0200
Message-Id: <20221123152001.694546-4-abel.vesa@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20221123152001.694546-1-abel.vesa@linaro.org>
References: <20221123152001.694546-1-abel.vesa@linaro.org>
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

From: Neil Armstrong <neil.armstrong@linaro.org>

Add support for the new i2c_pull property introduced for SM8550 setting
a I2C specific pull mode on I2C able pins.

Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
Signed-off-by: Abel Vesa <abel.vesa@linaro.org>
---

Changes since v1:
 * Added my missing Signed-off-by tag

 drivers/pinctrl/qcom/pinctrl-msm.c | 20 ++++++++++++++++++++
 drivers/pinctrl/qcom/pinctrl-msm.h |  1 +
 2 files changed, 21 insertions(+)

diff --git a/drivers/pinctrl/qcom/pinctrl-msm.c b/drivers/pinctrl/qcom/pinctrl-msm.c
index 8fbb953c4bbe..f92082c1c805 100644
--- a/drivers/pinctrl/qcom/pinctrl-msm.c
+++ b/drivers/pinctrl/qcom/pinctrl-msm.c
@@ -83,6 +83,12 @@ struct msm_pinctrl {
 	u32 phys_base[MAX_NR_TILES];
 };
 
+#define PIN_CONFIG_QCOM_I2C_PULL	(PIN_CONFIG_END + 1)
+
+static const struct pinconf_generic_params msm_pinconf_custom_bindings[] = {
+	{"qcom,i2c-pull", PIN_CONFIG_END + 1, 0},
+};
+
 #define MSM_ACCESSOR(name) \
 static u32 msm_readl_##name(struct msm_pinctrl *pctrl, \
 			    const struct msm_pingroup *g) \
@@ -324,6 +330,12 @@ static int msm_config_reg(struct msm_pinctrl *pctrl,
 		*bit = g->oe_bit;
 		*mask = 1;
 		break;
+	case PIN_CONFIG_QCOM_I2C_PULL:
+		if (g->i2c_pull_bit == 0)
+			return -EOPNOTSUPP;
+		*bit = g->i2c_pull_bit;
+		*mask = 1;
+		break;
 	default:
 		return -ENOTSUPP;
 	}
@@ -415,6 +427,9 @@ static int msm_config_group_get(struct pinctrl_dev *pctldev,
 			return -EINVAL;
 		arg = 1;
 		break;
+	case PIN_CONFIG_QCOM_I2C_PULL:
+		arg = 1;
+		break;
 	default:
 		return -ENOTSUPP;
 	}
@@ -498,6 +513,9 @@ static int msm_config_group_set(struct pinctrl_dev *pctldev,
 			/* disable output */
 			arg = 0;
 			break;
+		case PIN_CONFIG_QCOM_I2C_PULL:
+			arg = 1;
+			break;
 		default:
 			dev_err(pctrl->dev, "Unsupported config parameter: %x\n",
 				param);
@@ -1495,6 +1513,8 @@ int msm_pinctrl_probe(struct platform_device *pdev,
 	pctrl->desc.name = dev_name(&pdev->dev);
 	pctrl->desc.pins = pctrl->soc->pins;
 	pctrl->desc.npins = pctrl->soc->npins;
+	pctrl->desc.custom_params = msm_pinconf_custom_bindings;
+	pctrl->desc.num_custom_params = ARRAY_SIZE(msm_pinconf_custom_bindings);
 
 	pctrl->pctrl = devm_pinctrl_register(&pdev->dev, &pctrl->desc, pctrl);
 	if (IS_ERR(pctrl->pctrl)) {
diff --git a/drivers/pinctrl/qcom/pinctrl-msm.h b/drivers/pinctrl/qcom/pinctrl-msm.h
index 05a1209bf9ae..985eceda2517 100644
--- a/drivers/pinctrl/qcom/pinctrl-msm.h
+++ b/drivers/pinctrl/qcom/pinctrl-msm.h
@@ -80,6 +80,7 @@ struct msm_pingroup {
 
 	unsigned pull_bit:5;
 	unsigned drv_bit:5;
+	unsigned i2c_pull_bit:5;
 
 	unsigned od_bit:5;
 	unsigned egpio_enable:5;
-- 
2.34.1

