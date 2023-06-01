Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4F4B7719825
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Jun 2023 12:02:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233271AbjFAKCq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Jun 2023 06:02:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42580 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233015AbjFAKB5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Jun 2023 06:01:57 -0400
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A00AE10F3
        for <linux-kernel@vger.kernel.org>; Thu,  1 Jun 2023 03:00:59 -0700 (PDT)
Received: by mail-wr1-x430.google.com with SMTP id ffacd0b85a97d-30aea656e36so616756f8f.1
        for <linux-kernel@vger.kernel.org>; Thu, 01 Jun 2023 03:00:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1685613658; x=1688205658;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=j2P1a0KOBTLZC+uophPc49gdJwmZcbyKH/gBQdQP/Mk=;
        b=z67+0LqJbeZdArlPgOiRRp1Om2PEw7NUeeTtdlz1hCpKuI6gYwwCO+Ynz3nt4hiU6J
         4bCAkSWu4cGijdnt+R/FslOBvkgrM8LeIA5zgzsb1LtvmIDc5Xed8tDad72o+Nu6yQgr
         pCNE9bwGXlDx4qu2BFLq8GKpvrETBWVmk6WQaQHs2qJx+/nAyfSxh6a9XfsG7aHFJjFy
         79xIyaJ4zy1wJ1ro3T3M+4JvJWuvEs1+16m0TXcWbA1cjRL84LQVouJ2gbmIkkqywmQj
         E3PHJoFi+v79IO0lgY956FYnn6JvQTUv+CE3Qd4tIe2jRdNH76Zhhgl0nPPSeh0hYdfT
         jaIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685613658; x=1688205658;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=j2P1a0KOBTLZC+uophPc49gdJwmZcbyKH/gBQdQP/Mk=;
        b=J7GqviE5tG46TWcB3GLui2yWZWOlzIM8dMObPyhUYd1g8qCli7qzEpfYZCdKPyua9r
         K+1/G4ZdEEV9PhpN8RqbUyC4H+MGh9UlTDUK0zrrOqIaW7NKJW1avP28TmDWMHuh2Qmg
         widJ+jeONSIpFc681gY1HXmR3MX4ppbTPGIgmuaJR+bp2n32ZZUzsaW+kpPaEaITzz20
         p61AljBd0rxKspCWwCLpx1CjZOY8J13gfvePWPhj/hkFTz7T2n0bj6ubXCbnPISWuzoW
         vVqPP1+i2Vd3iEJInD8kBbQj+BJUT2c88DDBRiySSjoenGhCte1hFEuMtnTbhqoUGuvX
         fexQ==
X-Gm-Message-State: AC+VfDxJe9Maq8Xz8pXgESdaTr8qZ76S6wHtwcm5pX/eHYDlrJhLuXVj
        7Y9ckdxIhNWGj7NluXv6JmAFqnvIn+cYfRM5rVEg5g==
X-Google-Smtp-Source: ACHHUZ7XvtDk6mDx6XYfqTSGwDefzNTqRKLox4v/gA0M+CqIS/2xUcfgYKvQxJL70QJP/E98fZr7pg==
X-Received: by 2002:a5d:54c9:0:b0:309:3e1e:fa21 with SMTP id x9-20020a5d54c9000000b003093e1efa21mr1318119wrv.51.1685613657904;
        Thu, 01 Jun 2023 03:00:57 -0700 (PDT)
Received: from arrakeen.starnux.net ([2a01:e0a:982:cbb0:8261:5fff:fe11:bdda])
        by smtp.gmail.com with ESMTPSA id l13-20020adff48d000000b003064088a94fsm9708543wro.16.2023.06.01.03.00.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Jun 2023 03:00:57 -0700 (PDT)
