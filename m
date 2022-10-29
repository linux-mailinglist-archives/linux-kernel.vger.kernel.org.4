Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4AA51612065
	for <lists+linux-kernel@lfdr.de>; Sat, 29 Oct 2022 07:15:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229536AbiJ2FPt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 29 Oct 2022 01:15:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57936 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229919AbiJ2FPc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 29 Oct 2022 01:15:32 -0400
Received: from mail-pj1-x1033.google.com (mail-pj1-x1033.google.com [IPv6:2607:f8b0:4864:20::1033])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7EC0480F79
        for <linux-kernel@vger.kernel.org>; Fri, 28 Oct 2022 22:15:25 -0700 (PDT)
Received: by mail-pj1-x1033.google.com with SMTP id 3-20020a17090a0f8300b00212d5cd4e5eso11627679pjz.4
        for <linux-kernel@vger.kernel.org>; Fri, 28 Oct 2022 22:15:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=13oRY/sJIuQu8AJysTZUoL4QlYr6gHWdZr1jQCWlKvg=;
        b=WK5U34jSA8tZwmx18wVECaY4LGtf/lXQmwJJQxIGbDWKIZqFcB7UuYr5N4YCs4w6Z6
         7k/mCPQQJy+vfPIuOwbqdTwaw6gJZ+In/IjhAt53Ks9f02sFvEekglrv/yF46QEQ9xye
         D0GtVt7YOE/zp0Scr7pJ6N4e7dhUPi6zyRcUWmrpwqqJEWbRWvwmzsm05jjBVyqoTFrM
         pWFtNeCzN8+7NeeIah2FUAQTdLhlmJgfxX7d3OoD7ArYwlvPJe3FHWTe6ArJtzin5MH/
         VnmvyRKwdK3v0Fz7kG2dErYCsytBsykOE/KLKGVm69YkOqwFgMyxfM0k8eeuUPSMqiF9
         6++Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=13oRY/sJIuQu8AJysTZUoL4QlYr6gHWdZr1jQCWlKvg=;
        b=HUJlkvOt2GuQysafUnN/KMNmpk7/xX4Sx2hPXHLBRb1Th3dzjWXO0B2/p463Jb0odQ
         bMmwBPTOMxJjKoBWtlXTgCzU8Kli7btw+HMWCDERibbxx1fuSwenyEbN29GPGIexu3Zt
         158fC1KXgbEigXratdypyLx/g5ZZbl37LP3ZyHzVPKSHu5dvleiOx63KxBr97cLkUgZa
         0y3kzLqYk1uCt7EdW9h/akVPgjV1FC4MR9j9MIOeBzptmnfsGdTXlYKMA4zoBozmeh9Y
         PPrIXRQ6rySXw+TS/3+kqCAnMjJm6l8HKTfFhjfGKth9teUqqt8Iz0OaDExr96T/R6Vv
         P94w==
X-Gm-Message-State: ACrzQf3SzO/e2jDTQShQezHKfW8m7WR46oMY4Yv0Pg+Yp9YjlxXDo5y5
        sfTWrEzXZVQoA68g+gEIlGSO
X-Google-Smtp-Source: AMsMyM6CnK89B6pxZ4CzDHc3nDVhyNHzpGFlm4Zs/m2+knER3jPEF5p8mEK5T32GNZkox9prR+SSRg==
X-Received: by 2002:a17:902:c407:b0:17f:8bec:e7f4 with SMTP id k7-20020a170902c40700b0017f8bece7f4mr2683732plk.156.1667020525201;
        Fri, 28 Oct 2022 22:15:25 -0700 (PDT)
Received: from localhost.localdomain ([59.92.103.167])
        by smtp.gmail.com with ESMTPSA id f5-20020a170902ce8500b0017e9b820a1asm363150plg.100.2022.10.28.22.15.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Oct 2022 22:15:24 -0700 (PDT)
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     andersson@kernel.org
Cc:     konrad.dybcio@somainline.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, johan+linaro@kernel.org,
        quic_jprakash@quicinc.com, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        steev@kali.org,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH v2 04/12] arm64: dts: qcom: sc8280xp-pmics: Add support for PMK8280 RESIN input
Date:   Sat, 29 Oct 2022 10:44:41 +0530
Message-Id: <20221029051449.30678-5-manivannan.sadhasivam@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20221029051449.30678-1-manivannan.sadhasivam@linaro.org>
References: <20221029051449.30678-1-manivannan.sadhasivam@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The RESIN input can be used to reset the PMK8280 PMIC. Enabling the
RESIN block allows the PMK8280 to detect reset input via RESIN_N pin.

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
---
 arch/arm64/boot/dts/qcom/sc8280xp-pmics.dtsi | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/sc8280xp-pmics.dtsi b/arch/arm64/boot/dts/qcom/sc8280xp-pmics.dtsi
index 397ff4995003..4a3464f5e6e9 100644
--- a/arch/arm64/boot/dts/qcom/sc8280xp-pmics.dtsi
+++ b/arch/arm64/boot/dts/qcom/sc8280xp-pmics.dtsi
@@ -68,6 +68,12 @@ pmk8280_pon_pwrkey: pwrkey {
 				linux,code = <KEY_POWER>;
 				status = "disabled";
 			};
+
+			pmk8280_pon_resin: resin {
+				compatible = "qcom,pmk8350-resin";
+				interrupts = <0x0 0x13 0x6 IRQ_TYPE_EDGE_BOTH>;
+				status = "disabled";
+			};
 		};
 	};
 
-- 
2.25.1

