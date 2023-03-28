Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C55B36CB4E4
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Mar 2023 05:32:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232662AbjC1DcZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Mar 2023 23:32:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40406 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232633AbjC1DcD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Mar 2023 23:32:03 -0400
Received: from EUR03-AM7-obe.outbound.protection.outlook.com (mail-am7eur03on2089.outbound.protection.outlook.com [40.107.105.89])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 689B0213B;
        Mon, 27 Mar 2023 20:31:53 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=O7RUV7wLSaZHHXKwqLJFofe6lEqlRNdH7Rrzy+0Q3wtQxp7GikUaLd5dVkn7tVCoLZRb31P/pCsuGaYadFYWfm5Boek1f4I2BGbvTEiIOUPSBz+Bl+TLZB8s0gQATxfeu+giwqmxLruWvo7i8u/MbdiuRuvQ6r66YB1/L2150VMCbRi0BQxTTnulnARdQcKjsLXLiqbtHPox6kN2rZSh9094NcY8qEQzJCbOimPk8f2T5r2ISshAnVay9QIie9gDGvBwWXJS0kXZIMDPKcr/zCqG2qK8GKTiOtuTYNU+lS97Adyg5kcYpX7FjyGmnNGEFUglTO4mDjKYxqrWK8kRXA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TteCQI2MmgaC40NDEeKM+hJ3eQ5IIMd3fOFcgzdSOAc=;
 b=na9ZbP92BmA/sEQWRd60FRxrg0mc8OS3jDNMLW/mT0yeVqdLoD9ra0P9QTGFtzxPqovaUEfn5H1E/OYYZVO6gmQrfPZSIsISYc0qyRsU2kBYVUVgcw0LZM8+Jvqy/nrtz+VE4j2o8kXu04QmToXkTlRdsaM44tv93+5JZme4SocIRxCHxZDx+269pz5nAfbrl5VBE/PgTwdNuTkCALDvQ2Eg8trIU2BMb5quPLVmyXx2kuWPlZFzGmb4OQHddSzy+is9uGiLAK9kB15s9E2qZsYRFTXqNYlGTf4Q2VoNDq8jY+FqEBNPo4wc4d60ZGCwPnxv8YBxzzp5Pt/5sZcwlg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TteCQI2MmgaC40NDEeKM+hJ3eQ5IIMd3fOFcgzdSOAc=;
 b=MYdChluzTWuEuEKy6J9GPepYfEPuZ6x5j3OKSuxyiFU9cslOgvcob+JsxE1kZdpdid8adM47+G6YFbPqqm4O3QGY77lKwff32pY1cf31rwPupVGK9fpmiJ4LdHhe3PJuCT2iZOqu0i0sIIBkaaJTZHsT3mN/P7ZE8j6CRQpPR74=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by VI1PR04MB7184.eurprd04.prod.outlook.com (2603:10a6:800:125::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6222.30; Tue, 28 Mar
 2023 03:31:51 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::778e:19d0:cba0:5cc0]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::778e:19d0:cba0:5cc0%4]) with mapi id 15.20.6222.028; Tue, 28 Mar 2023
 03:31:51 +0000
