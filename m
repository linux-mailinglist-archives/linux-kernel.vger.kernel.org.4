Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B4DCF5BED25
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Sep 2022 20:51:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231281AbiITSvK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Sep 2022 14:51:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56530 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231178AbiITSuU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Sep 2022 14:50:20 -0400
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 92A7D74363;
        Tue, 20 Sep 2022 11:50:17 -0700 (PDT)
Received: by mail-wr1-x42b.google.com with SMTP id bq9so5961653wrb.4;
        Tue, 20 Sep 2022 11:50:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=huhfPl8+Ue6w49fzQoqMzRhfuePqblfjXffK332HZYQ=;
        b=ZQjck0mz1NJl+RRbDkDFrZ1Q9/1w20hB5vvd0dF4f9EerXG9HaP2wChEiLG5aaZ4Kw
         tIBvz+EWoCVYqaf74M0UGrLUL5QCZp5aapzOM5Dq4TCIaiHm2ZIjbHTQbbnDuZVKaQlI
         PuzgIilhOhJrzDsiGPj/Ujuejm3HCjb3Srp/mr1k+eY0diwNYr0WKmAYTz/5P0iCBs8I
         pqHZIOwJm+nBrwY8ulFO4bhR6VYT2ojWULuK/nNdoZyxNWmpyEQtvSqL5oecrgy0J80w
         CWrhOMGFQ8IuwBvyRyemIoWbKFH1W+QTDStjf1+0Iv7VTqsz3ky8t/NguXAaTpRbD0UU
         3WJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=huhfPl8+Ue6w49fzQoqMzRhfuePqblfjXffK332HZYQ=;
        b=f5B5Ve5BfdIPx72sgnsvkqg2sGklGtdMPFNP31cUKDkAO5rHis0mN6znYyp2flnqOo
         xp7/KEeJmy8RD4BtWmQCs7G+75277SGTxQ4kUwMGO76ahkZly0B45NeogrpX2h7jwVRG
         rTr+YWn9vdMenwobBeVc3N5pMCfi9v/1dHw8eIJP4APM7122HF9O67qSo5pGF3jK8qKx
         k86prl1S9N219mgE7xerqx/IIa0Khbkz+2br09Et4vG+ep7Eg4QIH/zKmAFe6srRS1sm
         tk2kKG1L5Bn645P12Znvg8lmT4XZ11uajdlJGTdUuwIEer3u6u/3DiaFgVhKobFl8uQB
         VE8w==
X-Gm-Message-State: ACrzQf0cuftrbYIrYOYxx5Djd5/8LXd34KcGoy9yUIQUdyfmdinq0TLJ
        rhBvcevsbmLYWdrEfuzXfYg=
X-Google-Smtp-Source: AMsMyM5P7vfaGfUtFwt4Kdyyd3Ifr620ytmNRKzPAhGTWtJMHr5MX79q+mtppyXZ320XyzU9w1dACg==
X-Received: by 2002:a5d:64e5:0:b0:22a:43a7:b9df with SMTP id g5-20020a5d64e5000000b0022a43a7b9dfmr15294792wri.79.1663699815859;
        Tue, 20 Sep 2022 11:50:15 -0700 (PDT)
Received: from prasmi.home ([2a00:23c8:2501:c701:e9a4:d6c9:505d:20d0])
        by smtp.gmail.com with ESMTPSA id cc4-20020a5d5c04000000b00228de351fc0sm582722wrb.38.2022.09.20.11.50.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Sep 2022 11:50:15 -0700 (PDT)
From:   Prabhakar <prabhakar.csengg@gmail.com>
X-Google-Original-From: Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Magnus Damm <magnus.damm@gmail.com>,
        Conor Dooley <conor.dooley@microchip.com>
Cc:     Heiko Stuebner <heiko@sntech.de>,
        Heinrich Schuchardt <heinrich.schuchardt@canonical.com>,
        Atish Patra <atishp@rivosinc.com>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org,
        linux-renesas-soc@vger.kernel.org,
        Prabhakar <prabhakar.csengg@gmail.com>,
        Biju Das <biju.das.jz@bp.renesas.com>,
        Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: [PATCH v4 07/10] riscv: dts: r9a07g043: Add placeholder nodes
Date:   Tue, 20 Sep 2022 19:49:01 +0100
Message-Id: <20220920184904.90495-8-prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220920184904.90495-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
References: <20220920184904.90495-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
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

This is in preparation to reuse the RZ/G2UL SMARC SoM and carrier board
DTSIs([0] and [1]).

As the RZ/G2UL SMARC EVK enables almost all the blocks supported by the
SoC and whereas for the RZ/Five SMARC EVK we will gradually be enabling
the blocks as a result we are adding the placeholder nodes to avoid DTB
compilation errors (currently we dont have support in DTC to delete the
reference nodes without actual nodes).

[0] arch/arm64/boot/dts/renesas/rzg2ul-smarc-som.dtsi
[1] arch/arm64/boot/dts/renesas/rzg2ul-smarc.dtsi

Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
---
v3 -> v4
* Dropped status and reg-names properties
* Updated the commit message
* Note sbc node is not enabled in RZ/G2UL SMARC EVK but will be soon
  enabled so added a placeholder for this too.

