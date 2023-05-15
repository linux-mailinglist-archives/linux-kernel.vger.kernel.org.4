Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C9E4770236E
	for <lists+linux-kernel@lfdr.de>; Mon, 15 May 2023 07:44:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238248AbjEOFog (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 May 2023 01:44:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53838 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238124AbjEOFoa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 May 2023 01:44:30 -0400
Received: from APC01-SG2-obe.outbound.protection.outlook.com (mail-sgaapc01on2105.outbound.protection.outlook.com [40.107.215.105])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C1FFC10E3;
        Sun, 14 May 2023 22:44:25 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=C4yG1NVAqPwyhUY49L9Arr+EjQpD/orEQBDZzadratD06prdbLEzBhMrpOPvSmQeCrgHplyUpCC1w2uS8Ore/5CJT1SYt1xUH05zihthYVcs1onB8q5EVt+diaCpn7HH0wO4ebidQRa1FwNYqee1VYGLjDNuoIw3ntiGUfpJgTVAYE1ee1ZrmY/I0km6uPICgh+zbtkzKU9KlGKpNbwkt/i2NEoeTJIBVfww74LtynBRQc6S/DWEVwYTvcfV08gZ4rDU1bc0FMbVJs+W2Ol44TeclTw8v1wAq43DhKd94mwr/M2PiiHG1kjsL9gLJ0Hxpmi96ce3rfiLlIrDV6rQ6A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZQFAbBWRWuxr72bJO5aoAJ3Or1VqTFvzqotaHbb1e6E=;
 b=euUCfxoWYAY/QAVBfRQLpwMV0FGC1PZDZhXJm/vku79lIQJ/9i0mX939fC4sYqGMajjsLFC8GgQT1JSGAoJaCido4QRPjC6FScrgIEm/Hyj3Q03TQUpjz2iLP1JCh/zvlM3nVSQ5VZsbQ6Bn6+eu58gwSAr5vRjojQUykbq+Vs/wanAj3Yvw7Zm6MN4mmcpT++gnRu2qf97A/ifPzYv2aJii9qhISiH7l+uom18drq9dkuH8O/u17iLnXyb3LyyeHRPSnUYFeazZEEesZqC6gB2zJM69z3JkBqf8DcR/EExCveJmcjhcAcryulvhEg89js2smqmJRRLY1xk+SusQlQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZQFAbBWRWuxr72bJO5aoAJ3Or1VqTFvzqotaHbb1e6E=;
 b=P+yj0YY7WB/LonSOggOk7uuYZFdLiUkGeoxYlS2q9Shv1Utu42R5OrVeXXEw0nasAUoeQg+TI7ENJTAupbxFEVZa57F8DAL2N3VklM2JFlc4OH1AYAHN7a3wJJAPL5NaGVNhzw8HapLcVk3MG6+YV2zI+UP5Y6oe7SCEv1kQ3cEOE3aIfmuPYOjbSuHWOs1L7KeuLxm3rS8cj4XLVqR+XiD4CKhB7TIBu9UzYlIc6bs6acQnvV0VmvLxpa6O9T096zmwR50GlO+ovvHIE3fDlhRlCdnRpNDPZ1HMWwY62GmsDU8bDBWFYHzMa3rSC4jCTp0/RyedYbngs1dItWCcSw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com (2603:1096:101:78::6)
 by SEZPR06MB6571.apcprd06.prod.outlook.com (2603:1096:101:185::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6387.30; Mon, 15 May
 2023 05:44:23 +0000
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::76d6:4828:7e80:2965]) by SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::76d6:4828:7e80:2965%3]) with mapi id 15.20.6387.030; Mon, 15 May 2023
 05:44:23 +0000
From:   Yangtao Li <frank.li@vivo.com>
To:     mturquette@baylibre.com, sboyd@kernel.org,
        Jisheng Zhang <jszhang@kernel.org>, Wei Fu <wefu@redhat.com>,
        Yangtao Li <frank.li@vivo.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>
Cc:     linux-clk@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org,
        Icenowy Zheng <uwu@icenowy.me>
