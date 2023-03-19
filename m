Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B10996C0107
	for <lists+linux-kernel@lfdr.de>; Sun, 19 Mar 2023 12:50:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230318AbjCSLuU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 19 Mar 2023 07:50:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55508 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229524AbjCSLuP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Mar 2023 07:50:15 -0400
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2089.outbound.protection.outlook.com [40.107.22.89])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B5E4B21284;
        Sun, 19 Mar 2023 04:50:10 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JvfCnFh6RBjRuvNzL6Wp6eaFpWvvbvhpQ0FrW5TwNCnb4XZ15FmAtxQa40w2vo3oxHibkLp0Wh8OM/MPCPM9W16rcevLaKD+4TicA/HZMUxPRnwma92KRl9MNg5xCI551lNy6FKxDHnLMKVECKp6elYdt15cAX8aMwisp9Wa8TCb0V0E4jElCTpQRvVySTiYeuKqaN2XlzdV0WOpPWZfT80FLTBlCvUdD0Fy6+A11pZCmDVShZ9anHLcUp1AFzTifgBQJxGDAtOx9v4w6qGJ+SaC0fetJOq8plTsdJDEtt6ojzWnd07vf+jM3Mpz3PGpNLtOJLNDagykk6O09EHkMA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7AOiSVpHHsJl5vjiViXVJzHrkbnpOPMIcItM0GZM6/E=;
 b=Kf0H7FVkddBbFXKzNnHQlqEPZwyKQ6ZRRAYN+sTSUYpyZyg+GOMflGiC2qxDaHEZO4R6kecBj1s+9kq9s7yE3SYK0VshX4zlcsvn2Ha5OSuLhidYXyElf6tHLDQpoHxHst11gmjeAmGKZRlTOLK/YvPoYd66T7ExbLroam9GBhEF+lE7GiaaAB0qKJIthScdr7nSIcaI1LAgkViLfzrb9BSH4V8WCZzAY375tPkJyyXs82ponPnZKFkzRIw8LpUxpxYACa38IzLFeWmoPksr8jaTs3GUuGsUHXaI2QEd+Qd2CTDuMlDp8T2Tn+CYg9n3BpIJA2dE8vyR5ha1orR1Iw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7AOiSVpHHsJl5vjiViXVJzHrkbnpOPMIcItM0GZM6/E=;
 b=jf4bM+NxpJi50HGDOZw7GZJw0/UtvrdAU8alHFhMn3vFUhlqG4Iam83rPNwRK8VJeeH4hyDQn/5/3VKDznBPj1Z/YP/zhkfkvO/uG8vLPzCgHz1ntXemAhClrIdgy65qaNnYw1/WY5Djsfru+4vOpPNVB79h7VQzt2bO/kpnueo=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by VI1PR04MB10075.eurprd04.prod.outlook.com (2603:10a6:800:1d6::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.36; Sun, 19 Mar
 2023 11:50:07 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::f55a:cf12:da08:6d2a]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::f55a:cf12:da08:6d2a%7]) with mapi id 15.20.6178.037; Sun, 19 Mar 2023
 11:50:04 +0000
From:   "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
To:     gregkh@linuxfoundation.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, shawnguo@kernel.org,
        s.hauer@pengutronix.de, xu.yang_2@nxp.com
Cc:     kernel@pengutronix.de, festevam@gmail.com, linux-imx@nxp.com,
        linux-usb@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        jun.li@nxp.com, Peng Fan <peng.fan@nxp.com>
