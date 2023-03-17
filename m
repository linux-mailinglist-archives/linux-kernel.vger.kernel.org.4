Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0F2B26BE959
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Mar 2023 13:35:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230036AbjCQMen (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Mar 2023 08:34:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59596 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229533AbjCQMei (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Mar 2023 08:34:38 -0400
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B66DD26C0C;
        Fri, 17 Mar 2023 05:33:53 -0700 (PDT)
Received: by mail-wm1-x336.google.com with SMTP id k25-20020a7bc419000000b003ed23114fa7so5013275wmi.4;
        Fri, 17 Mar 2023 05:33:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679056409;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ldlgZX8fs60uleVdii+8qFHUam8g5ps9PMRKNSMmtro=;
        b=OLj4Ca6gOYURBz3JJ2i8+KBTQfg+ctugUICw/A6Kxzjx4g0tOciOHGavhANfx/ayyV
         e979ntu0+Lfs84SaR3D1/LMdAax9Su+PqFYleBo8Ra6ffSz7BTQXOFV9VfApa+52hlmy
         i/1IJ/HLDpU2ovF2UhPd0oqgSNLJiCpmnd0r82dFKcr/BS+gjMlue5HIaSKuwbsPFpNc
         z7k13Joutcucv9CEw0LknLwSu0Oad3n0hwew8EacpvWevXRPSsFTby3JwzR1clalBglO
         w2RYNnJ/PhcBf9oTlDwWBDYuT+wbMgPquZhJAUG0ASYCRZwIVKF1EdfZPd4tmkrQdzpG
         G/ng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679056409;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ldlgZX8fs60uleVdii+8qFHUam8g5ps9PMRKNSMmtro=;
        b=x/hTYvYbzXrO3I5o6uMxP+8DNjrx4Ot4uhD9HIdiKg65SPp4czV2n+orB7VgfHwWWU
         mK7FX5DZlm7E/sO6WQ6gu/0s2Mz90FuYdTNjw/jn+ULXqsBaealfr6KM8Pu/KCeuD6av
         Jq6bZNOuqGX2BupF2tC/OAJu6peaJMaWZIIYilGVpfzhpmXWJO6beVrjoemAQCMSpg+h
         yrPlcilHwd6bjGMtLvu+ReBJtwU5f7hEVjuYeOgLM2Ong/us9MDkG9jRi3a2wVkrY7NA
         0e0dwaXEELJ0+zNkUSEo9wrexSEJ0cpgFnVmICFD6N7msOP4CaWl9XpfR9UpeQvw+6jh
         vvAg==
X-Gm-Message-State: AO0yUKUIntqskaNAr/o37jx/mhBkwuOkKOuE+ViRjudlShvd1xBeUWq4
        E5+pDb1Mzlquv4gBQEKP8YNKgjGMtxi08w==
X-Google-Smtp-Source: AK7set+TsegNZ+uI37egKx3tV4txLsxAWySpFo9hJeU3GINd/gORPzzwmtX/ym0ojhA0lONZloHMNQ==
X-Received: by 2002:a7b:c5c8:0:b0:3ed:8079:27d7 with SMTP id n8-20020a7bc5c8000000b003ed807927d7mr1732299wmk.40.1679056409493;
        Fri, 17 Mar 2023 05:33:29 -0700 (PDT)
Received: from prasmi.home ([2a00:23c8:2501:c701:cc60:8c15:c868:fa91])
        by smtp.gmail.com with ESMTPSA id j10-20020a5d464a000000b002cea8f07813sm1876515wrs.81.2023.03.17.05.33.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Mar 2023 05:33:29 -0700 (PDT)
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
Subject: [PATCH v2 1/2] arm64: dts: renesas: r9a07g044: Add CSI and CRU nodes
Date:   Fri, 17 Mar 2023 12:33:13 +0000
Message-Id: <20230317123314.145121-2-prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230317123314.145121-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
References: <20230317123314.145121-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
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

Add CSI and CRU nodes r9a07g044 (RZ/G2L) SoC DTSI.

Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
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

