Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 843A76C0110
	for <lists+linux-kernel@lfdr.de>; Sun, 19 Mar 2023 12:51:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230335AbjCSLvS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 19 Mar 2023 07:51:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56984 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229799AbjCSLvN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Mar 2023 07:51:13 -0400
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2089.outbound.protection.outlook.com [40.107.22.89])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B69C2211A;
        Sun, 19 Mar 2023 04:50:31 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mOcghypRBr+/27nrIuXJXhEl+zu/tNfdkoYMCRt4aGcWsGLVXVVFhxR365DOzrdzM96s+UFYS1BjGNE1LFX3gRR+pvf17v3chHKs0QWb4XsCG6qV5DHgwv3xBduTf2+fd86P23oVxWritjfvLnppEJbvHat5GXoajuz4d0WNCXO77693Pn2lrc9mHewD4vmSRK2zgZzLcVtaIB6Pxok048CnedT1Dp2A61wyW0ZF4MVx6rdMQXk5S2nJGvblxUUYiGYwyvnuAtvtlwy+5GbOwaCzRYMd/VKYrUCWTZ6Axp0yzQUaF5sUyhxRJfpSgM4JSrIbP/7USrIT17nF91EOoQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7nPkEt9QyfswdMet/S8eQ4hsytlZBf0Um1MloIm3Uq4=;
 b=IDlamdIIph9VwuW3mebtq2URxkGnnV9WZtH+CVfRvmt36Gzu4Qv4GTMb2buY1WpczuV1NActqK1IGDKI4HGJ0dykmlRB3l4i9VuQODulZFBRD62W7cI4tiywY0R46AA1rIP2fRMCqTSeGeNgHQ73LjePU1UiJNbO3QoIfTRPO+lMhmaqYj/UnLdtF6Ow6SwVC+swTVw9MMZeocO4w9PDXGPb4wiYvYSnba+jCKCxl/QoJ7RSTmYD8JOuDIHEx76pCpcGc5XzIpjdRAThucKnKcg0QmuDLucyZxh9sl3cyGo2UavzVCJT6rkhpTO8Qv+YNJfmGTnzl14B2EFApdPojw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7nPkEt9QyfswdMet/S8eQ4hsytlZBf0Um1MloIm3Uq4=;
 b=ZOPUmF+Dd9gui2KVZmECmw8e3Ev1ggD1MxSiBeskLijYWwQKT0UCYCSLAWm/kiMCAR91sblks9X8Xl7R+c++D4/l8jD8n5V/LYLlYSrg+zY6QtI8y9i9dLyEyDQ5LeNUidkppeLJdOP2F1J+DwG0KmnGFpzwUlBIHQt+t2WwxVk=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by VI1PR04MB10075.eurprd04.prod.outlook.com (2603:10a6:800:1d6::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.36; Sun, 19 Mar
 2023 11:50:16 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::f55a:cf12:da08:6d2a]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::f55a:cf12:da08:6d2a%7]) with mapi id 15.20.6178.037; Sun, 19 Mar 2023
 11:50:13 +0000
From:   "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
To:     gregkh@linuxfoundation.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, shawnguo@kernel.org,
        s.hauer@pengutronix.de, xu.yang_2@nxp.com
Cc:     kernel@pengutronix.de, festevam@gmail.com, linux-imx@nxp.com,
        linux-usb@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        jun.li@nxp.com, Peng Fan <peng.fan@nxp.com>
