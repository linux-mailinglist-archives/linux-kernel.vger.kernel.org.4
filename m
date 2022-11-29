Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4E45263C316
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Nov 2022 15:47:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234605AbiK2Org (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Nov 2022 09:47:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52568 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235806AbiK2OrM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Nov 2022 09:47:12 -0500
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com [IPv6:2a00:1450:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB8A75ADE0
        for <linux-kernel@vger.kernel.org>; Tue, 29 Nov 2022 06:47:09 -0800 (PST)
Received: by mail-wm1-x329.google.com with SMTP id p16so11100515wmc.3
        for <linux-kernel@vger.kernel.org>; Tue, 29 Nov 2022 06:47:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=w96//s+DKsR2vwyM7MoWsFHf/kzUOoVxQJ2TCTp4km0=;
        b=yZJdU9OOS10xuzdTBDJAB1arlFacY86knILTzyQTIuV1zhEy/8aqVq2PPZ+zDL1bI/
         Lav85J5Up9GG5X/zW2+6jO7CYYfMLr5yT972WiefBMCs5dwvIcq8aN+ngUN1kixVpbAU
         OiigE/mvpX39zvEUgb2X+OcSCD0gvQB/E7bq6xp3VNxi8Uw8/Id2A1na6fiKaP1LNG4V
         QBOcrcFuDCCAC3wEHhmz6B/zZ6YNE3VNc92WBzD2Uvte+04NUKixesOqoY/US+ld6I1w
         YJTWaWU0lXeFpTdoz8/X+BxxJ6CChveUS6e0Lvdc2k8Mjj/2ph+B8zf+rCxnmRqcQAO5
         /vHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=w96//s+DKsR2vwyM7MoWsFHf/kzUOoVxQJ2TCTp4km0=;
        b=nfjcJH4z7HmfjJcZ76g3vJQTtgyWw+/uDcsFm9SdtdwVQPB/idH+qcqYSdcsOja55s
         rS9nvPMQ14EyOv4uxUnqnIPmUfC7hPy3uD081sictYapORROOfRymEkwHz4cxBR3caHB
         dexQYTBcjnUg3XbWQROsJhWqtof0gYQEoNpQhCcwOVy7DBV3D1B4qbL26KNszU8vNUjx
         LZ/6osAz3j81zBnn+WTAwmkHlvi327G6mW9SVdKHfQ/fjsGcTZB3HFQrEj2pC8bCWVXF
         4qBfzAIDGGYlXwzR8fOxF8E8IQQGeqTTPBaBCQfVA4RPhDUaE6FiJQdBor+721agjVwt
         T11w==
X-Gm-Message-State: ANoB5plBCX6AhpHAF7/Vvjkf5kun8n/iqJ9xiuRamFJf2jxWgoJCdzga
        FJIr9IMq3pZCKy1+zR+sBLa2Yw==
X-Google-Smtp-Source: AA0mqf65YCv6tYbHaZxuQ7jBOY87eTUd4c3oTjMIGAQFqjwxUy5tR1kBl6jtFQtEZ0MWf/GgspX2ZQ==
X-Received: by 2002:a05:600c:348d:b0:3cf:88e7:f808 with SMTP id a13-20020a05600c348d00b003cf88e7f808mr27769285wmq.200.1669733228387;
        Tue, 29 Nov 2022 06:47:08 -0800 (PST)
Received: from arrakeen.starnux.net ([2a01:e0a:982:cbb0:52eb:f6ff:feb3:451a])
        by smtp.gmail.com with ESMTPSA id b10-20020adfee8a000000b00241dec4ad16sm13717792wro.96.2022.11.29.06.47.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Nov 2022 06:47:08 -0800 (PST)
From:   Neil Armstrong <neil.armstrong@linaro.org>
Date:   Tue, 29 Nov 2022 15:47:06 +0100
Subject: [PATCH v3 6/6] i2c: qcom-geni: add support for I2C Master Hub variant
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20221114-narmstrong-sm8550-upstream-i2c-master-hub-v3-6-f6a20dc9996e@linaro.org>
References: <20221114-narmstrong-sm8550-upstream-i2c-master-hub-v3-0-f6a20dc9996e@linaro.org>
In-Reply-To: <20221114-narmstrong-sm8550-upstream-i2c-master-hub-v3-0-f6a20dc9996e@linaro.org>
To:     Bjorn Andersson <andersson@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Andy Gross <agross@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        linux-i2c@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Neil Armstrong <neil.armstrong@linaro.org>
X-Mailer: b4 0.10.1
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The I2C Master Hub is a stripped down version of the GENI Serial Engine
QUP Wrapper Controller but only supporting I2C serial engines without
DMA support.

Add the I2C Master Hub serial engine compatible along the specific
requirements in a new desc struct passed through the device match data.

Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
Reviewed-by: Konrad Dybcio <konrad.dybcio@linaro.org>
---
 drivers/i2c/busses/i2c-qcom-geni.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/i2c/busses/i2c-qcom-geni.c b/drivers/i2c/busses/i2c-qcom-geni.c
index 75dd0718c5a1..bfe75038bc14 100644
--- a/drivers/i2c/busses/i2c-qcom-geni.c
+++ b/drivers/i2c/busses/i2c-qcom-geni.c
@@ -1026,8 +1026,16 @@ static const struct dev_pm_ops geni_i2c_pm_ops = {
 									NULL)
 };
 
+const struct geni_i2c_desc i2c_master_hub = {
+	.has_core_clk = true,
+	.icc_ddr = NULL,
+	.no_dma_support = true,
+	.tx_fifo_depth = 16,
+};
+
 static const struct of_device_id geni_i2c_dt_match[] = {
 	{ .compatible = "qcom,geni-i2c" },
+	{ .compatible = "qcom,geni-i2c-master-hub", .data = &i2c_master_hub },
 	{}
 };
 MODULE_DEVICE_TABLE(of, geni_i2c_dt_match);

-- 
b4 0.10.1
