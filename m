Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 79723747D66
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jul 2023 08:50:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231424AbjGEGuG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Jul 2023 02:50:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50590 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231886AbjGEGtk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Jul 2023 02:49:40 -0400
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com [IPv6:2a00:1450:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AFFFB2139
        for <linux-kernel@vger.kernel.org>; Tue,  4 Jul 2023 23:49:05 -0700 (PDT)
Received: by mail-ej1-x62c.google.com with SMTP id a640c23a62f3a-99384a80af7so187623666b.2
        for <linux-kernel@vger.kernel.org>; Tue, 04 Jul 2023 23:49:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1688539729; x=1691131729;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=u+MkrFMagkeIVy8ddwJ2oj2EHTlEbXRG0oh1YfYd/3Q=;
        b=iiIjNFLGPfjNj1fI30V62Stc1tnzX5ajqXD6ASSEccaJfwC3Z8MJ2KpUhYDD5cH0a7
         onLqb4b4fXe9mNW+xfaqEI4MFTjKn+nuLKx6lpj5To7cIzsG4YDHiwXMTR7n69zXpCJB
         yonJuaE21eWHaezgbQTi2qw/ds0JHwuwXTF6ODm8TfMkrLwJgGHXovis3SfvqDlv25qD
         fmMpPRQxEEfi9CVKpPCkmtxz0dmFVYi7NZq4CY/bB0qcle6THyLWn5H9+U5AfD0toC9S
         anMvmvEaSgM1osViu/yAINGF3cWluHzXriqR79J9LKnm7kGgmq/pMQsrVQnkZMc7gABq
         gcPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688539729; x=1691131729;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=u+MkrFMagkeIVy8ddwJ2oj2EHTlEbXRG0oh1YfYd/3Q=;
        b=GDEhWd18PMJFif8vpFwiBe/8gSANf7wMCGVgoZxlzUl6ZtqtbK3CE44tZz12iBd8mP
         nvMcS0c2XX8Ssd+89642PnOhletk/y2VKWp4FBoNrWnQFg+wXJ1+4TlldWb0+o13eCE4
         zUWwDjxuqchFQD8hRUbmacq9YZn3sSjilPjhNJwzmUuy/ajdM83PsUSdlwN1ouNvRaWv
         VgAYzvqDPOTyIROwgBJu0mcdk7Snrj6gEi+xeW0MFresbGcUoy7ReCnJVkhVMy4VnvGq
         YgW3Y7+OGDUHacEHAraYZ+1nUkpsraakigDcV7YxtjId6k1u6Tsw1DXP7co6Ct00iKn0
         2XGQ==
X-Gm-Message-State: ABy/qLaFEqczG/h03hyN3UyEvhGoLticwiUbmfDas4j6pjCsimkk0KQb
        rGmbwaFEZW93Z9LcpIT3islsCw==
X-Google-Smtp-Source: APBJJlHZl5PdNH0abYjBIDke2wCYFd5fP0UDSLJrYwlY2J0QoorN8lhH7IR9wBK+aqDps2wJxkgQKQ==
X-Received: by 2002:a17:906:37cc:b0:973:cc48:f19c with SMTP id o12-20020a17090637cc00b00973cc48f19cmr8818117ejc.56.1688539729764;
        Tue, 04 Jul 2023 23:48:49 -0700 (PDT)
Received: from krzk-bin.. ([178.197.219.26])
        by smtp.gmail.com with ESMTPSA id lj14-20020a170906f9ce00b00992bea2e9d2sm7504836ejb.62.2023.07.04.23.48.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Jul 2023 23:48:49 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Heiko Stuebner <heiko@sntech.de>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [RFT PATCH 2/3] arm64: dts: rockchip: correct audio-codec interrupt flag in Rock Pi 4B
Date:   Wed,  5 Jul 2023 08:48:22 +0200
Message-Id: <20230705064823.9210-2-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230705064823.9210-1-krzysztof.kozlowski@linaro.org>
References: <20230705064823.9210-1-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

GPIO_ACTIVE_x flags are not correct in the context of interrupt flags.
These are simple defines so they could be used in DTS but they will not
have the same meaning: GPIO_ACTIVE_HIGH = 0 = IRQ_TYPE_NONE.

Correct the interrupt flags, assuming the author of the code wanted same
logical behavior behind the name "ACTIVE_xxx", this is:
  ACTIVE_LOW  => IRQ_TYPE_LEVEL_LOW

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 arch/arm64/boot/dts/rockchip/rk3399-rock-pi-4b-plus.dts | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/rockchip/rk3399-rock-pi-4b-plus.dts b/arch/arm64/boot/dts/rockchip/rk3399-rock-pi-4b-plus.dts
index cec3b7b1b947..8a17c1eaae15 100644
--- a/arch/arm64/boot/dts/rockchip/rk3399-rock-pi-4b-plus.dts
+++ b/arch/arm64/boot/dts/rockchip/rk3399-rock-pi-4b-plus.dts
@@ -31,7 +31,7 @@ brcmf: wifi@1 {
 		compatible = "brcm,bcm4329-fmac";
 		reg = <1>;
 		interrupt-parent = <&gpio0>;
-		interrupts = <RK_PA3 GPIO_ACTIVE_HIGH>;
+		interrupts = <RK_PA3 IRQ_TYPE_LEVEL_HIGH>;
 		interrupt-names = "host-wake";
 		pinctrl-names = "default";
 		pinctrl-0 = <&wifi_host_wake_l>;
-- 
2.34.1

