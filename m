Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 24D8C65CABC
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Jan 2023 01:24:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238178AbjADAYr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Jan 2023 19:24:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35578 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237814AbjADAYl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Jan 2023 19:24:41 -0500
Received: from EUR03-DBA-obe.outbound.protection.outlook.com (mail-dbaeur03on2043.outbound.protection.outlook.com [40.107.104.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BDD751659C;
        Tue,  3 Jan 2023 16:24:40 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=H4xSolN9JAMDo29UkMLdhSR0n6NjMxi9c3M0zaOAkGjeZ+RFr38u6lQKS1zKQcMQwauVA0UDwzZvBQlG37K93vrVXimLRpmOvD+3wsejvINWhlU1x2oJLNJ7tibgTGTDwA3eC0vHMT0XkPqjQdN8M5oorZJ/i7Q0iM416LiGkj6TjFoz5oIbbQM7o3UKA7f02XnkONZNMCDCtMAcM6eGASubMGjETElxDolhdM4c2g0BKqbeAnVdb7sjpx9RgsLxBANx77cUuRhiUFw7bxaQbTUg8gjmkP8COJKVu29TWN6QfeROjVvLgoRQakjGKChOnyu/+awR3CEKjPZCzVAQsg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=m8PKDief0qUsPM4/V6P0rQOsyx7GOeD0X8WURvQn8ww=;
 b=jL8QOw8O3vqNlmd4Ls2slg4dDPfgATXiODnGrp177DiFJWTZ4u+P3dI+1UN0gDCpVvfRAR7+8Xg3e5n7wpjje6aaN5kBLqp0XwZTZ6DbwJY47lZXYs54t8kJzQvsaBUt6tyczWYJk30qDrze1V9Y+SBugQ4vnRmDgDXmMjxeP3lhytqyAG8mhbYRXRm5cMRyNl6Cf+ucB6v+qC6YiNQ6Iuiu69Dijg2yWSpbCOj7e0p8kbV3x3zEgyM8uPYtKNRV1D/Q0awfVYD6qh7fAwkhjU043NdNQsCq+1o3xCEtpSUVLXuR9/ormRUT6wCgP7gugi1iRS4vkI6aohVJuzBFDA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=m8PKDief0qUsPM4/V6P0rQOsyx7GOeD0X8WURvQn8ww=;
 b=H0wrUPX1Q7IqWxrQjFsD5j44wjNNjEQ4gw8VJYv7KZNAuSyo+RJQcp6QEbBeNHbefyVrGo2uCk4CKXCPblKeVQFEFyoNGW75Afg8N9yJym3lG7JyhcK6hDiDN0mBzlys1JefLCL+i2znBsdWK2y98kz3NxULgx806buI1yZaODY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by AM7PR04MB6982.eurprd04.prod.outlook.com (2603:10a6:20b:dd::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5944.19; Wed, 4 Jan
 2023 00:24:38 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::29b9:5061:2054:174b]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::29b9:5061:2054:174b%7]) with mapi id 15.20.5944.019; Wed, 4 Jan 2023
 00:24:38 +0000
From:   "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
To:     robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        shawnguo@kernel.org, s.hauer@pengutronix.de
Cc:     kernel@pengutronix.de, festevam@gmail.com, linux-imx@nxp.com,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, Peng Fan <peng.fan@nxp.com>,
        Marco Felsch <m.felsch@pengutronix.de>
