Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2F79B7345EC
	for <lists+linux-kernel@lfdr.de>; Sun, 18 Jun 2023 13:44:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229777AbjFRLox (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 18 Jun 2023 07:44:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53820 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229762AbjFRLov (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 18 Jun 2023 07:44:51 -0400
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com [IPv6:2a00:1450:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E54F410D0
        for <linux-kernel@vger.kernel.org>; Sun, 18 Jun 2023 04:44:48 -0700 (PDT)
Received: by mail-ej1-x62b.google.com with SMTP id a640c23a62f3a-987accb4349so208007566b.0
        for <linux-kernel@vger.kernel.org>; Sun, 18 Jun 2023 04:44:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1687088687; x=1689680687;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=E2l62kT3eiLEXqJg8CxMuWY141wzPG/hn4e3QVCnoRo=;
        b=whUyseXZjMZhBSfuawXlWU0LfE0rSHAdHQOKBNAIR+CrxT7m1V70RciIGp+YM6yHAO
         6HBjvZg59OnFQ4FTYrhHWz5++OfJmZjh/N1fMrMG1FYn+jIlnvSs16EKkW38KUlxWgio
         twb0wyP77TH8tW4/r30MLeOnFhuNQ9SbU2FJOTXg8m34sdv0HKH3NlW9bzL0L8rea+5X
         7+SfIZjHdAkxwP9JjrWJeeUFZvoQhXWdST7kMH8kfsm8/k77iwPEhnpRzgTCMT+zKXOY
         cPycoOoQ4QcAEbwMvox/Y1BPmrDkEgwXjUsIdQ+5Rs1r5HRxRTVYJ+6mzBdG0kstlCtA
         ytVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687088687; x=1689680687;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=E2l62kT3eiLEXqJg8CxMuWY141wzPG/hn4e3QVCnoRo=;
        b=YSR/24+49yyNKLAQfTgO+99yjR+Uyma+Hv/ntUO5gRdvdiSc2Q8vlTwZKBvrzMihcA
         bw3vTZe6SbAOseKoG9yaU8OuKauiawhKKgOr9qTxS1bUwXQq3n0Tt0M9VaZIS7wJdim7
         9V3qH0lTKpoENmCBx5wgdOtgpp5DGYV1tIM+/c5iruQrTxF/ppBqi5w3BAjxrN7lKyYF
         NMqVlCafJy/fPkl2MZwo7xtLgH2zqtd4iWV+9HbLeztnxjTi9M+wtZk/e8s0oKwx0edo
         uTnzMNhbdGtGtgDhV/OD0zgT8dDrw06LBxWA2LoowFV274PEeA2V6Hxsh2x54Qo3aULX
         XGug==
X-Gm-Message-State: AC+VfDy9eivODf7O5p6UyQI5m6TxSVJvWdYkKCQjtJphhxcsEzdRmzRn
        +In57Nrb6X0/o/zHtVDM/gp/zg==
X-Google-Smtp-Source: ACHHUZ7OkwHwZ354uyf5KpKgxVBy17PLodEGLL3XG9b4tYp1rBqRcUayxXIOn5EkFUKTc1VIZ7I1Gw==
X-Received: by 2002:a17:907:7e91:b0:973:cb21:8479 with SMTP id qb17-20020a1709077e9100b00973cb218479mr7048460ejc.70.1687088687234;
        Sun, 18 Jun 2023 04:44:47 -0700 (PDT)
Received: from krzk-bin.. ([178.197.219.26])
        by smtp.gmail.com with ESMTPSA id p4-20020a1709060dc400b0096f937b0d3esm13183854eji.3.2023.06.18.04.44.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 18 Jun 2023 04:44:46 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Tony Luck <tony.luck@intel.com>,
        "Guilherme G. Piccoli" <gpiccoli@igalia.com>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH 1/7] arm64: dts: qcom: sm8350-hdk: correct FSA4480 port
Date:   Sun, 18 Jun 2023 13:44:36 +0200
Message-Id: <20230618114442.140185-1-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

FSA4480 has only one port according to bindings:

  sm8350-hdk.dtb: typec-mux@42: 'port' is a required property

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 arch/arm64/boot/dts/qcom/sm8350-hdk.dts | 13 +++----------
 1 file changed, 3 insertions(+), 10 deletions(-)

diff --git a/arch/arm64/boot/dts/qcom/sm8350-hdk.dts b/arch/arm64/boot/dts/qcom/sm8350-hdk.dts
index b182f4cf06cc..95a2a42ccb9e 100644
--- a/arch/arm64/boot/dts/qcom/sm8350-hdk.dts
+++ b/arch/arm64/boot/dts/qcom/sm8350-hdk.dts
@@ -349,16 +349,9 @@ typec-mux@42 {
 		mode-switch;
 		orientation-switch;
 
-		ports {
-			#address-cells = <1>;
-			#size-cells = <0>;
-
-			port@0 {
-				reg = <0>;
-
-				fsa4480_sbu_mux: endpoint {
-					remote-endpoint = <&pmic_glink_sbu>;
-				};
+		port {
+			fsa4480_sbu_mux: endpoint {
+				remote-endpoint = <&pmic_glink_sbu>;
 			};
 		};
 	};
-- 
2.34.1

