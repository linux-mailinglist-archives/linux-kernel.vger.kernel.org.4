Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D9CDA6B8CBF
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Mar 2023 09:13:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230505AbjCNIMA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Mar 2023 04:12:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50260 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229454AbjCNILG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Mar 2023 04:11:06 -0400
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com [IPv6:2a00:1450:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 47FFB99272
        for <linux-kernel@vger.kernel.org>; Tue, 14 Mar 2023 01:09:37 -0700 (PDT)
Received: by mail-ed1-x52c.google.com with SMTP id x3so58395003edb.10
        for <linux-kernel@vger.kernel.org>; Tue, 14 Mar 2023 01:09:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1678781370;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VaFooc3ZqmiLvzci4fl/GeYapWLW5sp3t92Xl0ir5ig=;
        b=Yb6sdRjE21qgkIpYWILXnkm1lGY5yV2b+fgqw86+RykRblzHE1b0uF6MW8txOqzlPI
         SROLIDnX97wLME5XKT9Pp+u+E7mJUDrDBo6ftguehFvVY0kYq2o1tR4eMagsb+kZ4Exw
         egX4JnfAH3pv+gV6T8iinoTwlQJZyE8YBdimgQag0cj9cnKzWzirgFZQygwOBPlryAhq
         hOIA+qPlMjJ4LAUpRAyhfLi8IwE5JJVVUjBmBRjnVyQ+CA4h2lKiw9MA8xgFQLfQR+YH
         uM1X1WmG9rtiDburkS4DtVMyoz2yh0FrtonxnH8NH+LLlntxrQUFkwy5DJY4fYqFMn8n
         egzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678781370;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VaFooc3ZqmiLvzci4fl/GeYapWLW5sp3t92Xl0ir5ig=;
        b=C5aM8KlbJ4yJ48s4kJMrRr4Kx4xAiogMqhtRN8WSy6vr211ksODir++9ErvMz45kUH
         IHQ6moMdZPzvZOyOhKX1zlM+cyKjo2cxhLUKFODD+YwIvTPV69hJlZDsdghoXEUjdS7R
         FQvL0ydYevp6OmCQXzz3WQnXzEMOQDRs3eVaauO48fpx5ExNA916lcyfKU5GdFKgJ5rl
         3bujJlbCLJe61bW8O0QkeiRZVoyR3TuTsFvxGDo6xNhwYlo1qaU5PDj/IXwinLEBBnk0
         Q9bLAXuimfCd61eYr/oVIok4Lo8aFM5lbxsX+4vIeUCDFMxRo/UqqXAheNyWXrsIhYMD
         +8Ug==
X-Gm-Message-State: AO0yUKWQLpe/gtWBeOsTkzO+h/N/Z3MAoJAmajhIUv671a1MilVJ2SAY
        K4DqgAvH9bBfWKZzaCag3UC85A==
X-Google-Smtp-Source: AK7set/APHfoUuZWf2pafjAXejZ5leY1DkdX5DUsjX2PBOWYgQ4UfykW1CWAtP7k2shcSQrXc554aw==
X-Received: by 2002:a05:6402:12d5:b0:4fe:1b62:4741 with SMTP id k21-20020a05640212d500b004fe1b624741mr762069edx.28.1678781369949;
        Tue, 14 Mar 2023 01:09:29 -0700 (PDT)
Received: from krzk-bin.. ([2a02:810d:15c0:828:6932:5570:6254:9edd])
        by smtp.gmail.com with ESMTPSA id co2-20020a0564020c0200b004fce9ff4830sm584872edb.88.2023.03.14.01.09.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Mar 2023 01:09:29 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Jassi Brar <jassisinghbrar@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Manivannan Sadhasivam <mani@kernel.org>,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH v2 11/13] arm64: dts: qcom: qcs404: add compatible fallback to mailbox
Date:   Tue, 14 Mar 2023 09:09:15 +0100
Message-Id: <20230314080917.68246-12-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230314080917.68246-1-krzysztof.kozlowski@linaro.org>
References: <20230314080917.68246-1-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

QCS404 mailbox is compatible with MSM8916.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 arch/arm64/boot/dts/qcom/qcs404.dtsi | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/qcom/qcs404.dtsi b/arch/arm64/boot/dts/qcom/qcs404.dtsi
index bc2ed73afb74..e4fdc40be821 100644
--- a/arch/arm64/boot/dts/qcom/qcs404.dtsi
+++ b/arch/arm64/boot/dts/qcom/qcs404.dtsi
@@ -1302,7 +1302,8 @@ intc: interrupt-controller@b000000 {
 		};
 
 		apcs_glb: mailbox@b011000 {
-			compatible = "qcom,qcs404-apcs-apps-global", "syscon";
+			compatible = "qcom,qcs404-apcs-apps-global",
+				     "qcom,msm8916-apcs-kpss-global", "syscon";
 			reg = <0x0b011000 0x1000>;
 			#mbox-cells = <1>;
 			clocks = <&apcs_hfpll>, <&gcc GCC_GPLL0_AO_OUT_MAIN>;
-- 
2.34.1

