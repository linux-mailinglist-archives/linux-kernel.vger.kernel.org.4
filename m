Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5739B60F8A2
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Oct 2022 15:11:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236107AbiJ0NLJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Oct 2022 09:11:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38150 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236087AbiJ0NKl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Oct 2022 09:10:41 -0400
Received: from EUR03-AM7-obe.outbound.protection.outlook.com (mail-am7eur03on2066.outbound.protection.outlook.com [40.107.105.66])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9EEBC645F3;
        Thu, 27 Oct 2022 06:10:19 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=V+si1J4+E+DlttlP2F8QMtW85bLSZKeMIt4Jc1b/CCryI0fAQXdvAdHxEYQbcxv9TasFBvrJ6UPPdqL9q244VYhWGDRlYNXZuei1Pri1fY2kMwrgWxW7WXGpe2yUXYAO+gvACfGuud7hibBJB1Y80/etA4qyhYKSM+0U9JdIEIr8+fQpo70nGPSSC3UpFr16rcmhysWmHjGwzHfhm8FKfSq2XfKJi2qjU9FizgIjcxWbnYtFgXn6I7Vkf6bRp3p7JYKpYXWqlj4kQJMI58CeculKXPObxpvGPteuaqI0wmh0Su6fN0ftTRviVMnKnAVV/sj415CikDrcyC/XrRFy9A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RQZfuvJnXI/eFijRUp7QGqWSIetSaEZLmeIl9T5qHUQ=;
 b=SXmYizy2/71YoR+w0R7xKG7ywFsndbHvzaml6Hx5jHXgcGw2lUObQWxR/+WAC3AsmEGw+WWJq4mIoXIQXVBre6byj7BcaxOsqdOmo1eVzg0elZuhdv4wbkR7XQcxw8rr2X4i1eSALJzSgGTaUqAAG2DanonSj4LnNh5HrI09BYC3jz8MffypZUWMvDU0m+8A0rNLVCIM5R7JxRF6aU1e/qVhalSit3YR90DcqothrsMJLxA0UvQ4pPEcgyZqsmxbjAAkAQoBumR/hm4VKlc94ImXdSArKaVXdzVdnt97SbIfkdhcFpDrf3yxgOtDvF8N10oQK7yq/VBl8ZvZiiYaRQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RQZfuvJnXI/eFijRUp7QGqWSIetSaEZLmeIl9T5qHUQ=;
 b=Zwsu+sAgzcMOJsfqSk/IgJ4xksg03Oi7Z7fFfQb0YAVgNlDMtPMLHYsaTMt1IuGRAHXIRxPcggJUUPBW2ngpo1z5Qm9ie6sOn1bzFrn8kBip6w5bINS4V6xJfS3SVrLIKdXz8NzEXYLeJKwO+HLd2bQNPuu3EStNrBDjiBHJ7Tk=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9185.eurprd04.prod.outlook.com (2603:10a6:102:231::11)
 by AM7PR04MB6807.eurprd04.prod.outlook.com (2603:10a6:20b:104::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5746.21; Thu, 27 Oct
 2022 13:10:18 +0000
Received: from PAXPR04MB9185.eurprd04.prod.outlook.com
 ([fe80::b1ab:dd4f:9237:d9f8]) by PAXPR04MB9185.eurprd04.prod.outlook.com
 ([fe80::b1ab:dd4f:9237:d9f8%3]) with mapi id 15.20.5769.014; Thu, 27 Oct 2022
 13:10:18 +0000
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
Subject: [PATCH v4 5/5] gpio: mxc: enable pad wakeup on i.MX8x platforms
Date:   Thu, 27 Oct 2022 08:08:59 -0500
Message-Id: <20221027130859.1444412-6-shenwei.wang@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20221027130859.1444412-1-shenwei.wang@nxp.com>
References: <20221027130859.1444412-1-shenwei.wang@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR05CA0044.namprd05.prod.outlook.com
 (2603:10b6:a03:33f::19) To PAXPR04MB9185.eurprd04.prod.outlook.com
 (2603:10a6:102:231::11)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9185:EE_|AM7PR04MB6807:EE_
X-MS-Office365-Filtering-Correlation-Id: bbe4d484-b5b5-4daf-9c43-08dab81c980e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ZoKjo7GUdyH/MN7V9NB08SogM3y8M45pXZqqqInG5i3kzezRHKDYST4uci+oWCJFdcoini8tpnKqbqWFasyHxL5CrWwDgp8Rb3dSSQ8hE1Ww7p7Kx4HtPcdD8VvsEmdAikcFIqbpG/c+OzW/TJn0rwHMg2zs6Rtz34NJ7TW/d2LQ3aDNHRng/MD7ND+o092s/6M0gr2qrEoUuwz+C2nT0JUjp3QRHLcrG1Y3TjukWrWKMxX7B8zSXbtLxKs+wWJAC4fpDURv2hxxz1ZlY8LYEBOC20iVgwdIzb1znWz293ExmjW8xHNsuxvwPXiYg9u8xKlNsHmlDf9F8wLe1P2yLXcaLBFG6aVKLUzmy7My5dbXacL1hWXL3C1dDQyQdoyPTV0kCoXn6Xo7vzM7nhg+05C+iShJ0PyruLBAzzaAKHrQn6nPTswvorw1bKF/kIOHOPZmLC8RCqYtukPmsCcSXxvxi91G1dSEMD/fcAiPKtQgGOCdgH5JHXP+NpMYN6EreZhzh/PCi4cz44ZMKD3fLChTKQ+Re1TOOFlYjCwethRezlATQHp252xPffH2xF3n5ZTle9ZgggLfAK+xIwEXxjUBX3+dBJLPAUa8NWDozh1DTeWhC0O3n4GyuycEGUnXBy2N8aUpsckrZmdg/dXIaBlVeLT8MN8zcq4XdK0Gx/0rHY/Yb+SIz8e6QtKD04XwdRdPG/hMYoGgI3/7tMcWHYX6n2VR7Mr4j3NsC3h9kRS7z8ugw0aq14vOOGkPj6Hoam9Cw+jZDlIjROlwpNc1VA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9185.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(136003)(376002)(396003)(39860400002)(366004)(346002)(451199015)(55236004)(1076003)(6512007)(26005)(52116002)(6666004)(83380400001)(6506007)(478600001)(186003)(2616005)(44832011)(2906002)(6636002)(5660300002)(54906003)(8676002)(110136005)(6486002)(316002)(41300700001)(66556008)(7416002)(66946007)(66476007)(4326008)(8936002)(36756003)(86362001)(38350700002)(38100700002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?YgIj2yHyuQttUD4ER99SAf2r8yK37aMz2NAtDPwWH1XUrUfdH00azFHh/GTs?=
 =?us-ascii?Q?WSFghLGywVecVp+hK+ho8vT6vqpSwhDErMYS3skT6VMSIwmtJR4VqMyOcqXL?=
 =?us-ascii?Q?WhUrfg1FMzjvS2ZdzhW9NsGeaL85m7VeOmpiRsOPR32c8/DTeWbZAljlIMwZ?=
 =?us-ascii?Q?LgoDqi1HllTRvCZoDLfNI2eB0BZjBqykk4g4+oA2Arm9SxxzWQUjHB6BrEv5?=
 =?us-ascii?Q?R5iBf69WRyo0gCTg97aAmAtC+4oP7vRU6kXd6buT8dszfSexnotHQjiS2Jyc?=
 =?us-ascii?Q?x3M0pHm+0WLfUTq4ouIIi+6np4ZqtAdz+WcgF8p2wUsLjkvhJC5r2VGTRZlV?=
 =?us-ascii?Q?2YU87GkuPZHrj2lrIycI394tnuzccqNRXQpYQp07XbqXzTlpEegf2FRgAY6S?=
 =?us-ascii?Q?9m0RgvCZMAQoC06BbcvVfFPN8p1NaDHrCX9aUrAT10yYg284XWk/64oPuS3z?=
 =?us-ascii?Q?wUae1ExGBW2U+ehlhmsmr27bgWH5iVQq1PlmHUEaBHkSWz7PvByuToJWUGTu?=
 =?us-ascii?Q?PGPV9WLYHGT+3+vIPiUPl7nvQ7jlgyIWKaemE8FjAGR0cMjxBkFuUZQqVCjz?=
 =?us-ascii?Q?8r/ys7177nkjwXSNQA4/1WYtJ2g/PzS2HTq3OWescjK2/vZ4ZIoDvTGZoC5K?=
 =?us-ascii?Q?NPci+oFPTOO6PJo2Q4oXVUN8/XnoOlBZcjNdmmOeflod2yZ8QuIkjYts2ODa?=
 =?us-ascii?Q?dnUoXEnr2Lq0PmV73VzmtY+yCiTQeWmaJm4tDVFhmw2RpwLn3CWMvEIIYn5/?=
 =?us-ascii?Q?yeQwFC9HHPNNqzVXZ4koOfgqS7iDdNs0BKk4klk8b+N+iObKLIhitLfgwWg3?=
 =?us-ascii?Q?JKokS9cNLG4cZRSFoWjDvnwWzk9XGmKaMPQW2ck+zcJ/kxtYYy4xMtaz7hhh?=
 =?us-ascii?Q?Oyj9IKxKFD1kfKHV/7yUiQsICJyFMVG6uwQWFMg0cQsh4BjuCVdnxk0iBU+M?=
 =?us-ascii?Q?8mF5mt0E6ftWkhVRkK3d2/QhYi7nldfbc7j2LvvEvcbH7gE/Jn1R9hrS7Lub?=
 =?us-ascii?Q?gAKjQ7FVCwM2moqEf2sAH1IKlNPEoljCd+lQgKnseeteYlRfZ0ZutO3RcMcy?=
 =?us-ascii?Q?N5BKbByZk8TeTn4XEfw8i1KaUgDcoxqK4igN6BEgqoamKpsmY28jBXP3ACoP?=
 =?us-ascii?Q?LvcQL6riGU2B0bPQQQkQXFxubJrcmsH/pjaVGZzhRRl6xyk0cMVQVL3TSyn0?=
 =?us-ascii?Q?zF2ZycgCK958aGQ0WGx5FOGVvIbEJN/lef48rhKXpxwJ+04Aub8ict6JijAa?=
 =?us-ascii?Q?QBAtie0BUl5KLFONu1N8MLQc1dvc3fgWPFMwjIU5s9cYNlx0F6rbnhK2pJhA?=
 =?us-ascii?Q?+ik4+w39wzZrCbjCvNc6u7wfP4PwWmzM+NweE3qZHsq4lUmkVPb69L3PWAT0?=
 =?us-ascii?Q?nCfGRxknXhucsglOs+fyrU/YCDXuimBxBqf6t8XXf11nfab1l2+qAtJsSwl5?=
 =?us-ascii?Q?x5EGLVM7ZqsRJ68B3pq4k7vuxAmH8e5C1nH1d8gUH1gnnaPCQq6SHfhqtk8u?=
 =?us-ascii?Q?iMDp4JVVgSOD0tliBRFnSEdNKKoblPluMZjsWr82vz2+25rKFBbzYlEMsktf?=
 =?us-ascii?Q?iln/8mb7g4YTsp1ueQh9RZGrmMkhL5QqilI8avy0hfkIXAmPpPeppzociHeb?=
 =?us-ascii?Q?Cw=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bbe4d484-b5b5-4daf-9c43-08dab81c980e
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9185.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Oct 2022 13:10:17.9333
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0SRmzfqxWFSgKVcXQb0836FvTV6k9/ii7Cr3FsI9Ex0HgQ8m22+VL5lauidzW9/BQJVmLwRTqOb6TLGMFMYtJw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR04MB6807
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
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
Reviewed-by: Peng Fan <peng.fan@nxp.com>
---
 drivers/gpio/gpio-mxc.c | 92 ++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 91 insertions(+), 1 deletion(-)

diff --git a/drivers/gpio/gpio-mxc.c b/drivers/gpio/gpio-mxc.c
index c871602fc5ba..d5626c572d24 100644
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
+		port->wakeup_pads |= (1 << gpio_idx);
 	} else {
 		if (port->irq_high && (gpio_idx >= 16))
 			ret = disable_irq_wake(port->irq_high);
 		else
 			ret = disable_irq_wake(port->irq);
+		port->wakeup_pads &= ~(1 << gpio_idx);
 	}
 
 	return ret;
@@ -365,7 +383,6 @@ static int mxc_gpio_probe(struct platform_device *pdev)
 		return -ENOMEM;
 
 	port->dev = &pdev->dev;
-
 	port->hwdata = device_get_match_data(&pdev->dev);
 
 	port->base = devm_platform_ioremap_resource(pdev, 0);
@@ -498,6 +515,78 @@ static void mxc_gpio_restore_regs(struct mxc_gpio_port *port)
 	writel(port->gpio_saved_reg.dr, port->base + GPIO_DR);
 }
 
