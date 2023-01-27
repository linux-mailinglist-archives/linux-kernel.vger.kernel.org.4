Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9E81B67DFF8
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Jan 2023 10:22:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231542AbjA0JWm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Jan 2023 04:22:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36886 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231741AbjA0JWk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Jan 2023 04:22:40 -0500
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2043.outbound.protection.outlook.com [40.107.21.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 75CB677DDE;
        Fri, 27 Jan 2023 01:22:11 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MVMU7i2hQb0ckzV7kvsVtyPUeP8tIy3HUU/QeeBO/d1mcgrg8ooN+WYsd1Z+ZF0161GY0/Q2wpwcIEV4JDIWk0NohgWnXwtHri2sgCNbD0c0Of4fVTEteo/yTbLJzve1dDviGYJB+eAPhmGTxmWVvMTdllJEX9UyUE6MEnzRBTcJ8HjASUwpJORXfgKQww6XouSPU1AnG8Gz/VLP6tO6qtkTVL2ERxUtl9NoAUUh8t2BVmUhXg/cRyj40JMFj+TMqLk6Ve5rAMm8FUNAem8KcV05JH7ocS7Kqx8lYIyqaEoD6sQ+aUvmA7VZDC42XB/Qa2O9pnF8Bv3bTrqzpG5hjA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jQ6L8GQqTrzRnzvB6FhAoAmcEsPzQfNPTTf/AGaPakM=;
 b=NF04qRg5QeHRRZ9P3z5fxTlc0+y5gsJmA3lSpexHxXfnbMa8OEIK4BWgXDVP9kSBR2xFgtbNfmf+3aUr114u4pup35T6bo3TwJ6+JW3awO7H5Du2eqZWNxRypcwyt1anjH44HMnB4NwzgejXzyxB0N2QK4r7bbU4DdzIdLpskg76J1EuwXRjrQ/B/Utto9+ekjIfx5Y3UIGzX44TpcST3xwwFrKy6wn1BeMTyg1gg3Jgmt5c4mdKM4Y1g6rq/xKBuk/MCms+tp/eIKryf8RzalosPQqlMHu3Wel/J7pdj6CTsU7p1H6i3BYH2cPTpvrh6wESwGXk42h9SqXpnMvv7g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jQ6L8GQqTrzRnzvB6FhAoAmcEsPzQfNPTTf/AGaPakM=;
 b=P+OKp+weLI3b4f1uL4ybXIDTfDnQCSDyS411+xY/5Vsf0ir7HwYBKN8ivgZUXtw/M+sI7oCx/if49EKM//mcQdWMhsc9srOaffaIjrlxlsrhSOMSoI4lh6Oa/4s6PsR6YDWe7jMJ7DBFjdT52R8FtCMCdpdbYjkgwOnEXW/Mw7k=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by DBBPR04MB7530.eurprd04.prod.outlook.com (2603:10a6:10:1f5::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6043.22; Fri, 27 Jan
 2023 09:21:49 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::e203:47be:36e4:c0c3]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::e203:47be:36e4:c0c3%9]) with mapi id 15.20.6002.033; Fri, 27 Jan 2023
 09:21:49 +0000
From:   "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
To:     andersson@kernel.org, mathieu.poirier@linaro.org,
        shawnguo@kernel.org, s.hauer@pengutronix.de,
        arnaud.pouliquen@foss.st.com
Cc:     kernel@pengutronix.de, festevam@gmail.com, linux-imx@nxp.com,
        linux-remoteproc@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Peng Fan <peng.fan@nxp.com>
