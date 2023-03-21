Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2E9706C2D0C
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Mar 2023 09:50:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231147AbjCUIuP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Mar 2023 04:50:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56828 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230134AbjCUIsv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Mar 2023 04:48:51 -0400
Received: from EUR04-HE1-obe.outbound.protection.outlook.com (mail-he1eur04on2047.outbound.protection.outlook.com [40.107.7.47])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E1AA6EBE;
        Tue, 21 Mar 2023 01:48:08 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jbcPWaJMnJxnV4433z08MogWLDQUwC2hHmWw9qdntRAK+yEPzDujh7n5Me+9ObpRm6AH/g2DCfyNr07zcAHVGuYT1yEKgyenpHfM/1J/tmYzvMHQdgIkAJAG/j0ZyODR4/2aq9kJ9QiEhgJ1lRNRuG/EUnsyt4tv09BgtY85juTyYNPlqZH8W9nE9iwsaOd+Pup7egCTBuvKUu3HW8tUEZnGbEKNYfRsB709eMFzi2bpRJpMun9r54ZThjBia85FVR+7r8KsSwbw2W7oZq3FKSh3T/SlSPGdfLD96kCZK7/2hz8iFsGdEdE5Sz8kV3YyC8s1jM8tXyfKnSl6GyQMGg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5oIMJoaa1fZ7Qe9o//yuFaWYDpQrA/J7Hg5mCW8lIEE=;
 b=ESYtbPWD6a4uBS7G7fW+y27AhacEJfG/hT3rg+J3s9gOzkQDM7LD+XJKgVr4fpMScFALW0vqkIAieGSR5+Vy4TdhFwU4s/u4T3e2S02BSktjjvrBusSLQx6/AQbYwcp1VMm9KzH2MGonHKZzJ9rEqmfw7idM46KxqKdoM8lrr2BDIyOaW8r0AUeIeekOdXGd+uqj+3zffk20Pey+vDGH8LZI5HAbnBswSegkEEi6e/KPc6kfbGOmyPrQNkpTatwAl2xgrg9WezLNhrNfF29NgdSAoTDg3B8mrS+uhggLsulvFBVRP8tOu+cyvOj/mee44p/LaBQZueRiZ3tRXf1e7A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5oIMJoaa1fZ7Qe9o//yuFaWYDpQrA/J7Hg5mCW8lIEE=;
 b=DAAB1lhKUgDr8nPKK5D7ikScRbCjRWDVUDfW9AKBUPzZR+BWfQzWrgE2BU365vKp/oxj7EPNzkmueIOUASCqYwyjrTbsXxM1y8/t0YR8/q6Wp6rDNJGzaLNeM9mpDRjbV7+rKXqyY4LqGBk8m43+1klFjjzp1lxFWkQj2DBgLkI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by AS1PR04MB9456.eurprd04.prod.outlook.com (2603:10a6:20b:4d7::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.37; Tue, 21 Mar
 2023 08:48:03 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::f55a:cf12:da08:6d2a]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::f55a:cf12:da08:6d2a%7]) with mapi id 15.20.6178.037; Tue, 21 Mar 2023
 08:48:02 +0000
From:   "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
To:     gregkh@linuxfoundation.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, shawnguo@kernel.org,
        s.hauer@pengutronix.de, xu.yang_2@nxp.com
Cc:     kernel@pengutronix.de, festevam@gmail.com, linux-imx@nxp.com,
        linux-usb@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        jun.li@nxp.com, Peng Fan <peng.fan@nxp.com>
Subject: [PATCH V6 10/10] ARM64: dts: imx7ulp: update usb compatible
Date:   Tue, 21 Mar 2023 16:52:13 +0800
Message-Id: <20230321085213.1624216-11-peng.fan@oss.nxp.com>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20230321085213.1624216-1-peng.fan@oss.nxp.com>
References: <20230321085213.1624216-1-peng.fan@oss.nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2P153CA0040.APCP153.PROD.OUTLOOK.COM (2603:1096:4:c6::9)
 To DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU0PR04MB9417:EE_|AS1PR04MB9456:EE_
