Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8FC1460D3A1
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Oct 2022 20:34:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231820AbiJYSd7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Oct 2022 14:33:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39676 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232818AbiJYSdj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Oct 2022 14:33:39 -0400
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2041.outbound.protection.outlook.com [40.107.21.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 62690DD8B2;
        Tue, 25 Oct 2022 11:33:38 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dAxdlyjeV+/0lg81c67g++wG7MsBcTgKBJGl062LyZDfvD0q5mfH/TMvYv5VTZ15DV5CqussLNI8pMFxhC4LROdpOrq+8KhuHSr+m16F8vryiNLZ9rfApQ+elY9/4z48oWnJQdnNoN5dXesUxMWJKTZOf5nRyED7+F/xKJMKsYmzbZAwhkOLWYRNIGny+FxBce0gznqMMyrIxzMCPCvr/iH/AT6AH8J8EzYQeRdDXPqsz44ALwPluRqhxDWT3DG8E7iJaS/blF2erR1Mq6bX9uhkKHRj4aUd8r+wRdJslb2arw3hpkiZ28fv1JfI88oKHXps/8QkjrWTT/kaFGRfBA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HK8umn/SaBCLANQD/iiVYz01sajoRlXqGCOCY0E7X04=;
 b=hVBhYvwJu8OCRVGnlUUChQGCUxak/CV/kJRk7YYuHLSGVcLNEQKMf1UkZPC1yU3JvaJLNoDVk/FY6QpAhF4nid4fxvZnYJntRhzIJWisk9g5yEK4L4bR6GR1u9IWiLbrXTZhn3jihaDlFUc6P17CrvgQzFJpyXkphUTQCZcX1he0wlMfBjSqDXLCiZJYaoc0Ln1sBkBCEe/0mzK7gU9Qz25JH84DPGAN1WxgBhoYElOlhIUHJkwwDpKQL0097UGTAVKM0kjulOf3Y9Aovx+shPSC3bq4iO7kXDlWxiI1vtoePWDDTcVhCHNXPiyPdBjetSGHiLxo3j/QY0DdK8k1Rw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HK8umn/SaBCLANQD/iiVYz01sajoRlXqGCOCY0E7X04=;
 b=aMkrsmzjTCcu5Ez5Z1YgKUNnnHwQmg+Qfkq6XOF8YML6qdz7UCcZSTt5MxS8wTdq9kSjxFw9H+KxK4don5hLh5ACFN53IKSF48alRx5uN/wkv1Ys9wrQ6RaZvPcmx8i11Q0Ifubw2rile1uW+JixjE/WG9T1n6af5AqRjoA1YuQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9185.eurprd04.prod.outlook.com (2603:10a6:102:231::11)
 by AS1PR04MB9581.eurprd04.prod.outlook.com (2603:10a6:20b:470::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5723.33; Tue, 25 Oct
 2022 18:33:35 +0000
Received: from PAXPR04MB9185.eurprd04.prod.outlook.com
 ([fe80::4150:173b:56ec:dc6c]) by PAXPR04MB9185.eurprd04.prod.outlook.com
 ([fe80::4150:173b:56ec:dc6c%9]) with mapi id 15.20.5746.028; Tue, 25 Oct 2022
 18:33:35 +0000
From:   Shenwei Wang <shenwei.wang@nxp.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        Dong Aisheng <aisheng.dong@nxp.com>,
        Jacky Bai <ping.bai@nxp.com>
Cc:     Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Shenwei Wang <shenwei.wang@nxp.com>,
        Peng Fan <peng.fan@nxp.com>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        imx@lists.linux.dev
Subject: [PATCH v3 5/5] gpio: mxc: enable pad wakeup on i.MX8x platforms
Date:   Tue, 25 Oct 2022 13:32:44 -0500
Message-Id: <20221025183244.615318-6-shenwei.wang@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20221025183244.615318-1-shenwei.wang@nxp.com>
References: <20221025183244.615318-1-shenwei.wang@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BY5PR17CA0028.namprd17.prod.outlook.com
 (2603:10b6:a03:1b8::41) To PAXPR04MB9185.eurprd04.prod.outlook.com
 (2603:10a6:102:231::11)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9185:EE_|AS1PR04MB9581:EE_
X-MS-Office365-Filtering-Correlation-Id: 1dbaaf33-c275-4241-bf41-08dab6b76d54
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: +yUtfNQebIU+OmS2waKdMPD0mx0p9/tcE9Ak6duQ0Ka4sQmq72F5UILv7OiKkmBhcyfaCIVAyzm+JP77uLxUDyjzPHZigztFPpwkxSUOhWn/2GrI9oC/kbTE3Bzwqrayz8pdDFwHEw08ymY9ipXOFohJvjtAPt9AzzgpOuGXCxpl5UaLCw3JlvMa4HNZ8SbmE5KOhdmtmF0MvyeU8FBkXolXwvi9TnJeW8bPFd52Uj0RxC+//h7jhKkZ7ISDCU4DKnKRKqTp9IYrhSLXWt8JGNLoJsJBfphnxM1CMIoWWtDv9S8UWfjyOu98jBSH+3MaqgNLe6DUVudz3uDATKuyR+eDTmZtDvsHxO51rk+cldNBL0W+blc2HRFmXlkEVIavD1SwNdJHk253rmoxM8B7m6WdZQLI22l07sNKr0fjrIri5dmjPCbnfmV8MI1MTvxbdICdri0m8C78CfjJMDBCZRvHK2MHPUT7k5sTcHC1G0t1cPxKRjoi6gH3c1tr42UprLKh9VXem7TOyCn9ZhAovuIXnIvQGSdVGu4eD7LAU2eLkYOOJqyBdEDwf1RFhZFUMrvz5zCfb1SNQU5ciWUmdsuTcCVsF2aSTPxw9KSaAhH/VhuBvfdW0zZ4hNnfjt30W7uOBTb1Smz/ijFJ46N62uJKjZw/XHUAvZtDKJf4B//F200oaVlyRSgTXWZfIa7Pwj6IQwGYv4SykIJKR0Zai8HaOCFFFMrFeZpauuqzJdCFQo5LHUYIld9DdNTWL2doefkEKltnj6Yyfp0i+G5HbA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9185.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(39860400002)(136003)(396003)(366004)(376002)(346002)(451199015)(478600001)(38350700002)(38100700002)(7416002)(55236004)(6486002)(8676002)(86362001)(2906002)(52116002)(36756003)(44832011)(6636002)(66946007)(66476007)(110136005)(6506007)(8936002)(66556008)(4326008)(54906003)(26005)(41300700001)(5660300002)(6512007)(316002)(1076003)(186003)(2616005)(6666004)(83380400001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?nMBIrvdGRmZEPorIdq0XEqszecXNk2DnDMer/liXnO384+d2Ilfqdzo/HBld?=
 =?us-ascii?Q?0ktAum8JpEbxDCyiivuBtjpw/FW5hSk2a8BvCUp4aLUK0nttHxjD9qIGfwEU?=
 =?us-ascii?Q?eqKY+toWkDM1KpkBKwpH2JoBsnj55AUZLHmWEaKGp4pWckdRAPoktYWDfuU2?=
 =?us-ascii?Q?UAvy+87X6pq4DWu5F8za5icKF37ZneMV5seXTy6hc4mcds5r1z+JTB68JjOc?=
 =?us-ascii?Q?UHANo3Ud7HznU1taAg9DSmZhymggTdYoOIFicMP15jINYxTPre9woyxU4AFe?=
 =?us-ascii?Q?gIG5A04mEVZT46ii3aAXl7SmxOptsipwI1Asc/vzX/2cRCXAMGKh76JS8map?=
 =?us-ascii?Q?/71QhlpoNlS2QMqymhUL5D0Kz57m4qEEat/9Cv7vjiMb6xnWZTy2+VzpH438?=
 =?us-ascii?Q?Xar+nimxIKAx5MyLpekLcZv7Ro0aJUHoiiZaPGR3k/inc1PiUmTbVykoh5l+?=
 =?us-ascii?Q?uRtEAD713x33dTcpEnUBaYnyN2iBhKVgsf2JiMKRtw0GJxcKiru1VT5YRMHX?=
 =?us-ascii?Q?2Seps6Jukp+/Dz3fvMyVkPnEd//YuHKkCjVafxfI2tD5qIvNrBOIJwrSBm4y?=
 =?us-ascii?Q?TAymky2Mpjdtvhi21CJyXNqnChuvRoPC1T8JmrHxKJio08Jz6EAPus4f5gCz?=
 =?us-ascii?Q?bJwVJ5r6/qw+yT2McMzMrpYLetXqgG3fo+e9on88Honl+uyBXRG+ZbZllEe8?=
 =?us-ascii?Q?N7TQR3mUjR+o/4jjVpft2ez0cKjaI8JpCafgFEbFJXBFQJQfp06aKiAw4v8R?=
 =?us-ascii?Q?qL3TLzbru4Xs/ye/ynJJxM1P/SjjO72/sIqoZJbxEVypLQ8ppVaMSlfDSNiC?=
 =?us-ascii?Q?QPWIAhk9wQCcihL7q7X4030v7+CXnvRtS16/JiPYoKwbwOKnWlOk6ZNk1FHY?=
 =?us-ascii?Q?QYuBjBCJNlmeLQpeT220C8MB6e2/ILHdSmbBzh3Bj20PanQhBOJwCxLMu3jV?=
 =?us-ascii?Q?WSiaOAkKu9llqKF4a+jIQbnL7Kha/+Vgl8TYS7NnVCKzbvp3twW496cEKHqh?=
 =?us-ascii?Q?4HvlXFg/a+mEuVU9Un5g6AOvtKeNiLW4bnqj3mAbdXp2Y/ixHKSoVc0xLSFZ?=
 =?us-ascii?Q?4iPFr66PoKJzDepoMnxAMTWh3Gd49wP5nFaeDXZ//Wfga9UVWIILHCd5/nrN?=
 =?us-ascii?Q?Ti6FJl9NF4PL+vnLj9K5wKaP/y3J2eE+CYUuTW0uImwaxvWd74htX0Xx4sue?=
 =?us-ascii?Q?0Al0FyviUiVAWVUfzAIfptRJrmy/hObq4X6i1sdqEMkc0nud2uV6iWwMd4P+?=
 =?us-ascii?Q?64laOS0WFX8bmjARaU4WWt+fbIkwQVOPSIsJfu7cu5l4RIF71t/6J1xVUjXS?=
 =?us-ascii?Q?EWp2BhZ7rllm1I0bLLpAAoC3VJm+JFFXXDl3Ac3J/U1pGoE8EgbvOT9/XNep?=
 =?us-ascii?Q?egG9i+4UlVba3gYQeMUlLiKuk5qWeaGJ5G/Zq6Rdw04WgAugnpgMQohfVSGO?=
 =?us-ascii?Q?KTmEYDsjpbzqq7/qaPF3GqvpYE1OrMiX408hzSMw5m0CPHlN1J8tCxhP10i5?=
 =?us-ascii?Q?v2EKyynXMqAT+9veO7fqyatYyBHn+uGUb09duElJU42XoVnrYNbEaQ9IZzZW?=
 =?us-ascii?Q?GJfY4ZqRc0S01xa+Uo6wrle+Lb6TTrBR59iO6zyp?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1dbaaf33-c275-4241-bf41-08dab6b76d54
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9185.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Oct 2022 18:33:35.8230
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ooWSnz/BuCVYXtHO1WjYeH0x+zxgEsCgUmyOiX3VrwRXd9J6xavmgZOCHDB2Y5IJk1f+YTTRAtK+D5x4adfWZg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS1PR04MB9581
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On i.MX8QM/QXP/DXL SoCs, even a GPIO is selected as the wakeup source,
the GPIO block will be powered off when system enters into suspend
state. This can greatly reduce the power consumption of suspend state
because the whole partition can be shutdown. This is called PAD wakeup
feature on i.MX8x platform.

This patch adds the noirq suspend/resume hooks and uses the pad wakeup
feature as the default wakeup method for GPIO modules on
i.MX8QM/QXP/DXL platforms.

Signed-off-by: Shenwei Wang <shenwei.wang@nxp.com>
---
 drivers/gpio/gpio-mxc.c | 91 ++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 90 insertions(+), 1 deletion(-)

diff --git a/drivers/gpio/gpio-mxc.c b/drivers/gpio/gpio-mxc.c
index c871602fc5ba..a6fe5ed3d320 100644
--- a/drivers/gpio/gpio-mxc.c
+++ b/drivers/gpio/gpio-mxc.c
@@ -24,6 +24,12 @@
 #include <linux/of_device.h>
 #include <linux/bug.h>
 
+#define IMX_SCU_WAKEUP_OFF		0
+#define IMX_SCU_WAKEUP_LOW_LVL		4
+#define IMX_SCU_WAKEUP_FALL_EDGE	5
+#define IMX_SCU_WAKEUP_RISE_EDGE	6
+#define IMX_SCU_WAKEUP_HIGH_LVL		7
+
 /* device type dependent stuff */
 struct mxc_gpio_hwdata {
 	unsigned dr_reg;
@@ -61,6 +67,9 @@ struct mxc_gpio_port {
 	u32 both_edges;
 	struct mxc_gpio_reg_saved gpio_saved_reg;
 	bool power_off;
+	u32 wakeup_pads;
+	bool is_pad_wakeup;
+	u32 pad_type[32];
 	const struct mxc_gpio_hwdata *hwdata;
 };
 
@@ -130,6 +139,9 @@ static const struct of_device_id mxc_gpio_dt_ids[] = {
 	{ .compatible = "fsl,imx31-gpio", .data = &imx31_gpio_hwdata },
 	{ .compatible = "fsl,imx35-gpio", .data = &imx35_gpio_hwdata },
 	{ .compatible = "fsl,imx7d-gpio", .data = &imx35_gpio_hwdata },
+	{ .compatible = "fsl,imx8dxl-gpio", .data = &imx35_gpio_hwdata },
+	{ .compatible = "fsl,imx8qm-gpio", .data = &imx35_gpio_hwdata },
+	{ .compatible = "fsl,imx8qxp-gpio", .data = &imx35_gpio_hwdata },
 	{ /* sentinel */ }
 };
 MODULE_DEVICE_TABLE(of, mxc_gpio_dt_ids);
@@ -203,6 +215,7 @@ static int gpio_set_irq_type(struct irq_data *d, u32 type)
 	}
 
 	writel(1 << gpio_idx, port->base + GPIO_ISR);
+	port->pad_type[gpio_idx] = type;
 
 	return 0;
 }
@@ -254,6 +267,9 @@ static void mx3_gpio_irq_handler(struct irq_desc *desc)
 	struct mxc_gpio_port *port = irq_desc_get_handler_data(desc);
 	struct irq_chip *chip = irq_desc_get_chip(desc);
 
+	if (port->is_pad_wakeup)
+		return;
+
 	chained_irq_enter(chip, desc);
 
 	irq_stat = readl(port->base + GPIO_ISR) & readl(port->base + GPIO_IMR);
@@ -306,11 +322,13 @@ static int gpio_set_wake_irq(struct irq_data *d, u32 enable)
 			ret = enable_irq_wake(port->irq_high);
 		else
 			ret = enable_irq_wake(port->irq);
+		port->wakeup_pads |= (1<<gpio_idx);
 	} else {
 		if (port->irq_high && (gpio_idx >= 16))
 			ret = disable_irq_wake(port->irq_high);
 		else
 			ret = disable_irq_wake(port->irq);
+		port->wakeup_pads &= ~(1<<gpio_idx);
 	}
 
 	return ret;
