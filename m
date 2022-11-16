Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EEA3D62BB96
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Nov 2022 12:25:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239226AbiKPLZN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Nov 2022 06:25:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40580 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239237AbiKPLYk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Nov 2022 06:24:40 -0500
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com [IPv6:2607:f8b0:4864:20::102a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E3AF45EEC;
        Wed, 16 Nov 2022 03:14:45 -0800 (PST)
Received: by mail-pj1-x102a.google.com with SMTP id l22-20020a17090a3f1600b00212fbbcfb78so1956004pjc.3;
        Wed, 16 Nov 2022 03:14:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=user-agent:content-disposition:mime-version:message-id:subject:to
         :from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=nyC+yDLSk48NJUeZiMOPIOe4ZUnpBcxh3+f3W/dMNhk=;
        b=F8cMBQRGmA7UbL/PbV3eIPwM+8lhBL3rkfuqTpNMjpbaBWgDF7PTr++FdWTUw9krKg
         KI4GEjGZk5QUGvDFGED9XEwDhm8xRb1X5KhVf2C7GCTC2/YDz/8rvX4nTLmKutT5c5jk
         1XrWaFRBgdQvVUhB/1Qe+3cnQIlIoJNYDhmTLiK7VjCjspEvgzNBP21iQ5aN65Yva2e6
         T9jvHyQn9I5tRE/u3pJuKdw8f/s2hoNPlReiYFF9s36gZ1hapteOeg4JgN24PD/DGu/4
         U0DghUrKY0x3mhfFZWP4nt7ykYBajM0IeM6OWeL3ZSX+9p0YGT/7P1tPA4pvmt3VMiJ7
         Dm2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=user-agent:content-disposition:mime-version:message-id:subject:to
         :from:date:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=nyC+yDLSk48NJUeZiMOPIOe4ZUnpBcxh3+f3W/dMNhk=;
        b=52I4gcPlRYTOk1bI4CUtEp7rrUir9wF+Cv/oms9eGktJN+2sif/G9jDFoQHCJ0qdal
         h+3eRpn6/zAwp2DVyB0w3Hk1i3p8bCw3eaa0/PDfNx4AdSDACB0QzotRp7vCMu6C9lRR
         3tyNJ5+BuIUCqemdoUqn2ldhaS4BDaCndvMzoDa2PbZVlXiVEEqvvn+pa6tnk1PdS0Om
         /L1RF7ejvh10dqTGhH+DrGCUbSUagdq1HmAclyLmbDihVl6NhcJmhoBTMyCxmsvkbb2G
         dUkUwmEexzItHW0hW/DpN3PbDTtoXwYisdYXjhuPtxCA0CtHqvZqro4PJNezNTT2lhFi
         Uxpg==
X-Gm-Message-State: ANoB5pnfK7ZNjLGLIvZ1dGmRprBuDVMyvkMuPsO+6+jZnl/P7QDj8Lj9
        dYLwh3AuOO6/SwD0DFXSYA4=
X-Google-Smtp-Source: AA0mqf7w7C3XTM72ib/KnsNNsPX5J+DD22f1WSN/EZuW6n6yMcf+Zifxo6jiMnwqJySegYDIxLfz8A==
X-Received: by 2002:a17:902:ce8b:b0:186:a3a0:601c with SMTP id f11-20020a170902ce8b00b00186a3a0601cmr8419673plg.105.1668597285062;
        Wed, 16 Nov 2022 03:14:45 -0800 (PST)
Received: from hcl-ThinkPad-T495 ([2409:4072:707:8c4c:69fe:3231:5395:4d2f])
        by smtp.gmail.com with ESMTPSA id f21-20020aa79695000000b00561dcfa700asm10594330pfk.107.2022.11.16.03.14.39
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 16 Nov 2022 03:14:44 -0800 (PST)
Date:   Wed, 16 Nov 2022 16:44:35 +0530
From:   Karthikeyan Pasupathi <pkarthikeyan1509@gmail.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Joel Stanley <joel@jms.id.au>,
        Andrew Jeffery <andrew@aj.id.au>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        openbmc@lists.ozlabs.org
Subject: [PATCH v1] ARM: dts: aspeed: Yosemite V2: Add GPIO line names
Message-ID: <20221116111435.GA27359@hcl-ThinkPad-T495>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,WEIRD_QUOTING
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Name the GPIOs to help userspace work with them. The names describe
the functionality the lines provide, it makes easier to share
userspace code across different system.

Signed-off-by: Karthikeyan Pasupathi <pkarthikeyan1509@gmail.com>

---
--- v1 - Initial draft
---
---
 .../dts/aspeed-bmc-facebook-yosemitev2.dts    | 41 +++++++++++++++++++
 1 file changed, 41 insertions(+)

diff --git a/arch/arm/boot/dts/aspeed-bmc-facebook-yosemitev2.dts b/arch/arm/boot/dts/aspeed-bmc-facebook-yosemitev2.dts
index 8864e9c312a8..f84e2eeb9fd1 100644
--- a/arch/arm/boot/dts/aspeed-bmc-facebook-yosemitev2.dts
+++ b/arch/arm/boot/dts/aspeed-bmc-facebook-yosemitev2.dts
@@ -119,6 +119,47 @@
 			&pinctrl_adc15_default>;
 };
 
