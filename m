Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D8D056C2D0D
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Mar 2023 09:50:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231179AbjCUIuT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Mar 2023 04:50:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57636 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230499AbjCUIsg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Mar 2023 04:48:36 -0400
Received: from EUR04-HE1-obe.outbound.protection.outlook.com (mail-he1eur04on2047.outbound.protection.outlook.com [40.107.7.47])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 014121B4;
        Tue, 21 Mar 2023 01:48:05 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dpPOWY6ZbcfSnmHmfQhWkMRcTS2Ji8VVjidfMvEEywnggMp01Xv19q+VpxXki2rApsNhwQBJFP6buT19fXxdr5HFRSOteg7AwfJfZ/TqYPeaWLk9QI27wKTP+AQQJfVFT+cYY+7GFbqDCqADLFMgexIP3OA46qzJP2wjoQo7b2GKj0KsXhWMYuzQ5034d/ptBeoyHMYBEzwOpE38t6PawZ2LJ8Dl3/dKNscWaN7cRNr68Lw7zWEXY9Y3TrecRk5phCAVXAr9+Lm2RZY3TVkuOFaJaZVQwX29xZKko6lZ4W0YwaE0ekKuVjhmPgpZRO/0LHkQpvqlED3jo0XbDPzdkQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CDw5DpqU6K5S66RHwoUJICFaH7ygMKUR421HRre1JlE=;
 b=MP7+XLC2VNjSCkLVPlClTRW6xw6PH4UafiuL2y6aOHiCoqnxzwn1Jk1Gwdde0Kdb6BPsNYgjyqeno01XW7QaSQGGLSe2hUxdadmmcVdtI6LX3/Anxn/0aSzBvZaiXgFiC27OKrBzF5jJGmX1SaHcNfCuZpKxN5Q7NHUTWgZ02CTwyRpcsvDVKoOFZP1MaIi2RvV0VvpGb5KzRINe62q+PK0JqsVP8X4NrPM5rlP0XTcoLIQT/hiXYA8cmr4LhR0I8e66q7StBEXpVMcB9BvW/fgoa+3p5yG0tm/1W42scWtVI8IQPR2ZYXAUr4TV++ofTBABD1qCMsOJxUrRD7Pwng==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CDw5DpqU6K5S66RHwoUJICFaH7ygMKUR421HRre1JlE=;
 b=V6z21Z6haVeqINsHUOlSMkHK0Sj85nNBRWUkDhCaMRq+3E9LkzeX1AMDrIGUmzTCaY6QHxsa8JqO26LyOFSVg/QjNXnNHptNbU94gRvN9D7gkmFjyevByPEGOQu0rlZA/cN4GWbQEZXjOApeJmJRxeaPnBkci/5bf4JsPy8h5L0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by AS1PR04MB9456.eurprd04.prod.outlook.com (2603:10a6:20b:4d7::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.37; Tue, 21 Mar
 2023 08:48:02 +0000
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
Subject: [PATCH V6 09/10] arm64: dts: imx8-apalis-v1.1: drop ci-disable-lpm
Date:   Tue, 21 Mar 2023 16:52:12 +0800
Message-Id: <20230321085213.1624216-10-peng.fan@oss.nxp.com>
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
X-MS-Office365-Filtering-Correlation-Id: 4f0ca483-9127-4b44-4fe5-08db29e8f647
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: HP7ivPqvAexmzOTTp0+z86jQvntOiyPeOuCmLa5t0pEytfRQsERAd497Pcyslt0IJLzzOrpNaliviRdgRtIc+waPvB3/uWP2lopE2GdPrApXOSbKO8fOFUitqF8i6D9CT/Th48020d1wuSVlQo6KwOHF+b0ztrEKGt8A1bTIWTxraC15QKW5CQLOypCHNYbg+3tD4XsV47fZpvbmMX4ty6tffGCSGc3wH8OeevYewF9ftYVxX8nEVwYZ6+l2/g6CY05HqSyQk+EpSx1+CzwMs2Gp8Rp75PIyCPFOlNc5ynlTN2Vx7wuPeQQ7idSEjMfmiVpJMJBu0Lm3/KfPOSSZx5LBhP/GHrPmfC0rc8hdABbZNhgGoruQnVLteNLCfgUtGc/fwd11HvXAtacidkITJPifDTbMJ+9Q+y5Ix5T7xSnxqTlVPVqAEJWKfLYr/lwj+aXEQ//OAXa1Ag8+nJlYUsJk7DMqAShkjLoEOtz/VlByCx5GyNYrp0bQqDrUbHN+lS2aqdQ3mw8X11eRSa0EOF4Tm3hqFJSrVyRbdx/k+ZB8RzptZhB2bXQzPnW83m0pTahQ88cN6geS5ANIzjvm6SxgrzeB+b2YiTpiE1yduVWqSdYpIbQ6KUASzNnDt07it2K2wfaMVc/6cpBT9/zFXcLOZ9BG9JvFU69JArrPmmkXod/geNRmhz6mxlrlGW7AZyDBKaW21sCuNxI4kk5I0Q==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(366004)(346002)(136003)(39860400002)(396003)(376002)(451199018)(2616005)(6666004)(6486002)(186003)(6512007)(6506007)(26005)(1076003)(52116002)(38350700002)(38100700002)(478600001)(2906002)(86362001)(83380400001)(8676002)(316002)(4744005)(8936002)(4326008)(7416002)(5660300002)(41300700001)(66476007)(66946007)(66556008);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?wiQNPQasVJNwd9HG9iY7ERFeGyDipsMfLueKMIYKI7BfVqHshBn1VV6k8zC3?=
 =?us-ascii?Q?AgDgzSt/DPD7pN/559KC5KbEdRGjP86h2AiRX0AwLExI+t7oh+mx2a2PWysu?=
 =?us-ascii?Q?PVKMQ5BgD8Bf95hgRhlp+sf6mi4vTJf5xDTBZHeCze7JmJi5DmmJ9//iZzDR?=
 =?us-ascii?Q?MaHJa64iQOPQgYF5XXvrBNtc0EoaMlRalQ+/cHa1GqHm8K2M1WJ+kuBJL0kC?=
 =?us-ascii?Q?3qSYa5ynpY/TSLXbH0dGTULfyIaoetu7QTf4Qak5Py8R1gszKPoO72dY5/3H?=
 =?us-ascii?Q?Z2vdx57hgL5Hspoq7v/HPptzB1gEGeCHZg34T1u+dUx0eUp8W6aMIEKC53AN?=
 =?us-ascii?Q?JNgtyRNiwtj08wxbpFPLFtlhPEdcoKQHBbcOwC+uEEy6Nj0n/WtJbXGqPst0?=
 =?us-ascii?Q?kIw+C/dqjXoM/kUepk9tJoa7UV0Vv4HRMp4vygy0MDC3WTO/e0g+YrCFzMID?=
 =?us-ascii?Q?Alqu/iZskqJlquDZxNHQX7rOJSkhObBoQsP/KiXQT9ndJOp1G+sjfKBLipg+?=
 =?us-ascii?Q?RD7rvp0xvLKrVTWNIOxCC2C8pxjymg/m5EQOXPcPkbESHjDee7ns2agxjw1M?=
 =?us-ascii?Q?NQWmwkuWeNE4mV1Id5Vk+2HGItANjPCtMtlHflmVI2CLimOD/ICs2OupEANC?=
 =?us-ascii?Q?S0wBjp/3NpqAU2CrDKhLHR9L35eYZTlQNi//zrtkrKjVlJZAfb3eoFLSgMkW?=
 =?us-ascii?Q?GHb4Yhpl/j4XDD+zI0KII7JVF1NKEUCyVprc9uufbNcy2ZUgU08t8GBpvwmQ?=
 =?us-ascii?Q?I+KGw5ZRMaTE/O6yMIvH6XIioHpZZ4827hWDKgjgzBbLlRK/bfQFRkzFVW6M?=
 =?us-ascii?Q?FH+66fCbxIDFtX2Xbp9Qjf+yzHkvdD2bnfEG1hrrDb938gkr+i6o0vFPiwog?=
 =?us-ascii?Q?JE6TggyZYlzfk6fVO0ywaXdIyMY3YieSbJPbNesv5zYCZgC7JTYPAp1bSMXw?=
 =?us-ascii?Q?/HtbXhRU8wYSotqxzxYVXxfzbOPQzysgtXFjFNbG3SqDXQUyyoSC4Z1UEKOO?=
 =?us-ascii?Q?aoZRuECAwcED/3m6Ozq9EXo9nVSGnJnqHmHceQT5fQONp3VcX+lX5tWEk8Vj?=
 =?us-ascii?Q?EnasXNTsqGpL+Rcba6GcUzNjw5rY9WMsOWFkOIo9/e4A/Y4BmEGthfRPB8jT?=
 =?us-ascii?Q?LmGET5MG/voOAj/gjIBeVZHX1oMRHXPmww96m0lcbc1awxb3UahY8XkZ9Qdr?=
 =?us-ascii?Q?/E7qHVH6gI91QnWc8my+bvwzzwpbc/Uc3jO7t2hmSeJKc9KprOqhVTkEaDSR?=
 =?us-ascii?Q?YBu485m8n5D1sTKY3uo5nk43yNYggF9COQa7vnKKrOfnBvbtXSBiEG931Zps?=
 =?us-ascii?Q?fHBU4dRVpaBtvmlZ8qsIlL6ufS3NKEuQ/g4KBnmW9Zu3wU1hReJHemsHdfhJ?=
 =?us-ascii?Q?1AfUcLGLy0+L6jyYt1+A4JtUYQYcHS6kLG6Lpr3j4wwRZfyerVU4pGXTcVkb?=
 =?us-ascii?Q?/LUx9KVQY3hyguzttJfRpvJfo6kav/E6HtQ5tyeohfoaI1ZEbfe4IqfT0f0d?=
 =?us-ascii?Q?EblJpkI1IdyjOKYlfhQhVpbr6dfeKSv7PU0KiHQwsFVmpEnfc0eTG3yPnIol?=
 =?us-ascii?Q?7eH1qBIiKfc1jwWLAosEhoZDcRDo5nRHq/jDeujF?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4f0ca483-9127-4b44-4fe5-08db29e8f647
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Mar 2023 08:47:54.8763
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: JhPH4FDqXtGMaT+0NbIJvCMrBIPoc/dBCT+NzusAIYeTtp+GSdxSv5qSP1KgiLBxcq7CsRmKOzxJSIigQRow8Q==
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

This is an NXP downstream property. And no binding doc, and no
driver use this property. So drop it

Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 arch/arm64/boot/dts/freescale/imx8-apalis-v1.1.dtsi | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/arm64/boot/dts/freescale/imx8-apalis-v1.1.dtsi b/arch/arm64/boot/dts/freescale/imx8-apalis-v1.1.dtsi
index 486adf849452..bd5d771637ca 100644
--- a/arch/arm64/boot/dts/freescale/imx8-apalis-v1.1.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx8-apalis-v1.1.dtsi
@@ -726,7 +726,6 @@ &usbotg1 {
 	pinctrl-names = "default";
 	pinctrl-0 = <&pinctrl_usbotg1>;
 	adp-disable;
-	ci-disable-lpm;
 	hnp-disable;
 	over-current-active-low;
 	power-active-high;
-- 
2.37.1

