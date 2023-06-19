Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 77A01735CA9
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Jun 2023 19:02:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230305AbjFSRCG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Jun 2023 13:02:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52300 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231586AbjFSRCA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Jun 2023 13:02:00 -0400
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com [IPv6:2a00:1450:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7458010DC
        for <linux-kernel@vger.kernel.org>; Mon, 19 Jun 2023 10:01:57 -0700 (PDT)
Received: by mail-ed1-x530.google.com with SMTP id 4fb4d7f45d1cf-51a2c8e5a2cso5242739a12.2
        for <linux-kernel@vger.kernel.org>; Mon, 19 Jun 2023 10:01:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1687194116; x=1689786116;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=COsaRxZdSPBV9CeyLNaEQg4S1uumP/ZoT63AXElGvQM=;
        b=S0bbD5N+FhAvM28xfCEV5Iv+dBsG5PjpwStWc5X6w49zIJF3b+47JtdzVOlg6gw9hL
         5aAdxExIPkQ3l7YcACz80nKEZMpf8txfNDw0i2Mm0xC+TLDELcXIgnbojrbCY4srkbk+
         Zfg5y9bTk2jpBukwEMFOUZkgs+oF02mO4OzL5SHC88a8Acu9IPQFINQZB0wAPyksyrgA
         BV9EIihYks9f8Y6UQqPYDHNSiHU789rcsLxxY1YB2XC017WQ8kRqz0jmO13xRsiCa3Co
         ree1NoyNf5txD6WcIbr0CJcagyRsCEfKK/DcLC6UbG23UoOCwkGk4EuQ3cRar7D1MoYt
         ELGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687194116; x=1689786116;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=COsaRxZdSPBV9CeyLNaEQg4S1uumP/ZoT63AXElGvQM=;
        b=gm1s0iwGQMuPmE1kJTVAiNmTSUDxiOKPvRCc9jJXQVV09JAK+C5z/P1FUB1tME5BSZ
         tMg6NPaG5t0JkyJSPA6+cZrD/Zei+dof286k46WdZSpKEk3ixIGo/c5S2+lXa+iOo86b
         wDl10DDxTxDd/VrYNmHUFm9Qz2diggIHRM9kInQhRhUt0CAiOtQezd4J1txcXPCZBzEU
         ECtiUk3bjTNE3w+W2pzS2mvjD+tO/ZHA97t+8Kt9PWTodx00OHNLZWh+9+0xN1hJjkI8
         H8rXPyLo5tEhVbTTsxebLHnMHUXW8uFx7j6OlI4Ba7tMAObY6EWm0oB5ya1SmWZiTUab
         KKag==
X-Gm-Message-State: AC+VfDzxcrtdhPXxJeOndEV6brby53Vx5Vepn6jrAUi7QVvxHS4Kigcy
        m4iYgJpl92FKossanIFhVoQfKw==
X-Google-Smtp-Source: ACHHUZ7if91saarUGDyScY9DruSyV8Eho0OkIVDfKRL0EUFbxDpR2014gXdCLR/yFZM4Y/tN2uLjvg==
X-Received: by 2002:a05:6402:218:b0:517:6ed9:662d with SMTP id t24-20020a056402021800b005176ed9662dmr7128683edv.19.1687194115978;
        Mon, 19 Jun 2023 10:01:55 -0700 (PDT)
Received: from krzk-bin.. ([178.197.219.26])
        by smtp.gmail.com with ESMTPSA id p9-20020aa7cc89000000b005166663b8dcsm13136672edt.16.2023.06.19.10.01.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Jun 2023 10:01:55 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH 2/4] ARM: dts: qcom: sdx55: use generic node names for USB
Date:   Mon, 19 Jun 2023 19:01:49 +0200
Message-Id: <20230619170151.65505-2-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230619170151.65505-1-krzysztof.kozlowski@linaro.org>
References: <20230619170151.65505-1-krzysztof.kozlowski@linaro.org>
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

Device node names should be generic which is also expected by USB
bindings:

  qcom-sdx55-t55.dtb: dwc3@a600000: $nodename:0: 'dwc3@a600000' does not match '^usb(@.*)?'

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 arch/arm/boot/dts/qcom-sdx55.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/qcom-sdx55.dtsi b/arch/arm/boot/dts/qcom-sdx55.dtsi
index df3cd9c4ffb9..55ce87b75253 100644
--- a/arch/arm/boot/dts/qcom-sdx55.dtsi
+++ b/arch/arm/boot/dts/qcom-sdx55.dtsi
@@ -603,7 +603,7 @@ usb: usb@a6f8800 {
 
 			resets = <&gcc GCC_USB30_BCR>;
 
-			usb_dwc3: dwc3@a600000 {
+			usb_dwc3: usb@a600000 {
 				compatible = "snps,dwc3";
 				reg = <0x0a600000 0xcd00>;
 				interrupts = <GIC_SPI 133 IRQ_TYPE_LEVEL_HIGH>;
-- 
2.34.1

