Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4085C6CA4B6
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Mar 2023 14:53:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232692AbjC0Mxk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Mar 2023 08:53:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51820 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232343AbjC0MxY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Mar 2023 08:53:24 -0400
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A0741985
        for <linux-kernel@vger.kernel.org>; Mon, 27 Mar 2023 05:53:22 -0700 (PDT)
Received: by mail-wm1-x32a.google.com with SMTP id j18-20020a05600c1c1200b003ee5157346cso7309509wms.1
        for <linux-kernel@vger.kernel.org>; Mon, 27 Mar 2023 05:53:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20210112.gappssmtp.com; s=20210112; t=1679921601;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MUtBx+ZDcvBvTMSzz6CyHu6NajXWGopTZJ1ZilR4jUE=;
        b=zQn43BYBE5LEVK7NNGzUv02OGgPeuZ/xlBOKv7AtwuRiLZJ63ecV0sbHQkd5fjt+vT
         ZAFZP5orxIiO4BiUb8rq9dWzmguDJBuWuvFXWcXNPzGBFipIx/XVRzYW4vr29G9arb5a
         L/6W6Ej6nX0gcFjo1HeUhIEkd7U+DQf0JVH1foL4cBPjhjzTXH1mT10FmPvCU20GddVa
         dsRj1g19Wa0H9TZAgYSOfXqTNjySCv63dNvGefyHUopd86VfIDWfZCnZNsYlLhFDOmWf
         mytruDw5bLHaK2inhJC9eX0fUbls6vZiyavQBHIDmjsXeQln77cR0HhM/Rmd++6e10D/
         0/qg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679921601;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MUtBx+ZDcvBvTMSzz6CyHu6NajXWGopTZJ1ZilR4jUE=;
        b=UaDDhBSsyEOGEjm3jgKQnH3S9ZhF2aAZqQJHnUMeiorrlokjtt0u6TsTYgV9LYk7fZ
         vqVdh7UzTsUN/V8o8jF1yMhESmLQVaaWa9m38whqSsYM9rT6H5PYl1z2PCrALPkBGS1+
         UBy9mGC+3ySjq2d8b8QvXWeMeHSLgL7i/sGNzFVPW6G0nIDd3+JNdDEc5XkNxoB+XpaF
         MA4ZTvlcC2Yo6JySUL64lcQIFM7IB2bsHJVkABsbmMatlYaekgG156gncVsWso20N3Q8
         LdEeuVBG60ocoxa3kNnsREScTtLK0+aU4KF2AMeKnqry2Bl4FOzFEdh3SuIFiBpNBDxX
         225A==
X-Gm-Message-State: AO0yUKUe9eLjVrRjBrPpLRTUFirtvQjWl6ZlxVmAny/TUZWc4q6CCgDv
        L/Pg94GJum3njhA46f1NY0NhDg==
X-Google-Smtp-Source: AK7set8foAhaEz1+Hy9mnqHQULu3bo54rjsgWxkfWmq5tyVDg/aq7y2lkEdRXdvEwJICbCNSw2i4EA==
X-Received: by 2002:a7b:cd0d:0:b0:3ed:30cb:5569 with SMTP id f13-20020a7bcd0d000000b003ed30cb5569mr8471551wmj.20.1679921600794;
        Mon, 27 Mar 2023 05:53:20 -0700 (PDT)
Received: from brgl-uxlite.home ([2a01:cb1d:334:ac00:313d:a304:2790:a949])
        by smtp.gmail.com with ESMTPSA id q25-20020a1ce919000000b003ee58e8c971sm13572220wmc.14.2023.03.27.05.53.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Mar 2023 05:53:20 -0700 (PDT)
From:   Bartosz Golaszewski <brgl@bgdev.pl>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org,
        Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Subject: [PATCH v3 01/18] arm64: dts: qcom: sa8775p: pad reg properties to 8 digits
Date:   Mon, 27 Mar 2023 14:52:59 +0200
Message-Id: <20230327125316.210812-2-brgl@bgdev.pl>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <20230327125316.210812-1-brgl@bgdev.pl>
References: <20230327125316.210812-1-brgl@bgdev.pl>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=0.0 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>

The file has inconsistent padding of the address part of soc node
children's reg properties. Fix it.

Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Reviewed-by: Konrad Dybcio <konrad.dybcio@linaro.org>
---
 arch/arm64/boot/dts/qcom/sa8775p.dtsi | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/arch/arm64/boot/dts/qcom/sa8775p.dtsi b/arch/arm64/boot/dts/qcom/sa8775p.dtsi
index c5b73c591e0f..5aa28a3b12ae 100644
--- a/arch/arm64/boot/dts/qcom/sa8775p.dtsi
+++ b/arch/arm64/boot/dts/qcom/sa8775p.dtsi
@@ -440,7 +440,7 @@ soc: soc@0 {
 
 		gcc: clock-controller@100000 {
 			compatible = "qcom,sa8775p-gcc";
-			reg = <0x0 0x100000 0x0 0xc7018>;
+			reg = <0x0 0x00100000 0x0 0xc7018>;
 			#clock-cells = <1>;
 			#reset-cells = <1>;
 			#power-domain-cells = <1>;
@@ -464,7 +464,7 @@ gcc: clock-controller@100000 {
 
 		ipcc: mailbox@408000 {
 			compatible = "qcom,sa8775p-ipcc", "qcom,ipcc";
-			reg = <0x0 0x408000 0x0 0x1000>;
+			reg = <0x0 0x00408000 0x0 0x1000>;
 			interrupts = <GIC_SPI 229 IRQ_TYPE_LEVEL_HIGH>;
 			interrupt-controller;
 			#interrupt-cells = <3>;
@@ -473,7 +473,7 @@ ipcc: mailbox@408000 {
 
 		qupv3_id_1: geniqup@ac0000 {
 			compatible = "qcom,geni-se-qup";
-			reg = <0x0 0xac0000 0x0 0x6000>;
+			reg = <0x0 0x00ac0000 0x0 0x6000>;
 			#address-cells = <2>;
 			#size-cells = <2>;
 			ranges;
@@ -485,7 +485,7 @@ qupv3_id_1: geniqup@ac0000 {
 
 			uart10: serial@a8c000 {
 				compatible = "qcom,geni-uart";
-				reg = <0x0 0xa8c000 0x0 0x4000>;
+				reg = <0x0 0x00a8c000 0x0 0x4000>;
 				interrupts = <GIC_SPI 356 IRQ_TYPE_LEVEL_HIGH>;
 				clock-names = "se";
 				clocks = <&gcc GCC_QUPV3_WRAP1_S3_CLK>;
@@ -735,7 +735,7 @@ rpmhpd_opp_turbo_l1: opp-9 {
 
 		tcsr_mutex: hwlock@1f40000 {
 			compatible = "qcom,tcsr-mutex";
-			reg = <0x0 0x1f40000 0x0 0x20000>;
+			reg = <0x0 0x01f40000 0x0 0x20000>;
 			#hwlock-cells = <1>;
 		};
 
@@ -754,7 +754,7 @@ cpufreq_hw: cpufreq@18591000 {
 
 		tlmm: pinctrl@f000000 {
 			compatible = "qcom,sa8775p-tlmm";
-			reg = <0x0 0xf000000 0x0 0x1000000>;
+			reg = <0x0 0x0f000000 0x0 0x1000000>;
 			interrupts = <GIC_SPI 208 IRQ_TYPE_LEVEL_HIGH>;
 			gpio-controller;
 			#gpio-cells = <2>;
-- 
2.37.2