+&gpio {
+	status = "okay";
+	gpio-line-names =
+	/*A0-A7*/	"","","","","","","","",
+	/*B0-B7*/	"","","","","","","","",
+	/*C0-C7*/	"","","","","","","","",
+	/*D0-D7*/	"POWER_BUTTON","POWER_OUT1","","POWER_OUT2","","POWER_OUT3","",
+			"POWER_OUT4",
+	/*E0-E7*/	"DEBUG_UART_SEL0","DEBUG_UART_SEL1","DEBUG_UART_SEL2",
+			"DEBUG_UART_RX_SEL_N","","","","",
+	/*F0-F7*/	"","","","","","","","",
+	/*G0-G7*/	"LED_POST_CODE_0","LED_POST_CODE_1","LED_POST_CODE_2",
+			"LED_POST_CODE_3","","","","",
+	/*H0-H7*/	"","","","","","","","",
+	/*I0-I7*/	"SLOT1_POWER_OK","SLOT2_POWER_OK","SLOT3_POWER_OK","SLOT4_POWER_OK",
+			"","","","",
+	/*J0-J7*/	"","","","","","","","",
+	/*K0-K7*/	"","","","","","","","",
+	/*L0-L7*/	"","","","","","","","",
+	/*M0-M7*/	"","","","","","","","",
+	/*N0-N7*/	"","","I2C_SLOT1","I2C_SLOT2","I2C_SLOT3","I2C_SLOT4","","",
+	/*O0-O7*/	"","","","SELECTOR_BUTTON","SLOT1_POWER","SLOT2_POWER","SLOT3_POWER",
+			"SLOT4_POWER",
+	/*P0-P7*/	"","","","","LED_POST_CODE_4","LED_POST_CODE_5","LED_POST_CODE_6",
+			"LED_POST_CODE_7",
+	/*Q0-Q7*/	"","","","","","","","",
+	/*R0-R7*/	"","","","GPIO_DBG_CARD_PRSNT","","","","",
+	/*S0-S7*/	"RESET_OUT1","RESET_OUT2","RESET_OUT3","RESET_OUT4","","","","",
+	/*T0-T7*/	"","","","","","","","",
+	/*U0-U7*/	"","","","","","","","",
+	/*V0-V7*/	"","","","","","","","",
+	/*W0-W7*/	"","","","","","","","",
+	/*X0-X7*/	"","","","","","","","",
+	/*Y0-Y7*/	"","","","","","","","",
+	/*Z0-Z7*/	"POST_COMPLETE","POST_COMPLETE2","POST_COMPLETE3","POST_COMPLETE4",
+			"","","","",
+	/*AA0-AA7*/	"","","","","HAND_SW1","HAND_SW2","HAND_SW3","HAND_SW4",
+	/*AB0-AB7*/	"RESET_BUTTON","","","","","","","",
+	/*AC0-AC7*/	"","","","","","","","";
+};
+
 &i2c1 {
 	//Host1 IPMB bus
 	status = "okay";
-- 
2.17.1

