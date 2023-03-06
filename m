Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3CB3F6ACE56
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Mar 2023 20:43:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230135AbjCFTmz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Mar 2023 14:42:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42580 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229958AbjCFTmq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Mar 2023 14:42:46 -0500
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com [IPv6:2a00:1450:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 804E9410AB;
        Mon,  6 Mar 2023 11:42:45 -0800 (PST)
Received: by mail-ed1-x535.google.com with SMTP id s11so43336237edy.8;
        Mon, 06 Mar 2023 11:42:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20210112; t=1678131764;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9VMz7FwRCPzl0u0g9FryvFIO2eSi8c5ik8HpdOZSYw4=;
        b=VUW2S/qEm2qEaDo2jeLcOTzcZgk8r82W2NCK67wkcLUUGmJQ5PgcieZ/L9CPCX8oT0
         hYu85ZRSxqEX/iL/zqW3LLlqlQOb9FNfUqOEF83qSeGsRKPdYxINQRY3OagViEJdSASS
         y7U7vCSZauPO+yTH9qvQDgn7vO4zPDZ2pvxXCJXobR04ZLlKhGlU3ilqBOEEHbR2AQKS
         Jl0HjTxvTY4TzOIsuln5Lyk/nZFWuYct+Z3eklJS3kNT7s/37dmPfpecc+AOY0hfTx+q
         fPxWnp3nwfcApw8joRla3lW+xQpD5OEwHJN2K5NffDrtNoCdb7x40+my/gViEef/DlU2
         FWMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678131764;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9VMz7FwRCPzl0u0g9FryvFIO2eSi8c5ik8HpdOZSYw4=;
        b=cwmjaMW3D9y+tYd81Um702ytU+IhxPLb6CYI5lBSd0PrhQnFGWQMAUFusX81KCJcAL
         Zug7dsJNzAR0nPuiiO2nPInBaQBNncy1u48DRIQSPApplnHaMd4YUqxDZaE3oH0jCDoA
         3E6DSMsLVjlZ6RGnCuPmCsvgBGm+rMHK3uZ9UBhwcVwhfnXBcTDzdRejd4iYnboct8Bz
         xk+ddUE9p6B29RP0OCqCbWTaeQ7gEBdM6Fn1PjlAcnn1XKEremNZBJbMCJCuee2vZRoB
         chi4syTxLtcMPDLcC/SMpo6vi3ZEgQblJJwHsjMgVpfARAfTCsz2V6//f5MDN58EnMIf
         vJuw==
X-Gm-Message-State: AO0yUKWDSWTpYYsqbdmG6LFyc/NKdQO4ZlUHUkVe8q7794hZ4V/YWZ4B
        121515dQP0hMRhrEQYbfnrk=
X-Google-Smtp-Source: AK7set9y6Oy8/mPj3AB2/VR4I/2YrjSZlx9rcTbnl7yOfgnNZbZXeS60WL5YLUgYGyYN79oO69pukQ==
X-Received: by 2002:a17:907:9721:b0:8b1:9e47:9101 with SMTP id jg33-20020a170907972100b008b19e479101mr13076253ejc.12.1678131763930;
        Mon, 06 Mar 2023 11:42:43 -0800 (PST)
Received: from localhost.localdomain (dynamic-2a01-0c23-c405-5c00-0000-0000-0000-0e63.c23.pool.telefonica.de. [2a01:c23:c405:5c00::e63])
        by smtp.googlemail.com with ESMTPSA id e19-20020a170906315300b008f2b0c6052csm4951868eje.89.2023.03.06.11.42.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Mar 2023 11:42:43 -0800 (PST)
From:   Martin Blumenstingl <martin.blumenstingl@googlemail.com>
To:     linux-amlogic@lists.infradead.org, devicetree@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        jirislaby@kernel.org, neil.armstrong@linaro.org,
        krzysztof.kozlowski+dt@linaro.org, robh+dt@kernel.org,
        gregkh@linuxfoundation.org,
        Christian Hewitt <christianshewitt@gmail.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Subject: [PATCH v2 3/3] arm64: dts: meson-g12-common: Use the G12A UART compatible string
Date:   Mon,  6 Mar 2023 20:42:23 +0100
Message-Id: <20230306194223.1869814-4-martin.blumenstingl@googlemail.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230306194223.1869814-1-martin.blumenstingl@googlemail.com>
References: <20230306194223.1869814-1-martin.blumenstingl@googlemail.com>
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

Switch meson-12-common.dtsi to use the Meson G12A specific UART
compatible string. This enables the "divide XTAL by 2" divider which
improves support for UART attached Bluetooth modules (for example
RTL8822CS) running at a baud rate of 1500000. Without dividing XTAL
(24MHz) by 2 a baud rate of 1500000 cannot be generated cleanly and the
resulting jitter breaks communication with the module.

Tested-by: Christian Hewitt <christianshewitt@gmail.com>
Signed-off-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
---
Greg, please don't take this through your tree. I included this patch
to show the overall goal of this series. If Neil won't take this as
part of another series then I'll send it separately.

Changes from v1 -> v2:
- keep meson-gx-uart as fallback compatible string


 arch/arm64/boot/dts/amlogic/meson-g12-common.dtsi | 15 ++++++++++-----
 1 file changed, 10 insertions(+), 5 deletions(-)

diff --git a/arch/arm64/boot/dts/amlogic/meson-g12-common.dtsi b/arch/arm64/boot/dts/amlogic/meson-g12-common.dtsi
index 123a56f7f818..904bcd4d2acf 100644
--- a/arch/arm64/boot/dts/amlogic/meson-g12-common.dtsi
+++ b/arch/arm64/boot/dts/amlogic/meson-g12-common.dtsi
@@ -2046,7 +2046,8 @@ pwm_AO_cd: pwm@2000 {
 			};
 
 			uart_AO: serial@3000 {
-				compatible = "amlogic,meson-gx-uart",
+				compatible = "amlogic,meson-g12a-uart",
+					     "amlogic,meson-gx-uart",
 					     "amlogic,meson-ao-uart";
 				reg = <0x0 0x3000 0x0 0x18>;
 				interrupts = <GIC_SPI 193 IRQ_TYPE_EDGE_RISING>;
@@ -2056,7 +2057,8 @@ uart_AO: serial@3000 {
 			};
 
 			uart_AO_B: serial@4000 {
-				compatible = "amlogic,meson-gx-uart",
+				compatible = "amlogic,meson-g12a-uart",
+					     "amlogic,meson-gx-uart",
 					     "amlogic,meson-ao-uart";
 				reg = <0x0 0x4000 0x0 0x18>;
 				interrupts = <GIC_SPI 197 IRQ_TYPE_EDGE_RISING>;
@@ -2293,7 +2295,8 @@ clk_msr: clock-measure@18000 {
 			};
 
 			uart_C: serial@22000 {
-				compatible = "amlogic,meson-gx-uart";
+				compatible = "amlogic,meson-g12a-uart",
+					     "amlogic,meson-gx-uart";
 				reg = <0x0 0x22000 0x0 0x18>;
 				interrupts = <GIC_SPI 93 IRQ_TYPE_EDGE_RISING>;
 				clocks = <&xtal>, <&clkc CLKID_UART2>, <&xtal>;
@@ -2302,7 +2305,8 @@ uart_C: serial@22000 {
 			};
 
 			uart_B: serial@23000 {
-				compatible = "amlogic,meson-gx-uart";
+				compatible = "amlogic,meson-g12a-uart",
+					     "amlogic,meson-gx-uart";
 				reg = <0x0 0x23000 0x0 0x18>;
 				interrupts = <GIC_SPI 75 IRQ_TYPE_EDGE_RISING>;
 				clocks = <&xtal>, <&clkc CLKID_UART1>, <&xtal>;
@@ -2311,7 +2315,8 @@ uart_B: serial@23000 {
 			};
 
 			uart_A: serial@24000 {
-				compatible = "amlogic,meson-gx-uart";
+				compatible = "amlogic,meson-g12a-uart",
+					     "amlogic,meson-gx-uart";
 				reg = <0x0 0x24000 0x0 0x18>;
 				interrupts = <GIC_SPI 26 IRQ_TYPE_EDGE_RISING>;
 				clocks = <&xtal>, <&clkc CLKID_UART0>, <&xtal>;
-- 
2.39.2

