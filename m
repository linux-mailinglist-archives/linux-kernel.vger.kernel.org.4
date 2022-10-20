Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 548E7605BB2
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Oct 2022 11:59:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230111AbiJTJ7m (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Oct 2022 05:59:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41520 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230222AbiJTJ73 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Oct 2022 05:59:29 -0400
Received: from EUR04-VI1-obe.outbound.protection.outlook.com (mail-eopbgr80081.outbound.protection.outlook.com [40.107.8.81])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C03621D1037;
        Thu, 20 Oct 2022 02:59:07 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Qkdqlhw9QmigYkLN9bP0jt+o0lEY9DWG8ITallcrNYt07DVfckRZmjlJ/veqewDIc3AGulW6jUFJeOUGYN5klpx7z2st0NfnGU5WeYelUHO2piB1ZumBs4hvhVisVlYSHa2yZy4Z0Z7poBufCOp4cu53ljet1PSg7TV9tONmPbFr3Xzr3Sz2qj+g0WSxZOAsK63EITHVG23osGhU9hphpzXtqFQogjCByNYtjqMu+4oXFHvQzCcHLq/WRgZaTIsVu1eMKpiSYpfkeUsKFpv1X5olpZAxyudWOkXLudMJlmXOE9T2sUJKDWecrNXnMH2Ith+LFhRwpk6f8cIWF2Wqig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7seoCcDHr1GrJVtmnKhkNbzTU04i+Pt/e27f19TPcAQ=;
 b=VEBOSdoNcICDWC5/QICsQ9+EjFlOgg8+CYmfRnmI7MLvCMOrOxatXRlHNKqoolXlg6DzOpVFrOcgiVRV1QzLW0/Xk8yKu2N96xUZ9ZcAHOwaPEkfboL9cWUAO5p3zESp6CE7RLX4R+m5faH2E7JSXmiaA1oyi9DYvmhkA9SpyKEIuhWHZj2oiidZDFUFEl3JvKeNs3jKfg5bFsvaaWEmTfmTSdUbnwXJtvbfsUSfcKqcI6z28D440u2TIPy/RQmKVLKjfK6V0uHZcHaea/7Zt4ByQzBu0YG5A4he3ZkALA/9lUy7vQsddaziL2KlG6jxVPXk4A1+l92b8UoOebHZqA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7seoCcDHr1GrJVtmnKhkNbzTU04i+Pt/e27f19TPcAQ=;
 b=N1ZDN1d0Pk1LRVsnWyZOcsEleZ3INe6LkrA/jqKUYG4iU/jplPQCL08KPGBvBk5F/6jmE138D+Q2ERxY7TuzTpCaFLKQ92jS0i1VzZa8kahBfJVQHn4PJn7nUcUD0wLz39K0Z215TacVyBdVMCRkUmay/rCiRucEwWRunm975Jg=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by AS8PR04MB8039.eurprd04.prod.outlook.com (2603:10a6:20b:2a2::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5723.29; Thu, 20 Oct
 2022 09:58:45 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::a5ff:3d28:4bbc:e1ed]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::a5ff:3d28:4bbc:e1ed%6]) with mapi id 15.20.5723.032; Thu, 20 Oct 2022
 09:58:45 +0000
