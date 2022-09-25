Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AFF035E927A
	for <lists+linux-kernel@lfdr.de>; Sun, 25 Sep 2022 13:07:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232743AbiIYLHL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 25 Sep 2022 07:07:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60146 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232566AbiIYLG2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 25 Sep 2022 07:06:28 -0400
Received: from mail-lj1-x22f.google.com (mail-lj1-x22f.google.com [IPv6:2a00:1450:4864:20::22f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E49632048
        for <linux-kernel@vger.kernel.org>; Sun, 25 Sep 2022 04:06:25 -0700 (PDT)
Received: by mail-lj1-x22f.google.com with SMTP id l12so4587806ljg.9
        for <linux-kernel@vger.kernel.org>; Sun, 25 Sep 2022 04:06:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=RktSTcq3H5K8cHqTQr3Yf2+8uyprOBIhojh+e4mNQp4=;
        b=l06ERLARHFaw2C3l79m4hdGEQ5hP5sCW8oJSqQJ+pTSNb+TNSerspOXmApfYLF6eTT
         h4eJ4JrVezLAMjJ9YMSquAMm6xAJcheRTJl5hWLdiuaHRz0VXVELG6iEXiQOdTBn4z0N
         DpP4rBGOSDLB2pxemS7gTG2I2jktsZgKZIBZ8G2bhDragzAFV/uPdqqcgG6T+HI7C2Wt
         Dd6yiFi1y/EK8NN322/4wOg35NFiGZq+GegddSv40OgC3slZpr/tktIM4QShJWnsfMzh
         jWokUoy6MhJZugEj1Q1/6Z36++ovR9SBNTe/e00IpfrpEkFYT+ZFIi6l4ltCi4wa+Kqx
         HZfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=RktSTcq3H5K8cHqTQr3Yf2+8uyprOBIhojh+e4mNQp4=;
        b=IdUAZ7OUbWiDV7DkOplQquQkM9di7wkP0UTENfhoimBAAyPHXOXK78GO+SsX9Pbnpz
         RnmlHDPpLd5h00fNVL+3182RKhManDhW2fR2QbiuDnN7ZoNJ4Al/ISt7KHLz1faOAiRE
         pe1QGuN/KNCs1b2btv8rZdPMKCZqkWrK6AtuS5/YbvLzsqweyZIxJcgJe60xZT6xfOij
         hoY3hQadDXkLUbmiEXjytH5wda7JJX3PDsV5tPa8vFfYJhmUEINTEsvkAGimcUS4ZWm0
         MUHUvFaeJWrqREL1w7r1w4qBmazkxooLsrqjyRMi+5kZfuhSCc6kUTFI1UDflUejsC30
         8PGg==
X-Gm-Message-State: ACrzQf1G9Mi3CWlRjMRAUJ0fmWSwejBWLgStjTc7gfGO0Io9J3/Y1lCY
        nQvt4iVcfpImBPjeNqsNMpnxHA==
X-Google-Smtp-Source: AMsMyM4cddoHnv3mAdRS7zpT4z3TQb+pEIcd96DKWxxHxwIYJJHyzQa39m5rP/hwPFfCjtvGslbWcg==
X-Received: by 2002:a05:651c:227:b0:26a:b322:b243 with SMTP id z7-20020a05651c022700b0026ab322b243mr5504422ljn.13.1664103984591;
        Sun, 25 Sep 2022 04:06:24 -0700 (PDT)
Received: from krzk-bin.. (78-11-189-27.static.ip.netia.com.pl. [78.11.189.27])
        by smtp.gmail.com with ESMTPSA id u19-20020ac258d3000000b00492dadd8143sm2177265lfo.168.2022.09.25.04.06.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 25 Sep 2022 04:06:24 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-msm@vger.kernel.org, linux-gpio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH 10/15] arm64: dts: qcom: sm6125: align TLMM pin configuration with DT schema
Date:   Sun, 25 Sep 2022 13:06:03 +0200
Message-Id: <20220925110608.145728-11-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220925110608.145728-1-krzysztof.kozlowski@linaro.org>
References: <20220925110608.145728-1-krzysztof.kozlowski@linaro.org>
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

DT schema expects TLMM pin configuration nodes to be named with
'-state' suffix and their optional children with '-pins' suffix.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 arch/arm64/boot/dts/qcom/sm6125.dtsi | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/boot/dts/qcom/sm6125.dtsi b/arch/arm64/boot/dts/qcom/sm6125.dtsi
index 1fe3fa3ad877..af49a748e511 100644
--- a/arch/arm64/boot/dts/qcom/sm6125.dtsi
+++ b/arch/arm64/boot/dts/qcom/sm6125.dtsi
@@ -407,13 +407,13 @@ data-pins {
 			};
 
 			sdc2_on_state: sdc2-on-state {
-				clk {
+				clk-pins {
 					pins = "sdc2_clk";
 					drive-strength = <16>;
 					bias-disable;
 				};
 
-				cmd-pins-pins {
+				cmd-pins {
 					pins = "sdc2_cmd";
 					drive-strength = <10>;
 					bias-pull-up;
-- 
2.34.1

