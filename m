Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1E82F6F67C5
	for <lists+linux-kernel@lfdr.de>; Thu,  4 May 2023 10:50:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230228AbjEDIuP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 May 2023 04:50:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54504 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230193AbjEDIuN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 May 2023 04:50:13 -0400
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2040.outbound.protection.outlook.com [40.107.21.40])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2282A3C07;
        Thu,  4 May 2023 01:50:09 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WJOZlpSKmCPaJ1N24V8FPxwHDmb/2P8aG2yjohmaaGC+0I08xF6POt0YKCxPHjfmLQ8ywPbaA8ubEIhn44L3jCx6wn8Rgol6PPMTZXRKAvX2h4O+VXeT+eVAwtzX0zeOVle+jR5a0dRBaByyB0G1WO3MdC9jBrYBk9qLoZ/MZeMZVDSd26gpEKWYp1Bloq/geu1mr6PwIXtzqurGwJ666V+c77SRAKluCsRqktDczYA6y1MciZy9o9jWAXJ/pBajupV1iQshyJUxiMN3cfYiP5cv0lO3r84bDUdPe1jdAkszHGOe2gQuEtz9Pis8ty3KSKlM83HxWSYuVvnqTXKJfQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xCDOHuFrQYfhE30ZgxTiXiISVxjL8v8tf6k3k5tsBFQ=;
 b=BLEkN7xJRuAVA0uU3J109LOZOIgDNAlqqXNJRObyuCLUCclX0/HpFPKPyWtKsvvbe5Ee5853xN4/ANp5KYWsrByiauPJEKUPSkq0For/3rCAxK6WGZIYlr2b2sv5I0yoYN0Q9azk/RJiXP5AwSG7mnhpA08zRGB+kDcmH0wfQdUcb0Wsn4BTEAbA5TKz83KqTYNxuL+zUCY66UYLCKoKcCu9273kKL7eVvKEh/DrHcZSOopEmgXMXsCRs/CSVBakgWwkJImxDHslQl2MU2595S0P3Hb2THQywXseqFwnAvkyszH3qav7cciqANZpbrNb95VI3n2wH8dXZRW95M0wGw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xCDOHuFrQYfhE30ZgxTiXiISVxjL8v8tf6k3k5tsBFQ=;
 b=mTGwe81iFAfb0GkeP1/iIoxq2favxH7nMdOt9uDH2+xrJNcj391441WRDXmiaX5IcSjNECMlapNNiHbgw9ThZf2ROZFkSm0NtpQINCWz8xlhB4yEqCDAUnvmsMI5/kCvPk/gjaz4NUE5kQ6gbT5hZ9qQKzoKx3XEB+Fve25UCRE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by AM7PR04MB7159.eurprd04.prod.outlook.com (2603:10a6:20b:111::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6363.26; Thu, 4 May
 2023 08:50:06 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::b999:f2c6:a8cc:7b4]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::b999:f2c6:a8cc:7b4%5]) with mapi id 15.20.6340.031; Thu, 4 May 2023
 08:50:06 +0000
From:   "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
To:     abelvesa@kernel.org, mturquette@baylibre.com, sboyd@kernel.org,
        shawnguo@kernel.org, s.hauer@pengutronix.de, kernel@pengutronix.de,
        festevam@gmail.com
