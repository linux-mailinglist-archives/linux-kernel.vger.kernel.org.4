Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7ED4960F8A0
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Oct 2022 15:11:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235272AbiJ0NK5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Oct 2022 09:10:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37468 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236078AbiJ0NKY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Oct 2022 09:10:24 -0400
Received: from EUR03-AM7-obe.outbound.protection.outlook.com (mail-am7eur03on2066.outbound.protection.outlook.com [40.107.105.66])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6443451A1D;
        Thu, 27 Oct 2022 06:10:12 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=m0SdoCoxiX2xR8xlZFoHgRLB9n1HxGUs/cIdEXBsvfyV3E2FcMOvF4rO760tuCrkRF6r+l8imOqx8WKryj4gwLTAt4lRhbQMf0N4XcDm0McX48k7rGBU7uzNrktDsldhkdKtZfrlvavayYGvhcSwp0bam5PWRZOLu0aTBLSWPQwOSV2BTcPltJHZdgE5dNB8wWAge6IXwJiwrPZXKCDJ55v9sZh25g5ZPkjQvZo7sZbvxNhr4K65iJ8pKrvRSeSyaSMft0Qv52SRQFOTJkZ4VC1bwhD6CUcNTMAu4rJaOxDllxd9ecG0vQfYkHw7iHMpwpkL+aayqzWu8kmwceCegw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Zx7rvzpGKveheuABrjJhPyG94a0owwancSk7/48YbcE=;
 b=J/QvjtCJ48Y6CxF21yw48iLhM911TflpGi8Oj2eVlti3Ta+78le2xKOJIrk12QsksO8wRrop/dMSADjwX1m1rK2BmrGWFUWi0no3NVw4kcds00rrQiIJoHrU9XLPbI65epMPeEIb8Sm7Px97Q7GcaituQXFgipO9Q3gX6uzNsxw8Sa02azCaQlEVVQdhWTwFW94yVKtaVcaDcHXEVNuasayEkotWugX0mqexLlnYxMKuCasHN9WrWFdSY1gi7SUd96vebgtlSomxnqvlqrCq7fg/zNmz0xb/ksl0zfJ4NUouFNNgpq6hbdpeidl0hiuPe2Tm4DAROBSB7kRNfr9YXQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Zx7rvzpGKveheuABrjJhPyG94a0owwancSk7/48YbcE=;
 b=BHPE+tVwHGj/DRGK100H7Wt8BTCTFvaACK99qIFKj/Ckt6R4pVpYtkwaD/jQEQPJM4VuceeHI7fMVJDEo8uYlfRijAwTfJPR9SU1nD57KP77yYVwok2XKtTfpxVDtw7cOLSJ2IHMkoKn9M2lU27Helkea0+zoyndu7pwmz4HVc0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9185.eurprd04.prod.outlook.com (2603:10a6:102:231::11)
 by AM7PR04MB6807.eurprd04.prod.outlook.com (2603:10a6:20b:104::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5746.21; Thu, 27 Oct
 2022 13:10:10 +0000
Received: from PAXPR04MB9185.eurprd04.prod.outlook.com
 ([fe80::b1ab:dd4f:9237:d9f8]) by PAXPR04MB9185.eurprd04.prod.outlook.com
 ([fe80::b1ab:dd4f:9237:d9f8%3]) with mapi id 15.20.5769.014; Thu, 27 Oct 2022
 13:10:10 +0000
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
        imx@lists.linux.dev, kernel test robot <lkp@intel.com>
Subject: [PATCH v4 4/5] pinctrl: freescale: add pad wakeup config
Date:   Thu, 27 Oct 2022 08:08:58 -0500
Message-Id: <20221027130859.1444412-5-shenwei.wang@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20221027130859.1444412-1-shenwei.wang@nxp.com>
References: <20221027130859.1444412-1-shenwei.wang@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR05CA0139.namprd05.prod.outlook.com
 (2603:10b6:a03:33d::24) To PAXPR04MB9185.eurprd04.prod.outlook.com
 (2603:10a6:102:231::11)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9185:EE_|AM7PR04MB6807:EE_
X-MS-Office365-Filtering-Correlation-Id: 839ee7eb-5045-4832-410c-08dab81c9285
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: xD1hzBs22KfZ8/ZPDhGz3VN20AjCfwtQRxeD2izuBNKfQ63c+ZGoi7gA/EMOJ+Qdmw97qOGzQtz84KJXz4eLp+LKLkzAGhlx47gsu8VQzRNrYB3XeNgrdWrolZtHfondLcne5jO5hHHItlNlfZo44Xw1xP9RXTGclQD+vkmrk8i3r0DBRTfaJ9nNfL7Pn+q8blUcWzWWYxCSZO+Y+4UDww44qqyz0Gq1mMqyjx6utwymV5Mi07oR8wY4GwP65KO9Sr/ug02nBop+1RiqGoORzCAQ0YrEeqQt78k7G0rFXUVgbR321/TaIqA6gPCANhPDCbAWlCdKqIshvl/HNL8I+WFmF+DUqtEcUyojcZYPmcQUa/Ktbzr28bJ2FHESMKRB1KybAbgLfRY3bD0n29B5xyDy56mlF/IJnUHWU58UreqzTq+WdUHYudDF9JdtdTs1d/kuePg74g1lKp1n6a3bIT9HwlxOysFY74zGD2RV5An6n9IHtC9cUb04AUujK7WmjEG8tg+x/gisD4IznVWEGXSOGwHRQ1/bhmsKcPkzJxcKsaLaCxGgl7LdixMgxgSR2zj2wUFlFSrdbXQevHs9F3XaQ65Bg67ECLlu4FJf+QxPo5aAN79k1sxO8k8+ZFNSGuKq6fV0q5/HTjC3EZU2u0Xj5pXtbm4+gQvdHP8Va697oLDMwzNHh+Bs5tlH/HoDT9QSjQ0spvU0myj6WkB6fu48WX9l5WfaYJ8J8+NyOB3eZfgzYJHQN34BSoCf3Fb2OQGMBnTz+mQTnpt71LPL1A==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9185.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(136003)(376002)(396003)(39860400002)(366004)(346002)(451199015)(55236004)(1076003)(6512007)(26005)(52116002)(6666004)(6506007)(478600001)(186003)(2616005)(44832011)(2906002)(6636002)(5660300002)(54906003)(8676002)(110136005)(6486002)(316002)(41300700001)(66556008)(7416002)(66946007)(66476007)(4326008)(8936002)(36756003)(86362001)(38350700002)(38100700002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?mEwZ9oScSjYGIJpReP+h3HJiifzWEEKMnmOAYTOV4KGKSDJZe7xC2ExYWlsB?=
 =?us-ascii?Q?7FHCuudA5BXaNH5k6xw4ihJjRiaxR4h4Si0paxRH3vvyKBoVwOgd2GjkNOkD?=
 =?us-ascii?Q?oMAbx8WqxaFBWPuBQVJmb/7oHWPs+bV+nEg7Hx5gmsya7OPR8vTm6KY4B3Tg?=
 =?us-ascii?Q?CIGMjQm73cT3wGmiTzetjOdrx1dhxiuftKbI7fXQx379FNHbKcUPQUK4u4RY?=
 =?us-ascii?Q?5f+e8nBlEmMJKodR9fssZaI9gkX8yITU9JB4/9d13Jyng3UUkcDavdUINbo9?=
 =?us-ascii?Q?smtQlmjpOLcIZ8Ypm4eDSD0lZU2X19CpK4VzWp2hO9YwI+Ig362DnpNw9TeJ?=
 =?us-ascii?Q?dCy3BGZuPun5Cx8iwzeOGG4ha61GG9cGfWdCjrB/56d0/gbuTcPqOwZQWFdN?=
 =?us-ascii?Q?C62M+Jc3L5F4gUENkZ199gGob76Fzniso0kzsJ/2clUCu3/XQHun+AjravkE?=
 =?us-ascii?Q?YowC6Kx4Yufp0Wbm54ullcx9GkUEjusQhKlXCq8wvd459fv2GPHNXO1dLxJ9?=
 =?us-ascii?Q?HOGfgQ8nBxVhXUpEOsVksn8siBIKQxeTo0YkBkRYW/agpz0swPOwdngGV9JR?=
 =?us-ascii?Q?ghP8cLB8XPbencQxZR7jaT7AYGFIIk4Objnob5pnmI25eziuXN8+IcrtI2CV?=
 =?us-ascii?Q?HHe7cBC3+1xIytsE36EEjVwt+4R9vwHYBd/UoUisSnTUgETTmMbFGTlcMrx4?=
 =?us-ascii?Q?BE29uiy+EAWFz5+cf8C24ADRSrZzoT3iGanZbdCn6Or7A5nf+DeQuRiOZvQy?=
 =?us-ascii?Q?vr1J7LmE3jNNfnw91i1lSEtk+67ambHVoUgsOFx6Nj0OSmsIkYvWQc/bjnVC?=
 =?us-ascii?Q?gHNX8vA9pGtv4rbrYPisxSTGzPtwLpX1oKdtTLNvl7Z+UzQxQpKpASy670iS?=
 =?us-ascii?Q?UC08Y2L+WOGle3asN2B7vNVwsHFrBxrrGfYcllswFJyZd//l12njj/5sRmSG?=
 =?us-ascii?Q?XkH+fXehw+iwhdcTDNqXATEfU9znYvJNuZKJ/CyyGWsPERl9VCc9w/hTAqq6?=
 =?us-ascii?Q?oZKkkNoxWC2CvOV4uTRCje+TDUDNA22bEGyFr+FUBEBr57RJ+nUZu7X1qT06?=
 =?us-ascii?Q?OCUd529cAXv89CVZ8Z8DQJrhY3pbUyTFy0H7uDYtDD99QZgyaRt0dHmnh4Dn?=
 =?us-ascii?Q?w8XmQHMEyKhcKPRh82KSVfNIY84e9HjsV/pz76feq3PDHZCuOnQc0FNNmNk+?=
 =?us-ascii?Q?oBa2wxJ0T4vMoI77ERPB+9pR41ku8aEn7P6pLRk0HH7pr+cFfyr3pxLHU1Ha?=
 =?us-ascii?Q?0BjnaDXYJT/PNaSixPvr69lQdFhiDNdWcoLBdp4H0+fXfpPJddqACCMcxx+T?=
 =?us-ascii?Q?9232Fq25JJxWwBtTX2dClv6/FBUJUoZ8jlvtniWS7OOlNvb0UywkrJEQPSeg?=
 =?us-ascii?Q?GS6Z997scMD0yt7PPllAse9utbbd/HJOTPv8r3eODzM7lDswlRwbPbGv+EYq?=
 =?us-ascii?Q?MtkviwUxtLE78/hgcq2leMsmHYu31Llr9uip+G2ZHQk3xVhekSRJ8trENCQE?=
 =?us-ascii?Q?0qJqNMhax0i0oZB7QvtDst6ziYiSUIjNuOZodpCWU7ry3h39/fsvcJDT3foR?=
 =?us-ascii?Q?13JRMZgFnz427WGvGzPat940Hdjz2WJEGTFs7LQ/ltvjWheYVMepJ8b+6WMM?=
 =?us-ascii?Q?9g=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 839ee7eb-5045-4832-410c-08dab81c9285
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9185.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Oct 2022 13:10:10.0566
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: p7mTWpYTYaOuRuugJu3kM1LzhtWhAPhVdF4M4uA/y6kIccwRNbMrcc5p1TcYZC/NUd+Z/vOCHJiiyvxE09zbcA==
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

add the logic to configure the pad wakeup function via
the pin_config_set handler.

Signed-off-by: Shenwei Wang <shenwei.wang@nxp.com>
Reported-by: kernel test robot <lkp@intel.com>
Reviewed-by: Peng Fan <peng.fan@nxp.com>
---
 drivers/pinctrl/freescale/pinctrl-scu.c | 30 +++++++++++++++++++++++++
 1 file changed, 30 insertions(+)

diff --git a/drivers/pinctrl/freescale/pinctrl-scu.c b/drivers/pinctrl/freescale/pinctrl-scu.c
index 59b5f8a35111..ea261b6e7458 100644
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
+		dev_dbg(ipctl->dev, "wakeup pin_id: %d type: %ld\n",
+				pin_id, *configs);
+		return ret;
+	}
+
 	/*
 	 * Set mux and conf together in one IPC call
 	 */
-- 
2.34.1