Subject: [PATCH V2 2/5] arm64: dts: imx8mq: correct iomuxc-gpr compatible
Date:   Wed,  4 Jan 2023 08:25:42 +0800
Message-Id: <20230104002545.3473598-3-peng.fan@oss.nxp.com>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20230104002545.3473598-1-peng.fan@oss.nxp.com>
References: <20230104002545.3473598-1-peng.fan@oss.nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI1PR02CA0051.apcprd02.prod.outlook.com
 (2603:1096:4:1f5::6) To DU0PR04MB9417.eurprd04.prod.outlook.com
 (2603:10a6:10:358::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU0PR04MB9417:EE_|AM7PR04MB6982:EE_
X-MS-Office365-Filtering-Correlation-Id: 8b7af9ce-e613-40c9-26c0-08daedea104f
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: cYNMBhCmntmg4VVyANjX/nGoO2XTp6VIl1GoAgXpwNPTxFS4CeyREKCExaIbc4EcqHr31EM92hMEoYfsNpYlBmUfh78uVYFyBLf8bbE5mKIPO74XMDvS8iVb6sRS++RzYxmpWA2eF5IRQOWzYNdQFR/ZmsGyc1Sp9DVcgEEIyR10hbsxJEs9f/yh7byY8WhwrOGjSeSrj27XHvK19QafQYRaHW7qIeqYQmeO2XhSgRKtSL80FeWlgmKsd7LQVRpLOTykrRE4Uw6LnsMWf7llGZVGWrWS/lrCbCNtCyqbCB++a0DgvoikzdOBZfZN5m7Qe4w/5xgKUawmNVgOvD1CCVDz7z4CpgYulyxLzFp4VKHVMlgiF8F5y8eMkZ/4Jb4Ak9u0Qs804RY0seC212i54SI0dCGlhlj0tO9VfGQBoGvb8vPEev6No6uzJi/iL4+qdjZsEYDALFnNr+yuSWVd4uhjnT7HZXV9GkS2Gz8CLIcUGWB07VEYNbkAcb043SiAZgmUieat6Gne2zeGHWJuAHq7v+FnSw/RUE4zWuAIIC4fnMWRD03tWA+AavtPD4OEv1K32aohCOglkEDUVNboiSen+v/CkJ8kJFI3U7AXLtKrRnoPtLSkdnaq7nzyFRuvGHjXMnUPBBJ15rCoz2RuQg/2UooFvJA3WF4bnSzCd3OmCR8JmnaNpMo2clFPXWPI5OMapklDBWKfF8smB9f1Unxl/SX9JKtn8M8I+DaUFnw=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(346002)(376002)(39860400002)(366004)(396003)(136003)(451199015)(26005)(186003)(6512007)(83380400001)(1076003)(2616005)(86362001)(38100700002)(38350700002)(54906003)(2906002)(316002)(4326008)(66946007)(41300700001)(4744005)(8936002)(5660300002)(7416002)(8676002)(66476007)(6666004)(478600001)(66556008)(6486002)(52116002)(6506007)(32563001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?lHzg86zuYo5/kVxRFUPF7k4+sTYMXi2RZUJ8+iKOw0zN7NSSR7kMBLimnUfS?=
 =?us-ascii?Q?K+cpOUhFAlDoPi/pdK/+TkoF54KdKduRsLL21j0RYWSJFXpFp5a3SqsuYTjW?=
 =?us-ascii?Q?YT0sIeEdVPflcs7a/r9xfqSXbvTfc7K2iH+74Hu2EEgCT2C2IKKWOEWc967n?=
 =?us-ascii?Q?Bwfd0MapTIdDhhCTaEWcIQos54AR0/PtKo12BLJrER47qEkXrjBz3NYSSRU8?=
 =?us-ascii?Q?87JXWWkpVmK1VRr7KtIO2KbBuzzgqe7fxZeXvpzXBLzmXCwT0C6s2IE41WUs?=
 =?us-ascii?Q?LNAAPdlykryttOKu8Sk9f2Beo+UlhfQvNRUeisuQk/FyqG33Z/GCBQiiF6oc?=
 =?us-ascii?Q?WumWMpREL9YOJ97zYj0QQUG5AbzLgH2EWpZS3PwwbrTdGQmvrAp76WznCDOI?=
 =?us-ascii?Q?LToDvCSTw8zqUFBIG7KGcIHJw086327r20Ko4nI0tV9tm/IIQzNmO0XgS7do?=
 =?us-ascii?Q?98k/nrYVBl5n+fa2n2UE7q2hDy04i/xN1NesnpwHwz3/Tp9c0SXNq3THFAeF?=
 =?us-ascii?Q?fsy9t5ZhlVYpImmMgVAFGAUAPvzf8KOMbQkrMNqrhEWhl2rx4l23DJa9rxhE?=
 =?us-ascii?Q?3tvW95bH0Gehm4DqIPVs8dE0FOjnZOoiP6o0MP2DMKN9vn9OeCSYM67Y9BZx?=
 =?us-ascii?Q?zoL7aOqzJ+aLj912VYVIqfUUOAwHS7/ygiPVlLso9tF7onmWFrLOQBH22h1u?=
 =?us-ascii?Q?x1OOFCvTxLOjaHFGsg/OXZLfPJXR/CRlPjc68hqAJhpxd8hQsMQUM/yHDgx1?=
 =?us-ascii?Q?CnNESehzUEksKxy7QL58R7P73KXidbFosX6WavLfEE1VB/Its3EU8HCTyEVu?=
 =?us-ascii?Q?q7NK2tGS1dtZOXB/48yqF7fPXf4Hqk6bb9bU359DSaE5u9HsdBrS8PcWRj6J?=
 =?us-ascii?Q?R9kF0jMaI4FPuiGwL/CDdGZpW8V3jJ6G/zQLHrGIPP5o5RxqBPKw2dXU2amz?=
 =?us-ascii?Q?8LWxPf28xlJHbnOezSo+aikPPxIToFrAmwdhciBTfKvvESddEPJPCLDbcBM1?=
 =?us-ascii?Q?Sd4MmVWzxbSxbQvsYTSZEYlBy4Nk9C7/s8gwrWSMf8I9tSpqSa+mF0FSrHwB?=
 =?us-ascii?Q?u95zFC7Uw2Zzq6JXluNGXGU4VO5maKxw/KnoSFoR3WZXYYagySASXlIafFN+?=
 =?us-ascii?Q?g04WTry2GLA1KI0uYPL0RQmxJqnhtGN2lpcElve7gbI1HnpROOsh9y7lJ25Q?=
 =?us-ascii?Q?MccySEkfOj89935yG/d4dJMKQjb/es62qzl3l5ji6EROALrNSZ+Uh/pe2hE8?=
 =?us-ascii?Q?0ShNSlUQpR+oJ4JGjYXVa8DfnY5NgaHpzVJ+yNGq1pgO2YJg7f7I0qayU6fM?=
 =?us-ascii?Q?Dun6yqhiYbDgnX3pgqCR2H+JrfWjuXRtKeA633IkB0uBe/6J3Lb60SHtZ5MB?=
 =?us-ascii?Q?4U9FWQADf66jS5RiLNRGk2mQ/JYmR0VKps6K1ocMpsLi8v/8WBeRO/MetHxh?=
 =?us-ascii?Q?lF7g0IyRoH5lc1L8tMkTP9B7GXlcXTTAg6nUKSLoDWStXT6ze55TmtILdk9P?=
 =?us-ascii?Q?1icK0bjLnU0hGtmJGmS1TLRki31C/cetMYLvzkf/zxFe4kuTO0wVYiUAHJxO?=
 =?us-ascii?Q?uHKckuf2Jz43hG4lho5p0vAiZM0WTwG35s/Iktb4?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8b7af9ce-e613-40c9-26c0-08daedea104f
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Jan 2023 00:24:38.1223
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2C18rqsw10bs0PbUeAc6KZfPv2XjFwpO5lq41DndInPFPdXAIuGYsNFmBEoP/gzS/jBA/Td0GIR//l5uIG/lQg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR04MB6982
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Peng Fan <peng.fan@nxp.com>

The IOMUX Controller General purpose register group are unique almost
per SoC, i.MX8MQ is not compatible with i.MX6Q. So correct it.
Also update name with syscon.

Signed-off-by: Peng Fan <peng.fan@nxp.com>
Reviewed-by: Marco Felsch <m.felsch@pengutronix.de>
---
 arch/arm64/boot/dts/freescale/imx8mq.dtsi | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/arch/arm64/boot/dts/freescale/imx8mq.dtsi b/arch/arm64/boot/dts/freescale/imx8mq.dtsi
index 7ce99c084e54..6971c47d11fa 100644
--- a/arch/arm64/boot/dts/freescale/imx8mq.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx8mq.dtsi
@@ -575,8 +575,7 @@ iomuxc: pinctrl@30330000 {
 			};
 
 			iomuxc_gpr: syscon@30340000 {
-				compatible = "fsl,imx8mq-iomuxc-gpr", "fsl,imx6q-iomuxc-gpr",
-					     "syscon", "simple-mfd";
+				compatible = "fsl,imx8mq-iomuxc-gpr", "syscon", "simple-mfd";
 				reg = <0x30340000 0x10000>;
 
 				mux: mux-controller {
-- 
2.37.1

