Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 860396226FD
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Nov 2022 10:30:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230081AbiKIJaf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Nov 2022 04:30:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35502 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230258AbiKIJac (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Nov 2022 04:30:32 -0500
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 492682127C
        for <linux-kernel@vger.kernel.org>; Wed,  9 Nov 2022 01:30:31 -0800 (PST)
Received: by mail-wr1-x430.google.com with SMTP id a14so24834771wru.5
        for <linux-kernel@vger.kernel.org>; Wed, 09 Nov 2022 01:30:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pLWz/etKkdRYFJ1Qa8OubzwENK5OGCzv8f4RtofetLs=;
        b=EvIkXa/E3Gylc3MWmsmJcm5pjIg8IJYxwcmfcZjBmnXelQELNkmWdN2Ck0CT6P93Gz
         8b6+xzBMCCYP47iuKA9LvppbaQPR1by7OUxQFBIQmR0hUbWXzAyxcLa+YhgZsqd9FMy6
         HccaujjukGZzQKWp01gW+Iio+FzPZg8ed/IySzFMsit7Mdo0uzj9UJ2fGgGyFXCLhY67
         D046hd0HQ8sVZAPjr4m1QixjjFZVg43ZKR4pnT78MR9FhNDD7CEIINKR+2JkagV8f2iL
         ISu9wUpfhfuTqKw2GZZFkCNH3zp/30N44bIr/QY4JNh57PR6ups2nGpm0OIgkS7QR2Ub
         Tbiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pLWz/etKkdRYFJ1Qa8OubzwENK5OGCzv8f4RtofetLs=;
        b=glrHVUqjq0yMWgf2cCgjdjNwmYNDcg4R8IauTE8T/x0WADjA1nXLfM0tX90ce7D3eh
         FX/NyHXnVGQa0/eJ4tA02gfIx7JGwKrNOWT5lZIWxkzaEOM4agyCO7rbsTRhuP2kGxER
         5fkS5WIhlJeHwmXP+bowgscp7Znqmu39Cg3OJy9cZ/WqCbFLgSD5+dThvTlG1wL2jQIN
         tA0OfCCwtQQHCW7qnvd0NUrgXCTUB62Hjoh8PG5/ci4e2jBU+N6Ebw6Brg3TJZKeezIS
         gkKlJTaIHLXUOdwTQUceucfTmb80zycqk+JFbgNO3CqBd8XWZk4ZEOf/mzVlKKSpLu0v
         Ojtg==
X-Gm-Message-State: ACrzQf0HKpJOKhjWDQUD4TF8YuY9vqz9jH4Ye0EWABX5UAoh5lNTDLNw
        RrES4sT0lbrSq+s39720+QToFA==
X-Google-Smtp-Source: AMsMyM7JlX0xONPC+nB5MASK0ugjcmZFyvp7x8KuX5+aop6TQfMNPV70vvCP3crg/nSTj56oAtWvkQ==
X-Received: by 2002:adf:c5c4:0:b0:236:87bc:a8fa with SMTP id v4-20020adfc5c4000000b0023687bca8famr36777687wrg.151.1667986229834;
        Wed, 09 Nov 2022 01:30:29 -0800 (PST)
Received: from baylibre-ThinkPad-T14s-Gen-2i.. (254.31.102.84.rev.sfr.net. [84.102.31.254])
        by smtp.gmail.com with ESMTPSA id g12-20020adffc8c000000b0022cd96b3ba6sm14547919wrr.90.2022.11.09.01.30.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Nov 2022 01:30:29 -0800 (PST)
From:   Julien Panis <jpanis@baylibre.com>
To:     nm@ti.com, vigneshr@ti.com, afd@ti.com, kristo@kernel.org,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        linux-arm-kernel@lists.infradead.org
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v3 1/2] arm64: dts: ti: k3-am62: add watchdog nodes
Date:   Wed,  9 Nov 2022 10:30:25 +0100
Message-Id: <20221109093026.103790-2-jpanis@baylibre.com>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <20221109093026.103790-1-jpanis@baylibre.com>
References: <20221109093026.103790-1-jpanis@baylibre.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add nodes for watchdogs :
- 5 in main domain
- 1 in MCU domain
- 1 in wakeup domain

Signed-off-by: Julien Panis <jpanis@baylibre.com>
---
 arch/arm64/boot/dts/ti/k3-am62-main.dtsi   | 45 ++++++++++++++++++++++
 arch/arm64/boot/dts/ti/k3-am62-mcu.dtsi    |  9 +++++
 arch/arm64/boot/dts/ti/k3-am62-wakeup.dtsi | 11 ++++++
 3 files changed, 65 insertions(+)

diff --git a/arch/arm64/boot/dts/ti/k3-am62-main.dtsi b/arch/arm64/boot/dts/ti/k3-am62-main.dtsi
index 03660476364f..fb8480d7cf76 100644
--- a/arch/arm64/boot/dts/ti/k3-am62-main.dtsi
+++ b/arch/arm64/boot/dts/ti/k3-am62-main.dtsi
@@ -591,6 +591,51 @@ main_mcan0: can@20701000 {
 		bosch,mram-cfg = <0x0 128 64 64 64 64 32 32>;
 	};
 
