Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DDE11640631
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Dec 2022 12:53:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232801AbiLBLxR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Dec 2022 06:53:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41102 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233383AbiLBLwu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Dec 2022 06:52:50 -0500
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com [IPv6:2a00:1450:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3BB0E5FB84;
        Fri,  2 Dec 2022 03:52:46 -0800 (PST)
Received: by mail-ej1-x633.google.com with SMTP id n21so10976393ejb.9;
        Fri, 02 Dec 2022 03:52:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=57nQPIWboUhS0hM6UAXc+mV0l81PKd9lsPdM8FKXFZQ=;
        b=dVxzLkdhqEgqAKSv+70d22Uvs8M8T9J4rDG/8s4Oza0wQ0nriev5N8Qr5s1LjcPQTl
         EWIVfMQ76Lr0iDoC8moEya14poTgrFjQjojMmoa/vkCLJ+o64o/H1yxYxWJ1fR1oy/Nc
         1lKARHnRHQEoi9E91Vj7G+nYaoQpCs51nSo7jB2JP/+BXi1u0EJRJ18/9UYKemR2WpT3
         7ty8QKrRSwU6e+Cec5v0dwtfxuyAgOVNG9VV3m6F8nEV6kZwTDUlz2nF4P1J6sAoTJMp
         V9w3NX7V+lgSRlVgBaoE/z0QxvKVdYuv2dcc8oQWAh3OxenMr3iQMAC1XGvm+p4XBUtF
         uopQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=57nQPIWboUhS0hM6UAXc+mV0l81PKd9lsPdM8FKXFZQ=;
        b=7eU9rN7TE2miExefFiA6oDOndPNq+Jq4Yj3S+6fnK+XhbBiJRIk1fkJ/TCAhfprOeb
         nJXYr4TrOya3RvyrqP4tCtLVRGqRhVWZ3k0zIcRgyhetX05sXe301kWzMUDEzk8lg6up
         yXyeNuV5k7hhTX13ofqznO+7VPIvTY0AltUpd/kSA1GcZBFcHuj7WA69i7wHAfqQ2bCP
         5NiCTPZTG1TtIR1n/5tdcSOPRN5+hgPQnCBFPoyzGIjB6EJn3eptqRVGe6OJJr3ts16Y
         Sps6lEsJT9st/rF1/fOEyYD0BUrVlLgaNkD/7HW5CP2USRaTp9qzrvM0IKSNMpdF3QLd
         GoeA==
X-Gm-Message-State: ANoB5plliQgh8KH/77Vup8+ZEzyfFnRjXqBNIBuC7ajCBsi0sTdAIIXw
        LLvTsoRvfD+t0aZhC2pqxDs=
X-Google-Smtp-Source: AA0mqf5dmSPQFvDVM2KnCeukh0RGM++NkoeSCFP2ggwb6ZRYdBekyNSRZ5XIe69a0MWQn+J1fofwOg==
X-Received: by 2002:a17:906:a0d9:b0:78d:b912:6a6c with SMTP id bh25-20020a170906a0d900b0078db9126a6cmr60973122ejb.124.1669981966379;
        Fri, 02 Dec 2022 03:52:46 -0800 (PST)
Received: from cizrna.home (cst-prg-44-69.cust.vodafone.cz. [46.135.44.69])
        by smtp.gmail.com with ESMTPSA id ha7-20020a170906a88700b007c0bb571da5sm1206762ejb.41.2022.12.02.03.52.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Dec 2022 03:52:45 -0800 (PST)
Sender: Tomeu Vizoso <tomeu.vizoso@gmail.com>
From:   Tomeu Vizoso <tomeu.vizoso@collabora.com>
Cc:     italonicola@collabora.com,
        Tomeu Vizoso <tomeu.vizoso@collabora.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Kevin Hilman <khilman@baylibre.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        devicetree@vger.kernel.org (open list:OPEN FIRMWARE AND FLATTENED
        DEVICE TREE BINDINGS),
        linux-arm-kernel@lists.infradead.org (moderated list:ARM/Amlogic Meson
        SoC support),
        linux-amlogic@lists.infradead.org (open list:ARM/Amlogic Meson SoC
        support), linux-kernel@vger.kernel.org (open list)
Subject: [PATCH v6 8/8] arm64: dts: Fix NPU power domain references in Amlogic G12-based SoCs
Date:   Fri,  2 Dec 2022 12:52:20 +0100
Message-Id: <20221202115223.39051-9-tomeu.vizoso@collabora.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20221202115223.39051-1-tomeu.vizoso@collabora.com>
References: <20221202115223.39051-1-tomeu.vizoso@collabora.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The power sequence is different between SoCs in that family, so get the
right bits for each one.

Signed-off-by: Tomeu Vizoso <tomeu.vizoso@collabora.com>
---
 arch/arm64/boot/dts/amlogic/meson-g12-common.dtsi | 2 --
 arch/arm64/boot/dts/amlogic/meson-g12b.dtsi       | 4 ++++
 arch/arm64/boot/dts/amlogic/meson-sm1.dtsi        | 4 ++++
 3 files changed, 8 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/boot/dts/amlogic/meson-g12-common.dtsi b/arch/arm64/boot/dts/amlogic/meson-g12-common.dtsi
index 61c8461df614..d7eb01509685 100644
--- a/arch/arm64/boot/dts/amlogic/meson-g12-common.dtsi
+++ b/arch/arm64/boot/dts/amlogic/meson-g12-common.dtsi
@@ -11,7 +11,6 @@
 #include <dt-bindings/interrupt-controller/arm-gic.h>
 #include <dt-bindings/reset/amlogic,meson-g12a-reset.h>
 #include <dt-bindings/thermal/thermal.h>
-#include <dt-bindings/power/meson-g12a-power.h>
 
 / {
 	interrupt-parent = <&gic>;
@@ -2493,6 +2492,5 @@ npu: npu@ff100000 {
 			 <&clkc CLKID_NNA_AXI_CLK>;
 		clock-names = "core", "bus";
 		resets = <&reset RESET_NNA>;
-		power-domains = <&pwrc PWRC_G12A_NNA_ID>;
 	};
 };
diff --git a/arch/arm64/boot/dts/amlogic/meson-g12b.dtsi b/arch/arm64/boot/dts/amlogic/meson-g12b.dtsi
index ee8fcae9f9f0..886380b5a96f 100644
--- a/arch/arm64/boot/dts/amlogic/meson-g12b.dtsi
+++ b/arch/arm64/boot/dts/amlogic/meson-g12b.dtsi
@@ -139,3 +139,7 @@ map1 {
 &mali {
 	dma-coherent;
 };
+
+&npu {
+	power-domains = <&pwrc PWRC_G12A_NNA_ID>;
+};
diff --git a/arch/arm64/boot/dts/amlogic/meson-sm1.dtsi b/arch/arm64/boot/dts/amlogic/meson-sm1.dtsi
index 80737731af3f..318a16aa4433 100644
--- a/arch/arm64/boot/dts/amlogic/meson-sm1.dtsi
+++ b/arch/arm64/boot/dts/amlogic/meson-sm1.dtsi
@@ -543,3 +543,7 @@ &vpu {
 &usb {
 	power-domains = <&pwrc PWRC_SM1_USB_ID>;
 };
+
+&npu {
+	power-domains = <&pwrc PWRC_SM1_NNA_ID>;
+};
-- 
2.38.1