Cc:     linux-imx@nxp.com, linux-clk@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Peng Fan <peng.fan@nxp.com>
Subject: [PATCH] clk: imx: imx93: introduce clk_bypassed module parameter
Date:   Thu,  4 May 2023 16:55:06 +0800
Message-Id: <20230504085506.504474-1-peng.fan@oss.nxp.com>
X-Mailer: git-send-email 2.37.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR01CA0124.apcprd01.prod.exchangelabs.com
 (2603:1096:4:40::28) To DU0PR04MB9417.eurprd04.prod.outlook.com
 (2603:10a6:10:358::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU0PR04MB9417:EE_|AM7PR04MB7159:EE_
X-MS-Office365-Filtering-Correlation-Id: 02614332-90ef-4b52-925b-08db4c7c8ebb
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: aD4Z3Y3wd+V92zx3PCDZpEXavBed9oXo8h1uwfvLu0mJyMcaOyKsVLnng1dhfduVmh8vGfIVVop+HbvqTK+Gh+9weSIUZrm5f77Xum6MVQ38DJvQ+ZKvWgYAaE2H+Wx5xMpjAdyZL6mJ0h/m/JP8OvbU+vKRdS9+MN/vUoxk8Pa6owIPpxW+ZQSkjVWIGL6XQM4UtlyiOUNwStxC4aQCW7DnKwmUS/Svowp+PGfuyiOa/4ZdwrpGBSEKua6leiDGX4YW1aAhaSJIKMV0onqAVDYbl8vowc5zj6z1+eptlY6SL3M9w2BieOjGxvnQlErf4VwGnOLyd4CVsw7I3UKRLDK7S/XxIoIo8552dPtJK0vuAB49RXOiUgUDiqgjJ+G3n//9/SsM6O7dxLM23P7UKC398nruyEoNv/FPKLfjPU3njNgz/Z2BGRbfHGnXTg7j6UoUZVyeu5kHU+ShoMe+naVx8GWE4wo3N5tfJxFzxuUntS7keKuAadVFmHPLnB48ILfvnN8aMuiiN0CgA/ixqxJO2v45rgTa2J5nBgLw4rosJriY7lh1BR+qt394iuqtg+pqvhnSXpfiF1BTCN47MCZOcYkxDdpu9Yl1rZoinpw=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(136003)(376002)(396003)(366004)(346002)(39860400002)(451199021)(2616005)(52116002)(6486002)(26005)(1076003)(41300700001)(86362001)(316002)(83380400001)(4326008)(66476007)(66556008)(66946007)(478600001)(2906002)(38100700002)(38350700002)(186003)(5660300002)(7416002)(966005)(8936002)(8676002)(6506007)(6512007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?bYkakGvvIZp+MqVcdWfdJIOO4xi9iG5QraO1aLnZJ0/qEHMa+O16a5pyn/Z/?=
 =?us-ascii?Q?Ew4H4ZRu6rw/hWQI1RXGhpnynjTS6ejZspXKE2LXNHBdGeXTo3bFvS73iZs7?=
 =?us-ascii?Q?aZPR9WZBufIsDvWf+5Un4k+//mh52UWpw7LmXoHbZNrABtzyrYANs2WGnG4u?=
 =?us-ascii?Q?RRRMh68BnfzoskWJ5Wx5jhFqnoA1evjhqxSjXxChs21yCMpbA3CQRzwZca5w?=
 =?us-ascii?Q?tnUyf0hiQLVyJ26AbdzZ1lOMNPabOyCpWMc6pvhRA/pIWrHNc4xRxag08Eyg?=
 =?us-ascii?Q?1r6FAO/9i1eD4Uk2TLHrXplEcVCDJVJyP7OJEuaHAi+AJ9MYPnk6b/OtOdJE?=
 =?us-ascii?Q?loOEu1RxdVasdIrIL0ksyeIFlnP1on+JvLbHYeH0hijLqAC8rEtF5VV910uN?=
 =?us-ascii?Q?bemDah/rVJonKJim+SThOu8WXjVh00xCWHmC8wUPKBdBsCRpLdqM+yz0kCWz?=
 =?us-ascii?Q?T89HTQMBdmoE1TOTfSE80Yju1tD05/In+COSOlL12qcMWZLVezkYRv2I9//i?=
 =?us-ascii?Q?1xSkQd74dSdBTeQZqNVvnO/IDi7qcgVDI7JeXccTcEZyHIq38shWWeyL2FKv?=
 =?us-ascii?Q?lF2yQMgq9IJ7i78F7XewGxWBeXnn0UgdhpDwr0265XPXYMDWUkehR8kHt+HQ?=
 =?us-ascii?Q?BlzlMKMagHaPEk0WubLnF18j4rY89ssDDIEr8gbp+bg1Mwo4w7J+UUIgHr9p?=
 =?us-ascii?Q?OjFZSRk7i4sL1CdQc8tIiecCIMkg7BrnwuvgLwpZMRrM5sTV34O64In7h+8q?=
 =?us-ascii?Q?C9eFjaSz1d7C3Eoc6T0H05CgONdI3kHHcnBt7U6pxPc5g6lYauvVNVrL/Skz?=
 =?us-ascii?Q?cAmRLDChzISucYCFv7gHsqRBJrSLfHcCdgW0+HbqbHm30xBhIh8HqRpUGQ7L?=
 =?us-ascii?Q?xlDe2E8wzeuqpkIGlcAE15ATW/nsYSQ9wjSKtMslCaPqUDcZe0NQWkC0prGM?=
 =?us-ascii?Q?s5XmTINfOT9gduwHDYPMknE/jHSX3n5X7pGYu8GfSB/UAWpPWiBVarQ/kRLq?=
 =?us-ascii?Q?RW/k8tFFDvlyM5JPfRgC2qjWB1srwkCVm5/y0iBIWrQ5lXzWIZDKYnoeEpMB?=
 =?us-ascii?Q?qcRLGahHKAYk1DGA0/rQS++wuPXlHm9bSSGiAg6z5duXHjgAUneph1N1sEtj?=
 =?us-ascii?Q?bBYP2uEhPMeHyioN3dHRAmj4UUpoZ5h7Mv1Z/kwP6Bzo82zndBBFd1ACA+Z9?=
 =?us-ascii?Q?MdhE3EGi1KgnHnVaIxzggzurXAZ0kT5D8X56XqlsuVv9yg/lZ4gyuHPXns4M?=
 =?us-ascii?Q?Q4QI1kgskw6fRTwVhen55Y+3bJ3ACdIPlftbMr2dEf3xumy/4ZqnmL+5NNvY?=
 =?us-ascii?Q?KEJVq8cHuc7sn/u8ctQN2IG5Sh74+MRmS10p4hGYdfkixNGyV29vlfjlsyLG?=
 =?us-ascii?Q?yempsoQKNX4ZqxsDcqWEVZ2vcaP47bR+mQgYuxhnfQviu/bAHVVuR+TKpTQD?=
 =?us-ascii?Q?WgXX5MnDM0OFrOWEBwuu77Y1MW8Km1uzLdSXf+G0uB96JYKSsRdcfWjnRJJX?=
 =?us-ascii?Q?xNU5ZjFXWjpooQ0ozMiLRDtYqz87KrxI5vOjX/cjwUJmrb5Q5uy9u7Kccom0?=
 =?us-ascii?Q?bVqO5yFAAFnnVC8XN02H1RMh318jhG0zNzWDkT0T?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 02614332-90ef-4b52-925b-08db4c7c8ebb
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 May 2023 08:50:06.0711
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rCVgz09uKu33fDIThhC5El6fUZgptdMk0NCDjxuNMP8vKCRh+7i0TeVSPzDWDt1FWYAX1wzcPtF+ZWwUXT+gXA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR04MB7159
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Peng Fan <peng.fan@nxp.com>

With the clk names specified in clk_bypassed module parameter, give
user an option to bypass the clk from managing them by Linux kernel.

This is useful when Cortex-M33 and Cortex-A55 both running, A55 may
shutdown the clocks used by M33. Although we have mcore_booted module
parameter, but it is only for composite gate, the CCGR gate could still
be shutdown by Linux.

So let's use clk_bypassed parameter to handle clk root and clk ccgr both.

Signed-off-by: Peng Fan <peng.fan@nxp.com>
---

V1:
 Depends on: https://lore.kernel.org/all/20230504075754.372780-1-peng.fan@oss.nxp.com/

 drivers/clk/imx/clk-imx93.c | 55 +++++++++++++++++++++++++++++++++++++
 1 file changed, 55 insertions(+)

diff --git a/drivers/clk/imx/clk-imx93.c b/drivers/clk/imx/clk-imx93.c
index 07b4a043e449..88ed824ca2ff 100644
--- a/drivers/clk/imx/clk-imx93.c
+++ b/drivers/clk/imx/clk-imx93.c
@@ -255,6 +255,51 @@ static const struct imx93_clk_ccgr {
 static struct clk_hw_onecell_data *clk_hw_data;
 static struct clk_hw **clks;
 
+#define IMX_NUM_CLK_ENTRY	64
+
+static char clk_bypassed_names[SZ_512];
+static char *clk_names[IMX_NUM_CLK_ENTRY];
+
+/* The module args format as this: clk-imx93.clk_bypassed="lpi2c8_root,spdif" */
+static int imx_clk_bypass_setup(struct device *dev, char *str)
+{
+	char *pos = str, *next;
+	int i = 0;
+
+	while (pos != NULL && (next = strchr(pos, ',')) != NULL) {
+		clk_names[i++] = devm_kstrndup(dev, pos, next - pos, GFP_KERNEL);
+		pos = ++next;
+	}
+
+	clk_names[i] = devm_kstrdup(dev, pos, GFP_KERNEL);
+
+	return 0;
+}
+
+static bool imx_clk_bypass_check(char *name)
+{
+	int i;
+
+	for (i = 0; i < IMX_NUM_CLK_ENTRY; i++) {
+		if (!clk_names[i])
+			return false;
+		if (!strcmp(name, clk_names[i]))
+			return true;
+	}
+
+	return false;
+}
+
+static int imx_clk_bypass_free(struct device *dev)
+{
+	int i;
+
+	for (i = 0; i < IMX_NUM_CLK_ENTRY; i++)
+		devm_kfree(dev, clk_names[i]);
+
+	return 0;
+}
+
 static int imx93_clocks_probe(struct platform_device *pdev)
 {
 	struct device *dev = &pdev->dev;
@@ -264,6 +309,8 @@ static int imx93_clocks_probe(struct platform_device *pdev)
 	void __iomem *base, *anatop_base;
 	int i, ret;
 
+	imx_clk_bypass_setup(dev, clk_bypassed_names);
+
 	clk_hw_data = kzalloc(struct_size(clk_hw_data, hws,
 					  IMX93_CLK_END), GFP_KERNEL);
 	if (!clk_hw_data)
@@ -310,6 +357,8 @@ static int imx93_clocks_probe(struct platform_device *pdev)
 
 	for (i = 0; i < ARRAY_SIZE(root_array); i++) {
 		root = &root_array[i];
+		if (unlikely(imx_clk_bypass_check(root->name)))
+			continue;
 		clks[root->clk] = imx93_clk_composite_flags(root->name,
 							    parent_names[root->sel],
 							    4, base + root->off, 3,
@@ -318,6 +367,8 @@ static int imx93_clocks_probe(struct platform_device *pdev)
 
 	for (i = 0; i < ARRAY_SIZE(ccgr_array); i++) {
 		ccgr = &ccgr_array[i];
+		if (unlikely(imx_clk_bypass_check(ccgr->name)))
+			continue;
 		clks[ccgr->clk] = imx93_clk_gate(NULL, ccgr->name, ccgr->parent_name,
 						 ccgr->flags, base + ccgr->off, 0, 1, 1, 3,
 						 ccgr->shared_count);
@@ -341,6 +392,8 @@ static int imx93_clocks_probe(struct platform_device *pdev)
 
 	imx_register_uart_clocks();
 
+	imx_clk_bypass_free(dev);
+
 	return 0;
 
 unregister_hws:
@@ -367,6 +420,8 @@ static struct platform_driver imx93_clk_driver = {
 module_platform_driver(imx93_clk_driver);
 module_param(mcore_booted, bool, 0444);
 MODULE_PARM_DESC(mcore_booted, "See Cortex-M core is booted or not");
+module_param_string(clk_bypassed, clk_bypassed_names, SZ_512, 0444);
+MODULE_PARM_DESC(clk_bypassed, "The clks will not be managed by Linux");
 
 MODULE_DESCRIPTION("NXP i.MX93 clock driver");
 MODULE_LICENSE("GPL v2");
-- 
2.37.1

