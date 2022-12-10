Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8633F648E6B
	for <lists+linux-kernel@lfdr.de>; Sat, 10 Dec 2022 12:33:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229756AbiLJLdt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 10 Dec 2022 06:33:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58462 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229494AbiLJLds (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 10 Dec 2022 06:33:48 -0500
Received: from mail-lf1-x132.google.com (mail-lf1-x132.google.com [IPv6:2a00:1450:4864:20::132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AEB081FCF6
        for <linux-kernel@vger.kernel.org>; Sat, 10 Dec 2022 03:33:46 -0800 (PST)
Received: by mail-lf1-x132.google.com with SMTP id g7so11006309lfv.5
        for <linux-kernel@vger.kernel.org>; Sat, 10 Dec 2022 03:33:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=3N7tIHQraLsILIMF6LasiBa13lO97ALP3v/BN7IvCVs=;
        b=ROLxlv9PC6hsaViy8KhLqdAMDdff8n2EOtYVGUkIKiFGNrA7UQwxLlnT5/2JJAWFMt
         P+p2YWnM3usud3bKO5gNxHLBhBAT80rsWYnSud0+dOqSf+O/i2S7nOSaqEGCKwYiq50M
         S/6XYCUx6r/5ozbgtLTFVxZJC+hAahDPA2U4ADEIeP8MZSHP6Fgxzp9MCON2aPEMRJnR
         gk7emmtrNe+M5ZSGchNfA4XXvUR1rRCqojioIx93Iu4P1lGk86V3BGQNst03IP7rpgWd
         9GM/Zq51qdQNBvZYEShqcxz90aYKpc7Z8TghOZ3ZmyMMrsR+vuOz5g2pZkdwOuFrdFjg
         s31w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=3N7tIHQraLsILIMF6LasiBa13lO97ALP3v/BN7IvCVs=;
        b=0QmQXJkbFH8zAzejadvD4OvWARKkRXO2gSnnz9xkZcMrfPBH0sRqDqGtdYzAHoU/vI
         RLA4We8bDLXbUs29zwM7mkPXnM6uOvLzMcJZS/9uYC/Rs+F+h0pAjGaCzsMLNW54trzx
         fHZWBv32EcdxAzsqW3YL5W9X4QsDKXvTD32vYNPvmFovoTWIePiSmLTf/bClY2JN+OYE
         /vmQTkajyNEzeHmEvwG3YCsmXh9SlRDmQFkx2UMWlWkB357kxCJneRqFvEylN6I8pgsn
         Y8pMAVdI1Ggs2JlVTUMmGLzT0d5GDe6jD0oBk5x4pNdFQadoYYj/kyTw7ZdASgfZtfPg
         BI3g==
X-Gm-Message-State: ANoB5pnpMQNHM4rX0xT33Fu+hHkA3nh//+TM5u+hRmor/aLywuo9DdUa
        8/ursnOiG7Zjo+3cNC1o+ltxzQ==
X-Google-Smtp-Source: AA0mqf5caNByx4jKOY+ezGzEkLWU1Hc7Fd6M/S7iUKqrLAbxQo0ftQbVgg9iOYmZCHde7j5Ms7PPYQ==
X-Received: by 2002:ac2:5dc5:0:b0:4b5:b4d1:e1ca with SMTP id x5-20020ac25dc5000000b004b5b4d1e1camr1202826lfq.39.1670672024824;
        Sat, 10 Dec 2022 03:33:44 -0800 (PST)
Received: from krzk-bin.NAT.warszawa.vectranet.pl (088156142067.dynamic-2-waw-k-3-2-0.vectranet.pl. [88.156.142.67])
        by smtp.gmail.com with ESMTPSA id o19-20020ac24e93000000b0049944ab6895sm679729lfr.260.2022.12.10.03.33.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 10 Dec 2022 03:33:44 -0800 (PST)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Lars Povlsen <lars.povlsen@microchip.com>,
        Steen Hegelund <Steen.Hegelund@microchip.com>,
        Daniel Machon <daniel.machon@microchip.com>,
        UNGLinuxDriver@microchip.com, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH] arm64: dts: microchip: drop 0x from unit address
Date:   Sat, 10 Dec 2022 12:33:43 +0100
Message-Id: <20221210113343.63864-1-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
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

By coding style, unit address should not start with 0x.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 arch/arm64/boot/dts/microchip/sparx5.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/microchip/sparx5.dtsi b/arch/arm64/boot/dts/microchip/sparx5.dtsi
index 2dd5e38820b1..0367a00a269b 100644
--- a/arch/arm64/boot/dts/microchip/sparx5.dtsi
+++ b/arch/arm64/boot/dts/microchip/sparx5.dtsi
@@ -465,7 +465,7 @@ serdes: serdes@10808000 {
 			reg = <0x6 0x10808000 0x5d0000>;
 		};
 
-		switch: switch@0x600000000 {
+		switch: switch@600000000 {
 			compatible = "microchip,sparx5-switch";
 			reg =	<0x6 0 0x401000>,
 				<0x6 0x10004000 0x7fc000>,
-- 
2.34.1

