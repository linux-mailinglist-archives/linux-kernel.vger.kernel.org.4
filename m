Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 622DD60DC2D
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Oct 2022 09:35:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233156AbiJZHfd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Oct 2022 03:35:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50860 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233150AbiJZHf3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Oct 2022 03:35:29 -0400
Received: from EUR03-AM7-obe.outbound.protection.outlook.com (mail-am7eur03on2048.outbound.protection.outlook.com [40.107.105.48])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC9172B190;
        Wed, 26 Oct 2022 00:35:28 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AxK/FvGuINc/9dCzLB2y/hA8Q5fFr8VDWA1Ip3Sm3fJ9h/dnzYbvWpTh1C46GYvCpkUEf5l1+7vcS81STyyt9YyE0R07hO+zEM0qOBVgvxgX42tLItyDlISBwa5dSECErBJVUMURRayIFt9P3hBB11A5rnZCH7TRAtCe4qGJTb5UVDy6/9624I6xE+HM+voODtMxllqTV8WxKQECv1qYVJwjk/1i1bktSTdHvz2X34LBvTati5gfmqHJpKphxXhgihDcVno34TQ7C0bwXvBqOmnH44RZRvmCEORrzU3lsmOwIyqwZbpPHBCq73MmizrcW/iR0Pz0sNAp4tFL7ObpTA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CURNi133/YCRMXdiHCI7veFYzUvVu/5i8InKrVl5XFE=;
 b=EPUtQghFat79XJY+OhZwI3RnFO31/OkTksQT6csiHRhHG5TD9Xp0cclrEnJrJDVO51CerRlJBVRxgOpERxo3ftHGMdwkrCmrl+xN14d/DUrKPXTpJZCDn+f4BBP5VrA8PNyZGSFvMRGKtvY/qSnx3UEYJjCBPwgYCR2RRtOThAzj/Ep+vCHSX7KlaFYhaTKOvHtHg6S1olFTK0yfD8LxknmZlEZJR4VzQJKFk30130bT4WoNw5E368o8PI3TnTDFnHAZdraIxnTW57TIgUu8RSDtsk3Ca9vHPnbhB2cwSgtFlQnjnimLxqv82VnhX2OkOB0sP4e1lIa+5f/YcDBfPQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CURNi133/YCRMXdiHCI7veFYzUvVu/5i8InKrVl5XFE=;
 b=QhA1NhPwMcdPp1n3cAjMFhozsNymyGzURRWPJYEAcgtk8yCz/FCLZWfjbvyJ0y9rJ9P2uBbTLmGCvhBfszoe4LsdEGUbY2NIEb85f3WLb2E370AywQWztqpq+LCoXUsefAq7m8WWSXGLrRxe31lm8gTHMbjJvtCbBiTlhp/ieNY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by AM8PR04MB7409.eurprd04.prod.outlook.com (2603:10a6:20b:1c5::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5746.21; Wed, 26 Oct
 2022 07:35:26 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::1587:379:da06:2f18]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::1587:379:da06:2f18%5]) with mapi id 15.20.5746.028; Wed, 26 Oct 2022
 07:35:26 +0000
Date:   Wed, 26 Oct 2022 16:21:39 +0800
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
Subject: Re: [PATCH v3 4/5] pinctrl: freescale: add pad wakeup config
Message-ID: <20221026082139.GB18160@linux-1xn6>
References: <20221025183244.615318-1-shenwei.wang@nxp.com>
 <20221025183244.615318-5-shenwei.wang@nxp.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221025183244.615318-5-shenwei.wang@nxp.com>
X-ClientProxiedBy: SI2PR01CA0007.apcprd01.prod.exchangelabs.com
 (2603:1096:4:191::11) To DU0PR04MB9417.eurprd04.prod.outlook.com
 (2603:10a6:10:358::11)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU0PR04MB9417:EE_|AM8PR04MB7409:EE_
