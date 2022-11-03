Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 65C0A61773D
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Nov 2022 08:10:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231196AbiKCHKV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Nov 2022 03:10:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44998 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231132AbiKCHJ7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Nov 2022 03:09:59 -0400
Received: from mail-pf1-x430.google.com (mail-pf1-x430.google.com [IPv6:2607:f8b0:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 28D06DEF3
        for <linux-kernel@vger.kernel.org>; Thu,  3 Nov 2022 00:09:58 -0700 (PDT)
Received: by mail-pf1-x430.google.com with SMTP id q9so844383pfg.5
        for <linux-kernel@vger.kernel.org>; Thu, 03 Nov 2022 00:09:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JthYgOPJ8wLY+kJmpPo6YRkYw++3oIBC9/8kQpa43wk=;
        b=oqa2VR9xM7LgVSNeC59MrGPOve0uvlM/fYcJg4WIl+XyrrmYrNORIBh0taFvj7UFIH
         /izDRvXpS7JYP8andHnU7pV2PSKeLlDucZzPBloaRZ1/NFKMrVCSysRxRcmJ582IHFHg
         jUAUtquqZkHh1PrfSinyLc/L17ETX98Zf5WB440e5zfby9z+mkSwgDn1IzQfEXtt3tbE
         hDx9UY8UVQdNAuH+rtlF46qViU+fiXrteEQBE5WfxZXAx4xMR6AmbyXfY9tWmuP2tWI5
         8Xyxd/0zzSsE7jhYyI+uiphql2CRxUcCa/eb9twN6rXwS5QCdtjkR2WmUvoC8/zQbjsR
         oh5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JthYgOPJ8wLY+kJmpPo6YRkYw++3oIBC9/8kQpa43wk=;
        b=5SnuPgqMcH7MzY0v+1LA5aT/iiCYIXjC50lbCo0ZOOSanfGZjRKcwnFvXpI/Xar1uL
         oc5RSOKL+UHks+2NhI7rqREB2sLpJlMcNfHOrEMi6xmKiqAhMvvYH6+4z4OHiHKo93KM
         VIPueSfhZ12ltI3HVh2yy5Fk19G50XMFbMjTqMqYfc5B6JKtsrK0zJ6rwvetR4STAWhK
         C4CpiLWWftPRgWyBjhgJKefXr02c8x2cX+C4pB7TWRdEkBoS9GE6MnENO0m8onroej86
         hk67UVuB0rqh9jGKn+LAn5LPQJQAP75BMUUDmliZXSljUsnN+dagOj3PyruKKjsBCPdx
         91NA==
X-Gm-Message-State: ACrzQf1yWKkkm2rKZAQRW8te5p6CHEWUPOE0F8rdol1eCZbpsRc1FKV2
        LW0XkHpFn17A94tEgVYvxMa6
X-Google-Smtp-Source: AMsMyM6cUWZGog+Q3n/SQktIYFBOMxAyQ0e5FfsXA2Ts0Vfp96sI51AJBJh1v2hEToxAkBP4nZowGA==
X-Received: by 2002:a05:6a00:1253:b0:56d:8742:a9ff with SMTP id u19-20020a056a00125300b0056d8742a9ffmr18618778pfi.5.1667459397638;
        Thu, 03 Nov 2022 00:09:57 -0700 (PDT)
Received: from localhost.localdomain ([117.193.208.64])
        by smtp.gmail.com with ESMTPSA id s9-20020a170903214900b00186748fe6ccsm9451244ple.214.2022.11.03.00.09.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Nov 2022 00:09:56 -0700 (PDT)
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     andersson@kernel.org
Cc:     konrad.dybcio@somainline.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, johan+linaro@kernel.org,
        quic_jprakash@quicinc.com, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        steev@kali.org,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH v3 05/12] arm64: dts: qcom: sc8280xp-pmics: Add PMK8280 ADC7 block
Date:   Thu,  3 Nov 2022 12:39:04 +0530
Message-Id: <20221103070911.20019-6-manivannan.sadhasivam@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20221103070911.20019-1-manivannan.sadhasivam@linaro.org>
References: <20221103070911.20019-1-manivannan.sadhasivam@linaro.org>
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

Add support for ADC7 block available in PMK8280 for reading the
temperature via the AMUX pins.

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Reviewed-by: Konrad Dybcio <konrad.dybcio@somainline.org>
Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
---
 arch/arm64/boot/dts/qcom/sc8280xp-pmics.dtsi | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/sc8280xp-pmics.dtsi b/arch/arm64/boot/dts/qcom/sc8280xp-pmics.dtsi
index 4a3464f5e6e9..b1cdde2f7861 100644
--- a/arch/arm64/boot/dts/qcom/sc8280xp-pmics.dtsi
+++ b/arch/arm64/boot/dts/qcom/sc8280xp-pmics.dtsi
@@ -75,6 +75,16 @@ pmk8280_pon_resin: resin {
 				status = "disabled";
 			};
 		};
+
+		pmk8280_vadc: adc@3100 {
+			compatible = "qcom,spmi-adc7";
+			reg = <0x3100>;
+			interrupts = <0x0 0x31 0x0 IRQ_TYPE_EDGE_RISING>;
+			#address-cells = <1>;
+			#size-cells = <0>;
+			#io-channel-cells = <1>;
+			status = "disabled";
+		};
 	};
 
 	pmc8280_1: pmic@1 {
-- 
2.25.1

