Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9FA606C86C0
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Mar 2023 21:23:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232011AbjCXUXB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Mar 2023 16:23:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35348 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231817AbjCXUW6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Mar 2023 16:22:58 -0400
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com [IPv6:2a00:1450:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C2C27128
        for <linux-kernel@vger.kernel.org>; Fri, 24 Mar 2023 13:22:55 -0700 (PDT)
Received: by mail-ed1-x531.google.com with SMTP id eh3so12320085edb.11
        for <linux-kernel@vger.kernel.org>; Fri, 24 Mar 2023 13:22:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1679689374;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=es+HvkHe0F3GCsxEWp3ux6VZSAP82WMs4eTXPrG/qLs=;
        b=w3edZX2pdX8rRHpqalOELCRLN8gKCBYtNb8YNtJRMrGm0cgp17tl2c6c36k3LrmWMN
         sZxYkPvuGXF+b0jVGPrRHD5+RGo8XI0IuL14G0G2GJPHMVv2RB7KcohHfF2uLLiTGcBJ
         EUCqQ0Xbp+0zIap9KibqvUjqoeMSujbt9jEEdbXU7IwPsxvX7rPpkYSWNwlXhSZKEgdv
         ym2cQdH0hcYbVVGAqDTtlaeBrnrghuD8JAXkUwAs/90kX8AdN6GZjzKdxmROe9UqzIqr
         Tkye1KcG2KRTME+AIs++gHRg+Yv3TCHuiStl9BKusyb94+YK3slXNvsaLZIgwulty51w
         fChw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679689374;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=es+HvkHe0F3GCsxEWp3ux6VZSAP82WMs4eTXPrG/qLs=;
        b=sVS7sXlHbuDcFxl3RU0I0gtj8bcCVqIYUDodJkTmnc80dHmEhhEHJ0dBY4uvS40ECM
         m6bXGx39Mi4ENyAQ8VMFh0BPAxm2zTSJ0DGD/I7BmZwpqjocV+wLx5TSYCW+xEGaZzAv
         7FpY4XEVvgS4a0z+kGshXF3uHa8dCBv3sFdjLi8xUMQL4uhORgfzpEXJGnqMFquYyRMx
         7kVdlNzJkydZ3CYAXz6yNfkAWElGQdPIXdtF4y1MoXXBpnkqC6q9HhQbZnY3hBsBK/n/
         nuRW2QP2n5jYvH4wnkvOrJKXt8xbSEgA1v+lhuUdnaFmzwRM08z9F0+LuftiCGkKfMIv
         BA7g==
X-Gm-Message-State: AAQBX9eHK/Q9gns0rpVwrXzwkHNESu7jUVtgz/WgIg1q5op4DpDhDGyd
        9ePbUaVFbWqNjeojm/9CPOWk3g==
X-Google-Smtp-Source: AKy350ZqG9qUaOyLxyUcK4EVRu670bb4FV3YOfRgoKPvP4ChaTR+jipizk6p70bxtJaezkVI1TiYpg==
X-Received: by 2002:a17:906:5785:b0:93d:1c2b:bd23 with SMTP id k5-20020a170906578500b0093d1c2bbd23mr4926818ejq.39.1679689374260;
        Fri, 24 Mar 2023 13:22:54 -0700 (PDT)
Received: from krzk-bin.. ([2a02:810d:15c0:828:3027:fb0b:ae08:588])
        by smtp.gmail.com with ESMTPSA id rh26-20020a17090720fa00b00930ba362216sm10900041ejb.176.2023.03.24.13.22.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Mar 2023 13:22:53 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH 2/5] arm64: dts: qcom: apq8096-db820c: drop simple-bus from clocks
Date:   Fri, 24 Mar 2023 21:22:41 +0100
Message-Id: <20230324202244.744271-2-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230324202244.744271-1-krzysztof.kozlowski@linaro.org>
References: <20230324202244.744271-1-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

'clocks' node is not a bus, but just a placeholder for clocks:

  apq8096-db820c.dtb: clocks: $nodename:0: 'clocks' does not match '^([a-z][a-z0-9\\-]+-bus|bus|localbus|soc|axi|ahb|apb)(@.+)?$'
    From schema: dtschema/schemas/simple-bus.yaml
  apq8096-db820c.dtb: clocks: xo-board: {'compatible': ['fixed-clock'], '#clock-cells': [[0]],  ...
    From schema: dtschema/schemas/simple-bus.yaml

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 arch/arm64/boot/dts/qcom/apq8096-db820c.dts | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/arm64/boot/dts/qcom/apq8096-db820c.dts b/arch/arm64/boot/dts/qcom/apq8096-db820c.dts
index 4476e2e22816..b599909c4463 100644
--- a/arch/arm64/boot/dts/qcom/apq8096-db820c.dts
+++ b/arch/arm64/boot/dts/qcom/apq8096-db820c.dts
@@ -63,7 +63,6 @@ chosen {
 	};
 
 	clocks {
-		compatible = "simple-bus";
 		divclk4: divclk4 {
 			compatible = "fixed-clock";
 			#clock-cells = <0>;
-- 
2.34.1

