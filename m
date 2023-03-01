Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5506F6A6521
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Mar 2023 02:54:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229848AbjCAByz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Feb 2023 20:54:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42790 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229845AbjCAByn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Feb 2023 20:54:43 -0500
Received: from EUR01-VE1-obe.outbound.protection.outlook.com (mail-ve1eur01on2089.outbound.protection.outlook.com [40.107.14.89])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3124438026;
        Tue, 28 Feb 2023 17:54:07 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DH9M7MUJLqJDozDGkECdMK3CWLMSIJkXD6yvr6bGs2oXOKlgPsmb5x6xE9CTatZH7IgWrxdEnufg/quO6XIeFLYpR8W8sTfjHy5JRpgzwUOypN+SGKrcRyU1D5CdG1g/QwAHruNePZ3++WOV9v6cNJsRTA6ixqfyfb37cz7qidM+Ns1KJrl/oZJEYXyT5yGyAxDMV9YhFC3WxlTypbgmUFCL/zXhLJjzupAOkTS9p1GK4Sikzat3Tyq1cyIB2vrfwR8AyQHX68Enu5W/3BGiMG4/gB9y/uztBAqVjdth2hW5JeI04LxalxotP48VxnywUCSdacj3fLkLHeXCMttxpg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DDyHqJ9QzyYeozDUTCrTxsjgUPDPDdaz08+Nd7PYg2I=;
 b=USeJQyGLkO9APTUcuVcN+s2LbtNN79gusBAjA/QaSXQ9Wm9VpLPJjVmuM67kSRJsa/xq0KjQJ2vGCwuQsE/e99e3OwOpmNNFVzAnhtP9zFX/5SF+fsA0MD347XN0HHz0Xg/4+a5VL0tRw4odjS3lpPBnBJsNvMNCd8wfhHRyB5q9v4V7J2bbE1vCLOO7gVVPMvi9TljQO76ZTPkEnc4vaG8T9xp3jSqx7PY0APDW1fciiBDqtfGBbscDfbxr6I1YDmKxYHTy8gXlkrvxrTyvsdgenMwg1j4XwfKLFmqbB27Maj2Iz/SFmfUBBEV84dZh5OTL7UYSPohqxumDQAhzYw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DDyHqJ9QzyYeozDUTCrTxsjgUPDPDdaz08+Nd7PYg2I=;
 b=QkQodwjQGGwQaxpI9lsawh01EfqhbCo1v5lHsYETktegoUOmRgFNV8NpxwGXEomF3KFp7ywDx918TrTbh5CvY13cxADxCmhlU2qr7MQFeqOgprsEX5/AXhfFa4SUeupIgIEpZReTlGYvsFaAh3IfKYMfhWflp4a5XCyz0HjBtp0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by DBBPR04MB7546.eurprd04.prod.outlook.com (2603:10a6:10:1f7::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6134.30; Wed, 1 Mar
 2023 01:52:41 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::f55a:cf12:da08:6d2a]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::f55a:cf12:da08:6d2a%3]) with mapi id 15.20.6134.027; Wed, 1 Mar 2023
 01:52:41 +0000
From:   "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
To:     herbert@gondor.apana.org.au, davem@davemloft.net,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        horia.geanta@nxp.com, pankaj.gupta@nxp.com, gaurav.jain@nxp.com,
        shawnguo@kernel.org, s.hauer@pengutronix.de
Cc:     kernel@pengutronix.de, stefan@agner.ch,
        linux-crypto@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Peng Fan <peng.fan@nxp.com>