Subject: [PATCH V5 3/9] arm64: dts: imx8mn: update usb compatible
Date:   Sun, 19 Mar 2023 19:54:50 +0800
Message-Id: <20230319115456.716969-4-peng.fan@oss.nxp.com>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20230319115456.716969-1-peng.fan@oss.nxp.com>
References: <20230319115456.716969-1-peng.fan@oss.nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI1PR02CA0003.apcprd02.prod.outlook.com
 (2603:1096:4:1f7::20) To DU0PR04MB9417.eurprd04.prod.outlook.com
 (2603:10a6:10:358::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU0PR04MB9417:EE_|VI1PR04MB10075:EE_
X-MS-Office365-Filtering-Correlation-Id: f195b89f-1474-4d85-6cde-08db287013eb
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: l3pw4d9YoEqOrK9UMLUQE80YnNcbFhhOY2obK1L0Bh1VbWqu9xy1ciLzNlUcWoaSYo7qM6ckTRYn2D5coN3v7GetXoSI8Aq/AKWQ3J2pyG4XbehdM3ekP3y4zhxCVFesiHc3KMrIdwuej5EXw7UIz+vB5xxYDTzV48Y8CWw0FUiOK5E5C20bR7jfty82AQmPrnDOGoAQww10wTNxVSkUA9MMk6LOXO1rIq+3UdcHhUJqb9LOSBTN3D30+jhJrPAN8UUQxQ+uKBDLi0+WG+hRIJh8zr3RLKQfkugsXG4pE2zaU+85ANPkX8i0dQKUx2blNFeQ3sK+flH6ranUbkFAGakQzhOfLMqU6crzJ4D7O6iAjfIuJSO/xIKIZTdw7jfAtYC30BK9I9SrqZJsto4VuE1zJBsxgsQ6XRFAc75mVDh9XNoG0nv5dLP2o5VUaNz78I22KOXAHuU2IEwsUy4hLkFGdeJUCr+gMSftvzw5shQE945MjQqDU4ay9MX+Gw4DmDy2yPt4tzG6Qx0k75Xr+/BF/CBjOjUbdxFBgyfiuJ/u9nnG0fzi99ZFBWVV0nR3EjOjHFxdy460r914oQO+z2eT81XlPRAAACxyLJwy1K7tN38upET32FSO+8s/UpoQuzU0EHmMB8URlZRfoaYd0U1JXd8iAug+MfcP/l2fLQmnMla+aKIYZdI3QnhOsPau2f62hC2fTg4wxf9GLsZJNuHha1wqyhzOPo59d0yVvvQ=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(346002)(376002)(396003)(136003)(39850400004)(366004)(451199018)(86362001)(2616005)(186003)(1076003)(6506007)(6512007)(26005)(15650500001)(6666004)(38100700002)(38350700002)(2906002)(7416002)(8936002)(5660300002)(41300700001)(8676002)(6486002)(4326008)(478600001)(66556008)(66946007)(66476007)(316002)(52116002)(83380400001)(32563001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?eCBaGtcwpY4a/h8TqIHe3Lv3eKGjKsFNGT6XGEq9Ub/3Xm3JG1zFS+3ONyQa?=
 =?us-ascii?Q?yI3EMIMCdY1ObJmkCm6UbAohaVkpB6J4vAAzm3dUN/bAee/X7DWVkkpp23Ri?=
 =?us-ascii?Q?FmbG4nUOfNWAxaWMH3WD11KQKZTyY5Yoym+tbKm6CdVMtSftCYA9gY4LcK0k?=
 =?us-ascii?Q?9/qOOrmW6UOKeMRm4OWuxeNaxyY1S2NsFhOl0b4PfTO5OD56lzLFg7PEb7EL?=
 =?us-ascii?Q?hSNcTeU68fvgJNgCrrv8F0BHyQcF+b0ahoVu1P/Q1zXqkFJZWnqM4fVTdMaF?=
 =?us-ascii?Q?a9iueqfj9Qg1XH8jCWaAS+yAIOJAh1r8hPitagH8CovLRHkqr3M9G2+UZPNo?=
 =?us-ascii?Q?V+04yy20FZeYNlAPMCOSuzFES7jy32Bc3liCpgys/HP6Loxzj7gco5LjheV7?=
 =?us-ascii?Q?SxiElOfd8sbNG8hAOzYXH7kP8jftGFbbbx4xJ57HjUUcK67ClHHsD3udUtFL?=
 =?us-ascii?Q?PduPMsl+j9+ZU41pGu2M6AxjWJXAgl9uDJg5mYO0W54++h+v4Y0eG6u1W91h?=
 =?us-ascii?Q?x/VBPWhq132sv8mU91pNGhX6VCBtBKKY14ru2HiuQ1DcuUgAucm234N23Lza?=
 =?us-ascii?Q?4WL01imKtQH5nHWVEgoBp8ISqSLU5MNsBXW5W5P3yPvcHgNUIUWfM8DUH6ET?=
 =?us-ascii?Q?6+mJXWLtY3qWsfUI3aObFWPSA2GQwGuiJ/lKxl/XZh5wTOU8tUiQDMsF+iUd?=
 =?us-ascii?Q?QTugVCbUQraJNt9rAjN6acAXJGpwA2gKms421gKCN6rNU8z7iz3Nq/Th5vIB?=
 =?us-ascii?Q?5V08UGnEtS4TM7Hj0FPfGvLei3KrOJ4M2FO6jOXfvA2B5q1zAF2md1xKpgJJ?=
 =?us-ascii?Q?pJCKkpD8a73bKl2GMMNfCIEjoIaZaGqFQCrPinozzaGmw+3O7p99VV+rKAT7?=
 =?us-ascii?Q?5QrBSgaPMelTIMAlOisuuuEaGBBvLrj7KVbhODb2n/QbApAnMpZ2dtiKZq9i?=
 =?us-ascii?Q?gpDv9fvCDA9BTo/Xw5qswIqGIA67BO4HE4E+emdej/6UgIISECz85W1moxK1?=
 =?us-ascii?Q?cNGqCHr3xSRioVnGMzJJ7UKfWYccuQmZt5EUU5QSdQyu1asdbkamTD+WL5zS?=
 =?us-ascii?Q?cOcY6QwiKiZPAy/wCppOC10DOgioG9QZVusUIMFKhcOQTp7RIk5l4KphlazM?=
 =?us-ascii?Q?hYEp8NDnI6yDceISQ6f+6J2YRCRzgKIjYJ2gX/vAwjpude0iqz4RInsF5gdA?=
 =?us-ascii?Q?UeexSYTKhiGyed7KgkGmVZUQCp6fpz/XGl9mpds9NwNVjIDCy5ogMKyz45C/?=
 =?us-ascii?Q?PeHRLPeWcvu4/blgiQjTxZGj5PW31DBNS3Zpq4Mm7cKd5oLeUncqDRp9LE6m?=
 =?us-ascii?Q?uUqD/bHeKPL4ySKtVq4hMRclwEmN1Uky2mrpca/WaIUG7HNKA0Cnc5XFi7yP?=
 =?us-ascii?Q?Kf/4RZl5jymtcY5OKPXvjqFwWUqjJm5ms7zLEWRmvHLfwnIs+IfHI7pK6DWx?=
 =?us-ascii?Q?QiaRbIk0hraeM17E0+GBXwdbV5F5tL7spclKY9xjM+pBFLr3O3gZfCOPp/mt?=
 =?us-ascii?Q?QLVbVc7+owedIsC2+0kU6keo7yuvndoratTKdJdCY1yDyvMiR7JuPcnXkI7i?=
 =?us-ascii?Q?mmBR8DFSLL5f0IegEwWH35x5WW+Tnjlgps1r8MeA?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f195b89f-1474-4d85-6cde-08db287013eb
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Mar 2023 11:50:04.1513
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: uaCk9B25NJ5uaklh3Jsz7BDO5Un6eG5OvJVio/AvwPHKmpGCYlAcOz1nrGKmMSpm4lY5zNSpBOJxEdARVo9EcQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB10075
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Peng Fan <peng.fan@nxp.com>

Update usb compatible per binding doc

Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 arch/arm64/boot/dts/freescale/imx8mn.dtsi | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/boot/dts/freescale/imx8mn.dtsi b/arch/arm64/boot/dts/freescale/imx8mn.dtsi
index ed9ac6c5047c..5c3ace42fd4b 100644
--- a/arch/arm64/boot/dts/freescale/imx8mn.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx8mn.dtsi
@@ -1086,7 +1086,7 @@ disp_blk_ctrl: blk-ctrl@32e28000 {
 			};
 
 			usbotg1: usb@32e40000 {
-				compatible = "fsl,imx8mn-usb", "fsl,imx7d-usb";
+				compatible = "fsl,imx8mn-usb", "fsl,imx7d-usb", "fsl,imx27-usb";
 				reg = <0x32e40000 0x200>;
 				interrupts = <GIC_SPI 40 IRQ_TYPE_LEVEL_HIGH>;
 				clocks = <&clk IMX8MN_CLK_USB1_CTRL_ROOT>;
@@ -1100,7 +1100,8 @@ usbotg1: usb@32e40000 {
 			};
 
 			usbmisc1: usbmisc@32e40200 {
-				compatible = "fsl,imx8mn-usbmisc", "fsl,imx7d-usbmisc";
+				compatible = "fsl,imx8mn-usbmisc", "fsl,imx7d-usbmisc",
+					     "fsl,imx6q-usbmisc";
 				#index-cells = <1>;
 				reg = <0x32e40200 0x200>;
 			};
-- 
2.37.1

