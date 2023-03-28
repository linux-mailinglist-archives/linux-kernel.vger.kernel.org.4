Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 499F76CB4DD
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Mar 2023 05:31:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232241AbjC1Dbw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Mar 2023 23:31:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39812 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232580AbjC1Dbs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Mar 2023 23:31:48 -0400
Received: from EUR03-AM7-obe.outbound.protection.outlook.com (mail-am7eur03on2040.outbound.protection.outlook.com [40.107.105.40])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A919C2718;
        Mon, 27 Mar 2023 20:31:47 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oaGR2onHqH+LMAfINE7opRNLOFM4/f3WjtfngDfSnwySxFpCdgr/6EuJyMUb1FxZ8Vw5b/G7ws4va7mVwcOBo2L4irl8ldVfH7aIWwXyc071rvHaF2fyj3n46cvse9tW7M3TIhw4Grgill5oQVaWoJpB6GUOmRqPHebj5VF7HUTpH078/3wLB7SzzKVp/Pz7hWmEPK++66QWcfgliwGNqzF0AXDaYH0IdcziIOE77+b3eU3op1/N/spz2ZhdaHiKhJKNUFzCFfd0hAE9QZWtQ3vfXolJbi8+4hO8dSLh3yNTUPNQKiTGuPh/+SVNI/WK7LERRtHlaO7HDqojz7bcEQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GqhKkNsj02YjuHF+temtpumQYigq+6km/QL5tfsmaKk=;
 b=KIvVjAI+UTuY481aFkpgJt2hDxXOCqtQHYZH/98NVIjCf4TaOnPmkWPqzRSvivMkmQfiJqAiDqhWHdNUDbEejSU3F2qwG/Z7LzcCa1QRT/rirQExyE/E/SGeDUES6GbYhrEijyLQdPoWL6OUxJVFTM0QNDslgCiROPSB8bJMUDq4PxjzqVin2BsXZv1tJbqkxAJBYdUU+VDiafO4SwflSQQEG4ikSe3w9pCfoSmxdCUMnLrqen8arFlBNSS6apegYzno75viHXW2TNsyv0JuZ49lqGiYRx/ZGhKBl9PD5jJrm2SMDOSLxhifqw1w9M2Hwyi5NFBfln3xLvBWe4xChA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GqhKkNsj02YjuHF+temtpumQYigq+6km/QL5tfsmaKk=;
 b=He0o3B9PtY7mC/TYIF5D//sraECASQzdy5hlPcbJu5DtAr3Jei4bqi6c82HiVWvNEppbxhGtOr1FwN+oRBTl/hC3LmcK39Ul7C+bhJ6b25W3aNgf9WQn1j/ffhPyCbOxjKS5RoN6RtEQ8tF34Oeoh2tOsqoFB5TCF/pfoG43ZZQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by VI1PR04MB7184.eurprd04.prod.outlook.com (2603:10a6:800:125::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6222.30; Tue, 28 Mar
 2023 03:31:44 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::778e:19d0:cba0:5cc0]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::778e:19d0:cba0:5cc0%4]) with mapi id 15.20.6222.028; Tue, 28 Mar 2023
 03:31:44 +0000
