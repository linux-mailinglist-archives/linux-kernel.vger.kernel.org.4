Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 316406B7654
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Mar 2023 12:43:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231346AbjCMLmo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Mar 2023 07:42:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50088 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231216AbjCMLmB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Mar 2023 07:42:01 -0400
Received: from mail-lf1-x12f.google.com (mail-lf1-x12f.google.com [IPv6:2a00:1450:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C36CA6507C
        for <linux-kernel@vger.kernel.org>; Mon, 13 Mar 2023 04:41:29 -0700 (PDT)
Received: by mail-lf1-x12f.google.com with SMTP id j11so15266847lfg.13
        for <linux-kernel@vger.kernel.org>; Mon, 13 Mar 2023 04:41:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1678707683;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=SCGFjRBw5kwMjl8qNpiz2QImrKHMHXlVZTsDYHugyGg=;
        b=Hevw8MpUQhJ7dhCXv28ZA3swpM0Ffb+hqVdNWZm7xQ9v9eTnnUy/32o6XO7j7DMCvz
         WaC+vdC29jTZ5FRWSXUfLjfEDGxSFHpy+Jls70apaMuK9LBi51+H22vwnLWYJBiSRF6z
         qkcu+WSSCkkrR7p8G7ydui/hvMlUDLfBnBm2Cl3a0mjpTwh05Y1q3YFpbWd6RVHZE7/K
         mnbPJ050unHHZyqS/jAE9vXjqSuKtRi0Kxh4bDqu6d/iGwuwa2jKnDhGZW0/GTWXp300
         YGvAdVwL8m7wzF6s0fT4EVx0oQa9XFbZHbwlHtkhrUUeRUENQmrp2FwEiOYpyOV+tOT8
         FGgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678707683;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SCGFjRBw5kwMjl8qNpiz2QImrKHMHXlVZTsDYHugyGg=;
        b=vW+dXy2zERTpwNX/qJH+aX83aHlBjvYc8LoRCjbSBEkuyDfy7WTd9fenSqbPVncQw8
         1cjz9JhiBEif35S2p+gcaG+znwjEKp1roUtu5fRW6bu8+kYlrskl12VmSNt5gEpeD+Kc
         PPAumQYeCl6i2pUbveBjPjlSsPQNc9fFkvQw2+JLs2MgRPFCF8Psm+p5y/wOvjBQuBLR
         iAyiyRwW1xW48GXOLjy44o+d9gSsU4DDPsjvs0OA0PT67jEOHR8pZJlWv+WX7Hz0z6po
         7GncKsn3ilPmnPR1uEyotXYcPr0IpXQT73cNAX6x251eWWoHlgrF9ChdgbE74uR4KojT
         21jg==
X-Gm-Message-State: AO0yUKUCVKOMdgQ5DoLie95PzOqSudhreYkgmSjjpNDvFB+aG6cf35Bj
        /37YBeGUkJ4sA8E1x3uXFpoqtGRrzkvYEkrZrn0=
X-Google-Smtp-Source: AK7set9p2ibp3gnxwnhhNIVY7ndNWc9bkAeYbLeGTpt+vkBn28KfcVYod45QeMaEjyMrscM/aBFR0w==
X-Received: by 2002:ac2:59dc:0:b0:4d8:537a:753f with SMTP id x28-20020ac259dc000000b004d8537a753fmr10970228lfn.6.1678707683533;
        Mon, 13 Mar 2023 04:41:23 -0700 (PDT)
Received: from [192.168.1.101] (abyj16.neoplus.adsl.tpnet.pl. [83.9.29.16])
        by smtp.gmail.com with ESMTPSA id i2-20020ac25222000000b004d86808fd33sm948465lfl.15.2023.03.13.04.41.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Mar 2023 04:41:23 -0700 (PDT)
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
Date:   Mon, 13 Mar 2023 12:41:11 +0100
Subject: [PATCH v2 5/7] arm64: dts: qcom: sc8280xp: Use the correct BWMON
 fallback compatible
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230304-topic-ddr_bwmon-v2-5-04db989db059@linaro.org>
References: <20230304-topic-ddr_bwmon-v2-0-04db989db059@linaro.org>
In-Reply-To: <20230304-topic-ddr_bwmon-v2-0-04db989db059@linaro.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Georgi Djakov <djakov@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Thara Gopinath <thara.gopinath@gmail.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Konrad Dybcio <konrad.dybcio@linaro.org>
X-Mailer: b4 0.12.1
X-Developer-Signature: v=1; a=ed25519-sha256; t=1678707675; l=790;
 i=konrad.dybcio@linaro.org; s=20230215; h=from:subject:message-id;
 bh=IfB7PpYzYG3JhtNIYAVnyF67Vej4u/Zl5gN61g/4fsQ=;
 b=qDWyQPMu7J26e1w/bsNK1rpsK3lhrpiLLXq5/I9EI6+1HEGUbVv6euLgP/9by1+5H7qdVhwNlZW7
 kgqOguKGCB5vj9r7FeUCCJ3WpOlTFXdrbgKWpw0C/QeO+LpbQe/7
X-Developer-Key: i=konrad.dybcio@linaro.org; a=ed25519;
 pk=iclgkYvtl2w05SSXO5EjjSYlhFKsJ+5OSZBjOkQuEms=
X-Spam-Status: No, score=-0.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_SORBS_HTTP,RCVD_IN_SORBS_SOCKS,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use the correct fallback compatible for the BWMONv4 with merged global and
monitor register spaces.

Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
---
 arch/arm64/boot/dts/qcom/sc8280xp.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/qcom/sc8280xp.dtsi b/arch/arm64/boot/dts/qcom/sc8280xp.dtsi
index 0d02599d8867..131b99bfe771 100644
--- a/arch/arm64/boot/dts/qcom/sc8280xp.dtsi
+++ b/arch/arm64/boot/dts/qcom/sc8280xp.dtsi
@@ -2946,7 +2946,7 @@ opp-12 {
 		};
 
 		pmu@90b6400 {
-			compatible = "qcom,sc8280xp-cpu-bwmon", "qcom,msm8998-bwmon";
+			compatible = "qcom,sc8280xp-cpu-bwmon", "qcom,sdm845-bwmon";
 			reg = <0 0x090b6400 0 0x600>;
 
 			interrupts = <GIC_SPI 581 IRQ_TYPE_LEVEL_HIGH>;

-- 
2.39.2

