Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2E71B60F041
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Oct 2022 08:31:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234220AbiJ0GbU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Oct 2022 02:31:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45068 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234577AbiJ0Gav (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Oct 2022 02:30:51 -0400
Received: from mail-pl1-x62d.google.com (mail-pl1-x62d.google.com [IPv6:2607:f8b0:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 71315148F7C
        for <linux-kernel@vger.kernel.org>; Wed, 26 Oct 2022 23:30:45 -0700 (PDT)
Received: by mail-pl1-x62d.google.com with SMTP id l2so425768pld.13
        for <linux-kernel@vger.kernel.org>; Wed, 26 Oct 2022 23:30:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZD6r12BofDfMgshCtZ+x4zSd8OgAoRs881lTnCMffo8=;
        b=UmS84iZZyYlSpKMV3I2lmbjnEjx6AbCEBKgDOfr6rzdWwVxbw6kJ+w9Z7zlJbRKHcS
         euh5S+4gqhRZotWk7VryNY4IH+GDX32XnvJdVWxuoxsAFvDeF6Gro6QIxcCTIqWRAEhV
         EhXK45SjN93Qo2VRnG5u6FzECajU/AOJSAEoM3Ttex2Dj6P7yJNARhldBgj97Fyfpwla
         hLsWLHJZVEOeWlo8w97HLqaiVhx+WNNs22n+/N1JpEs+5Udu01Z2jElQ+VDDZGo/FViu
         /g+mJ5/gU9N/7XoO1LnaRhDfqUHbyGwvs8qERwSFA2Ma7enmJra2Zr8fjVE6xzKr1Ya4
         +OrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZD6r12BofDfMgshCtZ+x4zSd8OgAoRs881lTnCMffo8=;
        b=kkOrVi82VQPClWX4x73cfMBlwUX7qJxMOZvQI6ythMWw6pupjT65t6zPe5lUYBRuva
         pP9FudHZqqT0OtsqJw/C759vtucaXGYgZAFS51OiRKrIRsYtLvQz3OFvwmCezNDPwGJ4
         2bB9avT2qJdVju+qjq7vQRrcIY0itvpKleaqCOEKamNOEGfYfFx7YpIiEv7dUN8Mj1FX
         pnf3MOD7BjuQ6m65Ah2mzhHpHW/qoErSlG69Bc7rW4mzbuOPQw2Km4g0TL1tNLWKde55
         mqyJpdPTLZRsAhjafJvBD2dcVIpBs6YlC5KgMCUJt8kqI+bBxJJ1l9daffsLCu1UKAQK
         waqA==
X-Gm-Message-State: ACrzQf2WhH3zUGKKTYf8TD/KolCjQu4kU+ydSysvUZu5J1Jkh9RbtKFW
        5d6bUAHmEu9/nodKEbgHwF41
X-Google-Smtp-Source: AMsMyM5/BRnhLD1/POnH2o8+4lTLOnQKGYMNks0Au1ojeG2JeWh0lViZbDdiQg6EImy7dTTzQ0wKBQ==
X-Received: by 2002:a17:902:e810:b0:186:e9ff:4ec2 with SMTP id u16-20020a170902e81000b00186e9ff4ec2mr2910960plg.26.1666852245107;
        Wed, 26 Oct 2022 23:30:45 -0700 (PDT)
Received: from localhost.localdomain ([117.193.208.123])
        by smtp.gmail.com with ESMTPSA id i126-20020a626d84000000b00561d79f1064sm446041pfc.57.2022.10.26.23.30.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Oct 2022 23:30:44 -0700 (PDT)
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     andersson@kernel.org
Cc:     konrad.dybcio@somainline.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, johan+linaro@kernel.org,
        quic_jprakash@quicinc.com, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Subject: [PATCH 06/11] arm64: dts: qcom: sc8280xp-pmics: Add support for TM5 block in PMK8280
Date:   Thu, 27 Oct 2022 12:00:01 +0530
Message-Id: <20221027063006.9056-7-manivannan.sadhasivam@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20221027063006.9056-1-manivannan.sadhasivam@linaro.org>
References: <20221027063006.9056-1-manivannan.sadhasivam@linaro.org>
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

Thermal Monitoring block ADC5 (TM5) in PMK8280 can be used to monitor the
temperature from slave PMICs like PM8280.

Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
---
 arch/arm64/boot/dts/qcom/sc8280xp-pmics.dtsi | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/sc8280xp-pmics.dtsi b/arch/arm64/boot/dts/qcom/sc8280xp-pmics.dtsi
index 32086d5edd0d..d55f0a9cea61 100644
--- a/arch/arm64/boot/dts/qcom/sc8280xp-pmics.dtsi
+++ b/arch/arm64/boot/dts/qcom/sc8280xp-pmics.dtsi
@@ -86,6 +86,16 @@ pmk8280_vadc: adc@3100 {
 			#io-channel-cells = <1>;
 			io-channel-ranges;
 		};
+
+		pmk8280_adc_tm: adc-tm@3400 {
+			compatible = "qcom,spmi-adc-tm5-gen2";
+			reg = <0x3400>;
+			interrupts = <0x0 0x34 0x0 IRQ_TYPE_EDGE_RISING>;
+			#address-cells = <1>;
+			#size-cells = <0>;
+			#thermal-sensor-cells = <1>;
+			status = "disabled";
+		};
 	};
 
 	pmc8280_1: pmic@1 {
-- 
2.25.1

