Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DF20073D105
	for <lists+linux-kernel@lfdr.de>; Sun, 25 Jun 2023 14:39:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232290AbjFYMjo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 25 Jun 2023 08:39:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59338 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232003AbjFYMjl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 25 Jun 2023 08:39:41 -0400
Received: from EUR04-DB3-obe.outbound.protection.outlook.com (mail-db3eur04on2056.outbound.protection.outlook.com [40.107.6.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED53B10DF;
        Sun, 25 Jun 2023 05:39:08 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dwppaLhe+x21gQfluV4r0IG/3LzcpSeOCEhUDdKQ/vCvc9PbfHQgTPG0L850XkJ5QFsaZS6eIHXWlJAZnPJQx1/lkvbKWZI/1KMMvAvcS9S6akulGaGvBDNDTut4yXJnd3MahAVxYa9MuU3YmIAITsSQ/KXw2oDhNUB1qFIcB7gCkDn15LrymCeIWr8IiNVI9PqoLYuIRpquL98et4kGKAwAblMgKsTKgqeDgjRRhzy+hGzhUuMyjyOqaSm1ydKxNCrLpw04hfRfBwBtq6NEmnLSNNv9zFytWF8MC9LI+vz7CieVjmsgNgrcOvCdlPOP0JDNwz/ciy1iLne7aXOBeQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ObcxzNlwAI6iJUDtJxg742qBwNMK12wD3xX7ve04JCw=;
 b=ZE6OP7LPcAkEGw1yNc5jlOQQ8NDB6J+3PdOgLeKia+RMCMO8UsHusqI/ZpCiBmK4klpyQhpbAjG9DCd2nnpKfOJwbVhM4PfF3ePgdxb85yytb9xYJ26QQ69LGyHMmw69UeZ8TcSnJjNu+nPuk6b6RdDwE4hniW4Y6skenh5PFm3+Nf5M4hdYEW6IZBRhF7gU4G0ZvMpEWEuBugiTh8GD5pcTGoc1VLbdiypngn+bYwVw2C20VRrb4tFRib7WQpgy0bmpy8yGtpxvk7oTW8+m33tQfk+jRl13yymAh7A/Ik/F5sUU24X792dRJS/zdjeSHiTZf+cDEnk/oOYuYH5S7w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ObcxzNlwAI6iJUDtJxg742qBwNMK12wD3xX7ve04JCw=;
 b=TRd7RIY/ZSj4CuZGPQL4Fns9H9R/b8aadjPn+wtscwDwX6xHj1/SwNRKqrrfYDupXrV/iP9Bs8s8evwoHlcl3JhOpjMvjxGLSdJ/KHDY5z/ePmrY3DXqidsTZwxMXMxOSQmq6fwl7woRyaADxtmlWJuEM5SoCkcLTT8OSDsuaXQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by DB8PR04MB7129.eurprd04.prod.outlook.com (2603:10a6:10:127::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6521.24; Sun, 25 Jun
 2023 12:38:26 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::efff:43d6:6f46:eea]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::efff:43d6:6f46:eea%7]) with mapi id 15.20.6521.026; Sun, 25 Jun 2023
 12:38:26 +0000
From:   "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
To:     robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        shawnguo@kernel.org, s.hauer@pengutronix.de
Cc:     kernel@pengutronix.de, festevam@gmail.com, linux-imx@nxp.com,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, Haibo Chen <haibo.chen@nxp.com>,
        Clark Wang <xiaoning.wang@nxp.com>, Peng Fan <peng.fan@nxp.com>
