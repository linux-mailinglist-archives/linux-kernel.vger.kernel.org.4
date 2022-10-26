Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E233860DA9E
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Oct 2022 07:34:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232768AbiJZFeI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Oct 2022 01:34:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58496 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231341AbiJZFeG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Oct 2022 01:34:06 -0400
Received: from EUR04-VI1-obe.outbound.protection.outlook.com (mail-eopbgr80075.outbound.protection.outlook.com [40.107.8.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1CBE8ABF2E;
        Tue, 25 Oct 2022 22:34:05 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=L84i+e0mKixAq+gxS3Ozf1ehnL3/os//hVg+NLPUOI/wxhLSIuTCHhfGXaLeC7cq4Yh8JmGS2onSMJMwfnaAdwWgfHPyZWKR1KLG013RFNyMH5n9U810BLFSpBQb/WpCfzIe5jPcj3rAgQETB2XWHcVl848fcd6kW6bswPAnWPzlSKNd1lrszgip1CQo33dHBGIZU6tJUIWKhjUSRHEOlYoISm87sIODhRJ2KaFDwbokKTryAMD6voiTNm45wAy63bb5sXuWsa+DnlRrO+iyCR8BIg/NwwA0qzAcT7g3ktMFCQAgK/qibIH5nYwrKaAZ1n9vXBWXwg0ErNbw6qoxuA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cdxg55/7N1nGO6CRu6XTsjRG64aTcb9o3lcUQ2BvpBQ=;
 b=VL5Defte44F2U8mAaqKE45lJK43D+EjFLYOeQxP6Vys2shdu86jhhALL3SBBgfQDVxbB2NIWiyb4SEJFwKUwiqIb8COmPSHudHnz+aXM3bNgXmMx5bdeOCW2n7qNowABfq7Mq+tW2krZR8ZbokUIKm2+f2c9k1aJlfqhSeEstt9I0cjsowHYqVKc+EBZibISJV7Gbo+Z1maZvnKAMw9SEkz4td72f1xqdoX2xkdvrlUpUytSC2UYCjweGDF6xUidnORJXmVehPllxl6lJGWUmzb+JS/88V4qg3i0OThEmBDtEc1ui8O87llLZqNM+La9O7NbCElcH/krCSnFslZV/A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cdxg55/7N1nGO6CRu6XTsjRG64aTcb9o3lcUQ2BvpBQ=;
 b=kH8OzoUlgAsrTSf2hvwJ/6Y8jo+4oNRJNb9rvbjqQv5TrxbOEDZbVr5KIDvEtmf7SOA+hE5CgzHw7znKySzt20a5QBprPv7jPScGzs4cejVqQqHB+LqaIKaF8VhkVm4x0r6DWEPLMhE7M5CKb2VK2wRYvZG5xszNGcUxXJjbDj8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by AS8PR04MB8739.eurprd04.prod.outlook.com (2603:10a6:20b:42c::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5746.21; Wed, 26 Oct
 2022 05:34:00 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::1587:379:da06:2f18]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::1587:379:da06:2f18%5]) with mapi id 15.20.5746.028; Wed, 26 Oct 2022
 05:34:00 +0000
Date:   Wed, 26 Oct 2022 14:20:11 +0800
From:   Peng Fan <peng.fan@nxp.com>
To:     Shenwei Wang <shenwei.wang@nxp.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        Dong Aisheng <aisheng.dong@nxp.com>,
        Jacky Bai <ping.bai@nxp.com>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, imx@lists.linux.dev
Subject: Re: [PATCH v3 5/5] gpio: mxc: enable pad wakeup on i.MX8x platforms
Message-ID: <20221026062011.GA18160@linux-1xn6>
References: <20221025183244.615318-1-shenwei.wang@nxp.com>
 <20221025183244.615318-6-shenwei.wang@nxp.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221025183244.615318-6-shenwei.wang@nxp.com>
X-ClientProxiedBy: SI2PR02CA0052.apcprd02.prod.outlook.com
 (2603:1096:4:196::18) To DU0PR04MB9417.eurprd04.prod.outlook.com
 (2603:10a6:10:358::11)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU0PR04MB9417:EE_|AS8PR04MB8739:EE_
