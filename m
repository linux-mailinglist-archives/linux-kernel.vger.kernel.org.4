Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 37A8573D107
	for <lists+linux-kernel@lfdr.de>; Sun, 25 Jun 2023 14:39:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232321AbjFYMjw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 25 Jun 2023 08:39:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59416 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232003AbjFYMjq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 25 Jun 2023 08:39:46 -0400
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2048.outbound.protection.outlook.com [40.107.22.48])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 29A32E51;
        Sun, 25 Jun 2023 05:39:13 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jNAgkBJAtqZmbYFRBHSnyk4YyQO5eU2Hzpq+z+NSc2IZbmFAvTxRlGSqVq9fOXaBa8uzBexuUtXWUr76UxFut7+f+kEE/WzIJJWb7oL67LMQM4M8s8pgCrKFCz/n8Oib1MXibc/JZhwzjEgMHYigqyObm480hYQGNYFzcwEZ14IaQ5A9eAu8S2b1cqy1q3Wf/wWm29//OED/gkYJ6P6YxaUZXHGM2Sl1lPaBOXAh+Vgloj4YUPhdEJmAgjO0SCg4fN3/u7HczSuV6L6bU53lr0GnOjehRJdY+MOA93VzfHI2LQWLcNeK2uPyBw2sfOjUIiOJhPLL1SOR5imwzqlFQw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qmA0Jfkdz6jXehOqIoczQo+FwUAxq7tCcYKGenIuGx8=;
 b=EyYPQ4F3ikt9eEO2e6FU2fqfQSKF4SzSeF8Y5Eek9q5cnFYR/xq3iMYg9H5Svah2HPcx2daTgb6jwp6ycENO5ajA5msnAzTOyai1NzG1Hd0cwqCJ0h/s4ghAVxBNefmfjJf3DEIiUUslOU1pOAHwkzizpppvokS1XgKnhiE3QpOxLPT1Ob/tB6mVqSK14Ywj1hvIjSI0qFb9w7WsmJQnWfziXgTEtc1PBd18F9ai/bgQo+TLeqlGPFxG/zDhjxtiiPxdhA1xydJwFXaV/9/IZlxeaaHsF2yzEsg5kP4XwsrkJlJVCxi8nx9Rnquqv2BpbA+dkfi4WunIs4dSSwIfJQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qmA0Jfkdz6jXehOqIoczQo+FwUAxq7tCcYKGenIuGx8=;
 b=OwhuRrLZ2dOGAeoLNNXF3vCDleUEll9jPDB1qVHex4UJSepwoZ1DGU5lNmuso4eeUkcF5KAsiMboxuBU2SfpFsi/WKyE+VrZvSRkbFP0AZLYP8aafv3CWMYls2BOcS8Gsk/DuNqFZ29Yn8Vp4wBxgWLWc2ZDSgAIlpeuLlTFANE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by AS4PR04MB9314.eurprd04.prod.outlook.com (2603:10a6:20b:4e5::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6521.26; Sun, 25 Jun
 2023 12:38:18 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::efff:43d6:6f46:eea]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::efff:43d6:6f46:eea%7]) with mapi id 15.20.6521.026; Sun, 25 Jun 2023
 12:38:18 +0000
From:   "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
To:     robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        shawnguo@kernel.org, s.hauer@pengutronix.de
Cc:     kernel@pengutronix.de, festevam@gmail.com, linux-imx@nxp.com,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, Han Xu <han.xu@nxp.com>,
        Haibo Chen <haibo.chen@nxp.com>, Peng Fan <peng.fan@nxp.com>