From:   "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
To:     robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        shawnguo@kernel.org, s.hauer@pengutronix.de
Cc:     kernel@pengutronix.de, festevam@gmail.com, linux-imx@nxp.com,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, Peng Fan <peng.fan@nxp.com>
Subject: [PATCH 08/15] arm64: dts: imx8mn-evk: update vdd_soc dvs voltage
Date:   Thu, 20 Oct 2022 17:59:27 +0800
Message-Id: <20221020095934.1659449-9-peng.fan@oss.nxp.com>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20221020095934.1659449-1-peng.fan@oss.nxp.com>
References: <20221020095934.1659449-1-peng.fan@oss.nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR04CA0008.apcprd04.prod.outlook.com
 (2603:1096:4:197::20) To DU0PR04MB9417.eurprd04.prod.outlook.com
 (2603:10a6:10:358::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU0PR04MB9417:EE_|AS8PR04MB8039:EE_
X-MS-Office365-Filtering-Correlation-Id: 65f082a9-95ac-421b-dfed-08dab281ad07
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: O1MdvzB419E9wTKDIq8/WAxhjf9r7iFUD2whqMoJGG3I3bE0AvnSBP9y/vXOMY0YYV/Zm0eJ5wikKMpjbBPMWbky/pucanrbbRIdR2u5hse2f+bOMErl1HSvxo8Wd1Wnaq9rsx1/0URtIZHU919lCer99HVkhtVcL71CL6eKWiFQamiKzWnP+zDdHVIt4DQIQ9CJa5FUwxxqXmV0CPOE6/1LHaJmmKtzOQsJcIbM+Tl3BKr5+4B3CLvm/x7WztxZjToT06jJCb9/j/OUBvEopud4Cn1Ww6b8amO0OXBnJHLRTXA/XtXPTiJQ0FHIKZDAsCFyerCP2izrtYOVZ/0JbhrvWENjKB4ArZFodBwtozAUc6LGoQjyhqVuHPLAoCk3MDzxa25l2XvHKAKqfPybr7TV2CsHSAr2VHEAWVrARTvbyVYul1nf1nvs5DlHFb2zJ4SIymG5BuwlUYmCCK+LjTGVHAlBYdUoelzeL4djclo45m3fhT1RAqAs4ETwF73A9BzvYpNxRL5rXhRGi5bZFYH0uYGD5vmMOEQC5h6kep6d5Y79nATBGyVGr8oAyA2A0q48RfQfhhmDGVOjk/f7WLKVVLNMgnWj/o8YXIDYlxTVo6mupxbpRZ/rM6M3vaCN8XBcP4yNa4kdwgO+J1215f7CkzGC654M2J4K+b5iBJPUjO8gACfO3UAb3kHP6OxIYE1by85J1yqMrNZKHOie2CJZO44JLZCYDhZK913kJjzSvIBgykfC7dmmaJmSlpYorfbxnogEM/S7KYtZ1Wb1MvmdVNrjrmVr3pomqQZnABw=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(376002)(346002)(39860400002)(366004)(136003)(396003)(451199015)(6486002)(83380400001)(478600001)(86362001)(66946007)(66556008)(6666004)(26005)(41300700001)(6512007)(4326008)(8676002)(8936002)(66476007)(38100700002)(2616005)(2906002)(38350700002)(1076003)(186003)(5660300002)(6506007)(52116002)(316002)(32563001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?ar1c8wpSsS4I1V60zrF13MXTUHCpg2m2TgDdni6XfW6IDzKNK4S/yoX7ZxWb?=
 =?us-ascii?Q?xVwRGc4knbE4w5R7GL0ArrwCIByVUsZ1Ojv/AtjRHAt3cuCF7wsH8DfI164E?=
 =?us-ascii?Q?q3J5uoe5y3z0kVmSqOaZfpHHKoFAjSwPKn/7TvvAgJsdLzU0Aso4cuhjSVlw?=
 =?us-ascii?Q?tBZqyob+RvQfcg4xRuqdWNENRTJfQFkmxYnk33b4cjMEPfR3loXLZxkc/G1f?=
 =?us-ascii?Q?ISXJRfVBY/zUB2AWkPlEv1rcuruxMShK5QAD8rPrCT8ZrxLkbB4DpUd87ZLT?=
 =?us-ascii?Q?KAEK5DLpQSVBEGhH/rova1AUixDX3aD2vSaybc+kJveAKM2AClIQvoEdSEW+?=
 =?us-ascii?Q?4u5txaM7w1WocYWR4KQDM8mn4I1Hc+qBN9vIpl+4ou7XjtnjkCFr2rSAFgfR?=
 =?us-ascii?Q?hPNf9G67HLltOdS7vWjBHJWG/fMaF5ccL+7AYZ/85PmEXJQRWSDk0IdirP3u?=
 =?us-ascii?Q?MAfQUZs+8IjZBIQT7IHm3/CwJJdTYE1PD1gCQBSG7t4mF70fIxCuQO1DWWD9?=
 =?us-ascii?Q?NisSSMnAIiy+NGn7VOXulHHNTDih4Ur9e6zCsgaUf2PTNAdQ+ZL2CTo6H+Mo?=
 =?us-ascii?Q?Yg1dGRW19f/Kkr9HA+J6jv/a2oE72hB5wCtcnA06YJLrdicz0Jo8b5BTvPla?=
 =?us-ascii?Q?BSXeeLWW2tVP3MqPgCbbQNLPNX/AGQ4pUzPGPS9lnAQmnc620nrNQtm5Yg/u?=
 =?us-ascii?Q?XQmF5xEFtUjjU3IK9H7rEnV5e8WG6SQODEZc7kEz7rD7c5yUsNZJpnpjtO9/?=
 =?us-ascii?Q?g7lQEJW/kCMrsxkov1yn02lGglK8m1zPo1Jyhai3pccPyXyYVMjkWgc8YC0n?=
 =?us-ascii?Q?xDd5LUTLP4M0GtjmXshQdcGr+Ka584pFxU7+HpNoNUExW+FtIFBGSu/4m6ga?=
 =?us-ascii?Q?kdJ5K9rQqfV7iOfxq3DwDYbZ8bOsquKEMxKWff5hnPgf6BtrYjt4pnLY6zeC?=
 =?us-ascii?Q?2hgzNYc98CsMUE+maMhvqE46U6On10j/0RoLD25gg1cxiJVmqFUMJJTW7Ic/?=
 =?us-ascii?Q?0l9j1rcwt9q3sDbbjm7V1IO+5pWEbx5M35hCONh8FRryTct6n4CLgEPNF4PA?=
 =?us-ascii?Q?HpNGNQj+R/D1qLIh0K368vdviGkum3f5Rz7kIHeBhQ0dq//fK4YuDKylVFS1?=
 =?us-ascii?Q?2y/DQPQxiMkE2p8bgrLAMl2mkGf58DSBJVON0mUQVQVVXIVo3ErhDvyD8bRT?=
 =?us-ascii?Q?PTxDDatGR8UVVaoRp6hly4pt94GRk4zmpKauz6K7X7Xaq5ZxxXvIsJ/cU+PJ?=
 =?us-ascii?Q?t4UQrT/soN3At742C7JPwjyG4fpGK/KxlHHBH9BB3bN2LqXZ+y27g4bwDChQ?=
 =?us-ascii?Q?2HAB2b5WQZhLJGfVfIMrxUX/vmCbXuBqxh2Bsf+VK+IWWgXK16B4AATEVe2l?=
 =?us-ascii?Q?ZxlvNX4ho68nkSQWiVje7pH+nHmfeqKq7F89/xm3Sp5GDfD/HObAI3ZToHVY?=
 =?us-ascii?Q?YNsFy7DDEaFA76TDXBKZEZBMOhhHjOzbbsYlpB2EfiLwCc3hY+iZdCeuJzep?=
 =?us-ascii?Q?En3cHVcvRq6VxuY/WGG7p+jaFEnNPhgHcEjIjAvFPlT0WjUfojA5oeLWQ5Lf?=
 =?us-ascii?Q?RZhXhzw6Bl56iH+ItyA7xEPbQp0XxqXoiA4DRZly?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 65f082a9-95ac-421b-dfed-08dab281ad07
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Oct 2022 09:58:45.3765
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ENh6eEsi828T78+TFAFBsBltd4zhHCgbKpnD6+qrzCJELOK0A+uLYawgqJ8Lyc5vAkwVsEZxk0KDAUqWBN5klg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB8039
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Peng Fan <peng.fan@nxp.com>

Per schematic, BUCK1 is for VDD_SOC&DRAM&PU_0V9. The nxp,dvs-run-voltage
and nxp,dvs-standby-voltage need set for BUCK1, not BUCK2.
BUCK2 is for A53, which is handled by DVFS, so no need dvs property.

Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 arch/arm64/boot/dts/freescale/imx8mn-evk.dts | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/boot/dts/freescale/imx8mn-evk.dts b/arch/arm64/boot/dts/freescale/imx8mn-evk.dts
index 4eb467df5ba7..a5a7d74ec1d5 100644
--- a/arch/arm64/boot/dts/freescale/imx8mn-evk.dts
+++ b/arch/arm64/boot/dts/freescale/imx8mn-evk.dts
@@ -47,6 +47,8 @@ buck1: BUCK1{
 				regulator-boot-on;
 				regulator-always-on;
 				regulator-ramp-delay = <3125>;
+				nxp,dvs-run-voltage = <950000>;
+				nxp,dvs-standby-voltage = <750000>;
 			};
 
 			buck2: BUCK2 {
@@ -56,8 +58,6 @@ buck2: BUCK2 {
 				regulator-boot-on;
 				regulator-always-on;
 				regulator-ramp-delay = <3125>;
-				nxp,dvs-run-voltage = <950000>;
-				nxp,dvs-standby-voltage = <850000>;
 			};
 
 			buck4: BUCK4{
-- 
2.37.1

