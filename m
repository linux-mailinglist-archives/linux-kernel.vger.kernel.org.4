Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6B3F87024C2
	for <lists+linux-kernel@lfdr.de>; Mon, 15 May 2023 08:32:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239868AbjEOGch (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 May 2023 02:32:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34422 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239844AbjEOGcf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 May 2023 02:32:35 -0400
Received: from EUR01-HE1-obe.outbound.protection.outlook.com (mail-he1eur01on2054.outbound.protection.outlook.com [40.107.13.54])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E676A114
        for <linux-kernel@vger.kernel.org>; Sun, 14 May 2023 23:32:33 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XF8bQrTb59bgfcBxfRFN+NxqEasF7vESwFwmDdp8+T9786+Opeu6ca1UpFdGUCMzl3r39JBo4ytai5zT/exNo9Rf238pARzTUCCUfFaRDzzGR+35HkJ9N7L1uajwlQctqfgLaYdwRTbsGJ4e2n6173sESuUBZP/x2WvampJDPK1vcGvXnvDx2pO+JMO7L6LAXlSBHsE6DqrBvqrsvfgmkfvbrkgyQdNujTiQ2x2F5D4yUAFOAtZZYwfI1DEO3KjjPldZzYIXnsI/sqJ7d62wSJ/+Q6UAbQEfyrUHUgPiVBCT/G7Ljvfw2Br9ZVtnxAbIrt4Vwat53Y5UB1TXYq1tCA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OVSR3Z3j8fIFhQix6rGhA5lhkfFMlj6PAJG+63VNUcQ=;
 b=b7Ao0x1R+7uB8/OyF679R/tpaQEiJi+fv0mSwjp6NkcutYBich6J24cJScefowlpHU7Rkkc2M9WoeSdww9l0q/816fB6Bgv6ESawlOEclBybC2OSyD+WD+Ikl3qX0M3CfG7vMnge8FTYA7JWYMHm08LvLcFyFIUWqbqrNftXVj3vSqvxR6dnCyxpCAdr+cmsn7gQJpFLsqqxT0wEFiQFObC14gqYSODU13uerirFmIaG97NHd2EYpnuJyNzY4mNK9PMSnMHAfTF78ccIJkLvj+5T8eqtQDyGIc8Yyfmid3bJR4bgSCO2Cs9Rf0jkzWZ7LMPlVcWrfhbYPgMXkjWazQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OVSR3Z3j8fIFhQix6rGhA5lhkfFMlj6PAJG+63VNUcQ=;
 b=NNCcLvbDDYbbFsHGwJhBTlBB1j/PvLTweJYtBBzPPnzt9AxxBwIn4HM6/Goe4+Q9fZxGHbHRacEPPW6JuW5R87QerhWzL/ocgow+47a+gDvpBwbvoY0yz6v82l8Y7541Zfw8OAkc5EAHSdzcA7YeRj1AVAocZKwV6pqvdyqUThE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by AS8PR04MB8404.eurprd04.prod.outlook.com (2603:10a6:20b:3f8::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6387.30; Mon, 15 May
 2023 06:32:30 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::b999:f2c6:a8cc:7b4]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::b999:f2c6:a8cc:7b4%6]) with mapi id 15.20.6387.030; Mon, 15 May 2023
 06:32:30 +0000