Subject: [PATCH 9/9] dt-bindings: crypto: fsl-sec4-snvs: add poweroff support
Date:   Wed,  1 Mar 2023 09:57:02 +0800
Message-Id: <20230301015702.3388458-10-peng.fan@oss.nxp.com>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20230301015702.3388458-1-peng.fan@oss.nxp.com>
References: <20230301015702.3388458-1-peng.fan@oss.nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI1PR02CA0022.apcprd02.prod.outlook.com
 (2603:1096:4:1f4::16) To DU0PR04MB9417.eurprd04.prod.outlook.com
 (2603:10a6:10:358::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU0PR04MB9417:EE_|DBBPR04MB7546:EE_
X-MS-Office365-Filtering-Correlation-Id: 1a278638-f018-41e5-52ad-08db19f7a466
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: LgXYr8Xx2NLJhENvoF7/UjiPbO8HQiB2G/QVYyP5739OqbIR9covV7XQRR1NXgpAGZb8ETYa1iGhRK1dRxMEBq/taMStMtwX69kbKGCfKsdc22EW2o3CxQNYiwhFG+gsFn6GqfZWg5Leg4xzum3rWoX+fhi9I8GvI1Q9kQTBeBTHWBaeq8WJ/Um9f4+0UMD/vEYwUtQ6OkSO70K0804Tq5gZ0Ed2xODF/0Om6VwFLJPye04sIzkZj7hTRniPH8vd3lZehJcmCJ8TomhcpP4THvUy5gotLqQVSu1fs/JrG5LLmoSLsbEYONUkH2Y//q6IGekUhq1ToiPyML7ARE12qG2Vn1xxcOO1JbmXV5+Q8eNR68k11myOZz6v+6LlbY+wbmZsGtnv+tTkacCs1rhZQbXbT19Hs+9393bJdgMH4bNeW2KmY/OiK9pyMud3F3c1R+2dru1pc5oGYGmxNPqvnRjvqaRX4SNjxsBZ5Bp+z465rYj8/aKa+LLT9K7GWrsaIGV1/96VixI5iLpG65kWYNJ9vdvfGdDDHDGhjIlXS+ItdL9eYfTegDhZMhOVFJw8Fo/M5B5kc6GcY1sTx7GYeZD1fJe+b5oo1d/52PU7PR0pEh+HrhTkIvGAiNglWJgPZrapx73HwQxbwJcOq+/RtbRLr6zGbiSaKhuOv/rw7KsYAT2eA3Zbo9zK71k62j0w0cIHle6J6+r0b7KB8atNUg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(376002)(136003)(396003)(346002)(39860400002)(366004)(451199018)(316002)(6666004)(2906002)(6486002)(6506007)(478600001)(1076003)(2616005)(52116002)(26005)(186003)(6512007)(86362001)(8936002)(7416002)(41300700001)(66556008)(5660300002)(4744005)(66946007)(66476007)(8676002)(38100700002)(4326008)(38350700002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?IRgVEYOOoeWkTopWvBVhzP2PZI/pzFpKLFLdBDlQD5BwpEBeagbREdu1jxvt?=
 =?us-ascii?Q?QNgHiiW9lXvVtK/z6N5zKvtmBrwR45CN8GIcXiwspSPnO7dEGuP/fmcCeuqt?=
 =?us-ascii?Q?oOxl5WVcCf1h7/ih8V82errfHU8eH/V76Aoyk5l5lU+p6Vx0wfO/3WOHLLN9?=
 =?us-ascii?Q?D4ADwjKHSbPiCm4TzdHyh9FoqUHYMg2KtE9UrtHILZaWS7qna0K32AXvQdax?=
 =?us-ascii?Q?fGjO6NNXd1SsH+ax4QgytCBJnEd2+qjbRAd6wqE6ZsODsDjFSPBQwb99E5y6?=
 =?us-ascii?Q?gMk3Qh0CGZ2HVNbcaqjxOfYTCY9ciexi3uQ4I8z9gtqAEkAdN5YvYupguCmt?=
 =?us-ascii?Q?4ULv1pwjR2kz+mvR6tojMDiS0XtmkyZT9GkGtZM3OkSDe6v2a1jO4w/O1tt2?=
 =?us-ascii?Q?fVtYUwHdzCTbTWry1PSbrqls5bAn50629cQqtYraZfwPHFdZeBzI3KcWQhz+?=
 =?us-ascii?Q?lpXmtUtuzPSR6zPuJqqrpvhb3Cr6u8x2CFjqueHnVIb7osqjpC+ku3WxQNhf?=
 =?us-ascii?Q?inZ9k0e2LzOMLzfOvrXvQypSE3owPCVj97towIy9YKicsMdpgurezadVknJT?=
 =?us-ascii?Q?HqSvjxe+TGZ4O7PUfYGQQcLomVjjgvE8lZLGwwsrLx6ftU4Uu+5YQUayeRw7?=
 =?us-ascii?Q?4qeBpNCi/pmY6vWEH6fGMmYesCI1039gm3G48CzV3dKRi2SR39ViLvjvDKAy?=
 =?us-ascii?Q?myY2wbgTcZOP/XZWt6CKMqrIJ+JyLpm1s7ZSgAHGHHVPLiwWWTAkBATiDA/j?=
 =?us-ascii?Q?ooGdCwiLq93iP4GaqXsyrS7kkqYbx6bJrlUxxkLggNbcvgjHr1reXd4f8ucI?=
 =?us-ascii?Q?zj32iZImkt6m7VBn8QADXXRQVlzMw8rFlJisylUsvneJoex/36IoQ7j+0odV?=
 =?us-ascii?Q?YseQEkbgtGdnvpGFVQuCXYKHVoLBenhP4BidB/tWRB0NYd6K6rYa+6v54889?=
 =?us-ascii?Q?baL+9UcN/d5RR0p/dSsLb1/P8jHxLw91hd5QkKu/9GxDGLyIt+BMLqS2Ot6F?=
 =?us-ascii?Q?shVTqhAWNPaoU+7yKYEh9PMVcN/ifiwFvrutmAVp/DzFDmVuLVRLT/obYtBc?=
 =?us-ascii?Q?ciGbNhMcbmhicsYx1dhdMoWIqsGAYOycXJALtS9c6m7d4x5ktslo1254Djjg?=
 =?us-ascii?Q?GuM3RBzaGmnF6rzSXOsJNTj2ycSTrSzg1mev4jleiVZFwWhbRcHMpxLS3SHt?=
 =?us-ascii?Q?E8LRxWGsOTnRHXGu25xddjXDKGcJFP59UQ3vf4Mkg4KPY8tbZ9VOYknPKx3X?=
 =?us-ascii?Q?Ml7EECbe1aL9jV7vXJ90wux/+0UBLKF4nIas/Sqoxi/OkQ04GgfAZP0CN1dJ?=
 =?us-ascii?Q?CAASZ/Yf0QGC+LbTZsgEz4NseHxSKeBEwdGQx972r+f3P7UCEd3OLB3tySiR?=
 =?us-ascii?Q?mzeXNoCXFThWiBMSFV2ia/sI+RO94LVuTFYG4t2NoCaMc3aXpNubqXJB35s7?=
 =?us-ascii?Q?BNjMvSvMraVVNNZR4p03Q4UzAO6K6WZ4p5E+SycmtyP8nV5jcZBxl9hdKyyO?=
 =?us-ascii?Q?MyqmXO586qwke3Zo6t+dh9WwfLPpofmuVJUDPIviIzszR4iH1BdMv+AuCe5y?=
 =?us-ascii?Q?Acp5WhLFiw5I92sHvenqmW9QtrJIW7FtIkVc5HWb?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1a278638-f018-41e5-52ad-08db19f7a466
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Mar 2023 01:52:41.2123
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 50JU2R26/BE9zLy+uE7zb7zg+yzpwJToGgnIOkPdARJ+6Mu7YrAOrH6hAtXSHWgi8l7g9Z+wrVhQSe6SpbpqoQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBBPR04MB7546
X-Spam-Status: No, score=-0.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,RCVD_IN_VALIDITY_RPBL,
        SPF_HELO_PASS,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Peng Fan <peng.fan@nxp.com>

Add snvs poweroff support for fsl-sec4-snvs

Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 Documentation/devicetree/bindings/crypto/fsl-sec4-snvs.yaml | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/Documentation/devicetree/bindings/crypto/fsl-sec4-snvs.yaml b/Documentation/devicetree/bindings/crypto/fsl-sec4-snvs.yaml
index 688057ec5c97..f08a7ddece96 100644
--- a/Documentation/devicetree/bindings/crypto/fsl-sec4-snvs.yaml
+++ b/Documentation/devicetree/bindings/crypto/fsl-sec4-snvs.yaml
@@ -124,6 +124,10 @@ properties:
       - compatible
       - interrupts
 
+  snvs-poweroff:
+    description: The snvs-poweroff is designed to enable POWEROFF function.
+    $ref: /schemas/power/reset/syscon-poweroff.yaml#
+
   snvs-lpgpr:
     type: object
 
-- 
2.37.1

