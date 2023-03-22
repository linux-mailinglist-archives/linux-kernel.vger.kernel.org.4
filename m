Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AE7096C4B30
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Mar 2023 13:57:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229673AbjCVM5E (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Mar 2023 08:57:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49970 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230464AbjCVM5B (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Mar 2023 08:57:01 -0400
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4DD435F509;
        Wed, 22 Mar 2023 05:57:00 -0700 (PDT)
Received: by mail-wr1-x433.google.com with SMTP id l27so8649656wrb.2;
        Wed, 22 Mar 2023 05:57:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679489819;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xZCXW/2DQwjo2NSTCO/6DdFMwtXOMhz06C8yg8pHV5o=;
        b=Q0fG6vWI7svwUfChlkkFxcYCw20TeLJIIoqJYTM8Jj4GUwnNu+UktrrzC8eNEBYw+o
         H7Uzk8n0KQ9T3vQ7HH+959W4gNAA6M3aCx70CfJKas6CQujn0VrNga3G4HibZ83UFnby
         NNM078l6NiANsWA03PC4dduWBLzLwz+AXsETMCceW1KGfhqaJok3DHyUF/20hCWRUOUw
         PJ2cNJxKQjetbT8txG4hJQfOKfm4aRy2wjssdtGqYlcn4EQwlf5L/JxdhFSmLEfsCaNT
         b5Db9qE+YP3gVkv+YlioeaHt0unG39bdUatCgnsGa9i5qvMvu7Ot7wZImbRmIE28Fcpz
         CWow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679489819;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xZCXW/2DQwjo2NSTCO/6DdFMwtXOMhz06C8yg8pHV5o=;
        b=e52BOXjitSetfI89Ff+NUMpFwcs8a4NPKdIxKQXpatVInT7tG22m2DOsqdsGsMT9Wr
         KzxqLaT8USq1POW9kVLUS2FC8k/SPig64QXbnK5zlCFJem1Z1TINg99SjSgmuT/W76qM
         8fe2XVD0BhVX+hd+Luj37qoFb0PbJXmToUKdlbJywb3BgCAAZlc078VEHgEEmHbWJcyk
         GV9eKw6hc20y/z0hwThIYexs71Kp4MH0MV6GM6k2JH9TVDIZJolHC+rIGMQ5Qb43IpOO
         /AZPcYjCdzD/Pa1HiAdAOC0jyJxl/jP8xbucm10Gs0E7h6ZiJxcr5UgDIDF2UDfpGr3F
         WbHA==
X-Gm-Message-State: AO0yUKXngpHl/L+2P/OGA3I4RAV5/A5orgXdUs6BTKDdrRTPZDSzXLLQ
        bSCfTQbI3vWcxy/D5aL76Fc=
X-Google-Smtp-Source: AK7set8cbl9u+5mkG/G/yMYQXCKk/1NeZvSEND4VC11p/GMEzKPgZsjBfwps878+vvt2K4QuFkDK6w==
X-Received: by 2002:a5d:624a:0:b0:2d2:62b3:87e9 with SMTP id m10-20020a5d624a000000b002d262b387e9mr4751576wrv.45.1679489818556;
        Wed, 22 Mar 2023 05:56:58 -0700 (PDT)
Received: from prasmi.home ([2a00:23c8:2501:c701:9c35:3f3f:458c:5fef])
        by smtp.gmail.com with ESMTPSA id m23-20020a056000181700b002c5694aef92sm13707167wrh.21.2023.03.22.05.56.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Mar 2023 05:56:58 -0700 (PDT)
From:   Prabhakar <prabhakar.csengg@gmail.com>
X-Google-Original-From: Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
To:     Geert Uytterhoeven <geert+renesas@glider.be>,
        Magnus Damm <magnus.damm@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     linux-renesas-soc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Prabhakar <prabhakar.csengg@gmail.com>,
        Biju Das <biju.das.jz@bp.renesas.com>,
        Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: [PATCH v3 1/2] arm64: dts: renesas: r9a07g044: Add CSI and CRU nodes
Date:   Wed, 22 Mar 2023 12:56:47 +0000
Message-Id: <20230322125648.24948-2-prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230322125648.24948-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
References: <20230322125648.24948-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>

Add CSI and CRU nodes r9a07g044 (RZ/G2L) SoC DTSI.

Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
v2->v3
* No change

v1->v2
* Dropped using SOC_PREFIX() macro
* Added RB tag
---
 arch/arm64/boot/dts/renesas/r9a07g044.dtsi | 79 ++++++++++++++++++++++
 1 file changed, 79 insertions(+)

diff --git a/arch/arm64/boot/dts/renesas/r9a07g044.dtsi b/arch/arm64/boot/dts/renesas/r9a07g044.dtsi
index 79cffbf20c55..0a50926cb53e 100644
--- a/arch/arm64/boot/dts/renesas/r9a07g044.dtsi
+++ b/arch/arm64/boot/dts/renesas/r9a07g044.dtsi
@@ -618,6 +618,85 @@ sbc: spi@10060000 {
 			status = "disabled";
 		};
 
+		cru: video@10830000 {
+			compatible = "renesas,r9a07g044-cru", "renesas,rzg2l-cru";
+			reg = <0 0x10830000 0 0x400>;
+			clocks = <&cpg CPG_MOD R9A07G044_CRU_VCLK>,
+				 <&cpg CPG_MOD R9A07G044_CRU_PCLK>,
+				 <&cpg CPG_MOD R9A07G044_CRU_ACLK>;
+			clock-names = "video", "apb", "axi";
+			interrupts = <GIC_SPI 167 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 168 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 169 IRQ_TYPE_LEVEL_HIGH>;
+			interrupt-names = "image_conv", "image_conv_err", "axi_mst_err";
+			resets = <&cpg R9A07G044_CRU_PRESETN>,
+				 <&cpg R9A07G044_CRU_ARESETN>;
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
+			compatible = "renesas,r9a07g044-csi2", "renesas,rzg2l-csi2";
+			reg = <0 0x10830400 0 0xfc00>;
+			interrupts = <GIC_SPI 166 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&cpg CPG_MOD R9A07G044_CRU_SYSCLK>,
+				 <&cpg CPG_MOD R9A07G044_CRU_VCLK>,
+				 <&cpg CPG_MOD R9A07G044_CRU_PCLK>;
+			clock-names = "system", "video", "apb";
+			resets = <&cpg R9A07G044_CRU_PRESETN>,
+				 <&cpg R9A07G044_CRU_CMN_RSTB>;
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
 			compatible = "renesas,r9a07g044-cpg";
 			reg = <0 0x11010000 0 0x10000>;
-- 
2.25.1