From:   "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
To:     shawnguo@kernel.org, s.hauer@pengutronix.de
Cc:     kernel@pengutronix.de, festevam@gmail.com, linux-imx@nxp.com,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Peng Fan <peng.fan@nxp.com>
Subject: [PATCH V3] soc: imx: support i.MX93 soc device
Date:   Mon, 15 May 2023 14:37:30 +0800
Message-Id: <20230515063730.2042715-1-peng.fan@oss.nxp.com>
X-Mailer: git-send-email 2.37.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI1PR02CA0014.apcprd02.prod.outlook.com
 (2603:1096:4:1f7::9) To DU0PR04MB9417.eurprd04.prod.outlook.com
 (2603:10a6:10:358::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU0PR04MB9417:EE_|AS8PR04MB8404:EE_
X-MS-Office365-Filtering-Correlation-Id: 552af384-f07b-4812-64cc-08db550e287a
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: JdRuBCcnetZcTh/Og+MpKQwsn1GbfHsAZoZT8MshhP/twd5/BROiQw4LGnZvP4ZBVM0nQcY0ZdvKRHw7xuKvOj0M/EnmrOGbhZx71Lf0QU5ofcpqQFnKFE0KjWW/DqQ8PBOytMRB7/Qr62EQXMeZ0YXX0YqaP95IR2ZKS7+ly+gi1WqvkfKvoU1fLM+/BSSefckMTPcbqcIG5p39b46WG2h8p4icwbYwcXhnrgS1IJYrrE74mm85uAnNtOdUw55yQscn76wMK1JLB4iOlhL+XZxDYtrVC1x6o752kMwLTIluF5JSUeySDkup5Mjkz3lsUT6GDWGOGqaRNqXJ3pqnfSYeUPncxCazUHhZ3cfdS19U7shuyrAeIivDHEnWX6crBjkP7VQ3dTKOjepSm8ktpcsgUXi7ajazBcoLNgAtUU79KAd6DMDHHSrwjNhcZsyvb0vOYSuwHdleM4qo0yoE1z+YmXYSyACFL6sMcHm3Tlh3KEc+i+AFETpxRJynA7hXP70uFp3f3i+4FhehKJAMN4fffAQ5C0iOOM3y3ALqRnlahKLK8ooZX1usgVI5eITg0eVwh91F6aBu7747b8wxI/oRojBO16azUrq8rVNHyS9dJLS2HF5BDUhTI3JcU265
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(346002)(396003)(376002)(366004)(39860400002)(136003)(451199021)(52116002)(478600001)(66476007)(66556008)(66946007)(6486002)(86362001)(316002)(4326008)(186003)(1076003)(2616005)(38350700002)(38100700002)(5660300002)(41300700001)(2906002)(6506007)(6512007)(8676002)(8936002)(26005)(83380400001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?MxuRiCzX2x9xqgtxEd0NqHyGTDBLD1XT7Q9qCFesFAY37KBtiOuUB32BLj6F?=
 =?us-ascii?Q?lKP2R/7gf0xgxZr0ijU8vP8zOWt+F3Os+bGPAA+gp4/tOk9WzuWmwgtNuR37?=
 =?us-ascii?Q?KBj/OqeLHippMIxJo3dEPrW5kT/CReasfEMMbxGB2+pdZzcXirY5/liu5Y08?=
 =?us-ascii?Q?OtoZlIcq3lM9+HmWu/7KWzR/vKMJhruxyOYZ9gwpwdKnUN2e7OiNr29M63+6?=
 =?us-ascii?Q?q+Tpqh6+DVpYbjW0AIgyp6PSBqgtlx5qAsfjAAHkEvdNZrd2mWrbMH2uOg7N?=
 =?us-ascii?Q?lNhpy4kRo+E5/cd2habE+2zGAt9MDRNN/ErBenqKpv+O75Q6cAOH2/jaI0Cz?=
 =?us-ascii?Q?MJpWnzm/nb3GkqPwoKCyELS1OHgHX90nxr3gR00yEYatsO3nEJnVNjv0YOUA?=
 =?us-ascii?Q?L7GxI/2WivRV9fT8xsR4K783hJzG5LahtNCq+63TW1FH2d2b2FnI6tzSen4d?=
 =?us-ascii?Q?NBYGajuFC8K+AjZBip5jS701qq0MpU4y2g8mJsw7zf6Y9UCkwxJy4GylljFw?=
 =?us-ascii?Q?S2vJ4u9yJ+l2VSj4jfs90c6oLAIn7Qyq4bGqq7F+9vdr7BjuMizO1+BNVa2m?=
 =?us-ascii?Q?yRfHgHvdpAtFL5C6I2PHy9vgMu4UIra/kwHPj591Db9akYsaKR2kt9cL+9QT?=
 =?us-ascii?Q?7iWqJKq+4M0B63jEUxXhXdJmw9r2743TnDMDg5j/ltrNSYEyPlE3bi5piA4h?=
 =?us-ascii?Q?jOF9ZnCxs8Ed+Ym/IQ7F2AYV06O7WrYBCG65UDJjpHrzxWqspPSlr5RJXlOl?=
 =?us-ascii?Q?U4fi6Z57skjhNBaFhUc/L8fjwTNfDcM6fUM1u+VxUugTPV1JzcSXfCepRlTk?=
 =?us-ascii?Q?6iIZHDCq3bGE5fthuPYeMCu7vRTKgtiovT4KA4SAlMeTJGYfgq3iP9EEM8s8?=
 =?us-ascii?Q?nUkTDdMndpqSw7uGFm9uFk3RRlByMkMLxdV4eHgDSGpS21ZFIpr+kdsWTpyC?=
 =?us-ascii?Q?xy+xcZ2V8d7WiBAlqn/ZNLO5IyxTDKpckdQBM+/xot32WHDOMkBmuqYONwU0?=
 =?us-ascii?Q?u527Om5tF1GxlDtUPn7nYRLb2R48jZk/6L8imGD8PK3JLhZybwtu76l8dPOS?=
 =?us-ascii?Q?NvtI+piEpzpPJpBDGINgG9Wwv1Vr+zV8tyT+5LpVGgrxDm2FeUVOkp+t0L71?=
 =?us-ascii?Q?K0xpNyoOvXi1kGGN9SPl4Wlpk/tdUSZG3MhzgQ3Ti9Ia9eyZzzLWGGCu2F1s?=
 =?us-ascii?Q?X5jcPRTsJjmuPHp2Fo1ZjSSxKRmuKwk4gE91ipp0CqJ1k2PdTA7sTOhGA2yS?=
 =?us-ascii?Q?z3Hw3AIGVe+BZ8Vt3ccLPCP+1GML3pU6hy48GRe/HrHu6BmXeqHz1H8aoavr?=
 =?us-ascii?Q?FJDkYUxRMpr/glLKn12dgiMdm1PITHVGkf/X21lS60uRziK/CSuFsslCX331?=
 =?us-ascii?Q?k5JYdt0fvBfYeHksdo3s/j8ZarwW/XGUhhoP1wEpb19CUYN0NHC7a4ZYmK/M?=
 =?us-ascii?Q?kyyURhT4Gt0fUQgQJrHJh8Nl8IsSRYpviB1zaVVWQmDDyg5a39UtL54rgnVL?=
 =?us-ascii?Q?XkqhDlAysr5+AO1gk3kGmA5qsKqp5vzNC2pfQwavLPMht4tnZ76Rho1iqel2?=
 =?us-ascii?Q?cz5KeHT/TGoqFr2NaSBbpI8wObIhgD4MeDpj8xHA?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 552af384-f07b-4812-64cc-08db550e287a
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 May 2023 06:32:30.3247
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: FBmL6AvwlBu2hCxV/DOMeeZg1Vf2gOINf4A/3/HmS5EfEyEgn3iT3wr/tlE6UNUF75zC73MXUnzmkFfo6L5cRw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB8404
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Peng Fan <peng.fan@nxp.com>

i.MX93 Device Unique ID(UID) is in eFuse that could be read through
OCOTP Fuse Shadow Block. i.MX93 UID is 128 bits long, so introduce
soc_uid_high to indicate the higher 64bits.

The overall logic is similar as i.MX8M, so reuse soc-imx8m driver
for i.MX93.

Signed-off-by: Peng Fan <peng.fan@nxp.com>
---

V3:
 Update commit log
 Drop uneeded {}

V2:
 The ocotp yaml has got R-b from DT maintainer

 drivers/soc/imx/Makefile    |  2 +-
 drivers/soc/imx/soc-imx8m.c | 63 ++++++++++++++++++++++++++++++++++++-
 2 files changed, 63 insertions(+), 2 deletions(-)

diff --git a/drivers/soc/imx/Makefile b/drivers/soc/imx/Makefile
index a28c44a1f16a..83aff181ae51 100644
--- a/drivers/soc/imx/Makefile
+++ b/drivers/soc/imx/Makefile
@@ -7,5 +7,5 @@ obj-$(CONFIG_IMX_GPCV2_PM_DOMAINS) += gpcv2.o
 obj-$(CONFIG_SOC_IMX8M) += soc-imx8m.o
 obj-$(CONFIG_IMX8M_BLK_CTRL) += imx8m-blk-ctrl.o
 obj-$(CONFIG_IMX8M_BLK_CTRL) += imx8mp-blk-ctrl.o
-obj-$(CONFIG_SOC_IMX9) += imx93-src.o imx93-pd.o
+obj-$(CONFIG_SOC_IMX9) += soc-imx8m.o imx93-src.o imx93-pd.o
 obj-$(CONFIG_IMX9_BLK_CTRL) += imx93-blk-ctrl.o
diff --git a/drivers/soc/imx/soc-imx8m.c b/drivers/soc/imx/soc-imx8m.c
index 1dcd243df567..6723ac6c0f04 100644
--- a/drivers/soc/imx/soc-imx8m.c
+++ b/drivers/soc/imx/soc-imx8m.c
@@ -25,8 +25,11 @@
 
 #define IMX8MP_OCOTP_UID_OFFSET		0x10
 
+#define IMX93_OCOTP_UID_OFFSET		0x80c0
+
 /* Same as ANADIG_DIGPROG_IMX7D */
 #define ANADIG_DIGPROG_IMX8MM	0x800
+#define ANADIG_DIGPROG_IMX93	0x800
 
 struct imx8_soc_data {
 	char *name;
@@ -34,6 +37,7 @@ struct imx8_soc_data {
 };
 
 static u64 soc_uid;
+static u64 soc_uid_h;
 
 #ifdef CONFIG_HAVE_ARM_SMCCC
 static u32 imx8mq_soc_revision_from_atf(void)
@@ -141,6 +145,53 @@ static u32 __init imx8mm_soc_revision(void)
 	return rev;
 }
 
+static void __init imx93_soc_uid(void)
+{
+	void __iomem *ocotp_base;
+	struct device_node *np;
+
+	np = of_find_compatible_node(NULL, NULL, "fsl,imx93-ocotp");
+	if (!np)
+		return;
+
+	ocotp_base = of_iomap(np, 0);
+	WARN_ON(!ocotp_base);
+
+	soc_uid = readl_relaxed(ocotp_base + IMX93_OCOTP_UID_OFFSET + 0x8);
+	soc_uid <<= 32;
+	soc_uid |= readl_relaxed(ocotp_base + IMX93_OCOTP_UID_OFFSET + 0xC);
+
+	soc_uid_h = readl_relaxed(ocotp_base + IMX93_OCOTP_UID_OFFSET + 0x0);
+	soc_uid_h <<= 32;
+	soc_uid_h |= readl_relaxed(ocotp_base + IMX93_OCOTP_UID_OFFSET + 0x4);
+
+	iounmap(ocotp_base);
+	of_node_put(np);
+}
+
+static u32 __init imx93_soc_revision(void)
+{
+	struct device_node *np;
+	void __iomem *anatop_base;
+	u32 rev;
+
+	np = of_find_compatible_node(NULL, NULL, "fsl,imx93-anatop");
+	if (!np)
+		return 0;
+
+	anatop_base = of_iomap(np, 0);
+	WARN_ON(!anatop_base);
+
+	rev = readl_relaxed(anatop_base + ANADIG_DIGPROG_IMX93);
+
+	iounmap(anatop_base);
+	of_node_put(np);
+
+	imx93_soc_uid();
+
+	return rev;
+}
+
 static const struct imx8_soc_data imx8mq_soc_data = {
 	.name = "i.MX8MQ",
 	.soc_revision = imx8mq_soc_revision,
@@ -161,11 +212,17 @@ static const struct imx8_soc_data imx8mp_soc_data = {
 	.soc_revision = imx8mm_soc_revision,
 };
 
+static const struct imx8_soc_data imx93_soc_data = {
+	.name = "i.MX93",
+	.soc_revision = imx93_soc_revision,
+};
+
 static __maybe_unused const struct of_device_id imx8_soc_match[] = {
 	{ .compatible = "fsl,imx8mq", .data = &imx8mq_soc_data, },
 	{ .compatible = "fsl,imx8mm", .data = &imx8mm_soc_data, },
 	{ .compatible = "fsl,imx8mn", .data = &imx8mn_soc_data, },
 	{ .compatible = "fsl,imx8mp", .data = &imx8mp_soc_data, },
+	{ .compatible = "fsl,imx93", .data = &imx93_soc_data, },
 	{ }
 };
 
@@ -212,7 +269,11 @@ static int __init imx8_soc_init(void)
 		goto free_soc;
 	}
 
-	soc_dev_attr->serial_number = kasprintf(GFP_KERNEL, "%016llX", soc_uid);
+	if (soc_uid_h)
+		soc_dev_attr->serial_number = kasprintf(GFP_KERNEL, "%016llX%016llX",
+							soc_uid_h, soc_uid);
+	else
+		soc_dev_attr->serial_number = kasprintf(GFP_KERNEL, "%016llX", soc_uid);
 	if (!soc_dev_attr->serial_number) {
 		ret = -ENOMEM;
 		goto free_rev;
-- 
2.37.1

