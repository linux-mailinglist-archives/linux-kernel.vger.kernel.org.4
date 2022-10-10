Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 68B3D5F9C65
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Oct 2022 12:06:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231381AbiJJKGe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Oct 2022 06:06:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43500 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231430AbiJJKG3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Oct 2022 06:06:29 -0400
Received: from EUR01-DB5-obe.outbound.protection.outlook.com (mail-eopbgr150053.outbound.protection.outlook.com [40.107.15.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5CC4866A5E;
        Mon, 10 Oct 2022 03:06:21 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Deu94H1VIRhccMHu/b3puSveVBOntCMXvKwq8eBKtuOw+V6jz6gnS/qVd7q6uyq8/iruXRKbhUZO5qTba0VVmZDF5N7aTUnTUYGN98FFC2r0Q+ju3PXPKHusKfwHrenzD3RvjebF3FoU++FzrU6Ut0s8NCSH2I7CATGCzB5+sww/nX864yv0hlfBBlH35oFjdM6HCw3yPnJAteDOMJTrH+NZB5SA2/NWWRfXZLfWfYSF7nNdqa4gfAQnCMjTMPqwcxZ2MA9wev7CsOhlQka7nRuqqM3t+PkuXXgTrA6aXPAylWE+Bb26GARyHZ2zwI9uYa47HpvEPFU+NUHD/fxbmQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+8KDLIExg4Mqf43a8Paq5AME8XTVoLM6VHQvRilQlvw=;
 b=DWufprA6YVW2nkt64APM6CB/wuJBpV2/TdNvADmK1fH3cNZT4t8/qWAM7qNay4Ln6kxcVbo+d+2DgVkJcwMxGgFcn1rwhRBU5MQs6fDx8RwggqEygHcwcX/3ajcVdhhLL7B9zBG57tG2A22G5PysLz8NDwOeeCLmtNsGW4pXhC62VhPLHjbHccVO3WBF0/A1iXdu1jFmNd4BmdQwhqb81xfAzwjkqWwhgMk+NWztsrpZMU65M6UZpWzUNfS0+4V0Kmuj+95mNZy/V7AEiva7UDOrxXvLmfcw3hW4EdSJnd+TX1ICrn1WNBR1xHo4XeoVRWaTPj40GHidq32okz53Fw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+8KDLIExg4Mqf43a8Paq5AME8XTVoLM6VHQvRilQlvw=;
 b=RmD+NdOVz4/P8r5cJSpxknVIDhgcmkJFlIZvfekOY98/44DLhb/l/muIvg+EmTlSE3RUcRY2YoEHJUX/L9eLeWL1GyB/95RkaLT+otXkWke15b4SvW6T0d2tQiaXNe5QfCTUDAnCbrBRDtEcPUiEiq9GMKz2mkChOJmt0jeLqwk=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by VE1PR04MB7374.eurprd04.prod.outlook.com (2603:10a6:800:1ac::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5709.15; Mon, 10 Oct
 2022 10:06:18 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::ba6:d7ae:a7c9:7a3a]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::ba6:d7ae:a7c9:7a3a%4]) with mapi id 15.20.5676.028; Mon, 10 Oct 2022
 10:06:18 +0000
From:   "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
To:     robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        shawnguo@kernel.org
Cc:     s.hauer@pengutronix.de, kernel@pengutronix.de, festevam@gmail.com,
        linux-imx@nxp.com, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Peng Fan <peng.fan@nxp.com>