@@ -365,7 +383,6 @@ static int mxc_gpio_probe(struct platform_device *pdev)
 		return -ENOMEM;
 
 	port->dev = &pdev->dev;
-
 	port->hwdata = device_get_match_data(&pdev->dev);
 
 	port->base = devm_platform_ioremap_resource(pdev, 0);
@@ -498,6 +515,77 @@ static void mxc_gpio_restore_regs(struct mxc_gpio_port *port)
 	writel(port->gpio_saved_reg.dr, port->base + GPIO_DR);
 }
 
+static int mxc_gpio_generic_config(struct mxc_gpio_port *port,
+		unsigned int offset, unsigned long config)
+{
+	struct device_node *np = port->dev->of_node;
+
+	if (of_device_is_compatible(np, "fsl,imx8dxl-gpio") ||
+		of_device_is_compatible(np, "fsl,imx8qxp-gpio") ||
+		of_device_is_compatible(np, "fsl,imx8qm-gpio"))
+		return gpiochip_generic_config(&port->gc, offset, config);
+
+	return 0;
+}
+
+static void mxc_gpio_set_pad_wakeup(struct mxc_gpio_port *port, bool enable)
+{
+	unsigned long config;
+	int i, type;
+
+	static const u32 pad_type_map[] = {
+		IMX_SCU_WAKEUP_OFF,		/* 0 */
+		IMX_SCU_WAKEUP_RISE_EDGE,	/* IRQ_TYPE_EDGE_RISING */
+		IMX_SCU_WAKEUP_FALL_EDGE,	/* IRQ_TYPE_EDGE_FALLING */
+		IMX_SCU_WAKEUP_FALL_EDGE,	/* IRQ_TYPE_EDGE_BOTH */
+		IMX_SCU_WAKEUP_HIGH_LVL,	/* IRQ_TYPE_LEVEL_HIGH */
+		IMX_SCU_WAKEUP_OFF,		/* 5 */
+		IMX_SCU_WAKEUP_OFF,		/* 6 */
+		IMX_SCU_WAKEUP_OFF,		/* 7 */
+		IMX_SCU_WAKEUP_LOW_LVL,		/* IRQ_TYPE_LEVEL_LOW */
+	};
+
+	for (i = 0; i < 32; i++) {
+		if ((port->wakeup_pads & (1<<i))) {
+			type = port->pad_type[i];
+			if (enable)
+				config = pad_type_map[type];
+			else
+				config = IMX_SCU_WAKEUP_OFF;
+			mxc_gpio_generic_config(port, i, config);
+		}
+	}
+}
+
+static int __maybe_unused mxc_gpio_noirq_suspend(struct device *dev)
+{
+	struct platform_device *pdev = to_platform_device(dev);
+	struct mxc_gpio_port *port = platform_get_drvdata(pdev);
+
+	if (port->wakeup_pads > 0) {
+		mxc_gpio_set_pad_wakeup(port, true);
+		port->is_pad_wakeup = true;
+	}
+
+	return 0;
+}
+
+static int __maybe_unused mxc_gpio_noirq_resume(struct device *dev)
+{
+	struct platform_device *pdev = to_platform_device(dev);
+	struct mxc_gpio_port *port = platform_get_drvdata(pdev);
+
+	if (port->wakeup_pads > 0)
+		mxc_gpio_set_pad_wakeup(port, false);
+	port->is_pad_wakeup = false;
+
+	return 0;
+}
+
+static const struct dev_pm_ops mxc_gpio_dev_pm_ops = {
+	SET_NOIRQ_SYSTEM_SLEEP_PM_OPS(mxc_gpio_noirq_suspend, mxc_gpio_noirq_resume)
+};
+
 static int mxc_gpio_syscore_suspend(void)
 {
 	struct mxc_gpio_port *port;
@@ -537,6 +625,7 @@ static struct platform_driver mxc_gpio_driver = {
 		.name	= "gpio-mxc",
 		.of_match_table = mxc_gpio_dt_ids,
 		.suppress_bind_attrs = true,
+		.pm = &mxc_gpio_dev_pm_ops,
 	},
 	.probe		= mxc_gpio_probe,
 };
-- 
2.34.1

