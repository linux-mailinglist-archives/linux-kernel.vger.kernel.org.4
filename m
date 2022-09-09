Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 157D25B33AA
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Sep 2022 11:22:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230268AbiIIJWC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Sep 2022 05:22:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43980 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231844AbiIIJVN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Sep 2022 05:21:13 -0400
Received: from mail-lj1-x234.google.com (mail-lj1-x234.google.com [IPv6:2a00:1450:4864:20::234])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B3F3128C20
        for <linux-kernel@vger.kernel.org>; Fri,  9 Sep 2022 02:21:00 -0700 (PDT)
Received: by mail-lj1-x234.google.com with SMTP id l12so1085788ljg.9
        for <linux-kernel@vger.kernel.org>; Fri, 09 Sep 2022 02:20:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=uXLJl3ZPkfkVvmcRHOHOBnFdkGCya/Ew5ljctJGYsvo=;
        b=oSLLh+PdKzlLThUm9rrBhde8+nwX4FQZ/wrin76fCzhIy4cru3zpDI5kn6B5HHMZYe
         UKhB7Pn1RdYvW+w3JgA6qNGH7hI70atkDCXTg1fjfPsTotP5eC6sGOQ+JaQnEWa0jyt9
         diTNNkPtUR0zA3JqN9E6KtKP5zbt5MN5gTyZgS4wxRbLDqQBqFVSxMtziO+huS0T21uM
         AXTg/O2TJVmezBrCau8N7sw3LcdYpc6nIp04SfE7jrA+1bUYiT+NHg+WRWTkPC5iKJdy
         kRkeVeLTeKn8RgkJXF8DhJbrUtDawM1RZB+dRWu2GZdw+TCE4Zk9d0ZzrMe4MvmbGayN
         1lxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=uXLJl3ZPkfkVvmcRHOHOBnFdkGCya/Ew5ljctJGYsvo=;
        b=w2JMi1CTPXrhHASjhoGDkZ6c1y96wJfFS9VfA0ynoiws/puVSFmEFC1R0fvdv5SCFs
         bHVrjXmVqHR/td9MA/R1H9EiUREsE78/XlYrknjq2sqQV70QqtM5wFJ8IsGvPAgaS2nU
         QRh6+sEEimZvDbYcMQYWiTRF2d9NHQQnuI7xf0mo5OrozqZl+zPLzqrb5BUUevYkkjCN
         R58vlw6K5mHzYlzD9ZhvzCXGXQmVpeboOv9+lxWyKxoZNoRvEmfF0IlepzbjG4YlMrJt
         7zxCgBGLYYTyMPOpC7hGfOC+LhblMsVvRHM8qJr+w/gwJvuqcmOLjwWSHKsHn5rcJE4H
         NYuQ==
X-Gm-Message-State: ACgBeo3lm3Dd45Uq4PAWMeoewy6+T3LUm37h2f8C4FfAfy87dU32ROVT
        xYl3qAZ+ECzWZ4pJ2ORpBUnb+w==
X-Google-Smtp-Source: AA6agR584RkTZ1UtDLrrx5HMsetTOvE5i4tfUBuyEb0L+NI1IoakQmfkqI77jkS7QYz57OgehP0liw==
X-Received: by 2002:a2e:808f:0:b0:26a:b498:2c87 with SMTP id i15-20020a2e808f000000b0026ab4982c87mr3749489ljg.279.1662715257992;
        Fri, 09 Sep 2022 02:20:57 -0700 (PDT)
Received: from krzk-bin.. (78-11-189-27.static.ip.netia.com.pl. [78.11.189.27])
        by smtp.gmail.com with ESMTPSA id s6-20020a056512214600b00498fe38ea0fsm2170lfr.174.2022.09.09.02.20.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Sep 2022 02:20:57 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Ohad Ben-Cohen <ohad@wizery.com>,
        Baolin Wang <baolin.wang@linux.alibaba.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Vinod Koul <vkoul@kernel.org>, linux-arm-msm@vger.kernel.org,
        linux-remoteproc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH v3 14/15] ARM: dts: qcom: apq8084: switch TCSR mutex to MMIO
Date:   Fri,  9 Sep 2022 11:20:34 +0200
Message-Id: <20220909092035.223915-15-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220909092035.223915-1-krzysztof.kozlowski@linaro.org>
References: <20220909092035.223915-1-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The TCSR mutex bindings allow device to be described only with address
space (so it uses MMIO, not syscon regmap).  This seems reasonable as
TCSR mutex is actually a dedicated IO address space and it also fixes DT
schema checks:

  qcom-apq8084-mtp.dtb: hwlock: 'reg' is a required property
  qcom-apq8084-mtp.dtb: hwlock: 'syscon' does not match any of the regexes: 'pinctrl-[0-9]+'

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 arch/arm/boot/dts/qcom-apq8084.dtsi | 11 +++--------
 1 file changed, 3 insertions(+), 8 deletions(-)

diff --git a/arch/arm/boot/dts/qcom-apq8084.dtsi b/arch/arm/boot/dts/qcom-apq8084.dtsi
index 72f9255855a1..5e07255fe5ea 100644
--- a/arch/arm/boot/dts/qcom-apq8084.dtsi
+++ b/arch/arm/boot/dts/qcom-apq8084.dtsi
@@ -383,14 +383,9 @@ gcc: clock-controller@fc400000 {
 			reg = <0xfc400000 0x4000>;
 		};
 
-		tcsr_mutex_regs: syscon@fd484000 {
-			compatible = "syscon";
-			reg = <0xfd484000 0x2000>;
-		};
-
-		tcsr_mutex: hwlock {
-			compatible = "qcom,tcsr-mutex";
-			syscon = <&tcsr_mutex_regs 0 0x80>;
+		tcsr_mutex: hwlock@fd484000 {
+			compatible = "qcom,apq8084-tcsr-mutex", "qcom,tcsr-mutex";
+			reg = <0xfd484000 0x1000>;
 			#hwlock-cells = <1>;
 		};
 
-- 
2.34.1

