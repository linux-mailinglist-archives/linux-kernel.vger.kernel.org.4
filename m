Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0CEF762BB19
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Nov 2022 12:12:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239115AbiKPLMA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Nov 2022 06:12:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54996 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232190AbiKPLL2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Nov 2022 06:11:28 -0500
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A572A3E089
        for <linux-kernel@vger.kernel.org>; Wed, 16 Nov 2022 02:58:02 -0800 (PST)
Received: by mail-wr1-x42c.google.com with SMTP id h9so29305167wrt.0
        for <linux-kernel@vger.kernel.org>; Wed, 16 Nov 2022 02:58:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DAzQ5VogwJoLM/PM812FxjEr23ojJfulgqhylS8RB/4=;
        b=du6z2HXCGLOd50YcDKiIkpDXlZWW4NN/hQ4ghIy/UBXT+OiDecIiR8HqXY+w9ENgi5
         6ezFesUKmEk0OGql+o6Dol7DkdHRJG40LluRYx0NvvPtP9wq8NtPaaiSPLV4pZHphMXQ
         DWo17mvj5u50wWXcilbGNi18syV2vumeFLBStOVOtLz4esp08vZ/DDQsGPLhwsrWKyuT
         Tudf1Y1XkeJFx0XFCogp2HF0d9M9EumJcx+OB9QaE5zoVvomPIyjUwzb22vsFJdjm2nr
         p6soSP4TFH5cpUX4PmizPH93ztTD7sbi9jNqBSeary0tU38mGScKPWJndVo17P97lXgN
         GWiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DAzQ5VogwJoLM/PM812FxjEr23ojJfulgqhylS8RB/4=;
        b=L1E2HAMog9vllnpow66TGzMFjA69EInSZteCoYEiNeT6wqvhu0WycXpkByKJNqPumD
         /4U9ueiKPMXHvNMIDqq7BM+KlZ7GFLU5j5F1IpAqWTxGXD+bqX/bFdTfZCyPG6+OwndX
         k8iN3tcoY8FlcXEzJ3Paq1ZDCKlY1gOnVsXW80hi/LrVkOeaR99AaKLLKZrxRh6HXim0
         GuGZk/pJ7pX2OIVPiKqYgL2nR2FRC5isAJ127o8vnWPtHqHYPGt+QevYMsxw11kplsc2
         po9T1k13OUwfnshH0/60s+PLop7JHZ5xBeUZgQIoagSNykmFwAgsyft0vDN4XGPS8D0V
         mwEg==
X-Gm-Message-State: ANoB5pnYuQj2AlWaCUFfMh3HkwffKU7iU/cVuE5/uRQeCbCED/hEohev
        4TPKpF0U/Byn6pym0lLkzD3NWw==
X-Google-Smtp-Source: AA0mqf5mRpvjlTZwA5aXvgYUPTW0++QM93WGLr/rBYVjgvB8DwbSzx8YSicuntUWbaKjqQdLSVtqxQ==
X-Received: by 2002:a5d:6412:0:b0:236:651d:60cb with SMTP id z18-20020a5d6412000000b00236651d60cbmr13480874wru.474.1668596281160;
        Wed, 16 Nov 2022 02:58:01 -0800 (PST)
Received: from localhost.localdomain ([94.52.112.99])
        by smtp.gmail.com with ESMTPSA id p13-20020adfe60d000000b00236e9755c02sm14935053wrm.111.2022.11.16.02.58.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Nov 2022 02:58:00 -0800 (PST)
From:   Abel Vesa <abel.vesa@linaro.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        devicetree@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>,
        Neil Armstrong <neil.armstrong@linaro.org>
Subject: [PATCH 3/4] pinctrl: qcom: add support for i2c specific pull feature
Date:   Wed, 16 Nov 2022 12:57:23 +0200
Message-Id: <20221116105724.2600349-4-abel.vesa@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20221116105724.2600349-1-abel.vesa@linaro.org>
References: <20221116105724.2600349-1-abel.vesa@linaro.org>
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
---
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