Subject: [PATCH 10/10] arm64: dts: imx8ulp-evk: enable lpi2c7 bus
Date:   Sun, 25 Jun 2023 20:42:38 +0800
Message-Id: <20230625124238.4071717-11-peng.fan@oss.nxp.com>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20230625124238.4071717-1-peng.fan@oss.nxp.com>
References: <20230625124238.4071717-1-peng.fan@oss.nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR01CA0111.apcprd01.prod.exchangelabs.com
 (2603:1096:4:40::15) To DU0PR04MB9417.eurprd04.prod.outlook.com
 (2603:10a6:10:358::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU0PR04MB9417:EE_|DB8PR04MB7129:EE_
X-MS-Office365-Filtering-Correlation-Id: 8629266a-8b66-471c-a60d-08db75791273
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Sc42Ok8jZp+CXMYmmyIXNuHIK2QpOUVG/r445b/ldZFW2lKHtfLmNa2LXSrdwqfmz+GgnNdDOECnUh1UX6FsZkzO/XeCThYr4wbYb/ZUVK4uYYl4WzsqcWJJsgDqJdC01OOLz4pnCsiqo8yySTwLRUbDra1SEt6p/VDSIO4LekxOpWXiq33VzrcqxnXM8gCfk1TnU4UhOwe/dwuM5Ljkdqy3ba3XwANtgkGv5kym1mUuRg3/Gcct8LnnRL7Sr3b2G9UAVmvdZMVK2YWCLGUhWI/No2vDmF8uclVntVn2nfkF3t+evJIyUkr032tFK2EBAhak9xYqZRriAplSp+Yh2CMog9J88O0d5mXOBSnNeVSHi1pVgRbVs/iI4fZUnsrOAikh2vQH0PBn0GY3TJWGqSPLCe4715Ujh5zfZfto/1ooDSKS7sTtwhyRFso/8AgqTkkZ23u9mjrwn9+xF+2g5maxYEyhYTjJ/VkucT28h668i4juO25KuqB6kzUrGJ1zc64Hkf8sZ/DP1/MPEsMzGRiwbN73JAa8hdo+jfhdYdnC8i0dA1NH8gxOV7NdiSfYzEtcMt94TFrm524KAMTUhhHqQcSoBiBatSDfUBEvwQm7V1hwehIwaKeAxZR4vJH2bp0Rr1A9VSF1uTnYw8O+pw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(136003)(346002)(376002)(366004)(396003)(39860400002)(451199021)(2906002)(6486002)(52116002)(38350700002)(38100700002)(6666004)(2616005)(83380400001)(6512007)(6506007)(1076003)(26005)(186003)(41300700001)(54906003)(86362001)(478600001)(316002)(66556008)(4326008)(66946007)(66476007)(5660300002)(8676002)(8936002)(32563001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?3x/P0G7ZOTQ8KQTn74Hva5vz1EalV1Gxt4NQtogjZdKe7RpEzx9cEC0id6Pg?=
 =?us-ascii?Q?xm8+Z8AHXFHRGf2jKxJl+Un96aFfK8ypMItSnmrlojJSFwjOHf3Uf3gQSo76?=
 =?us-ascii?Q?vlfu0CctqSVhe7DFjVdUa/RSkz8iq5RctYhFzIhDOzdDG1kJoewqbRUJTIUS?=
 =?us-ascii?Q?nsri7nMTHfmw98cl8Wv3PyyV/d5gAqc8tCCt9rj0e2BM9KS7aHTjoJ+affah?=
 =?us-ascii?Q?KQAPr7WdjAqRGSKDFFkFcNgDA3ZbHoYa1oCljqtLs9vidjV8x/Aw0SR11KmT?=
 =?us-ascii?Q?fWDxtBRwnSj/ojMpHj9URbf8qW0wbNlIG/EiDvD+hKQDTU+W4rFkXDplF+Pc?=
 =?us-ascii?Q?6UMn2auFhstnKoHQqH8zY6nguXbtpTG6fmZ+RDe4Rlw5h8qdc9e7li0/96Z1?=
 =?us-ascii?Q?8ebecYz7pLPQEBxZ4UoahbRQLedX2ZpsXPgqgICUmHsdK3SbJcmwWJSTZRgI?=
 =?us-ascii?Q?L16/dRj2x6gxYbnNSW4CwhySDnSXYXIXO0Pbfl1YxAHXVITJjvYqXrKblAK7?=
 =?us-ascii?Q?yjF0G8tyWnQAxdstRie2RgJM44vDpVaDN+6bmusxGiA8km9nIt5vVe36EZ3e?=
 =?us-ascii?Q?C6z5iKLXqJAAZ8VhER0mdjoFkYTF7PR7MGJMFMagOnZXp2mquISQAwP44SVE?=
 =?us-ascii?Q?F1VwSEgvzvo1n4bB7PbRCxxeKMf35hqv87jci2z2K6QGjnhUp2tYiDbWy++F?=
 =?us-ascii?Q?8VtMRNIm75wUJXB25ezwgGwpx7pa95CckJxQiK1eWifRghIUJLD8hEWxO6ar?=
 =?us-ascii?Q?7uxMnEaD/+K9KiYx71/r8yYE9akQUvsZ+oEEvjGV6PD5FmF6Y9WoZJwn5fMk?=
 =?us-ascii?Q?+w/AbqgDmBg14QZReWwoZs/oA444x+qIGJ6Lq/DNK1poJEjxqy0wfe2J+i03?=
 =?us-ascii?Q?G9m06xPszLXUv7oH2ugGFSqomK30PoYK/N84tsBrE2y8jRl/3mojg1m7o3ZD?=
 =?us-ascii?Q?WWhU40ReIDdSFxycztKzDNj6ajLT/+GYXuCwnYmL8TbmYED/rZL2Bh+QPaPc?=
 =?us-ascii?Q?eMbZTlwPU5GTIlF+MHC6sf7Qx+fZ8MpCxq6W+znPxqbjLCJqubKqV/A29jMe?=
 =?us-ascii?Q?1L356p6hUVnLAhyExUdU5Qf8hgHl9AZCDYCaZHonU7Twu7h/+fg98IaN134q?=
 =?us-ascii?Q?6G0J6B7RosY9o63ekk1q7pEg4xLFQcv3VQETLf3+sdQi1nqR9reIsBs/w3Op?=
 =?us-ascii?Q?Iw/IzfFaQNCa7o9wWFB4svSi2FfHjUdN/YfBp39XOjqoCo3Ipd/bHxNmFrMx?=
 =?us-ascii?Q?tJI9PC/BTH5Pzg0UO9jr7qsgKpynIXsjaoGFwjtV/+T8uq3HSqnX9aHo0wpy?=
 =?us-ascii?Q?A02wbhmBUnEiOT4QXp076M72aZ/L7bkexIaWP/LFf7QbWxpphW3VET0Gxlj8?=
 =?us-ascii?Q?h3od9CwI+XTp0F3QWJP3msLoPuYOevie+AqBzcqcLneXT+R7ZdanaNmt9OqS?=
 =?us-ascii?Q?x2Eht5F51gK+IEmReWGbvQ7fBGlnzdfeVInUr05yi4+Yzn88t5EVmRPnVFpd?=
 =?us-ascii?Q?xFiCB3LqrTVT5+imqfawkXPUtofzMJGiE5QRBkK7dRz0mv3k+UUi/xYzjHOz?=
 =?us-ascii?Q?lxwclIUDdLzBlWjP9SW6dbidislK4+qseKhWq66y?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8629266a-8b66-471c-a60d-08db75791273
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Jun 2023 12:38:26.6672
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9DZwHGR4rqmBPVPqO7DG29e9eMnqEvbKJnzE5oqSZF63Jv7vJp47DOjyFiZfL7t2e5utINDww7cesmU3w7bqOg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR04MB7129
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Haibo Chen <haibo.chen@nxp.com>

Enable lpi2c7 bus, and enable i2c IO expander.

Reviewed-by: Clark Wang <xiaoning.wang@nxp.com>
Signed-off-by: Haibo Chen <haibo.chen@nxp.com>
Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 arch/arm64/boot/dts/freescale/imx8ulp-evk.dts | 24 +++++++++++++++++++
 1 file changed, 24 insertions(+)

diff --git a/arch/arm64/boot/dts/freescale/imx8ulp-evk.dts b/arch/arm64/boot/dts/freescale/imx8ulp-evk.dts
index ab7af705bbca..785108c37210 100644
--- a/arch/arm64/boot/dts/freescale/imx8ulp-evk.dts
+++ b/arch/arm64/boot/dts/freescale/imx8ulp-evk.dts
@@ -120,6 +120,23 @@ &lpuart5 {
 	status = "okay";
 };
 
+&lpi2c7 {
+	#address-cells = <1>;
+	#size-cells = <0>;
+	clock-frequency = <400000>;
+	pinctrl-names = "default", "sleep";
+	pinctrl-0 = <&pinctrl_lpi2c7>;
+	pinctrl-1 = <&pinctrl_lpi2c7>;
+	status = "okay";
+
+	pcal6408: gpio@21 {
+		compatible = "nxp,pcal9554b";
+		reg = <0x21>;
+		gpio-controller;
+		#gpio-cells = <2>;
+	};
+};
+
 &usdhc0 {
 	pinctrl-names = "default", "state_100mhz", "state_200mhz", "sleep";
 	pinctrl-0 = <&pinctrl_usdhc0>;
@@ -202,6 +219,13 @@ MX8ULP_PAD_PTF15__LPUART5_RX	0x3
 		>;
 	};
 
+	pinctrl_lpi2c7: lpi2c7grp {
+		fsl,pins = <
+			MX8ULP_PAD_PTE12__LPI2C7_SCL	0x20
+			MX8ULP_PAD_PTE13__LPI2C7_SDA	0x20
+		>;
+	};
+
 	pinctrl_usdhc0: usdhc0grp {
 		fsl,pins = <
 			MX8ULP_PAD_PTD1__SDHC0_CMD	0x3
-- 
2.37.1

