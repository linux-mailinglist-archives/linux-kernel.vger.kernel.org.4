Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2E90D5B6A95
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Sep 2022 11:20:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231494AbiIMJUg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Sep 2022 05:20:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50104 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231504AbiIMJUW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Sep 2022 05:20:22 -0400
Received: from EUR02-AM5-obe.outbound.protection.outlook.com (mail-eopbgr00086.outbound.protection.outlook.com [40.107.0.86])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 58BDE140ED;
        Tue, 13 Sep 2022 02:20:17 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lcR8qRX9cboFIntIdwSMpMclqcL42ZXF5RkNTmOCmaN3Os9rvX182H12AEJ85aMAr5cm9rmT8B1yLoFygvp1jF/TXJ4HhoJG7xNvQut7qT2DeOPRwWNcFRfcAgFSuxu4C/nt4E2/7XMhxQPrwpzH5ZPrhzvhew8JfibsKx/Wl8ql8S7WnE5uP1PQvZC6kPDgabJ1qdvAP5g/fmNpIDIEexd/ORjaUbp0oSaXzaAuc8iscfAjaXLki0a60mO4fgotDxvwqakqd1g2zOiUnIx7ns+krO8WKj6uapAiaEDLyr/qRcAwHKxTo1c6k1O099boOJ9wb0AkR7iaCZwxsxJQyQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=j4QM7D56dZ4kz0so4FBj4tyzvvOCv48uVsyc/uaZbUI=;
 b=Ewk82fprIB8AdOVFedEveb3nCpeVgvd4grSZjl/PSZTEvXr4+H2mx7Z34XVU1jiPh4R8j8N/kbgHjVZrK4lzvsxmNTkyz9GYnyTaoptWnhbev1UVQLBbKSIrmFqup5H+o+BbLs2Qmj8Mxo3avckj10B2JjT95A9l0OocJ4jAzhmDXUJ2ALJw7wAqmJpwwbO6T7Qay157m5H3ux+WRoqIDUEY7dMvvf9DJGKPiURNcEcqkYwNOsq1K70d2DdGYbyTKoUC63p9DYKD4zPWBJyThCslEQM8sZ4XALgb//4nHr1a/kdMP2UDclHDXGMyxL0AXIRHAU1biZwEG62E6eUQhA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=j4QM7D56dZ4kz0so4FBj4tyzvvOCv48uVsyc/uaZbUI=;
 b=MlYG6R8JEiF4ImZZadArZgucXgcVR2hBxRhEm461mDz2EVNtlme/zSKrRp6C3L39dGZE960vBsEbgJGP0Xa1X+yhD0wDWsO/AyQ/aioUTo0sOlaCV1GekYutypMa6zV2ZPp6S5dTW6b/aEzAsx/ZVglsUErRIMOz1Reuhcge7f8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by AM8PR04MB7234.eurprd04.prod.outlook.com (2603:10a6:20b:1dd::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5612.22; Tue, 13 Sep
 2022 09:20:13 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::75b7:64ed:bc9e:5354]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::75b7:64ed:bc9e:5354%5]) with mapi id 15.20.5612.022; Tue, 13 Sep 2022
 09:20:13 +0000
From:   "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
To:     krzysztof.kozlowski+dt@linaro.org, robh+dt@kernel.org,
        abelvesa@kernel.org, abel.vesa@linaro.org, mturquette@baylibre.com,
        sboyd@kernel.org, shawnguo@kernel.org, s.hauer@pengutronix.de,
        kernel@pengutronix.de, festevam@gmail.com
Cc:     linux-imx@nxp.com, linux-clk@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Peng Fan <peng.fan@nxp.com>
Subject: [PATCH V3 2/2] clk: imx: support fsl,always-on-clocks
Date:   Tue, 13 Sep 2022 17:21:36 +0800
Message-Id: <20220913092136.1706263-3-peng.fan@oss.nxp.com>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20220913092136.1706263-1-peng.fan@oss.nxp.com>
References: <20220913092136.1706263-1-peng.fan@oss.nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2P153CA0018.APCP153.PROD.OUTLOOK.COM (2603:1096:4:140::9)
 To DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU0PR04MB9417:EE_|AM8PR04MB7234:EE_