From:   "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
To:     robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        shawnguo@kernel.org, s.hauer@pengutronix.de
Cc:     kernel@pengutronix.de, festevam@gmail.com, linux-imx@nxp.com,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, Peng Fan <peng.fan@nxp.com>
Subject: [PATCH V2 2/6] arm64: dts: imx8mm-ddr4-evk: update gpmi pinctrl to match dtschema
Date:   Tue, 28 Mar 2023 11:36:36 +0800
Message-Id: <20230328033640.1930104-3-peng.fan@oss.nxp.com>
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
X-MS-Office365-Filtering-Correlation-Id: 6ae46dc3-9c6c-4def-c603-08db2f3cf3e8
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: vtKe8y+iOj5kXGaMN/stRElcIRfiuo/IWrv7uW1T9VzT+cWzhKdrAqgNsZl8yBJnla2oV0LJ5sqn5UC6+bgc5u2b4HdfMyyQBg2j3tguUnA0S+n8rCvPFkdvMA3xeQYYviPY9VYlHiSpfMlUslSqDhnmxv6jZh8qCswMhGveMfUgxfuOsyfdTkBSNenV1S00aqprtrK2Hjt71y11hPgBGOJ5D3OzX080S+ICKQm12Asj8/wUE/RxUzldXs2ZTiofRJWwSEMvTxIQ0AgS6jaWUWT8srVP+PHIEfkNWpkeREYpbeTevsbjfX9TlJwdnLUFDfQOSJBeKhAOkyrs0IZjVsmZkyECTK89a/2equQfcYnp856ccCkNobwYiGWUN+PmZlYvGpjtN4SlKhrIExqxyMX6zO4ezps+TgTcKC3h/zNDMJ4UscyDD8eNyloJvDvMewN1BDvQWhhM9jTUYOL8u8uztr/JCtBsHVH5xPVaEnEhvCrC94YU/8aJBy5C6K02sK4zVktqIdUvyo5u1Lf5vCfrvgwq2ygs1dBl1mo+TD0R2xPr0R96L6b7+46OPfw8i/qGI4aGtkFvQM+/5962bK+R87z6BApx1g2g9qS5/+qvIHBWL6FLnlYcUrlFqj2bTkYNneygGpKxUOZJhLZ0eA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(366004)(396003)(136003)(346002)(376002)(39860400002)(451199021)(86362001)(6506007)(1076003)(26005)(186003)(2616005)(83380400001)(4744005)(6512007)(8936002)(5660300002)(6666004)(6486002)(41300700001)(52116002)(4326008)(66946007)(38350700002)(15650500001)(2906002)(38100700002)(316002)(66556008)(8676002)(66476007)(478600001)(32563001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?rx3n50Lr7jYwSFEoxSVMST8lXeDj7vjN6eVw6i2ctjV34W9EjMYzpWh7YcsD?=
 =?us-ascii?Q?u4Pgh4TO0fQ2OjIVQRL/KmR7H3ZL5jbae2tN4DmYILIKOXd1lXy3nb9Ye4QY?=
 =?us-ascii?Q?SL+Z5RmJ8lGhE9TXW0DVxqyTN7EgruhTzuD2xtruQxK20+IBCrg8w3d0blic?=
 =?us-ascii?Q?O2rrMkYRKEbEDgYNsj84d6owiIgQSy2tusfdqeRLcZazD6Nmr4urW3co++ml?=
 =?us-ascii?Q?MSOumKbUFl0JnnGBJ9fAl5PgIB5P/qybdoSvFeLOiuRg5pDYf9r31Cp8cVLS?=
 =?us-ascii?Q?34p0sQb6xpcyfpYkgGnMf93Qs1T7io/NXhhU1WmG19UtKsbwVHoUPXsq0UA1?=
 =?us-ascii?Q?p5hdZ9k7tZVmWmC2ojI8Z9iz62H8q63Wi9UwM6VunkcPmHMY4BbUIcTir4LG?=
 =?us-ascii?Q?rlRS/nbZh9LRzA8TwItU2LVr9dP8ZOGCChzO9RBoM2QRAao5hKaqrzqNQX6E?=
 =?us-ascii?Q?wb9gPaGcfhvGzgCBzu5lIgLUQTEQx6sQMQ1loLDg+qPWKAmJxP92g1cBeHkh?=
 =?us-ascii?Q?8MMGphB+L1IwnlfmI8DCBN42OdGDNvqh3nb1Q+9q6eg6Pmk5LuIcjElBpJn+?=
 =?us-ascii?Q?dsdvlrevUixOfh8etmry1ZVjQA5+MA1UAl8xk5U2vQFRk1hOXeHKD/wxIqR8?=
 =?us-ascii?Q?y5X8karai2bX9b98OTaVqo9EbG1/wyk8zcY2NEo8td4MpfqytykiXqjZM40Z?=
 =?us-ascii?Q?ZHImBuet6FQTUj9FVd9xFfJW3PEfCwJT59sv6qagiof+zms2x7Z9qM5Hlt6E?=
 =?us-ascii?Q?0hl6jkKyjbVK78LaV9uZwMTXSIw+4VddsPFB9bWtoM4ripuxkW9cLEYKnm0b?=
 =?us-ascii?Q?WrDoK8RPsLTrYa8oYlN7xIsE+EZ8YCjRQVVynyz5kAHdigcQofSIfT1++t/i?=
 =?us-ascii?Q?1k8i6mzZeZ7JJrOTSAy8m0ely3gBhJpUAQA2JXP+i2Ocqn7ep/lLxeA2WG2T?=
 =?us-ascii?Q?0YCqklEpL9+pkuJu6Dob3/lDqKRBfuXTh01Pq422rVYlXyYnrDbYIuVZVsjY?=
 =?us-ascii?Q?Gin1+Sq+FQSuOJwSegtJF9/ltUJqKYjb5kQKASnR7LyOPoviqry0G5od3lBU?=
 =?us-ascii?Q?eEXDjYz8f4YFD5QlxBPW78Ts4ThBNH46x+hFjUR1peB323AEez+Tl0TZmDu6?=
 =?us-ascii?Q?xb/RvFmuiO6b8e4FPi5duM1lK4LreWQnEr49bJB1aSvYlo8iRLHrOrA9JjSO?=
 =?us-ascii?Q?dxcxXfHc1mjcIfD9UkmgzVAQD9B+7hFJ2cuujr/jWr//gXIpX3k1fcElaXUd?=
 =?us-ascii?Q?gP3WdtV4Ix+EZKIybDpipYdGeA3hz2t/ef39EfvyE0NdX4P2qxJSE7vqJvfu?=
 =?us-ascii?Q?ORXuHsIdWZ4z2KZt75jSF7qnJqjI/OiEfYrJoSz/syQItZBbfBzHNKPGoT5L?=
 =?us-ascii?Q?Y4+ll1ve97nswL3v5xl82ukif3D3igWPM9KWISPZzcdR+lw8EZMH9TOHiZ7L?=
 =?us-ascii?Q?fYhQZLP7eCWVZniuWfWzCJOixOA0qyKvST9bZvqofsE2v2lmU3zmrPLP/9qh?=
 =?us-ascii?Q?x41RKvUzmOE9fUbdwS4cxYMrhnSfNfnHcmlmuxmg5u9EITAt0SRaNdotG9XO?=
 =?us-ascii?Q?YAOthRdKWpDsvFTAsbE+eCTgro51nxsKW7u5ORwB?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6ae46dc3-9c6c-4def-c603-08db2f3cf3e8
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Mar 2023 03:31:44.3019
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rIRzkaIcJF61G52El1sFb5IaD0Kq9bpuYIMCQzA+6us1zJMFJIuYFdLTu02gE1iESVqjGY3Qp17kF6loHJoQ8w==
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

The dtschema requires 'grp' in the end, so update the name.

Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 arch/arm64/boot/dts/freescale/imx8mm-ddr4-evk.dts | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/freescale/imx8mm-ddr4-evk.dts b/arch/arm64/boot/dts/freescale/imx8mm-ddr4-evk.dts
index 6c079c0a3a48..010e836ebe5c 100644
--- a/arch/arm64/boot/dts/freescale/imx8mm-ddr4-evk.dts
+++ b/arch/arm64/boot/dts/freescale/imx8mm-ddr4-evk.dts
@@ -28,7 +28,7 @@ &gpmi {
 };
 
 &iomuxc {
-	pinctrl_gpmi_nand: gpmi-nand {
+	pinctrl_gpmi_nand: gpminandgrp {
 		fsl,pins = <
 			MX8MM_IOMUXC_NAND_ALE_RAWNAND_ALE		0x00000096
 			MX8MM_IOMUXC_NAND_CE0_B_RAWNAND_CE0_B		0x00000096
-- 
2.37.1

