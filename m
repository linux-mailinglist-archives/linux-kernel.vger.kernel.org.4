Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 113AC6CB669
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Mar 2023 07:55:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229786AbjC1Fzd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Mar 2023 01:55:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43048 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229496AbjC1Fzb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Mar 2023 01:55:31 -0400
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2057.outbound.protection.outlook.com [40.107.20.57])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C522B1BFE;
        Mon, 27 Mar 2023 22:55:29 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=M1qAuvK6vGAIt8HUy3RrjtN4Wgd/kxi/16dw7dT8W91p2Y/5wmCsMCGQGU7J6kchGhRddC3xFWJbyFTCChPvtj7sSsf8cY9n94hfIAhiLLXrape+UvqOO8JGsr1QZnvWv8GSM0DsmVSx9GTDmBa+CynynK2oZ/nEGJXWvzWgjxJnMudklG/cukzQiVPqfMCnxccKTejpZgYcca/P2wZuOUiasOV+OXTLyeeYMtthVEy486rLB57bVoPEUd74QrYL/xHdPEv6cWmRc7+q1T49PAxJ9ZqL4SOczwmI4wesOTdn3yNwUm6Y7BH2RYyWfkN5E1APrWWKvdQ3q9cFbCdS7A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CIAY/4ygkU57Fz9RMxkj7b/XUkuiCfY6HZ2eXMBHOS0=;
 b=ldsYFb96HhMdn84tKgY9Xcoqxi5O/T1HFhfzDbW/JI9njCbwpbNODSluZXORY5ubKLJD8dKuQY4v6NRoyBaljrjTSgDb5a9PmaPy5LRk4LtcOOibkWyrK1C3+dIcVq+eScqH3zCcs25tSM1FYpE2RKQKvRNE7d/LlPhCbtaun7sP4BrUhCPhaazrhpnSN/2sH0FBD5qhsqDwFLfqw0T25nDCVwGX6DgC0UEsgn/28MTNGCTFRYDx064ujtbTHginLN6HFJBovJ0hX4THdgZAYC6ZUGMeppd+akJOItfd7YpiZY+KnSh36pA9uf/iBmR0RS3B7Ow6CRdCDjqIlfnTIA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CIAY/4ygkU57Fz9RMxkj7b/XUkuiCfY6HZ2eXMBHOS0=;
 b=SBxw7Hm2dfjEVkdQaaemBbhzvxzNrAuJYPYlHbQcWWOJd7f7PFvGeHl6AUe2iAfF/OMu+9G7tqpo8Eb4Vboq+8Te/BTVfrt0NPzFecxBu7WGAjLWH4s31vKHhSfabWLd10y+t2dVbk9fnDxT9kUPnWmv9Yb+FI+TIgpp2WYANJg=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by AM0PR04MB6788.eurprd04.prod.outlook.com (2603:10a6:208:18e::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6222.33; Tue, 28 Mar
 2023 05:55:26 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::778e:19d0:cba0:5cc0]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::778e:19d0:cba0:5cc0%4]) with mapi id 15.20.6222.028; Tue, 28 Mar 2023
 05:55:26 +0000
From:   "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
To:     jagan@amarulasolutions.com, lgirdwood@gmail.com,
        broonie@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, troy.kisky@boundarydevices.com
