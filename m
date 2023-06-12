Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2D34172C9D8
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Jun 2023 17:23:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239613AbjFLPXG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Jun 2023 11:23:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50160 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239489AbjFLPXB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Jun 2023 11:23:01 -0400
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com [IPv6:2a00:1450:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 890A9E5F
        for <linux-kernel@vger.kernel.org>; Mon, 12 Jun 2023 08:22:59 -0700 (PDT)
Received: by mail-wm1-x32c.google.com with SMTP id 5b1f17b1804b1-3f7ff69824dso28995535e9.1
        for <linux-kernel@vger.kernel.org>; Mon, 12 Jun 2023 08:22:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1686583378; x=1689175378;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=j2P1a0KOBTLZC+uophPc49gdJwmZcbyKH/gBQdQP/Mk=;
        b=WIUZ21+fOCK0ijBgB4RtC6H+xxxnX+qpQ6WPHdf4uRaaQRTc7KxwEbA9yqfF+uHRUV
         jU3WyzWR0iS7TbpsyOJTmDTCELfDsOqr9nOaTQgOIHZMVj5hWComsMsJQD2Cuqcr0nM7
         uf0lfV2HfUS/Ll7rzxjxboio/ACzzjQ6T2ZaHrNxta0pkhYiamNSbUNkLYkEKpyCW+li
         6SeoRQYpYzFpQhbBhUwFcpMkh5Tsz30aHG5Xa0uNxuFk62/8TtXWQHZaLFNFn/HUOEjS
         QrmXOWHv1OV/MJiCblTKgJ1FAteDI0mUHsfyjrckEAfoAlAT4+7ySCxdxvhtOvWOrEDs
         +qyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686583378; x=1689175378;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=j2P1a0KOBTLZC+uophPc49gdJwmZcbyKH/gBQdQP/Mk=;
        b=QYdSNV8dIZ8qOKxMmerh5TynoFoUlC6eCNb1AwZfEvZiY3g2qaa1BKHUDVDiOiKAXq
         cFd+1rhEfyIWKbicT1mvjsYj1cs6f7Qq65f1wD72DRA8jwwcye08biB+E09Qtj1RA88H
         NSALQLvxritaHjJio7FF0ripqYxfPPbPwXqSD4AyhFYQURKc2T+F16V9W4VDzq6rSsc7
         /ALjcMImeDv1Ad5qcaYcxT2ieY5gU0EEc8SDtUfohnh4I128cu83CQ3+21zgenji+Lmq
         fDrgY6uKFeL2Xb3HpRHdYnL1toMvn3v8FOxn0Vkp8VGTjsh5vrxFguGj4WnuS+xCltCC
         RP7Q==
X-Gm-Message-State: AC+VfDx1TPtFagZMR7m/xmfP3zf2y6x8iqemB4GdfkP4ifxv2tkBV6Th
        QeVJE3Iy8VwARqO7DY5KVWJ50w==
X-Google-Smtp-Source: ACHHUZ4A+zPVbNtrBFJx3oJ4Zf1+tvbSu37MA4+/+B8rokYRxCU/eGiUrDSAe0nOQIMHUafwojlwOA==
X-Received: by 2002:a05:600c:1c15:b0:3f7:aee8:c23a with SMTP id j21-20020a05600c1c1500b003f7aee8c23amr9973614wms.19.1686583377942;
        Mon, 12 Jun 2023 08:22:57 -0700 (PDT)
Received: from arrakeen.starnux.net ([2a01:e0a:982:cbb0:52eb:f6ff:feb3:451a])
        by smtp.gmail.com with ESMTPSA id l7-20020a7bc347000000b003f4248dcfcbsm11876512wmj.30.2023.06.12.08.22.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Jun 2023 08:22:57 -0700 (PDT)
From:   Neil Armstrong <neil.armstrong@linaro.org>
Date:   Mon, 12 Jun 2023 17:22:49 +0200
Subject: [PATCH v4 1/4] arm64: dts: qcom: pm8550: add PWM controller
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230525-topic-sm8550-upstream-pm8550-lpg-dt-v4-1-a288f24af81b@linaro.org>
References: <20230525-topic-sm8550-upstream-pm8550-lpg-dt-v4-0-a288f24af81b@linaro.org>
In-Reply-To: <20230525-topic-sm8550-upstream-pm8550-lpg-dt-v4-0-a288f24af81b@linaro.org>
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
 b=owEBbQKS/ZANAwAKAXfc29rIyEnRAcsmYgBkhzhNffOKbpqOTlJ7ehlprja6Mfz8TolaYO5f5kla
 jQvWi6uJAjMEAAEKAB0WIQQ9U8YmyFYF/h30LIt33NvayMhJ0QUCZIc4TQAKCRB33NvayMhJ0bDID/
 9nJV71LhuBdLg0LLppUmmcErYY9LFxIkgGjPtAZgImSBHKcfcvQ5P3kj6ztO9/ZCPta5fcKpwqJEOn
 e02yMocpoEuK9qTv3jIHlClAyVT/kkbZp4Kone3AVlm1iHpz11yfMH5LNc4xdwne8eMFN4E6INp2C/
 sKSQzv5vege2OzYDQfMTp3kj6gXVUjj6KAC5h+N8+DnZIymwCgUSGqDurOcJ4/UawGdPaNV64jNWdi
 rRG+Vieujrwbmqx2DIeCqKjFCxlUgYy8NpXHfg6JSKzWJpzvpEe2nuxQ7+AQksfqdUOcMSZoCMy2Sq
 LrR7E8tk41P2miFwJquH/Vgzi2Uil9ZsuaYm/Zq/cq2fky451yS8OHHQLa37218mQcwuFIBkuzu1aZ
 TkwrulhOK9tPwoFpXK8x207JlXRMgj8H6Xixd/nzyboVtg/eOilYHfEwP+57AkGw1AKW8xRqJn4n/a
 fnCjdLzdTStUl0lJf5SX8ZN7CZLcVBoYCwHCXLkLybYbAwix0c/wV3W+nOzC9aifTEF2rh4berQ0Qz
 uma/XuzoPnEW19ooSfyYr4szIZGRARqNCWhyMd5Ox4bU7g4BDcYrZcPtZYWefEZNab+LFa48DNrUMd
 MLTMrhc+HT1zH+zpavdX8OZ9wvnDJVgixjGpFacBXzmOkCIk2dFn3nBf7c6w==
X-Developer-Key: i=neil.armstrong@linaro.org; a=openpgp;
 fpr=89EC3D058446217450F22848169AB7B1A4CFF8AE
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
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

