Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 63AA66251AD
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Nov 2022 04:28:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229757AbiKKD2l (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Nov 2022 22:28:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58202 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232590AbiKKD1q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Nov 2022 22:27:46 -0500
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2083.outbound.protection.outlook.com [40.107.21.83])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A25C6587B
        for <linux-kernel@vger.kernel.org>; Thu, 10 Nov 2022 19:26:58 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iUkf9SOaQhoYSbcSWleUCaISESoNcfGWEM8jReTBaJWmn4k5tuxlSsv9d3j4uOc3iiK7j66m/pnq5GuDkvagfeBH70g4733T3Qe7qrNXqCEtQWJxBuowENN86QsUMkFB86yxmKydIiOnFyxck+5JfauJvdYN+xLRf4MGD6BEubZXwIlN70Q2H0gL9Qbc4k1jSNUW2/t866V0cfPYEXdo//p7SzBTmqZX5sHhpWrw4qe2hBzRwdbu0B6I/YhRo3vKD0NscX+Kl6qnvO4MVIGa6KzjUe67hedLT7eQczNlKH1ZdVDxQwuijxOS3IJF5quawJsN/LcftZJwTuL5qwRHDw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=94TR/gJ3QFYxCbPvYw8g71pvCpJSSj08ePQxdLAnyuQ=;
 b=EW1Agw/lDFbptgplZGVZs/EeMjtHIKh1sGCOEbU2TfO9YT4KUE/+jz3PXpdd4t/r/zkRaOR3nWSsfo6S8G//Oqjq15H0YLvwOdbUsTbeOYqpHTI9/VAl6Fwi+0DhWtyRsUF2blS4YZ/71MOJSIiVvzSpP4TnMPr+BURp0spQLliE62QScw3AOP9tzxRUH/vg2zqWMgszLHR3bNgJqQtEb3zCy/yoZRNEomuV4atVyjGzLVy7BUh+D3uOr3j13CpaHQnrSpELvuDK6BkgaBZXL4+K3OkV6J6rlOodyIwOSihKf4w4tukB02YdNEojHd+RDE/aivmxC6Xw1QP4I0AaJA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=94TR/gJ3QFYxCbPvYw8g71pvCpJSSj08ePQxdLAnyuQ=;
 b=ayMIIw7AtvJUZ8clC2XH2BUmTaZPP1KlkjcayAlnYF2T+zegHY6KjqUmc5feLy+crmVFP1cf99sd9xF5u4WOw8kxjuDkykMgGVi/E7fmvguQai4wugHWz3waTO1lmNlwpyZbQtI7whVL1udLdedNVZNzJmDM3k/wh6b+VHTYCJI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by DB8PR04MB7020.eurprd04.prod.outlook.com (2603:10a6:10:126::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5813.13; Fri, 11 Nov
 2022 03:26:55 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::ac6c:bcb8:674c:35d0]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::ac6c:bcb8:674c:35d0%4]) with mapi id 15.20.5813.013; Fri, 11 Nov 2022
 03:26:55 +0000
From:   "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
To:     shawnguo@kernel.org, s.hauer@pengutronix.de
Cc:     kernel@pengutronix.de, festevam@gmail.com, linux-imx@nxp.com,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Clark Wang <xiaoning.wang@nxp.com>,
        Fugang Duan <fugang.duan@nxp.com>, Peng Fan <peng.fan@nxp.com>,
        Marco Felsch <m.felsch@pengutronix.de>