From:   "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
To:     robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        shawnguo@kernel.org, s.hauer@pengutronix.de
Cc:     kernel@pengutronix.de, festevam@gmail.com, linux-imx@nxp.com,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, Peng Fan <peng.fan@nxp.com>
Subject: [PATCH V2 4/6] arm64: dts: imx8mm-emcon: update pinctrl to match dtschema
Date:   Tue, 28 Mar 2023 11:36:38 +0800
Message-Id: <20230328033640.1930104-5-peng.fan@oss.nxp.com>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20230328033640.1930104-1-peng.fan@oss.nxp.com>
References: <20230328033640.1930104-1-peng.fan@oss.nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR01CA0043.apcprd01.prod.exchangelabs.com
 (2603:1096:4:193::12) To DU0PR04MB9417.eurprd04.prod.outlook.com
 (2603:10a6:10:358::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU0PR04MB9417:EE_|VI1PR04MB7184:EE_
X-MS-Office365-Filtering-Correlation-Id: e771ea3d-e295-4267-b233-08db2f3cf838
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: fOJraEJ7TXunwwzsClmyE/8ZElQJ+3Mugjr+bmEvMTAISVFuLcPnD48LEb3BX4J5eMFOC8W7TRM4fGRnl1ELFkiQfjrLyotrQF8iSJLgwm8TspEs4iAiJlNQH5Z1QuGDhAzZ2O4mFWz5VTIV2H0aV2Q0x3O90e+GMCRlgZz5Uhh4wMd0PQLEE/o6LteVHyjhFZDWknB/0TaaLQg+5k0tlL0DLTlECw1jy+fVhwghrONMfJ681S4idqaneUDTMItf9FQhqpXHyrWpmtUnO814F7Eo0uIGqZC44ueqApaEHvyrOFHVIzjdD4dzDREGUaKG4Z1MlIl/IoSUhn936hjchLN314djCguXHgpvUp0CD8ppI3faNTAb9/UAUDbcjqjeqCixz/ASRIzz2Mw4CWEjKHWtOMyXE2csjDgYFPMVKI5vr58od9ZHBqGuVkp2EqtYuLi0Vlp30rBdCbapAu5FYLfLdd5wMRjVHtxE3VY65NaYoT1HpHJ5slJXHhylUnbHZdWD4qy4qWeuiWqaZwKXNb2mRFbEQZ2c1qoKo5yKHTfMM40B/1UsjauP0fiHeKaQZsSR0LixSlUIYj325sVbovyVG3cuaw97meb3K60KA+AD6jcd7x8Ht7Avzj2Q0bjGPz0DWjqBOg+6Oy21H0ukEw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(366004)(396003)(136003)(346002)(376002)(39860400002)(451199021)(86362001)(6506007)(1076003)(26005)(186003)(2616005)(83380400001)(4744005)(6512007)(8936002)(5660300002)(6666004)(6486002)(41300700001)(52116002)(4326008)(66946007)(38350700002)(15650500001)(2906002)(38100700002)(316002)(66556008)(8676002)(66476007)(478600001)(32563001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?PXZ1UBfqh5EXXaZjMfRG7hZ5m82IxerseNMV8sBrs8aJ8Yijg9ruZB6+syS/?=
 =?us-ascii?Q?S/Ez3wFwcgVD6lIsFZygoqdSXQxJ93rO54EmKwHE3qmkE2uuUAon/s2N2iTZ?=
 =?us-ascii?Q?nGVK1Tqp+nL1DIQHQTwn9v8ktEhGguiUUWQQlu2dzouWeC9u1HYuaheP1Tlr?=
 =?us-ascii?Q?gl3ilI8na9Pw5b7D2sZf9pLqtaKu3Z0O98LBPE5+gzINEjYwzwwiynY3Sw5G?=
 =?us-ascii?Q?ulWq2l2S4k15g34EB+pUBs0MRgNl5PISn8tch1Jli/G2MGwSj0L34TUKuyvV?=
 =?us-ascii?Q?nouJyq0GnZSyzebr4PxLRqNh1VZ7ye1kAcLPBPc1gbFcCZMhEW1u5W93Uh/9?=
 =?us-ascii?Q?OIaOiLL2GHaJnVlv2ownTKGzuBUT+29Lq9mUpxpuPmzRdkL8WgW7IQL5/4SN?=
 =?us-ascii?Q?Ve4pkG+ezUYHj1F5BB2OI1LA+QxomA657l32TUlqq1wuQAE9T+pADPyvfShg?=
 =?us-ascii?Q?GB3SenTPiz0YFQ4+nIdeFMyAKJGFlrrTgbF4EY8oNJ8n1EKcD5V0G92v+wxG?=
 =?us-ascii?Q?Pqva6DzdmSjO+Orf3P6pL+RQzmpNI0ZIwWXsmKEO4A3p+SdEUzaoYeSKeNyS?=
 =?us-ascii?Q?/dTJ1P/apYifb3OtaQm30RbcR0Jkm5M3VvDWE8vQUv8MUt4Q2NUnguXzBNg4?=
 =?us-ascii?Q?5Oj3g95lnfu4Fk0HPmqxXT2Xw5nxP7v9Cag61wUahDVj/VWKoDhbRS8OWSuj?=
 =?us-ascii?Q?9SzuEy/rLTfeXWkbtvL2BRVNLTsVQzRKu2mdOFpA5g5MUIyATl38/Ea+qQO4?=
 =?us-ascii?Q?Kbn+DQKm9HmhhjE330+fJr1hMnjF02RZzFlN+QZ4eFOp0wNt4zNQBpATIb1H?=
 =?us-ascii?Q?8fNa/os4Empox4/Pqp+GajfPgxoW1b3Fp8r21En8AW/mIXDs6Jg24hCbn8tV?=
 =?us-ascii?Q?7J0rVfX7jtsf+Ex+fRiKXO5Ed05RiPCzwlzDmfjMGhJP5Q/dRF0WvGZitI7/?=
 =?us-ascii?Q?7iCu7ahnREMSfQppEaHx5LPjWCcRF+JC9pcwomEH52sndnQkiCJatVlYEllk?=
 =?us-ascii?Q?y3K3WEmya5wWr06deMW4XeJXl6E1iHUahwHAXdtMrtgMaNlakctMalX0NsA7?=
 =?us-ascii?Q?/1UxLFVEoeHrgnoH0JI84WZOg16V0KCX+2uvp/ETByf9OXGsNoIgfL8Dr1L8?=
 =?us-ascii?Q?wi4oOGUlWh0d49OiBNklYceqebByT3SpMZm2IJTp32I+Sc83B+HTssK+6BhV?=
 =?us-ascii?Q?a9HT+pl+FeOUX5PJe5PgZ4XX8lj7qLOB7Tk4k9VLrMujv8IemnMxQmTF+FnH?=
 =?us-ascii?Q?xQFj6EM0AUjhl4I3w0HGNFE1FFAsXzuQiQSSfcGo2DY/f2+/PqlmyqnER1oC?=
 =?us-ascii?Q?W5GjU9EfhU2jieawdAAnsgYy+KX0pdKAmgjcmdPV2OPz03cDqHO4PmQqnkdf?=
 =?us-ascii?Q?vy+bVyLbepUBA4+6PEP8/sSK9SgjkebpmeeI7hDSH/68b/V0BpvI9eNIg8Pz?=
 =?us-ascii?Q?sbXv0blQYJ8Ox3OcQuW2dKrrXyiXCrMzJTAK3Y7NOKG8Zdg9dSM9fklSNvjp?=
 =?us-ascii?Q?6MM7KNvj2l3tJccZq8JqJg/oUAvEjmIA66TTh+nghADaN5SQUzyXWEEE2Sug?=
 =?us-ascii?Q?V0X/fzNf0cIPTZSnequoRz5fEuSmIA4StN/qLHSe?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e771ea3d-e295-4267-b233-08db2f3cf838
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Mar 2023 03:31:51.5495
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: FcXFpN0fZ5XReUMIRtUphDGpHmxAjO1Mu0hGrvLxT81xV2uRUoUNe5u6/1nc86q5AzhBtHUeE6LO+f2Q56oheA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB7184
X-Spam-Status: No, score=-0.0 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Peng Fan <peng.fan@nxp.com>

The dtschema requires 'grp' in the end, so update the name

Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 arch/arm64/boot/dts/freescale/imx8mm-emcon.dtsi | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/boot/dts/freescale/imx8mm-emcon.dtsi b/arch/arm64/boot/dts/freescale/imx8mm-emcon.dtsi
index 3d859a350bd5..4e9e58acd262 100644
--- a/arch/arm64/boot/dts/freescale/imx8mm-emcon.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx8mm-emcon.dtsi
@@ -124,7 +124,7 @@ MX8MM_IOMUXC_ECSPI1_MISO_ECSPI1_MISO		0x82
 		>;
 	};
 
-	pinctrl_ecspi1_cs: ecspi1-cs {
+	pinctrl_ecspi1_cs: ecspi1cs-grp {
 		fsl,pins = <
 			MX8MM_IOMUXC_ECSPI1_SS0_GPIO5_IO9		0x40000
 			MX8MM_IOMUXC_ECSPI2_SS0_GPIO5_IO13		0x40000
@@ -215,7 +215,7 @@ MX8MM_IOMUXC_SAI5_RXFS_GPIO3_IO19		0x41
 		>;
 	};
 
-	pinctrl_pmic: pmic-irq {
+	pinctrl_pmic: pmicirq-grp {
 		fsl,pins = <
 			MX8MM_IOMUXC_NAND_CE1_B_GPIO3_IO2		0x41
 		>;
-- 
2.37.1

