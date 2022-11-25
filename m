Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 09F9F63888F
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Nov 2022 12:20:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230437AbiKYLT5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Nov 2022 06:19:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46150 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230074AbiKYLTt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Nov 2022 06:19:49 -0500
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 389D228E04;
        Fri, 25 Nov 2022 03:19:47 -0800 (PST)
Received: by mail-wr1-x42f.google.com with SMTP id x5so6291787wrt.7;
        Fri, 25 Nov 2022 03:19:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7PfQ2W7+jfq13mv60YI0ZFUsMp5wOyJ2UsW2Qs+puQY=;
        b=SbOHS903mNOpnILtR4C6Hka3wbt9VO8ZuT7xkiYlMrLPpfzFTRq/BYRgVS/iJ8W9cy
         DvWv19s6RhNIRBpVLu8cwh1cDiYGNe6tGXBnRrlNI978OeboQKWWz2bF0fgIZt1W5Stf
         mE02QjarGeHFH8aLwY/H9J4EzBPZDBgFlSfewGntNzf7EHZodWIE8G+gv6jT6CRvICW5
         qzZUtGHrDaMGlqXsNb0o4uS51N5omZkkcQA+ERrSSFeNPd2W1cOSNoXaYJvbwHAbeiv2
         yBZ0wZIF86RreFLmbDlM8pU8lL8haqJo1C40g3y4eNxwvHzRn5NTyHXDJSGPG+OP82x0
         BQQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=7PfQ2W7+jfq13mv60YI0ZFUsMp5wOyJ2UsW2Qs+puQY=;
        b=rV3uJ4mfyh5Op9/voduhEfOehbLXGPg2iFVVBX9o6lr3otchxcvahBxVBbXpCIZpbb
         uYU/VVnheVavG6DDEaVhufwjVKSA2s+hdI7tPhN1NUxzFeKYr51wfmYJArboFSPMgicw
         xLDL5913ZV/wqHHj/oExYLJQ9I8JHHnxDiIx5UK7Ri1PaZ4J7GmfU9NXQbXJgMoAnmLU
         tjia9+M1//VxV2SE+ukPnTgaoZ3wXMQ8qnRfFvnTo5ASncMV5QXSzMnHPbGr45AuMg40
         WuHmtEfF85+9wMDf6UAntnJc4vWLNSwPdjMRQwhH9nx9XAFIQvb/7DK6bgxHLQTAUOVn
         Vwrw==
X-Gm-Message-State: ANoB5plwdKfsgZx3fXzEgd9qfkNf+ASYpDY4hRuFeytc1KgUWobDtv1b
        hwFFpwE9WHk7FXpVLaEPCxQ=
X-Google-Smtp-Source: AA0mqf5PgDcWrGG/qlTS1d5khO1RXvIht00dzCgwzfFVqj3/zuybOqlxIFU+3NcsYBK3ngzF7dm6Ng==
X-Received: by 2002:adf:e8c9:0:b0:22e:33dc:3bf1 with SMTP id k9-20020adfe8c9000000b0022e33dc3bf1mr23477456wrn.316.1669375185693;
        Fri, 25 Nov 2022 03:19:45 -0800 (PST)
Received: from cizrna.home (cst-prg-44-69.cust.vodafone.cz. [46.135.44.69])
        by smtp.gmail.com with ESMTPSA id v11-20020a5d4b0b000000b002368f6b56desm4207406wrq.18.2022.11.25.03.19.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Nov 2022 03:19:45 -0800 (PST)
Sender: Tomeu Vizoso <tomeu.vizoso@gmail.com>
From:   Tomeu Vizoso <tomeu.vizoso@collabora.com>
Cc:     Tomeu Vizoso <tomeu.vizoso@collabora.com>,
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
Subject: [PATCH 5/6] arm64: dts: Add DT node for the VIPNano-QI on the A311D
Date:   Fri, 25 Nov 2022 12:19:18 +0100
Message-Id: <20221125111921.37261-6-tomeu.vizoso@collabora.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20221125111921.37261-1-tomeu.vizoso@collabora.com>
References: <20221125111921.37261-1-tomeu.vizoso@collabora.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This "NPU" is very similar to the Vivante GPUs and Etnaviv works well
with it with just a few small changes.

Signed-off-by: Tomeu Vizoso <tomeu.vizoso@collabora.com>
---
 arch/arm64/boot/dts/amlogic/meson-g12-common.dtsi      | 10 ++++++++++
 .../boot/dts/amlogic/meson-g12b-a311d-khadas-vim3.dts  |  4 ++++
 2 files changed, 14 insertions(+)

diff --git a/arch/arm64/boot/dts/amlogic/meson-g12-common.dtsi b/arch/arm64/boot/dts/amlogic/meson-g12-common.dtsi
index fa96fddf4633..13c79676a356 100644
--- a/arch/arm64/boot/dts/amlogic/meson-g12-common.dtsi
+++ b/arch/arm64/boot/dts/amlogic/meson-g12-common.dtsi
@@ -11,6 +11,7 @@
 #include <dt-bindings/interrupt-controller/arm-gic.h>
 #include <dt-bindings/reset/amlogic,meson-g12a-reset.h>
 #include <dt-bindings/thermal/thermal.h>
+#include <dt-bindings/power/meson-g12a-power.h>
 
 / {
 	interrupt-parent = <&gic>;
@@ -2485,4 +2486,13 @@ xtal: xtal-clk {
 		#clock-cells = <0>;
 	};
 
+	npu: npu@ff100000 {
+		compatible = "vivante,gc";
+		reg = <0x0 0xff100000 0x0 0x20000>;
+		interrupts = <0 147 4>;
+		clocks = <&clkc CLKID_NNA_CORE_CLK>,
+			<&clkc CLKID_NNA_AXI_CLK>;
+		clock-names = "core", "bus";
+		power-domains = <&pwrc PWRC_G12A_NNA_ID>;
+	};
 };
diff --git a/arch/arm64/boot/dts/amlogic/meson-g12b-a311d-khadas-vim3.dts b/arch/arm64/boot/dts/amlogic/meson-g12b-a311d-khadas-vim3.dts
index 124a80901084..73f3d87dcefd 100644
--- a/arch/arm64/boot/dts/amlogic/meson-g12b-a311d-khadas-vim3.dts
+++ b/arch/arm64/boot/dts/amlogic/meson-g12b-a311d-khadas-vim3.dts
@@ -15,6 +15,10 @@ / {
 	compatible = "khadas,vim3", "amlogic,a311d", "amlogic,g12b";
 };
 
+&npu {
+	status = "okay";
+};
+
 /*
  * The VIM3 on-board  MCU can mux the PCIe/USB3.0 shared differential
  * lines using a FUSB340TMX USB 3.1 SuperSpeed Data Switch between
-- 
2.38.1