X-MS-Office365-Filtering-Correlation-Id: ba73bee6-ee28-4cba-a602-08da956929ca
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: pBz4lPnzMCK5eCA5Y+S2DIGN3BUaSZvcn+jjgr8oWv2LpU/tVxYzMZ04cs3IcmNyBGqyY3xk6B+/6jKvDcGGZRwGICdMbQW4ZuHMpX0upT0vAiAi/EjYEs7gPXMi7wLILl8WOSgRTshLgjH4Lna1EyNWP4QDie6XNpmJ/1bUVOFa4Bpm9vszoq7b/F5LLU0gqeJYEmmox/4ziedrKK4pLwylDYgD602hsIL9E2dDusiWqlFXurTru3IsdaaSWJdy7rZBg7LQvfmH73lWRIp5z5ZNn7sj3AKd3p4h8RGK2FNjC7nuZbSD1gNagY3sNOad84UonrOE+yff4xgdTcAruSrbX0UzIo4LfwYjFIdzwzAE0Co2p5jv9sjyzCilJK8c/iLiLgxTRsH6wCmPbGCw7ylLPJPK3fIkqEbc2BY8+s8WQKdcTymAdcckVYjWRyGgqpLjk/jtJwDjjb2YHzmTu7zXH2J3WAkbAc0T20Au/ziocwyYxKOZLU7VawAc9EfleIC0AelCFfiEIrhHbw8Clww2GkYPDVslVodUTCRTVCtpMLuJQ1zSRyRjRJcA8j+b1CtbV7xE8qPElBgkxOM2inOQ38zHrqM4QaI9jB9ecGBx+IznN+omzZmOjsIqdO0Mn71qBVN6REh2tsHmaZpEx+Mq6/mC2Z2Ogo4bu2Px4PmpsN0psPW1+krcnMT68/mDlxf02kLuulKVkABX4POxPPj7z6BibCuOUZrPFrd1zse96S6A2wdObQLK+dP/GjSN/NE+FF4DtHvkba8xxZpHf1cJR46zzdpkgSRCBVPyny4=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(396003)(39860400002)(136003)(376002)(366004)(346002)(451199015)(8936002)(6512007)(26005)(66476007)(921005)(86362001)(2906002)(41300700001)(38100700002)(2616005)(66946007)(478600001)(6506007)(6666004)(6486002)(66556008)(186003)(8676002)(38350700002)(83380400001)(52116002)(1076003)(5660300002)(316002)(4326008)(7416002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?sbGIRRgPOnttNUWmO/XzeXOxx7U8rvgy4Zg/N5lIVm1r2jgdZFPrDGPxJRv3?=
 =?us-ascii?Q?w+qcidoXmKPkc/hcenAnsAcMfEx8k4+jrW6zk/PjD+MO8DI7M5eC+RmC4f/3?=
 =?us-ascii?Q?o2w6wcmV1sVC1ogHBK35A9fC3yXEu2K39FuKVxgBQZNDb52iFOYBOb3LJD8T?=
 =?us-ascii?Q?cvJtftlAUSRrfhbgjPvZr52+JjQ3nS59yLv9ggziZpCTNm2BP+eDptU7Pd1V?=
 =?us-ascii?Q?xvPW7Nk6nljiccYr2bNNqAn3Di5Sng5DmuueStiiozTfbc4y1zp70pR5G/Ds?=
 =?us-ascii?Q?/Jsw6mCkFvpXmctwceJke7xtSFpmCDQUruw2TzfY6BPFMkLlH1ny7v1Wll7P?=
 =?us-ascii?Q?EwwN5Z82W5PC/ECS+4Be/ACjgAgeiuf2Ti7KIBheXbROlye1dtlBabsnMh6z?=
 =?us-ascii?Q?HoLNN5JmnKiqsjH6P/w65yyA1Iz5zDOD+m34tmJavB3GJp16R2JdWFt4BEaH?=
 =?us-ascii?Q?p8Rnl1N9zuQlk2oE4sbErR96DzZ6v5WaUcdxmdCQp+affroRbTpl8nSHi8XG?=
 =?us-ascii?Q?d0F/qsxsVtBPvd+ZAWYgK82LVZ6WM1P1r/6nncg/D9ZZbIuuBzJujcZCuHQF?=
 =?us-ascii?Q?OhlUthpSx/pTiFOdoWe6xhxFa78tE1//Ex1CCq33fFDLoJK9OpbIH1BLiw6O?=
 =?us-ascii?Q?P+p6BpdrHbLW1h6H+pGeJpVkuRkUeBUnt6N1GpqWgrqpkKNe2mBu4iVLkrGE?=
 =?us-ascii?Q?SkL3qVjywFe6VncwuEVyHy8psTExGJO4U983yUxoGbYhLVWgCgtbk+6jzIk7?=
 =?us-ascii?Q?WGR9oxdeXYoQY4EisRdONt4zYEHpT6vUPoaY8j5lKRQt0WvvJ+lA8qH6mVFi?=
 =?us-ascii?Q?5HgmGGWA7mbAiPm9iVBNG7K47AbLGHdvh1oI4hSMQ58DrW13/ZZAykTy3/F5?=
 =?us-ascii?Q?tg+7DDN3RuQSLr30G1OS4UxcUXjpIXsSW8lsN4gud6IKdr0qA900kmIMYJE2?=
 =?us-ascii?Q?RduoucWikbDrCyKBRH7DOmfuFh6wITA0xaGbiD5pTJtU1GCtZwugWi15AgYJ?=
 =?us-ascii?Q?gR2ROcLb7U1jKI3O5O0pnVG4f1WGIkdd7AWFhVsfa/7RC1ee0Rq6ISCA1zz+?=
 =?us-ascii?Q?8DliDbsJ9TqYVlIFu7BnQ6Ghn/9Bu3EAqfQMO5BVm3KUglg0bSTavDErJKAN?=
 =?us-ascii?Q?YNWM8DAV+QTP+i5Z3TGvHzTQ1RnCrhwhC6YbihvRkYRqHGWYsImEiCicLHlH?=
 =?us-ascii?Q?4YyFuADf5uonrocLJJcL7M455tD7cIAouyrOwFMHrnUo4qb9l6S6bzDFAPvi?=
 =?us-ascii?Q?wU71sduj9vOkUg7rNe6FDbMG5P7vKtglbT5u1KukmQND33wohFGU9FMiNMyi?=
 =?us-ascii?Q?jEyyBhgQfVXmao4smYur5v10SUwSG5qygeRazXSsNhsjuApHyJhXcnxcHvww?=
 =?us-ascii?Q?pyv4AgkQRKx0D4X2Wo/SkB1hAzbMv7InWyE4HJGl4I/S39Ks9z4jjnaRBmAP?=
 =?us-ascii?Q?gytFQ25lPwdjAwpejP/lL4lyZKUrsMhVk70nAQNPZLwsuY+lidp1bwMyDpEY?=
 =?us-ascii?Q?3Iw5YmtT8/Ripfar3nw1sD7ELWlt1NmkZ0ruZiENV19JoqRh5f+fZysr3nJ9?=
 =?us-ascii?Q?n88UAyCNCcO1dnoGukRjmE32xTlsqR/uyoIq2X1K?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ba73bee6-ee28-4cba-a602-08da956929ca
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Sep 2022 09:20:13.3316
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9EjPvFsrbBOs2XxRsqXIi6CCNEap9fy2EJDpn/Mc8hg21nKAr8B9HyYtSGy4xt9bCNf4/u9z8C1N3u4gq15Dzw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM8PR04MB7234
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Peng Fan <peng.fan@nxp.com>

For the clocks listed in fsl,always-on-clocks, enable them to avoid
Linux disable them. This will benifit root Linux and inmate cell run
on top of Jailhouse hypervisor.

Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 drivers/clk/imx/clk-imx8mm.c |  2 ++
 drivers/clk/imx/clk-imx8mn.c |  2 ++
 drivers/clk/imx/clk-imx8mp.c |  2 ++
 drivers/clk/imx/clk-imx8mq.c |  2 ++
 drivers/clk/imx/clk.c        | 21 +++++++++++++++++++++
 drivers/clk/imx/clk.h        |  2 ++
 6 files changed, 31 insertions(+)

diff --git a/drivers/clk/imx/clk-imx8mm.c b/drivers/clk/imx/clk-imx8mm.c
index aa58b2995610..d1e4d0d3c41b 100644
--- a/drivers/clk/imx/clk-imx8mm.c
+++ b/drivers/clk/imx/clk-imx8mm.c
@@ -611,6 +611,8 @@ static int imx8mm_clocks_probe(struct platform_device *pdev)
 
 	imx_register_uart_clocks(4);
 
+	imx_clk_always_on(dev, hws);
+
 	return 0;
 
 unregister_hws:
diff --git a/drivers/clk/imx/clk-imx8mn.c b/drivers/clk/imx/clk-imx8mn.c
index 79fabc0606b0..422b535013de 100644
--- a/drivers/clk/imx/clk-imx8mn.c
+++ b/drivers/clk/imx/clk-imx8mn.c
@@ -605,6 +605,8 @@ static int imx8mn_clocks_probe(struct platform_device *pdev)
 
 	imx_register_uart_clocks(4);
 
+	imx_clk_always_on(dev, hws);
+
 	return 0;
 
 unregister_hws:
diff --git a/drivers/clk/imx/clk-imx8mp.c b/drivers/clk/imx/clk-imx8mp.c
index 4297af85ab09..ff043fa0299d 100644
--- a/drivers/clk/imx/clk-imx8mp.c
+++ b/drivers/clk/imx/clk-imx8mp.c
@@ -714,6 +714,8 @@ static int imx8mp_clocks_probe(struct platform_device *pdev)
 
 	imx_register_uart_clocks(4);
 
+	imx_clk_always_on(dev, hws);
+
 	return 0;
 }
 