+static bool mxc_gpio_generic_config(struct mxc_gpio_port *port,
+		unsigned int offset, unsigned long conf)
+{
+	struct device_node *np = port->dev->of_node;
+
+	if (of_device_is_compatible(np, "fsl,imx8dxl-gpio") ||
+	    of_device_is_compatible(np, "fsl,imx8qxp-gpio") ||
+	    of_device_is_compatible(np, "fsl,imx8qm-gpio"))
+		return (gpiochip_generic_config(&port->gc, offset, conf) == 0);
+
+	return false;
+}
+
+static bool mxc_gpio_set_pad_wakeup(struct mxc_gpio_port *port, bool enable)
+{
+	unsigned long config;
+	bool ret = false;
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
+		if ((port->wakeup_pads & (1 << i))) {
+			type = port->pad_type[i];
+			if (enable)
+				config = pad_type_map[type];
+			else
+				config = IMX_SCU_WAKEUP_OFF;
+			ret |= mxc_gpio_generic_config(port, i, config);
+		}
+	}
+
+	return ret;
+}
+
+static int __maybe_unused mxc_gpio_noirq_suspend(struct device *dev)
+{
+	struct platform_device *pdev = to_platform_device(dev);
+	struct mxc_gpio_port *port = platform_get_drvdata(pdev);
+
+	if (port->wakeup_pads > 0)
+		port->is_pad_wakeup = mxc_gpio_set_pad_wakeup(port, true);
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
@@ -537,6 +626,7 @@ static struct platform_driver mxc_gpio_driver = {
 		.name	= "gpio-mxc",
 		.of_match_table = mxc_gpio_dt_ids,
 		.suppress_bind_attrs = true,
+		.pm = &mxc_gpio_dev_pm_ops,
 	},
 	.probe		= mxc_gpio_probe,
 };
-- 
2.34.1

