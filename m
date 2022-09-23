Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BA13C5E7F70
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Sep 2022 18:16:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232435AbiIWQQb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Sep 2022 12:16:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40748 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232636AbiIWQQR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Sep 2022 12:16:17 -0400
Received: from mail-lf1-x12e.google.com (mail-lf1-x12e.google.com [IPv6:2a00:1450:4864:20::12e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E4EDE133CB3
        for <linux-kernel@vger.kernel.org>; Fri, 23 Sep 2022 09:16:12 -0700 (PDT)
Received: by mail-lf1-x12e.google.com with SMTP id k10so1065602lfm.4
        for <linux-kernel@vger.kernel.org>; Fri, 23 Sep 2022 09:16:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=nJKdZtRvq8vBlaQZJuT8tYogYRM3UsmdrKTxy6xD2iw=;
        b=Xfg1awDmiUcpuVPcBMW/FiqbFFeQmvs0LWuSTrmgGp2qby6q1KdawTWyRdaIMvkGHN
         CttSYjA7q2t7TxM/DHGI1E6jjctpOdpZK4lrSCnGGmP6MHdUoZiAUl1qdTBiAiyFu2HX
         Kp6eTFdFGYBdsvvvVYYGBN2zFbx/NsnoePe1DmBxt4EiWnSIZdKd51mM5vezG52ZR3re
         LV/PeV3zrKUh9QIHB4NOsdhd1K/pFPce8ocQQuAnekN/vNkONipqEAYgrVitj/s30RPb
         lOD4ewemEaITwY+ApcwPqLhE0rF1RnZpg5VW5djLNMGVUT8EnRlwg7hd788Z+Y+0tR+H
         ixjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=nJKdZtRvq8vBlaQZJuT8tYogYRM3UsmdrKTxy6xD2iw=;
        b=ZObfZRjJfa+vadWwVAA23dFI/jSmyvumzbGA+NEEoSFfYoCEyguI9yQKNNA41RTAPP
         BPHBe0LSJ9QHARioikjhpFJGrk+VtRB5y9FnyPedCqskyocPY9XWqvI9OfeHU/mw6VOR
         1siVsSavy3Db/ErutNNhjx172K/6AgEWu3W9pxGKasPMtVeLlh0wsexleUnkbMKjXGrW
         3UjIB7r2VKcd93AkfT6Q080crreba6tWiQTMZ/a17MC4PE52npszp8UG7kOpvwN8lLiy
         PPVZFYhnE8U1k1lHWd6fOF1LEixWNsmTWc86ivdaI1Obrq/bTwBDWYZoiNGyzcXD5lza
         1DVQ==
X-Gm-Message-State: ACrzQf2skR1Ers4olvMTMnuh/map/zXFbQ9uW9jkXlRB9OFBxb9MX9Cu
        r0kBo7guctEv8JgesuVgY1z2ug==
X-Google-Smtp-Source: AMsMyM7pGltPmmGkuAEHAcrGUgl/lKfRBdxAiWjL6WRo3JAsU/8+hmNR9y1u0n50ycApnB7uOANipg==
X-Received: by 2002:a05:6512:b8b:b0:498:f32a:3c1e with SMTP id b11-20020a0565120b8b00b00498f32a3c1emr3355951lfv.123.1663949770909;
        Fri, 23 Sep 2022 09:16:10 -0700 (PDT)
Received: from krzk-bin.. (78-11-189-27.static.ip.netia.com.pl. [78.11.189.27])
        by smtp.gmail.com with ESMTPSA id f9-20020ac25cc9000000b00492f45cbbfcsm1493491lfq.302.2022.09.23.09.16.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Sep 2022 09:16:10 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        alsa-devel@alsa-project.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH 04/11] arm64: dts: qcom: mms8996: correct slimbus children unit addresses
Date:   Fri, 23 Sep 2022 18:14:46 +0200
Message-Id: <20220923161453.469179-5-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220923161453.469179-1-krzysztof.kozlowski@linaro.org>
References: <20220923161453.469179-1-krzysztof.kozlowski@linaro.org>
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

Correct slimbus address/size cells to match bindings.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 arch/arm64/boot/dts/qcom/msm8996.dtsi | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/arm64/boot/dts/qcom/msm8996.dtsi b/arch/arm64/boot/dts/qcom/msm8996.dtsi
index 903c443a867f..2c5908d104f7 100644
--- a/arch/arm64/boot/dts/qcom/msm8996.dtsi
+++ b/arch/arm64/boot/dts/qcom/msm8996.dtsi
@@ -3320,15 +3320,15 @@ slim_msm: slim@91c0000 {
 			#size-cells = <0>;
 			ngd@1 {
 				reg = <1>;
-				#address-cells = <1>;
-				#size-cells = <1>;
+				#address-cells = <2>;
+				#size-cells = <0>;
 
-				tasha_ifd: tas-ifd {
+				tasha_ifd: tas-ifd@0,0 {
 					compatible = "slim217,1a0";
 					reg = <0 0>;
 				};
 
-				wcd9335: codec@1{
+				wcd9335: codec@1,0 {
 					pinctrl-0 = <&cdc_reset_active &wcd_intr_default>;
 					pinctrl-names = "default";
 
-- 
2.34.1