Subject: [PATCH V2 5/6] remoteproc: imx_rproc: set Cortex-M stack/pc to TCML
Date:   Fri, 27 Jan 2023 17:22:45 +0800
Message-Id: <20230127092246.1470865-6-peng.fan@oss.nxp.com>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20230127092246.1470865-1-peng.fan@oss.nxp.com>
References: <20230127092246.1470865-1-peng.fan@oss.nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR02CA0019.apcprd02.prod.outlook.com
 (2603:1096:4:195::13) To DU0PR04MB9417.eurprd04.prod.outlook.com
 (2603:10a6:10:358::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU0PR04MB9417:EE_|DBBPR04MB7530:EE_
X-MS-Office365-Filtering-Correlation-Id: 3647e098-5aa6-4d4c-5892-08db0047eb47
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: q4LtB36+6O8Pwfm9VfGRNH5LQzB5bHrt3LTWclnrOB93BFi63pxbvbPH+DdE5y7f+Vs5ArdWGtlDOrk4+cPV7x5t9ESh2ZzDshwtc1aIvdZHiceGIScx14DuyLg1KZNmrQzheYz+zvV3xRujBjvheaeEiMLlfs3d1CC6jYUIUJ18lMR42SPcDc7ZLn7nPA/A26B39X2O8f0jojAqDPf16Sk0I364HokWVKk4mn+DkaWdDEDp4s4cbVnwOXJ1l3DBcgONMu2jkhmSPtSnL3ED+geNSky7TtQ9WWMCgDQgJguFMXjw74gd10Edy6HuL1N0YCheabFgaYoe1uRjbLB81JUsikJdzAxDSicAsAH6p5QkNtVkVvLtZ1TMZ3MxducIfW6m6npHez4nqzasjYVPxd0mk7X4F5dFclZj/m/HMRj1Mii0mEOTLqAldKlmJSWICVavRVIGtU6KbnL2t25V3ef9cD25nQAFrD07MMgNjNMqwDCL9tmqP47YUlgphg4Ybd2qXyR/9jiKWmnjJHSZBsHMxiWvcJGdSQBap6OLYv+OGbLZ0Eyly7NRRgGrtbTOVsWM/pQPucTokAKEOT2mwCU1/x6v5MX2c/2lnd62JdfSmIUZ3QW//go1tMOIIvn7WeEgNeAJWZ5t1+qrx5fwNYwSi3W1WVbZF05SaOVa9y1dZ1YdWPKgyIPia4KYVQhsTZAChkKZ3ymULS7f46kDNg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(376002)(136003)(396003)(39860400002)(366004)(346002)(451199018)(38100700002)(1076003)(2616005)(8936002)(38350700002)(2906002)(316002)(52116002)(41300700001)(6486002)(478600001)(86362001)(83380400001)(6512007)(186003)(26005)(6666004)(6506007)(7416002)(8676002)(66946007)(5660300002)(66476007)(4326008)(66556008);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?1ETzwjPonV3JU1z1eD6NKCa7HcAeb4lm64qlbFVq8qarQ23elhybyXK1I6Nh?=
 =?us-ascii?Q?RGbhRPzbY2igmwY5O8yUWu/48HggP43qFa6aKSuwURG7+I+6DuoUJFppsqC4?=
 =?us-ascii?Q?fwV0Yr8AB3QpG50cTQtGCz3qxqF3AjipPQ2oKMO4BhnqhlToVmvLbENAPppF?=
 =?us-ascii?Q?gtYJNUELmVqz6lpMo2z5Y5lfBEfDmowEFEZ+x6EZzOMKCkkcD44yZMOcglhE?=
 =?us-ascii?Q?BVcK1NsPJZb+j2hhmYPESxaRlEIhNJzMUpHdxYhomrFAw0ZkuOFcfLAu4CNl?=
 =?us-ascii?Q?WPCqA8BgeSKeC92CJkVucF+xvR6Sr7zJOtoOBqoOd5NcQsjPKrU/b6KdZNMS?=
 =?us-ascii?Q?lle+NO6Oujf+9XwCPv9APSApDzSLQpp4LOUTmJsMjZZsV5tOL364WdF8zs3V?=
 =?us-ascii?Q?PlawMLuQ4LWvLXdHMOjVKvs/yvkiBt8qyLGiXAAtoR9zN8406Qxhw+MzJU84?=
 =?us-ascii?Q?c36PF0ir38dGt/FDAWEG3UXuI7yXm+0qtcBRdJatG/HE2nVD1ieEJzu/2Bac?=
 =?us-ascii?Q?bNXI/y0Fi+vvZjIy/HwJ9CxRIdgMqJS5Jz0IYDz6xosIeiZVwH7ljAr+CkBK?=
 =?us-ascii?Q?6xvaPMw0736hXD41g3iY1cl9cY51hBM0KqzlRG95gRgMBYLwvjfcVYrTMaPj?=
 =?us-ascii?Q?6vKVpuu7uLcBqhtuAT63tEoEYu28HbzRrmHm0rwzni9+DgGTzfe73Vsz0XVy?=
 =?us-ascii?Q?EOMbf3cd8NsieTxJ20ka/HZ0Q2n5XWT2LUfprs5SBePGfctMqz//EXLS/+sp?=
 =?us-ascii?Q?vvqfxPUzAC7x+uAEjjz0brqdk2pgZUSmSa6fudSru11Z7aGrmIoUy8Gbmg4h?=
 =?us-ascii?Q?DFIQDjmAOvTYU8g2sdhKbEGuD6dKoNKAKNwvyrqaViqIQg+3fKRRZ3ENzMST?=
 =?us-ascii?Q?qGek6IXHYYFJpopaok/VbKivNSH9nWGx/ljpaEpQRepipHOGMeVWelIRqYB5?=
 =?us-ascii?Q?X1TiBzdkqnyZNr5Lb/7HsSIaI3/ZUKlXBBppKNQUa6QNgxzMHhibdnptWWTq?=
 =?us-ascii?Q?4IrJry43R0gumSKaiy28dSvXNPj4DBJzcdVUDh2f7xeWIvOuuz7dt6fh4eR+?=
 =?us-ascii?Q?tJjgRyA8umXaXYeLa29mCYSTc+5LMt209fLk2xMC/mhJOgUJ2XTXs0kIUuU+?=
 =?us-ascii?Q?6FccrbwOxx/c/PgPpcFCCI46os13v1CAuMg3d462pujJAoFcbZuOiVZ2xfwc?=
 =?us-ascii?Q?KUZ0y2gSIM1VNIqDJq9jCbzmI12PCE5wBLL9nwqK1k72MLusl/udGQBI/NH0?=
 =?us-ascii?Q?6pf7G6hsA/JlJHe05PrJxMZ2tTbT6qAWkBW5KzOsu4e/3YChYUxEOXfhmtS6?=
 =?us-ascii?Q?7eIQ5vcskwv9uc5OuJoXxt9jsIiYLSviqRp4+rl7cqab/meFdQyFQZXatlRE?=
 =?us-ascii?Q?TIiSODPRle4KWbVdPsdMBPLo29tg1t354yD75jscyDZtAXByMB7hzyher8KJ?=
 =?us-ascii?Q?2sF6ctlXLSVv356HhkUG2VDrQbf6ObdTuJMhVM3EFGdD/vVodwh0zl6HynoS?=
 =?us-ascii?Q?3MgS1LUtCjb/JveN376LWuUaFuNqMIJK7zNN+Kl16FDV+LRLcfjJCL7mbNp8?=
 =?us-ascii?Q?VAinNmGXpRYJPkTzmkdO8kEQO6a91d3mWtsecKny?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3647e098-5aa6-4d4c-5892-08db0047eb47
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jan 2023 09:21:49.6805
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2pSMr1rz46dsQMNH2G8WwyDHUZ0ntZBNFPcO5G01fVlxwqfnyYvEN8UVI4Z4g7HboPGr7blbzL3g+4LnCyjZrQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBBPR04MB7530
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Peng Fan <peng.fan@nxp.com>

The i.MX8M Cortex-M core not has ROM. It has a requirement is
the stack, pc value should be set in address 0 and 4 from the view of
itself. From Cortex-A core view, the region is at TCML start address.

The stack and pc value are the first two words stored in section
".interrupts" of the firmware, and the section is the first section in
the firmware.

When the firmware is built to run in TCML, there is no issue, because
when copying elf segments, the first two words are copied to TCML also.

However when the firmware is built ro run in DDR, the first two words
are not copied to TCML start address.

This patch is to find the ".interrupts" section, read out the first
two words and write to TCML start address at offset 0 and 4.

Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 drivers/remoteproc/imx_rproc.c | 37 +++++++++++++++++++++++++++++++++-
 1 file changed, 36 insertions(+), 1 deletion(-)

diff --git a/drivers/remoteproc/imx_rproc.c b/drivers/remoteproc/imx_rproc.c
index 295e0e0e869a..f5ee0c9bb09d 100644
--- a/drivers/remoteproc/imx_rproc.c
+++ b/drivers/remoteproc/imx_rproc.c
@@ -7,6 +7,7 @@
 #include <linux/arm-smccc.h>
 #include <linux/clk.h>
 #include <linux/err.h>
+#include <linux/firmware.h>
 #include <linux/firmware/imx/sci.h>
 #include <linux/interrupt.h>
 #include <linux/kernel.h>
@@ -23,6 +24,7 @@
 #include <linux/workqueue.h>
 
 #include "imx_rproc.h"
+#include "remoteproc_elf_helpers.h"
 #include "remoteproc_internal.h"
 
 #define IMX7D_SRC_SCR			0x0C
@@ -634,6 +636,39 @@ static struct resource_table *imx_rproc_get_loaded_rsc_table(struct rproc *rproc
 	return (struct resource_table __force *)priv->rsc_table;
 }
 
+static u64 imx_rproc_get_boot_addr(struct rproc *rproc, const struct firmware *fw)
+{
+	struct imx_rproc *priv = rproc->priv;
+	const u8 *elf_data = (void *)fw->data;
+	u8 class = fw_elf_get_class(fw);
+	u64 bootaddr = rproc_elf_get_boot_addr(rproc, fw);
+	const void *shdr;
+	void __iomem *va;
+	u64 sh_addr, offset;
+
+	if (priv->dcfg->devtype == IMX_RPROC_IMX8M) {
+		/*
+		 * i.MX8M Cortex-M requires [stack, pc] be put in address
+		 * [0, 4], so the da address is 0, size is 8 words.
+		 */
+		va = (__force void __iomem *)rproc_da_to_va(rproc, 0, 8, NULL);
+		shdr = rproc_elf_find_shdr(rproc, fw, ".interrupts");
+		if (!shdr || !va)
+			return bootaddr;
+		sh_addr = elf_shdr_get_sh_addr(class, shdr);
+		offset = elf_shdr_get_sh_offset(class, shdr);
+
+		/*
+		 * Write stack, pc to TCML start address. The TCML region
+		 * is marked with ATT_IOMEM, so use writel.
+		 */
+		writel(*(u32 *)(elf_data + offset), va);
+		writel(*(u32 *)(elf_data + offset + 4), va + 4);
+	}
+
+	return bootaddr;
+}
+
 static const struct rproc_ops imx_rproc_ops = {
 	.prepare	= imx_rproc_prepare,
 	.attach		= imx_rproc_attach,
@@ -647,7 +682,7 @@ static const struct rproc_ops imx_rproc_ops = {
 	.find_loaded_rsc_table = rproc_elf_find_loaded_rsc_table,
 	.get_loaded_rsc_table = imx_rproc_get_loaded_rsc_table,
 	.sanity_check	= rproc_elf_sanity_check,
-	.get_boot_addr	= rproc_elf_get_boot_addr,
+	.get_boot_addr	= imx_rproc_get_boot_addr,
 };
 
 static int imx_rproc_addr_init(struct imx_rproc *priv,
-- 
2.37.1