X-MS-Office365-Filtering-Correlation-Id: ac182e68-e18a-45c1-9638-08db29e8f917
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: mepJ/CWRQcn31owTc0vd21bl3LiUgNLfdxWiFjTRleekAvM8ZBFq++VVEoNhLWNJrsHeFrouJbWIxzgXVqVAx1ej0ioP2VrlDLqGpyXu0kYTM00//vR2M33aQkQN9MBSaTr/NC/LwzbDb5Y53/1KCJqI6P4xLtPkfqyjkadE3aZeKNRp7qdXC1ReHAdEcf1rMoc2LtRdyC5G1LCC5GX3kKIdN+DgQ4jKhhQXyngIT58n0ffRVl1VaJF4WtfxE/frqSukHCCsqZ/5puLrj3JX+xhMoxq9fRl0TVLcfo1BobUcEK5oaNL3+DeEyxP/CDf338GKFGpZechJHoaoatoeBZAlvD8K1obcPfSowimi7Z031UQpKnouqjbq0Vi6pUoifyN9y2E5IcEOn+0MjEqShDWHI8xWkzM5t9p3cF6CWg3EIx2a8XVtPJ7ZwGtxKpYpXUNp0xEJ6BXEaw4+in2lvm7FNSY6a/sRYRuLbuHepg2ldTmPqJvgH4RIwiKiycim0Aw/nLMtkTR+ETcThA2gEqp4kc9KcRzF1IhrS9HIozOTbcNZwsyFmZdySYkzDuufJaM6QF8u64rgHAqB0o5GRHowBfppdIG9jFKfcUJ0m0vTaFNhK3BT7IDpvLx7G8Oa9J7zVxSOC0jOQ3DcuB3WTAaz0ASiU4D4F9tzkSFef3F/IbNbJn5DJZcwivwa1I81VbSvBKFehREFOJ7jmOyfcw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(366004)(346002)(136003)(39860400002)(396003)(376002)(451199018)(2616005)(6666004)(6486002)(186003)(6512007)(6506007)(26005)(1076003)(52116002)(38350700002)(38100700002)(478600001)(2906002)(86362001)(83380400001)(15650500001)(8676002)(316002)(4744005)(8936002)(4326008)(7416002)(5660300002)(41300700001)(66476007)(66946007)(66556008);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?zTYwB5DyRSkkhPbEsSvf+5lFh2Pe++oMv4+4kmJU4obxHk5/KRitVfeAm8mj?=
 =?us-ascii?Q?/Bo+WmgXFFVT3WkRv3kjP1Q8DI+6Yjgc/ReT55eL9rvnJXeii39PgYqPm+nJ?=
 =?us-ascii?Q?YGGqzFdvXDs9G0iLx9HrI8BXP9wF9VhYYZ36TG4CIJbQMSdmasXgE7tX4Qkg?=
 =?us-ascii?Q?EGB3klsOEkPCo4NTupI04cHEghTikzrLDcHtDjb+vpT2CZkY7a1uaKQiOpQu?=
 =?us-ascii?Q?Majf530C9U1GioN3bWrdoSKHTWRpap4KaKdZvGPsHC0rV4IAUOlgiSUK9LXX?=
 =?us-ascii?Q?gHGGPgZKelbX9jcaSHhr/Vig+9rAQm1RBwGwuP56O8o5xs2aNqAz7dHsDJDB?=
 =?us-ascii?Q?S7Y/I3w6pbtQwgqrDZ50rkiuuhzBL6Gpexiq8MyQZGDm9RbEvyWNuIzWqYQ+?=
 =?us-ascii?Q?hXGu36JHndRhdSwE5ZcWekjxbugnvvrlsomTexBEc361+QDDLiKQCgFwR47f?=
 =?us-ascii?Q?1QuU0K2c1iPZRBTt42ikC4Ts3MGxx8R8xLkvq0aQsT1Lz0rIPdwVzn7k0L0f?=
 =?us-ascii?Q?iwjo9SxWbZC1NMwCpb+ibR7mjE1pi1eZlxhvd4fdQkGwNMEKxQQh38BtU08T?=
 =?us-ascii?Q?an14jB3LIA00Wc8XRYR/S3BPE40tVifW2CRRPU9a69LdjPbjxtYtv4XVJOQC?=
 =?us-ascii?Q?BVdiEAI6aqYwITfiFWdSl4/x1f1ohlQuZ41xrMyu2VBv8PX8ZBjRFvZc4LGl?=
 =?us-ascii?Q?M0URBC89xeZO1yZz3UMl+IJao4/GEsfq52kjmg6PLgqzKAKlAZvJ2MrvVNzi?=
 =?us-ascii?Q?9TpcX31LNu0j51iaQOM2/WS/+a5bUr4x5vL4OAUXfXcG2mNr+2PAxIVUemz0?=
 =?us-ascii?Q?oaIYIgmzOXin2znUd6socq1lZSxXW5m9PMHBqVKDC04GaDJJz7UnrPF5wOms?=
 =?us-ascii?Q?DbCRfopn4tYovsde/isbrR8ytNzbVSLAfPNJFtKC4Gdfg//HtgIlI/h7M4+s?=
 =?us-ascii?Q?LLGiiGfY+jlPSlosJuF5xtD/oACo22Jd4tzYC+1TUU3qiuqwpJDCo9ZsyVUu?=
 =?us-ascii?Q?iwh/mX0O9NHpWdp5OPGh4y92l4gaWvlN2PEPlpJBBTs3y70SERmDpyhqa7mK?=
 =?us-ascii?Q?+B97ByrPCT7M/zfSCVGUD2NbPoBnjbwcorpbtzQYgHxF0vui/VFycHRTTCx1?=
 =?us-ascii?Q?8/6FjzFJzA/RuvZGXSNdvln23UMTRhG/PZMGJAGG1611Q2K4BrCKN2ZjqUEn?=
 =?us-ascii?Q?AXzHPaHyJKpKxR3F08lhISkkXIMyjit/rjV6CfWH+lDkgUVVeXzguExKP4tG?=
 =?us-ascii?Q?KchTyNKzLOQicYab5dxcVZ4YOr2G5ndiyO92IxgARpv0lB3xypPGAm3kicVI?=
 =?us-ascii?Q?NVNmPiYa+BH5Dmpob+ka7aMvBgtzHa5Ijtek5opdmhQ4mafW1RgdX3OuwAjy?=
 =?us-ascii?Q?7/E+LtgpONy9AD0hsbQttKdrB7WYM7EPAJUYeA0LcGS2/Rvkgim4zJwnhxRB?=
 =?us-ascii?Q?A+dU6IUl5s+SkZpdxEmmbs9VJu7NR2/6ffH6l/H6Pp5X7zKhbTjW+enfWYBD?=
 =?us-ascii?Q?jP8UrqGttrCUScM/NWRyDvQYCUu96sAYRF2kX0wPZ25mijCP1u75/0gVK4XH?=
 =?us-ascii?Q?qRne+L5yeq46vIRtUZiIXAhD7t18p6USi6sTZ1fI?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ac182e68-e18a-45c1-9638-08db29e8f917
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Mar 2023 08:47:59.6449
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: GP5ik2rtLIb8/TuctNuB8FJHVP+Gtm4HasPQs2xl2MS793+OnNO4jl7nUjGxo3JVVfD+efXJVi372+gqm79T9g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS1PR04MB9456
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Peng Fan <peng.fan@nxp.com>

