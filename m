Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 94B9461FC35
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Nov 2022 18:55:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232557AbiKGRzV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Nov 2022 12:55:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58422 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232556AbiKGRyO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Nov 2022 12:54:14 -0500
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com [IPv6:2a00:1450:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 603302CC;
        Mon,  7 Nov 2022 09:53:22 -0800 (PST)
Received: by mail-wm1-x329.google.com with SMTP id ay14-20020a05600c1e0e00b003cf6ab34b61so10145943wmb.2;
        Mon, 07 Nov 2022 09:53:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ol70elGXSkOXuxfrggtPBzq4RmwwfV6GuIgQ6Ej8CSA=;
        b=cipDfNIYO9dRlaj4Jg1svXKSPG1N0oDpCTckBC7tkCqZ68QDlYxg+/nSo2jubRv+f9
         jGOcxCqIAT302w9148xt4EMKC6mUR/0UWrDr56IIxNUFP7cqpIdt1y7pHxgwvNWp6dWe
         gcfcjjmCer46Ghofszo4b+7GIzN/w72D5+iCtCcFCoydxUGxtoWwz+W0pmJnbI1BRyWx
         I/M3BnYL1zyRXuYiI+jsBJTcbFwL+/JRm0fs1RczqZ5HcHzjl9CFWrXUysaZBGxlCHfE
         zLE9n5iVYlKrmQV2T7u94MjWOX17SGxDGWmhln6w5ai0YXOmtZZad2zQAjMf3F/6YjH0
         eKow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Ol70elGXSkOXuxfrggtPBzq4RmwwfV6GuIgQ6Ej8CSA=;
        b=DjLON1Syl9gF9SWGptJxKgpmHiP5dC7wCFrNouS6K0n8asOfGTGGtGLPqC903wnyxC
         FXQxtzVHrB8LTJaC0PCX4iCa0gBEdTd5mFGcPzx3MIC1l21+FL2kvxhbol5kD6z5tNFy
         3IpGE6wDKkvaP9xDh81iVKHOwERXW/hmCRamv6uZlY0NifDQnCajJ8hDA5zVU2ygkAU1
         QEFHi/zLmC9fdJkMCegEuCU3nnI1PFvoPmseSXy8GcGrRNQHT9/hhmZ+VgwblgtzjBsj
         enKjShy/2zL9JSRfG9u2piHHmg28Yab2YFB9d3t/VPu9h262pyAOdHuOzORp/9Atul6T
         BEMA==
X-Gm-Message-State: ACrzQf3d+s9Kc1umEY/Tyi9rWLkcIojZAzkFb37CfB3WQ6qoGz483R5D
        CfBZJfwLL9u7jxwKKiCwwEo=
X-Google-Smtp-Source: AMsMyM7cnbn0gJsudNbXC9g4LN2e8/85YSN1C2HXnYAeCWVp4agWDareOr/Odx6X//SN0+0dhkiGMA==
X-Received: by 2002:a05:600c:4383:b0:3cf:6ab5:5c38 with SMTP id e3-20020a05600c438300b003cf6ab55c38mr31601777wmn.194.1667843600793;
        Mon, 07 Nov 2022 09:53:20 -0800 (PST)
Received: from prasmi.home ([2a00:23c8:2501:c701:9c45:7ed3:c12e:e25b])
        by smtp.gmail.com with ESMTPSA id v4-20020a5d4a44000000b002365254ea42sm8072454wrs.1.2022.11.07.09.53.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Nov 2022 09:53:20 -0800 (PST)
From:   Prabhakar <prabhakar.csengg@gmail.com>
X-Google-Original-From: Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
To:     Thomas Gleixner <tglx@linutronix.de>,
        Marc Zyngier <maz@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Magnus Damm <magnus.damm@gmail.com>,
        Linus Walleij <linus.walleij@linaro.org>
Cc:     linux-gpio@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Prabhakar <prabhakar.csengg@gmail.com>,
        Biju Das <biju.das.jz@bp.renesas.com>,
        Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: [PATCH RFC 4/5] arm64: dts: renesas: r9a07g043[u]: Update pinctrl node to handle GPIO interrupts
Date:   Mon,  7 Nov 2022 17:53:04 +0000
Message-Id: <20221107175305.63975-5-prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20221107175305.63975-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
References: <20221107175305.63975-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
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

From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>

Add required properties in pinctrl node to handle GPIO interrupts.

Note as IRQC is not enabled in RZ/Five the phandle for interrupt-parent
is added in RZ/G2UL specific dtsi so that RZ/Five pinctrl driver
continues without waiting for IRQC to probe.

Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
---
 arch/arm64/boot/dts/renesas/r9a07g043.dtsi  | 2 ++
 arch/arm64/boot/dts/renesas/r9a07g043u.dtsi | 4 ++++
 2 files changed, 6 insertions(+)

diff --git a/arch/arm64/boot/dts/renesas/r9a07g043.dtsi b/arch/arm64/boot/dts/renesas/r9a07g043.dtsi
index 44b9bc6294be..afb1abaa8b9a 100644
--- a/arch/arm64/boot/dts/renesas/r9a07g043.dtsi
+++ b/arch/arm64/boot/dts/renesas/r9a07g043.dtsi
@@ -531,6 +531,8 @@ pinctrl: pinctrl@11030000 {
 			gpio-controller;
 			#gpio-cells = <2>;
 			gpio-ranges = <&pinctrl 0 0 152>;
+			#interrupt-cells = <2>;
+			interrupt-controller;
 			clocks = <&cpg CPG_MOD R9A07G043_GPIO_HCLK>;
 			power-domains = <&cpg>;
 			resets = <&cpg R9A07G043_GPIO_RSTN>,
diff --git a/arch/arm64/boot/dts/renesas/r9a07g043u.dtsi b/arch/arm64/boot/dts/renesas/r9a07g043u.dtsi
index 7a8ed7ae253b..65e7b029361e 100644
--- a/arch/arm64/boot/dts/renesas/r9a07g043u.dtsi
+++ b/arch/arm64/boot/dts/renesas/r9a07g043u.dtsi
@@ -98,6 +98,10 @@ &irqc {
 	resets = <&cpg R9A07G043_IA55_RESETN>;
 };
 
+&pinctrl {
+	interrupt-parent = <&irqc>;
+};
+
 &soc {
 	interrupt-parent = <&gic>;
 
-- 
2.25.1

