Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6476D6D1C15
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Mar 2023 11:26:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231309AbjCaJ0W (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 31 Mar 2023 05:26:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55946 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229448AbjCaJ0S (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Mar 2023 05:26:18 -0400
Received: from EUR02-DB5-obe.outbound.protection.outlook.com (mail-db5eur02on2044.outbound.protection.outlook.com [40.107.249.44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D878AAF20
        for <linux-kernel@vger.kernel.org>; Fri, 31 Mar 2023 02:26:16 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=F9qEk+ITxnmoJR3ASuDsZzdZC5p3MTags9YqKuhKBzHaEVi96FhjQrAfiyuwCSiQ1xQFIOJXoQG0bsNaK2+hZFsdsaxf67E1+u9ODhF1YE3EyKMY6hLCQDGJ0LfmM+xK7fFtArASsY11E6QqKW5ZiEup3ghyhtl/BYbRDjjs2ZoKd0ivsDIsNvlH5R3+dvVy8tvZ8f46v/OGFqCT4GeU3qRr0D6hd7N4+BBlII0BaRW9feTLCRPp5yma9ZkbLexZvtBN87vB1HpgJoAQGXehQVodefiS4vP4bNTe57yGQ23CrpuYUBIaPVWC+KxgVZxffVK00d0WgLFE1trpvapKfw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lZJnVbBGwe656ZUKMIooFpYWWymTtYpsYWN1z4Lau7s=;
 b=mk0+MCkmE9QynPBUVSwxNbMBy694sxFVuyzEMD3ZvF3X7aEWEKJRouQUfqNjwZZivz4atxsUAGODht4/HL5+747x5vTvEcgiaAKrZi+lwCM0fMDoNm1jIk65whwPm9eLtn84/l0YFuCYRrVUPY60AAyhL2063xWPbLQw2qH2BK49pQzunjzj7QNxt0x+3H7TwJXkqpzsaHPxU7keyQo1l0cq26pK3SnBhBPbH19kHzSKTqdhEvpqgPbNY0dDGwaHFRRENd8kcmVSvfEFYZ0P5XyBSleGXcDjE0HI5AzXhzMaKKnTD13ACmJfR772t48sbPmSOfP/QpQTLIgwli6aMg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lZJnVbBGwe656ZUKMIooFpYWWymTtYpsYWN1z4Lau7s=;
 b=EQKJv+GR0HsJ7eJV/hAUeQHuUtN7SfO3KhPVu+CGdJcMBvMg8YOt0eENPWR11DKL0qxxoRVVVhThCwa6MDQPEg3uDcp8n15bCtTBB7xFdSkVZBeZCJUMNzXGoSPFERZDnRTpnpJeIE8zi6SGnad8CarbDaszqEzutMuz1V1H5DM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by DBAPR04MB7366.eurprd04.prod.outlook.com (2603:10a6:10:1a0::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6254.22; Fri, 31 Mar
 2023 09:26:13 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::778e:19d0:cba0:5cc0]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::778e:19d0:cba0:5cc0%4]) with mapi id 15.20.6222.028; Fri, 31 Mar 2023
 09:26:13 +0000
From:   "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
To:     shawnguo@kernel.org, s.hauer@pengutronix.de
Cc:     kernel@pengutronix.de, festevam@gmail.com, linux-imx@nxp.com,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Peng Fan <peng.fan@nxp.com>, Jacky Bai <ping.bai@nxp.com>
Subject: [PATCH] soc: imx: imx8m-blk-ctrl: fix i.MX8MP VPU_H1 sequence
Date:   Fri, 31 Mar 2023 17:31:16 +0800
Message-Id: <20230331093116.2500598-1-peng.fan@oss.nxp.com>
X-Mailer: git-send-email 2.37.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR02CA0033.apcprd02.prod.outlook.com
 (2603:1096:4:195::20) To DU0PR04MB9417.eurprd04.prod.outlook.com
 (2603:10a6:10:358::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU0PR04MB9417:EE_|DBAPR04MB7366:EE_
X-MS-Office365-Filtering-Correlation-Id: ed0ff879-3a09-4746-86ee-08db31c9f866
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Y+V1CSqugLS1SOaxB8ud64gAA4llz8MN4mcQqCBEzldJ7qzmn9OoKRs2DZWXYhSDlGBrYMdmGEVQVa8wSNBHVTIF4o7R97MDeKEmw4GuklWQie5MTTcPoIjCkVER1sM0FwB67WcRkqpHDfLnWklmrwACobYehE64aelzQ6S9CyWG3DQRG4gx2cu5UENdbn2x/bcrQvw1msfD688VR8P3dkBLgsXz4YNqbGDhBVM9RonKVMtoOh0wNYP4b0+KWSfd5vSsd33kqwf6ZYqVxYHCHH9jbazFIYtBLscKwoa10gGOepeDXsZvrjZMWKZV2nYRH9omHR/vRlJvMqiUBPGw8Xf3BH5oc8dGbNtm32fYizZMGBybCBXDdmV0ZOlpui41adycxelApksDBelFXYPVyBQjz+sxYRBuVyeLpZc2x7v2Gz6u+rP1danW4HS6Am4PCXrGq9OzJKsLsbeFANrLKDMeNezpz3uQBPdNT+zt40oTHHT+Ukt7FU7avv7qqk51dsaVutMlJX8oqvFMyIwRWVBpbm/FkQ7LaOUzQB0vwowUw5Gf5Ep0HzJsZLEsMT9lRjcmjnoepzBsYPm/U7wJEb07vdO+Y44AiCI6marapKybBK1a8xi2J70uqlfRDm46OSG3zyzjGnfbnXqdwohNvA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(346002)(366004)(136003)(396003)(39860400002)(376002)(451199021)(8936002)(38100700002)(38350700002)(5660300002)(6486002)(41300700001)(4326008)(8676002)(86362001)(66476007)(66946007)(66556008)(83380400001)(54906003)(2616005)(1076003)(6506007)(2906002)(6512007)(186003)(26005)(478600001)(52116002)(316002)(32563001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?G2or2W44M7jTl6S4wkh4bPUrQFRHy6T1v95gP4vFNQOxssle2jCfJfWoe7m+?=
 =?us-ascii?Q?2+vni5p69aL8qi6M2wf7f6f+yP3xR+aEEllbgTUgatpCtGr01UlQ1sPH+ksQ?=
 =?us-ascii?Q?/l7Aac5zUJ11k22Nc0ea+oIML98hj02+7z7t2iOY48wBIryz/0XgvRZLf0oP?=
 =?us-ascii?Q?fSMgHrc2jbyOJjJplNyQCVlp4ZWLJlG+ZIAVr+jdqmeb25jah4QoAyZ6fkUw?=
 =?us-ascii?Q?UTJBJ325YjSTL9MWuHL3VMU+KuCdi1FZnL03WuklaNgitLRP2q0ZVs5CbqAc?=
 =?us-ascii?Q?ex0RutiFcIbmx8TshRrhebkxWG3X9+E4fhuVMOYptjru+50yFsE5PaG2NhjP?=
 =?us-ascii?Q?anTrv5rjXtp5FhoLFCWdIRwted4GQvYRFAwRfW7ZZDgRuZ/ssDhdbVH3BJBt?=
 =?us-ascii?Q?lJNYFlEYPeLhsvNJ7DwnwsPRG72B+TjemjamW0xnuDytJ0d93OwWAonLUYWA?=
 =?us-ascii?Q?O4+sDjFOyAAR0OL5R1A48hPXSUVqv/RCBlYXW+T/Xp1xZN+1BDvT5CSxItfl?=
 =?us-ascii?Q?mb22/wTiVbesZQS67bZB5kKRCq+iPUjzlWrLzbDHVYcwp/80MImi08KtVlof?=
 =?us-ascii?Q?0cHdt4ton43BwjldoIORWPkE36aA+V2kvwXIAnO2pdlKf4VX9p5KAbwtqa5B?=
 =?us-ascii?Q?Cm8y+3mVqBATdo+cRSIjsXrm9K6TlV7rtlevgX6Ep/nY4qf4aNXOHh9HLLgW?=
 =?us-ascii?Q?lYWtXAaIdWpIKcYv8z+zcJd5BabBZPG4YUMWJBRBYC8zJCOh/dlm+FxPnaoF?=
 =?us-ascii?Q?BK9rMh7EGfXJph95BCZvqpPIXQVi7I4G9TsSMYRAdb7pqqu/Wp74X0INbzeA?=
 =?us-ascii?Q?JGY4OESRY5PZ5xK7QRNN8z8gdpmcQCv0qd71eiGeXvPOBD7j6WQOfQNQI8/G?=
 =?us-ascii?Q?uzcWRfaBjeYPHbMSBbpT6UABjis6or1Y4tX+1ZZTHQKfIL600qFVrMcjPmGj?=
 =?us-ascii?Q?ZOb4JubR+8t462cfmqC+l9M9LaX4ttJjky9hIOMyKhh78qBNCd6aEu8NvRTk?=
 =?us-ascii?Q?IflsV4ssyW4zZqPN5u4jtBtUKBbyRy5xAkoZrOdQvEEE4rsbOxXDxPCh9AO/?=
 =?us-ascii?Q?mSQ317fC9+adPPjHrIw+sF9e0OyIVvZ61a9PVRT8z4hEPyjN9BI07JayiWCr?=
 =?us-ascii?Q?doGE3XbAfpFgNw2TQXiq7lG/Z0Xxji/n262LYdY6rTp6euZu+eu+Lg5ugeup?=
 =?us-ascii?Q?YVSmZC00P9EpXz0Dpl+LPEO0tqcBwr/0IQyMqBqlQRjUnW+dLKAzE4HGfLTy?=
 =?us-ascii?Q?hgN4WJ8F4VEbqwtNkyFKN9YfW/XW4qEInX8h0BWFvPBaMDF58iLXqXV+UtsD?=
 =?us-ascii?Q?JYYdpadadGwlxqmDY1H1P+964AsbJ6vnJjehn8nO1CYXC0t1rKW/WAF/M6kM?=
 =?us-ascii?Q?8OVZy/zJGn68XtaAGCwHjlW/Onkbty1UqDUr+lALpg6wz6btGmzxmQUwN0h5?=
 =?us-ascii?Q?8l9/3iHQtKuNfecTt5G81SLRS5/PBS5y/cXs10C0kp+C3u2xVbNiFajZLtAc?=
 =?us-ascii?Q?Ni3DNqXVcrNkIV1rEIS3GqGs2CY58hg2E8OUvlCxPTdi73uGb9fL+dS0qeDt?=
 =?us-ascii?Q?EeN2uw2J9TB8gHOTD4baPNCJ6cmLYtblYNrNXIrq?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ed0ff879-3a09-4746-86ee-08db31c9f866
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Mar 2023 09:26:13.3177
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: BYLLSNVGOSTS2UBlF5zUugu+dAmQOMlyHOJ0BlYqJVRqIozNUhkolHhhkmUQdO0Lp/zbnJ++P59Rq12xvXjwdA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBAPR04MB7366
X-Spam-Status: No, score=-0.0 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Peng Fan <peng.fan@nxp.com>

Per errata:
ERR050531: VPU_NOC power down handshake may hang during VC8000E/VPUMIX
power up/down cycling.
Description: VC8000E reset de-assertion edge and AXI clock may have a
timing issue.
Workaround: Set bit2 (vc8000e_clk_en) of BLK_CLK_EN_CSR to 0 to gate off
both AXI clock and VC8000E clock sent to VC8000E and AXI clock sent to
VPU_NOC m_v_2 interface during VC8000E power up(VC8000E reset is
de-asserted by HW)

Need clear BIT2 of BLK_CLK_EN_CSR before power up VPU_H1, so
add a notifier with BIT2 cleared when GENPD_NOTIFY_PRE_ON and BIT2 set
when GENPD_NOTIFY_ON to match NXP downstream Arm Trusted Firmware
implementation.

NOTE: The NXP downstream ATF has VPU_H1 CLK SET before do ADB400 HDSK,
so follow that procdure to avoid any suprise.

Reviewed-by: Jacky Bai <ping.bai@nxp.com>
Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 drivers/soc/imx/gpcv2.c          |  3 +++
 drivers/soc/imx/imx8m-blk-ctrl.c | 28 ++++++++++++++++++++++++++++
 include/soc/imx/gpcv2.h          |  8 ++++++++
 3 files changed, 39 insertions(+)
 create mode 100644 include/soc/imx/gpcv2.h

diff --git a/drivers/soc/imx/gpcv2.c b/drivers/soc/imx/gpcv2.c
index 4b3300b090a8..81e3c09e004b 100644
--- a/drivers/soc/imx/gpcv2.c
+++ b/drivers/soc/imx/gpcv2.c
@@ -17,6 +17,7 @@
 #include <linux/regulator/consumer.h>
 #include <linux/reset.h>
 #include <linux/sizes.h>
+#include <soc/imx/gpcv2.h>
 #include <dt-bindings/power/imx7-power.h>
 #include <dt-bindings/power/imx8mq-power.h>
 #include <dt-bindings/power/imx8mm-power.h>
@@ -376,6 +377,8 @@ static int imx_pgc_power_up(struct generic_pm_domain *genpd)
 
 	reset_control_deassert(domain->reset);
 
+	raw_notifier_call_chain(&genpd->power_notifiers, IMX_GPCV2_NOTIFY_ON_ADB400, NULL);
+
 	/* request the ADB400 to power up */
 	if (domain->bits.hskreq) {
 		regmap_update_bits(domain->regmap, domain->regs->hsk,
diff --git a/drivers/soc/imx/imx8m-blk-ctrl.c b/drivers/soc/imx/imx8m-blk-ctrl.c
index 9129c97b7a01..7c4045068804 100644
--- a/drivers/soc/imx/imx8m-blk-ctrl.c
+++ b/drivers/soc/imx/imx8m-blk-ctrl.c
@@ -14,6 +14,7 @@
 #include <linux/pm_runtime.h>
 #include <linux/regmap.h>
 #include <linux/clk.h>
+#include <soc/imx/gpcv2.h>
 
 #include <dt-bindings/power/imx8mm-power.h>
 #include <dt-bindings/power/imx8mn-power.h>
@@ -53,6 +54,7 @@ struct imx8m_blk_ctrl_domain_data {
 	 * register.
 	 */
 	u32 mipi_phy_rst_mask;
+	notifier_fn_t power_notifier_fn;
 };
 
 #define DOMAIN_MAX_CLKS 4
@@ -66,6 +68,7 @@ struct imx8m_blk_ctrl_domain {
 	struct device *power_dev;
 	struct imx8m_blk_ctrl *bc;
 	int num_paths;
+	struct notifier_block power_nb;
 };
 
 struct imx8m_blk_ctrl_data {
@@ -265,6 +268,15 @@ static int imx8m_blk_ctrl_probe(struct platform_device *pdev)
 			goto cleanup_pds;
 		}
 
+		if (data->power_notifier_fn) {
+			domain->power_nb.notifier_call = data->power_notifier_fn;
+			ret = dev_pm_genpd_add_notifier(domain->power_dev, &domain->power_nb);
+			if (ret) {
+				dev_err_probe(dev, ret, "failed to add power notifier\n");
+				goto cleanup_pds;
+			}
+		}
+
 		domain->genpd.name = data->name;
 		domain->genpd.power_on = imx8m_blk_ctrl_power_on;
 		domain->genpd.power_off = imx8m_blk_ctrl_power_off;
@@ -479,6 +491,21 @@ static const struct imx8m_blk_ctrl_data imx8mm_vpu_blk_ctl_dev_data = {
 	.num_domains = ARRAY_SIZE(imx8mm_vpu_blk_ctl_domain_data),
 };
 
+static int imx8mp_vpu_h1_power_notifier(struct notifier_block *nb,
+					unsigned long action, void *data)
+{
+	struct imx8m_blk_ctrl_domain *domain = container_of(nb, struct imx8m_blk_ctrl_domain,
+							    power_nb);
+	struct imx8m_blk_ctrl *bc = domain->bc;
+
+	if (action == GENPD_NOTIFY_PRE_ON)
+		regmap_clear_bits(bc->regmap, BLK_CLK_EN, BIT(2));
+	else if (action == IMX_GPCV2_NOTIFY_ON_ADB400)
+		regmap_set_bits(bc->regmap, BLK_CLK_EN, BIT(2));
+
+	return NOTIFY_OK;
+}
+
 static const struct imx8m_blk_ctrl_domain_data imx8mp_vpu_blk_ctl_domain_data[] = {
 	[IMX8MP_VPUBLK_PD_G1] = {
 		.name = "vpublk-g1",
@@ -509,6 +536,7 @@ static const struct imx8m_blk_ctrl_domain_data imx8mp_vpu_blk_ctl_domain_data[]
 		.clk_mask = BIT(2),
 		.path_names = (const char *[]){"vc8000e"},
 		.num_paths = 1,
+		.power_notifier_fn = imx8mp_vpu_h1_power_notifier,
 	},
 };
 
diff --git a/include/soc/imx/gpcv2.h b/include/soc/imx/gpcv2.h
new file mode 100644
index 000000000000..db09720bf638
--- /dev/null
+++ b/include/soc/imx/gpcv2.h
@@ -0,0 +1,8 @@
+/* SPDX-License-Identifier: GPL-2.0-or-later */
+#ifndef __SOC_IMX_GPCV2_H
+#define __SOC_IMX_GPCV2_H
+
+/* Avoid conflict with GENPD_NOTIFY_XX */
+#define IMX_GPCV2_NOTIFY_ON_ADB400	0x80000000
+
+#endif /* __SOC_IMX_GPC_H */
-- 
2.37.1