X-MS-Office365-Filtering-Correlation-Id: 6077a7e9-b25c-464d-ae92-08dab713af27
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: HbaW83QB38af+mTula1tbBL0qBFmN/SlQ8S523rwp+9iA1i83DvFx6T73ma3zMMfcCIz+RXvBdvGAq1rjgHDGPcKd/tqESnLOu2m6/F0agh2PSqY5t9JYth6iV1so9gBG3j4CYGVKubO0ckp+nvg91KIO3kitKvdo6qSb/0VkuvE4XO7aO0+Er/MAxHtkb5h+SIQc8bFVwRigdzd8pNgahGRHkNzZbRjvYg5X2Mk/eAOL734P8YX1Zn32XYYPf5fI7NES4NQk5gDOoBagZE5xhEHTH/4eow7g6BFcVWzs1tkPuqfWxjywZdB0sY0DxMQHReVbAsp6ENfBjqODEI8H5mCEABWn2p1HTj1UhC70z56ZIuvGtWWda5myy9coTMNvVleE9omHIkTynDUWBHqcR6hWNnR+Kk1xr6KWPYpAxU6VY+N9MwOxh45A8dpXnzty1o0hXwILYN3w30mLvvsRcsp+9+xdLuTr6TS9rHxfoYP5Bdt0QNJfSaMv+lprSAmM7vg1m0084aouG5VWuc1NVMP8TIJ95x1WHGipvzBX7E/bSO84D8l0ZKYZB8OMlJ6XxMd4VfpWXTaxw8yU4Aa7NxRZqFWmf6fjxiAymQTC+K+jx5/ZAeeiAjZ2T2wiGeKzffGY6RVyH8swfOm6I2pthYH1UzgftLimqlkSroaXGFzguDkEyCO6sr26fvg5e/lGqJaoD08jJgIQtCAQCOxnbw+226HaqEk4ByZsbPbqTmjhryLR2Dn0YG8cNTqrnY+VwIpCiYMCYO3epzyOdyg2Q==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(7916004)(4636009)(396003)(346002)(39860400002)(366004)(136003)(376002)(451199015)(33656002)(316002)(7416002)(5660300002)(2906002)(4326008)(41300700001)(8676002)(38350700002)(66556008)(478600001)(6486002)(44832011)(6636002)(83380400001)(6862004)(6512007)(54906003)(66476007)(38100700002)(6666004)(52116002)(26005)(86362001)(1076003)(9686003)(186003)(6506007)(8936002)(66946007)(33716001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?if3sKptwQDo7tLiGNLkLuBGkNLyWQg2lfEpV757VLdh232XyqNPQrqP3e3mQ?=
 =?us-ascii?Q?YzPAoRvBiUVg80++rYz/VnBo8249ucML8k8Ib8yEtNGbANUDmXwhTwJJHsPX?=
 =?us-ascii?Q?l5+lI6ZbKgDUA2hNroY5jNaEdpjOebZoKgBtP+AH+fKUcH8iT+EyfpDxj6Mv?=
 =?us-ascii?Q?ZxUeIxPrJywIiGpv1DzEhIlb5dSq9nCjuqtg3pmGAB5uj+OfIm35Cvp7lEAd?=
 =?us-ascii?Q?9sWssPVrHK5zObkUx4NvP70EB8HUTPplVIDRLB0gRWyFEG9J+0neWEfg7YQ+?=
 =?us-ascii?Q?y4a6KXl5w2ZjijCDuQ5jmDp+56enWzI7fSYsZ5ZZ2ChFl9v3CecnwoMt/Umk?=
 =?us-ascii?Q?mVqL9Wxg+PU4A1EwW6u261YNIb20BsnZaDNGgKMEdhP0bMDQKIVmzcroFsS/?=
 =?us-ascii?Q?GsCw2D74S6ZWH5rvHCtYKlSOZ0+DQVLhWyR8NRty8vtS2cXXhZOop89ygvnL?=
 =?us-ascii?Q?knnIHsG6UWIGvqYs0s/9iNCD/g8yMv7L8/mujSY9dp00FAB8PglFF6xtnL21?=
 =?us-ascii?Q?VMhThve40GhNCFyAtW3n9c+sFD5mR1SrmFUtRiH6dTN5n8krFq4lgLPv95X8?=
 =?us-ascii?Q?L+n7EkrOw2Pb9zMVnltVLnC3uKGgtvFcr9aXxzWt6Hv7mCYIwh2DGffOSRTj?=
 =?us-ascii?Q?ju4Si23u6oFHN6GivwcUI1F7exyAZrNs8xED3XyQ2+RWarONu7EPgPNwy6v6?=
 =?us-ascii?Q?AnDhLjmInZLas0TMfbIFegPOBl3oUNSTSR2gXTN9SSggTkmLmVHFyVW8fu00?=
 =?us-ascii?Q?RRsZxgfDEgIuLQbvoEABi7dv77mrWgD/Q5S0Hj9LKJ4iwn+P7r90DH69NdmX?=
 =?us-ascii?Q?rd32PVNnFWmDI9kiepmwo5Ref10GE3le2P5kb7QNHnOClhxG4A58IW8mbWrE?=
 =?us-ascii?Q?tsCAEV9/LARGhebF5hLiaS8KPwNgm1isAKarGiPyc8CRjmt9gyRst4cHzPtI?=
 =?us-ascii?Q?6XEOndaKsZBQDmjgDd7zya8Fwglkqr2rrPsLZP2h9Eu+gdK11hFz+jXfFygE?=
 =?us-ascii?Q?ItBcDL6UA0Ul+Zq8l9wkm84cb8s9R04WG+srrlFJbl5DexxX5kXKZdtl/7ai?=
 =?us-ascii?Q?1EejDVsoNI2GsjN3tsRM4cErjIE8uKd6r7E/3bd4vNO79MKwqWHFeyIBy05E?=
 =?us-ascii?Q?t5tNLYjUSa6kZBIDsbc6KMMvsVs6ZCjO6ISCP1NH5jHO3DS6EDNQCEanQYV6?=
 =?us-ascii?Q?/0zGC6pQsJCcTMxP9HZofZZ2ipBPm4wX/z/rrGqz4fRaOY7jBpIvliwppJk3?=
 =?us-ascii?Q?RN9kYdjnmWqsugF1vsOR4uGR7wWNs6FZMNBvksO42xOOQYzmCJUJrBjPD2Oh?=
 =?us-ascii?Q?ytltbGmi6G7vmAnPSmEunDeudaVuUa8Ca75L330ELbjrpy5hcmmmNbsFU3J/?=
 =?us-ascii?Q?R5j8ExGUd4pjFrSmRyFF9hBAjraBRz7MdE8LdBJ5I30QP7mXc6PT78TIuKWX?=
 =?us-ascii?Q?N6OqvQJO/fh+4DV9CSnAWFI6xulrOqW7K5Z03btHIKYle7zgbfw5yZfI4s5W?=
 =?us-ascii?Q?6oBlD3d2HCbaybbBUwLei3lE3eQ/+301Ldlkiuk8rKxb89s0y+HKXnsIgGh/?=
 =?us-ascii?Q?dtg3hPCKP9eNe3G+4NDvQEVaesonWgbv1QZyXxdJ?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6077a7e9-b25c-464d-ae92-08dab713af27
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Oct 2022 05:33:59.8783
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Bp185UxY4beit4P++Y7+X2x5mGG6+XciyZd4QEgdBZfQQs8bV4jF/NXoIDb8zZ5iBgLriksfKeNQCT8obOWfQw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB8739
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 25, 2022 at 01:32:44PM -0500, Shenwei Wang wrote:
>On i.MX8QM/QXP/DXL SoCs, even a GPIO is selected as the wakeup source,
>the GPIO block will be powered off when system enters into suspend
>state. This can greatly reduce the power consumption of suspend state
>because the whole partition can be shutdown. This is called PAD wakeup
>feature on i.MX8x platform.
>
>This patch adds the noirq suspend/resume hooks and uses the pad wakeup
>feature as the default wakeup method for GPIO modules on
>i.MX8QM/QXP/DXL platforms.
>
>Signed-off-by: Shenwei Wang <shenwei.wang@nxp.com>
>---
> drivers/gpio/gpio-mxc.c | 91 ++++++++++++++++++++++++++++++++++++++++-
> 1 file changed, 90 insertions(+), 1 deletion(-)
>
>diff --git a/drivers/gpio/gpio-mxc.c b/drivers/gpio/gpio-mxc.c
>index c871602fc5ba..a6fe5ed3d320 100644
>--- a/drivers/gpio/gpio-mxc.c
>+++ b/drivers/gpio/gpio-mxc.c
>@@ -24,6 +24,12 @@
> #include <linux/of_device.h>
> #include <linux/bug.h>
> 
>+#define IMX_SCU_WAKEUP_OFF		0
>+#define IMX_SCU_WAKEUP_LOW_LVL		4
>+#define IMX_SCU_WAKEUP_FALL_EDGE	5
>+#define IMX_SCU_WAKEUP_RISE_EDGE	6
>+#define IMX_SCU_WAKEUP_HIGH_LVL		7
>+
> /* device type dependent stuff */
> struct mxc_gpio_hwdata {
> 	unsigned dr_reg;
>@@ -61,6 +67,9 @@ struct mxc_gpio_port {
> 	u32 both_edges;
> 	struct mxc_gpio_reg_saved gpio_saved_reg;
> 	bool power_off;
>+	u32 wakeup_pads;
>+	bool is_pad_wakeup;
>+	u32 pad_type[32];
> 	const struct mxc_gpio_hwdata *hwdata;
> };
> 
>@@ -130,6 +139,9 @@ static const struct of_device_id mxc_gpio_dt_ids[] = {
> 	{ .compatible = "fsl,imx31-gpio", .data = &imx31_gpio_hwdata },
> 	{ .compatible = "fsl,imx35-gpio", .data = &imx35_gpio_hwdata },
> 	{ .compatible = "fsl,imx7d-gpio", .data = &imx35_gpio_hwdata },
>+	{ .compatible = "fsl,imx8dxl-gpio", .data = &imx35_gpio_hwdata },
>+	{ .compatible = "fsl,imx8qm-gpio", .data = &imx35_gpio_hwdata },
>+	{ .compatible = "fsl,imx8qxp-gpio", .data = &imx35_gpio_hwdata },
> 	{ /* sentinel */ }
> };
> MODULE_DEVICE_TABLE(of, mxc_gpio_dt_ids);
>@@ -203,6 +215,7 @@ static int gpio_set_irq_type(struct irq_data *d, u32 type)
> 	}
> 
> 	writel(1 << gpio_idx, port->base + GPIO_ISR);
>+	port->pad_type[gpio_idx] = type;
> 
> 	return 0;
> }
>@@ -254,6 +267,9 @@ static void mx3_gpio_irq_handler(struct irq_desc *desc)
> 	struct mxc_gpio_port *port = irq_desc_get_handler_data(desc);
> 	struct irq_chip *chip = irq_desc_get_chip(desc);
> 
>+	if (port->is_pad_wakeup)
>+		return;
>+
> 	chained_irq_enter(chip, desc);
> 
> 	irq_stat = readl(port->base + GPIO_ISR) & readl(port->base + GPIO_IMR);
>@@ -306,11 +322,13 @@ static int gpio_set_wake_irq(struct irq_data *d, u32 enable)
> 			ret = enable_irq_wake(port->irq_high);
> 		else
> 			ret = enable_irq_wake(port->irq);
>+		port->wakeup_pads |= (1<<gpio_idx);

