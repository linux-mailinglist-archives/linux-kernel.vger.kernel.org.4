Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 43A9C67CBF8
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Jan 2023 14:23:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236583AbjAZNXZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Jan 2023 08:23:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60242 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234330AbjAZNXU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Jan 2023 08:23:20 -0500
Received: from egress-ip4b.ess.de.barracuda.com (egress-ip4b.ess.de.barracuda.com [18.185.115.208])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F8E518A89
        for <linux-kernel@vger.kernel.org>; Thu, 26 Jan 2023 05:23:14 -0800 (PST)
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com [209.85.214.200]) by mx-outbound20-172.eu-central-1b.ess.aws.cudaops.com (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO); Thu, 26 Jan 2023 13:23:12 +0000
Received: by mail-pl1-f200.google.com with SMTP id z10-20020a170902ccca00b001898329db72so1080661ple.21
        for <linux-kernel@vger.kernel.org>; Thu, 26 Jan 2023 05:23:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mistralsolutions.com; s=google;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=G6Ajtn/dXFsb1dJwxtMc9cBb7rwqzMHAM/XeIm3RbXo=;
        b=dLKubE6MdgWycXaqJju4vKd0/kcSXs8DRbRASh4UPjDRiySsPddsy7NQZdipi/04Rc
         Fi/OrdSOMfIo3bHbMl4gct77HOhlChQcv0SF5OUSZAUttB0lk+pWu4TrxA43CeRCM/Pu
         xcr9ZmtwKObDu6JI7c/qIN9TL0FnN2HKwugbE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=G6Ajtn/dXFsb1dJwxtMc9cBb7rwqzMHAM/XeIm3RbXo=;
        b=PDrIJ3h9kZISFcIhLrAPmYTDQDyt9O/Y4zMDm+YRQwhcpUxZPpFlXfQpQBWZ//fz3V
         yUdaSbEQC39lxLnXDH7lMKiDDCFaGWpkr+I7J1TymjB1MeH7h6sA/yOLg1KGCU8jkzmH
         l5TcIQbzcyWYQct5/AdboGoqN5tls1oFz5xmwBQBaqpkZ3Gm93K8YWSARBC8G/pisXlu
         Fpx1HEEgVXuYtQ+b0ZKOXkAqfAIO3hhp8jesvh+cMPZxCuXpJIhi5/g+cRCxjK2WdeGL
         aOPmgbaR9dGwyCRIXlzzSLVDs0vIg453x6VeEURrJzdySTwW8tTOyfgk6hXAMNJgm+oT
         /SqQ==
X-Gm-Message-State: AO0yUKX/+9px7ntVOOdJNABwTeKWGMtJxSLN0l4UVe2kZbXKV9wPthhq
        uPx7okwLf8v4TUhexTs10L0jh4IwVwO2M5k352TKc8U4U17X6xEu9qJvMBBt5N4xSz6WKgKq/Ru
        ZgKqtTJ4tPhz7RTZQKyyVPjZMgIvzX7LWdgCAVi4NQ2yR8M3nD10MbJbMB0ca
X-Received: by 2002:a17:902:dccc:b0:192:8cd1:5e79 with SMTP id t12-20020a170902dccc00b001928cd15e79mr1237642pll.41.1674739391263;
        Thu, 26 Jan 2023 05:23:11 -0800 (PST)
X-Google-Smtp-Source: AK7set8IQgw7vRA4qsEaaEHQGI+f2pPf6yzXhzjvUm7ljh/Pd1JT6RB0lPlOU7j1jmjyQkcXIIGqMg==
X-Received: by 2002:a17:902:dccc:b0:192:8cd1:5e79 with SMTP id t12-20020a170902dccc00b001928cd15e79mr1237621pll.41.1674739390872;
        Thu, 26 Jan 2023 05:23:10 -0800 (PST)
Received: from localhost.localdomain ([49.207.202.116])
        by smtp.gmail.com with ESMTPSA id ix12-20020a170902f80c00b00178143a728esm946206plb.275.2023.01.26.05.23.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Jan 2023 05:23:10 -0800 (PST)
From:   Sinthu Raja <sinthu.raja@mistralsolutions.com>
X-Google-Original-From: Sinthu Raja <sinthu.raja@ti.com>
To:     Nishanth Menon <nm@ti.com>, Tero Kristo <kristo@kernel.org>,
        Rob Herring <robh+dt@kernel.org>
Cc:     Vignesh Raghavendra <vigneshr@ti.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Sinthu Raja <sinthu.raja@ti.com>
Subject: [PATCH] arm64: dts: ti: k3-j721s2-main: Add dts nodes for EHRPWMs
Date:   Thu, 26 Jan 2023 18:52:43 +0530
Message-Id: <20230126132243.15695-1-sinthu.raja@ti.com>
X-Mailer: git-send-email 2.36.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-BESS-ID: 1674739391-305292-5511-661-1
X-BESS-VER: 2019.1_20221214.2106
X-BESS-Apparent-Source-IP: 209.85.214.200
X-BESS-Outbound-Spam-Score: 0.00
X-BESS-Outbound-Spam-Report: Code version 3.2, rules version 3.2.2.245721 [from 
        cloudscan16-118.eu-central-1b.ess.aws.cudaops.com]
        Rule breakdown below
         pts rule name              description
        ---- ---------------------- --------------------------------
        0.00 BSF_BESS_OUTBOUND      META: BESS Outbound 
        0.00 BSF_SC0_MISMATCH_TO    META: Envelope rcpt doesn't match header 
