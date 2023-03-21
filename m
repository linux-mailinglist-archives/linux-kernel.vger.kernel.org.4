Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 66BA96C2D0B
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Mar 2023 09:50:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230501AbjCUIuL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Mar 2023 04:50:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55632 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229939AbjCUIsa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Mar 2023 04:48:30 -0400
Received: from EUR03-AM7-obe.outbound.protection.outlook.com (mail-am7eur03on2057.outbound.protection.outlook.com [40.107.105.57])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA0F17DBF;
        Tue, 21 Mar 2023 01:47:54 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SnRrQ1VOb7kJoUGCNkNII538T9pSHlQO2kI8K9LPQF36YFihc/+szRc/xqPyKQmruABtFHqITs5icrdiA/8d3wQ+Gzd7g2QKe0DVCDSlI69Mkxpv0mKr/sgMFf0LCYPuOj7IrBWDCQ0ghUuf5acssxLdzEC+rjxG4nVbGwfRYIthEvjj4+3SJcWR3HW/fJV0pCFboD3DAtDkktpdnNi0nKTlTckXQtliPwzjX689iIAD7+faI8vnniW9eIhBs9usdeepfVtyCj7UrP3wg70JXWcOwjzeaRZ8pDun4/SUAB2YDkBf7AaUpufwxuE+OU5P9HG26P0FI5C1uWkhIGqMDQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jJNo2IgufYk97JEDBsaiPrlY61EOTpQspqwn9wxkVZI=;
 b=Fjx2I3SVMdyodhbQxDXEFvFhMBAGA4BMGYrxA5iXMiaNJ88y6DaMLlxjdZQzu5yS2abkZ3AhQ9hGGJ7gdaSBUq1SelxR+ew3xVfPl3HwcYQEceHpedtwLfGRh3JiMjGlYVjY51eOk6rU/5Klm/lVm0qaizNSa80GosbJ7vDoCIWiIC6gusQ39Z1EIB/m9NxoUHcYq7uEpP3MYBaV5jlzGijRdBUjVfhSC/+kjgLbAD4U4tQvIkTUsji05BfMPcCwEeyegHSGj0VlPpoch/n7HgUQeHr+DqGungqjiTdgjxchXTn90/n/3DkBuEq5b/dQkC19DtXypVjKTFa+A5vdsA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jJNo2IgufYk97JEDBsaiPrlY61EOTpQspqwn9wxkVZI=;
 b=k1FkZFQoKvHMfVRsn4HLLVZLfB5OYdofyhix13R2v4td5Ibc2U5Hy2IFNOYjKA0cDSXeFBCWOhIxAUk1r5/hSC+R0cLSSdAKZURaxeIt/3yms33a9HKJR2r802BxNWhpua4M9lgl3qmtvlov7oHn7SAHoHxCcVtigvVHR/FzVMs=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by VI1PR04MB6944.eurprd04.prod.outlook.com (2603:10a6:803:133::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.37; Tue, 21 Mar
 2023 08:47:50 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::f55a:cf12:da08:6d2a]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::f55a:cf12:da08:6d2a%7]) with mapi id 15.20.6178.037; Tue, 21 Mar 2023
 08:47:49 +0000
From:   "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
To:     gregkh@linuxfoundation.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, shawnguo@kernel.org,
        s.hauer@pengutronix.de, xu.yang_2@nxp.com
Cc:     kernel@pengutronix.de, festevam@gmail.com, linux-imx@nxp.com,
        linux-usb@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        jun.li@nxp.com, Peng Fan <peng.fan@nxp.com>