Subject: [PATCH 08/10] arm64: dts: imx8ulp-evk: add spi-nor device support
Date:   Sun, 25 Jun 2023 20:42:36 +0800
Message-Id: <20230625124238.4071717-9-peng.fan@oss.nxp.com>
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
X-MS-TrafficTypeDiagnostic: DU0PR04MB9417:EE_|AS4PR04MB9314:EE_
X-MS-Office365-Filtering-Correlation-Id: eb8b5778-8e52-4081-193b-08db75790d9c
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: s1DV0ps7Nx1lf6WzjhtHtz4dYWStWrPCw3+aLft9Su9JrOU6iCZc0d/9Gn98s2daWYt2CATwR96fl5rC6OZH21vwgfXaICQOnqKJRbaHEpiuBkIIoRoti5AnIbGGE7Um8zoV/wSb9zf1+gXl8qvDTZ6TVat0i5VRwuQp4OwqztgFCcav1SDeECBH7sCB1lE0QmOjqXXJGz71D09haZ+XKzsbH8xLYqV6yCYOR0h+ups4vsebDPcevjotsc2m2JvIX+pDocxGFut7NmMxqVI5LGciYpEpfYyi6GsuMEyZWPTR49eBWACs7bFFasmuQxuTEr/tRoWfFIxpD9xWX5xL7y043Vr6tiFQYhCIQJT8jRYhAxZt9YVh+D5kaDVnS7S6cFlYyWihO7cZSjxk9B8W5ToesBEOmnuCAOBCn+9NtxCWZkvpLXpkizGCDTdtckNIZYd5rlOEa5BJoB6rd5YrhMdPLyiqEUtZwMuM27pQmZHOgRlABKDh0aSkRYz5SJTU9Ni9P4uuuqMKqwrc+yeOlvxjz/TCQkHyg7LV7zNOKRy9/3WLPYQygmxCEjKfvCx5IUrhU4JUuuvTatdvFK2wW5jatrxDhqvvXfHGue4eRIojSgNTGCh47AUXfUYewSuOrTEeiX2eP3D915mrBQv2Zw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(396003)(346002)(136003)(376002)(366004)(39860400002)(451199021)(5660300002)(4326008)(66946007)(66556008)(66476007)(478600001)(316002)(8676002)(8936002)(2906002)(54906003)(86362001)(41300700001)(6486002)(52116002)(186003)(6512007)(6506007)(1076003)(26005)(38100700002)(38350700002)(6666004)(83380400001)(2616005)(32563001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?PNT0cl4pTEYFk/+fkj7kdaqPSfOS1Tx8xJQHv7CwoZrhTuBOOKVxVw+TVamr?=
 =?us-ascii?Q?IL0xbjkcyEbLiik58UXSZqAu/S1i02bAvfUJRLofHVuTS078Grx0htyuvofc?=
 =?us-ascii?Q?LH87utWSYCd18oEW0Pdz4/QUOP5NEqoU+Wqq8EhzznQKUSCDWtoF2hrd9TWc?=
 =?us-ascii?Q?0jq6aGlYeGgGbbbIq09rueL6FK08WtguKGQMXowxaIIS6AtFf/IesOHswqNP?=
 =?us-ascii?Q?P/BfkJJfvdjcAVr0QfTAoy0QGHJK1OzWtjoCdniI2l66WbkQEt30AG6+x3tE?=
 =?us-ascii?Q?GhO56+Q6UC8ENJNwanDfIXj70mQGJB3bBC3ebh5UR+TCierTWP+NGkBI+PM8?=
 =?us-ascii?Q?2/VpkmoZAoLfC9xSqqMXPyorWY/FcoeIsgUHpn5AaXbrhl0a2toq4u3Xsdf0?=
 =?us-ascii?Q?/4nm/yAXAE+BFK5BA+1E9bCMK5CcSMaTseA3gcyXWaTofJlK4E1dnS4IEFzp?=
 =?us-ascii?Q?KYZsl/ew+AN23SPBehILSTyiro4j0/kGDqZei6GNxI2R+s/UeWmlxbKoOyq/?=
 =?us-ascii?Q?3MuhTN79DU7sQJZWJ9q1AuLVcI+ZpAXnvuI+qCBP60mxKlMq5r7j+KkEkgQx?=
 =?us-ascii?Q?mEMXTBb2YrtUy2k86QjL+0Wkfz/7uO7K2cwkqklMLFcczQP4qR+PZbiesofL?=
 =?us-ascii?Q?e03pWNnEyBu8T9fWaGAeTwphMc0TXS5FF2znNIBtn/nmMfQaHp+25+NzThDZ?=
 =?us-ascii?Q?hYrOIrWbaeruo/WfRpYqhkPjCpR7sCUa1bWRUcpFOq5V8YT0OTBzGLxIkFRv?=
 =?us-ascii?Q?+OnpyH7lNysgewxGHufwl5EPWg6/sL5RlWEEOU/zTYXH4vToUvXrGr9iU5tP?=
 =?us-ascii?Q?ObdNUythPXrD6MoIlwzm9hl6Qisszh0eAdWOi7G0XW6y6hGKGRngW4OzWmDr?=
 =?us-ascii?Q?ThquqF/TmdMuXt2+p+G5OPZZ/Ev5mIRJa2azbDkWGndPRl4YflVcgFitiSb5?=
 =?us-ascii?Q?7+Sl8LBm2lzCruZdd1tprMKlWdN6PFi3fwCiaJh/UPFaafC5xpPxcwRXLDxt?=
 =?us-ascii?Q?IvzYYDPB+bA49oZc4LdaZgTzdcbebCHV9nH3KFxTCkdsx3+kZJj31QdxhN6t?=
 =?us-ascii?Q?luZp0mVIDUrhc7YMe2fx5SUBsGHYhxWMIA+ups8ZKOOWMujXnmyWXyYarg0t?=
 =?us-ascii?Q?8eb9EHPrVb4MXAsC14++lXJtlJd/2MkqEGMhJGC5uOoc7xMGwXGi0HNqd3aB?=
 =?us-ascii?Q?t1hlwwPr3oriYbL+DCs7KkFJTYRtHsKG2oyKkzQBYgF3n57wLElDge9pP9IF?=
 =?us-ascii?Q?KILtyePbX3dcigz2rtk+bYTrdO80QbZPbh1bi460xKC5oeKqIjI3vXrRZSmR?=
 =?us-ascii?Q?NOzKuv7RUcqZSaDaqys7IBXMEPTlfpPSnOh6Dc3I+dIhxJkLl3NlIAKcZaoi?=
 =?us-ascii?Q?wwGgtyiHFNJSWQfshkdjCPIMMeaGJ4vueIxIakU9Sf1jCO4kanOyonQsiqry?=
 =?us-ascii?Q?72ak8VZiqiPTCHOuez63TX2PtLco4Y2RswvT9NSFcwedwGnT0NFbrI+Q4dLP?=
 =?us-ascii?Q?kEUIOEaeMY/wEcUD8SgWqq4ckMKD0ZJuQHfwh0pADt3fWLmgjv8jdNF7TNPj?=
 =?us-ascii?Q?1iyR4JNBq45QA0y+FDa7iEo4wFSdvvOLjkYRWyHv?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: eb8b5778-8e52-4081-193b-08db75790d9c
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Jun 2023 12:38:18.5346
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: nmC63WCMvIA5b/bqM7EsYYIyrmkZwZoKMncDpNvDfJNf94hItugr22gE1qWbt1/x4gbCM7g5sN8Cz+LrLrggGQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS4PR04MB9314
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Han Xu <han.xu@nxp.com>

Add spi-nor support.
- 8 bit mode for RX/TX.
- Set the clock rate to 200MHz.
- add default/sleep pinctrl.

Co-developed-by: Haibo Chen <haibo.chen@nxp.com>
Signed-off-by: Haibo Chen <haibo.chen@nxp.com>
Signed-off-by: Han Xu <han.xu@nxp.com>
Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 arch/arm64/boot/dts/freescale/imx8ulp-evk.dts | 34 +++++++++++++++++++
 1 file changed, 34 insertions(+)

diff --git a/arch/arm64/boot/dts/freescale/imx8ulp-evk.dts b/arch/arm64/boot/dts/freescale/imx8ulp-evk.dts
index d66e31cf83fe..e459dc35e469 100644
--- a/arch/arm64/boot/dts/freescale/imx8ulp-evk.dts
+++ b/arch/arm64/boot/dts/freescale/imx8ulp-evk.dts
@@ -95,6 +95,23 @@ &cm33 {
 	status = "okay";
 };
 
+&flexspi2 {
+	pinctrl-names = "default", "sleep";
+	pinctrl-0 = <&pinctrl_flexspi2_ptd>;
+	pinctrl-1 = <&pinctrl_flexspi2_ptd>;
+	status = "okay";
+
+	mx25uw51345gxdi00: flash@0 {
+		reg = <0>;
+		#address-cells = <1>;
+		#size-cells = <1>;
+		compatible = "jedec,spi-nor";
+		spi-max-frequency = <200000000>;
+		spi-tx-bus-width = <8>;
+		spi-rx-bus-width = <8>;
+	};
+};
+
 &lpuart5 {
 	/* console */
 	pinctrl-names = "default", "sleep";
@@ -159,6 +176,23 @@ MX8ULP_PAD_PTF10__ENET0_1588_CLKIN 0x43
 		>;
 	};
 
+	pinctrl_flexspi2_ptd: flexspi2ptdgrp {
+		fsl,pins = <
+
+			MX8ULP_PAD_PTD12__FLEXSPI2_A_SS0_B	0x42
+			MX8ULP_PAD_PTD13__FLEXSPI2_A_SCLK	0x42
+			MX8ULP_PAD_PTD14__FLEXSPI2_A_DATA3	0x42
+			MX8ULP_PAD_PTD15__FLEXSPI2_A_DATA2	0x42
+			MX8ULP_PAD_PTD16__FLEXSPI2_A_DATA1	0x42
+			MX8ULP_PAD_PTD17__FLEXSPI2_A_DATA0	0x42
+			MX8ULP_PAD_PTD18__FLEXSPI2_A_DQS	0x42
+			MX8ULP_PAD_PTD19__FLEXSPI2_A_DATA7	0x42
+			MX8ULP_PAD_PTD20__FLEXSPI2_A_DATA6	0x42
+			MX8ULP_PAD_PTD21__FLEXSPI2_A_DATA5	0x42
+			MX8ULP_PAD_PTD22__FLEXSPI2_A_DATA4	0x42
+		>;
+	};
+
 	pinctrl_lpuart5: lpuart5grp {
 		fsl,pins = <
 			MX8ULP_PAD_PTF14__LPUART5_TX	0x3
-- 
2.37.1