X-BESS-Outbound-Spam-Status: SCORE=0.00 using account:ESS91090 scores of KILL_LEVEL=7.0 tests=BSF_BESS_OUTBOUND, BSF_SC0_MISMATCH_TO
X-BESS-BRTS-Status: 1
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Sinthu Raja <sinthu.raja@ti.com>

Add dts nodes for 6 EHRPWM instances on SoC. Disable EHRPWM nodes in the
dtsi files and only enable the ones that are actually pinned out on a
given board.

Signed-off-by: Sinthu Raja <sinthu.raja@ti.com>
---
 arch/arm64/boot/dts/ti/k3-j721s2-main.dtsi | 74 ++++++++++++++++++++++
 1 file changed, 74 insertions(+)

diff --git a/arch/arm64/boot/dts/ti/k3-j721s2-main.dtsi b/arch/arm64/boot/dts/ti/k3-j721s2-main.dtsi
index 8915132efcc1..68f4fe85085b 100644
--- a/arch/arm64/boot/dts/ti/k3-j721s2-main.dtsi
+++ b/arch/arm64/boot/dts/ti/k3-j721s2-main.dtsi
@@ -26,6 +26,80 @@ l3cache-sram@200000 {
 		};
 	};
 
+	scm_conf: scm-conf@104000 {
+		compatible = "ti,j721e-system-controller", "syscon", "simple-mfd";
+		reg = <0x00 0x00104000 0x00 0x18000>;
+		#address-cells = <1>;
+		#size-cells = <1>;
+		ranges = <0x00 0x00 0x00104000 0x18000>;
+
+		ehrpwm_tbclk: clock-controller@140 {
+			compatible = "ti,am654-ehrpwm-tbclk", "syscon";
+			reg = <0x140 0x18>;
+			#clock-cells = <1>;
+		};
+	};
+
+	main_ehrpwm0: pwm@3000000 {
+		compatible = "ti,am654-ehrpwm", "ti,am3352-ehrpwm";
+		#pwm-cells = <3>;
+		reg = <0x00 0x3000000 0x00 0x100>;
+		power-domains = <&k3_pds 160 TI_SCI_PD_EXCLUSIVE>;
+		clocks = <&ehrpwm_tbclk 0>, <&k3_clks 160 0>;
+		clock-names = "tbclk", "fck";
+		status = "disabled";
+	};
+
+	main_ehrpwm1: pwm@3010000 {
+		compatible = "ti,am654-ehrpwm", "ti,am3352-ehrpwm";
+		#pwm-cells = <3>;
+		reg = <0x00 0x3010000 0x00 0x100>;
+		power-domains = <&k3_pds 161 TI_SCI_PD_EXCLUSIVE>;
+		clocks = <&ehrpwm_tbclk 1>, <&k3_clks 161 0>;
+		clock-names = "tbclk", "fck";
+		status = "disabled";
+	};
+
+	main_ehrpwm2: pwm@3020000 {
+		compatible = "ti,am654-ehrpwm", "ti,am3352-ehrpwm";
+		#pwm-cells = <3>;
+		reg = <0x00 0x3020000 0x00 0x100>;
+		power-domains = <&k3_pds 162 TI_SCI_PD_EXCLUSIVE>;
+		clocks = <&ehrpwm_tbclk 2>, <&k3_clks 162 0>;
+		clock-names = "tbclk", "fck";
+		status = "disabled";
+	};
+
+	main_ehrpwm3: pwm@3030000 {
+		compatible = "ti,am654-ehrpwm", "ti,am3352-ehrpwm";
+		#pwm-cells = <3>;
+		reg = <0x00 0x3030000 0x00 0x100>;
+		power-domains = <&k3_pds 163 TI_SCI_PD_EXCLUSIVE>;
+		clocks = <&ehrpwm_tbclk 3>, <&k3_clks 163 0>;
+		clock-names = "tbclk", "fck";
+		status = "disabled";
+	};
+
+	main_ehrpwm4: pwm@3040000 {
+		compatible = "ti,am654-ehrpwm", "ti,am3352-ehrpwm";
+		#pwm-cells = <3>;
+		reg = <0x00 0x3040000 0x00 0x100>;
+		power-domains = <&k3_pds 164 TI_SCI_PD_EXCLUSIVE>;
+		clocks = <&ehrpwm_tbclk 4>, <&k3_clks 164 0>;
+		clock-names = "tbclk", "fck";
+		status = "disabled";
+	};
+
+	main_ehrpwm5: pwm@3050000 {
+		compatible = "ti,am654-ehrpwm", "ti,am3352-ehrpwm";
+		#pwm-cells = <3>;
+		reg = <0x00 0x3050000 0x00 0x100>;
+		power-domains = <&k3_pds 165 TI_SCI_PD_EXCLUSIVE>;
+		clocks = <&ehrpwm_tbclk 5>, <&k3_clks 165 0>;
+		clock-names = "tbclk", "fck";
+		status = "disabled";
+	};
+
 	gic500: interrupt-controller@1800000 {
 		compatible = "arm,gic-v3";
 		#address-cells = <2>;
-- 
2.36.1