Subject: [PATCH V4 03/14] ARM64: dts: imx8mp-evk: add pwm support
Date:   Fri, 11 Nov 2022 11:28:00 +0800
Message-Id: <20221111032811.2456916-4-peng.fan@oss.nxp.com>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20221111032811.2456916-1-peng.fan@oss.nxp.com>
References: <20221111032811.2456916-1-peng.fan@oss.nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI1PR02CA0040.apcprd02.prod.outlook.com
 (2603:1096:4:1f6::7) To DU0PR04MB9417.eurprd04.prod.outlook.com
 (2603:10a6:10:358::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU0PR04MB9417:EE_|DB8PR04MB7020:EE_
X-MS-Office365-Filtering-Correlation-Id: e6307b78-ab4b-4bcd-babc-08dac39494f1
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 1K+Th6rLCqW4IJpkoJkcQPID7xFXZbNdrPsBz/FLIAamC5sAzfjsr3bN+tXfCnzODYfYK+8jpBP6ZrjyzKMYthmPVeUldnwXfR5fi+gGkP6u+7osE7gQxIXhG2GuOBptriQ6XnnhRJfcADHgFNc8oxHFRfgtXq5b7JY/KKMI8ju4q/UZtP/pbQ+aAschQISW+6/BQuVT1QZ3CS0tti5J9L9pCc4sBBx6twdzJIp+xkm6COUrhxoMv7l8w4YjFmiRMEYpe0wOV8efumXBbOhkZ17R4DeDekIpkaARGy4UnB5V17DegP8wj8T4lIOqS9CZ9nNrCWzR+mwS2B1vyLPu9FaWK9RZ3QpLjkMu9p8CTXjQtqN3xIM21SUjJsbNbWKU5ihAkbOgUsbc0o2MBX86XjG/PFymRDnsQ+lw73tXSvdj8jsrlFFW/kuxt0yl/NIAveVpf8/yhos2qIY2wV+0zuLBaJRY0I+2FOlyQtGsN693Y1tLAkTbqeF+46qB17jgTuQypWcD85C4Z44jOOm/NIddxhC/49O6ItRXNkT4sbQ44yvDzb+t607SnbhuOAM7VZ0vXST+2ckb9TsJ7M2E08nNQc4KHnSn3lAGUdBqQQfFFOEpMZbNAsrNdvlHT08ZmdXFbofAeW3YOJkCEKyXd2qdk/kVuVLncyU+MvZ8yyhI4yhh3A5F7TCftNjNKtbjn9kNeIYWaTqUexvepb5JaLLWAVoBpLpgjW8WcRiSc9IwWgZzxqbZ7a3uytbpNoIZabIu7Owh0CfY2A1YKss5UG7CEFFA1hiaQPdmY2Xx9b4LmXOLdnh3N9vDYxciETSBr5tdElHlYEWth5HbSEjepC+LoNuT8fMr77cKMvbMGnc=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(346002)(136003)(376002)(396003)(366004)(39860400002)(451199015)(6486002)(6666004)(8936002)(478600001)(41300700001)(5660300002)(1076003)(186003)(316002)(6506007)(4326008)(38100700002)(38350700002)(6512007)(26005)(86362001)(2616005)(8676002)(2906002)(66556008)(66946007)(66476007)(54906003)(52116002)(32563001)(414714003)(473944003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?zjWiDLxnx8GInDfKQXNczCNVN3Z9x1/hvoXD07LakeAZcU3a9wX57PT2/9h1?=
 =?us-ascii?Q?77lEaTySf6QOuJELHAQVt9h0xCwGsVD6P94swubfVrkl/vVde51vQqgVTJMZ?=
 =?us-ascii?Q?/Z2CaFVOLB8nyaub5P/FteC4z+8zx/zAlYo7XwxkZeWCbSbqgCGkQZP/jtT5?=
 =?us-ascii?Q?mw4v1cCnUjDG7W8dK0Me5NaE7ph/UwiW8MKPPiSChiGCU5ioUQshXl9x3YKD?=
 =?us-ascii?Q?riqFF1kP4iNY8toHwBb9LiBmP17x3R3rZd2xp9ofuCJqEASeBUDz9E63tOPV?=
 =?us-ascii?Q?+zYduD70UFzXNTixPEb12rQT6BtDfIKzER5rXLQh0l2D7W/eFzL2wHkK2mti?=
 =?us-ascii?Q?yHmQDq7N+ZLS93BirpZGia7CmqjRVONYYDa2q5m9CBI2VJfsc3EZ4rX+RRfU?=
 =?us-ascii?Q?2a+5oynpzjC3DfVg3x8wf9cjfUxMzBJRqxhXwxpytlnszLch0GYUfPkZnG2t?=
 =?us-ascii?Q?oYtrprJJRtUnXRUUPWfVa2WSY5n4/cojEUUR6cqv/uJ51CWxa4FT6fhqFul4?=
 =?us-ascii?Q?1kuSNBmYr8WVPbmpkN9lJbyzLv9+OTpMn5FYlvt7HOgeFhXpVUzDChY68dbF?=
 =?us-ascii?Q?/7YGuLvql96DKkqmGMgLf+hAxtNZzYVK+yrieN55PTI/XLCipfQygTrwS2Aq?=
 =?us-ascii?Q?AawfSIFgxzcsEAOi12k7AOdp62P1bS39YNHreQV7Kq5nf2Azg7e0grPqiw15?=
 =?us-ascii?Q?tbX3tm0G1n1i0sydC40mA1plzNu+lcwpLlTandfjeAvoJYIrqfxDscPpODMS?=
 =?us-ascii?Q?eAvSI1zhhmKnhcP3UMTjUGQGSfqLDxInqXfDnGAfGymYxPR0qFGZCYrnAie2?=
 =?us-ascii?Q?XIa3taTIuJ0Zmpc8fkVvXOuHcMtGdVIicsMQfoM6aSWsNMRDpM3+PKTxX0pk?=
 =?us-ascii?Q?tPnR0xFqEN+jD2ZciKaD6G9kjEZKlMbRKzj0YukafBKlsYTO12VZrrHeSUUN?=
 =?us-ascii?Q?YRtqG3/X6aPmLiGwrYyTXUuKOT/VifSW3meDyWSf8fB+cF6SsfppKvojd5Jq?=
 =?us-ascii?Q?oECW/3XRfN9Duu6UVBS/6Mg2UmOXfScPqLOH9+qVZpVjzhr6Dq0bmO7JqG1U?=
 =?us-ascii?Q?sa4IkLhGM6no1cFbkqgFTzPwVf8Qh5nEwWonL4r/YltJXsv4MJM3hOzeGT8a?=
 =?us-ascii?Q?OfKjkyOQc9IJsvXPsD60fWMRq4XVLb+dGv2hJreuBEAT2CBWqXbplVLqRSI5?=
 =?us-ascii?Q?P/y3qB19H71oFT7wNnOMS7By5R59QL7GYSyxn0bWCXMgAM7PlrFUggC9gwFF?=
 =?us-ascii?Q?uoNiLgz9QOIKjrKJFiLleNP/VE9IlwY3W3xhVdGGOobNYfEiaIJzaCgQOALS?=
 =?us-ascii?Q?lk7bQR96E2JTWNYzZf+ri4IDaFRHr4joXrhCizAdnVSnk/4AFEChGLfl3kAX?=
 =?us-ascii?Q?KdgXAlnjH8WCMb+B2LL/mm6iurJaBQC4z9g0mxSCqpwLC97WSpA+5VCQIcYj?=
 =?us-ascii?Q?1Zs0Yl+jpJo0kDim7fnVAi9RU8Gn4Ioks6ascoR6v9Vnqfq/Ky7QVl9NtHzM?=
 =?us-ascii?Q?aAtXnRwZGp0bVT5KInOMiDzncKYu5S3ctHmgjABtNMHLYstUuakYLPwXlgZ0?=
 =?us-ascii?Q?DBFOCoBV7P2HOARQMdjTO4jNaF/Skf4OCguoFk2k?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e6307b78-ab4b-4bcd-babc-08dac39494f1
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Nov 2022 03:26:54.9824
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0zCf5kcWTA7+QGFUxdqp5nPh7yh5VVWl/65S70yes/nO5J+n8OCxbEv66JbdXgU/jThO1wTZabPs95ue00jD3Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR04MB7020
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Clark Wang <xiaoning.wang@nxp.com>

Enable pwm1/2/4 support.
Enable pwm1 on pin GPIO1_IO01 for DSI_BL_PWM
       pwm2 on pin GPIO1_IO11 for LVDS_BL_PWM
       pwm4 on pin SAI5_RXFS for J21-32

Acked-by: Fugang Duan <fugang.duan@nxp.com>
Signed-off-by: Clark Wang <xiaoning.wang@nxp.com>
Signed-off-by: Peng Fan <peng.fan@nxp.com>
Reviewed-by: Marco Felsch <m.felsch@pengutronix.de>
---
 arch/arm64/boot/dts/freescale/imx8mp-evk.dts | 36 ++++++++++++++++++++
 1 file changed, 36 insertions(+)

diff --git a/arch/arm64/boot/dts/freescale/imx8mp-evk.dts b/arch/arm64/boot/dts/freescale/imx8mp-evk.dts
index b4c1ef2559f2..e323e6f4b7e5 100644
--- a/arch/arm64/boot/dts/freescale/imx8mp-evk.dts
+++ b/arch/arm64/boot/dts/freescale/imx8mp-evk.dts
@@ -390,6 +390,24 @@ &pcie {
 	status = "okay";
 };
 
+&pwm1 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_pwm1>;
+	status = "okay";
+};
+
+&pwm2 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_pwm2>;
+	status = "okay";
+};
+
+&pwm4 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_pwm4>;
+	status = "okay";
+};
+
 &snvs_pwrkey {
 	status = "okay";
 };
@@ -567,6 +585,24 @@ MX8MP_IOMUXC_GPIO1_IO12__GPIO1_IO12	0x146 /* Input pull-up. */
 		>;
 	};
 
+	pinctrl_pwm1: pwm1grp {
+		fsl,pins = <
+			MX8MP_IOMUXC_GPIO1_IO01__PWM1_OUT	0x116
+		>;
+	};
+
+	pinctrl_pwm2: pwm2grp {
+		fsl,pins = <
+			MX8MP_IOMUXC_GPIO1_IO11__PWM2_OUT	0x116
+		>;
+	};
+
+	pinctrl_pwm4: pwm4grp {
+		fsl,pins = <
+			MX8MP_IOMUXC_SAI5_RXFS__PWM4_OUT	0x116
+		>;
+	};
+
 	pinctrl_reg_usdhc2_vmmc: regusdhc2vmmcgrp {
 		fsl,pins = <
 			MX8MP_IOMUXC_SD2_RESET_B__GPIO2_IO19	0x40
-- 
2.37.1