Subject: [PATCH 2/3] clk: thead: add support for the T-HEAD TH1520 CCU
Date:   Mon, 15 May 2023 13:44:00 +0800
Message-Id: <20230515054402.27633-3-frank.li@vivo.com>
X-Mailer: git-send-email 2.39.0
In-Reply-To: <20230515054402.27633-1-frank.li@vivo.com>
References: <20230515054402.27633-1-frank.li@vivo.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR02CA0064.apcprd02.prod.outlook.com
 (2603:1096:4:54::28) To SEZPR06MB5269.apcprd06.prod.outlook.com
 (2603:1096:101:78::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SEZPR06MB5269:EE_|SEZPR06MB6571:EE_
X-MS-Office365-Filtering-Correlation-Id: a25d52a9-9af6-44bc-4c8a-08db55076fcf
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: zW0dcoLM+tfljggOltOIpbOiN/m3qB0uMSdWU2kEV4o+o9J30M6Y+k25jEheqFnvu2bz+Gj61hkfl6KFZWfJslCU1TCFx93Jjr3jETDXAuOOm7b4+9MiDPWZqF6HmkVfBIEOOVmQhG2N9ohFcKWdFxqi3iHDa4iGL+gytYTL5J30+fMHRZAD1mTj8pwe0G/SZYz3Rgs6C+b7c+XbRLgimH0lmx7W1KRzOnWRji3t1vj4aY0v2zj095V5cRJwLziAozVCxUr2bAhKPnMcoo0eAkOethCucCIEQCb5FTVxVQLJOHeiGRkXo5IHY1yKJ2vp5xiUWm3rfbhiQqZZMQ695qJAYlfgXgdZUrMHpNhd0tBYcP60CRWFCs0LrfPqn8+ox3G4bqOnmU/CmKWm14cHktsne5LAaKtqeopAX4iKBLHwX5gXZCK3YtZMuWkB0hv+GLCV8W3MAFepaoOYig4kVEF9eYiM8MLbLyYnely++i0oU6KF3vvC+ptxeG8LAwW7zEucpUBJgE+Mhe2+cwqU3TJAfQupQqTjtjkqz0XLoZraHzH/4OTvw0o0+jf//MN0RLEgDp/auQphLN8v4lZgHZmD/UlakXDkfIfwQg6dMUpaLHHpqfLwpwZTvFLDRYkS
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEZPR06MB5269.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(346002)(376002)(366004)(136003)(396003)(39860400002)(451199021)(52116002)(66556008)(66946007)(66476007)(4326008)(478600001)(6486002)(86362001)(316002)(110136005)(36756003)(83380400001)(6512007)(26005)(1076003)(186003)(2616005)(6506007)(41300700001)(8936002)(8676002)(5660300002)(7416002)(6666004)(30864003)(2906002)(38100700002)(38350700002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?rcOX5KJDxDlg8VLyRN8BnH76A3Cp1235vpa4Y4oAasOYR6pGArjKBQeZ4aGx?=
 =?us-ascii?Q?w+0hhhP2r4kcY/OFYerv42Qs7EhFhA9fVIIOwt7aXBvZZIyO5UuLnApopjoY?=
 =?us-ascii?Q?5n4H+QR+dYia0Lmk1RErKQ0ew56ClMt5LIoE8LPo66uCOPH1jNsEK1ETdIJW?=
 =?us-ascii?Q?g2nHqidbPmK+PzhH4mJiGAPOw9gHZICwBQ0B5Tc3qESaWW4MKgCq8SYeol5G?=
 =?us-ascii?Q?eFGbugOBjjqD9++bx/7YBXTD/wqdcTWTU62mYkZiY1hxoArxwOTafCJj0ko+?=
 =?us-ascii?Q?Es7q8XjFxef24xEdsBCxI4FGpfP0r3RrtJG8PuJX0EgmyYXk3R7pvhkxPF3F?=
 =?us-ascii?Q?w7GHNTx/V9bae9povBEnZ6IBbPc1USe86RbgUZ1Lc6Un7ItQSM47h6I+Uurj?=
 =?us-ascii?Q?yfyPNga0w3GbLFEDR7FFzBlbXdyWlvH2NU+tiHv5wnuU+93DkPFoJ64Nefql?=
 =?us-ascii?Q?nbDwMdzo0mmm31R2AFwB+Z+sMP+W+gqeuw1fCfJZjazZ2MOh8zybkWE846yz?=
 =?us-ascii?Q?z+IONf41TP2wBecGAbFeqJ+ChFGstzt42xOxE+cb3xEii9qb53Mgjh2Fa1j2?=
 =?us-ascii?Q?Z+auenHiL7UhdbhBNTdOVgcbLYslcfbuHAetjXELxBUzcH/CN2Z3yZ+LyFGj?=
 =?us-ascii?Q?b2uU0M7zb6OK6u4xFw46MS4pifKPOwqGKml9D3hHmTQ+sPGjlUM10dPQc20L?=
 =?us-ascii?Q?5tzne4p5Kxbg1LqVdwvF3RiZafgp1VCnP9Wk70mKZm1ywthUQX/Q6QnaWLXb?=
 =?us-ascii?Q?dntQytt2WHvyAokl0Zj9YmyiZNp8pRF4/7ji1mh5TherrZrG6N3/oelpyw7J?=
 =?us-ascii?Q?g1/eJR44b8ZW4lA51FO1KkBD4NL1qyrfcIShZR8g1C8z8KPF2cub80NP5VMv?=
 =?us-ascii?Q?Cvu7K5EwcJpId2FTLJd994cvFq7Av0s3wTXQwaIgcnHPy2PuNRFTyl5Cm4xo?=
 =?us-ascii?Q?ltgcyf9GedgplsoCkA+J+Oj7bS5y7BWPFyqS7acdos95HW80QYc+YLU+JgaA?=
 =?us-ascii?Q?bYk1oIG4wJ3vItYUYTQoxbudhbFTpG6di+8eVAkYjHFA+NJDZoOgeo6caN+z?=
 =?us-ascii?Q?AkqSHfVSxyb8rolwU5RtiC0x2RT8ioR7hwRdGXCqeWzHuL/jtLgHkSlUdQ8E?=
 =?us-ascii?Q?L0eKPXBcRy+YNNYLpEbmZAebwS6yXYaezwFhYHQRepy5V6dHM775ZNbsBveW?=
 =?us-ascii?Q?k15lNSyJpuKdcIWcyTKXGsD1qV11A1C4OLLb1e/AKk3yQDFYKMpMdc84OYsJ?=
 =?us-ascii?Q?I9wSG3a0t99TmU+4iejoPUDsCyv8pq9W/MZV+NUtPnVlo4ANAeu3YnCY1kTq?=
 =?us-ascii?Q?522aA0FhH2ncoAtpi7nmOmu2pskJcGaUSQq/S5wjg4fEW4eITaB16vKz+3Dt?=
 =?us-ascii?Q?dHw5SJ+Pp2z0NTZxrEeXLnIiXYU1HtBwN/sA2RgasZzY0y46FXlSjP6pJJ0/?=
 =?us-ascii?Q?C4BwW4ZHJveQf6XMlPscz3OVA4bMVhJo6iGGVhYTC9QbQ8SuhDnqMPi2TxzJ?=
 =?us-ascii?Q?5GdU4t4dzUFts+TgdUcL52rlWOjDypJ6veTghVlOt+Lv6fWBjAJ2WbclLWq8?=
 =?us-ascii?Q?BE3bex4lI1mdu30oSd8vhjKh4wGY99h/3EsB1hyb?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a25d52a9-9af6-44bc-4c8a-08db55076fcf
X-MS-Exchange-CrossTenant-AuthSource: SEZPR06MB5269.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 May 2023 05:44:23.4600
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: XUKBWPUFFgrdhcf+pCFdD1EXNqi9w3h5rXfjRaNOHZYLn85EKSdIm/B/F688IidhjER1X7iLzvmsbOrXZqEkgw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEZPR06MB6571
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add support for th1520 in the clock framework.

Cc: Icenowy Zheng <uwu@icenowy.me>
Cc: Wei Fu <wefu@redhat.com>
Cc: Jisheng Zhang <jszhang@kernel.org>
Signed-off-by: Yangtao Li <frank.li@vivo.com>
---
 drivers/clk/Kconfig                      |   6 +
 drivers/clk/Makefile                     |   1 +
 drivers/clk/clk-th1520.c                 | 999 +++++++++++++++++++++++
 include/dt-bindings/clock/th1520-clock.h |  92 +++
 4 files changed, 1098 insertions(+)
 create mode 100644 drivers/clk/clk-th1520.c
 create mode 100644 include/dt-bindings/clock/th1520-clock.h

diff --git a/drivers/clk/Kconfig b/drivers/clk/Kconfig
index 016814e15536..aa69a4d17916 100644
--- a/drivers/clk/Kconfig
+++ b/drivers/clk/Kconfig
@@ -464,6 +464,12 @@ config COMMON_CLK_SP7021
 	  Not all features of the PLL are currently supported
 	  by the driver.
 
+config COMMON_CLK_THEAD
+	tristate "Clock driver for TH1520 SoC"
+	depends on ARCH_THEAD || COMPILE_TEST
+	help
+	  Support for the T-HEAD TH1520 RISC-V SoC clocks.
+
 source "drivers/clk/actions/Kconfig"
 source "drivers/clk/analogbits/Kconfig"
 source "drivers/clk/baikal-t1/Kconfig"
diff --git a/drivers/clk/Makefile b/drivers/clk/Makefile
index 0aebef17edc6..95c89bfb129f 100644
--- a/drivers/clk/Makefile
+++ b/drivers/clk/Makefile
@@ -76,6 +76,7 @@ obj-$(CONFIG_CLK_TWL6040)		+= clk-twl6040.o
 obj-$(CONFIG_ARCH_VT8500)		+= clk-vt8500.o
 obj-$(CONFIG_COMMON_CLK_RS9_PCIE)	+= clk-renesas-pcie.o
 obj-$(CONFIG_COMMON_CLK_SI521XX)	+= clk-si521xx.o
+obj-$(CONFIG_COMMON_CLK_THEAD)		+= clk-th1520.o
 obj-$(CONFIG_COMMON_CLK_VC5)		+= clk-versaclock5.o
 obj-$(CONFIG_COMMON_CLK_VC7)		+= clk-versaclock7.o
 obj-$(CONFIG_COMMON_CLK_WM831X)		+= clk-wm831x.o
diff --git a/drivers/clk/clk-th1520.c b/drivers/clk/clk-th1520.c
new file mode 100644
index 000000000000..5dfa9e5207e2
--- /dev/null
+++ b/drivers/clk/clk-th1520.c
@@ -0,0 +1,999 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (C) 2023 Vivo Communication Technology Co. Ltd.
+ * Authors: Yangtao Li <frank.li@vivo.com>
+ */
+
+#include <dt-bindings/clock/th1520-clock.h>
+#include <linux/clk-provider.h>
+#include <linux/device.h>
+#include <linux/module.h>
+#include <linux/platform_device.h>
+#include <linux/regmap.h>
+
+struct ccu_internal {
+	u8	shift;
+	u8	width;
+};
+
+struct ccu_div_internal {
+	u8	shift;
+	u8	width;
+	u32	flags;
+};
+
+struct ccu_common {
+	struct regmap	*map;
+	u16		reg;
+	struct clk_hw	hw;
+};
+
+struct ccu_mux {
+	struct ccu_internal	mux;
+	struct ccu_common	common;
+};
+
+struct ccu_gate {
+	u32			enable;
+	struct ccu_common	common;
+};
+
+struct ccu_div {
+	u32			enable;
+	struct ccu_div_internal	div;
+	struct ccu_internal	mux;
+	struct ccu_common	common;
+};
+
+/*
+ * struct ccu_mdiv - Definition of an M-D-I-V clock
+ *
+ * Clocks based on the formula (parent * M) / (D * I * V)
+ */
+struct ccu_mdiv {
+	struct ccu_internal	m;
+	struct ccu_internal	d;
+	struct ccu_internal	i;
+	struct ccu_internal	v;
+	struct ccu_common	common;
+};
+
+#define TH_CCU_ARG(_shift, _width)					\
+	{								\
+		.shift	= _shift,					\
+		.width	= _width,					\
+	}
+
+#define TH_CCU_DIV_FLAGS(_shift, _width, _flags)			\
+	{								\
+		.shift	= _shift,					\
+		.width	= _width,					\
+		.flags	= _flags,					\
+	}
+
+#define CCU_GATE(_struct, _name, _parent, _reg, _gate, _flags)		\
+	struct ccu_gate _struct = {					\
+		.enable	= _gate,					\
+		.common	= {						\
+			.reg		= _reg,				\
+			.hw.init	= CLK_HW_INIT(_name,		\
+						      _parent,		\
+						      &ccu_gate_ops,	\
+						      _flags),		\
+		}							\
+	}
+
+static inline struct ccu_common *hw_to_ccu_common(struct clk_hw *hw)
+{
+	return container_of(hw, struct ccu_common, hw);
+}
+
+static inline struct ccu_mux *hw_to_ccu_mux(struct clk_hw *hw)
+{
+	struct ccu_common *common = hw_to_ccu_common(hw);
+
+	return container_of(common, struct ccu_mux, common);
+}
+
+static inline struct ccu_mdiv *hw_to_ccu_mdiv(struct clk_hw *hw)
+{
+	struct ccu_common *common = hw_to_ccu_common(hw);
+
+	return container_of(common, struct ccu_mdiv, common);
+}
+
+static inline struct ccu_div *hw_to_ccu_div(struct clk_hw *hw)
+{
+	struct ccu_common *common = hw_to_ccu_common(hw);
+
+	return container_of(common, struct ccu_div, common);
+}
+
+static inline struct ccu_gate *hw_to_ccu_gate(struct clk_hw *hw)
+{
+	struct ccu_common *common = hw_to_ccu_common(hw);
+
+	return container_of(common, struct ccu_gate, common);
+}
+
+static u8 ccu_get_parent_helper(struct ccu_common *common,
+				struct ccu_internal *mux)
+{
+	unsigned int val;
+	u8 parent;
+
+	regmap_read(common->map, common->reg, &val);
+	parent = val >> mux->shift;
+	parent &= GENMASK(mux->width - 1, 0);
+
+	return parent;
+}
+
+static int ccu_set_parent_helper(struct ccu_common *common,
+				struct ccu_internal *mux,
+				u8 index)
+{
+	return regmap_update_bits(common->map, common->reg,
+			GENMASK(mux->width - 1, 0) << mux->shift,
+			index << mux->shift);
+}
+
+static u8 ccu_mux_get_parent(struct clk_hw *hw)
+{
+	struct ccu_mux *cm = hw_to_ccu_mux(hw);
+
+	return ccu_get_parent_helper(&cm->common, &cm->mux);
+}
+
+static int ccu_mux_set_parent(struct clk_hw *hw, u8 index)
+{
+	struct ccu_mux *cm = hw_to_ccu_mux(hw);
+
+	return ccu_set_parent_helper(&cm->common, &cm->mux, index);
+}
+
+static const struct clk_ops ccu_mux_ops = {
+	.get_parent	= ccu_mux_get_parent,
+	.set_parent	= ccu_mux_set_parent,
+	.determine_rate	= __clk_mux_determine_rate,
+};
+
+void ccu_disable_helper(struct ccu_common *common, u32 gate)
+{
+	if (!gate)
+		return;
+
+	regmap_update_bits(common->map, common->reg,
+			   gate, ~gate);
+}
+
+int ccu_enable_helper(struct ccu_common *common, u32 gate)
+{
+	if (!gate)
+		return 0;
+
+	return regmap_update_bits(common->map, common->reg,
+				  gate, gate);
+}
+
+static int ccu_is_enabled_helper(struct ccu_common *common, u32 gate)
+{
+	unsigned int val;
+
+	if (!gate)
+		return true;
+
+	regmap_read(common->map, common->reg, &val);
+	return val & gate;
+}
+
+static int ccu_gate_is_enabled(struct clk_hw *hw)
+{
+	struct ccu_gate *cg = hw_to_ccu_gate(hw);
+
+	return ccu_is_enabled_helper(&cg->common, cg->enable);
+}
+
+static void ccu_gate_disable(struct clk_hw *hw)
+{
+	struct ccu_gate *cg = hw_to_ccu_gate(hw);
+
+	ccu_disable_helper(&cg->common, cg->enable);
+}
+
+static int ccu_gate_enable(struct clk_hw *hw)
+{
+	struct ccu_gate *cg = hw_to_ccu_gate(hw);
+
+	return ccu_enable_helper(&cg->common, cg->enable);
+}
+
+static const struct clk_ops ccu_gate_ops = {
+	.disable	= ccu_gate_disable,
+	.enable		= ccu_gate_enable,
+	.is_enabled	= ccu_gate_is_enabled,
+};
+
+static unsigned long ccu_div_recalc_rate(struct clk_hw *hw,
+					unsigned long parent_rate)
+{
+	struct ccu_div *cd = hw_to_ccu_div(hw);
+	unsigned int val;
+
+	regmap_read(cd->common.map, cd->common.reg, &val);
+	val = val >> cd->div.shift;
+	val &= GENMASK(cd->div.width - 1, 0);
+
+	val = divider_recalc_rate(hw, parent_rate, val, NULL,
+				  cd->div.flags, cd->div.width);
+
+	return val;
+}
+
+static u8 ccu_div_get_parent(struct clk_hw *hw)
+{
+	struct ccu_div *cd = hw_to_ccu_div(hw);
+
+	return ccu_get_parent_helper(&cd->common, &cd->mux);
+}
+
+static int ccu_div_set_parent(struct clk_hw *hw, u8 index)
+{
+	struct ccu_div *cd = hw_to_ccu_div(hw);
+
+	return ccu_set_parent_helper(&cd->common, &cd->mux, index);
+}
+
+static void ccu_div_disable(struct clk_hw *hw)
+{
+	struct ccu_div *cd = hw_to_ccu_div(hw);
+
+	ccu_disable_helper(&cd->common, cd->enable);
+}
+
+static int ccu_div_enable(struct clk_hw *hw)
+{
+	struct ccu_div *cd = hw_to_ccu_div(hw);
+
+	return ccu_enable_helper(&cd->common, cd->enable);
+}
+
+static int ccu_div_is_enabled(struct clk_hw *hw)
+{
+	struct ccu_div *cd = hw_to_ccu_div(hw);
+
+	return ccu_is_enabled_helper(&cd->common, cd->enable);
+}
+
+static const struct clk_ops ccu_div_ops = {
+	.disable	= ccu_div_disable,
+	.enable		= ccu_div_enable,
+	.is_enabled	= ccu_div_is_enabled,
+	.get_parent	= ccu_div_get_parent,
+	.set_parent	= ccu_div_set_parent,
+	.recalc_rate	= ccu_div_recalc_rate,
+};
+
+
+static unsigned long ccu_mdiv_recalc_rate(struct clk_hw *hw,
+					unsigned long parent_rate)
+{
+	struct ccu_mdiv *mdiv = hw_to_ccu_mdiv(hw);
+	unsigned long div, rate = parent_rate;
+	unsigned int m, d, i, v, val;
+
+	regmap_read(mdiv->common.map, mdiv->common.reg, &val);
+
+	m = val >> mdiv->m.shift;
+	m &= GENMASK(mdiv->m.width - 1, 0);
+
+	d = val >> mdiv->d.shift;
+	d &= GENMASK(mdiv->d.width - 1, 0);
+
+	i = val >> mdiv->i.shift;
+	i &= GENMASK(mdiv->i.width - 1, 0);
+
+	v = val >> mdiv->v.shift;
+	v &= GENMASK(mdiv->v.width - 1, 0);
+
+	rate = parent_rate * m;
+	div = d * i * v;
+	do_div(rate, div);
+
+	return rate;
+}
+
+static const struct clk_ops clk_mdiv_ops = {
+	.recalc_rate	= ccu_mdiv_recalc_rate,
+};
+
+static struct ccu_mdiv pll_cpu0_clk = {
+	.m		= TH_CCU_ARG(8, 12),
+	.d		= TH_CCU_ARG(24, 3),
+	.i		= TH_CCU_ARG(20, 3),
+	.v		= TH_CCU_ARG(0, 6),
+	.common		= {
+		.reg		= 0x000,
+		.hw.init	= CLK_HW_INIT("pll-cpu0", "osc24m",
+					      &clk_mdiv_ops,
+					      0),
+	},
+};
+
+static struct ccu_mdiv pll_cpu1_clk = {
+	.m		= TH_CCU_ARG(8, 12),
+	.d		= TH_CCU_ARG(24, 3),
+	.i		= TH_CCU_ARG(20, 3),
+	.v		= TH_CCU_ARG(0, 6),
+	.common		= {
+		.reg		= 0x010,
+		.hw.init	= CLK_HW_INIT("pll-cpu1", "osc24m",
+					      &clk_mdiv_ops,
+					      0),
+	},
+};
+
+static struct ccu_mdiv pll_gmac_clk = {
+	.m		= TH_CCU_ARG(8, 12),
+	.d		= TH_CCU_ARG(24, 3),
+	.i		= TH_CCU_ARG(20, 3),
+	.v		= TH_CCU_ARG(0, 6),
+	.common		= {
+		.reg		= 0x020,
+		.hw.init	= CLK_HW_INIT("pll-gmac", "osc24m",
+					      &clk_mdiv_ops,
+					      0),
+	},
+};
+
+static struct ccu_mdiv pll_video_clk = {
+	.m		= TH_CCU_ARG(8, 12),
+	.d		= TH_CCU_ARG(24, 3),
+	.i		= TH_CCU_ARG(20, 3),
+	.v		= TH_CCU_ARG(0, 6),
+	.common		= {
+		.reg		= 0x030,
+		.hw.init	= CLK_HW_INIT("pll-video", "osc24m",
+					      &clk_mdiv_ops,
+					      0),
+	},
+};
+
+static struct ccu_mdiv pll_dpu0_clk = {
+	.m		= TH_CCU_ARG(8, 12),
+	.d		= TH_CCU_ARG(24, 3),
+	.i		= TH_CCU_ARG(20, 3),
+	.v		= TH_CCU_ARG(0, 6),
+	.common		= {
+		.reg		= 0x040,
+		.hw.init	= CLK_HW_INIT("pll-dpu0", "osc24m",
+					      &clk_mdiv_ops,
+					      0),
+	},
+};
+
+static struct ccu_mdiv pll_dpu1_clk = {
+	.m		= TH_CCU_ARG(8, 12),
+	.d		= TH_CCU_ARG(24, 3),
+	.i		= TH_CCU_ARG(20, 3),
+	.v		= TH_CCU_ARG(0, 6),
+	.common		= {
+		.reg		= 0x050,
+		.hw.init	= CLK_HW_INIT("pll-dpu1", "osc24m",
+					      &clk_mdiv_ops,
+					      0),
+	},
+};
+
+static struct ccu_mdiv pll_tee_clk = {
+	.m		= TH_CCU_ARG(8, 12),
+	.d		= TH_CCU_ARG(24, 3),
+	.i		= TH_CCU_ARG(20, 3),
+	.v		= TH_CCU_ARG(0, 6),
+	.common		= {
+		.reg		= 0x060,
+		.hw.init	= CLK_HW_INIT("pll-tee", "osc24m",
+					      &clk_mdiv_ops,
+					      0),
+	},
+};
+
+static const char * const c910_i0_parents[] = { "pll-cpu0", "osc24m" };
+struct ccu_mux c910_i0_clk = {
+	.mux	= TH_CCU_ARG(1, 1),
+	.common	= {
+		.reg		= 00100,
+		.hw.init	= CLK_HW_INIT_PARENTS("c910-i0",
+					      c910_i0_parents,
+					      &ccu_mux_ops,
+					      0),
+	}
+};
+
+static const char * const c910_parents[] = { "c910-i0", "pll-cpu1" };
+struct ccu_mux c910_clk = {
+	.mux	= TH_CCU_ARG(0, 1),
+	.common	= {
+		.reg		= 0x100,
+		.hw.init	= CLK_HW_INIT_PARENTS("c910",
+					      c910_parents,
+					      &ccu_mux_ops,
+					      0),
+	}
+};
+
+static CCU_GATE(brom_clk, "brom", "ahb2",
+		0x100, BIT(4), 0);
+
+static CCU_GATE(bmu_clk, "bmu", "axi4",
+		0x100, BIT(5), 0);
+
+static const char * const ahb2_parents[] = { "pll-gmac", "osc24m" };
+static struct ccu_div ahb2_clk = {
+	.div		= TH_CCU_DIV_FLAGS(0, 3, CLK_DIVIDER_ONE_BASED),
+	.mux		= TH_CCU_ARG(5, 1),
+	.common		= {
+		.reg		= 0x120,
+		.hw.init	= CLK_HW_INIT_PARENTS("ahb2",
+						      ahb2_parents,
+						      &ccu_div_ops,
+						      0),
+	},
+};
+
+static struct ccu_div apb3_clk = {
+	.div		= TH_CCU_ARG(0, 3),
+	.common		= {
+		.reg		= 0x130,
+		.hw.init	= CLK_HW_INIT("apb3", "ahb2",
+					      &ccu_div_ops,
+					      0),
+	},
+};
+
+static struct ccu_div axi4_clk = {
+	.div		= TH_CCU_DIV_FLAGS(0, 3, CLK_DIVIDER_ONE_BASED),
+	.common		= {
+		.reg		= 0x134,
+		.hw.init	= CLK_HW_INIT("axi4", "pll-gmac",
+					      &ccu_div_ops,
+					      0),
+	},
+};
+
+static CCU_GATE(aon2cpu_clk, "aon2cpu", "axi4",
+		0x134, BIT(8), 0);
+
+static CCU_GATE(x2x_clk, "x2x", "axi4",
+		0x134, BIT(7), 0);
+
+static const char * const axi_parents[] = { "pll-video", "osc24m" };
+static struct ccu_div axi_clk = {
+	.div		= TH_CCU_DIV_FLAGS(0, 4, CLK_DIVIDER_ONE_BASED),
+	.mux		= TH_CCU_ARG(5, 1),
+	.common		= {
+		.reg		= 0x138,
+		.hw.init	= CLK_HW_INIT_PARENTS("axi",
+						      axi_parents,
+						      &ccu_div_ops,
+						      0),
+	},
+};
+
+static CCU_GATE(cpu2aon_clk, "cpu2aon", "axi",
+		0x138, BIT(8), 0);
+
+static const char * const peri_ahb_parents[] = { "pll-gmac", "osc24m" };
+static struct ccu_div peri_ahb_clk = {
+	.enable		= BIT(6),
+	.div		= TH_CCU_DIV_FLAGS(0, 4, CLK_DIVIDER_ONE_BASED),
+	.mux		= TH_CCU_ARG(5, 1),
+	.common		= {
+		.reg		= 0x140,
+		.hw.init	= CLK_HW_INIT_PARENTS("peri-ahb",
+						      peri_ahb_parents,
+						      &ccu_div_ops,
+						      0),
+	},
+};
+
+static CCU_GATE(cpu2peri_clk, "cpu2peri", "axi4",
+		0x140, BIT(9), 0);
+
+static struct ccu_div peri_apb_clk = {
+	.div		= TH_CCU_ARG(0, 3),
+	.common		= {
+		.reg		= 0x150,
+		.hw.init	= CLK_HW_INIT("peri-apb", "peri-ahb",
+					      &ccu_div_ops,
+					      0),
+	},
+};
+
+static struct ccu_div peri2apb_clk = {
+	.div		= TH_CCU_DIV_FLAGS(4, 3, CLK_DIVIDER_ONE_BASED),
+	.common		= {
+		.reg		= 0x150,
+		.hw.init	= CLK_HW_INIT("peri2apb",
+					      "pll-gmac",
+					      &ccu_div_ops,
+					      0),
+	},
+};
+
+static CCU_GATE(peri_apb1_clk, "peri-apb1", "peri-ahb",
+		0x150, BIT(9), 0);
+
+static CCU_GATE(peri_apb2_clk, "peri-apb2", "peri-ahb",
+		0x150, BIT(10), 0);
+
+static CCU_GATE(peri_apb3_clk, "peri-apb3", "peri-ahb",
+		0x150, BIT(11), 0);
+
+static CCU_GATE(peri_apb4_clk, "peri-apb4", "peri-ahb",
+		0x150, BIT(12), 0);
+
+static CLK_FIXED_FACTOR_FW_NAME(osc12m_clk, "osc12m", "hosc", 2, 1, 0);
+
+static const char * const out_parents[] = { "osc24m", "osc12m" };
+
+static struct ccu_div out1_clk = {
+	.enable		= BIT(5),
+	.div		= TH_CCU_DIV_FLAGS(0, 3, CLK_DIVIDER_ONE_BASED),
+	.mux		= TH_CCU_ARG(4, 1),
+	.common		= {
+		.reg		= 0x1b4,
+		.hw.init	= CLK_HW_INIT_PARENTS("out1",
+						      out_parents,
+						      &ccu_div_ops,
+						      0),
+	},
+};
+
+static struct ccu_div out2_clk = {
+	.enable		= BIT(5),
+	.div		= TH_CCU_DIV_FLAGS(0, 3, CLK_DIVIDER_ONE_BASED),
+	.mux		= TH_CCU_ARG(4, 1),
+	.common		= {
+		.reg		= 0x1b8,
+		.hw.init	= CLK_HW_INIT_PARENTS("out2",
+						      out_parents,
+						      &ccu_div_ops,
+						      0),
+	},
+};
+
+static struct ccu_div out3_clk = {
+	.enable		= BIT(5),
+	.div		= TH_CCU_DIV_FLAGS(0, 3, CLK_DIVIDER_ONE_BASED),
+	.mux		= TH_CCU_ARG(4, 1),
+	.common		= {
+		.reg		= 0x1bc,
+		.hw.init	= CLK_HW_INIT_PARENTS("out3",
+						      out_parents,
+						      &ccu_div_ops,
+						      0),
+	},
+};
+
+static struct ccu_div out4_clk = {
+	.enable		= BIT(5),
+	.div		= TH_CCU_DIV_FLAGS(0, 3, CLK_DIVIDER_ONE_BASED),
+	.mux		= TH_CCU_ARG(4, 1),
+	.common		= {
+		.reg		= 0x1c0,
+		.hw.init	= CLK_HW_INIT_PARENTS("out4",
+						      out_parents,
+						      &ccu_div_ops,
+						      0),
+	},
+};
+
+static const char * const apb_parents[] = { "pll-gmac", "osc24m" };
+static struct ccu_div apb_clk = {
+	.enable		= BIT(5),
+	.div		= TH_CCU_DIV_FLAGS(0, 4, CLK_DIVIDER_ONE_BASED),
+	.mux		= TH_CCU_ARG(7, 1),
+	.common		= {
+		.reg		= 0x1c4,
+		.hw.init	= CLK_HW_INIT_PARENTS("apb",
+						      apb_parents,
+						      &ccu_div_ops,
+						      0),
+	},
+};
+
+static const char * const npu_parents[] = { "pll-gmac", "pll-video" };
+static struct ccu_div npu_clk = {
+	.enable		= BIT(5),
+	.div		= TH_CCU_DIV_FLAGS(0, 3, CLK_DIVIDER_ONE_BASED),
+	.mux		= TH_CCU_ARG(6, 1),
+	.common		= {
+		.reg		= 0x1c8,
+		.hw.init	= CLK_HW_INIT_PARENTS("npu",
+						      npu_parents,
+						      &ccu_div_ops,
+						      0),
+	},
+};
+
+static struct ccu_div vi_clk = {
+	.div		= TH_CCU_DIV_FLAGS(16, 4, CLK_DIVIDER_ONE_BASED),
+	.common		= {
+		.reg		= 0x1d0,
+		.hw.init	= CLK_HW_INIT("vi",
+					      "pll-video",
+					      &ccu_div_ops,
+					      0),
+	},
+};
+
+static struct ccu_div vi_ahb_clk = {
+	.div		= TH_CCU_DIV_FLAGS(0, 4, CLK_DIVIDER_ONE_BASED),
+	.common		= {
+		.reg		= 0x1d0,
+		.hw.init	= CLK_HW_INIT("vi-ahb",
+					      "pll-video",
+					      &ccu_div_ops,
+					      0),
+	},
+};
+
+static struct ccu_div vo_axi_clk = {
+	.enable		= BIT(5),
+	.div		= TH_CCU_DIV_FLAGS(0, 4, CLK_DIVIDER_ONE_BASED),
+	.common		= {
+		.reg		= 0x1dc,
+		.hw.init	= CLK_HW_INIT("vo-axi",
+					      "pll-video",
+					      &ccu_div_ops,
+					      0),
+	},
+};
+
+static struct ccu_div vp_apb_clk = {
+	.div		= TH_CCU_DIV_FLAGS(0, 3, CLK_DIVIDER_ONE_BASED),
+	.common		= {
+		.reg		= 0x1e0,
+		.hw.init	= CLK_HW_INIT("vp-apb",
+					      "pll-gmac",
+					      &ccu_div_ops,
+					      0),
+	},
+};
+
+static struct ccu_div vp_axi_clk = {
+	.enable		= BIT(15),
+	.div		= TH_CCU_DIV_FLAGS(8, 4, CLK_DIVIDER_ONE_BASED),
+	.common		= {
+		.reg		= 0x1e0,
+		.hw.init	= CLK_HW_INIT("vp-axi",
+					      "pll-video",
+					      &ccu_div_ops,
+					      0),
+	},
+};
+
+static CCU_GATE(cpu2vp_clk, "cpu2vp", "axi",
+		0x1e0, BIT(13), 0);
+
+static struct ccu_div venc_clk = {
+	.enable		= BIT(5),
+	.div		= TH_CCU_DIV_FLAGS(0, 3, CLK_DIVIDER_ONE_BASED),
+	.common		= {
+		.reg		= 0x1e4,
+		.hw.init	= CLK_HW_INIT("venc",
+					      "pll-gmac",
+					      &ccu_div_ops,
+					      0),
+	},
+};
+
+static struct ccu_div dpu0_clk = {
+	.div		= TH_CCU_DIV_FLAGS(0, 8, CLK_DIVIDER_ONE_BASED),
+	.common		= {
+		.reg		= 0x1e8,
+		.hw.init	= CLK_HW_INIT("dpu0",
+					      "pll-dpu0",
+					      &ccu_div_ops,
+					      0),
+	},
+};
+
+static struct ccu_div dpu1_clk = {
+	.div		= TH_CCU_DIV_FLAGS(0, 8, CLK_DIVIDER_ONE_BASED),
+	.common		= {
+		.reg		= 0x1ec,
+		.hw.init	= CLK_HW_INIT("dpu1",
+					      "pll-dpu1",
+					      &ccu_div_ops,
+					      0),
+	},
+};
+
+static CCU_GATE(mmc_clk, "mmc", "pll-video", 0x204, BIT(30), 0);
+static CCU_GATE(gmac1_clk, "gmac1", "pll-gmac", 0x204, BIT(26), 0);
+static CCU_GATE(padctrl1_clk, "padctrl1", "peri-apb", 0x204, BIT(24), 0);
+static CCU_GATE(dsmart_clk, "dsmart", "peri-apb", 0x204, BIT(23), 0);
+static CCU_GATE(padctrl0_clk, "padctrl0", "peri-apb", 0x204, BIT(22), 0);
+static CCU_GATE(gmac_axi_clk, "gmac-axi", "axi4", 0x204, BIT(21), 0);
+static CCU_GATE(gmac0_clk, "gmac0", "pll-gmac", 0x204, BIT(19), 0);
+static CCU_GATE(pwm_clk, "pwm", "peri-apb", 0x204, BIT(18), 0);
+static CCU_GATE(qspi0_clk, "qspi0", "pll-video", 0x204, BIT(17), 0);
+static CCU_GATE(qspi1_clk, "qspi1", "pll-video", 0x204, BIT(16), 0);
+static CCU_GATE(spi_clk, "spi", "pll-video", 0x204, BIT(15), 0);
+static CCU_GATE(uart0_clk, "uart0", "peri-apb", 0x204, BIT(14), 0);
+static CCU_GATE(uart1_clk, "uart1", "peri-apb", 0x204, BIT(13), 0);
+static CCU_GATE(uart2_clk, "uart2", "peri-apb", 0x204, BIT(12), 0);
+static CCU_GATE(uart3_clk, "uart3", "peri-apb", 0x204, BIT(11), 0);
+static CCU_GATE(uart4_clk, "uart4", "peri-apb", 0x204, BIT(10), 0);
+static CCU_GATE(uart5_clk, "uart5", "peri-apb", 0x204, BIT(9), 0);
+static CCU_GATE(i2c0_clk, "i2c0", "peri-apb", 0x204, BIT(5), 0);
+static CCU_GATE(i2c1_clk, "i2c1", "peri-apb", 0x204, BIT(4), 0);
+static CCU_GATE(i2c2_clk, "i2c2", "peri-apb", 0x204, BIT(3), 0);
+static CCU_GATE(i2c3_clk, "i2c3", "peri-apb", 0x204, BIT(2), 0);
+static CCU_GATE(i2c4_clk, "i2c4", "peri-apb", 0x204, BIT(1), 0);
+static CCU_GATE(i2c5_clk, "i2c5", "peri-apb", 0x204, BIT(0), 0);
+
+static CCU_GATE(spinlock_clk, "spinlock", "ahb2", 0x208, BIT(10), 0);
+static CCU_GATE(dma_clk, "dma", "axi4", 0x208, BIT(8), 0);
+static CCU_GATE(mbox0_clk, "mbox0", "apb3", 0x208, BIT(7), 0);
+static CCU_GATE(mbox1_clk, "mbox1", "apb3", 0x208, BIT(6), 0);
+static CCU_GATE(mbox2_clk, "mbox2", "apb3", 0x208, BIT(5), 0);
+static CCU_GATE(mbox3_clk, "mbox3", "apb3", 0x208, BIT(4), 0);
+static CCU_GATE(wdt0_clk, "wdt0", "apb3", 0x208, BIT(3), 0);
+static CCU_GATE(wdt1_clk, "wdt1", "apb3", 0x208, BIT(2), 0);
+static CCU_GATE(timer0_clk, "timer0", "apb3", 0x208, BIT(1), 0);
+static CCU_GATE(timer1_clk, "timer1", "apb3", 0x208, BIT(0), 0);
+
+static CCU_GATE(sram0_clk, "sram0", "axi", 0x20c, BIT(4), 0);
+static CCU_GATE(sram1_clk, "sram1", "axi", 0x20c, BIT(3), 0);
+static CCU_GATE(sram2_clk, "sram2", "axi", 0x20c, BIT(2), 0);
+static CCU_GATE(sram3_clk, "sram3", "axi", 0x20c, BIT(1), 0);
+
+static CLK_FIXED_FACTOR_HW(pll_gmac_100m_clk, "pll-gmac-100m",
+			   &pll_gmac_clk.common.hw,
+			   10, 1, 0);
+
+static const char * const uart_parents[] = { "pll-gmac-100m", "osc24m" };
+struct ccu_mux uart_clk = {
+	.mux	= TH_CCU_ARG(0, 1),
+	.common	= {
+		.reg		= 0x210,
+		.hw.init	= CLK_HW_INIT_PARENTS("uart",
+					      uart_parents,
+					      &ccu_mux_ops,
+					      0),
+	}
+};
+
+static struct ccu_common *th1520_clks[] = {
+	&pll_cpu0_clk.common,
+	&pll_cpu1_clk.common,
+	&pll_gmac_clk.common,
+	&pll_video_clk.common,
+	&pll_dpu0_clk.common,
+	&pll_dpu1_clk.common,
+	&pll_tee_clk.common,
+	&c910_i0_clk.common,
+	&c910_clk.common,
+	&brom_clk.common,
+	&bmu_clk.common,
+	&ahb2_clk.common,
+	&apb3_clk.common,
+	&axi4_clk.common,
+	&aon2cpu_clk.common,
+	&x2x_clk.common,
+	&axi_clk.common,
+	&cpu2aon_clk.common,
+	&peri_ahb_clk.common,
+	&cpu2peri_clk.common,
+	&peri_apb_clk.common,
+	&peri2apb_clk.common,
+	&peri_apb1_clk.common,
+	&peri_apb2_clk.common,
+	&peri_apb3_clk.common,
+	&peri_apb4_clk.common,
+	&out1_clk.common,
+	&out2_clk.common,
+	&out3_clk.common,
+	&out4_clk.common,
+	&apb_clk.common,
+	&npu_clk.common,
+	&vi_clk.common,
+	&vi_ahb_clk.common,
+	&vo_axi_clk.common,
+	&vp_apb_clk.common,
+	&vp_axi_clk.common,
+	&cpu2vp_clk.common,
+	&venc_clk.common,
+	&dpu0_clk.common,
+	&dpu1_clk.common,
+	&mmc_clk.common,
+	&gmac1_clk.common,
+	&padctrl1_clk.common,
+	&dsmart_clk.common,
+	&padctrl0_clk.common,
+	&gmac_axi_clk.common,
+	&gmac0_clk.common,
+	&pwm_clk.common,
+	&qspi0_clk.common,
+	&qspi1_clk.common,
+	&spi_clk.common,
+	&uart0_clk.common,
+	&uart1_clk.common,
+	&uart2_clk.common,
+	&uart3_clk.common,
+	&uart4_clk.common,
+	&uart5_clk.common,
+	&i2c0_clk.common,
+	&i2c1_clk.common,
+	&i2c2_clk.common,
+	&i2c3_clk.common,
+	&i2c4_clk.common,
+	&i2c5_clk.common,
+	&spinlock_clk.common,
+	&dma_clk.common,
+	&mbox0_clk.common,
+	&mbox1_clk.common,
+	&mbox2_clk.common,
+	&mbox3_clk.common,
+	&wdt0_clk.common,
+	&wdt1_clk.common,
+	&timer0_clk.common,
+	&timer1_clk.common,
+	&sram0_clk.common,
+	&sram1_clk.common,
+	&sram2_clk.common,
+	&sram3_clk.common,
+	&uart_clk.common,
+};
+
+#define NR_CLKS	(CLK_UART + 1)
+
+static struct clk_hw_onecell_data th1520_hw_clks = {
+	.hws	= {
+		[CLK_OSC12M]		= &osc12m_clk.hw,
+		[CLK_PLL_CPU0]		= &pll_cpu0_clk.common.hw,
+		[CLK_PLL_CPU1]		= &pll_cpu1_clk.common.hw,
+		[CLK_PLL_GMAC]		= &pll_gmac_clk.common.hw,
+		[CLK_PLL_VIDEO]		= &pll_video_clk.common.hw,
+		[CLK_PLL_DPU0]		= &pll_dpu0_clk.common.hw,
+		[CLK_PLL_DPU1]		= &pll_dpu1_clk.common.hw,
+		[CLK_PLL_TEE]		= &pll_tee_clk.common.hw,
+		[CLK_C910_I0]		= &c910_i0_clk.common.hw,
+		[CLK_C910]		= &c910_clk.common.hw,
+		[CLK_BROM]		= &brom_clk.common.hw,
+		[CLK_BMU]		= &bmu_clk.common.hw,
+		[CLK_AHB2]		= &ahb2_clk.common.hw,
+		[CLK_APB3]		= &apb3_clk.common.hw,
+		[CLK_AXI4]		= &axi4_clk.common.hw,
+		[CLK_AON2CPU]		= &aon2cpu_clk.common.hw,
+		[CLK_X2X]		= &x2x_clk.common.hw,
+		[CLK_AXI]		= &axi_clk.common.hw,
+		[CLK_CPU2AON]		= &cpu2aon_clk.common.hw,
+		[CLK_PERI_AHB]		= &peri_ahb_clk.common.hw,
+		[CLK_CPU2PERI]		= &cpu2peri_clk.common.hw,
+		[CLK_PERI_APB]		= &peri_apb_clk.common.hw,
+		[CLK_PERI2APB]		= &peri2apb_clk.common.hw,
+		[CLK_PERI_APB1]		= &peri_apb1_clk.common.hw,
+		[CLK_PERI_APB2]		= &peri_apb2_clk.common.hw,
+		[CLK_PERI_APB3]		= &peri_apb3_clk.common.hw,
+		[CLK_PERI_APB4]		= &peri_apb4_clk.common.hw,
+		[CLK_OUT1]		= &out1_clk.common.hw,
+		[CLK_OUT2]		= &out2_clk.common.hw,
+		[CLK_OUT3]		= &out3_clk.common.hw,
+		[CLK_OUT4]		= &out4_clk.common.hw,
+		[CLK_APB]		= &apb_clk.common.hw,
+		[CLK_NPU]		= &npu_clk.common.hw,
+		[CLK_VI]		= &vi_clk.common.hw,
+		[CLK_VI_AHB]		= &vi_ahb_clk.common.hw,
+		[CLK_VO_AXI]		= &vo_axi_clk.common.hw,
+		[CLK_VP_APB]		= &vp_apb_clk.common.hw,
+		[CLK_VP_AXI]		= &vp_axi_clk.common.hw,
+		[CLK_CPU2VP]		= &cpu2vp_clk.common.hw,
+		[CLK_VENC]		= &venc_clk.common.hw,
+		[CLK_DPU0]		= &dpu0_clk.common.hw,
+		[CLK_DPU1]		= &dpu1_clk.common.hw,
+		[CLK_MMC]		= &mmc_clk.common.hw,
+		[CLK_GMAC]		= &gmac1_clk.common.hw,
+		[CLK_PADCTRL1]		= &padctrl1_clk.common.hw,
+		[CLK_DSMART]		= &dsmart_clk.common.hw,
+		[CLK_PADCTRL0]		= &padctrl0_clk.common.hw,
+		[CLK_GMAC_AXI]		= &gmac_axi_clk.common.hw,
+		[CLK_GMAC0]		= &gmac0_clk.common.hw,
+		[CLK_PWM]		= &pwm_clk.common.hw,
+		[CLK_QSPI0]		= &qspi0_clk.common.hw,
+		[CLK_QSPI1]		= &qspi1_clk.common.hw,
+		[CLK_SPI]		= &spi_clk.common.hw,
+		[CLK_UART0]		= &uart0_clk.common.hw,
+		[CLK_UART1]		= &uart1_clk.common.hw,
+		[CLK_UART2]		= &uart2_clk.common.hw,
+		[CLK_UART3]		= &uart3_clk.common.hw,
+		[CLK_UART4]		= &uart4_clk.common.hw,
+		[CLK_UART5]		= &uart5_clk.common.hw,
+		[CLK_I2C0]		= &i2c0_clk.common.hw,
+		[CLK_I2C1]		= &i2c1_clk.common.hw,
+		[CLK_I2C2]		= &i2c2_clk.common.hw,
+		[CLK_I2C3]		= &i2c3_clk.common.hw,
+		[CLK_I2C4]		= &i2c4_clk.common.hw,
+		[CLK_I2C5]		= &i2c5_clk.common.hw,
+		[CLK_SPINLOCK]		= &spinlock_clk.common.hw,
+		[CLK_DMA]		= &dma_clk.common.hw,
+		[CLK_MBOX0]		= &mbox0_clk.common.hw,
+		[CLK_MBOX1]		= &mbox1_clk.common.hw,
+		[CLK_MBOX2]		= &mbox2_clk.common.hw,
+		[CLK_MBOX3]		= &mbox3_clk.common.hw,
+		[CLK_WDT0]		= &wdt0_clk.common.hw,
+		[CLK_WDT1]		= &wdt1_clk.common.hw,
+		[CLK_TIMER0]		= &timer0_clk.common.hw,
+		[CLK_TIMER1]		= &timer1_clk.common.hw,
+		[CLK_SRAM0]		= &sram0_clk.common.hw,
+		[CLK_SRAM1]		= &sram1_clk.common.hw,
+		[CLK_SRAM2]		= &sram2_clk.common.hw,
+		[CLK_SRAM3]		= &sram3_clk.common.hw,
+		[CLK_PLL_GMAC_100M]	= &pll_gmac_100m_clk.hw,
+		[CLK_UART]		= &uart_clk.common.hw,
+	},
+	.num = NR_CLKS,
+};
+
+static const struct regmap_config config = {
+	.reg_bits = 32,
+	.val_bits = 32,
+	.reg_stride = 4,
+	.fast_io = true,
+};
+
+static int th1520_clock_probe(struct platform_device *pdev)
+{
+	struct device *dev = &pdev->dev;
+	struct regmap *map;
+	void __iomem *regs;
+	int ret, i;
+
+	regs = devm_platform_ioremap_resource(pdev, 0);
+	if (IS_ERR(regs))
+		return PTR_ERR(regs);
+
+	map = devm_regmap_init_mmio(dev, regs, &config);
+	if (IS_ERR(map))
+		return PTR_ERR(map);
+
+	for (i = 0; i < ARRAY_SIZE(th1520_clks); i++)
+		th1520_clks[i]->map = map;
+
+	for (i = 0; i < th1520_hw_clks.num; i++) {
+		ret = devm_clk_hw_register(dev, th1520_hw_clks.hws[i]);
+		if (ret)
+			return ret;
+	}
+
+	ret = devm_of_clk_add_hw_provider(dev, of_clk_hw_onecell_get,
+					&th1520_hw_clks);
+	if (ret)
+		return ret;
+
+	return 0;
+}
+
+static const struct of_device_id clk_match_table[] = {
+	{
+		.compatible = "thead,th1520-ccu",
+	},
+	{ /* sentinel */ },
+};
+MODULE_DEVICE_TABLE(of, clk_match_table);
+
+static struct platform_driver th1520_clk_driver = {
+	.probe		= th1520_clock_probe,
+	.driver		= {
+		.name	= "th1520-clk",
+		.of_match_table = clk_match_table,
+	},
+};
+module_platform_driver(th1520_clk_driver);
+
+MODULE_DESCRIPTION("T-HEAD th1520 Clock driver");
+MODULE_AUTHOR("Yangtao Li <frank.li@vivo.com>");
+MODULE_LICENSE("GPL");
diff --git a/include/dt-bindings/clock/th1520-clock.h b/include/dt-bindings/clock/th1520-clock.h
new file mode 100644
index 000000000000..e5a1e1c127fc
--- /dev/null
+++ b/include/dt-bindings/clock/th1520-clock.h
@@ -0,0 +1,92 @@
+/* SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause) */
+/*
+ * Copyright (C) 2023 Vivo Communication Technology Co. Ltd.
+ * Authors: Yangtao Li <frank.li@vivo.com>
+ */
+
+#ifndef _DT_BINDINGS_CLK_TH1520_H_
+#define _DT_BINDINGS_CLK_TH1520_H_
+
+#define CLK_PLL_CPU0		0
+#define CLK_PLL_CPU1		1
+#define CLK_PLL_GMAC		2
+#define CLK_PLL_VIDEO		3
+#define CLK_PLL_DPU0		4
+#define CLK_PLL_DPU1		5
+#define CLK_PLL_TEE		6
+#define CLK_C910_I0		7
+#define CLK_C910		8
+#define CLK_BROM		9
+#define CLK_BMU			10
+#define CLK_AHB2		11
+#define CLK_APB3		12
+#define CLK_AXI4		13
+#define CLK_AON2CPU		14
+#define CLK_X2X			15
+#define CLK_AXI			16
+#define CLK_CPU2AON		17
+#define CLK_PERI_AHB		18
+#define CLK_CPU2PERI		19
+#define CLK_PERI_APB		20
+#define CLK_PERI2APB		21
+#define CLK_PERI_APB1		22
+#define CLK_PERI_APB2		23
+#define CLK_PERI_APB3		24
+#define CLK_PERI_APB4		25
+#define CLK_OSC12M		26
+#define CLK_OUT1		27
+#define CLK_OUT2		28
+#define CLK_OUT3		29
+#define CLK_OUT4		30
+#define CLK_APB			31
+#define CLK_NPU			32
+#define CLK_VI			33
+#define CLK_VI_AHB		34
+#define CLK_VO_AXI		35
+#define CLK_VP_APB		36
+#define CLK_VP_AXI		37
+#define CLK_CPU2VP		38
+#define CLK_VENC		39
+#define CLK_DPU0		40
+#define CLK_DPU1		41
+#define CLK_MMC			42
+#define CLK_GMAC		43
+#define CLK_PADCTRL1		44
+#define CLK_DSMART		45
+#define CLK_PADCTRL0		46
+#define CLK_GMAC_AXI		47
+#define CLK_GMAC0		48
+#define CLK_PWM			49
+#define CLK_QSPI0		50
+#define CLK_QSPI1		51
+#define CLK_SPI			52
+#define CLK_UART0		53
+#define CLK_UART1		54
+#define CLK_UART2		55
+#define CLK_UART3		56
+#define CLK_UART4		57
+#define CLK_UART5		58
+#define CLK_I2C0		59
+#define CLK_I2C1		60
+#define CLK_I2C2		61
+#define CLK_I2C3		62
+#define CLK_I2C4		63
+#define CLK_I2C5		64
+#define CLK_SPINLOCK		65
+#define CLK_DMA			66
+#define CLK_MBOX0		67
+#define CLK_MBOX1		68
+#define CLK_MBOX2		69
+#define CLK_MBOX3		70
+#define CLK_WDT0		71
+#define CLK_WDT1		72
+#define CLK_TIMER0		73
+#define CLK_TIMER1		74
+#define CLK_SRAM0		75
+#define CLK_SRAM1		76
+#define CLK_SRAM2		77
+#define CLK_SRAM3		78
+#define CLK_PLL_GMAC_100M	79
+#define CLK_UART		80
+
+#endif
-- 
2.39.0

