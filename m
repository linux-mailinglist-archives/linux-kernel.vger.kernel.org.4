Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A4A6465EFDA
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Jan 2023 16:20:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234758AbjAEPUH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Jan 2023 10:20:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41332 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234757AbjAEPTJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Jan 2023 10:19:09 -0500
Received: from egress-ip33a.ess.de.barracuda.com (egress-ip33a.ess.de.barracuda.com [18.185.115.192])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F5D25E660
        for <linux-kernel@vger.kernel.org>; Thu,  5 Jan 2023 07:18:45 -0800 (PST)
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com [209.85.214.200]) by mx-outbound9-213.eu-central-1a.ess.aws.cudaops.com (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO); Thu, 05 Jan 2023 15:18:25 +0000
Received: by mail-pl1-f200.google.com with SMTP id s14-20020a17090302ce00b00192d831a155so6043966plk.11
        for <linux-kernel@vger.kernel.org>; Thu, 05 Jan 2023 07:18:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mistralsolutions.com; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kixjQUN0j0X26LpmZMpaE+vUfWEYeiY+St6K75WwNOQ=;
        b=B15QOnBD4RMX9dh+37ri7oFoMWAN8eOaacWkGF9mwYH+8Xd1h9M8ZDNaeCZSGxxNtW
         D6fPhZWDeQAywbYvnGYCyateMEzsZH2dVtRf7T/Hrz1l7fHtlcBUdn4V953Ca2Mn7pSV
         UOr0F4aI6I9spZtXEZL/TrmnH6Gi3kNvkbKic=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kixjQUN0j0X26LpmZMpaE+vUfWEYeiY+St6K75WwNOQ=;
        b=dAqNCX9rYr+bSUOOTXc5d5Td9DuxXXe7Zu3mg8V4Li/+oH/fqK8npepoiAp6YpgdkO
         5/0tJzVgFQFb8KSEXBoQrMFutuLmx8DRqjkzJ7FKQSGhdI1NBCNqS0k+mhME78cSv6K8
         rqOiXbpinapxV52z1BqY7bwBEgKvI/Qzr7gWrPSbHKEr2Ap7JXAlkBJESjIZAdDhtOLH
         27RrWlx/ZRaRvtAxr3RtclB5p5KBqTb9f7LIyuw/GniCoXTbFcMADJcgiEiyK28uvzvc
         POw/xFlDBN0ALWFDbkDaQMb3ksZ0Ljnxd+5f/eWW/Gemru/KMN+HBHLXGfS7f6LTU6qh
         Lv2Q==
X-Gm-Message-State: AFqh2krM7GKsxiKdXj6yAJqFwaazEdrwPZphGQznas3dzks6KUglWyMV
        1pBbsEJgJGY79/KWWfd/R8SqnbAS1Z8DN5FCRDxrMKrbXWtGP06O+oEEYAkoFR15u9bHYarUB69
        T5b4FL1cBgCwuFn99Cse709cnrbQI9iz/jZ7xgm3mgEje5+TJBadn76YahGh4
X-Received: by 2002:aa7:8d41:0:b0:582:b7a7:de13 with SMTP id s1-20020aa78d41000000b00582b7a7de13mr9789437pfe.10.1672931904618;
        Thu, 05 Jan 2023 07:18:24 -0800 (PST)
X-Google-Smtp-Source: AMrXdXvvOmrzBa4SPTWLVDzOT4lvesc3US2Dmaw9fje4wNRzyOiqb9auZazcdk/0tyNgtheyu6arPQ==
X-Received: by 2002:aa7:8d41:0:b0:582:b7a7:de13 with SMTP id s1-20020aa78d41000000b00582b7a7de13mr9789420pfe.10.1672931904329;
        Thu, 05 Jan 2023 07:18:24 -0800 (PST)
Received: from LAP568U.mistral.in ([106.51.227.150])
        by smtp.gmail.com with ESMTPSA id i6-20020aa796e6000000b0056bc30e618dsm12473040pfq.38.2023.01.05.07.18.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Jan 2023 07:18:23 -0800 (PST)
From:   Sinthu Raja <sinthu.raja@mistralsolutions.com>
X-Google-Original-From: Sinthu Raja <sinthu.raja@ti.com>
To:     Nishanth Menon <nm@ti.com>, Tero Kristo <kristo@kernel.org>,
        Rob Herring <robh+dt@kernel.org>