Subject: [PATCH V6 08/10] arm64: dts: imx8dxl: drop #stream-id-cells for usb node
Date:   Tue, 21 Mar 2023 16:52:11 +0800
Message-Id: <20230321085213.1624216-9-peng.fan@oss.nxp.com>
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
X-MS-TrafficTypeDiagnostic: DU0PR04MB9417:EE_|VI1PR04MB6944:EE_
X-MS-Office365-Filtering-Correlation-Id: bbf57e0a-587f-4d51-0b8d-08db29e8f30f
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: oq+R6gDcNScxYUfXOWfhmWz+azVCowzaQ1jnGjwW+LRhHLBMQ4KwGpeAQROUtZcGZ3Y+Ch7Mz8iRlBDdlezARW9vBUv5YZeibO+hqWxf+Pz4oamCZUFu9n4hJhmPJpkYm/jMzCrDW9MX30Xk3fpM6SMaKcDlfHXAQWxBnSut96WjlOGRPAEawrktEmsdlnuLI5dk6i+lHuAWOW5+wW0XL5IX6VOYzgoGPdD9hK5ah+aUfGA7TiVv8xnsFTI5Mn/w35Wh5Y7URN8Agik9xn2uy4VmskPpengFOQY7Ierfo/b6c8Ebk0ncbZkgogtw87s90Xbxnb7zeZk4UE8z7ZoPDG5OFg0Br6ugd/73nNNuAZOLgITpklU22EGlMZz7H/o59MB+0a5acMzANg6HGNzS7+pMWTYgJnm23HQYBE3xlyqH/q3pTWtgznMlxAvI8AnfuFaTsIiO/7rtKAhoaGVuwN15qblIxJG+lxxOzdxYAOg12eP1unmDeTvTUhDPcpkPtChMXvXmTWQ894CYnfzuCaicb1iFmL6jJ73jqvz5KZxlwSBCUi7BeJXtNqJvZiixR+cSkQtrWhDGCkFy7tRXix6+GQVO8jrlaRtgTNo0TgLzWDnKxh6orpPuuae8Ho+1A9Er3gA2vIG3cCfnSUBbRObo4RtAtifsBSCKgvBhJlAeB1Gnwsoe3S3G56gEJ5L7084WPYQL6UcqYEQa0AhtA0FRu3D87rCtGBBXyv8424k=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(366004)(346002)(39860400002)(136003)(396003)(376002)(451199018)(2616005)(186003)(6666004)(6486002)(6512007)(6506007)(26005)(1076003)(52116002)(38100700002)(316002)(38350700002)(478600001)(2906002)(86362001)(83380400001)(4744005)(7416002)(4326008)(8936002)(66556008)(5660300002)(41300700001)(8676002)(66946007)(66476007)(32563001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?6+k7yu/kuwFjgepf2inNwXRqSWu+uMwAcQ+CxVfWHv7hUME8Nb6XpWvx+qhK?=
 =?us-ascii?Q?y5bu7mQo+G5jnz57VqdMZzpZu3UW/TuDz0pqcJyJcgKOcDuhlMLibmDonem9?=
 =?us-ascii?Q?X1h3pCRroU6oXsUY8uKIintsGMx17vEUKnIYv07Z6doBVsc8uAKmpnIWTgb3?=
 =?us-ascii?Q?N95xxEMwAzfAozCYY2K+s9Yd2epHIdC1HUtZFvBgCPgPp08+IHz5I2kpgfsF?=
 =?us-ascii?Q?st8kNCh/BewyS/wE9I1kQDb0JvvcP3ERlVpexTNUMYG4u2wdW2jfEl+Q3h3D?=
 =?us-ascii?Q?Mj6Go5VeXLUs3MmgYCS59N0R2XCvgub97AB2bsTsLiN7DJDGaf+9hMTEDnp5?=
 =?us-ascii?Q?xPCsZzlK1rCgXnwmvcrIu4ZHiLXGwlJ4eyz7Sd5KXY1eWpUurgKtWeo0pgjq?=
 =?us-ascii?Q?4udKvCtGCymtvxCwG8a42HNEBSsXVHDuaMprxO0pPGBspKLfymT1NborsTpP?=
 =?us-ascii?Q?MB3xV966z58qi68rwYt2f0reSLiwEUEwqKdQAcCdgMWREgWCoOnDAx906RaR?=
 =?us-ascii?Q?g4BzETejGJi7QEQ59r0qIIuR9PYJhV8wQMzRgVMaVzpIUJsDNbOncSVu/ZcH?=
 =?us-ascii?Q?Bquj0q/Q0OOW5vPDgr664nXvPQVt0389iL+mysg3Yk4Hm2PhuNiiF5LQikBh?=
 =?us-ascii?Q?y0NiCC5WyGBGbYIT0QS//5nQCkl1g4O56voGn6WawSfH3AFsR1Axk5dEGf51?=
 =?us-ascii?Q?DrLmPQuMZSqP9Q30hF98cfGfTVlDR8N1TIfILHnPYaeZcnQcijbrr0l7p7XC?=
 =?us-ascii?Q?vzKx5PIZegxohnP8QIhaP+5Va+p5bNLmkYeD+X5ON3+G42arsO8/0wIr+uAi?=
 =?us-ascii?Q?2rk5UUtm5enYtXOi7RCq4ixDwIT8XLI52CN4+Q8ldVlyGgw4zxyWQhle4ct0?=
 =?us-ascii?Q?yQJHo4/1OYZiCumfb+HAa54SZ0ZxOwRrNLN0y6Dh5tLuEynlpz6QGootMXbP?=
 =?us-ascii?Q?EVIXESFdWEK2cUB8C41avQyGUghPtY6yglPcJb1e7G5i+NU0ibHV5y/1iIKS?=
 =?us-ascii?Q?oQ9dpPzdnf4Ou5lmt1yW115Hi/eZ9YHlkfbe9rDyR7oOzUlQgPFOKVTpD3uz?=
 =?us-ascii?Q?3ZSAbRTab4RwhXlDhgHvGQ8cXFg2vkFpE9IudFbr1cIqajeEFMD+3hD+QEF2?=
 =?us-ascii?Q?MMMx0ImvnhQMPMawkDuItgX+h3y7/2ZmYiAM4+x4M0WcMePWstinVo6qR2v8?=
 =?us-ascii?Q?ZzoLBKPr6e5uZ7j0whxFprnm/oPGWalMJA0MDx0iwpHvP7IFtUSwcgQg0XH4?=
 =?us-ascii?Q?mTWf64ZVaY4Un6EKktFZG7NHpmPe0QLROqsnwQJzJ+jGN7vZzn+crdxF1otH?=
 =?us-ascii?Q?t8E4a4Qh4wOQNvRPBeX/WIYIzL59cxUfoWlUh+WcN0FvOsySbQbCKlBCzwP+?=
 =?us-ascii?Q?WRkbVMLRYo9P1DRoaCm06+YhX+FXTuiKs2OVR+enwMwyB+EoY/WV2JsNFMN3?=
 =?us-ascii?Q?H9V15bMXwg2hnCinzZJ3b+s29pohBlcR/cK/MlEkq0OdJbv6IR5cMYU3Ve00?=
 =?us-ascii?Q?GJpijufnopDbtCKcrDhFJWDwTng3bBotzvxPEs7loZz2areg9R6Bn2Hp5I7N?=
 =?us-ascii?Q?B1YtN1IbOQGoUp4D2FrblLt170cw9VaxP6Z3ZhOI?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bbf57e0a-587f-4d51-0b8d-08db29e8f30f
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Mar 2023 08:47:49.5853
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: iI8+tpHgwGjoTO+joXWqXDB/bOyWsqj1ZFs3s7enCMF041U07zjAcFhCUjI8rjxrCGZZ/QioIBKk2fypoNI5fw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB6944
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Peng Fan <peng.fan@nxp.com>

There is no SMMU in i.MX8DXL, drop #stream-id-cells which
is for SMMU-v2.

Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 arch/arm64/boot/dts/freescale/imx8dxl-ss-conn.dtsi | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/arm64/boot/dts/freescale/imx8dxl-ss-conn.dtsi b/arch/arm64/boot/dts/freescale/imx8dxl-ss-conn.dtsi
index 88913869ae9c..652493ae4bb5 100644
--- a/arch/arm64/boot/dts/freescale/imx8dxl-ss-conn.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx8dxl-ss-conn.dtsi
@@ -49,7 +49,6 @@ usbotg2: usb@5b0e0000 {
 		ahb-burst-config = <0x0>;
 		tx-burst-size-dword = <0x10>;
 		rx-burst-size-dword = <0x10>;
-		#stream-id-cells = <1>;
 		power-domains = <&pd IMX_SC_R_USB_1>;
 		status = "disabled";
 
-- 
2.37.1

