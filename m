Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CBFD25BA0C0
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Sep 2022 20:18:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229636AbiIOSST (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Sep 2022 14:18:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38926 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229907AbiIOSRw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Sep 2022 14:17:52 -0400
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com [IPv6:2a00:1450:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 774A495E61;
        Thu, 15 Sep 2022 11:17:38 -0700 (PDT)
Received: by mail-wm1-x32c.google.com with SMTP id r3-20020a05600c35c300b003b4b5f6c6bdso855846wmq.2;
        Thu, 15 Sep 2022 11:17:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=h7rmDnDbEL5nfCcVBsfSnk+K+mwOgzf5y2MGdbkhmos=;
        b=pJ+WzY3CCFUWtX4TsruXqFq2+vI90gSDypxzOkr2djU2Rj0ml3PS1t96Zx0i2lZ2wM
         vCYotryDXl75WPhpCDPwhBNQSOMJv6hSEluVzcMeieuoobhBBV9ur0buMnwLJgsmjxnp
         XVpSNQyJzSlYeEsUWjP0JWZm/FaxpvEUVcBpXkXoelZ1exDOtgW4kx4lgolnLmj46Rs+
         y+DGl0webU/vwpfufgNaT6k0j6pDRy3L9TYfMzC8CTLex6fQGFSowm6nahPGyx8iamcK
         2bJuIT74TkPfmAT7cZo4Bie83H9TbZ3vixCHv6bcak24ma3jf1grEXg4FrZtb11g+YUU
         swRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=h7rmDnDbEL5nfCcVBsfSnk+K+mwOgzf5y2MGdbkhmos=;
        b=WTkGZ3GvhrlSakN7H9QQUMunhLIBxbKH2B5wM2YPKQ7JM0Q7+NpbwPbvOYq3k1rpI+
         J7k8m572HJGpUC7PI0HLt0EjAGo3x6TucMWsUQ1llHAPe+rjY8JIYAR58+t/bDS8Y1oy
         3noAPzy1ZsU7I3Y/vVmGOnxYNiwKFut3DGlgirzPUvXkxEc8JAoWWubxOa060mEJ5oCp
         Bf+4sBmcY3c1fdRk5z/jbkmTwPYPBIeTz7JJOWiec3DBQk3LxbS0GB+aM/zvMKJI2dGr
         QPJUbplFylfCMamU1Evdtc+a8w1/panwFGzYsyeJWFEGHUDfjrrj/jarr9/gszQ+28KE
         J0ng==
X-Gm-Message-State: ACgBeo2r/elDXwXsr7VfC0uhYEY//cW8tRspGkB6sGmoi8RhDqGpD0WI
        6OTqlo4zShXeGnTgMisOZFM=
X-Google-Smtp-Source: AA6agR6pdr/WhjUQs5dbPdMFvVEN7qcpsDILeWhlX+kudsNMORv11FDp6hzHNX+T5WBRNGOTYfw7zQ==
X-Received: by 2002:a05:600c:229a:b0:3b4:810a:8b4f with SMTP id 26-20020a05600c229a00b003b4810a8b4fmr7749657wmf.117.1663265856553;
        Thu, 15 Sep 2022 11:17:36 -0700 (PDT)
Received: from prasmi.home ([2a00:23c8:2501:c701:d411:a48b:4035:3d98])
        by smtp.gmail.com with ESMTPSA id c11-20020a05600c0a4b00b003b47e8a5d22sm4243151wmq.23.2022.09.15.11.17.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Sep 2022 11:17:35 -0700 (PDT)
From:   Prabhakar <prabhakar.csengg@gmail.com>
X-Google-Original-From: Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
To:     Geert Uytterhoeven <geert+renesas@glider.be>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>
Cc:     Heiko Stuebner <heiko@sntech.de>,
        Atish Patra <atishp@rivosinc.com>,
        Conor Dooley <conor.dooley@microchip.com>,
        devicetree@vger.kernel.org, linux-riscv@lists.infradead.org,
        linux-renesas-soc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Prabhakar <prabhakar.csengg@gmail.com>,
        Biju Das <biju.das.jz@bp.renesas.com>,
        Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: [PATCH v3 07/10] riscv: boot: dts: r9a07g043: Add placeholder nodes
Date:   Thu, 15 Sep 2022 19:15:55 +0100
Message-Id: <20220915181558.354737-8-prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220915181558.354737-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
References: <20220915181558.354737-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
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

Add empty placeholder nodes to RZ/Five (R9A07G043) SoC DTSI.

This is in preparation to reuse the RZ/G2UL SMARC SoM and carrier
board DTS/I.

Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
---
v1->v3
* New patch
---
 arch/riscv/boot/dts/renesas/r9a07g043.dtsi | 177 +++++++++++++++++++++
 1 file changed, 177 insertions(+)

diff --git a/arch/riscv/boot/dts/renesas/r9a07g043.dtsi b/arch/riscv/boot/dts/renesas/r9a07g043.dtsi
index fb6733f3cc2b..6d9db759a847 100644
--- a/arch/riscv/boot/dts/renesas/r9a07g043.dtsi
+++ b/arch/riscv/boot/dts/renesas/r9a07g043.dtsi
@@ -13,6 +13,14 @@ / {
 	#address-cells = <2>;
 	#size-cells = <2>;
 
+	audio_clk1: audio1-clk {
+		/* placeholder */
+	};
+
+	audio_clk2: audio2-clk {
+		/* placeholder */
+	};
+
 	cpus {
 		#address-cells = <1>;
 		#size-cells = <0>;
@@ -54,6 +62,23 @@ soc: soc {
 		#size-cells = <2>;
 		ranges;
 
+		ssi1: ssi@1004a000 {
+			reg = <0 0x1004a000 0 0x400>;
+			#sound-dai-cells = <0>;
+			status = "disabled";
+
+			/* placeholder */
+		};
+
+		spi1: spi@1004b000 {
+			reg = <0 0x1004b000 0 0x400>;
+			#address-cells = <1>;
+			#size-cells = <0>;
+			status = "disabled";
+
+			/* placeholder */
+		};
+
 		scif0: serial@1004b800 {
 			compatible = "renesas,scif-r9a07g043",
 				     "renesas,scif-r9a07g044";
@@ -73,6 +98,48 @@ scif0: serial@1004b800 {
 			status = "disabled";
 		};
 
+		canfd: can@10050000 {
+			reg = <0 0x10050000 0 0x8000>;
+			status = "disabled";
+
+			/* placeholder */
+		};
+
+		i2c0: i2c@10058000 {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			reg = <0 0x10058000 0 0x400>;
+			status = "disabled";
+
+			/* placeholder */
+		};
+
+		i2c1: i2c@10058400 {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			reg = <0 0x10058400 0 0x400>;
+			status = "disabled";
+
+			/* placeholder */
+		};
+
+		adc: adc@10059000 {
+			reg = <0 0x10059000 0 0x400>;
+			status = "disabled";
+
+			/* placeholder */
+		};
+
+		sbc: spi@10060000 {
+			reg = <0 0x10060000 0 0x10000>,
+			      <0 0x20000000 0 0x10000000>,
+			      <0 0x10070000 0 0x10000>;
+			reg-names = "regs", "dirmap", "wbuf";
+			status = "disabled";
+
+			/* placeholder */
+		};
+
 		cpg: clock-controller@11010000 {
 			compatible = "renesas,r9a07g043-cpg";
 			reg = <0 0x11010000 0 0x10000>;
@@ -104,6 +171,95 @@ pinctrl: pinctrl@11030000 {
 				 <&cpg R9A07G043_GPIO_SPARE_RESETN>;
 		};
 
+		sdhi0: mmc@11c00000 {
+			reg = <0x0 0x11c00000 0 0x10000>;
+			status = "disabled";
+
+			/* placeholder */
+		};
+
+		sdhi1: mmc@11c10000 {
+			reg = <0x0 0x11c10000 0 0x10000>;
+			status = "disabled";
+
+			/* placeholder */
+		};
+
+		eth0: ethernet@11c20000 {
+			reg = <0 0x11c20000 0 0x10000>;
+			#address-cells = <1>;
+			#size-cells = <0>;
+			status = "disabled";
+
+			/* placeholder */
+		};
+
+		eth1: ethernet@11c30000 {
+			reg = <0 0x11c30000 0 0x10000>;
+			#address-cells = <1>;
+			#size-cells = <0>;
+			status = "disabled";
+
+			/* placeholder */
+		};
+
+		phyrst: usbphy-ctrl@11c40000 {
+			reg = <0 0x11c40000 0 0x10000>;
+			#reset-cells = <1>;
+			status = "disabled";
+
+			/* placeholder */
+		};
+
+		ohci0: usb@11c50000 {
+			reg = <0 0x11c50000 0 0x100>;
+			status = "disabled";
+
+			/* placeholder */
+		};
+
+		ohci1: usb@11c70000 {
+			reg = <0 0x11c70000 0 0x100>;
+			status = "disabled";
+
+			/* placeholder */
+		};
+
+		ehci0: usb@11c50100 {
+			reg = <0 0x11c50100 0 0x100>;
+			status = "disabled";
+
+			/* placeholder */
+		};
+
+		ehci1: usb@11c70100 {
+			reg = <0 0x11c70100 0 0x100>;
+			status = "disabled";
+
+			/* placeholder */
+		};
+
+		usb2_phy0: usb-phy@11c50200 {
+			reg = <0 0x11c50200 0 0x700>;
+			status = "disabled";
+
+			/* placeholder */
+		};
+
+		usb2_phy1: usb-phy@11c70200 {
+			reg = <0 0x11c70200 0 0x700>;
+			status = "disabled";
+
+			/* placeholder */
+		};
+
+		hsusb: usb@11c60000 {
+			reg = <0 0x11c60000 0 0x10000>;
+			status = "disabled";
+
+			/* placeholder */
+		};
+
 		plic: interrupt-controller@12c00000 {
 			compatible = "renesas,r9a07g043-plic", "andestech,nceplic100";
 			#interrupt-cells = <2>;
@@ -116,5 +272,26 @@ plic: interrupt-controller@12c00000 {
 			resets = <&cpg R9A07G043_NCEPLIC_ARESETN>;
 			interrupts-extended = <&cpu0_intc 11 &cpu0_intc 9>;
 		};
+
+		wdt0: watchdog@12800800 {
+			reg = <0 0x12800800 0 0x400>;
+			status = "disabled";
+
+			/* placeholder */
+		};
+
+		ostm1: timer@12801400 {
+			reg = <0x0 0x12801400 0x0 0x400>;
+			status = "disabled";
+
+			/* placeholder */
+		};
+
+		ostm2: timer@12801800 {
+			reg = <0x0 0x12801800 0x0 0x400>;
+			status = "disabled";
+
+			/* placeholder */
+		};
 	};
 };
-- 
2.25.1

