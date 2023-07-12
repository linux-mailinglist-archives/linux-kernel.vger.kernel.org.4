Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E8EDE7507D7
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jul 2023 14:13:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230361AbjGLMNX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Jul 2023 08:13:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34402 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232972AbjGLMNO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jul 2023 08:13:14 -0400
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2049.outbound.protection.outlook.com [40.107.21.49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C137CE4D;
        Wed, 12 Jul 2023 05:13:12 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HeXRv6ubTxG3a3eCGKvaGR9mq0lGXqNAPZxZziaHL8WujdoSfa3nFf/N1BOTIpxFUp6xYz8EZYd8ez4aNk32a7iyVcaAQZVUGKjPVRYv053vfVQD7PJE6r5A+rzYVyaIYFsnc1W0+W/KGdpUFT2fsHfTsUd6f1fmNU6dpsauF94OtbaL+bLpWERewh6xO9Uy2CTKgcXjSKlDsebyfAirxnNzmU2QNcfeEl+fqoa9b/jeZkYSiB1f5hSwhfnnzAeFKDsLKSNWRgA9kRxUJsifFS5yLVfaIcZnotoJV3gyxoEeFElqcm0C3euqazH5Xd6ttlmwjRar7oKFYGtujzk+7A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=26m0nChAGWxwBQN2odkiomWL/4WB40nokEFcyOE9WlU=;
 b=nEmTTdHw3ebecQTO3TfU2xGiMOGe38nbJ3OPYQ3oi1IcVbaLnBwOeWpNE1TD33lN84jog7CShagu9cDDsn9qR2jtoQBY3L5kjujXGfBVW6aE5k4+6k7GK4zrJvk94TiQfIhckFGsZ4zQ+k25a0t+t9GfKOYiij20TY5UpF3ewB4mqRYd8LEKoxKteZ5/wHQAmBpX3cytFgY8ghEFR5WlDAUUc7S6HbRTI+TUEnGmiTFoSPA0gcFOHiap/pBaZtuNE916LSOJ5E1T631Q0tVifq1Q9Lp84UshD4J0OPQ9MGMEb4pz2J71qIzOMAtqxwprHHbGBq+/l6jEVRzqySMEYA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=26m0nChAGWxwBQN2odkiomWL/4WB40nokEFcyOE9WlU=;
 b=Z1K8B9Bo1lXfoeN8yEgsyPk08qiTAYApJpUq6152wqGkTrx8F+7N0bm1JkYyBZKDGkq+cZrYe9WD4YvzOiYQ2+nFEsr47G5aq0yw4qdvcK0ZyhoLBfjrsYVwI3G4to7sKSfY/KgedfpC3sLMLmXyO8In4an6gjgbqk8IlIKAUR8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB8638.eurprd04.prod.outlook.com (2603:10a6:102:21d::14)
 by GVXPR04MB9877.eurprd04.prod.outlook.com (2603:10a6:150:113::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6565.30; Wed, 12 Jul
 2023 12:13:10 +0000
Received: from PAXPR04MB8638.eurprd04.prod.outlook.com
 ([fe80::7650:27db:4ae:b7ec]) by PAXPR04MB8638.eurprd04.prod.outlook.com
 ([fe80::7650:27db:4ae:b7ec%3]) with mapi id 15.20.6544.024; Wed, 12 Jul 2023
 12:13:09 +0000
From:   Pankaj Gupta <pankaj.gupta@nxp.com>
To:     shawnguo@kernel.org, s.hauer@pengutronix.de, kernel@pengutronix.de,
        clin@suse.com, conor+dt@kernel.org, pierre.gondois@arm.com,
        ping.bai@nxp.com, xiaoning.wang@nxp.com, wei.fang@nxp.com,
        peng.fan@nxp.com, haibo.chen@nxp.com, festevam@gmail.com,
        linux-imx@nxp.com, davem@davemloft.net, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, gaurav.jain@nxp.com,
        alexander.stein@ew.tq-group.com, sahil.malhotra@nxp.com,
        aisheng.dong@nxp.com, V.Sethi@nxp.com
Cc:     Pankaj Gupta <pankaj.gupta@nxp.com>
Subject: [PATCH v4 2/7] arm64: dts: imx8ulp-evk: added nxp secure enclave firmware
Date:   Wed, 12 Jul 2023 17:42:14 +0530
Message-Id: <20230712121219.2654234-3-pankaj.gupta@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230712121219.2654234-1-pankaj.gupta@nxp.com>
References: <20230712121219.2654234-1-pankaj.gupta@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SGXP274CA0024.SGPP274.PROD.OUTLOOK.COM (2603:1096:4:b8::36)
 To PAXPR04MB8638.eurprd04.prod.outlook.com (2603:10a6:102:21d::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB8638:EE_|GVXPR04MB9877:EE_
X-MS-Office365-Filtering-Correlation-Id: a111a243-7ea4-45b3-43f1-08db82d15b46
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: EE8NtgB6gs4YlCPbzs66OUzagSi6u8nsxlcs+Wjs++080YFPXHRfpYaDePv9HnL4FWfDOE5ttmhqm7UgTjDNRT/Y0FwgX4yyPMQftsD/+5cr+JSIImbXkh3MuKiBnDXtC4by+PvrdVr1lPg9JO6kmrExADfSdG3OG1o6jFXfHnLNatA9qvs5mIOQyTzjdjRvsWqwk3Pp0VACToduozAsgaXxKAR/m3E5l1ucuYwVIrDmg0Cx+QezO7eJez8TrtMlBkDZzQNHJL/pjlFsDSn7GJBs1eWB0HJfKAngzV/otRpx3n44eBsv7+7oXzDop7j7xS86bonQZTXezkXKj1b6R0BSsDkv6qqaVSCUqA/Zs2h2OhAeCmqF+/IaLCn7utqHvwRlqxpgxkuXT5gYTiAOSgUUFeU1hgv14j97E4PcSpRhmKN6pVtThesLkNcTSS+nmtXIqyG41BP6RBBR/FVHwrFB/Sx9UdpCobjraC45IGq7YZ8tht+Toyw1BFOsmlWInY2T3xL+cRg5iXDfL3jMBF1ZL5Ppo+FoEOhEJ7wthfCsh8UtaOZnkr2V56gCou2Fa3/TfOzryAjFbmwb8UhbCjRHPp22oS7Mxs/Enveoj9XRu5de1cXty/b2gaFeMfRPOGwMv9q5VEf0S7lW5THdKUDPWgD/Edke//bh44tp+8U=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8638.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(396003)(346002)(39860400002)(366004)(136003)(376002)(451199021)(478600001)(52116002)(6666004)(6486002)(6506007)(1076003)(26005)(6512007)(186003)(66946007)(2906002)(316002)(44832011)(41300700001)(66556008)(4326008)(66476007)(7416002)(6636002)(8676002)(38350700002)(8936002)(921005)(5660300002)(38100700002)(86362001)(36756003)(83380400001)(2616005)(32563001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?7qClJ/nAnb//d7zoi53eUljOFOHzCITsaTXpbH0n9M3PrOsdx8m70t79eLSK?=
 =?us-ascii?Q?1Qdp+UTjQ97ZY9ID8k9X6uIBPRzKdmNEulaHSqy4qk9qJxpvPm6ps51NKE27?=
 =?us-ascii?Q?KSY/eMDCV2Y5EVDHYaqdHt5QjEiYH6+d6wIMI4XsdNXHpKjiJ/uLhhjlueRX?=
 =?us-ascii?Q?l40EeUE7T+oMA+rpjMpr7uf/7NB8oMcF2jQ9w1e+V09yQ+4eEGbnRGVzn1DZ?=
 =?us-ascii?Q?/D4kPOzcgWWCZ1UK/B0Rd5Z6pF4zLU2EcKary/VpcGBrFBFTRtQDlgLUnCL0?=
 =?us-ascii?Q?0A8zdTdytVnWbWr7M12tXNbOKDGc5wGpvvtldvaVAO4Lwh8YIEzUn2NrSLet?=
 =?us-ascii?Q?PAhA60bUnzxaeFOfZY5+RrPH0MqDpXXsZV+qPxjr08nMv6UcYtuCujv2RNTQ?=
 =?us-ascii?Q?DzGmywtouIpzcLGeG2+ipxnHGbeiZIeDmsOaQims0Uzt6Ry2ru2FMIjqFneV?=
 =?us-ascii?Q?luHFsaKJ/MrToAr5re/YAA+H3HJpbeXewVU4zKLgA+Yp/Fsuydasbbrr/KXv?=
 =?us-ascii?Q?yMoynzxde6l2ECWyzCjfMdfAD5WQkEFrxYrNKLNYh4vZugZan4Y3ae8misXV?=
 =?us-ascii?Q?Z/ZW+SgH6a9zJRgmNccFdT7Dmg6bfV6eo1LQ2I1A4+CldahN8JfnNCnPSEoN?=
 =?us-ascii?Q?bkSVGgPNKQqLx0DWslV7ppD4xWQwegzbZcft/w0Ly8xilcmQh+IogjlIoBBB?=
 =?us-ascii?Q?PQVEQ8+Z2HOFjHTx+1zRd71op+eRMpFknvtePIGqCZOyVVr+mKsAAhv/Wyt1?=
 =?us-ascii?Q?eSiicuOFryqkfbyCVhbboHMDvqGXHT+Hw10ACS5NdkvSqE0SK3p6kjul1zu9?=
 =?us-ascii?Q?uew/CijUU3vUQE3ufSmjNgRhIAUDLNqAUFNcqkD8EDlbviFmk+oIRQ8vqxwZ?=
 =?us-ascii?Q?v5qDTxudLRj61Q8LqHX+zPoFSUmkmWGAbU9xAKR1emQx1psh3hfd/4UpFqIa?=
 =?us-ascii?Q?FQtTGW+PMPxJXDVHPIxdLJ6LqViX74wnkkRoqgkQcjImsdjeIRlO4BhgCTRM?=
 =?us-ascii?Q?d6V0Tw/EmD6XDvqZDbVjg0KMEjWxfwRBS854VeCbaKsAId8CqqJciCVAqGcV?=
 =?us-ascii?Q?T/pOB334kD+UdsZMU/WZ8q7LHzUCfPrjkYPIw4kiQ6zd3y5orsMUU9ppZ0vw?=
 =?us-ascii?Q?v/NSGwrSLQs1zpkQ+YgcJH7gbqgnKZxZSeLo82AnVJYV6fEDgpFdX7xxV/4n?=
 =?us-ascii?Q?+2+19k7PjHzEMWtRNmHwwgVNFbZPpGaRE84DusgWX+E+ai9bfnhpayDiX6Rr?=
 =?us-ascii?Q?htUEDHXDbimVeoziCjjCck0dk5EDsKjz11QllcP4xXN/oGLxItjbGHpFBGS2?=
 =?us-ascii?Q?hRRJltXgj1SWAiRgmvnsHxxA4Bi/tuDXjNwzFxJGVYGkOaM/E/vW9oxOZXLg?=
 =?us-ascii?Q?BSi3fBM8bYo7ll3+Hi4VfTiuQB+Mp8Rm5+lS9SV1Qd1OCMoMHKwAiiSO79k6?=
 =?us-ascii?Q?K3TpUE/cjdtET0myRIta8aVO5uVuS4A8ks/f3xtl8xafFI75W+sSK63D8Vpu?=
 =?us-ascii?Q?EXrC9jCPV/+BFi4v3ay42Czt4HBCV/xpIgMHbQahY1TwViVmu1jXMc5jWqjj?=
 =?us-ascii?Q?YLVMkArXFisn+6pKNvFX7GBA2S8OoI9iCMXzFpQI?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a111a243-7ea4-45b3-43f1-08db82d15b46
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8638.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jul 2023 12:13:09.8640
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: eCAECe/RC966nQWxtGKNmwamiZ1sxDHre6BCfleSogtKqS2v2oDwRteS8ZsK/Rlo3nlZrGX6d02ylEyjf+H1ZA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVXPR04MB9877
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Added support for NXP secure enclave called EdgeLock Enclave
firmware (se-fw) for imx8ulp-evk.

Signed-off-by: Pankaj Gupta <pankaj.gupta@nxp.com>
---
 arch/arm64/boot/dts/freescale/imx8ulp.dtsi | 12 +++++++++++-
 1 file changed, 11 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/freescale/imx8ulp.dtsi b/arch/arm64/boot/dts/freescale/imx8ulp.dtsi
index 3ddc0f3125b3..10ed31974a6f 100644
--- a/arch/arm64/boot/dts/freescale/imx8ulp.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx8ulp.dtsi
@@ -114,7 +114,7 @@ sosc: clock-sosc {
 		#clock-cells = <0>;
 	};
 
-	sram@2201f000 {
+	sram0: sram@2201f000 {
 		compatible = "mmio-sram";
 		reg = <0x0 0x2201f000 0x0 0x1000>;
 
@@ -161,6 +161,16 @@ s4muap: mailbox@27020000 {
 			#mbox-cells = <2>;
 		};
 
+		ele_fw: se-fw {
+			compatible = "fsl,imx-ele";
+			mboxes = <&s4muap 0 0 &s4muap 1 0>;
+			mbox-names = "tx", "rx";
+			fsl,mu-did = <7>;
+			fsl,mu-id = <2>;
+			sram-pool = <&sram0>;
+			status = "okay";
+		};
+
 		per_bridge3: bus@29000000 {
 			compatible = "simple-bus";
 			reg = <0x29000000 0x800000>;
-- 
2.34.1

