Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C1D506A81BC
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Mar 2023 12:58:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229993AbjCBL6i (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Mar 2023 06:58:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57644 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229919AbjCBL6c (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Mar 2023 06:58:32 -0500
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5FAA1D33B
        for <linux-kernel@vger.kernel.org>; Thu,  2 Mar 2023 03:58:03 -0800 (PST)
Received: by mail-wr1-x435.google.com with SMTP id bw19so16229331wrb.13
        for <linux-kernel@vger.kernel.org>; Thu, 02 Mar 2023 03:58:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1677758274;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=53i6n/4N8iPHrAE+4akf4+FY/Eqzip/AN+jA8SQFls4=;
        b=HVXAXJS37D1r4M20G4fME7mQhMV/po3gK33mAgGd9ONtA1KJIUHhUUYz7SaUJ6JKan
         IYYZDZ5wCctvMCvxmUQGx6iooPIXQFxc8rPZOc5lFqLSiF1pPfoHaIVSd1ZhtbxVFoaW
         96FDNf3QSRrqCdrQd8Wev47LdWAHKYJGiGXzgEr2Jp/E2P0JhAB8E0NedQ9TW4wXcBx4
         IB+3B12W/AK2pPxT2lq6xI1bQ/SMiWslE9uXvjNLpfGT+2DY7a8Y56PWF3xCOyI/K2jL
         vLAk8GpcurSNSbo8q9k4DE0gX7uusTyf88CgnXbxgljv0c/DsuTiSOLYT8Ol/mz3l9Qb
         LcTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1677758274;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=53i6n/4N8iPHrAE+4akf4+FY/Eqzip/AN+jA8SQFls4=;
        b=zoH4NIhDSPaLGdGm2gNLKW/kvZbmrYy7W6e7Gqhlz9d5pNO2iTQ3QYqDq+eNaSA16R
         UrZPsNCR/54jqQKQnHFmeqiK6fs/5qenPPD2ESBRi1sjKfzM7DU6A9caXaBhMVPFNAlo
         QjE7r2G8qO+VqT2kulgmwUS+EZ8DsZgM2jcrP3R+hnI91/qDrLi5BU1946qKAivNCHFj
         xDpQ+QBz6D3yYxXyUfBszOJmhwx8XlFEhS6/04FEGcECLgNp1YGLnvqyAfZBtPoYlzTb
         Nit8nNfocw128xpR+MdqBeqDxyF+1M0FDGTdi5HGy8DnGZqh2Tq5em4sfzX43gDxpUm6
         QQcQ==
X-Gm-Message-State: AO0yUKW0ZY48rKSN1gAkUF/SoWpxFXDiFqhOb6KpLh5VtuJ5QcCy7xxA
        yxZTFF1GoufNHW4np389maq7kg==
X-Google-Smtp-Source: AK7set9JGhaVMVq1Aun7eorGLllXN0G+3ZY9aQjvAJK+0twIdWlGMLKeCpK9OMroCb5jMJzggb2DpQ==
X-Received: by 2002:a5d:5141:0:b0:2c7:1a96:efcd with SMTP id u1-20020a5d5141000000b002c71a96efcdmr7390210wrt.1.1677758274590;
        Thu, 02 Mar 2023 03:57:54 -0800 (PST)
Received: from localhost.localdomain ([5.133.47.210])
        by smtp.gmail.com with ESMTPSA id v16-20020a5d4a50000000b002c5526234d2sm15298209wrs.8.2023.03.02.03.57.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Mar 2023 03:57:54 -0800 (PST)
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
To:     agross@kernel.org, andersson@kernel.org
Cc:     robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        konrad.dybcio@linaro.org, johan+linaro@kernel.org,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: [PATCH 4/4] arm64: dts: qcom: sc8280xp-x13s: fix va dmic dai links and routing
Date:   Thu,  2 Mar 2023 11:57:41 +0000
Message-Id: <20230302115741.7726-5-srinivas.kandagatla@linaro.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20230302115741.7726-1-srinivas.kandagatla@linaro.org>
References: <20230302115741.7726-1-srinivas.kandagatla@linaro.org>
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

VA dmics 0, 1, 2 micbias on X13s are connected to WCD MICBIAS1, WCD MICBIAS1
and WCD MICBIAS3 respectively. Reflect this in dt to get dmics working.
Also fix dmics to go via VA Macro instead of TX macro to fix device switching.

Fixes: 8c1ea87e80b4 ("arm64: dts: qcom: sc8280xp-x13s: Add soundcard support")
Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
---
 .../arm64/boot/dts/qcom/sc8280xp-lenovo-thinkpad-x13s.dts | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/arm64/boot/dts/qcom/sc8280xp-lenovo-thinkpad-x13s.dts b/arch/arm64/boot/dts/qcom/sc8280xp-lenovo-thinkpad-x13s.dts
index d18d405d1776..89230112e288 100644
--- a/arch/arm64/boot/dts/qcom/sc8280xp-lenovo-thinkpad-x13s.dts
+++ b/arch/arm64/boot/dts/qcom/sc8280xp-lenovo-thinkpad-x13s.dts
@@ -933,9 +933,9 @@
 		"VA DMIC0", "MIC BIAS1",
 		"VA DMIC1", "MIC BIAS1",
 		"VA DMIC2", "MIC BIAS3",
-		"TX DMIC0", "MIC BIAS1",
-		"TX DMIC1", "MIC BIAS2",
-		"TX DMIC2", "MIC BIAS3",
+		"VA DMIC0", "VA MIC BIAS1",
+		"VA DMIC1", "VA MIC BIAS1",
+		"VA DMIC2", "VA MIC BIAS3",
 		"TX SWR_ADC1", "ADC2_OUTPUT";
 
 	wcd-playback-dai-link {
@@ -986,7 +986,7 @@
 	va-dai-link {
 		link-name = "VA Capture";
 		cpu {
-			sound-dai = <&q6apmbedai TX_CODEC_DMA_TX_3>;
+			sound-dai = <&q6apmbedai VA_CODEC_DMA_TX_0>;
 		};
 
 		platform {
-- 
2.21.0

