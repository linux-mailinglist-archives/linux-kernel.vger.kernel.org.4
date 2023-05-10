Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0AF8F6FE55A
	for <lists+linux-kernel@lfdr.de>; Wed, 10 May 2023 22:45:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236671AbjEJUpV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 May 2023 16:45:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36198 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236650AbjEJUpR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 May 2023 16:45:17 -0400
Received: from APC01-PSA-obe.outbound.protection.outlook.com (mail-psaapc01on2122.outbound.protection.outlook.com [40.107.255.122])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 39093198E;
        Wed, 10 May 2023 13:45:16 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fc/2JBxBEOdii6kBF2NpbstL4hCf/611r9fSo/wYzZahS2uTlU2d6Llb+l6LPdxXh8FQWz7e+10WkB7j4WhoieJ/XAaYPCufGmczQbxNfiFlI6Ve3ZIvKkR/1TLkr+l27JXhgqIiI5JzxiY55JdpeLWhWplwT4fxVRkO+c7mE8tS1dW+fbslMUsNp7YoOkrcHXWmB5rrWfCsECBZgpaGj7AV2ZGgr9Tr3qXgf0kLpsHgjtm42fVum2guAnCkIjjO4H+ydiUa+jA2vD1ReEgXl/U6vc8cf+F17NfxI9uWWzXWsS070a1zNSAB6whIZTZgJl/8cXGHjhXsonKK8PxMlw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wDfkaBo6LjMIW33WCTKeSvbdpXYFdxQLPDeCzZFB8fU=;
 b=JXP2VtgOCh/KRxMdt3Z/YR+OH5U4rIve7bGqEutkPUz1Ok230QsJIk51A/9oUiJWd+0gL4bHgiMw3yKRNINoRouRHE3m9obe1DD9tuZ/7Sb4Ne4Nol1+gz7M9WlJkuxikSksA7SWffhRfMhSFGnFXiuKlgFjpRIkjN4fRH4sKAH4gqvxL/ELePbxCQ5OQT6ZZdFFgBPbYBRjYEZlOYM1TnE1ObMO60QROaBwTqoFCPVyk87sDlMaVRWxHz8IPLt32U2EC60Is1I0t3DVFwLpEI/oNkKVP3i3pnq4UjKclZfGwOhNI79EmmvSQk0P4fRPHhBEbz00bHvwpvNuwnwL2A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wDfkaBo6LjMIW33WCTKeSvbdpXYFdxQLPDeCzZFB8fU=;
 b=aSZiIWSDJnYvgmJ6TzxoRN4A5mhQBGWamXlVL+Vcdwd5wLTvmKFj9qvi1SKCFNR50jRfJGjDrnD5s2g+xxV1xxQ2PndoQdITLFfQgMlkmtXKTPfkLW+yHuKWN3M3l41XHgVpHAMag4HESocEsRHsvwY4xXUVKRjnoJ6+ZGVL5rNcG+mqZ0LMJzu85qp9GbnSEZceDz6b7Po5VegR/jM0VaYLH/atfmxQF/hICr71X08w83apWuNvtHAwE566QzIFUD4lPH3O097l8PfxG+sGMdTeb50z/n3ddNX2mVj5/HUfa25q+TZuINU3/1hfIgvrhahhCdPJYp6cuitNQPHvmA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com (2603:1096:101:78::6)
 by TYZPR06MB6468.apcprd06.prod.outlook.com (2603:1096:400:459::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6363.33; Wed, 10 May
 2023 20:45:14 +0000
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::76d6:4828:7e80:2965]) by SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::76d6:4828:7e80:2965%3]) with mapi id 15.20.6363.033; Wed, 10 May 2023
 20:45:14 +0000
From:   Yangtao Li <frank.li@vivo.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Jisheng Zhang <jszhang@kernel.org>, Wei Fu <wefu@redhat.com>,
        Yangtao Li <frank.li@vivo.com>