Per binding doc, update the compatible

Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 arch/arm/boot/dts/imx7ulp.dtsi | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/arch/arm/boot/dts/imx7ulp.dtsi b/arch/arm/boot/dts/imx7ulp.dtsi
index 7f7d2d5122fb..f91bf719d4e2 100644
--- a/arch/arm/boot/dts/imx7ulp.dtsi
+++ b/arch/arm/boot/dts/imx7ulp.dtsi
@@ -189,7 +189,7 @@ tpm5: tpm@40260000 {
 		};
 
 		usbotg1: usb@40330000 {
-			compatible = "fsl,imx7ulp-usb", "fsl,imx6ul-usb";
+			compatible = "fsl,imx7ulp-usb", "fsl,imx6ul-usb", "fsl,imx27-usb";
 			reg = <0x40330000 0x200>;
 			interrupts = <GIC_SPI 40 IRQ_TYPE_LEVEL_HIGH>;
 			clocks = <&pcc2 IMX7ULP_CLK_USB0>;
@@ -202,7 +202,8 @@ usbotg1: usb@40330000 {
 		};
 
 		usbmisc1: usbmisc@40330200 {
-			compatible = "fsl,imx7ulp-usbmisc", "fsl,imx7d-usbmisc";
+			compatible = "fsl,imx7ulp-usbmisc", "fsl,imx7d-usbmisc",
+				     "fsl,imx6q-usbmisc";
 			#index-cells = <1>;
 			reg = <0x40330200 0x200>;
 		};
-- 
2.37.1

