Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A46AA641C2F
	for <lists+linux-kernel@lfdr.de>; Sun,  4 Dec 2022 10:44:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230101AbiLDJoz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 4 Dec 2022 04:44:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58114 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230042AbiLDJop (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 4 Dec 2022 04:44:45 -0500
Received: from mail-lf1-x135.google.com (mail-lf1-x135.google.com [IPv6:2a00:1450:4864:20::135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D06018B27
        for <linux-kernel@vger.kernel.org>; Sun,  4 Dec 2022 01:44:44 -0800 (PST)
Received: by mail-lf1-x135.google.com with SMTP id p8so14160908lfu.11
        for <linux-kernel@vger.kernel.org>; Sun, 04 Dec 2022 01:44:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DoQ6CQ4V9lgvMnNOweePTBqtltjrmYKf98Qn9cRfYv4=;
        b=bkK0jr6rB1JDSQulz3Jgo1u6StXcdfr11XR878MIeX21zP/X9zh6bAZE+91SxJvZ1F
         bm3UoisJzCnTBuaT4KtCW6IraqdtnU1QAiro56HCB7Z6ybh5SdFEcbURJ62MQTITAX7e
         QbBErl8Qscps4sQE9Dz1j3zXf2yzaVpLKbtEmkSSOPVjB45uDV7lt7lHNzx6YS7UIFLZ
         5qZRhTjm1r8Dt7x4aJOzQDooEPTsxa2mtZFW7C9Xa1cyvqEHhFcxKIhIDr6/eOuUxuFo
         sywbrxVJswO7TLHeRdRKfwdTaFVnx4DC58YsIOraFJ4XfBcW52tN2t5ulT9Tcvj9qKrT
         D4HQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DoQ6CQ4V9lgvMnNOweePTBqtltjrmYKf98Qn9cRfYv4=;
        b=4hlxiHY9SN3Tcmna0iLjKx7J8ID8B9rT1PScsasaGvY9AqiA9tuWyMuP7a1QlpreqA
         LhVg7V52riDBgkzTrVGyoCENUoV0gOGoz7OcKqXtfmSWE9AcCEfrxCJ6oh/dBBLkiOKG
         UcQ/SLQH8KbSaFk9d+Dzb+jWm5ZzJoqt4uadrgEw0tkhvCIOBC7S5dR2vmjmlyFoK9zm
         Tw2ZP9CtSYtgwvjaToJ/HUE0fzJmxMWj3PaZLDTA7EV4BQUVMt4bJctSfVyfPDCX5Xgj
         xE6f8p4vaENjk0F65aa/ix10vP8GYC+BPz72KlbmUSyZ//3DiKSfuCBy1M0yeXew7vY9
         xNrg==
X-Gm-Message-State: ANoB5pkhSuM11Ob0fORZnWXC/IXqEZ1L4kp9hncTtNPi0A0PpbAhhUi/
        HiBYCqpQd+P89yC75B2GnvGkyQ==
X-Google-Smtp-Source: AA0mqf4tkcrMbiqx1CHzex8Ip0XgvLJtfj88MQTC07Bb8sjy63t8fYJS5AB9BrTbt5vBxIrKcikpDg==
X-Received: by 2002:ac2:5f65:0:b0:4aa:1754:9ae3 with SMTP id c5-20020ac25f65000000b004aa17549ae3mr19242729lfc.344.1670147082705;
        Sun, 04 Dec 2022 01:44:42 -0800 (PST)
Received: from krzk-bin.NAT.warszawa.vectranet.pl (088156142067.dynamic-2-waw-k-3-2-0.vectranet.pl. [88.156.142.67])
        by smtp.gmail.com with ESMTPSA id o10-20020a056512052a00b004b07cdef19csm1711593lfc.138.2022.12.04.01.44.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 04 Dec 2022 01:44:42 -0800 (PST)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH 2/6] arm64: dts: qcom: qrb5165-rb: fix no-mmc property for SDHCI
Date:   Sun,  4 Dec 2022 10:44:34 +0100
Message-Id: <20221204094438.73288-2-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20221204094438.73288-1-krzysztof.kozlowski@linaro.org>
References: <20221204094438.73288-1-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There is no "no-emmc" property, so intention for SD/SDIO only nodes was
to use "no-mmc":

  qcom/qrb5165-rb5.dtb: mmc@8804000: Unevaluated properties are not allowed ('no-emmc' was unexpected)

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 arch/arm64/boot/dts/qcom/qrb5165-rb5.dts | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/qcom/qrb5165-rb5.dts b/arch/arm64/boot/dts/qcom/qrb5165-rb5.dts
index 4c39cec0b13e..8c64cb060e21 100644
--- a/arch/arm64/boot/dts/qcom/qrb5165-rb5.dts
+++ b/arch/arm64/boot/dts/qcom/qrb5165-rb5.dts
@@ -904,7 +904,7 @@ &sdhc_2 {
 	cd-gpios = <&tlmm 77 GPIO_ACTIVE_LOW>;
 	bus-width = <4>;
 	no-sdio;
-	no-emmc;
+	no-mmc;
 };
 
 &sound {
-- 
2.34.1

