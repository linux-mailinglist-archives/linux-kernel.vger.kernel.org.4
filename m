Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 58C22710FED
	for <lists+linux-kernel@lfdr.de>; Thu, 25 May 2023 17:48:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241709AbjEYPrw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 May 2023 11:47:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39258 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241776AbjEYPrq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 May 2023 11:47:46 -0400
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5FB7A19A
        for <linux-kernel@vger.kernel.org>; Thu, 25 May 2023 08:47:45 -0700 (PDT)
Received: by mail-wr1-x432.google.com with SMTP id ffacd0b85a97d-3093d10442aso1554325f8f.1
        for <linux-kernel@vger.kernel.org>; Thu, 25 May 2023 08:47:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1685029664; x=1687621664;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=6W6z3yseUW0ZEUXSC4TnDkmT5+0hex5HR1TgWJvB5Vg=;
        b=dXc0/xfrpw6K8JIFSoad4GyekZbfACRBdkSEGOM+MP5KMQKFmORNuGRUFQg31Imt0j
         hFSRDAPE+IngrkaD2GgLt1XuRSV200E/Zob8cYPDZYaXoPUs0Y0uM55PFBjsYoKzx6dD
         8AEl6EwbjN0nMKwLlqnFZIJwaTYoEUyG5EnFq2eXmdcGPoXDLVl9xs46X+2aWvLbKUsC
         ihB7raXKBlLAWfdDFsgQc5i0S5YZDmvBxiC4tB/nloDiu1u4d9Aaz6BbpHMewb8BAB4g
         qr0AmLajIbQjEKcLJIHGYvqfg1rd+1KmQmSDSKMtXCArM+KF94SoleBpKea7bCeHb7Hu
         B32A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685029664; x=1687621664;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6W6z3yseUW0ZEUXSC4TnDkmT5+0hex5HR1TgWJvB5Vg=;
        b=eTzUQ6zb+kCrzVFS+WZ9XqmzTNMXZs440LcBQyVBKgrRZGFw3sFRamBgt/INFEcr3z
         6U8YzuH2OiXpO8s/9+c+LNyAdIbNFfZOv05YjzHtQe480YtrXVqb5MsSgNC/5d3zhLjT
         hPZj4gqW8SiL8rXnuIkXpKxsIFXZiGA714S/m2bu+Gyg8rrbmOIgue23tnEyT+IxUG+I
         3DFv5ZtIQmbr+VlOZiXUo4I5ZmTfyKAZXOEN9Yf/PKYEKKY7nDPpJlu7CMBC7X2cNYDt
         QOtB0qcfe65SfOE7/2Q6poCWF28ATjsoQxj0Es+ux9vBx0Uk4ijidpao+w7QbOxYsUET
         qKAw==
X-Gm-Message-State: AC+VfDxJgz5ZCAq/hLpkCDvzggj08OnHmrRnHazvZCQQCwCedaWR7Kd0
        t6do5dHeFgQmhm+8h1ivXhja0A==
X-Google-Smtp-Source: ACHHUZ79BqD6Z2l7IjTTPg7mydbmaAYbxh1JlyDrA3g7lfkSN0/gJQdmvvl5XF4FnCERQ0VMVi0XuQ==
X-Received: by 2002:a05:6000:10cf:b0:309:4f23:e52d with SMTP id b15-20020a05600010cf00b003094f23e52dmr3053481wrx.43.1685029663893;
        Thu, 25 May 2023 08:47:43 -0700 (PDT)
Received: from arrakeen.starnux.net ([2a01:e0a:982:cbb0:8261:5fff:fe11:bdda])
        by smtp.gmail.com with ESMTPSA id b3-20020a5d5503000000b002ca864b807csm2275873wrv.0.2023.05.25.08.47.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 May 2023 08:47:43 -0700 (PDT)
