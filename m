Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1891D6DFE1F
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Apr 2023 20:56:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230313AbjDLS4k (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Apr 2023 14:56:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36434 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230288AbjDLS4a (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Apr 2023 14:56:30 -0400
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com [IPv6:2a00:1450:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6CAB230F3;
        Wed, 12 Apr 2023 11:56:28 -0700 (PDT)
Received: by mail-wm1-x332.google.com with SMTP id s8so7195574wmo.0;
        Wed, 12 Apr 2023 11:56:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1681325786; x=1683917786;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wi2/8kxTREzr2cIcW2upY0bPVzPNjYn2hU+djj6R2RI=;
        b=a3kW0hM45UaQtqz9Jil3hNhigiqzuh6iagZmgAf0cw45bedF4X5HQ+5vpEaebN9fGZ
         822AGSCT57LrnG7sPSQFqXWU7eC0T70n5evGWA+/T/EvqD8pqwr0tWzJolvx0zs1Ao/Q
         jIzO5NNKJzSp0dI4kGR3LykmihqwUufCbGqHRN27jsWzn0MCUmMv6PaZdKi6jg5ZFPbS
         HWcNYSxId5oj7b3Cy8c1dNr4Hc70divJn/zB2YjE3NkBzTlV/Fto3j/8sAxM+BdOMHh+
         dk+bs4JOBxPnq/BUf+JqmBcIvnXDDpjA5hyoJ+BZTNmUhLY0Z5fhzeX+oPPCrRLIibjD
         s0mA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681325786; x=1683917786;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wi2/8kxTREzr2cIcW2upY0bPVzPNjYn2hU+djj6R2RI=;
        b=bcPp7OlZAZ7Ekzlr/INuZ4l3VxJV6+/SHevy2lGMLR6W7iWwZ4G2u9QXsAxETlRNkW
         FcP6IfNHPTIk58fKdUAY6MEAvPKiLbXYCpJNDpMC2i8EPkEbiI/D+cG4Y5kx/uFg9cq8
         Ek2i+5sV/PPjjvfVFebZpkLXzphmvswE/Ro9L62bGiG35nH8UVWqEeokLPkKNkSpy/Ii
         YwAmUzmI/ZyWMOQas0ypsMxs1k7xaCw/u4kLddIXho8vMJ1qbD1N6KkGr42dIN+6MS+b
         HpFwE3gfZbbFMNA6z3+WYe/2tUhpvyKtMhhKh8eF7W0Gl7eRSbyzHsqo8Z1JqBHRZydO
         qJew==
X-Gm-Message-State: AAQBX9fKqM8OTjx+c/rlvgezK6Y7IUNa2G+ztHlTJHRIPs8x0PAuxeky
        F6jDPkip+wkJsGQesQnNX7M=
X-Google-Smtp-Source: AKy350YpaQ4gHvLfYnk4OzwLhaEv+LDZgMVlcLW9E7EKhVKY3uFcFYGqvNQlnT215v/wY6FY34kNWA==
X-Received: by 2002:a7b:c44c:0:b0:3d0:6a57:66a5 with SMTP id l12-20020a7bc44c000000b003d06a5766a5mr1284wmi.0.1681325786465;
        Wed, 12 Apr 2023 11:56:26 -0700 (PDT)
Received: from prasmi.home ([2a00:23c8:2501:c701:a00d:9fa0:9d0c:b9db])
        by smtp.gmail.com with ESMTPSA id r13-20020a05600c35cd00b003ede03e4369sm3362705wmq.33.2023.04.12.11.56.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Apr 2023 11:56:25 -0700 (PDT)
From:   Prabhakar <prabhakar.csengg@gmail.com>
X-Google-Original-From: Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
To:     Geert Uytterhoeven <geert+renesas@glider.be>,
        Magnus Damm <magnus.damm@gmail.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-renesas-soc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Prabhakar <prabhakar.csengg@gmail.com>,
        Biju Das <biju.das.jz@bp.renesas.com>,
        Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: [PATCH 1/2] arm64: dts: renesas: r9a07g054: Add CSI and CRU nodes
Date:   Wed, 12 Apr 2023 19:56:07 +0100
Message-Id: <20230412185608.64628-2-prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230412185608.64628-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
References: <20230412185608.64628-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
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

Add CSI and CRU nodes to r9a07g054 (RZ/V2L) SoC DTSI.

Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
---
 arch/arm64/boot/dts/renesas/r9a07g054.dtsi | 79 ++++++++++++++++++++++
 1 file changed, 79 insertions(+)

diff --git a/arch/arm64/boot/dts/renesas/r9a07g054.dtsi b/arch/arm64/boot/dts/renesas/r9a07g054.dtsi
index cc11e5855d62..f87bce02e043 100644
--- a/arch/arm64/boot/dts/renesas/r9a07g054.dtsi
+++ b/arch/arm64/boot/dts/renesas/r9a07g054.dtsi
@@ -623,6 +623,85 @@ sbc: spi@10060000 {
 			status = "disabled";
 		};
 
+		cru: video@10830000 {
+			compatible = "renesas,r9a07g054-cru", "renesas,rzg2l-cru";
+			reg = <0 0x10830000 0 0x400>;
+			clocks = <&cpg CPG_MOD R9A07G054_CRU_VCLK>,
+				 <&cpg CPG_MOD R9A07G054_CRU_PCLK>,
+				 <&cpg CPG_MOD R9A07G054_CRU_ACLK>;
+			clock-names = "video", "apb", "axi";
+			interrupts = <GIC_SPI 167 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 168 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 169 IRQ_TYPE_LEVEL_HIGH>;
+			interrupt-names = "image_conv", "image_conv_err", "axi_mst_err";
+			resets = <&cpg R9A07G054_CRU_PRESETN>,
+				 <&cpg R9A07G054_CRU_ARESETN>;
+			reset-names = "presetn", "aresetn";
+			power-domains = <&cpg>;
+			status = "disabled";
+
+			ports {
+				#address-cells = <1>;
+				#size-cells = <0>;
+
+				port@0 {
+					#address-cells = <1>;
+					#size-cells = <0>;
+
+					reg = <0>;
+					cruparallel: endpoint@0 {
+						reg = <0>;
+					};
+				};
+
+				port@1 {
+					#address-cells = <1>;
+					#size-cells = <0>;
+
+					reg = <1>;
+					crucsi2: endpoint@0 {
+						reg = <0>;
+						remote-endpoint = <&csi2cru>;
+					};
+				};
+			};
+		};
+
+		csi2: csi2@10830400 {
+			compatible = "renesas,r9a07g054-csi2", "renesas,rzg2l-csi2";
+			reg = <0 0x10830400 0 0xfc00>;
+			interrupts = <GIC_SPI 166 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&cpg CPG_MOD R9A07G054_CRU_SYSCLK>,
+				 <&cpg CPG_MOD R9A07G054_CRU_VCLK>,
+				 <&cpg CPG_MOD R9A07G054_CRU_PCLK>;
+			clock-names = "system", "video", "apb";
+			resets = <&cpg R9A07G054_CRU_PRESETN>,
+				 <&cpg R9A07G054_CRU_CMN_RSTB>;
+			reset-names = "presetn", "cmn-rstb";
+			power-domains = <&cpg>;
+			status = "disabled";
+
+			ports {
+				#address-cells = <1>;
+				#size-cells = <0>;
+
+				port@0 {
+					reg = <0>;
+				};
+
+				port@1 {
+					#address-cells = <1>;
+					#size-cells = <0>;
+					reg = <1>;
+
+					csi2cru: endpoint@0 {
+						reg = <0>;
+						remote-endpoint = <&crucsi2>;
+					};
+				};
+			};
+		};
+
 		cpg: clock-controller@11010000 {
 			compatible = "renesas,r9a07g054-cpg";
 			reg = <0 0x11010000 0 0x10000>;
-- 
2.25.1