v2 -> v3
* New patch
---
 arch/riscv/boot/dts/renesas/r9a07g043.dtsi | 150 +++++++++++++++++++++
 1 file changed, 150 insertions(+)

diff --git a/arch/riscv/boot/dts/renesas/r9a07g043.dtsi b/arch/riscv/boot/dts/renesas/r9a07g043.dtsi
index fb6733f3cc2b..d90d263b1b13 100644
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
@@ -54,6 +62,19 @@ soc: soc {
 		#size-cells = <2>;
 		ranges;
 
+		ssi1: ssi@1004a000 {
+			reg = <0 0x1004a000 0 0x400>;
+			#sound-dai-cells = <0>;
+
+			/* placeholder */
+		};
+
+		spi1: spi@1004b000 {
+			reg = <0 0x1004b000 0 0x400>;
+
+			/* placeholder */
+		};
+
 		scif0: serial@1004b800 {
 			compatible = "renesas,scif-r9a07g043",
 				     "renesas,scif-r9a07g044";
@@ -73,6 +94,41 @@ scif0: serial@1004b800 {
 			status = "disabled";
 		};
 
+		canfd: can@10050000 {
+			reg = <0 0x10050000 0 0x8000>;
+
+			/* placeholder */
+		};
+
+		i2c0: i2c@10058000 {
+			reg = <0 0x10058000 0 0x400>;
+			#address-cells = <1>;
+			#size-cells = <0>;
+			/* placeholder */
+		};
+
+		i2c1: i2c@10058400 {
+			reg = <0 0x10058400 0 0x400>;
+			#address-cells = <1>;
+			#size-cells = <0>;
+
+			/* placeholder */
+		};
+
+		adc: adc@10059000 {
+			reg = <0 0x10059000 0 0x400>;
+
+			/* placeholder */
+		};
+
+		sbc: spi@10060000 {
+			reg = <0 0x10060000 0 0x10000>,
+			      <0 0x20000000 0 0x10000000>,
+			      <0 0x10070000 0 0x10000>;
+
+			/* placeholder */
+		};
+
 		cpg: clock-controller@11010000 {
 			compatible = "renesas,r9a07g043-cpg";
 			reg = <0 0x11010000 0 0x10000>;
@@ -104,6 +160,82 @@ pinctrl: pinctrl@11030000 {
 				 <&cpg R9A07G043_GPIO_SPARE_RESETN>;
 		};
 
+		sdhi0: mmc@11c00000 {
+			reg = <0x0 0x11c00000 0 0x10000>;
+
+			/* placeholder */
+		};
+
+		sdhi1: mmc@11c10000 {
+			reg = <0x0 0x11c10000 0 0x10000>;
+
+			/* placeholder */
+		};
+
+		eth0: ethernet@11c20000 {
+			reg = <0 0x11c20000 0 0x10000>;
+			#address-cells = <1>;
+			#size-cells = <0>;
+
+			/* placeholder */
+		};
+
+		eth1: ethernet@11c30000 {
+			reg = <0 0x11c30000 0 0x10000>;
+			#address-cells = <1>;
+			#size-cells = <0>;
+
+			/* placeholder */
+		};
+
+		phyrst: usbphy-ctrl@11c40000 {
+			reg = <0 0x11c40000 0 0x10000>;
+
+			/* placeholder */
+		};
+
+		ohci0: usb@11c50000 {
+			reg = <0 0x11c50000 0 0x100>;
+
+			/* placeholder */
+		};
+
+		ohci1: usb@11c70000 {
+			reg = <0 0x11c70000 0 0x100>;
+
+			/* placeholder */
+		};
+
+		ehci0: usb@11c50100 {
+			reg = <0 0x11c50100 0 0x100>;
+
+			/* placeholder */
+		};
+
+		ehci1: usb@11c70100 {
+			reg = <0 0x11c70100 0 0x100>;
+
+			/* placeholder */
+		};
+
+		usb2_phy0: usb-phy@11c50200 {
+			reg = <0 0x11c50200 0 0x700>;
+
+			/* placeholder */
+		};
+
+		usb2_phy1: usb-phy@11c70200 {
+			reg = <0 0x11c70200 0 0x700>;
+
+			/* placeholder */
+		};
+
+		hsusb: usb@11c60000 {
+			reg = <0 0x11c60000 0 0x10000>;
+
+			/* placeholder */
+		};
+
 		plic: interrupt-controller@12c00000 {
 			compatible = "renesas,r9a07g043-plic", "andestech,nceplic100";
 			#interrupt-cells = <2>;
@@ -116,5 +248,23 @@ plic: interrupt-controller@12c00000 {
 			resets = <&cpg R9A07G043_NCEPLIC_ARESETN>;
 			interrupts-extended = <&cpu0_intc 11 &cpu0_intc 9>;
 		};
+
+		wdt0: watchdog@12800800 {
+			reg = <0 0x12800800 0 0x400>;
+
+			/* placeholder */
+		};
+
+		ostm1: timer@12801400 {
+			reg = <0x0 0x12801400 0x0 0x400>;
+
+			/* placeholder */
+		};
+
+		ostm2: timer@12801800 {
+			reg = <0x0 0x12801800 0x0 0x400>;
+
+			/* placeholder */
+		};
 	};
 };
-- 
2.25.1

