Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C4C2773D03A
	for <lists+linux-kernel@lfdr.de>; Sun, 25 Jun 2023 12:53:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231423AbjFYKx4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 25 Jun 2023 06:53:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59572 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231937AbjFYKxi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 25 Jun 2023 06:53:38 -0400
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2052.outbound.protection.outlook.com [40.107.21.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1276110C9;
        Sun, 25 Jun 2023 03:53:31 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HsCBEZh3hib5cHAEo7EgfCgJDneGJze2drmoP+iubCe5B4kJxIS0YP1VDKQ33LfhMaJgE8Iwp02EAeA671CeyAHXvTTcMDauNfdo1BX6Mn1AbQAaYQ8l2xCHPHFw4lXhC+2L04Uojla1Lx6vNJcB9b/p2eHV+5K49z5VNDWuH4+J1DsAyPB3Lv+7QuTOZgCOe+SFt9SBph2uhmmlg3ef/yoYl4zg2GuBQ3EG3OBzOon5VUjK5/rsuge/nrVB6prMFcZ5+Nn9PbwTT3zqEpghJb6xS4TJMsm+LN6kB+UShsqdRr/JEcU/TRuvCO+chjKh8nqW7mOrqFxRZ7AGxTZIbA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DdKbgFgnBfARl51AMlb9z+R9OuMo+IWD/HwWJbqe1sc=;
 b=CldcJXq+bIP2y8RyWEHl14J8+LfwwqAfXlYbfAiUybHFD5LtmxU8ughlOGPa2+JwgV2M9b/QpmZL2/eX2Db/SjhPZdu0h6VvKWryNK/e8CNg3pkt3bBt4zIb3stk0ClhbmeU6AJ1skX0X4Ekl/vF0m52XZz8evNaedQpsVsyRehqD40d88DHPsxxW7+WtOm3vnX8QpkSmmlVEqS+/M5mxFq4PCnWmOeGtir6hjZQQHK8pOrqI2i1TJ/jVnsxOY4U0GtW0lsF6eScEM1HCwI0yW1KZLEBtGCuSMWedYnrMJ8ScuuuDJr2K2IAZQ4/bMjkF1p1SfhXvd+39f5AoScZAQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DdKbgFgnBfARl51AMlb9z+R9OuMo+IWD/HwWJbqe1sc=;
 b=UcNu/6G5bkAmNkiPkjyclKZTX1ke5GOzXPvD9x+xg456OIUXGwmqmsSJDivnTFnDWLQ0DmTWlSemCL3zt46DqPTaLdOBIj0gllM0nK89CizLFZVCSAwbXodIA9XSk7U3g+VinReudhovrhIXcrq7TJKwDrEFtKCGVQ8cBcUu6TQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by AS8PR04MB7928.eurprd04.prod.outlook.com (2603:10a6:20b:2af::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6521.26; Sun, 25 Jun
 2023 10:53:28 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::efff:43d6:6f46:eea]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::efff:43d6:6f46:eea%7]) with mapi id 15.20.6521.026; Sun, 25 Jun 2023
 10:53:28 +0000
