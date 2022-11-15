Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5B07C629422
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Nov 2022 10:18:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237988AbiKOJSB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Nov 2022 04:18:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45190 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237977AbiKOJR1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Nov 2022 04:17:27 -0500
Received: from EUR04-VI1-obe.outbound.protection.outlook.com (mail-eopbgr80070.outbound.protection.outlook.com [40.107.8.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E9097233AB
        for <linux-kernel@vger.kernel.org>; Tue, 15 Nov 2022 01:16:51 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SdSbYqb+3splSV2PiQkbgKUuZ96+qZkukJiNNaVmK9MbMjOS40iCq1XH4l7qTjAIapuz4svQIj6Ccj87Q1v+VZiFrrbJGOzDa43Ln2VtFOjrKwILl4BVGC4xnWiMUS01NkJY+6YIMacng3s79VtNMHdq6COpVNQiFoJUz0n6qKRfIbFBdHjq43AwoFpA48eNClrf3UVkcN/gJfl6BN930Pd/TDIwBS+JD66AxXO+Df+8SmILhplRa2KZ11VJ/JbX/Pd1xXXEcLgD0EAlyF26ANRS9loE1Mr0giMYe9j5Vmtctm1K35C00PPOLOpPkBuu/VemRdElEj6j91A1hqfLSQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/QJyfcMRCt8RnzfjVIbNMhcXQqdgUy4gExc4vtwu7DI=;
 b=Ux7Rr/joS18cct51uJMo4pPvq1TOmDWPkwPhCJoRWZvc8L+0//nyt4a7906m6xOSnUnS8wi3k8Pm4FseHBSjU7qfKme3HnIj4bRLRzsAy14740bWuqogs+4ZrWW1cAtT74pJLF5zZGXmRGwPAqiZT5QBtEqIBnKp86zu0i1SHBE+wuPhqWssdx/hik/TzYag7szz1HkA3bSWSrOTu5mh7kJV6zNhJdHBOlHlFhCEeLPKIFOvJCShKbk5zzZE+NXpmqyhj4tN8G8FcSrkudgGwyTt4YNewKwKt3lSRU4Sib1FJ/jbw53CDp2ALK59PgMXZ5PIjjLIA17VGW/skeLIgg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/QJyfcMRCt8RnzfjVIbNMhcXQqdgUy4gExc4vtwu7DI=;
 b=QgIYgjpum3lIxwU/JSd28EyzDb4Umm0x5xbcPL7PLU2BHHGJXT3Ag46wQmbBMaGl3OBJfsFoD4w4i3nuJ5syErOTH8fKW70qQbspavdfEJjCJjweEs3K8+cbIakpUm3/ZpZ5PybOjO82fqQf5vkH+TXcEMt0Rf4uNYGv9YMtq3c=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by DBBPR04MB7899.eurprd04.prod.outlook.com (2603:10a6:10:1e1::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5791.20; Tue, 15 Nov
 2022 09:16:28 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::ac6c:bcb8:674c:35d0]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::ac6c:bcb8:674c:35d0%4]) with mapi id 15.20.5813.013; Tue, 15 Nov 2022
 09:16:28 +0000
From:   "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
To:     shawnguo@kernel.org, s.hauer@pengutronix.de
Cc:     kernel@pengutronix.de, festevam@gmail.com, linux-imx@nxp.com,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Adrian Alonso <adrian.alonso@nxp.com>,
        Shengjiu Wang <shengjiu.wang@nxp.com>,
        Peng Fan <peng.fan@nxp.com>
Subject: [PATCH V5 12/12] arm64: dts: imx8mm-evk: add vcc supply for pca6416
Date:   Tue, 15 Nov 2022 17:17:09 +0800
Message-Id: <20221115091709.2865997-13-peng.fan@oss.nxp.com>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20221115091709.2865997-1-peng.fan@oss.nxp.com>
References: <20221115091709.2865997-1-peng.fan@oss.nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2P153CA0007.APCP153.PROD.OUTLOOK.COM (2603:1096:4:140::8)
 To DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU0PR04MB9417:EE_|DBBPR04MB7899:EE_