Cc:     linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        Peng Fan <peng.fan@nxp.com>
Subject: [PATCH] dt-bindings: regulator: pf8x00: Remove restrictions for regulator-name
Date:   Tue, 28 Mar 2023 14:00:32 +0800
Message-Id: <20230328060032.1983381-1-peng.fan@oss.nxp.com>
X-Mailer: git-send-email 2.37.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI1PR02CA0035.apcprd02.prod.outlook.com
 (2603:1096:4:1f6::8) To DU0PR04MB9417.eurprd04.prod.outlook.com
 (2603:10a6:10:358::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU0PR04MB9417:EE_|AM0PR04MB6788:EE_
X-MS-Office365-Filtering-Correlation-Id: 1cc7840f-4016-46f9-7f39-08db2f510715
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-LD-Processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: gbThq7sEx+kKDsU/CcEG8OdQaEpa76SigPuJxzKI2xQbkDd0Xf4xAySbJDV8LVEvt9Kh+dBzXEvd/Z7dXeET4iGid1C9JEE+PS7vadGTvDZ/AgZWyEQ/qRuWPhwzg1rJ95kWTYnI9CjEdDvXjVFpYVFfxRA0TsSg9WrGjmBBbu8an9lpQsiFFd0bvyfN+tw6mCXPEM72mu/zExjAMGi/jWiaulSHANkJt2GgIeXRLnAwjLAjx1fpuzFcCCoj990hWv9RG3pxqH2obfZJ5cY6g/97aEB6fH42jrDR67jZcuSAcl5ZUknXZ8KrqkJbqpe4vkZD7+wP+MzTgC6ZQK3RkL7J8CXA9ZEBBgYix3LhF7fTbpjbOymJgD87BVOHLeicBuddi9LeihTm1zo1Du/tm+iZQYDqpr5o595wQBDku2+UAJroDqHcuGOgXrwqlDwBfSaw7jBwNMLW55hXFOA2ao2Ct9jHKxCJmmziFYBpnuaUaSv7CX7VDH6gSzMyT3D8GVtDBczdoGefzc2w58zb2qtYM9uVZG2Ed9/egYBn2/IluT7MtWdjOgLPD6au0H3XqqfKtsrXUjNVZ9PAtsz0QzXDhrFVSvGyMOi43pKeTHO14HxWMffr5RTWfLfuDF0M
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(376002)(136003)(366004)(39860400002)(396003)(346002)(451199021)(2616005)(186003)(83380400001)(6506007)(6512007)(1076003)(52116002)(26005)(6486002)(86362001)(478600001)(316002)(66946007)(66556008)(66476007)(8676002)(41300700001)(5660300002)(8936002)(4326008)(2906002)(38350700002)(6666004)(38100700002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?DR4pgEjBzuWtC5lejMrmgTy7cWSqWoGMct6zYRXAkMDwbKOv98w5Ulxhaj+B?=
 =?us-ascii?Q?edJpSBQ1Mmn6rMDd+5zXZXJOq+krLwjarkNboW12q7ZwkoWMiRtGFZ9OrMQs?=
 =?us-ascii?Q?S8hDWyoYurx/ffvjg3JTqIaZJLCNjNZ0juM8fnBPVlKf/gc5fyf/G19sl06h?=
 =?us-ascii?Q?WJ7pc8alHZxCyCqZ1KlGDgBGSdGruNkMS2L0DTvC/lYP7eyFG7WNrn+C5iUO?=
 =?us-ascii?Q?FXm7uqIGbs9nBdxMR8vZjUykKv4gpRtDhm+g2h+8mSuO26R0n5b1l2GjGMlY?=
 =?us-ascii?Q?0fHjmT6wPEeaGyk23JgiPAnpQn1wFz8CpPGNONTs7RYAy4P5ApAaNW6N/5+3?=
 =?us-ascii?Q?aqATvtrrqezhaHLpAKQFg0D1cJ9qwzyCXG5XvbczfuEYO5kSeaEvVBnJNoTb?=
 =?us-ascii?Q?vcFEWT2m94KZPIh56ZmCIhmdtHMPAxzIHaLJyCd+92mNhCsCgWjTFVp2f4mF?=
 =?us-ascii?Q?de572GfcZsOGU//7QjSGp1v2UtkfuP3zrpfOUC924cjK/D7R68VmfISTy2L7?=
 =?us-ascii?Q?YpENRk/Woro+BrGDIs+RfpTWVkmeOvDrzQTo3j8nPtpabog9qiYHZi/ccx8L?=
 =?us-ascii?Q?1SVd19lKMhDJFiE3Qi0jEOfeNtwnVefrkl2yh5FEPMpDKKSNd6lH3i+7nG+8?=
 =?us-ascii?Q?2OPyHv5rEgmYwtTvB+RuyCTqsWlJKC3sPH1u2IeG7La7PeCLMp9AEDZHc7RF?=
 =?us-ascii?Q?XK8KEuAqq4qBqCkYqUvcAJe+/Ed2mlNPTstAbKUM7n6ZcoP5deQFM9Chgg9k?=
 =?us-ascii?Q?UaCo1Th3c95oDS1RGIY+SqqqRn1speu/1xODwl61fb6L8nczmOU24OiQxmQo?=
 =?us-ascii?Q?1vnpr7oyCkAqR4UEA/fOxxDw/ePksmLgSV3HGiV7n9ReKJ4dFIiz1Pb+z+Uv?=
 =?us-ascii?Q?MoPU9PGGFtIgOeXGyAdh2X8Oj5zJI8p/DhCn6Hjqi1G4u8Ae8osJVu6hxX66?=
 =?us-ascii?Q?tM7kTla/8HdXgs1GvwTJHaLsJsUDw2HZW1WF7WiOMusvC39IwOX8NF5AYLY+?=
 =?us-ascii?Q?NnRaYuuzig7rIgbf0s2fIlrzhrsFLMw9fRj15QXF9LJi7Rtz6zIiw2ab0mEm?=
 =?us-ascii?Q?goQfenSEBK3RWonjtVCpti3pWIxeGAWTd3/xDmpIUOb3l34R3cfzc1Fd9+rH?=
 =?us-ascii?Q?of9foZtEYeYZ/ksL4yOvslAS6KcxV3EbxDoGD7bO7DStzLDQetDJKS+Vu3wA?=
 =?us-ascii?Q?rdsn6fnl0MOVBzgsBQ0LjmX3RZzeHcm8zz7ZfI3I49hXEwzdLLg4r5cfFOAp?=
 =?us-ascii?Q?bw3QB0eklCqcsNn2srlwA6u76GSDYVxqSLvk16igdwaiTwzb+37PLQv88dfZ?=
 =?us-ascii?Q?HpE+0NQ82p6WD2QgKEGutyeqwv7QwJrHcf1ICMkiyXrF98w7EKUFxO4zlsvk?=
 =?us-ascii?Q?RXPs6nfTS/JnoJF1kiou0xhgH7OA5d3pJ/Ip4S/7IlyzZzhAuitZkUNyPC0A?=
 =?us-ascii?Q?qRW9+1W3VUVPfuPuppU5ihf9fte85ftrupWxLKFJLEbYrFTHX6rtTwz+gwpI?=
 =?us-ascii?Q?/B0isFKCxXEuGQPMAVMxbvKCxXdR/gaQODvPFgFUkgkjjsgUCquISZVUkVUs?=
 =?us-ascii?Q?ZJq29PKCaHZBJ1U7ZydSnszQ+HOa32ERfSZPYw1X?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1cc7840f-4016-46f9-7f39-08db2f510715
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Mar 2023 05:55:26.4567
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: UzWu52wPGf+rhKnwIB9saH5AnJVcjE15xjNumsOvLD4OSL0by0zfQd8AOLfseUHUvGdtOcp3H2pK0LE+f5i6gQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB6788
X-Spam-Status: No, score=-0.0 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Peng Fan <peng.fan@nxp.com>

Following commit b0de7fa706506
("regulator: pca9450: Remove restrictions for regulator-name") to remove
the constraints on the regulator-name to allow using arbitrary and
descriptive names for the regulators.

Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 .../regulator/nxp,pf8x00-regulator.yaml         | 17 -----------------
 1 file changed, 17 deletions(-)

diff --git a/Documentation/devicetree/bindings/regulator/nxp,pf8x00-regulator.yaml b/Documentation/devicetree/bindings/regulator/nxp,pf8x00-regulator.yaml
index e094c40a7072..b56fd9c3d5d7 100644
--- a/Documentation/devicetree/bindings/regulator/nxp,pf8x00-regulator.yaml
+++ b/Documentation/devicetree/bindings/regulator/nxp,pf8x00-regulator.yaml
@@ -38,12 +38,6 @@ properties:
         description:
           Properties for single LDO regulator.
 
-        properties:
-          regulator-name:
-            pattern: "^ldo[1-4]$"
-            description:
-              should be "ldo1", ..., "ldo4"
-
         unevaluatedProperties: false
 
       "^buck[1-7]$":
@@ -53,11 +47,6 @@ properties:
           Properties for single BUCK regulator.
 
         properties:
-          regulator-name:
-            pattern: "^buck[1-7]$"
-            description:
-              should be "buck1", ..., "buck7"
-
           nxp,ilim-ma:
             $ref: "/schemas/types.yaml#/definitions/uint32"
             minimum: 2100
@@ -90,12 +79,6 @@ properties:
         description:
           Properties for single VSNVS regulator.
 
-        properties:
-          regulator-name:
-            pattern: "^vsnvs$"
-            description:
-              should be "vsnvs"
-
         unevaluatedProperties: false
 
     additionalProperties: false
-- 
2.37.1

