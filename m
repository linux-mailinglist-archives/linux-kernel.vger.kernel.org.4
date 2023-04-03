Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5518F6D3F1F
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Apr 2023 10:37:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231450AbjDCIh3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Apr 2023 04:37:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57022 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229670AbjDCIh1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Apr 2023 04:37:27 -0400
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2079.outbound.protection.outlook.com [40.107.22.79])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 131081A1
        for <linux-kernel@vger.kernel.org>; Mon,  3 Apr 2023 01:37:26 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ivsgMBlJ5QGNO3IxHie1jaot38cq2edkhjHTd4mz608JG+n2uDBKzd2cG5rGTf/+xheMahKXv4QEVBg9bVhKOzB3QpoOOsjj/KLc7cpL0+L4gwK7lxMArQrNX6By5Nepflca/lI4sS/0e/UoMXye12Jx/OYgoUNifhzK8RJ8pcW8+X7RzAlIXY30R684clGfq62KUgKPk+sT9TNRpHIoPT09/Oy/3YjcOWgEA696Y5JqrH/QeDTtoM1H+gklrZ+4Xf3L7yhd9nF17y6p4jVB09nZ/thCklgSVzXwbJl+lN1yzQ55LhcUVLHChmTKGakhq8jqVgVc9ssVQ3EVq1lN/w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hD8UdfVrUKgEtVUnZVWuAKF+pb8/8yBQ7tuxXset418=;
 b=NyW2bykrLwQ/Ar6oi9pbQ6GrCnLDdZC0vH4pANeQkyELaVchux3uwP5fSwOOQTHbh9Ls8WxJs4+vgnUuUvhLOXKgBUQYS7ubAJLz6F3QR7t6EI/jgBmDds++u97T7hZnN3OxvVhPRZFdOXDuhfQ0M0a6o8t0GFeN9clxncdkpbC0abmujMefchaAHoB7MeUQt5PvP7dh9ybUP10DKR+IpsAiqhFZqx0U/gkW6iJw1ChPTiHJjIPFTM1kmHsXU/QIafqAP6xHrMzDmGCNMRt/DZLDYtnPsKe0z/2fC7sRNABU/TfqC4HVnhIpz+0QrOVjsqIfSpSKSIF0g4i4lYVUlg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hD8UdfVrUKgEtVUnZVWuAKF+pb8/8yBQ7tuxXset418=;
 b=EnmxfvYTEafIjKYb+whF6jehrEMRAuIO78+RQqv1jE+5J/tli5mXU6CEK3WYrTudS52MqHrNfWoAHKqwkXIlUiSdzz8Uot/lnWwDebOuSiraAR+DGiVo8eouPskVYz56Hohdn25VrtN/z09vfFt/xH3wD2fc3YZ7MuNvXwbfp3c=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by PAXPR04MB8407.eurprd04.prod.outlook.com (2603:10a6:102:1c7::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6254.30; Mon, 3 Apr
 2023 08:37:23 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::b999:f2c6:a8cc:7b4]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::b999:f2c6:a8cc:7b4%4]) with mapi id 15.20.6254.033; Mon, 3 Apr 2023
 08:37:22 +0000