Subject: [PATCH V5 5/9] arm64: dts: imx8: update usb compatible
Date:   Sun, 19 Mar 2023 19:54:52 +0800
Message-Id: <20230319115456.716969-6-peng.fan@oss.nxp.com>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20230319115456.716969-1-peng.fan@oss.nxp.com>
References: <20230319115456.716969-1-peng.fan@oss.nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI1PR02CA0003.apcprd02.prod.outlook.com
 (2603:1096:4:1f7::20) To DU0PR04MB9417.eurprd04.prod.outlook.com
 (2603:10a6:10:358::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU0PR04MB9417:EE_|VI1PR04MB10075:EE_
X-MS-Office365-Filtering-Correlation-Id: cc9b57fb-547c-463a-e069-08db28701941
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: q2lzEdQwZ8fiW8lGAz7Ar8w69MACapbk/hqYD2uUWVzfQLibKyR6I0z7g4UsZhaAb5ZhP1H4kd7IdyZOM6x8HETIW5BwRydjSQknhZT86Dcfyc6QiJNd89F7BmzBDUmGYbMvUFOLCjA93YVYtNoVlr/4Os3GXNKyUZIxI/bwNk+qHqoKhCU5piwdcWtFxwlnlq9J4nBUXHkfBYG1GnkrvsDmMOS2kTLWPE3GpmdvFmfdY6EkUj4sZ9SP0J9rWKPT7rcG0TWr+ghYg5kQ3zJwxEmAPDYoFF/YS3N/21hzYj3sQQfGxMzyd2CKStGY7jCgsJr7yz5WWMW2dlImrFNy222s1LPD+OmH23ZoL8+T0kgi/ISH/s28U6xwPGM38QE+CPwzE/Pq1MPuEyRaDwSNjpAuVJ1KzRIJaLgIPPgzdGAaGDWTIR2spoQkZuN6XZsd4cavkG37TV/ArQb7HSCErchDkul28ll4T3pBhR4w9NCCV0DVKsPNYR9cabPvXU+/OxBSeMYa/auAiFr5J9TVC89aA/nrJCauiDaQfPtSr8TU+mg6OUa0k/xmfld9CLSEMzdYAwFUHzf0q5WtSGabMElCDV3XD3Q3wjrHv2L3y9n/bBGe88NOeO+9M2q0lL0ChJWpq/6MDDvZiAHyKGrEBtLmETLJNnXtfaHrbqOya9yTWcyM2YpOxFMBUvhuJui/EGyPBUFw5wQUyl0+1B75tw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(346002)(376002)(396003)(136003)(39850400004)(366004)(451199018)(86362001)(2616005)(186003)(1076003)(6506007)(6512007)(26005)(15650500001)(6666004)(38100700002)(38350700002)(2906002)(7416002)(8936002)(5660300002)(41300700001)(8676002)(6486002)(4326008)(478600001)(66556008)(66946007)(66476007)(316002)(52116002)(83380400001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?AUgKwjNOueA/7mGREpcgPNBqRXayK+7E5Jgp/tAWjrDiBZXuom0DNHmRyXDn?=
 =?us-ascii?Q?pH/OYi0u6V8FfYcxYubNEo8e7Y2O5CwLLuAIyIDmZC8Mp1NcEUzrPXQeMrvG?=
 =?us-ascii?Q?Kfa2X7U5RTuv6DfDWjQbHuibSjgZhC5FibfGA43VVdZkhCQlO2N3EkzxJ92z?=
 =?us-ascii?Q?ilLLIzXUSHUtUWERkxYfcEXMIX9L2g/27i1Ac8tvYPnQAaL4/sQr97zGMLqV?=
 =?us-ascii?Q?ZCtOFcI2kKRl/UG61d4JFrCmIjiMnXj2cCUWIW/xCWC3kkPRvxsp49wo1qul?=
 =?us-ascii?Q?c8nBGx+RYXnIpCkNW16skwdpWNkCxeEp6ja89CBsab7R4b7N3CWgoecHmgwG?=
 =?us-ascii?Q?wtHtAwF+UPxSveM4BVMr9WCCik/FtTrAD8Y4lbVH8CTtNaYpAWThJqSS6YE4?=
 =?us-ascii?Q?5DStApWZAYFlubbu57vTtP5XOS7NmNyqrMzxGJhi4e65zbzwDCwSrT4iNda+?=
 =?us-ascii?Q?zXpl3aVcr9ubALFPySFtvJDJ+dqr8UgIcqpwjyeT8WJHiBnhXwuzlAq764NB?=
 =?us-ascii?Q?7U6noCqMT2O2e8Omc5tLq0f8D6Cf+4kNAV6NvbdxXptlH84RyMxQhIu2Jixn?=
 =?us-ascii?Q?K/6fM9BvO6gQX2D0JSly3XEYR3WIvdUEth2s6/CqyV00r8JNAhKMzTuMLDdJ?=
 =?us-ascii?Q?LkS3uki8JOTs/pgKkPE+ipVhAmcb7gbjrCztgYPtQZwUU2MN0SMF1kTCBCHB?=
 =?us-ascii?Q?v5SX52CpYGXfZzqH8l1hym7LSamUxdol+Jg0O0D+jN7ZgPSs8vv9z+K9CSNs?=
 =?us-ascii?Q?zeJoZKPLfJYfrA1rEySG7EJv2wFEV9OqQQgU+tjnGqXC1UXfgdtX2SvJzuKK?=
 =?us-ascii?Q?wPabY2ssWgiRz26odL8s6Z85gGNJ+5vs8fseW3TmcgHG/bbCm1itBawlnwwf?=
 =?us-ascii?Q?d6iL1w6nDDlbd/0bebsZe5Q+w56Q5XmoFQFM4tbaKm4o2uEJBpy/X7qywVjC?=
 =?us-ascii?Q?6DGdsdUEa3USeuXGox0F41iEJERVnZ/vpP0/Vu4873NPR8oGLfP2w04NBfYF?=
 =?us-ascii?Q?cmNw3tMLAKhjCVOQ7GMO5MgQHp/+E91uhxNfLZzMBVSOx3S0meV7D2G2cp+q?=
 =?us-ascii?Q?n32jR5Ac5ic+jXIa7f/uKqSz1pI3yedMSxq927YRJr209u3CqQgU4lv9PElQ?=
 =?us-ascii?Q?6cfuXwUaPVts4TCGuhIgESJpFlNmfolJ6bhFyhPVDgM4+grUNXnV5NlKltPJ?=
 =?us-ascii?Q?Qu2ROkA2fih+Kc33aUwjs1TvdaQsdLiEeYqkZPICc2353ckvLZ028GbwqAQ2?=
 =?us-ascii?Q?UO8HcmhL3SDEn5GxehSYGP/s2xWEoWGF93FswVk6lrScThVErdY9WpUkdGEz?=
 =?us-ascii?Q?5jUQKJnP8YInLUDxvsBpZofV7yzlpUfFDBUVnHrXCVkMkVt/nrCK6gbr6ocK?=
 =?us-ascii?Q?Xfq48gxAFbPwAHvRfnLZXtQvXfw51xmRL2N73Sqvy/8rOPhiwHuNQ5SvFL/C?=
 =?us-ascii?Q?uo8d6IL9gLulCRIJ8NmkiuZsw37XWC78DegCYMCcGSAUMd9G/+tLz7CX9W40?=
 =?us-ascii?Q?eoRniI9JRXomewqnj8EkHUZc+8/o7ikoqWw9BZuMdPrnOn5bcM8HC3UWv0aR?=
 =?us-ascii?Q?AXY3XKhrAu2Jv/s43Uwu4qSrKLn/ZO1eaHfXGDiQ?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cc9b57fb-547c-463a-e069-08db28701941
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Mar 2023 11:50:13.1235
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: nuZ7ZsMZxChj+HPRH61h33/fBKNOb3VGSJtciFlI2EFMeHThMwIfGhrLquSgihI5OXdUmBlwvtw0c9OkW1h0GA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB10075
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Peng Fan <peng.fan@nxp.com>

Update usb compatible per binding doc

Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 arch/arm64/boot/dts/freescale/imx8-ss-conn.dtsi | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/boot/dts/freescale/imx8-ss-conn.dtsi b/arch/arm64/boot/dts/freescale/imx8-ss-conn.dtsi
index 4852760adeee..6ed084862345 100644
--- a/arch/arm64/boot/dts/freescale/imx8-ss-conn.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx8-ss-conn.dtsi
@@ -35,7 +35,7 @@ conn_ipg_clk: clock-conn-ipg {
 	};
 
 	usbotg1: usb@5b0d0000 {
-		compatible = "fsl,imx7ulp-usb";
+		compatible = "fsl,imx7ulp-usb", "fsl,imx6ul-usb", "fsl,imx27-usb";
 		reg = <0x5b0d0000 0x200>;
 		interrupt-parent = <&gic>;
 		interrupts = <GIC_SPI 267 IRQ_TYPE_LEVEL_HIGH>;
@@ -51,7 +51,7 @@ usbotg1: usb@5b0d0000 {
 
 	usbmisc1: usbmisc@5b0d0200 {
 		#index-cells = <1>;
-		compatible = "fsl,imx7ulp-usbmisc", "fsl,imx6q-usbmisc";
+		compatible = "fsl,imx7ulp-usbmisc", "fsl,imx7d-usbmisc", "fsl,imx6q-usbmisc";
 		reg = <0x5b0d0200 0x200>;
 	};
 
-- 
2.37.1

