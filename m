Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2C05F629670
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Nov 2022 11:55:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229722AbiKOKzB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Nov 2022 05:55:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59680 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238453AbiKOKwm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Nov 2022 05:52:42 -0500
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com [IPv6:2a00:1450:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E33B2714B;
        Tue, 15 Nov 2022 02:51:51 -0800 (PST)
Received: by mail-wm1-x32b.google.com with SMTP id 5so9394790wmo.1;
        Tue, 15 Nov 2022 02:51:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HyEqDf0zONZ5Fdec0EnXfdhTnIhb+Oxxv22zZ7JUl/c=;
        b=GW+bkA4PaazkuF/iApqAZFGTaz+gM0M/BOXwidlQjDa+es1IMB+JYc1p8jHjDBN5gk
         iDRAAOaAz6mVlZEZD6fC56HDJj0RxQy5tu2EVLY2sv/3BAbfC4uAuaoUURToyp410SWv
         H1GM+LIhN1MHkR5YqeGxAlXGURgaRRuAtxZDwG0a0FM6sqos4LaUnVVw0AKVg9/VxSl7
         xv+Vr1/3tlERzcmN9k66jaE2ktOrZF3dzEfjs12yJDnCt0oNuHxaSIipn3FXMmXF3Jfz
         tK4scW0ER5OIjdxYtyuIpsMjQn8qycGsYnI+WMcqrSoPedkTh9CdO1KtuwF4ccKHmbcH
         SWdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HyEqDf0zONZ5Fdec0EnXfdhTnIhb+Oxxv22zZ7JUl/c=;
        b=B9oFuHKiX4XLH607A4WoUVevfk0BwKG2cumV9XTywqoJAmuxFwtuqztkRWVMOK0PIO
         rGNYkiVab5k47BZxs+XHW0O3pj53SC7emDWEMUwlCT4m3MZ69xFOiZ1WdhPNtoc3febh
         bWwI5ZfuUXa9mNXa/XOqhZKxn2JmhNs/KP90X/S8ArfMdPL91CRBpUgNMfzMCYBhk7gq
         T2vnBwhcK6EqiPN7BsmGtsccklydtMo49eB11M+kfcaDLI9vyqwiNKrNEA8fTdu+qL5x
         r/hcz6xsyUVLH2g2pSaKmFk1jnrObHhZozQbtAr1t847/7kaTMbd8o/n7LLA7msJ3B21
         WLCw==
X-Gm-Message-State: ANoB5pkm728yozK9hjqn2fPS+I1kFfHdHDbZBeIOO+H1xcSEe9KaSWUK
        4dxwag3E9u0V83fpJFtDluw=
X-Google-Smtp-Source: AA0mqf6P/jewkEk8TdUrUxghgtMbiJTA5+rAtKhSEGvnHmqYTotT7ySyX0rI+nkKCFcMbt/LsC4Imw==
X-Received: by 2002:a05:600c:3586:b0:3cf:8e62:f907 with SMTP id p6-20020a05600c358600b003cf8e62f907mr1035263wmq.7.1668509509515;
        Tue, 15 Nov 2022 02:51:49 -0800 (PST)
Received: from prasmi.home ([2a00:23c8:2501:c701:d94a:6345:c378:e255])
        by smtp.gmail.com with ESMTPSA id az9-20020adfe189000000b002367ad808a9sm12210528wrb.30.2022.11.15.02.51.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Nov 2022 02:51:48 -0800 (PST)
From:   Prabhakar <prabhakar.csengg@gmail.com>
X-Google-Original-From: Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
To:     Geert Uytterhoeven <geert+renesas@glider.be>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Magnus Damm <magnus.damm@gmail.com>,
        Conor Dooley <conor.dooley@microchip.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh+dt@kernel.org>
Cc:     linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-renesas-soc@vger.kernel.org, devicetree@vger.kernel.org,
        Prabhakar <prabhakar.csengg@gmail.com>,
        Biju Das <biju.das.jz@bp.renesas.com>,
        Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: [PATCH 2/3] riscv: dts: renesas: r9a07g043f/rzfive-smarc-som: Enable ADC/OPP/Thermal Zones/TSU
Date:   Tue, 15 Nov 2022 10:51:34 +0000
Message-Id: <20221115105135.1180490-3-prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20221115105135.1180490-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
References: <20221115105135.1180490-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
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

Enable support for below blocks found on RZ/Five SMARC EVK SoC/SoM:
- ADC
- OPP
- Thermal Zones
- TSU

Note, these blocks are enabled in RZ/G2UL SMARC SoM DTSI [0] hence
deleting these disabled nodes from RZ/Five SMARC SoM DTSI enables them
here too as we include [0] in RZ/Five SMARC SoM DTSI.

[0] arch/arm64/boot/dts/renesas/rzg2ul-smarc-som.dtsi

Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
---
 arch/riscv/boot/dts/renesas/r9a07g043f.dtsi       |  2 ++
 arch/riscv/boot/dts/renesas/rzfive-smarc-som.dtsi | 11 -----------
 2 files changed, 2 insertions(+), 11 deletions(-)

diff --git a/arch/riscv/boot/dts/renesas/r9a07g043f.dtsi b/arch/riscv/boot/dts/renesas/r9a07g043f.dtsi
index 50134be548f5..6ec1c6f9a403 100644
--- a/arch/riscv/boot/dts/renesas/r9a07g043f.dtsi
+++ b/arch/riscv/boot/dts/renesas/r9a07g043f.dtsi
@@ -20,6 +20,7 @@ cpus {
 		cpu0: cpu@0 {
 			compatible = "andestech,ax45mp", "riscv";
 			device_type = "cpu";
+			#cooling-cells = <2>;
 			reg = <0x0>;
 			status = "okay";
 			riscv,isa = "rv64imafdc";
@@ -29,6 +30,7 @@ cpu0: cpu@0 {
 			d-cache-size = <0x8000>;
 			d-cache-line-size = <0x40>;
 			clocks = <&cpg CPG_CORE R9A07G043_CLK_I>;
+			operating-points-v2 = <&cluster0_opp>;
 
 			cpu0_intc: interrupt-controller {
 				#interrupt-cells = <1>;
diff --git a/arch/riscv/boot/dts/renesas/rzfive-smarc-som.dtsi b/arch/riscv/boot/dts/renesas/rzfive-smarc-som.dtsi
index 45a182fa3b4b..2b7672bc4b52 100644
--- a/arch/riscv/boot/dts/renesas/rzfive-smarc-som.dtsi
+++ b/arch/riscv/boot/dts/renesas/rzfive-smarc-som.dtsi
@@ -16,13 +16,6 @@ aliases {
 	chosen {
 		bootargs = "ignore_loglevel";
 	};
-
-	/delete-node/opp-table-0;
-	/delete-node/thermal-zones;
-};
-
-&adc {
-	status = "disabled";
 };
 
 &dmac {
@@ -49,10 +42,6 @@ &sdhi0 {
 	status = "disabled";
 };
 
-&tsu {
-	status = "disabled";
-};
-
 &wdt0 {
 	status = "disabled";
 };
-- 
2.25.1