diff --git a/drivers/clk/imx/clk-imx8mq.c b/drivers/clk/imx/clk-imx8mq.c
index 882dcad4817d..6eec3bbcde6f 100644
--- a/drivers/clk/imx/clk-imx8mq.c
+++ b/drivers/clk/imx/clk-imx8mq.c
@@ -603,6 +603,8 @@ static int imx8mq_clocks_probe(struct platform_device *pdev)
 
 	imx_register_uart_clocks(4);
 
+	imx_clk_always_on(dev, hws);
+
 	return 0;
 
 unregister_hws:
diff --git a/drivers/clk/imx/clk.c b/drivers/clk/imx/clk.c
index 5582f18dd632..75876c81882c 100644
--- a/drivers/clk/imx/clk.c
+++ b/drivers/clk/imx/clk.c
@@ -2,6 +2,7 @@
 #include <linux/bits.h>
 #include <linux/clk.h>
 #include <linux/clk-provider.h>
+#include <linux/device.h>
 #include <linux/err.h>
 #include <linux/io.h>
 #include <linux/module.h>
@@ -214,4 +215,24 @@ static int __init imx_clk_disable_uart(void)
 late_initcall_sync(imx_clk_disable_uart);
 #endif
 
+int imx_clk_always_on(struct device *dev, struct clk_hw * const clks[])
+{
+	struct device_node *np = dev->of_node;
+	struct property *prop;
+	const __be32 *p;
+	u32 i;
+	int ret;
+
+	of_property_for_each_u32(np, "fsl,always-on-clocks", prop, p, i) {
+		ret = clk_prepare_enable(clks[i]->clk);
+		if (ret) {
+			dev_err(dev, "failed to enable %s\n", clk_hw_get_name(clks[i]));
+			return ret;
+		}
+	}
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(imx_clk_always_on);
+
 MODULE_LICENSE("GPL v2");
diff --git a/drivers/clk/imx/clk.h b/drivers/clk/imx/clk.h
index dd49f90110e8..591d72ea4d31 100644
--- a/drivers/clk/imx/clk.h
+++ b/drivers/clk/imx/clk.h
@@ -22,6 +22,8 @@ void imx_mmdc_mask_handshake(void __iomem *ccm_base, unsigned int chn);
 void imx_unregister_clocks(struct clk *clks[], unsigned int count);
 void imx_unregister_hw_clocks(struct clk_hw *hws[], unsigned int count);
 
+int imx_clk_always_on(struct device *dev, struct clk_hw * const clks[]);
+
 extern void imx_cscmr1_fixup(u32 *val);
 
 enum imx_pllv1_type {
-- 
2.37.1

