Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0A73A677F6D
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Jan 2023 16:18:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232684AbjAWPSM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Jan 2023 10:18:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42876 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232385AbjAWPRz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Jan 2023 10:17:55 -0500
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1CE5B298FB
        for <linux-kernel@vger.kernel.org>; Mon, 23 Jan 2023 07:17:10 -0800 (PST)
Received: by mail-wr1-x435.google.com with SMTP id b7so11141356wrt.3
        for <linux-kernel@vger.kernel.org>; Mon, 23 Jan 2023 07:17:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gm+Gp9pR9IMXXhQFxyLYqm/RbZlHJZIdJ3yAH5kvq7Y=;
        b=TX4Y/4P8Xhe1h9XM0PVorL+OzHG/rDPGMpkSrrgxxUPGlKc+czJQoRpd6sdv0KFnjL
         bxOtBmmFlq2jUmz+XsEUREyIt4JY2zPK8G9aJk438fXVqSzQpdGKPt6a++Zwj+p385AX
         ZGV8C7BQJVQ7iuS1U17IXue8Iqa/vwy0/dlmC00RjpGuhBw3gR++RIlqnHRACBz3poQO
         Ukw8pywqsSGNEscgAsFUUmVewPEfDCTB3ww4eIvU1Bv+djDTWoo0QdQO2knscugsL/rt
         NF0YgtrGPFEKEI9DZvLqVCxaDZO6VIfW4TwFVBn9/z9klLUZakG8OSqF7Xl2ooU1KVe/
         Ap/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gm+Gp9pR9IMXXhQFxyLYqm/RbZlHJZIdJ3yAH5kvq7Y=;
        b=Krhu4GgKWUmEXbk1p/hRAlCBukcw2Y206lBUnxpI4DaiaeNC2IJoU9WR+HHlhTJk8F
         /uECG7OcVRGohZdorlAFTu2++WQgg03A2dj9llI8SqMkQYe1SUdbVBVc+nmdcKP+MvXD
         4kN2fFIG7iwqmZe7acDAlw9do9QNHH1kJV8ZB7KZfxX10f1zg+5XlO1x148SR1vYw80+
         hwD012NtkJnIGEIc4lPySJcwrmj9xSGtbyPTBByo/fouqAjXa067SgZ3cdQcd2mKDL7y
         KP0RUXkZt7p442NmRHnScyflZiNJgLFzrvyUrogYSNPHz5lyskPM6V2xzJxyXbiWN5Hw
         /dcw==
X-Gm-Message-State: AFqh2kp3666Rj1eA2DZFO/iWPIUckggEyn5nopx1dKbIUG7ZjkRkPkMT
        9wtBNailO+7zJ7P5tqcutKyuhQ==
X-Google-Smtp-Source: AMrXdXsOrds413JqL7J/87edldEW0DET/5EYJMlOr3g1/6+tV4yilZkdowNpQSk3rGo59FDk1iRRRA==
X-Received: by 2002:a5d:6084:0:b0:242:733b:af28 with SMTP id w4-20020a5d6084000000b00242733baf28mr21564299wrt.5.1674486999487;
        Mon, 23 Jan 2023 07:16:39 -0800 (PST)
Received: from krzk-bin.. ([178.197.216.144])
        by smtp.gmail.com with ESMTPSA id k3-20020a5d6e83000000b00289bdda07b7sm4529287wrz.92.2023.01.23.07.16.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Jan 2023 07:16:39 -0800 (PST)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH 2/2] arm64: dts: mediatek: mt8183: drop double interrupts
Date:   Mon, 23 Jan 2023 16:16:34 +0100
Message-Id: <20230123151634.370011-2-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230123151634.370011-1-krzysztof.kozlowski@linaro.org>
References: <20230123151634.370011-1-krzysztof.kozlowski@linaro.org>
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

The DTSI comes with interrupts property, so it must be removed if
interrupts-extended are used:

  mt8183-kukui-jacuzzi-cozmo.dtb: serial@11003000: More than one condition true in oneOf schema:

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 arch/arm64/boot/dts/mediatek/mt8183-kukui.dtsi | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/boot/dts/mediatek/mt8183-kukui.dtsi b/arch/arm64/boot/dts/mediatek/mt8183-kukui.dtsi
index 821a51e458c5..fbe14b13051a 100644
--- a/arch/arm64/boot/dts/mediatek/mt8183-kukui.dtsi
+++ b/arch/arm64/boot/dts/mediatek/mt8183-kukui.dtsi
@@ -963,6 +963,7 @@ &uart1 {
 	pinctrl-0 = <&uart1_pins_default>;
 	pinctrl-1 = <&uart1_pins_sleep>;
 	status = "okay";
+	/delete-property/ interrupts;
 	interrupts-extended = <&sysirq GIC_SPI 92 IRQ_TYPE_LEVEL_LOW>,
 			      <&pio 121 IRQ_TYPE_EDGE_FALLING>;
 
-- 
2.34.1