Subject: [PATCH] arm64: dts: imx8: correct clock order
Date:   Mon, 10 Oct 2022 18:07:47 +0800
Message-Id: <20221010100747.289644-1-peng.fan@oss.nxp.com>
X-Mailer: git-send-email 2.37.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR04CA0006.apcprd04.prod.outlook.com
 (2603:1096:4:197::13) To DU0PR04MB9417.eurprd04.prod.outlook.com
 (2603:10a6:10:358::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU0PR04MB9417:EE_|VE1PR04MB7374:EE_
X-MS-Office365-Filtering-Correlation-Id: 86a81174-b85e-4660-9fa3-08daaaa71273
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: cNlSQ9xVuFEkkmOZJDsmfb8OvPX+2wa+d9LLRGSofFDTXnHz5Rqc7MvIKzGOvjwk4B6DDuGmqMyEqyIJiatTQrbGQzdFj95M3a/HxUdrlqc6DWGR6LmfVAJodKWDGAvgVcMnCm0uRlZPLCKINR3rktGpB5VbUOmWD3sepz1OE7qjpIhdNhaKWm5aXdbXjCL6shnqI4UznvgQqOJx/Jil8BuSjrSY2hbHfm92hJiloOgDIYC12ceOo4A+Vj0iqs5RBuPgFgowgjKoKrQEiWpYElBqUWuFFh2RiChSzDp2JRpNO9EqOVDUMK7LRD2jXXuyPUcqRqgve45GQVThURNYNDjfD5MZfnO0yc3/iB5Kj4cFAEfMtmthQVj6kN61+fm6W75802D7gB/EX5klzUs9khNtJeF5KtWHNLHUh32QWQMZORDr+75HBrjbIROnYNSsj84yvLC0yjC184Kxi5dwjGBPGI03gAim0+OSkUBcBSuF70m9XOh7GsN2WoJ5NcU6igAsKfbQAircRyJhhkIirmK5c1Os4MMUMQ04ifcokGgOYtlHWTHDYt8hCHXOsm+6ff2eZNC7JWQTYB0WAnW/iz89vHYuaayugkuuWDfEWv/JppQejkG1tghmJTZp1eAa29KyXA861SFWKl96z6wVuTysjjRivcXG1RVYzKql10pswjwzVw7oF1cHctsy0t2FQmqF8RNOR2hsyPKzI4ByvxeUDyCSLe7zzhlA0oPFBqD0hFb5WP4pbYKnuuNBVETcOffMiywN3id1K/hhkTP+FA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(376002)(396003)(39860400002)(366004)(346002)(136003)(451199015)(2616005)(83380400001)(6512007)(186003)(1076003)(26005)(66556008)(4326008)(2906002)(66946007)(86362001)(66476007)(5660300002)(8676002)(6666004)(38100700002)(6506007)(6486002)(478600001)(52116002)(41300700001)(8936002)(316002)(38350700002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?WOGtmJaLM82PxdUD1sKCKylLrtHIj9B+cuhZYpxcFsaPI726wIQERt0zr/JB?=
 =?us-ascii?Q?bnn7oQH8talUJXZMwxfEJm876I9UOIx7zf5BehEaRANXkYZFbU6FkEnWNZ71?=
 =?us-ascii?Q?iFVbIC9iEipRTyPizxaUo6csDnwmsTNMTfiR/YNIr5rckWhow8Dt3lY48Dts?=
 =?us-ascii?Q?37hKz0JGTjykOmy+TS4okRSzT4nxzP6hOiJtwlZIhezcSixKil4NZj7mZ4FR?=
 =?us-ascii?Q?K7ZEiRUdDSZQMKpRKF8xpp9zeLMsyr/qVy771k3f7Ii2VDWS0VUgCdGwcL6M?=
 =?us-ascii?Q?s5luzc1cYYVk0+Ljih8sRFTlfqkjGK7akmtFr5ior9YHmvZ1Pgv7ktGnt+1U?=
 =?us-ascii?Q?7IjYcgyY+1B8e0JztaZN9jpidNV/XZ4Ysb0ePaMYv6wJpg8ge+vQaazHO+2w?=
 =?us-ascii?Q?JvJlEjKdSFd+1f2mng86uMkawyXxRGTCsTvlMyjuPMYtHaIi5I7zcrwGet/6?=
 =?us-ascii?Q?jM0Iy/rRstlq/84nKghZhweSZ42njB9L2NuoMGwIBE1eL5ghlXIfLz8BH6lQ?=
 =?us-ascii?Q?WJ11f3SxPvRiDIUOP9V+pks2uDD6UI2LYHKMMbFOD/oYYw9vi90k9VBnOCtI?=
 =?us-ascii?Q?6PZT9Ew+zd7OBg8cb0V28Ek7PXxdamtHkM2R8yQ8T7yFyR4hC9wQdoyaZwBP?=
 =?us-ascii?Q?6FSp/QaouNppOUqt1wkzM+1p+h/BSh9tDhLj/JJsPWflSAZepswB3KRrr4Bn?=
 =?us-ascii?Q?QDKzBHmbXN6Mu+5vXLnsxMlR1sgZHpkmtxMHMKVMvR9W7a5BwuQIFWEMOCHB?=
 =?us-ascii?Q?VdbpbvhUr+aXj8MC74CGszCpozITymtfEN43W+3VcC5iNYIE0pL92cN0peO0?=
 =?us-ascii?Q?g4o5b1z4i7DC1vk2xlDa10LZxdGrB9YUYMyqfxQdt6K1S59sPO+fVrA8LAIO?=
 =?us-ascii?Q?7vNxyqrAzfHCn7dMflTMAOA/dL2ny8WytRDutgCMOVIa3W+YACbRIX8USP4f?=
 =?us-ascii?Q?DRlfO+MY2aftQz8if0vx2BmcMxVaSuhYbsI5uUi+VvP6WvLS+snaT3oF7+E9?=
 =?us-ascii?Q?9ULhYQUeLz0o3Gc2lSOnLittPNeFENU7AFz9CL5kmEA0iIMcjxxeB3LS4mVv?=
 =?us-ascii?Q?HAMGeNpCYt5rLUfQPXenbXk77sLidhsTgUxIZu+g9HEQ/oic6tmZE9SboEaI?=
 =?us-ascii?Q?7HnRM3Hpy+UK0ZGRdG2uMzmWgbgymWpPE77rACXJ3JCyXzorCPoFipm8KmPZ?=
 =?us-ascii?Q?qS14cXODyCNBYRhWkcZjRIGdPJVGn1FGLJX7uW45nkXzx1aB4g7kDdgKjFrO?=
 =?us-ascii?Q?O9558f9qqgpAQmC3/YR0G2CoZM7ARanexNg90L3c6lkq3f3kwzvOLd5oWsDB?=
 =?us-ascii?Q?G7ZgIa5Xx5rln965gRW4SMgtOZppD8ZL+2vdKIiZiuaLsrvZLV0shT8NxzkV?=
 =?us-ascii?Q?hcchfNqE37+BMeRpeDfXRpBE5H6CiIAibQBvKCpjsyIrssyLRpsF84GxjJex?=
 =?us-ascii?Q?6clnOb9yaTXAdgXnLxqYs79afLiQA3yit047DFLIBMNo4JsrHtUzGzJll3iq?=
 =?us-ascii?Q?/XEEk/oYqdeyzXro0LdpVqQ+aJnle3MsRtj7CWm+I2fVVGrOgYKCJChJNavk?=
 =?us-ascii?Q?MCnJxZsZ63kwYMueEmrk/ELrI4/0qMgChhEqFl+l?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 86a81174-b85e-4660-9fa3-08daaaa71273
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Oct 2022 10:06:18.0467
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zPDkicl9XxJE2XGAQe5+YP0541pDITgq4fQ8n3saIfUuCEHQBLOEsXRBXQ8eF1xB55tQMEnxLdIzzzqqPRQ86A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VE1PR04MB7374
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Peng Fan <peng.fan@nxp.com>

Per bindings/mmc/fsl-imx-esdhc.yaml, the clock order is ipg, ahb, per,
otherwise warning: "
mmc@5b020000: clock-names:1: 'ahb' was expected
mmc@5b020000: clock-names:2: 'per' was expected "

Fixes: 16c4ea7501b1 ("arm64: dts: imx8: switch to new lpcg clock binding")
Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 .../arm64/boot/dts/freescale/imx8-ss-conn.dtsi | 18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

diff --git a/arch/arm64/boot/dts/freescale/imx8-ss-conn.dtsi b/arch/arm64/boot/dts/freescale/imx8-ss-conn.dtsi
index 82a1c4488378..10370d1a6c6d 100644
--- a/arch/arm64/boot/dts/freescale/imx8-ss-conn.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx8-ss-conn.dtsi
@@ -38,9 +38,9 @@ usdhc1: mmc@5b010000 {
 		interrupts = <GIC_SPI 232 IRQ_TYPE_LEVEL_HIGH>;
 		reg = <0x5b010000 0x10000>;
 		clocks = <&sdhc0_lpcg IMX_LPCG_CLK_4>,
-			 <&sdhc0_lpcg IMX_LPCG_CLK_5>,
-			 <&sdhc0_lpcg IMX_LPCG_CLK_0>;
-		clock-names = "ipg", "per", "ahb";
+			 <&sdhc0_lpcg IMX_LPCG_CLK_0>,
+			 <&sdhc0_lpcg IMX_LPCG_CLK_5>;
+		clock-names = "ipg", "ahb", "per";
 		power-domains = <&pd IMX_SC_R_SDHC_0>;
 		status = "disabled";
 	};
@@ -49,9 +49,9 @@ usdhc2: mmc@5b020000 {
 		interrupts = <GIC_SPI 233 IRQ_TYPE_LEVEL_HIGH>;
 		reg = <0x5b020000 0x10000>;
 		clocks = <&sdhc1_lpcg IMX_LPCG_CLK_4>,
-			 <&sdhc1_lpcg IMX_LPCG_CLK_5>,
-			 <&sdhc1_lpcg IMX_LPCG_CLK_0>;
-		clock-names = "ipg", "per", "ahb";
+			 <&sdhc1_lpcg IMX_LPCG_CLK_0>,
+			 <&sdhc1_lpcg IMX_LPCG_CLK_5>;
+		clock-names = "ipg", "ahb", "per";
 		power-domains = <&pd IMX_SC_R_SDHC_1>;
 		fsl,tuning-start-tap = <20>;
 		fsl,tuning-step = <2>;
@@ -62,9 +62,9 @@ usdhc3: mmc@5b030000 {
 		interrupts = <GIC_SPI 234 IRQ_TYPE_LEVEL_HIGH>;
 		reg = <0x5b030000 0x10000>;
 		clocks = <&sdhc2_lpcg IMX_LPCG_CLK_4>,
-			 <&sdhc2_lpcg IMX_LPCG_CLK_5>,
-			 <&sdhc2_lpcg IMX_LPCG_CLK_0>;
-		clock-names = "ipg", "per", "ahb";
+			 <&sdhc2_lpcg IMX_LPCG_CLK_0>,
+			 <&sdhc2_lpcg IMX_LPCG_CLK_5>;
+		clock-names = "ipg", "ahb", "per";
 		power-domains = <&pd IMX_SC_R_SDHC_2>;
 		status = "disabled";
 	};
-- 
2.37.1

