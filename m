Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A0E0C699BA3
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Feb 2023 18:54:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230099AbjBPRyH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Feb 2023 12:54:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36008 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230029AbjBPRyF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Feb 2023 12:54:05 -0500
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 101AB1BD1;
        Thu, 16 Feb 2023 09:54:04 -0800 (PST)
Received: by mail-wm1-x32a.google.com with SMTP id m20-20020a05600c3b1400b003e1e754657aso4842575wms.2;
        Thu, 16 Feb 2023 09:54:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fsnnXrGjSFWEPm5CWqloaKqDhJT1psg1t9dTnw05I+s=;
        b=WkBQvpQP9hcUr4Yb7UY8gP3xGFXv7ITKCyRGvvFlyhtIcSD5+GTIK22Pb1LINOPlL3
         c9In0GzByClzeTHpVAO6UXTv7UUxTvSLy1lQd2salLYsc5IC9fejSyD8bCfv2M6D+umr
         gSmQCe8/j2pQ+b1KCviC5TosE12Ho836UK1DX9Yk3Xh+v2xXe5g/mklTbtDAl2rDX0bE
         Qn9QpBj48niXaHGL9Nk8wqJd/z/nKkvc+A2AcjI9NPK5CmuiB5nRKc4Farhj1uQ8n/Ww
         Rm2L6JyRabiaaOI0Pj6NoeKCym6Me5mQBeIYn1IeHyqG6Kl4Y8vyOrwoZUwTJm2eVe4L
         fZaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fsnnXrGjSFWEPm5CWqloaKqDhJT1psg1t9dTnw05I+s=;
        b=MUp9TM4+5PvTlGDnNScSGznZCEwwATonMhl3fTGp5d5t+WZ2hi0h5dNUEbNkVu/b07
         Us0bZ7cnst+nSXBK2r5cqozjVrn3KRwreCddmb2tMZYaRWq+GBD1WY7oCeZgAX3+v/4e
         YRdf18rnRxvH12KvfmIObokfLE3AaVeqMUHXc4ekH/PXGJxECiDr7sfQYzME71/8MK54
         wJGD4mCYW6PybO4twtJ0xFffYkNZgDL/tOjPVKFuiAf9nwEKeyCy6xp6+BspODB2GteF
         lh37mqwRvzOvXUNcv7LWvbDgN9SBYhlB24qP25XLVrYC/pev2Ucly3BtkHpSnPP/U0H5
         hxhA==
X-Gm-Message-State: AO0yUKXe8R6uCunnp7r/u/t3/aiHWZJF+jbdmDTJhvAym1o1LxobeVLp
        ICR+kdPkTbCALmchxmWGazHWTPgfZ/llKA==
X-Google-Smtp-Source: AK7set9bgnBmaGTRk9onV8zOknwRYTFctXIShIpOreYy6FgpVZavqHFnlULt+WQI+FxLgaPVY/Z8fA==
X-Received: by 2002:a05:600c:5486:b0:3dd:37a5:dc90 with SMTP id iv6-20020a05600c548600b003dd37a5dc90mr5550444wmb.32.1676570042573;
        Thu, 16 Feb 2023 09:54:02 -0800 (PST)
Received: from prasmi.home ([2a00:23c8:2501:c701:31b2:19e1:4409:5c3b])
        by smtp.gmail.com with ESMTPSA id o10-20020a1c750a000000b003dc4aae4739sm5826836wmc.27.2023.02.16.09.54.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Feb 2023 09:54:01 -0800 (PST)
From:   Prabhakar <prabhakar.csengg@gmail.com>
X-Google-Original-From: Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
To:     Geert Uytterhoeven <geert+renesas@glider.be>,
        Magnus Damm <magnus.damm@gmail.com>
Cc:     Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>,
        =?UTF-8?q?Niklas=20S=C3=B6derlund?= 
        <niklas.soderlund+renesas@ragnatech.se>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-renesas-soc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Prabhakar <prabhakar.csengg@gmail.com>,
        Biju Das <biju.das.jz@bp.renesas.com>,
        Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: [PATCH 1/3] arm64: dts: renesas: r9a07g044: Add CSI and CRU nodes
Date:   Thu, 16 Feb 2023 17:53:45 +0000
Message-Id: <20230216175347.99778-2-prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230216175347.99778-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
References: <20230216175347.99778-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
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
---
 arch/arm64/boot/dts/renesas/r9a07g044.dtsi | 79 ++++++++++++++++++++++
 1 file changed, 79 insertions(+)

diff --git a/arch/arm64/boot/dts/renesas/r9a07g044.dtsi b/arch/arm64/boot/dts/renesas/r9a07g044.dtsi
index 9a3e18abae39..68bd70210d08 100644
--- a/arch/arm64/boot/dts/renesas/r9a07g044.dtsi
+++ b/arch/arm64/boot/dts/renesas/r9a07g044.dtsi
@@ -627,6 +627,85 @@ sbc: spi@10060000 {
 			status = "disabled";
 		};
 
+		cru: video@10830000 {
+			compatible = "renesas,r9a07g044-cru", "renesas,rzg2l-cru";
+			reg = <0 0x10830000 0 0x400>;
+			clocks = <&cpg CPG_MOD SOC_PREFIX(CRU_VCLK)>,
+				 <&cpg CPG_MOD SOC_PREFIX(CRU_PCLK)>,
+				 <&cpg CPG_MOD SOC_PREFIX(CRU_ACLK)>;
+			clock-names = "video", "apb", "axi";
+			interrupts = <GIC_SPI 167 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 168 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 169 IRQ_TYPE_LEVEL_HIGH>;
+			interrupt-names = "image_conv", "image_conv_err", "axi_mst_err";
+			resets = <&cpg SOC_PREFIX(CRU_PRESETN)>,
+				 <&cpg SOC_PREFIX(CRU_ARESETN)>;
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
+			clocks = <&cpg CPG_MOD SOC_PREFIX(CRU_SYSCLK)>,
+				 <&cpg CPG_MOD SOC_PREFIX(CRU_VCLK)>,
+				 <&cpg CPG_MOD SOC_PREFIX(CRU_PCLK)>;
+			clock-names = "system", "video", "apb";
+			resets = <&cpg SOC_PREFIX(CRU_PRESETN)>,
+				 <&cpg SOC_PREFIX(CRU_CMN_RSTB)>;
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

