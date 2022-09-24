Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B08155E8976
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Sep 2022 10:08:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233581AbiIXIFj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 24 Sep 2022 04:05:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54266 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233615AbiIXIFU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 24 Sep 2022 04:05:20 -0400
Received: from mail-lj1-x230.google.com (mail-lj1-x230.google.com [IPv6:2a00:1450:4864:20::230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 14D68E5126
        for <linux-kernel@vger.kernel.org>; Sat, 24 Sep 2022 01:05:13 -0700 (PDT)
Received: by mail-lj1-x230.google.com with SMTP id q17so2283492lji.11
        for <linux-kernel@vger.kernel.org>; Sat, 24 Sep 2022 01:05:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=FWVDuWp8BwqwRmMZ9J51BUVWuUxtUS1YpggdRQgiP8U=;
        b=lKqiHTyCaBQqonBvUzIa0MOK2PGwTxupkeVmCMlXsiL0hCMzRJcxjyDBaf3z1ha2hb
         7LIzryArcR4kW6fvegtze4M9DXV2ACZfUmyN7Pif2q9bPshRPp7tAwZJk96GDY56pjzR
         4XEX/XrgBoBStZUvKa3jAUiI7iKAJAe9jCQXUOTROvpLiNesTyqIlVltmk9i+Yqm1SSL
         kVZ0AFLYUf9SW4V0chPQgSVGTetNQIX3EoaeZF3aifyYIHJBCN/ONVA6BW568b0i/29o
         6thn+K8O5x+/SDZmbLy51y8i++OyOUyJk+P73gP5fWwr2gG9nLENKe2G9ZYPGczzIg+S
         329A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=FWVDuWp8BwqwRmMZ9J51BUVWuUxtUS1YpggdRQgiP8U=;
        b=0XPNgzFkqLwxFNRAtYW685DzFfPDiDB3Pcl8PgvZT27SopYxMQCsrbemyz6ecxSKco
         lm+tT0UXWdNBxoL83io0PqrMoww0qom1fcyYq2kfX0YW4TcLiF9p4FkSC1hwClf2Z6Ch
         CFN5Lo9/WHMpiCl4T4jIX3Gs1LjDCHz2AO7mCtM2u7Tf8dx8ZmqcQai3qUp8J/VohEX+
         EBzRhjioLT/LSsqheD8ffkHXk8ojoYYub0kQZ2/PtoyKqZgFPeXeX52t49hb/j+0qsKN
         OL6RvfCVYzT9Dsc2V95eGF2/QqPKSkp0UMkh0EFxcqz/CP9s9dzBBE1Zh1eDtF7HP7Ui
         Heag==
X-Gm-Message-State: ACrzQf0Sj4L3wxLjl2FGx70TwkYEeBQAK98iFGly7w6bhJftESZL5nPn
        u0K/YdSAfM10Bt9Ii25XKI9Hjw==
X-Google-Smtp-Source: AMsMyM6h7DHWtiAHdnbYgp6OT8Z2eDM7rQSK7Nb2kym+FE7x4xYbhKt8v1OjF9u1wbIRQ6DtCop/Sw==
X-Received: by 2002:a05:651c:1147:b0:26b:e6b4:6d34 with SMTP id h7-20020a05651c114700b0026be6b46d34mr4371508ljo.209.1664006711275;
        Sat, 24 Sep 2022 01:05:11 -0700 (PDT)
Received: from krzk-bin.. (78-11-189-27.static.ip.netia.com.pl. [78.11.189.27])
        by smtp.gmail.com with ESMTPSA id y2-20020a2e5442000000b0026c41574790sm1696668ljd.30.2022.09.24.01.05.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 24 Sep 2022 01:05:10 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Sricharan R <sricharan@codeaurora.org>,
        Stephan Gerhold <stephan@gerhold.net>,
        Shawn Guo <shawn.guo@linaro.org>,
        Vinod Koul <vkoul@kernel.org>,
        krishna Lanka <quic_vamslank@quicinc.com>,
        Sivaprakash Murugesan <sivaprak@codeaurora.org>,
        linux-arm-msm@vger.kernel.org, linux-gpio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH 03/32] ARM: dts: qcom: sdx55: add gpio-ranges to TLMM pinctrl
Date:   Sat, 24 Sep 2022 10:04:30 +0200
Message-Id: <20220924080459.13084-4-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220924080459.13084-1-krzysztof.kozlowski@linaro.org>
References: <20220924080459.13084-1-krzysztof.kozlowski@linaro.org>
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

Add required gpio-ranges property to TLMM pinctrl node:

  qcom-sdx55-mtp.dtb: pinctrl@f100000: 'gpio-ranges' is a required property

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 arch/arm/boot/dts/qcom-sdx55.dtsi | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/boot/dts/qcom-sdx55.dtsi b/arch/arm/boot/dts/qcom-sdx55.dtsi
index c72540223fa9..f1c0dab40992 100644
--- a/arch/arm/boot/dts/qcom-sdx55.dtsi
+++ b/arch/arm/boot/dts/qcom-sdx55.dtsi
@@ -559,6 +559,7 @@ tlmm: pinctrl@f100000 {
 			#gpio-cells = <2>;
 			interrupt-controller;
 			#interrupt-cells = <2>;
+			gpio-ranges = <&tlmm 0 0 109>;
 		};
 
 		sram@1468f000 {
-- 
2.34.1