From:   "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
To:     robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        shawnguo@kernel.org, s.hauer@pengutronix.de
Cc:     kernel@pengutronix.de, festevam@gmail.com, linux-imx@nxp.com,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, Peng Fan <peng.fan@nxp.com>
Subject: [PATCH 4/4] arm64: dts: imx93: enable CM33 for 11x11 EVK
Date:   Sun, 25 Jun 2023 18:55:28 +0800
Message-Id: <20230625105528.4057850-5-peng.fan@oss.nxp.com>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20230625105528.4057850-1-peng.fan@oss.nxp.com>
References: <20230625105528.4057850-1-peng.fan@oss.nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR06CA0008.apcprd06.prod.outlook.com
 (2603:1096:4:186::23) To DU0PR04MB9417.eurprd04.prod.outlook.com
 (2603:10a6:10:358::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU0PR04MB9417:EE_|AS8PR04MB7928:EE_
X-MS-Office365-Filtering-Correlation-Id: 2548b6e7-ec71-4595-0a59-08db756a684c
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: yUS83CvN+ItzsGLqG9bFSBUqeKbPuzr2hNKte+B/V1WWduia31ATf2RvGFOGiKaWUN1MXfogIXO9f3EKeLT+pTm39tzhFCAvelZJsVmFpakLfxNTUq1EgktbBTUNbpSnIs0I3LppZyFI2BqYBhKw4jUHyowvZ+bqjzjN1rwgGRS1ayWogl24QTzuoWlU1bn+Lw5vlfiZJ5v3nwC1VFV6R5ncJVGb1kB305r8X5jHce1flgj3C3ShBGqaJK/wZc/7dnbGiQyyd12SlCWciAj6LnnHa++leCYUJNowj2bSSGQjjp1LZJV9LMB4GjnC1cKuGUeX9iVyjF1BO6IHvShC2ng3QTQskBRC+6Aw1UhDFABz3CbapaHp8YiOs9FL6DbnytXe/INW/TlT6ixRkC/JOiKbNzqX/uyjo1xAk2J8fjBjXEC/DHk6DxMEufm5HmKMyrjpk5UkX6gqWaGBhzPPT9KQcHIpR6b+H5nmSenAZ/RHooyGRoiy014T3Ik3LQkRdLhgww2aT8C3XF0vESoYHBVtlt3ersex45VQGK+jH6+S18+V49hFodR9N4LPDNGvvZ8aVR8Ule2+EV2V8FmUPHohxDH8OyJ+cVflykFcJEonTDlMGil9O/R5b4HehjEk
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(396003)(136003)(376002)(366004)(39860400002)(346002)(451199021)(316002)(66946007)(66556008)(66476007)(4326008)(478600001)(5660300002)(8936002)(8676002)(86362001)(41300700001)(52116002)(6486002)(2906002)(186003)(26005)(1076003)(6512007)(6506007)(38100700002)(38350700002)(83380400001)(2616005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?PJ37c7q6m4lVa1cnqwXR/ImgKOdORmmfp4uHheIUWswPlgQmxtZHClDEae4s?=
 =?us-ascii?Q?/QPlChS0KUIn+xw/UpbcC4zcQ9zafiZNjn4WSfKFiyojvhYC8/TtQoSoElfK?=
 =?us-ascii?Q?tfzHG5FwEiQva6h7lPLOaz7Y6zP5AX0d9UTAvedPLnd3PMPhRtTIcpPIoq7d?=
 =?us-ascii?Q?rO+k8raNBra5gpMbzERpmaHjM7akCIboaHTc2SW5XbKfOVXNrXhj7cUZU1lQ?=
 =?us-ascii?Q?LEjIqHGW8oUlB2y+DTccrhmnAQ15KzAg2rbAU4e4bao3hQExc6aBu0MDosC2?=
 =?us-ascii?Q?oQnOw2AMgjZtGu3Mz5lyIYb0IV4+xDgkBcTXygT1NGHZdWIoE4ZbymMzPnzx?=
 =?us-ascii?Q?RTVpn2voDV/pfOXUBUgLN1ZJaF41DHIPxPO7fAFMwm5grPT9cFoPJP6UIzXS?=
 =?us-ascii?Q?ZZwaS1nGcdTfqWZ3sv7Lqx9d01aZY6jmiJl7Ntp7Of/iAEUvdnwPWo8wnp10?=
 =?us-ascii?Q?eDyiuIlKBVszh0OZQi4nLb+E83ue/JI+CgNW5uJMGo0yWea6dzVwv1w4sHvH?=
 =?us-ascii?Q?ca/It+9+mFBipH/wqKUj/xjWsUnexBarqdtyAQMOCoBxzYJC16PtetdfYRdk?=
 =?us-ascii?Q?hiGVZmnncDnVuSqUMApwctHqnB0pDbKPlSxDZeW5NTbHJgHhL+gTKbO+B3gj?=
 =?us-ascii?Q?ffgEisYTi0nbPXi5z1Gz39VGMYPSG09x9MJ+156Nr6mP9avyJUPvgW1AyYCd?=
 =?us-ascii?Q?HAfw+JbkWER5DWWVIl4B+4/uiJgmVs34hKJXBTWQ4RUbcO8y/PefVBJQo9VD?=
 =?us-ascii?Q?iLUvA1ZX4htETrHN6hPodJ4Bpm9OCNbNmG/24v0cyE2yeLs7YfOgXuyPIiag?=
 =?us-ascii?Q?ybACrxEN2QPGykyjUGR41pnMe20g6KhPnQNqWWKRkza6yFWeIaUXroOiT5zN?=
 =?us-ascii?Q?hkUrgdyp3U3FKaiSyhUGb9/eBCxt0/DA3vmW93F0b2QPiekf2sMbx0ky8gvX?=
 =?us-ascii?Q?HWBuHujJFxV8smBwE4ks2RIZ/TQ84vFjkgBc2PSftHMQg3z0Ro8Vj4fowz2r?=
 =?us-ascii?Q?TxEDn3JU8wmWFwoxiQ3yAn9CYYOa5I3oxnzn/f18LJSPJZYJo6kaodMq2wq3?=
 =?us-ascii?Q?KorwyUkTBZuuyhNFeUppp9BG70pOyglfnHIimNQcLj3+6ugS/xMnP/VlwOIW?=
 =?us-ascii?Q?FzTHehl0KgxTtyG7oV+s1MMp1ayl3ryxELX+qdQIQs47ASn/UtyXAffUAvE0?=
 =?us-ascii?Q?Tme1fYRmSaZRsJGgvwm4gNEHWdy/fRhm0DfChudN2KYBAgsqbjO5MYubS4lC?=
 =?us-ascii?Q?oBW280satjQPPIMi/+DvHr5tPdFhwYb1ZhGQ83xbOu/2p3HFVs8DxbiH4mao?=
 =?us-ascii?Q?kmnFUAwwVsTHGX/62r9Bry+ERLCYQlWMcgq+1+PiOFsS7TDfCNr2XXTQDf+X?=
 =?us-ascii?Q?TeZ/vKa3u+LlpsxLTbApXFGkluVjN9iaDS+whQ9bmvMltRYVxOmPusKfHUY+?=
 =?us-ascii?Q?dqys0QtsbtVTqO6C+56GLtoaYDsi7gBnfZ0OkrAlvrKsYnP79xjrDnvK61iC?=
 =?us-ascii?Q?kz0KuyIHwOfjB3LBqzaDp6L8kT92lZZ3s8PilHjzq7OTpojnc++s6FGQ1vAJ?=
 =?us-ascii?Q?LnK2rtRb1IplfAktwguCcqIG8dtkkUfk31eMcuSl?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2548b6e7-ec71-4595-0a59-08db756a684c
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Jun 2023 10:53:28.2160
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ATRkIxwXx6hE4lzp+5MCZy4ZR46Cm5gE4wy4oaMlCHZhZp0/18IWhy8OUf+QB+8hloCyHJCgIjbkqVtxuZ4wzA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB7928
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Peng Fan <peng.fan@nxp.com>

Add reserved memory node for rpmsg
Enable CM33 node with mailbox property included for doorbell.

Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 .../boot/dts/freescale/imx93-11x11-evk.dts    | 42 +++++++++++++++++++
 1 file changed, 42 insertions(+)

diff --git a/arch/arm64/boot/dts/freescale/imx93-11x11-evk.dts b/arch/arm64/boot/dts/freescale/imx93-11x11-evk.dts
index 359ae86f4e7e..5050848a8837 100644
--- a/arch/arm64/boot/dts/freescale/imx93-11x11-evk.dts
+++ b/arch/arm64/boot/dts/freescale/imx93-11x11-evk.dts
@@ -27,6 +27,38 @@ linux,cma {
 			size = <0 0x10000000>;
 			linux,cma-default;
 		};
+
+		vdev0vring0: vdev0vring0@a4000000 {
+			reg = <0 0xa4000000 0 0x8000>;
+			no-map;
+		};
+
+		vdev0vring1: vdev0vring1@a4008000 {
+			reg = <0 0xa4008000 0 0x8000>;
+			no-map;
+		};
+
+		vdev1vring0: vdev1vring0@a4000000 {
+			reg = <0 0xa4010000 0 0x8000>;
+			no-map;
+		};
+
+		vdev1vring1: vdev1vring1@a4018000 {
+			reg = <0 0xa4018000 0 0x8000>;
+			no-map;
+		};
+
+		rsc_table: rsc-table@2021f000 {
+			reg = <0 0x2021f000 0 0x1000>;
+			no-map;
+		};
+
+		vdevbuffer: vdevbuffer@a4020000 {
+			compatible = "shared-dma-pool";
+			reg = <0 0xa4020000 0 0x100000>;
+			no-map;
+		};
+
 	};
 
 	reg_vref_1v8: regulator-adc-vref {
@@ -107,6 +139,16 @@ &lpuart1 { /* console */
 	status = "okay";
 };
 
+&{/remoteproc-cm33} {
+	mbox-names = "tx", "rx", "rxdb";
+	mboxes = <&mu1 0 1
+		  &mu1 1 1
+		  &mu1 3 1>;
+	memory-region = <&vdevbuffer>, <&vdev0vring0>, <&vdev0vring1>,
+			<&vdev1vring0>, <&vdev1vring1>, <&rsc_table>;
+	status = "okay";
+};
+
 &usdhc1 {
 	pinctrl-names = "default", "state_100mhz", "state_200mhz";
 	pinctrl-0 = <&pinctrl_usdhc1>;
-- 
2.37.1

