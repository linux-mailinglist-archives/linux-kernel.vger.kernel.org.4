Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4C214712D76
	for <lists+linux-kernel@lfdr.de>; Fri, 26 May 2023 21:29:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243226AbjEZT32 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 May 2023 15:29:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48288 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230305AbjEZT30 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 May 2023 15:29:26 -0400
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1890FA3;
        Fri, 26 May 2023 12:29:25 -0700 (PDT)
Received: by mail-wr1-x42b.google.com with SMTP id ffacd0b85a97d-30adc69c0dbso533843f8f.1;
        Fri, 26 May 2023 12:29:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1685129363; x=1687721363;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=vqZSsN91VZtcZCPTbwZ9Z6XKTZlAiaWgWZMS5nw69AU=;
        b=L8NSh5p7r3xqnjGfoYAcikP7KRGUnF+w12JTEczg6zfAzUYssWmg5ZmpCntu0K0gfM
         n6PycZ94xYB/1uiAEcDHk48ZknWbcyP2vfG8RA58jrpahSF3haXk2a0ht1T+XOYRzehG
         fs8kyMyEcHvlI8EUBQSMzLE2zDOZVp/J0HctkQCiIBsV+uMb5ejxLDyLHBUfghcAo96O
         WxjaydubvFvG4FavNoo02qUc9+XmcsgfTn2PgfGZKLvMbpBzekkWC1G890sKm6PzVRjf
         jlN9vPtX9WzlXydm+b9B4tJ+0xub3GUq8WMSbuW9I2HV94yvQ3LKg3CtJRmFBMDCWehn
         9uWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685129363; x=1687721363;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vqZSsN91VZtcZCPTbwZ9Z6XKTZlAiaWgWZMS5nw69AU=;
        b=SdC7DaWfj1r9Ql2OXgTmr3ToRqI1wpnq84g5Xsa7cG7i6ITJsW2m8NKioCbybZ5+Lh
         VZNa1meHfIu9E7R7bZ5VEyTrxG8IdR99vGB839q+TOyenGcNpBQTIlRfpk2uB8Nfu2ku
         zZt/e+mXoBc+ePgnNAsYLRK9kkbPzB3wV+GwmJnTFTYqOfePBNeiu4nH2p2jVXo9oY36
         rqnLSbQdySPwAfnkaVmTaXP16GNmfgqU+f3WgqpmvEImEwberEWJ0/46W0by35NRbKIy
         /GEiTUrt/T6/Ny3ljljZBTsjDfj0C0HHsOKXNo4erHw8pzm+21+hZG9GhIOcVn1fNZXD
         sX6A==
X-Gm-Message-State: AC+VfDyg7M9GsDlZxn1DLtpY606ltdPk3H1xU3EyjvZIs163wwpIYn++
        ZmGuWw8/t6cpSZ0Ibf/natI=
X-Google-Smtp-Source: ACHHUZ5KUQQ8Zx9EqPAyo80KH5Tt3YadlbiQoXfnS4piMdC/m5E5Chb3n42XVecm3vqVXZwxhpvHIg==
X-Received: by 2002:a5d:43c3:0:b0:309:1c89:c61b with SMTP id v3-20020a5d43c3000000b003091c89c61bmr2484280wrr.29.1685129363382;
        Fri, 26 May 2023 12:29:23 -0700 (PDT)
Received: from standask-GA-A55M-S2HP ([188.123.113.247])
        by smtp.gmail.com with ESMTPSA id o4-20020a5d4744000000b003062675d4c9sm5981882wrs.39.2023.05.26.12.29.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 May 2023 12:29:23 -0700 (PDT)
Date:   Fri, 26 May 2023 21:29:21 +0200
From:   Stanislav Jakubek <stano.jakubek@gmail.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Ray Jui <rjui@broadcom.com>,
        Scott Branden <sbranden@broadcom.com>
Cc:     bcm-kernel-feedback-list@broadcom.com, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH 2/6] ARM: dts: bcm21664/23550: use CCU compatibles directly
Message-ID: <65c54bd4076d646623d2a2f518631435522dc628.1685127525.git.stano.jakubek@gmail.com>
References: <cover.1685127525.git.stano.jakubek@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1685127525.git.stano.jakubek@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