+	main_rti0: watchdog@e000000 {
+		compatible = "ti,j7-rti-wdt";
+		reg = <0x00 0x0e000000 0x00 0x100>;
+		clocks = <&k3_clks 125 0>;
+		power-domains = <&k3_pds 125 TI_SCI_PD_EXCLUSIVE>;
+		assigned-clocks = <&k3_clks 125 0>;
+		assigned-clock-parents = <&k3_clks 125 2>;
+	};
+
+	main_rti1: watchdog@e010000 {
+		compatible = "ti,j7-rti-wdt";
+		reg = <0x00 0x0e010000 0x00 0x100>;
+		clocks = <&k3_clks 126 0>;
+		power-domains = <&k3_pds 126 TI_SCI_PD_EXCLUSIVE>;
+		assigned-clocks = <&k3_clks 126 0>;
+		assigned-clock-parents = <&k3_clks 126 2>;
+	};
+
+	main_rti2: watchdog@e020000 {
+		compatible = "ti,j7-rti-wdt";
+		reg = <0x00 0x0e020000 0x00 0x100>;
+		clocks = <&k3_clks 127 0>;
+		power-domains = <&k3_pds 127 TI_SCI_PD_EXCLUSIVE>;
+		assigned-clocks = <&k3_clks 127 0>;
+		assigned-clock-parents = <&k3_clks 127 2>;
+	};
+
+	main_rti3: watchdog@e030000 {
+		compatible = "ti,j7-rti-wdt";
+		reg = <0x00 0x0e030000 0x00 0x100>;
+		clocks = <&k3_clks 128 0>;
+		power-domains = <&k3_pds 128 TI_SCI_PD_EXCLUSIVE>;
+		assigned-clocks = <&k3_clks 128 0>;
+		assigned-clock-parents = <&k3_clks 128 2>;
+	};
+
+	main_rti15: watchdog@e0f0000 {
+		compatible = "ti,j7-rti-wdt";
+		reg = <0x00 0x0e0f0000 0x00 0x100>;
+		clocks = <&k3_clks 130 0>;
+		power-domains = <&k3_pds 130 TI_SCI_PD_EXCLUSIVE>;
+		assigned-clocks = <&k3_clks 130 0>;
+		assigned-clock-parents = <&k3_clks 130 2>;
+	};
+
 	epwm0: pwm@23000000 {
 		compatible = "ti,am64-epwm", "ti,am3352-ehrpwm";
 		#pwm-cells = <3>;
diff --git a/arch/arm64/boot/dts/ti/k3-am62-mcu.dtsi b/arch/arm64/boot/dts/ti/k3-am62-mcu.dtsi
index f56c803560f2..f82e94def774 100644
--- a/arch/arm64/boot/dts/ti/k3-am62-mcu.dtsi
+++ b/arch/arm64/boot/dts/ti/k3-am62-mcu.dtsi
@@ -81,4 +81,13 @@ mcu_gpio0: gpio@4201000 {
 		clocks = <&k3_clks 79 0>;
 		clock-names = "gpio";
 	};
+
+	mcu_rti0: watchdog@4880000 {
+		compatible = "ti,j7-rti-wdt";
+		reg = <0x00 0x04880000 0x00 0x100>;
+		clocks = <&k3_clks 131 0>;
+		power-domains = <&k3_pds 131 TI_SCI_PD_EXCLUSIVE>;
+		assigned-clocks = <&k3_clks 131 0>;
+		assigned-clock-parents = <&k3_clks 131 2>;
+	};
 };
diff --git a/arch/arm64/boot/dts/ti/k3-am62-wakeup.dtsi b/arch/arm64/boot/dts/ti/k3-am62-wakeup.dtsi
index 4090134676cf..7d5bc9dfe51d 100644
--- a/arch/arm64/boot/dts/ti/k3-am62-wakeup.dtsi
+++ b/arch/arm64/boot/dts/ti/k3-am62-wakeup.dtsi
@@ -38,4 +38,15 @@ wkup_i2c0: i2c@2b200000 {
 		clocks = <&k3_clks 107 4>;
 		clock-names = "fck";
 	};
+
+	wkup_rti0: watchdog@2b000000 {
+		compatible = "ti,j7-rti-wdt";
+		reg = <0x00 0x2b000000 0x00 0x100>;
+		clocks = <&k3_clks 132 0>;
+		power-domains = <&k3_pds 132 TI_SCI_PD_EXCLUSIVE>;
+		assigned-clocks = <&k3_clks 132 0>;
+		assigned-clock-parents = <&k3_clks 132 2>;
+		/* WKUP RTI0 is used by DM firmware */
+		status = "reserved";
+	};
 };
-- 
2.37.3