From:   Neil Armstrong <neil.armstrong@linaro.org>
Date:   Thu, 25 May 2023 17:47:36 +0200
Subject: [PATCH 2/4] arm64: dts: qcom: sm8550-qrd: add notification RGB LED
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230525-topic-sm8550-upstream-pm8550-lpg-dt-v1-2-4d5d7602f290@linaro.org>
References: <20230525-topic-sm8550-upstream-pm8550-lpg-dt-v1-0-4d5d7602f290@linaro.org>
In-Reply-To: <20230525-topic-sm8550-upstream-pm8550-lpg-dt-v1-0-4d5d7602f290@linaro.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1094;
 i=neil.armstrong@linaro.org; h=from:subject:message-id;
 bh=VN0b6yYDeCqIJw88Yxteguvzp1g40067w/aqfqr4Wb4=;
 b=owEBbQKS/ZANAwAKAXfc29rIyEnRAcsmYgBkb4MbzmE/LZCBiUmXoX5AEsmQgizJBa0B1WTsuR8k
 zYEusuCJAjMEAAEKAB0WIQQ9U8YmyFYF/h30LIt33NvayMhJ0QUCZG+DGwAKCRB33NvayMhJ0R0ZD/
 9jB3pJtPJzH35clvFkBoH2QptMDQ/E/T2NPHrCT0RAMn0siMkKyovzjCwiYNIQN88j9O6/lK5/65LF
 /ZE/zItTV4k1Pzcylam3DTsdO6rBn/EFXLTxPCzlLN5W1ri2y1np13V5oeleFX7dJJzjbljmlWhVrj
 JRpOyvnYH+v7CCQ2/GUv+/L2zpqy0j/VSnz2HDZTFhDRmgmlvbbM9HHA4I147I999FAVdv/1M5yBcf
 DCGMgXP0uKPbE86g5s9pNn9BscuNXqML79e6sldDhXMetTB08nyHVGwoKy88V7AyWxI9GhullcV1pz
 h/uUKNeUdDtSINjmuhgKpgFQMwj2azNgCeDsyH1C95Bvb3Ofyc+yyVgtbkyTQlKVnTE4H2h9DGBB69
 +PVhCtlxSJo+ci45ST7k8tWTOFEMgHFaUR5WZd9jfShunJcLPA5fTyZuH/exprXXOeBIzPo/Udx8Db
 mRz1YSJE3+pYcHjAzDdZQu5EzmBqHZTRycAyp22VBU7+OG+vFlUm5weO1UN4Y25qGzl7vyHXvBj8Bj
 tR+BlWL62Aqy+3byF9Bj5G/romm873gPxTPzfPCSE70Axfhs9IbCTLyYmUzbSf4eujEYjJSTQUWdt5
 wSaJn00mI+CGv0O6uipOZnDL/zACQHoY+1u6rwdv3cjcyiL/TcDpYByhjKpg==
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

The QRD features a notification LED connected to the pm8550.
Configure the RGB led controlled by the PMIC PWM controller.

Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
---
 arch/arm64/boot/dts/qcom/sm8550-qrd.dts | 27 +++++++++++++++++++++++++++
 1 file changed, 27 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/sm8550-qrd.dts b/arch/arm64/boot/dts/qcom/sm8550-qrd.dts
index ff61b8b36853..4a8177f99523 100644
--- a/arch/arm64/boot/dts/qcom/sm8550-qrd.dts
+++ b/arch/arm64/boot/dts/qcom/sm8550-qrd.dts
@@ -450,6 +450,33 @@ led-1 {
 	};
 };
 
+&pm8550_pwm {
+	status = "okay";
+
+	multi-led {
+		color = <LED_COLOR_ID_RGB>;
+		function = LED_FUNCTION_STATUS;
+
+		#address-cells = <1>;
+		#size-cells = <0>;
+
+		led@1 {
+			reg = <1>;
+			color = <LED_COLOR_ID_RED>;
+		};
+
+		led@2 {
+			reg = <2>;
+			color = <LED_COLOR_ID_GREEN>;
+		};
+
+		led@3 {
+			reg = <3>;
+			color = <LED_COLOR_ID_BLUE>;
+		};
+	};
+};
+
 &pm8550b_eusb2_repeater {
 	vdd18-supply = <&vreg_l15b_1p8>;
 	vdd3-supply = <&vreg_l5b_3p1>;

-- 
2.34.1