BCM21664 and BCM23550 DTs for some reason use constants from a header file
for their CCU node compatibles. Change these to use the strings directly.

Signed-off-by: Stanislav Jakubek <stano.jakubek@gmail.com>
---
 arch/arm/boot/dts/bcm21664.dtsi | 8 ++++----
 arch/arm/boot/dts/bcm23550.dtsi | 8 ++++----
 2 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/arch/arm/boot/dts/bcm21664.dtsi b/arch/arm/boot/dts/bcm21664.dtsi
index 2a426125f9fe..19ade84e42c1 100644
--- a/arch/arm/boot/dts/bcm21664.dtsi
+++ b/arch/arm/boot/dts/bcm21664.dtsi
@@ -285,21 +285,21 @@ var_156m_clk: var_156m {
 		};
 
 		root_ccu: root_ccu@35001000 {
-			compatible = BCM21664_DT_ROOT_CCU_COMPAT;
+			compatible = "brcm,bcm21664-root-ccu";
 			reg = <0x35001000 0x0f00>;
 			#clock-cells = <1>;
 			clock-output-names = "frac_1m";
 		};
 
 		aon_ccu: aon_ccu@35002000 {
-			compatible = BCM21664_DT_AON_CCU_COMPAT;
+			compatible = "brcm,bcm21664-aon-ccu";
 			reg = <0x35002000 0x0f00>;
 			#clock-cells = <1>;
 			clock-output-names = "hub_timer";
 		};
 
 		master_ccu: master_ccu@3f001000 {
-			compatible = BCM21664_DT_MASTER_CCU_COMPAT;
+			compatible = "brcm,bcm21664-master-ccu";
 			reg = <0x3f001000 0x0f00>;
 			#clock-cells = <1>;
 			clock-output-names = "sdio1",
@@ -313,7 +313,7 @@ master_ccu: master_ccu@3f001000 {
 		};
 
 		slave_ccu: slave_ccu@3e011000 {
-			compatible = BCM21664_DT_SLAVE_CCU_COMPAT;
+			compatible = "brcm,bcm21664-slave-ccu";
 			reg = <0x3e011000 0x0f00>;
 			#clock-cells = <1>;
 			clock-output-names = "uartb",
diff --git a/arch/arm/boot/dts/bcm23550.dtsi b/arch/arm/boot/dts/bcm23550.dtsi
index 424c818d7a1b..ed3ce2fabca6 100644
--- a/arch/arm/boot/dts/bcm23550.dtsi
+++ b/arch/arm/boot/dts/bcm23550.dtsi
@@ -371,21 +371,21 @@ var_156m_clk: var_156m {
 		};
 
 		root_ccu: root_ccu@35001000 {
-			compatible = BCM21664_DT_ROOT_CCU_COMPAT;
+			compatible = "brcm,bcm21664-root-ccu";
 			reg = <0x35001000 0x0f00>;
 			#clock-cells = <1>;
 			clock-output-names = "frac_1m";
 		};
 
 		aon_ccu: aon_ccu@35002000 {
-			compatible = BCM21664_DT_AON_CCU_COMPAT;
+			compatible = "brcm,bcm21664-aon-ccu";
 			reg = <0x35002000 0x0f00>;
 			#clock-cells = <1>;
 			clock-output-names = "hub_timer";
 		};
 
 		slave_ccu: slave_ccu@3e011000 {
-			compatible = BCM21664_DT_SLAVE_CCU_COMPAT;
+			compatible = "brcm,bcm21664-slave-ccu";
 			reg = <0x3e011000 0x0f00>;
 			#clock-cells = <1>;
 			clock-output-names = "uartb",
@@ -398,7 +398,7 @@ slave_ccu: slave_ccu@3e011000 {
 		};
 
 		master_ccu: master_ccu@3f001000 {
-			compatible = BCM21664_DT_MASTER_CCU_COMPAT;
+			compatible = "brcm,bcm21664-master-ccu";
 			reg = <0x3f001000 0x0f00>;
 			#clock-cells = <1>;
 			clock-output-names = "sdio1",
-- 
2.25.1