"1 << gpio_idx"

> 	} else {
> 		if (port->irq_high && (gpio_idx >= 16))
> 			ret = disable_irq_wake(port->irq_high);
> 		else
> 			ret = disable_irq_wake(port->irq);
>+		port->wakeup_pads &= ~(1<<gpio_idx);

"1 << gpio_idx"

> 	}
> 
> 	return ret;
>@@ -365,7 +383,6 @@ static int mxc_gpio_probe(struct platform_device *pdev)
> 		return -ENOMEM;
> 
> 	port->dev = &pdev->dev;
>-
> 	port->hwdata = device_get_match_data(&pdev->dev);
> 
> 	port->base = devm_platform_ioremap_resource(pdev, 0);
>@@ -498,6 +515,77 @@ static void mxc_gpio_restore_regs(struct mxc_gpio_port *port)
> 	writel(port->gpio_saved_reg.dr, port->base + GPIO_DR);
> }
> 
>+static int mxc_gpio_generic_config(struct mxc_gpio_port *port,
>+		unsigned int offset, unsigned long config)
>+{
>+	struct device_node *np = port->dev->of_node;
>+
>+	if (of_device_is_compatible(np, "fsl,imx8dxl-gpio") ||
>+		of_device_is_compatible(np, "fsl,imx8qxp-gpio") ||
>+		of_device_is_compatible(np, "fsl,imx8qm-gpio"))
>+		return gpiochip_generic_config(&port->gc, offset, config);

checkpatch should report warning.

>+
>+	return 0;
>+}
>+
>+static void mxc_gpio_set_pad_wakeup(struct mxc_gpio_port *port, bool enable)
>+{
>+	unsigned long config;
>+	int i, type;
>+
>+	static const u32 pad_type_map[] = {
>+		IMX_SCU_WAKEUP_OFF,		/* 0 */
>+		IMX_SCU_WAKEUP_RISE_EDGE,	/* IRQ_TYPE_EDGE_RISING */
>+		IMX_SCU_WAKEUP_FALL_EDGE,	/* IRQ_TYPE_EDGE_FALLING */
>+		IMX_SCU_WAKEUP_FALL_EDGE,	/* IRQ_TYPE_EDGE_BOTH */
>+		IMX_SCU_WAKEUP_HIGH_LVL,	/* IRQ_TYPE_LEVEL_HIGH */
>+		IMX_SCU_WAKEUP_OFF,		/* 5 */
>+		IMX_SCU_WAKEUP_OFF,		/* 6 */
>+		IMX_SCU_WAKEUP_OFF,		/* 7 */
>+		IMX_SCU_WAKEUP_LOW_LVL,		/* IRQ_TYPE_LEVEL_LOW */
>+	};
>+
>+	for (i = 0; i < 32; i++) {
>+		if ((port->wakeup_pads & (1<<i))) {
>+			type = port->pad_type[i];
>+			if (enable)
>+				config = pad_type_map[type];
>+			else
>+				config = IMX_SCU_WAKEUP_OFF;
>+			mxc_gpio_generic_config(port, i, config);
>+		}
>+	}
>+}
>+
>+static int __maybe_unused mxc_gpio_noirq_suspend(struct device *dev)
>+{
>+	struct platform_device *pdev = to_platform_device(dev);
>+	struct mxc_gpio_port *port = platform_get_drvdata(pdev);
>+
>+	if (port->wakeup_pads > 0) {
>+		mxc_gpio_set_pad_wakeup(port, true);
>+		port->is_pad_wakeup = true;
>+	}
>+
>+	return 0;
>+}
>+
>+static int __maybe_unused mxc_gpio_noirq_resume(struct device *dev)
>+{
>+	struct platform_device *pdev = to_platform_device(dev);
>+	struct mxc_gpio_port *port = platform_get_drvdata(pdev);
>+
>+	if (port->wakeup_pads > 0)
>+		mxc_gpio_set_pad_wakeup(port, false);
>+	port->is_pad_wakeup = false;
>+
>+	return 0;
>+}
>+
>+static const struct dev_pm_ops mxc_gpio_dev_pm_ops = {
>+	SET_NOIRQ_SYSTEM_SLEEP_PM_OPS(mxc_gpio_noirq_suspend, mxc_gpio_noirq_resume)
>+};
>+
> static int mxc_gpio_syscore_suspend(void)
> {
> 	struct mxc_gpio_port *port;
>@@ -537,6 +625,7 @@ static struct platform_driver mxc_gpio_driver = {
> 		.name	= "gpio-mxc",
> 		.of_match_table = mxc_gpio_dt_ids,
> 		.suppress_bind_attrs = true,
>+		.pm = &mxc_gpio_dev_pm_ops,
> 	},
> 	.probe		= mxc_gpio_probe,
> };


Except the format issue, patch looks good to me.

Regards,
Peng.

>-- 
>2.34.1
>

-- 