From:   Neil Armstrong <neil.armstrong@linaro.org>
Date:   Thu, 01 Jun 2023 12:00:52 +0200
Subject: [PATCH v3 1/4] arm64: dts: qcom: pm8550: add PWM controller
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230525-topic-sm8550-upstream-pm8550-lpg-dt-v3-1-8823ee43f3fc@linaro.org>
References: <20230525-topic-sm8550-upstream-pm8550-lpg-dt-v3-0-8823ee43f3fc@linaro.org>
In-Reply-To: <20230525-topic-sm8550-upstream-pm8550-lpg-dt-v3-0-8823ee43f3fc@linaro.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>
Cc:     linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Neil Armstrong <neil.armstrong@linaro.org>
X-Mailer: b4 0.12.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=875;
 i=neil.armstrong@linaro.org; h=from:subject:message-id;
 bh=AHgyGipOMjlGOCP8Y/c8QiME6jknRqzIvtxw7+SzMLM=;
 b=owEBbQKS/ZANAwAKAXfc29rIyEnRAcsmYgBkeGxW0RZxkHeCkcW/hzt4+u2vkeGe6JzA2wd9Jw66
 V4/RDtaJAjMEAAEKAB0WIQQ9U8YmyFYF/h30LIt33NvayMhJ0QUCZHhsVgAKCRB33NvayMhJ0U87D/
 0dcwsQNCsNsitgmyg8fY70wwtj1xFS0pRmh+KBhKbaD52lhe+4hDEH+TR0zD3dZYKSytd2K8aw1oro
 On5X3eCJNH0SjE11yr7DlZp6coqszodxVwu0TvBlOf5hQPi+bKcRNH5hReyu1V5sf9hDd6vyhaPWP+
 MrzScSKIWuNavA3jtvyN/dGNIkTxnwFJMULdD3n+CeWnLXwN7Y6OX3zgAsdbYGngujpJEZtbiudJMk
 jWub8OErxxgeYGdEiPRAMnpuRKQrPFxdZCa4ZNH/GvqPYMjyjOvs/L90aWLVE/eMu80a+YQJY41ekh
 xnc2yqdRZiHykayNz73VtBrVXKkEAD4Kwksdzj6sUt3nCTsyJOQYw8/4mzybijDeid77lUIwMOF020
 4s3PHR3zkjngHUkecRmzM+r2bO3FqSaHMTmHXNwJioa8zHq3jMSYpFaD69gNUmAng+ijlS4tpNMk17
 EkcNV4fI/o8neaC4Kh7N6AnWRJyPrk/4dMpKIjOa/1sZVIAhH0pepEcIjYsY+LAksfBsYpivAtnmDj
 vuSyeE4WmS0bHLSFCEO0zoOLEsX3XUZLfolIGcfQEJVBwOYOfa9rjrhAvRPzqfxamFFt9uquC+Y+Qk
 Pqrid/byIBxw+wObxWDwoTO0+VPHoBu5RRqBD0cBCnuZ/8jpoqRwZ8Skikvg==
X-Developer-Key: i=neil.armstrong@linaro.org; a=openpgp;
 fpr=89EC3D058446217450F22848169AB7B1A4CFF8AE
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add the PWM function to the pm8550 dtsi, this is usually used
to drive RGB leds on platforms using this PMIC.

Reviewed-by: Konrad Dybcio <konrad.dybcio@linaro.org>
Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
---
 arch/arm64/boot/dts/qcom/pm8550.dtsi | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/pm8550.dtsi b/arch/arm64/boot/dts/qcom/pm8550.dtsi
index 33f357a80636..db3d5c17a77d 100644
--- a/arch/arm64/boot/dts/qcom/pm8550.dtsi
+++ b/arch/arm64/boot/dts/qcom/pm8550.dtsi
@@ -61,5 +61,15 @@ pm8550_flash: led-controller@ee00 {
 			reg = <0xee00>;
 			status = "disabled";
 		};
+
+		pm8550_pwm: pwm {
+			compatible = "qcom,pm8550-pwm", "qcom,pm8350c-pwm";
+
+			#address-cells = <1>;
+			#size-cells = <0>;
+			#pwm-cells = <2>;
+
+			status = "disabled";
+		};
 	};
 };

-- 
2.34.1

