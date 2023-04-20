Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BBA316E8BD2
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Apr 2023 09:51:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234246AbjDTHvj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Apr 2023 03:51:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56556 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234185AbjDTHv2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Apr 2023 03:51:28 -0400
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com [IPv6:2a00:1450:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6903D59D6
        for <linux-kernel@vger.kernel.org>; Thu, 20 Apr 2023 00:51:05 -0700 (PDT)
Received: by mail-ej1-x632.google.com with SMTP id a640c23a62f3a-94ed301bba0so53458866b.0
        for <linux-kernel@vger.kernel.org>; Thu, 20 Apr 2023 00:51:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1681977061; x=1684569061;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CWHnHNToGasJrGjvR3eKDTStQb2y8kbHp8eaclo2u2U=;
        b=CWBUgIitVWJxSHspzz20QTWtGG4QoDPwz45NNAy97Bs8k9/z8qwIhY05CsBC57Zbws
         CBuy0OaJ+NpzPDf6OruNTx4lwwX+hqXCfIWKZUgv9ZFd+ZQ3R2A4HhuPnfjsW3hyrfVr
         oBbDKx9ss/y1QBREkryRrj8ha9EzVsoD1LBrfzGLW4b0Kct8HQNJnlkUcA9k38SvoEhh
         aRb3aZ0gWbPww7zREf3P513/0h3cA0vz6VDyBQhASkga87z67YxkFPaHsSbD06W137CD
         UzbDP7acxlpKaP5zgAV/P3v6rvNah2VsrgwrWKwz6+9T6qwWqXEr4zoZuR/3TQXN/HVH
         5hig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681977061; x=1684569061;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CWHnHNToGasJrGjvR3eKDTStQb2y8kbHp8eaclo2u2U=;
        b=daap94sdpJI/fuEDxcQGHefaaCLUmvynlXANRS++tXn0btOJFuYSnyblhyL9SlmSur
         8XjzDVPIRTCn+aluk/QxOLPqJyLHsDjTx2pXMJc/bkomGxMyMEsLkeCtKQTRDu3jTWw+
         kCwFswSmDkHCFVUNpZycZPHA9pCQ/v4OuwXO6hrJar+/1vySgO8wja7Osx/lus3HsF3j
         a+WeYar/jZ8Wyk18EPywlFpoGA7VdAt96r+R52Qac/L4K3TcydB8sXwc+8y/G7pSkUIE
         hMnMWsWhqTOVOdi7Lze8avKTCMWGUQ0lfaveQ7Vw75tT1yj7Rq0J2EjJ4oFoUyowvWqa
         1dzA==
X-Gm-Message-State: AAQBX9eaElVQtin1uZXiPViSczR/RnTEChb7XoB7s9ivvdKiQDBAb4hf
        OVVdQOT6lLesXNfhHnTupAbyBGv+gpxIhl1gjejkhw==
X-Google-Smtp-Source: AKy350bu2rvyxOdNXkK9xZupPFlAfRpbBcdy7kevrPzIpYFwmBrXlEUqDtpbzPDUHW+XKWXims0z0g==
X-Received: by 2002:a50:e61a:0:b0:506:bcd6:b125 with SMTP id y26-20020a50e61a000000b00506bcd6b125mr845212edm.40.1681977061521;
        Thu, 20 Apr 2023 00:51:01 -0700 (PDT)
Received: from krzk-bin.. ([2a02:810d:15c0:828:bcb8:77e6:8f45:4771])
        by smtp.gmail.com with ESMTPSA id h25-20020a50ed99000000b00505060e4280sm447165edr.94.2023.04.20.00.51.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Apr 2023 00:51:01 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH 05/10] ARM: dts: qcom: ipq8064: drop invalid GCC thermal-sensor unit-address
Date:   Thu, 20 Apr 2023 09:50:48 +0200
Message-Id: <20230420075053.41976-5-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230420075053.41976-1-krzysztof.kozlowski@linaro.org>
References: <20230420075053.41976-1-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

GCC comes with syscon compatible so the thermal-sensor child node should
not have unit-address (bindings also do not expect it):

  Warning (unit_address_vs_reg): /soc/clock-controller@900000/thermal-sensor@900000: node has a unit name, but no reg or ranges property

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 arch/arm/boot/dts/qcom-ipq8064.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/qcom-ipq8064.dtsi b/arch/arm/boot/dts/qcom-ipq8064.dtsi
index 182018d79a7b..49310520da1c 100644
--- a/arch/arm/boot/dts/qcom-ipq8064.dtsi
+++ b/arch/arm/boot/dts/qcom-ipq8064.dtsi
@@ -522,7 +522,7 @@ gcc: clock-controller@900000 {
 			#reset-cells = <1>;
 			#power-domain-cells = <1>;
 
-			tsens: thermal-sensor@900000 {
+			tsens: thermal-sensor {
 				compatible = "qcom,ipq8064-tsens";
 
 				nvmem-cells = <&tsens_calib>, <&tsens_calib_backup>;
-- 
2.34.1