Cc:     Vignesh Raghavendra <vigneshr@ti.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Sinthu Raja <sinthu.raja@ti.com>
Subject: [PATCH V4 2/3] arm64: dts: ti: Add initial support for AM68 SK System on Module
Date:   Thu,  5 Jan 2023 20:47:39 +0530
Message-Id: <20230105151740.29436-3-sinthu.raja@ti.com>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20230105151740.29436-1-sinthu.raja@ti.com>
References: <20230105151740.29436-1-sinthu.raja@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-BESS-ID: 1672931905-302517-5394-21758-1
X-BESS-VER: 2019.1_20221214.2106
X-BESS-Apparent-Source-IP: 209.85.214.200
X-BESS-Outbound-Spam-Score: 0.00
X-BESS-Outbound-Spam-Report: Code version 3.2, rules version 3.2.2.245267 [from 
        cloudscan14-206.eu-central-1a.ess.aws.cudaops.com]
        Rule breakdown below
         pts rule name              description
        ---- ---------------------- --------------------------------
        0.00 BSF_BESS_OUTBOUND      META: BESS Outbound 
        0.00 BSF_SC0_MISMATCH_TO    META: Envelope rcpt doesn't match header 
X-BESS-Outbound-Spam-Status: SCORE=0.00 using account:ESS91090 scores of KILL_LEVEL=7.0 tests=BSF_BESS_OUTBOUND, BSF_SC0_MISMATCH_TO
X-BESS-BRTS-Status: 1
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Sinthu Raja <sinthu.raja@ti.com>

AM68 Starter Kit (SK) is a low cost, small form factor board designed
for TI’s AM68 SoC. TI’s AM68 SoC comprises of dual core A72, high
performance vision accelerators, hardware accelerators, latest C71x
DSP, high bandwidth real-time IPs for capture and display. The SoC is
power optimized to provide best in class performance for industrial
applications.

    AM68 SK supports the following interfaces:
      * 16 GB LPDDR4 RAM
      * x1 Gigabit Ethernet interface
      * x1 USB 3.1 Type-C port
      * x2 USB 3.1 Type-A ports
      * x1 PCIe M.2 M Key
      * 512 Mbit OSPI flash
      * x2 CSI2 Camera interface (RPi and TI Camera connector)
      * 40-pin Raspberry Pi GPIO header

SK's System on Module (SoM) contains the SoC and DDR.
Therefore, add DT node for the SOC and DDR on the SoM.

Schematics: https://www.ti.com/lit/zip/SPRR463
TRM: http://www.ti.com/lit/pdf/spruj28

Signed-off-by: Sinthu Raja <sinthu.raja@ti.com>
---
 arch/arm64/boot/dts/ti/k3-am68-sk-som.dtsi | 31 ++++++++++++++++++++++
 1 file changed, 31 insertions(+)
 create mode 100644 arch/arm64/boot/dts/ti/k3-am68-sk-som.dtsi

diff --git a/arch/arm64/boot/dts/ti/k3-am68-sk-som.dtsi b/arch/arm64/boot/dts/ti/k3-am68-sk-som.dtsi
new file mode 100644
index 000000000000..c35f81edee8c
--- /dev/null
+++ b/arch/arm64/boot/dts/ti/k3-am68-sk-som.dtsi
@@ -0,0 +1,31 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (C) 2023 Texas Instruments Incorporated - https://www.ti.com/
+ */
+
+/dts-v1/;
+
+#include "k3-j721s2.dtsi"
+#include <dt-bindings/gpio/gpio.h>
+
+/ {
+	memory@80000000 {
+		device_type = "memory";
+		/* 16 GB RAM */
+		reg = <0x00 0x80000000 0x00 0x80000000>,
+		      <0x08 0x80000000 0x03 0x80000000>;
+	};
+
+	/* Reserving memory regions still pending */
+	reserved_memory: reserved-memory {
+		#address-cells = <2>;
+		#size-cells = <2>;
+		ranges;
+
+		secure_ddr: optee@9e800000 {
+			reg = <0x00 0x9e800000 0x00 0x01800000>;
+			alignment = <0x1000>;
+			no-map;
+		};
+	};
+};
-- 
2.36.1

