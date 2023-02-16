Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F1E70699BA6
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Feb 2023 18:54:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230119AbjBPRyN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Feb 2023 12:54:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36058 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230073AbjBPRyG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Feb 2023 12:54:06 -0500
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com [IPv6:2a00:1450:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B49F4FAAA;
        Thu, 16 Feb 2023 09:54:05 -0800 (PST)
Received: by mail-wm1-x32c.google.com with SMTP id o19-20020a05600c379300b003e21af96703so1121672wmr.2;
        Thu, 16 Feb 2023 09:54:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fa6e/J6Az3QweT1AcfTAdQTvvQGaFdfGTCPOYfh9lAs=;
        b=nP5Cj6OoPxzboBqC043G0EDoX/vicms/McihqYLr/ykhh1ezlX/LIi1OCe99bCp72f
         jMgp+2xrg+i3imAgDgEOpKEEfaHcP8zCAC/4gnQod7Iz0IuPMpwrU53FYtOzVcwksmpa
         Fp02UE3yz50femzY/eFXRDsSYaGScZXSqhPLejpgzgQahFx85YyhnBQDZ/bAL6U2Vevg
         YXFvgafGOGjCfiU8fMRHQzWgm9FyfdKr/rLPjlJm9GSYf5jK01XJ2gRoXcNjJLlFWfTa
         BsTPfP9H18ho+DEz2ZaOXBhBEpnACFkKnvNBRQLrw/i5R63gTzPIIFwS9zvZbenNASTi
         qTCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fa6e/J6Az3QweT1AcfTAdQTvvQGaFdfGTCPOYfh9lAs=;
        b=6ELW4z2hfRzvP00Bqs1e/P3/fQYCPsT1pT8klybj/oXco/5nY15FFA7ErTwIs1tqjZ
         5/LwI24mX/awFd5AphgyH0FcHAK0CO4HsR4XQ9d0y6nSLgDif87lNgYfM+4oQH/C3f5y
         EqfNGfjqIHh12W765kdC55Za9UKZxTJysYbReQkC2fDEDucISvxjGe6A7MPoiNcphr09
         Ek6S3waTBI2fCMdTo7XVKNPBxxs4Ujyw7cswLfJZFe2QGWI7inZjbSk9vBIgd22zn6uu
         Y89RkOCcKtjDexFnAf4J5Yabguv1tB6asH6KIc8PXYBiHLTkr2fTYEcSqT6pd70A6in+
         T3og==
X-Gm-Message-State: AO0yUKWGozyQvVQ1IFqzA0Ub0h4LO8Noq3eNfymaY2aRk95z9+16BVp5
        HZ8PSH3qjw4vDdPlc3dj92U=
X-Google-Smtp-Source: AK7set9OgspDNDFeQp7YEfFIWhJ6rfthg/5MfYK31MG2O9dqKxGyuzCJtk9GmLU0woeuB4KRlknNQg==
X-Received: by 2002:a05:600c:188a:b0:3e1:fc61:e0e5 with SMTP id x10-20020a05600c188a00b003e1fc61e0e5mr6103294wmp.33.1676570044447;
        Thu, 16 Feb 2023 09:54:04 -0800 (PST)
Received: from prasmi.home ([2a00:23c8:2501:c701:31b2:19e1:4409:5c3b])
        by smtp.gmail.com with ESMTPSA id o10-20020a1c750a000000b003dc4aae4739sm5826836wmc.27.2023.02.16.09.54.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Feb 2023 09:54:04 -0800 (PST)
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
Subject: [PATCH 3/3] arm64: dts: renesas: rzg2l-smarc: Enable CRU and CSI nodes
Date:   Thu, 16 Feb 2023 17:53:47 +0000
Message-Id: <20230216175347.99778-4-prabhakar.mahadev-lad.rj@bp.renesas.com>
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

Enable CRU and CSI nodes and tie the CSI remote endpoint with
OV5645 endpoint.

Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
---
 .../boot/dts/renesas/r9a07g044l2-smarc.dts    |  1 +
 .../boot/dts/renesas/rz-smarc-common.dtsi     | 23 +++++++++++++++++++
 2 files changed, 24 insertions(+)

diff --git a/arch/arm64/boot/dts/renesas/r9a07g044l2-smarc.dts b/arch/arm64/boot/dts/renesas/r9a07g044l2-smarc.dts
index 275e760324f3..25da4c93e0a4 100644
--- a/arch/arm64/boot/dts/renesas/r9a07g044l2-smarc.dts
+++ b/arch/arm64/boot/dts/renesas/r9a07g044l2-smarc.dts
@@ -9,6 +9,7 @@
 
 /* comment the #define statement if OV5645 is not connected to CN1  */
 #define CAM_INTERFACE_OV5645	1
+#define CRU_INTERFACE_AVAILABLE	1
 
 #include "r9a07g044l2.dtsi"
 #include "rzg2l-smarc-som.dtsi"
diff --git a/arch/arm64/boot/dts/renesas/rz-smarc-common.dtsi b/arch/arm64/boot/dts/renesas/rz-smarc-common.dtsi
index 915ad7e3935d..0f9a96ef5f6a 100644
--- a/arch/arm64/boot/dts/renesas/rz-smarc-common.dtsi
+++ b/arch/arm64/boot/dts/renesas/rz-smarc-common.dtsi
@@ -132,6 +132,28 @@ channel1 {
 	};
 };
 
+#ifdef CRU_INTERFACE_AVAILABLE
+&cru {
+	status = "okay";
+};
+
+&csi2 {
+	status = "okay";
+
+	ports {
+		port@0 {
+			csi2_in: endpoint {
+				clock-lanes = <0>;
+				data-lanes = <1 2>;
+#ifdef CAM_INTERFACE_OV5645
+				remote-endpoint = <&ov5645_ep>;
+#endif
+			};
+		};
+	};
+};
+#endif
+
 &ehci0 {
 	dr_mode = "otg";
 	status = "okay";
@@ -168,6 +190,7 @@ port {
 			ov5645_ep: endpoint {
 				clock-lanes = <0>;
 				data-lanes = <1 2>;
+				remote-endpoint = <&csi2_in>;
 			};
 		};
 	};
-- 
2.25.1

