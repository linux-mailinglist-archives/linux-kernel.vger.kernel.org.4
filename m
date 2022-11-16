Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0359062B2D8
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Nov 2022 06:39:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232056AbiKPFjF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Nov 2022 00:39:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54296 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231766AbiKPFih (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Nov 2022 00:38:37 -0500
Received: from mail-pg1-x535.google.com (mail-pg1-x535.google.com [IPv6:2607:f8b0:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E764E60C8
        for <linux-kernel@vger.kernel.org>; Tue, 15 Nov 2022 21:38:35 -0800 (PST)
Received: by mail-pg1-x535.google.com with SMTP id 136so15703614pga.1
        for <linux-kernel@vger.kernel.org>; Tue, 15 Nov 2022 21:38:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PI/Dm8Xn6WniktdX7f/nHoTvWtwHm/H0w1CeN5e56Wg=;
        b=FdiOzIGoubl3ylDJ4lEbihqGx6GfPoOlTI+RmmWDK+WcYsnRSZUWPAHqNsO7JqQOhP
         HHWv2k57KZmxMnVz7Vg5/t0q5d/X+ZAnSobweFcquLpO27kqyM14vA/q1knI7/pKtWiV
         yu+0f5rKkHGOVOwo4Dwedj3jxrvGASm8QZLmCO8VGmhjNiTWKhcjSjmKOkwn/2QKLHuK
         WuwERwYNTksL8zv+t7VgVmVtf4l4XTOPMxTC2ETVdBB7cPOqgEnX5mNIwg0SOmXc3UiK
         t2welHGhT4I2vZJCOLDoAa1ndbstNuuwNsQHuJ+JSYt+Zg1nyMtP/3wgzatOZ1aZjNRI
         EEqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PI/Dm8Xn6WniktdX7f/nHoTvWtwHm/H0w1CeN5e56Wg=;
        b=GSo+89SFm9HKo/snchjojG3JiTcuIGMBWIxbkv+kYzG2ACBLdGMnMK2CZNt2+lvp1/
         +FuAXyE6FC8GZxd7QnL3K3UQYfGZqgSE8yy8SmCMHYT5mX5wnB+xjwrWvhMutflJB9PA
         mUJkqXWcDQliiy+nzbDL/FRFczJaA2F7pS+m+lq4ZPyjSv2T5cwSEGsDL+igFNBFgtnk
         nbzPo4rtuP/j84m1ipye5ZfTHo2jxzDNvIMzW+F3vWuUy0+xKNRjHJSXB368jD+0foBi
         qUb5YEOl9Nt6zj6GvwXJXFgSThqQMD7VyS7gP2jGFicw4+xeSkEqYPfZCIgAKNj40x0B
         Mgow==
X-Gm-Message-State: ANoB5pn7bgM7McPG2AIWtYWA6X2A4hJUiOjhUiaM4WIMG4pHfhlmp6kN
        9ULol+RUwuIcf12XwnL33R4=
X-Google-Smtp-Source: AA0mqf6tk4n1dLo2nIOqIKkMGMQQJiQhYcFaLRx5eEWqbalX+e19mG1wrZvjtwV/DOOFKmlOgiSJJw==
X-Received: by 2002:a63:fd42:0:b0:426:9c23:97da with SMTP id m2-20020a63fd42000000b004269c2397damr19863493pgj.2.1668577115229;
        Tue, 15 Nov 2022 21:38:35 -0800 (PST)
Received: from dtor-ws.mtv.corp.google.com ([2620:15c:9d:2:2d36:e9a0:170b:669f])
        by smtp.gmail.com with ESMTPSA id ik13-20020a170902ab0d00b0017834a6966csm10881038plb.176.2022.11.15.21.38.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Nov 2022 21:38:34 -0800 (PST)
From:   Dmitry Torokhov <dmitry.torokhov@gmail.com>
To:     Mark Brown <broonie@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>
Cc:     linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH 08/11] ASoC: dt-bindings: wcd9335: fix reset line polarity in example
Date:   Tue, 15 Nov 2022 21:38:14 -0800
Message-Id: <20221116053817.2929810-8-dmitry.torokhov@gmail.com>
X-Mailer: git-send-email 2.38.1.431.g37b22c650d-goog
In-Reply-To: <20221116053817.2929810-1-dmitry.torokhov@gmail.com>
References: <20221116053817.2929810-1-dmitry.torokhov@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When resetting the block, the reset line is being driven low and then
high, which means that the line in DTS should be annotated as "active
low".

Fixes: 1877c9fda1b7 ("ASoC: dt-bindings: add dt bindings for wcd9335 audio codec")
Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
---

This was sent out previously as part of other series. Collected
Krzysztof's ack.

 Documentation/devicetree/bindings/sound/qcom,wcd9335.txt | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/sound/qcom,wcd9335.txt b/Documentation/devicetree/bindings/sound/qcom,wcd9335.txt
index 5d6ea66a863f..1f75feec3dec 100644
--- a/Documentation/devicetree/bindings/sound/qcom,wcd9335.txt
+++ b/Documentation/devicetree/bindings/sound/qcom,wcd9335.txt
@@ -109,7 +109,7 @@ audio-codec@1{
 	reg  = <1 0>;
 	interrupts = <&msmgpio 54 IRQ_TYPE_LEVEL_HIGH>;
 	interrupt-names = "intr2"
-	reset-gpios = <&msmgpio 64 0>;
+	reset-gpios = <&msmgpio 64 GPIO_ACTIVE_LOW>;
 	slim-ifc-dev  = <&wc9335_ifd>;
 	clock-names = "mclk", "native";
 	clocks = <&rpmcc RPM_SMD_DIV_CLK1>,
-- 
2.38.1.431.g37b22c650d-goog