X-MS-Office365-Filtering-Correlation-Id: 9ce4203a-b365-41e9-837a-08dac6ea1384
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: eySprgweuQf1OKkDK3LIMm4I6TffiIbAtUxDk12BghUwa93v7EjMdkDFz9f9AbEKPo37So8lxMO0/GkxARmORUZGGy1rgQHpHVC6w1WsHnfgBcZTpLen0DsSQqz/mnyRanYFc/kaXsCENK8Ge0h3Um7uYmdaGAf0dpc4a0k8sBn3252m65prDiSCEK5y16KfYPBQQjQWbYAhLzutWxgEI9/pQdFx8Ge70KsXVNhzPWoKpQGOabuwrPXS6EB/4ybw4H3e5uvH56MKWwUonC7lwD1mPXpDyqc0feH0V6F0Kz6Kmrk89DTyiNa3BuQQyqwv79XSDV4DI9pjEaTWA8xQkLb42imRF24bGBfW0IhHCYCkAm43NlIKcRlXRqPHmnsGeZqK1B+cz9YwEG0Y+C/3HQrpU3p58gucHVs1Cpt95pEhGpXSaG9nvHqqNH+uqsTiSnFhgOoBt9DspPYu+d56wsgTCHhZbXU/OKwX0YkDc8KACjkM+2Tbf2AaSUZ27STo+8kym9Hc8IoudaGawcA9xLCF2MIzpUkZs52iNiZ+STL7JmMuf420uYtwAx8mHvUXI7Z36MnESldhb9FrsEaUTK89ESemUQcSphWOAO3JTcRl28gooIjmrlP+qWrlBbIyc+rfblsKT8LSHFs0r4QR9XUpJKT4lkWuPEEVM21WlKOHwmDtrLnHbu8fg85qWNOyVHqYnUjLMB5dkOZLdm+HGAp3M7AvJY6eJ63bcp5Q6p2gpvd6/M+wLbQlmycXLdeshYgqL2WELCVOW47wPYPZ84zkfm0mtQN3kXBQ2WsjEIw=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(366004)(136003)(39860400002)(396003)(376002)(346002)(451199015)(1076003)(52116002)(6506007)(6666004)(186003)(478600001)(26005)(2616005)(6512007)(41300700001)(8936002)(5660300002)(66946007)(4326008)(66556008)(66476007)(4744005)(2906002)(86362001)(6486002)(316002)(54906003)(8676002)(38350700002)(38100700002)(32563001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?e03D0Rd6zpRJa1aFMwQ46E/vPJPzpuETtMzHYRbjgXd8hFaRLtSc2KEKa+ou?=
 =?us-ascii?Q?mkzIFYA4CepNEQLWPoxp62DPuiccLTJd+uPVpMA2iKs2+sWmdzJRxR1iFiCv?=
 =?us-ascii?Q?xpmH6KeCoxSnn2OyxYtcyREgYc743n9egYA3ntbphJz5cGm3pu3i8oCnUVMk?=
 =?us-ascii?Q?r52nlctEZdGwwTx7VXietV9PULiIxl9MDi7oTkjK/F12N4Tyd7yOTA0FygOe?=
 =?us-ascii?Q?x+8viHpKcgH417VjVyuVbMXEAbHOkV3R1zfILKFRNYt+v7Exqa60n7gBbmQ0?=
 =?us-ascii?Q?mN4MGKqIcVa/vr6Mu1NhE9yJU9b6rv3t7p88Zv5FCMZSIvmDHdci9mxNWZPA?=
 =?us-ascii?Q?3aDiQE5jcGrzKJnSqTqnEuNF+AOgcxXsEbrzAFyyUKbz/2Kw1puMJJfByGrj?=
 =?us-ascii?Q?GptDKPiNtGvHdfPqhpcQFKPZ+WwTbOXGdsfidgS597yq3oBr4o+D01fWVi1C?=
 =?us-ascii?Q?bmN88fh3ueHtdq6ed8IHyF63wkCyQBM7otx6/lpMuGybx+dgIuvnPL2DF7d6?=
 =?us-ascii?Q?GEDLI48xcDpfLFCS6eQRxzOtwmrND9BkueHn/ui4bH6CZKr36ofTfBJWMWhI?=
 =?us-ascii?Q?praX5jFPA7qZHxEalzynL9ZnZgg6OrWHUyRvcPs0DC65qjVTVpTH12RJPAoY?=
 =?us-ascii?Q?GWk7cYDVBaWuRZeLs4sIgE9LDSzgpTLbXS0kMW6Ing9N7WN5wXjA9Z6VGdj2?=
 =?us-ascii?Q?tC1yZgR6YDToRiBMggmQ7hZD8Jj3mUH6efUyWdedxj16oEIJJ/TWFND5XIJu?=
 =?us-ascii?Q?b5f+/oHpBpai4qJpyy1/ZWUGXSRNl7spyzJrQtAo9hCTmfcs8WlhNzOY03W/?=
 =?us-ascii?Q?MyXPdbZY2MlIXAWm63tCH78vN1ZSK+cnEm9WYEiYKQCPXdN7gYFtnSpj4vQX?=
 =?us-ascii?Q?Eq9u+hMy35DxBs3fuABq/EwBzt59tZihPuHXFzk7SizMpAlZM5rNi6KIEBr+?=
 =?us-ascii?Q?2S0Kcz/WL6WXrEZnWT+Op8wMsY83vWOPibOx8m07P3IMpLBR5Kp634zIuBVK?=
 =?us-ascii?Q?3mpVQEjGLCZUlBU9Xi1K0Vk3AWaFU17EFpsvVqSp/wc6dj/kCf821YyuswWu?=
 =?us-ascii?Q?tVOhSYBTX6jZzErIchCrruX9dADBTzZ4jOod5ZXxpd1aYky0/TXD+kO1gBvT?=
 =?us-ascii?Q?3e/qDPUhGmPASxpOwLV/MFGRQAR9PztspidwWXAQjP+mCy6Koizc5S9L+W2P?=
 =?us-ascii?Q?5aLKJ0N4CrNZBNmZ/3cxAev1HNW2yzU4ICkOjb6eoS8RAYvpfDNqaRnHCkNZ?=
 =?us-ascii?Q?668FP6Tzmx+S9p/xUjpfoewgsufift1Gxez4V+BGnUHri0kbmxBaXKck9+8C?=
 =?us-ascii?Q?a/SdF3bwU0bl459Rp6lUpCwmXrDXHyXXOYk6gmtKfLs8fCgCB1q8s+ep2Zbu?=
 =?us-ascii?Q?KtiZHruRXGd385dZLhRbWNSo7xbUE3Xg5F7PZ3cAgwNe8AcILoETvgoWxubK?=
 =?us-ascii?Q?CsckgBnM1Iijr2qu/P3i/BCH2kqih7NTYuCDawCipboQ2GO+qXcDw7fqg/si?=
 =?us-ascii?Q?gUyqrOd2tALmJLkBgYIW70hf/VeqZN2Lwla56Stl/htjt01oe58nU6Bv4cnM?=
 =?us-ascii?Q?KzLYPiDJePzUmt9FB1Xxgxf+Z6/R6oDb5atMNqdB?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9ce4203a-b365-41e9-837a-08dac6ea1384
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Nov 2022 09:16:28.7987
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: DIeJMREYe76GPS3BSm81BpJaaeurMWkR5G0D7K3rB8ED5jkUootO52qooqlmKWWZOvG3Fqc6Z6Bj+3AsSC6cCQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBBPR04MB7899
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Adrian Alonso <adrian.alonso@nxp.com>

pca6146 requires vcc-supply to work on i.MX8MM-EVK board.

Reviewed-by: Shengjiu Wang <shengjiu.wang@nxp.com>
Signed-off-by: Adrian Alonso <adrian.alonso@nxp.com>
Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 arch/arm64/boot/dts/freescale/imx8mm-evk.dtsi | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/boot/dts/freescale/imx8mm-evk.dtsi b/arch/arm64/boot/dts/freescale/imx8mm-evk.dtsi
index f881494996a1..e7984205de3e 100644
--- a/arch/arm64/boot/dts/freescale/imx8mm-evk.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx8mm-evk.dtsi
@@ -344,6 +344,7 @@ pca6416: gpio@20 {
 		reg = <0x20>;
 		gpio-controller;
 		#gpio-cells = <2>;
+		vcc-supply = <&buck4_reg>;
 	};
 };
 
-- 
2.37.1

