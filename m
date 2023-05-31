Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D450D717FCC
	for <lists+linux-kernel@lfdr.de>; Wed, 31 May 2023 14:22:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235484AbjEaMWj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 May 2023 08:22:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33458 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232442AbjEaMWf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 May 2023 08:22:35 -0400
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C252133
        for <linux-kernel@vger.kernel.org>; Wed, 31 May 2023 05:22:33 -0700 (PDT)
Received: by mail-wm1-x32e.google.com with SMTP id 5b1f17b1804b1-3f61530506aso60078125e9.1
        for <linux-kernel@vger.kernel.org>; Wed, 31 May 2023 05:22:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1685535752; x=1688127752;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=j2P1a0KOBTLZC+uophPc49gdJwmZcbyKH/gBQdQP/Mk=;
        b=Zdw8uHEtVlDvG7XIhyPgvMxycM+cTDjhIplug6Ydmn++s/x4qi4GD79wkEQOZkFuIR
         H13zD0C8iYVISCNdfYBa1DOYzxkNiUJ+0iOf7x1vXG812D0QidAGZWAk3Ts3/MeRNshR
         shOJG1rs3BzMBDijdoMMfWmYQ/KNM40m903EY71WinOAkcIgmReefD4DnY1lFYPZNRLM
         IKV0gGRrXb1PDQVJ44K3luXfnO2p0NwtnFytoOhFAYCijAo+wK33x+o2qF+bJri7Jh4N
         5OU9CY9QjmEuKqbQLhtK7GAo6gAO/QVwHMYsIF3ajyVL2RjDzvdAq/FFiOkEvEotTmFC
         yOOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685535752; x=1688127752;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=j2P1a0KOBTLZC+uophPc49gdJwmZcbyKH/gBQdQP/Mk=;
        b=RutbAlI2FdFin4fJ0yGBHn+ZGQX4nqmSsrXexSGRvWyWlUF20Xxww+ShjqE/ScCXBd
         wqNXXoV/NqVNCQLDr3mphgWOXPZPTfSGXYeb88bu24ek3vltiPW4+HBBgOE0VBpHcaVm
         Ga7lkTCBK3l/MjZbZLfHpAkZROGy8qiVKi0G5AEmP7h7Es2AY+VOj/wxrcPv1NnI9tfU
         z8qa8dDlrSpHW98dCShEWaspu18xDwHDexvhEnYwUhL3gxNTCDf+q2tUpu+kRw2atZE7
         3UhixJI6yXHX59VkRlWd/yvVt5w3wdRralhoa3NngdEP0k1F/pQjCg7JkySSx0lbJVt9
         atYg==
X-Gm-Message-State: AC+VfDzh4naKvh4U/mk58xY/FHJn1SWzAD+41p3drRcaKuipSgh6Xkyr
        gD3UlfTClOzn7nVCMJfoopfesg==
X-Google-Smtp-Source: ACHHUZ7yhlm+DU+BkVtByjSGiASi/vgFdDBbXodD/4i8SIg78Md0L9bugJqVe08iS93p1Dq3kKwqKA==
X-Received: by 2002:adf:f4d2:0:b0:30a:e69d:721e with SMTP id h18-20020adff4d2000000b0030ae69d721emr4036810wrp.55.1685535751991;
        Wed, 31 May 2023 05:22:31 -0700 (PDT)
Received: from arrakeen.starnux.net ([2a01:e0a:982:cbb0:52eb:f6ff:feb3:451a])
        by smtp.gmail.com with ESMTPSA id n7-20020adfe347000000b00309382eb047sm6637954wrj.112.2023.05.31.05.22.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 31 May 2023 05:22:31 -0700 (PDT)
From:   Neil Armstrong <neil.armstrong@linaro.org>
Date:   Wed, 31 May 2023 14:22:24 +0200
Subject: [PATCH v2 1/4] arm64: dts: qcom: pm8550: add PWM controller
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230525-topic-sm8550-upstream-pm8550-lpg-dt-v2-1-a3b890604c49@linaro.org>
References: <20230525-topic-sm8550-upstream-pm8550-lpg-dt-v2-0-a3b890604c49@linaro.org>
In-Reply-To: <20230525-topic-sm8550-upstream-pm8550-lpg-dt-v2-0-a3b890604c49@linaro.org>
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
 b=owEBbQKS/ZANAwAKAXfc29rIyEnRAcsmYgBkdzwEechUNw3QDs71LQJsZ22oe+/Y/U00wFZNBn7R
 mV2J5/SJAjMEAAEKAB0WIQQ9U8YmyFYF/h30LIt33NvayMhJ0QUCZHc8BAAKCRB33NvayMhJ0XsXD/
 9kO9O82GbZoxvCiYaGDqdPBvUoFeFS3W202hQRzm8KHdKarI/InaqdUpCEvYDxGeWOiTL+e+c5H083
 HFGmvWj4OcbzyhkJ9gF34mTFjiNWBRP8uAG7/GbdGyKNdNPI1zPwIbxh5FowEDi9lXRvEPeyM6AKnw
 uMN9bOEVARWUrFO9i8MtYinajeOml8bzUVaf+ZtZMqlQ/9sATX6M0wU5vYhYxlRQBkNSxG5NDFCjx6
 WyPFQfCrqtT0QRtUiNuQOxGgOPGJdJ5nZ1ZQ9rgzu66BOOaTKVsPfpW1xExr3DpdXLWHWtwXe3A0co
 nFHoruSPLP8FS4g5F22k9I20lPEiVj1GsCnQQj93gMSo8nWohHgtRXRGtoCuY2T5d1sVuOBYQ3troh
 AepXwAqNfDoJQGwvvCJyEScRcNVPZpfKzMOsbqNoXFZU5F8b77kA0K+pOXlHRdbFbG2nTrQlDHYfVe
 SLfuOkwqSY7A/FcWUFXN9s/HT7KuPpJec+cePgIZpg5+mt4FkMEX2P4vt0VSljBydNmiRjgLQYKbfI
 3UpSAJTxvjIqkxiHJmVzu8TiSJKwcgKOQWCWPS5d+pPdn2lV84KnlACv+7y5267B6+syJjZicdh+IF
 FtW5zmYNZ+lGpMeQy+naOvqVI8F2oO9azZTiNgKYzdKkl7Z7vU1eUu+Mm7uQ==
X-Developer-Key: i=neil.armstrong@linaro.org; a=openpgp;
 fpr=89EC3D058446217450F22848169AB7B1A4CFF8AE
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
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