From:   "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
To:     shawnguo@kernel.org, s.hauer@pengutronix.de, l.stach@pengutronix.de
Cc:     kernel@pengutronix.de, festevam@gmail.com, linux-imx@nxp.com,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Peng Fan <peng.fan@nxp.com>, Jacky Bai <ping.bai@nxp.com>
Subject: [PATCH V2] soc: imx: imx8m-blk-ctrl/gpcv2: fix i.MX8MP VPU_H1 sequence
Date:   Mon,  3 Apr 2023 16:42:28 +0800
Message-Id: <20230403084228.3212581-1-peng.fan@oss.nxp.com>
X-Mailer: git-send-email 2.37.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR03CA0106.apcprd03.prod.outlook.com
 (2603:1096:4:7c::34) To DU0PR04MB9417.eurprd04.prod.outlook.com
 (2603:10a6:10:358::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU0PR04MB9417:EE_|PAXPR04MB8407:EE_
X-MS-Office365-Filtering-Correlation-Id: 384c13e4-a7c7-46da-a16d-08db341ea515
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Yrb+e/W8kGVQMxujlIiIZjBFaVX7DBNLQTY124ClbtNVA0cOlDcj/p6r0MOqrl+WSRZHOAhfv+2zCKOqzi/U1YQF+wXTkK/ys6LI/UC87sYpx2TlYXxpLRuESRDYST18kODOY7rz1QqbEQk5xc6f7xsQ437o9uHk1PXOSapfQsHzIZVvXYhU9pz4Gl+vypS0E0sMklluV8uN1m8MTl20F3sfBGRsQBtcPAXSbrEEowCvLbjyjfNDGPh9sYpZ7fZaBVcou3wXS6cFkWoZKTWYZRkLJLMarUbDDrZDGA9i/II7HKsqetYaojw0l4Znb4OZaJNXXF9YBSot0VowkdUR3lp9kn5SWWcWCnKU0ILAjci+njtjXSttpqu+gx5rMXCxDSf8Bk1v9fW8E1R62q9ZsNtYd32EK7B3JuBS+R98XEfeqKbLp3aC4TIyGZLYfoJ/BsscoFCAu0QdRmXMYNu2SAtxm25LZv+ck3Yl8B5DAdvk4HNqEDg9WL69bl9DHuzTLbgpL+1x8V/kPS1bVJj0tDqhJCAZrSE5cWUKGj5YvvpVqxFh1F07EYsSbbQXuL2VbA2p1BxIxqsSXZ01HzoDo7TxDAeOk4B5BX1Sp5kQ4pVzY6mOcYi8VBdEWeYUT3ZHI5SWiEgPysBBXtx8V0BMfQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(39860400002)(136003)(396003)(376002)(346002)(366004)(451199021)(86362001)(2906002)(52116002)(2616005)(83380400001)(186003)(6512007)(6506007)(1076003)(26005)(6486002)(4326008)(8676002)(478600001)(66556008)(66946007)(66476007)(41300700001)(38100700002)(38350700002)(5660300002)(54906003)(316002)(8936002)(32563001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?7H5TihpW2arWyNoF3aHgwiy35yF/LyFv43O+pS/k3V6WpjXl2VTf4Dn25sM8?=
 =?us-ascii?Q?dPPNTwBCs+FzGACHbBirYaVDz8mIM6j2rYXQZoPJ5ImMW+Q79r9EetBlRj77?=
 =?us-ascii?Q?ttz9bFLjtishW8Y3ybeh3n6EEmgdr75IVy/YgiozeooX44WKGsPnhZ1btFYo?=
 =?us-ascii?Q?glnfyk8siZvCa86M0w8XmhOcZ1PNj4a7e/ECkUQJekKMc8QK8vzNfMBbiAkM?=
 =?us-ascii?Q?dSmtZpvXcQ/rkftw+BPIhsC7P28ibIuXH6yf/L1FnrT1pS4XHclfV3l3jE9j?=
 =?us-ascii?Q?UrIISUQRTYtW+HmeqpNTgmrCrpQkXU8pBC9x8ftqDKrCZcESxXmwGZWK+1iY?=
 =?us-ascii?Q?4VPQHzb9/6vEJaPLY3B4/aTqEwIyQR+VZ0SfeUqoXc9/v2aO0tRf2bxFJaZI?=
 =?us-ascii?Q?WGzK67uxIaMprEy8XkUURtQITVnr3xI4WLJkd4AMcCbufFwFGrtP0F9iT1ME?=
 =?us-ascii?Q?xlo+cCWTmzN0F2hA3+SuE1GYnD/pyXQvhpdTkFi7Xs/3yOgdUGWHn4SD3A2Q?=
 =?us-ascii?Q?iXvweSW9UUyiqbL5kAif/82M9WRurGY6C77l4B2vqPhLlrB5EvZqEFmGDYdT?=
 =?us-ascii?Q?8xwZYnjn1ZbkYL5z6MXzb6CrBHeZFPspsYGuf2dwdlgICfzYflrWLBgfq0ek?=
 =?us-ascii?Q?F7gBDCg/FTTYFtrxckfP53y4CVlZAOfATXgdL6oZF5GdETJiewfKpa7fg45i?=
 =?us-ascii?Q?mGGOYC5TWaoDLl3tJK3PSKNzQ21jM5tBZeSSI762CaeN23Ve09MHEU/FdW1X?=
 =?us-ascii?Q?j83dKmGrGN2CH1wnxHBS/8X21SvswjQ85snyfYSQETy0WJwWSmqFa65s9wOK?=
 =?us-ascii?Q?hs10MyujDe+qGVz1ac6eWStz5F55gDVvpfWtAo4C8RP2jHiJioFq4n2mJ92B?=
 =?us-ascii?Q?Oqkzd149aqNXIKlGHTqwpH7IbL8htgC85P86blolWEsv4ddXNGClGW15/E/T?=
 =?us-ascii?Q?TUCElZC9QGGf4Ua5Jb5h4UmMSbdOhjVvrOg5wcBXPLxBDuvGO74/9pW+YkAm?=
 =?us-ascii?Q?GCwFpbX4LmByd12JMtRTlw9QKaGA+U1LpfirjnmFq778odJzp/NtVpq8WlWx?=
 =?us-ascii?Q?EiCLDHinGWagNZWipZZHc0VBornUo7bp4QkoUMMJCYIWOWcdebx+FNUPo5yv?=
 =?us-ascii?Q?5qtzYtLMvdq94xGf0vYq6+XspQEcwe7AnlVYzbrXEN66bzmf1EiLhR/Pbpjs?=
 =?us-ascii?Q?5zlHeyI23IGCbK5vCU2PzsJsBLK6CbS+AMjYNwtAevR/ypmQlKH9LIBGjrvK?=
 =?us-ascii?Q?yIBo3apJ+C685qBuUceMzKwDYNbfKfYAFHfnbYM9LN8jbZw2z5NkyBxWAfNi?=
 =?us-ascii?Q?QeoGue5CmpRCVWPyRUWNi1GWOQJYkSEEghxZymE7uVfnZjq2S5bhtaBREtI9?=
 =?us-ascii?Q?lUZeRelXo6Reg1lB2/2eo8oBstLNqZ1Egtqw1yxquMzyYy0YEt3+ncXZBVKc?=
 =?us-ascii?Q?q8CsQ2HUh+SNcKGT5HdmpTVtyswE/I6emSENJi4Jk2F53K9o/KvRiFB/Myci?=
 =?us-ascii?Q?klM11n/Yjf1O1Uej35ihu8i0iXttZ9CtCxD+a2mwdQd3qt8+agZJx0H7Cmob?=
 =?us-ascii?Q?f4ml2NsO2gBC4F8Ktc+uJWaFNFphMXUz0w1LD3Id?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 384c13e4-a7c7-46da-a16d-08db341ea515
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Apr 2023 08:37:22.9179
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: lJOgGJ2vQ3W5oyCaf6+j6ir4yUtlttYbk6maRiR9Z0xHwnxFGGRcdQ4GBv4YIm/jpLkHosSfIlszLlA4fcs4Cg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB8407
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

V2:
 Add the missing gpcv2 changes

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
index afbca0d48c14..d88e338a54b1 100644
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

