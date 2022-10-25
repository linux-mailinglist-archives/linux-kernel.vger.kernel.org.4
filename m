Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BA79960D39F
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Oct 2022 20:33:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232747AbiJYSdo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Oct 2022 14:33:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39586 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232839AbiJYSdh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Oct 2022 14:33:37 -0400
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2070.outbound.protection.outlook.com [40.107.21.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C1F3F53D3;
        Tue, 25 Oct 2022 11:33:32 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ErlIN+ucj5MLLUCWSDJmACYDdJqpuT8RXeUaJakQV4d6O+Ox0QfHFGX412uNtagH1rcsTFk6OjE4wsv6B//Mdkx9Mk42Ychuh4AC1T/c/E0peWNa9adVc7n2gHEVdooypcqVw6N1pWSoerLSzuJrKGhSuZLv36JUnN3WxJezbKfSa4I9IfN7hgyTC4ZWOyYEovzTa6lMKXESmeyNmk87hNAHCJGUnXpqcuhSiq33IdS6XFZ9lUI54XZp10jYBSq6rFFzhEj/VDvB/N821TMBqJd7LaSMyVgolHAu1j7Zj5K3ZJYlJgQ9pTItp+aYE6Ho1Kn6aHMS9nkALzH5vBZfNg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8xf3M/pDapRpv9SPS1/daqxjwo3pBb33QMXB95kKr6A=;
 b=cFlh3GlHXqiDN93Ck2ot3bZcJ2awuLZl84jGDVozbWsMZ79CX/dxYOmR31Kkfih/CVG0bWo/thUKH/pPE9518G6NxNoGIq9zpYO8o7wyPlCdiki6W2Ko5CYSCYAXL3fWALeNKRKH4RI1y4o+ltg4Z+c7RnEhvg9fp7cRfwinCFHEx1Z99kF5BglqGCg5aMnT3ChOK9lU7LUit5vs5pvPvGpuTlaq93kc9Ogq/PrXTR+1Zk39+90ZMpNyxYGVTruKWajiKeY4T9ycLzZ6fG7h9ukEy6S09klFn+e8p6i4/TGhHMs+xrN0SM4lsM6ZGV90JOWx180m9QOCeKYBC0mFrg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8xf3M/pDapRpv9SPS1/daqxjwo3pBb33QMXB95kKr6A=;
 b=apTgx34V890FoOeENKV65h7XKf+PsC1OtbVEW/MHPBceRujAxq5e9oXdL0DTt3xAmxIp4UHlQN5TWkqqBmjHMeep5oAQE4ikoyLYI+eR4B9uSMMaWfzfBMY689RTcvFlR+PgQ+a4a7psbQfgRwZZ4m6j7mmKpsaE6coiBV/UsTA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9185.eurprd04.prod.outlook.com (2603:10a6:102:231::11)
 by AS1PR04MB9581.eurprd04.prod.outlook.com (2603:10a6:20b:470::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5723.33; Tue, 25 Oct
 2022 18:33:29 +0000
Received: from PAXPR04MB9185.eurprd04.prod.outlook.com
 ([fe80::4150:173b:56ec:dc6c]) by PAXPR04MB9185.eurprd04.prod.outlook.com
 ([fe80::4150:173b:56ec:dc6c%9]) with mapi id 15.20.5746.028; Tue, 25 Oct 2022
 18:33:29 +0000
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
Subject: [PATCH v3 4/5] pinctrl: freescale: add pad wakeup config
Date:   Tue, 25 Oct 2022 13:32:43 -0500
Message-Id: <20221025183244.615318-5-shenwei.wang@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20221025183244.615318-1-shenwei.wang@nxp.com>
References: <20221025183244.615318-1-shenwei.wang@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BY5PR13CA0032.namprd13.prod.outlook.com
 (2603:10b6:a03:180::45) To PAXPR04MB9185.eurprd04.prod.outlook.com
 (2603:10a6:102:231::11)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9185:EE_|AS1PR04MB9581:EE_
X-MS-Office365-Filtering-Correlation-Id: 790b2d9d-6383-4ce8-7e14-08dab6b769ac
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Nm2cNgeuebKHjxWVZe6l2Pxu6VAj+QlN88x1Niho+2ECWuykiAkXpniYMLKZJp0aOV9xGd5Q4wvtPQan7EECwL5RqKRicqKm/tLinQMi/THMmZlJ86gJJtVaBxjrfKC5dtAJUEfTJoG4yeQQ2Nehv0xr/mQ2FH1/3PuJt5OVNh6ib4tq8b3iw4uXoNXlL9rQ9UifNlZSJghourVVf9TmaV23SKNLRhY9kN5nsL1gHy+QWBtP77DEkaxHDwFjBA5lrDBJmTYWoN9U4h0AUJpI4HEitPaF/SmCRvvwJPD3GMQ1PATXxh2+6iLVnPgDpxzj7Cv4lVlobX71elCTiY+5I8wCsok6jRD2Zyq3lCGcz+kmJxsO5VS1SD+zOU/nZcQ33ohaFP2GW1/hO0a2Vu4qdb+JcFujtGNoElPbFOutzKVevzO9Af2UnUYWnszfQdJsf6EKtytmBp0bY8AJP1p/dAnHJYnuH04REnL/Vnt6Al+HUWYYaCd3fgQg29PaHJkRsyPKlSQV0IdmkqjpfEO7mLPORDQ9MbZkefV92ZClycKvxMmHFkgV9AYfqQ71Y+yX3iLlKSQN/HZiZAci1sNwkGFlfx5FoItjZ0j+JYrLetKWRarJD7uEBfcBfGPuu3BZNqq+v+xWCyfXLQBsv73G3JOAPbPEB8auy2XswWoe00dOIge4jq6QYriewwGYDFy6OpUw/NOUWpVaxSzATOefcmfFW0fSCSMskfZa5WQwBy6/NXYVGtlTxZkDXOD0Lgi3JsSsWf4ixjEB95CM5XZtKA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9185.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(39860400002)(136003)(396003)(366004)(376002)(346002)(451199015)(478600001)(38350700002)(38100700002)(7416002)(55236004)(6486002)(8676002)(86362001)(2906002)(52116002)(36756003)(44832011)(6636002)(66946007)(66476007)(110136005)(6506007)(8936002)(66556008)(4326008)(54906003)(26005)(41300700001)(5660300002)(6512007)(316002)(1076003)(186003)(2616005)(6666004);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Y3V0y4VPML1E3MqD+lkJqr8pS1GjWmQCG4Evv+JAzKtHDEERJEHA+zUOT00K?=
 =?us-ascii?Q?MTvD/xqQhBEIah9OImaiFV6k8pgfRAThHy5FiwrGVhoUXNrBmyq7nriGXKXW?=
 =?us-ascii?Q?T+mO1eW0CN8RvJTXdeuGTkPLE5mNmwpyWkFMB4WUT0Htaq1jR3gJmfiX+Hk5?=
 =?us-ascii?Q?I5FWhlqsxqKDoN+fcQ4hRRMBqzMJIVx654UfOaBKLrSIww8kKpuYO66YXIF8?=
 =?us-ascii?Q?8aFohidMV72G2n0veuRrYyXVcr+QYK8BvEFIQ/T8C+Bvq+8cFzi30Q/AWiJO?=
 =?us-ascii?Q?nUlsmzf6o276yItjfoTLOQG3i7v22C/FTh6eZ2V4WXYYp8tn54EH3127mrYe?=
 =?us-ascii?Q?LT/yWVc8G/AF7pFGClzyzPErOq4tgvN7PMXGBpK11tZ4jJ05JwFl6wQaFpDj?=
 =?us-ascii?Q?446+aibQdPWAhlIOR1fsKv3dEaeb0HvsbrSU4JVwS9GwmXlSNdS+uNSO4AAI?=
 =?us-ascii?Q?Ky3DNlWZTXQweJzvtwGjSumR8RIglvt0Ok3JC+/IUawuGtJw8XdZR6aIxkn+?=
 =?us-ascii?Q?tdbyGpC21lxcmGNAwN+jBMdYf5rXIcxol0ZEUNs0OxqesVPGHeWwW93DdW9C?=
 =?us-ascii?Q?iWjoZgGtShzu9lIb+ybs5IBhzQIJuRt39R4ty0ey/4nmxT/kv/ol4ZFiU6r9?=
 =?us-ascii?Q?SqEAzsj2ZgTexgUcwpdFjAL1nJlzxdgRiqWxvW0R4KK9pMltzE52HWRlL3Ud?=
 =?us-ascii?Q?Q3YSkKFGjCUG9rkH/OLr8pltnieF/eQ/a8v9sj+uJJK3zVno+w7AHvjfMmLX?=
 =?us-ascii?Q?MaEN1GAyUbvc1C42sYayV0Ibb+ZtA+gZoyJNAE8Gjxs8YxvBTdNz3TCvj3Eb?=
 =?us-ascii?Q?BTxrPrEYUbc6wsdWWBWoOJAjbJd2dqCRiBnggRMw2DBfOkHIvPojPtPyQKYY?=
 =?us-ascii?Q?NvpPuxlOkv1eS4wo3mYLxm8/cRH7BybiNFS6eGikbgPWFz6uHp7YuTRqeEn/?=
 =?us-ascii?Q?8KWtae+mT47ogyx0d2GzZsi1gXaRyYnHDnKSsfMrF/dZJxdpIUG5cjqlYwU0?=
 =?us-ascii?Q?apC2B9HnTawBGw0vrHNq1XKE0GWQBjFApv86hiwF28nuzwJwzVM6PP1TmKOX?=
 =?us-ascii?Q?Opdzlg5fN2afes373FcVTATJuxBw8v7QwX6EbLMiE1OJFBV7+7DUIZQJveGH?=
 =?us-ascii?Q?JDy2f+aP4KkqQjK84tnZtyntZ9gMe27I2ynpp8TwogL0wmVYhaDd0c/Z8j6o?=
 =?us-ascii?Q?fPQZzNccX0R9jqLo9QRgZTrdQz0SVzqr49G8OOFJ7qiHwFkBDLrkEz8yKadD?=
 =?us-ascii?Q?hsXxjzUGAx45SYUtMTn4OFkX37pEnrr9b3GEjjHHw7jV2U3eSCbvjVC6p8kT?=
 =?us-ascii?Q?gbVlYARjqr1Vljl+o0Uy0Cj40exwzdPeG3wrLCA9MjUq5Mj2dy7RM6wMzW1o?=
 =?us-ascii?Q?WFuQu+dFICD+RJmcX1aMTItoYnROpwm1SA4IaKIBnB2kCswhV4nmn8kLn6Z2?=
 =?us-ascii?Q?afUUB9NXVznFoLNOzXqbvuL+N1q7kZn7U96tuFSnFenD+oYDYlmNDmIl0RB1?=
 =?us-ascii?Q?VwOpk76KaiNSgjF+F6YvU3h7elW9sh+M+S82mQUDPEdCdUtLz7RulgS7bCsv?=
 =?us-ascii?Q?hWF7Xu91OGJK1l35MKhaR3hUuo6yeIhTpUfZiQ8P?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 790b2d9d-6383-4ce8-7e14-08dab6b769ac
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9185.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Oct 2022 18:33:29.7341
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: GdIM/RQcQVV5WFvaX2Jo7bCBQi5qdEqMO+ZPMSCbjv2EWTm3X4itvqHvoSY3o2NCjV+fzmnr72xSwx2rO93xow==
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

add the logic to configure the pad wakeup function via
the pin_config_set handler.

Signed-off-by: Shenwei Wang <shenwei.wang@nxp.com>
---
 drivers/pinctrl/freescale/pinctrl-scu.c | 30 +++++++++++++++++++++++++
 1 file changed, 30 insertions(+)

diff --git a/drivers/pinctrl/freescale/pinctrl-scu.c b/drivers/pinctrl/freescale/pinctrl-scu.c
index 59b5f8a35111..0b172f7e7261 100644
--- a/drivers/pinctrl/freescale/pinctrl-scu.c
+++ b/drivers/pinctrl/freescale/pinctrl-scu.c
@@ -15,6 +15,11 @@
 #include "../core.h"
 #include "pinctrl-imx.h"
 
+#define IMX_SC_PAD_FUNC_GET_WAKEUP	9
+#define IMX_SC_PAD_FUNC_SET_WAKEUP	4
+#define IMX_SC_IRQ_GROUP_WAKE           3   /* Wakeup interrupts */
+#define IMX_SC_IRQ_PAD			2   /* Pad wakeup */
+
 enum pad_func_e {
 	IMX_SC_PAD_FUNC_SET = 15,
 	IMX_SC_PAD_FUNC_GET = 16,
@@ -36,10 +41,18 @@ struct imx_sc_msg_resp_pad_get {
 	u32 val;
 } __packed;
 
+struct imx_sc_msg_gpio_set_pad_wakeup {
+	struct imx_sc_rpc_msg hdr;
+	u16 pad;
+	u8 wakeup;
+} __packed __aligned(4);
+
 static struct imx_sc_ipc *pinctrl_ipc_handle;
 
 int imx_pinctrl_sc_ipc_init(struct platform_device *pdev)
 {
+	imx_scu_irq_group_enable(IMX_SC_IRQ_GROUP_WAKE,
+					 IMX_SC_IRQ_PAD, true);
 	return imx_scu_get_handle(&pinctrl_ipc_handle);
 }
 EXPORT_SYMBOL_GPL(imx_pinctrl_sc_ipc_init);
@@ -81,6 +94,23 @@ int imx_pinconf_set_scu(struct pinctrl_dev *pctldev, unsigned pin_id,
 	unsigned int val;
 	int ret;
 
+	if (num_configs == 1) {
+		struct imx_sc_msg_gpio_set_pad_wakeup wmsg;
+
+		hdr = &wmsg.hdr;
+		hdr->ver = IMX_SC_RPC_VERSION;
+		hdr->svc = IMX_SC_RPC_SVC_PAD;
+		hdr->func = IMX_SC_PAD_FUNC_SET_WAKEUP;
+		hdr->size = 2;
+		wmsg.pad = pin_id;
+		wmsg.wakeup = *configs;
+		ret = imx_scu_call_rpc(pinctrl_ipc_handle, &wmsg, true);
+
+		dev_dbg(ipctl->dev, "wakeup pin_id: %d type: %d\n",
+				pin_id, *configs);
+		return ret;
+	}
+
 	/*
 	 * Set mux and conf together in one IPC call
 	 */
-- 
2.34.1

