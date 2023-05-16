Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BE81670516C
	for <lists+linux-kernel@lfdr.de>; Tue, 16 May 2023 17:02:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234065AbjEPPC0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 May 2023 11:02:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33224 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233766AbjEPPCP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 May 2023 11:02:15 -0400
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com [IPv6:2a00:1450:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE5A15BA0
        for <linux-kernel@vger.kernel.org>; Tue, 16 May 2023 08:02:13 -0700 (PDT)
Received: by mail-ed1-x52e.google.com with SMTP id 4fb4d7f45d1cf-50bd37ca954so8170674a12.0
        for <linux-kernel@vger.kernel.org>; Tue, 16 May 2023 08:02:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1684249332; x=1686841332;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EW6F/zPBbypHWDTGQl44KAM/klcDgb6LbEcAMdPHpO4=;
        b=CCwVB9hCZ10YwDiFV+bl+/dNzmxglHroRkpL3TygJd9izEuGXi0RX4RMincFf2sKPT
         mVvojcTwe/lq45vzUnY6pW4t7ogLr9nvbU84dwexK40fbmXm4sD/Tl4HsaqB2rBEqx2L
         2XR2kOd24PfkodCgd1BX/s9+4EURL8y54TWn/XA6X+zB8R4BVSJZRE85BfNkyF27jvbb
         /f2oRoP2oxB6yNDC1gueW9+RJIxGDUHIgNd56xL+FdoOKByXSQVcdk4xiFW/ubx8uxX6
         CgFVZy7+XLi0lzYwTYeZ6jnLCvJOV9B/yVCPspOLA9vKV7itAT//TdXFbZ3cqP4gxlIs
         gzYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684249332; x=1686841332;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=EW6F/zPBbypHWDTGQl44KAM/klcDgb6LbEcAMdPHpO4=;
        b=KyEbWzUFwxsrC9gq9XTzpdhzJQjFXmkPQ9v9Y8RMaCk9R6kmB+mqIB/Hk/e2fzovis
         AEOvzU5ZmF7Rl4crbMsFZ+a2eVFk+datlQSaeypvpkddhTwt10mWrlF6JbFUq5j6ChtP
         O7HiowKVgRQi+gFPGYdKJw52d6E/vUyEl75zbpVSma2QNHm+uUubeu+QN//5Wcsd2gUQ
         FbMXpihfm+0lhAA1kvEKJpbTerxhVjDu7wxwOA1vETS8JLwTB8iBDsGtKJoymW6rZL/9
         OxvfGQd8zH4YzXwisoFma2gX0imti7n2wq0/FdFnr96SV5rZYZqR4g6Xip/m2+UhFPR/
         RGbg==
X-Gm-Message-State: AC+VfDzmKnNyDr7ez0Jv/FNzWYWnfFeF2y7NMvuQlJnMNXouJ069FExf
        sOQNji/bUeQvcA8tyd20ZnxGkA==
X-Google-Smtp-Source: ACHHUZ4RoHylUFACTNPVTpfQwulbKXPzLTkVoGQ4VYmlSdw7riw8YJzFNBNn5v4KK69iknDnLCtojg==
X-Received: by 2002:a17:907:c17:b0:965:ae3a:52c8 with SMTP id ga23-20020a1709070c1700b00965ae3a52c8mr38020261ejc.32.1684249332030;
        Tue, 16 May 2023 08:02:12 -0700 (PDT)
Received: from krzk-bin.. ([2a02:810d:15c0:828:77d1:16a1:abe1:84fc])
        by smtp.gmail.com with ESMTPSA id q24-20020a170906541800b0096aa7d25a65sm6361810ejo.23.2023.05.16.08.02.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 May 2023 08:02:11 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Pavel Machek <pavel@ucw.cz>, Lee Jones <lee@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Fenglin Wu <quic_fenglinw@quicinc.com>,
        linux-arm-msm@vger.kernel.org, linux-leds@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Neil Armstrong <neil.armstrong@linaro.org>,
        "Signed-off-by : Abel Vesa" <abel.vesa@linaro.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH 2/3] arm64: dts: qcom: pm8550: add flash LED controller
Date:   Tue, 16 May 2023 17:02:01 +0200
Message-Id: <20230516150202.188655-2-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230516150202.188655-1-krzysztof.kozlowski@linaro.org>
References: <20230516150202.188655-1-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add node for PM8550 PMIC flash LED controller.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 arch/arm64/boot/dts/qcom/pm8550.dtsi | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/pm8550.dtsi b/arch/arm64/boot/dts/qcom/pm8550.dtsi
index 46396ec1a330..33f357a80636 100644
--- a/arch/arm64/boot/dts/qcom/pm8550.dtsi
+++ b/arch/arm64/boot/dts/qcom/pm8550.dtsi
@@ -55,5 +55,11 @@ pm8550_gpios: gpio@8800 {
 			interrupt-controller;
 			#interrupt-cells = <2>;
 		};
+
+		pm8550_flash: led-controller@ee00 {
+			compatible = "qcom,pm8550-flash-led", "qcom,spmi-flash-led";
+			reg = <0xee00>;
+			status = "disabled";
+		};
 	};
 };
-- 
2.34.1