Cc:     Icenowy Zheng <uwu@icenowy.me>, devicetree@vger.kernel.org,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 3/5] riscv: dts: thead: add sipeed Lichee Pi 4A board device tree
Date:   Thu, 11 May 2023 04:44:54 +0800
Message-Id: <20230510204456.57202-3-frank.li@vivo.com>
X-Mailer: git-send-email 2.39.0
In-Reply-To: <20230510204456.57202-1-frank.li@vivo.com>
References: <20230510204456.57202-1-frank.li@vivo.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI1PR02CA0055.apcprd02.prod.outlook.com
 (2603:1096:4:1f5::16) To SEZPR06MB5269.apcprd06.prod.outlook.com
 (2603:1096:101:78::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SEZPR06MB5269:EE_|TYZPR06MB6468:EE_
X-MS-Office365-Filtering-Correlation-Id: b727f876-a141-4e82-a79c-08db519774e1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: qbYLZ/Hfzx5SoMfxC+rdK8j6dnqjZuT+4eB+45jc0mgu50Wq591e98me7SOCoq6XZxlasO4XI6/wjmD9S9Zw5z8dWkGyumy+b5nnuqMu1i+/QrRqYa7Swjnt5tLQBwikRvF1TrwHj6SGyAtNvJY0QqmFTAdU4NyPzjIDipp/dwU8wzx3i14Hr+vM0yzP7OZQ2WQwK7gkl5mGdJpIlttLPwJ3qxFc0jDGVToLp+/NH9K+zGWnzKmREyncMyRsre8KM1Yd/w3LijxbowirJfF4tRDcBFYTHw/czIs0V7W5wFWYTaJvAQYSwn/PTwuKaBQsGAqVuo0b9Xc6FED86f4BwnIy5gwW+VpwR/xPiu92Xe92WOXfPJaDtv+5UdatOPk62UKuVt7ZTSZVWcNhdRNhiWMoh7Pz6KtNkH+GFQqIaR8dgiz+eL8E5BtDDkJJonYybpVAP+foW4MsJksxQWD0yQLcPmrbbK81tLGxt697Il/mDWP2ihUlWY7eCuKFted4k7MKqON6KHcWrN/tufdIkHPnXwMypzmVrULyR/Iy4N5svGuzME/0u9fgwATVifHPOTY4wHPi0JTfEWrzLjhsBVHRdoW3301deSLMYlDU/CEi5Dg0L2c/dTCskqURUd+N
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEZPR06MB5269.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(376002)(39860400002)(396003)(366004)(346002)(136003)(451199021)(7049001)(6486002)(6666004)(316002)(83380400001)(66556008)(66946007)(478600001)(52116002)(4326008)(26005)(66476007)(6506007)(6512007)(110136005)(1076003)(186003)(2906002)(38350700002)(41300700001)(36756003)(86362001)(8936002)(8676002)(7416002)(5660300002)(38100700002)(2616005);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?bRM0sJ5Xp71vVayi3kO2fR2WJ5eMfnIwKbvlKd9stC7GVrInn88oE6DdCEjP?=
 =?us-ascii?Q?O84Xwl+sH+N6B8eK4Y9xcElGUhrv7dSld3O99f7cg8w70//LI0M+sB1HoNea?=
 =?us-ascii?Q?CGZQ24xlGPH0p9X0LWgAAsvM+Y0yJn7YepS1IF9pHnxbgW62M/xY7FD4bKxU?=
 =?us-ascii?Q?qmNvrWBbxVIJOH/2UQe+E6Ns/bmSLQlIOGQ9jNm1QF9/PUyBMQHT21XybkSM?=
 =?us-ascii?Q?S/6gVi6osdaMEoLpH3EKUmOIBGtDeZZLdp6ra4SbxoFfDiW6caBLVxfJx/On?=
 =?us-ascii?Q?um+6aneNPvCzZlDi+XfRI8Bjvow5MPxzdogcV4VY0t8sq9PxAJIG4PXl+4xj?=
 =?us-ascii?Q?PY6AGLHShxCnjsLNrbybISJ0+/mv+NMKIpJjM7glEuL6PKqRRGmH3lVAggP2?=
 =?us-ascii?Q?B3K9tba6YFmJ3GmdXgZfttRWJ95MEA2y4bQ+cgi/IMUIC1xLSWPbZ7gYqiHt?=
 =?us-ascii?Q?voue4AdnFrAwvlpmhwZAyCQjjqsM/lMu1AEh/55w8BI4RBOjxMvXb1X1oNgy?=
 =?us-ascii?Q?Gzg6c32Fgf4BwtUWtFYchcbrscmpI0KHgJZimvToyZHkZOr3KdcQBR2oC9Lz?=
 =?us-ascii?Q?ocCwKbpvRphMSxHJ+uprph7i4V2PDmmqYeNiHQ/NJ2up0igltlFgY5wd1ENW?=
 =?us-ascii?Q?HMYKKzRCpxgZ8dNi8NNPUfsJO1sEj3zeKJCksxZ2F9xZRyDBkCmlUhm+dYBL?=
 =?us-ascii?Q?l8N03tbEg4+bWduCR3eptdwMhnc42bmLk+hkHXinu28DokevKcUAzU8JVo5r?=
 =?us-ascii?Q?QmqNz2gTVsFGm3rTJX/uzz3ouWjYlOaz4u9DZfPSdURZqZnHcFz4eEj9LWGU?=
 =?us-ascii?Q?f0SWsy4ECHUN3sIPey8DfKqsYuuG43liRq1xpVwyx/wIBYlrC5sCzOy3bBuz?=
 =?us-ascii?Q?8976Iv4BAeX+HUHeLgKkE0cxFzZx87Ypcf2WYQJRQGWKQGGsl+KU5We30trW?=
 =?us-ascii?Q?NQC0fHBpanUXZhsoJeFfLqIV0vNwRLMJqJNmMTMrFcAJTXhsZ8/dbLtqcRsB?=
 =?us-ascii?Q?0fSXj/nr8jG58O6kwwLmIWANDK13PbZ7ADrcMPzO0sAfYJFdHc3Du2kAaLWA?=
 =?us-ascii?Q?QJ5HsFgW5dZ8zjOO8DvQ7synFmLxEY/qsqT+GwESBvKZlxs8s8hOTN5VgVFF?=
 =?us-ascii?Q?W0VzMu1KgplQmCQbQBnXoz0YCDvLMR4xHk9FkVe3kL8Yw/ALvS2l16ss6Kr2?=
 =?us-ascii?Q?ACAoiN5kT47B8f1hgAxXgneWAdaTljj4KtgO/ZL2oZUk1Kc06iwOSJUpJZ41?=
 =?us-ascii?Q?m+rPLb0QiCpXzt8p4nN985To/4QoGkYIMJLotOcjQU5YSXKizpDv78vEt3ar?=
 =?us-ascii?Q?C4ZSnckeRf/B1MKJcgTBKWw/h7/RFVRym3BuUeZEu3RqWC7tupLrwQ/igTum?=
 =?us-ascii?Q?NyBQGjD3p8DALEdV0FRNhikftbVxUCnLlxB5NR4ZP2irLkFQ/0UW9tCWvEqx?=
 =?us-ascii?Q?Lb4hcUJ5oZa5DnLn52k49BZmEdE+7DOG9B/twy2iMnfhm4ku0OJQw3I48cc6?=
 =?us-ascii?Q?+NiFaa+JyH1TSIfyEYqAq+ajHrHPjKnbC5+vOjgc0ne1UKWYcFbLY/G+AWMt?=
 =?us-ascii?Q?uWW4PrmAyXuTBxhpVmUS5V7iDL3AJD3P9tN6wBeU?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b727f876-a141-4e82-a79c-08db519774e1
X-MS-Exchange-CrossTenant-AuthSource: SEZPR06MB5269.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 May 2023 20:45:14.6807
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qK0W0rH9B1tAQCquY8fkyiKPM0txB43NvVfZi+i30kygiSR7L98dDRoKhmBb/v3Oza6nz2FVD9Ba+OvHpgd0+A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYZPR06MB6468
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jisheng Zhang <jszhang@kernel.org>

Sipeed's Lichee Pi 4A development board uses Lichee Module 4A core
module which is powered by T-HEAD's light(a.k.a TH1520) SoC. Add
minimal device tree files for the core module and the development
board.

Support basic uart/gpio/dmac drivers, so supports booting to a basic
shell.

Cc: Icenowy Zheng <uwu@icenowy.me>
Cc: Wei Fu <wefu@redhat.com>
Signed-off-by: Jisheng Zhang <jszhang@kernel.org>
Signed-off-by: Yangtao Li <frank.li@vivo.com>
---
v2:
-cleanup `light`
 arch/riscv/boot/dts/Makefile                  |  1 +
 arch/riscv/boot/dts/thead/Makefile            |  2 +
 .../dts/thead/th1520-lichee-module-4a.dtsi    | 39 +++++++++++++++++++
 .../boot/dts/thead/th1520-lichee-pi-4a.dts    | 33 ++++++++++++++++
 4 files changed, 75 insertions(+)
 create mode 100644 arch/riscv/boot/dts/thead/Makefile
 create mode 100644 arch/riscv/boot/dts/thead/th1520-lichee-module-4a.dtsi
 create mode 100644 arch/riscv/boot/dts/thead/th1520-lichee-pi-4a.dts

diff --git a/arch/riscv/boot/dts/Makefile b/arch/riscv/boot/dts/Makefile
index f0d9f89054f8..1e884868ccba 100644
--- a/arch/riscv/boot/dts/Makefile
+++ b/arch/riscv/boot/dts/Makefile
@@ -2,6 +2,7 @@
 subdir-y += allwinner
 subdir-y += sifive
 subdir-y += starfive
+subdir-y += thead
 subdir-y += canaan
 subdir-y += microchip
 subdir-y += renesas
diff --git a/arch/riscv/boot/dts/thead/Makefile b/arch/riscv/boot/dts/thead/Makefile
new file mode 100644
index 000000000000..e311fc9a5939
--- /dev/null
+++ b/arch/riscv/boot/dts/thead/Makefile
@@ -0,0 +1,2 @@
+# SPDX-License-Identifier: GPL-2.0
+dtb-$(CONFIG_ARCH_THEAD) += th1520-lichee-pi-4a.dtb
diff --git a/arch/riscv/boot/dts/thead/th1520-lichee-module-4a.dtsi b/arch/riscv/boot/dts/thead/th1520-lichee-module-4a.dtsi
new file mode 100644
index 000000000000..bc5f8677d546
--- /dev/null
+++ b/arch/riscv/boot/dts/thead/th1520-lichee-module-4a.dtsi
@@ -0,0 +1,39 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (C) 2023 Jisheng Zhang <jszhang@kernel.org>
+ * Copyright (C) 2023 Yangtao Li <frank.li@vivo.com>
+ */
+
+/dts-v1/;
+
+#include "th1520.dtsi"
+
+/ {
+	model = "Sipeed Lichee Module 4A";
+	compatible = "sipeed,lichee-module-4a", "thead,th1520";
+
+	memory@0 {
+		device_type = "memory";
+		reg = <0x0 0x00000000 0x2 0x00000000>;
+	};
+};
+
+&osc {
+	clock-frequency = <24000000>;
+};
+
+&osc_32k {
+	clock-frequency = <32768>;
+};
+
+&apb_clk {
+	clock-frequency = <62500000>;
+};
+
+&uart_sclk {
+	clock-frequency = <100000000>;
+};
+
+&dmac0 {
+	status = "okay";
+};
diff --git a/arch/riscv/boot/dts/thead/th1520-lichee-pi-4a.dts b/arch/riscv/boot/dts/thead/th1520-lichee-pi-4a.dts
new file mode 100644
index 000000000000..86d677175feb
--- /dev/null
+++ b/arch/riscv/boot/dts/thead/th1520-lichee-pi-4a.dts
@@ -0,0 +1,33 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (C) 2023 Jisheng Zhang <jszhang@kernel.org>
+ * Copyright (C) 2023 Yangtao Li <frank.li@vivo.com>
+ */
+
+#include "th1520-lichee-module-4a.dtsi"
+
+/ {
+	model = "Sipeed Lichee Pi 4A";
+	compatible = "sipeed,lichee-pi-4a", "sipeed,lichee-module-4a", "thead,th1520";
+
+	aliases {
+		gpio0 = &gpio0;
+		gpio1 = &gpio1;
+		gpio2 = &gpio2;
+		gpio3 = &gpio3;
+		serial0 = &uart0;
+		serial1 = &uart1;
+		serial2 = &uart2;
+		serial3 = &uart3;
+		serial4 = &uart4;
+		serial5 = &uart5;
+	};
+
+	chosen {
+		stdout-path = "serial0:115200n8";
+	};
+};
+
+&uart0 {
+	status = "okay";
+};
-- 
2.34.1