X-MS-Office365-Filtering-Correlation-Id: e7bf4b77-fc25-445b-4453-08dab724a64c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: rsNxmMdaw4PM/wM4p/EnLwimnirzJjgqY1z9UEF6rhOBXtC/MZG2QDTTltonhyiA4uHTU81EAXVU9BcQ6zSDo8Ic28sG608yzzJZA8qWj7deAikj90LctiYHb7AJ5kANA4COSms/3Ssag2J841FRrF7UOjnNNjFKzkd0zc1tyIzHPmpm4AK8bTNRl7I7WuCGbm5GQMaqynvbu+K3shzFdYSVcdvTNeceDehZ5Ra86QXozCZUEPDoE88eUrqe8/qK++dA7g1SOd3xp92Pk5VVkk98//HdBA+1bdUWLmhBwvcC9ZPHTywy/rNe8PgN+lOOpsidPIqyOgfQ+pmQz4cuB4MBs++TpPIlRRTshyec7MuNWwy4aLDY9a7fzstKDLMR6mTbshGUpDp3ah6Hrdklf6WSgHEMG7atb8aJBVaSRWEksSE9v1u12tzXgOCntjYb1KVh/EggM51Jz/AkoCjW7TK8FoYuE7AoqOS8urNbHR+mUYOZzBY6/oVhHQH7xaFybbrnqxy8QyNIAz4U2HvsShD+UZAbzYDXW5awvV0I/vgocB1S0t+DtOxJqj7xNhaq/Zm9EPdVaE61wBTrHYBYywJMbKnI3z24psNumlN+zug9HTfxmCvi7wBYHuj9g1j1YXByWYbujz5MaSfG/QSJXO9kicz5hJc6Vov2Pgai/uU4pzvR87zNpgoL3/R8TZgOrO0cmAlG7QlI1IWRQo+5tKMaR0xk2Kv78w3+D1zCBTHhmlKL0TlKbJVL/r52azLMCdfBBA/ZQBqyxAIC0I91bQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(7916004)(4636009)(396003)(366004)(346002)(39860400002)(376002)(136003)(451199015)(316002)(6512007)(6862004)(52116002)(9686003)(54906003)(44832011)(8676002)(7416002)(33656002)(6636002)(66476007)(41300700001)(4326008)(86362001)(26005)(66946007)(66556008)(2906002)(8936002)(186003)(5660300002)(478600001)(6666004)(6486002)(1076003)(6506007)(33716001)(38100700002)(38350700002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?cYM7ZcQvqBt/229D7CCUHEGyYOijAHoLV3wQxLdLpvjr355UVUTlVDnFw/eZ?=
 =?us-ascii?Q?mG+3kT76rgucOuV2d6psf15xj8tjksDwXIYegl6du7rgKqqH+W8iLn0IL5zP?=
 =?us-ascii?Q?8WF8aRhW5VMXpglqT01ZKCTlM1MClsMY3cydA2+cA6dkogYFGQHFjFmr3gN8?=
 =?us-ascii?Q?vaz14noDuKipoNIPi5wL3VSpwR06zXs3OjF3rYeZaU5fJEIzHj6UsqpLRhHG?=
 =?us-ascii?Q?AbankSl2KZIYCDDClmFTqwIe7pfvL4KW7dCVJ/3s4VA1lGMuntlEE/diYMPA?=
 =?us-ascii?Q?RVOSypzAmRYRRp2DGzD2PZwBJVSTQKyMk/f28472ii+llTWLMYSVTLqjTUdg?=
 =?us-ascii?Q?+aLgiMBaYAifjaIIj7GDi8JbqdevdH9UpGEJJOvCyZD/0VOhlw/bLKKd0D8y?=
 =?us-ascii?Q?MCOfRJf5vPi7VTa6zKahDU5WETRPDw4Q9xXZOJEei7gjV9FN+Uk3QL6l4RJT?=
 =?us-ascii?Q?NV3hBjqyDsXKK4Pr0A/xO8PYTgUSDX0mH8buf4jIDN/Z4KbqgGaEa8iVJuDt?=
 =?us-ascii?Q?FWbIPp0SGXY8gr0Rrdbjg1HYG8JKkkxXjGJrmA9/Fd5eFD6Q0FUoykiYdmW0?=
 =?us-ascii?Q?kmQ255PCkj/HfQZiTw+IJ8SBjAG3HIfuPwzQfU5MAA+ADOK9J0mAFa7wbri8?=
 =?us-ascii?Q?tUsmTcLMU2QwO2ypsQ6Ilo/nbe/FzukJBsentkNO189owlV8+UugWE1bzaok?=
 =?us-ascii?Q?tk9IrwyYWQb03CCpvvjvwIScKDVjICLXa1EnO3TipEcBL4nkZ5Cs/pGUHCfU?=
 =?us-ascii?Q?LdBb3odxKhMgjrLdrHmaOL32wTAJ55vOPpUh7DpWOxIjA/ZO5rLVTHqhmLOm?=
 =?us-ascii?Q?f8Bdz0uKDIV5pv6IdL8X6FAfVxv52YvHYSAzDKB1eBmKX4aCxy7TvRJkQ5o9?=
 =?us-ascii?Q?qqTfLfJG5m8I9RmN1kxBzFax8E4AhGzZq78y3XjQ5bxWZuY4cDOaOd77dpC5?=
 =?us-ascii?Q?utbaxCVwc2Z6V+ivuNljyjLqUcdUE+VA7FpSG7rsM2cqV4OQrPUpBWyiKwKx?=
 =?us-ascii?Q?3t2+9p1cJHHpgWse+jO6RROYTToR48ECSt4LAiv7M3z2QHRmi2YV9nHLGdwW?=
 =?us-ascii?Q?mt85bTQCtpLxWNbtu0dYVFb9RZqMoiidrVDH6ND4hd5AA0BJVBDexY6dATxk?=
 =?us-ascii?Q?xRou3pvdZFWR+YJnL0XUU6XvECKKiK7MvYPIrD83WKaLtYHs6sRiCuD6Sn/0?=
 =?us-ascii?Q?Br1yh4eM351M8g0YKWwY8o1/oDtqM6nxa1uzxhpuypZQkLxy6Kit0io/yX3X?=
 =?us-ascii?Q?wETFububGqkuelOm1NeP0NgSi2J3sEV8EfIKKH7zzS+YC68AUv9N9ZHhVkJN?=
 =?us-ascii?Q?WS+gM+71B9VVuw9uD10a9oAQIbX/qLGGtlHVZM0HbleYIk4o5VIw71s2vVDz?=
 =?us-ascii?Q?kP4BWoU96VtrPqI0JFshlwmt94HB/DcZt2awSUnxiM/CZsaLhQc8UUnYH2+1?=
 =?us-ascii?Q?H+qHWQnApovGwiQTebJp+4FVvnVoQLhQLmxo63p8XDihN3DL79yAmvxXrlEL?=
 =?us-ascii?Q?xUt3ZjounZWZdSRV/qCaDZg8kBPhLRRy4x8uRRCRpU9+D7StuNwSK7nZ4wNz?=
 =?us-ascii?Q?RMw3wJ6YERN4TxEM0aaqKmBMj1uEpPKcBOejdC5k?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e7bf4b77-fc25-445b-4453-08dab724a64c
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Oct 2022 07:35:26.4630
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ITobXiArzeY36ogS+hiDDVIsVioSDOeIFnbOETW0HfDx2sxGfClCemJ+UxuvbxfnH3zfveTmnRP/aCIJMUYvGQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM8PR04MB7409
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 25, 2022 at 01:32:43PM -0500, Shenwei Wang wrote:
>add the logic to configure the pad wakeup function via
>the pin_config_set handler.
>
>Signed-off-by: Shenwei Wang <shenwei.wang@nxp.com>
>---
> drivers/pinctrl/freescale/pinctrl-scu.c | 30 +++++++++++++++++++++++++
> 1 file changed, 30 insertions(+)
>
>diff --git a/drivers/pinctrl/freescale/pinctrl-scu.c b/drivers/pinctrl/freescale/pinctrl-scu.c
>index 59b5f8a35111..0b172f7e7261 100644
>--- a/drivers/pinctrl/freescale/pinctrl-scu.c
>+++ b/drivers/pinctrl/freescale/pinctrl-scu.c
>@@ -15,6 +15,11 @@
> #include "../core.h"
> #include "pinctrl-imx.h"
> 
>+#define IMX_SC_PAD_FUNC_GET_WAKEUP	9
>+#define IMX_SC_PAD_FUNC_SET_WAKEUP	4
>+#define IMX_SC_IRQ_GROUP_WAKE           3   /* Wakeup interrupts */
>+#define IMX_SC_IRQ_PAD			2   /* Pad wakeup */
>+
> enum pad_func_e {
> 	IMX_SC_PAD_FUNC_SET = 15,
> 	IMX_SC_PAD_FUNC_GET = 16,
>@@ -36,10 +41,18 @@ struct imx_sc_msg_resp_pad_get {
> 	u32 val;
> } __packed;
> 
>+struct imx_sc_msg_gpio_set_pad_wakeup {
>+	struct imx_sc_rpc_msg hdr;
>+	u16 pad;
>+	u8 wakeup;
>+} __packed __aligned(4);
>+
> static struct imx_sc_ipc *pinctrl_ipc_handle;
> 
> int imx_pinctrl_sc_ipc_init(struct platform_device *pdev)
> {
>+	imx_scu_irq_group_enable(IMX_SC_IRQ_GROUP_WAKE,
>+					 IMX_SC_IRQ_PAD, true);
> 	return imx_scu_get_handle(&pinctrl_ipc_handle);
> }
> EXPORT_SYMBOL_GPL(imx_pinctrl_sc_ipc_init);
>@@ -81,6 +94,23 @@ int imx_pinconf_set_scu(struct pinctrl_dev *pctldev, unsigned pin_id,
> 	unsigned int val;
> 	int ret;
> 
>+	if (num_configs == 1) {
>+		struct imx_sc_msg_gpio_set_pad_wakeup wmsg;
>+
>+		hdr = &wmsg.hdr;
>+		hdr->ver = IMX_SC_RPC_VERSION;
>+		hdr->svc = IMX_SC_RPC_SVC_PAD;
>+		hdr->func = IMX_SC_PAD_FUNC_SET_WAKEUP;
>+		hdr->size = 2;
>+		wmsg.pad = pin_id;
>+		wmsg.wakeup = *configs;
>+		ret = imx_scu_call_rpc(pinctrl_ipc_handle, &wmsg, true);
>+
>+		dev_dbg(ipctl->dev, "wakeup pin_id: %d type: %d\n",
>+				pin_id, *configs);

Format issue, and configs should be unsigned long type. Otherwise, looks good
to me.

Regards,
Peng.

>+		return ret;
>+	}
>+
> 	/*
> 	 * Set mux and conf together in one IPC call
> 	 */
>-- 
>2.34.1
>

-- 
