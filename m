Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 318A573CFD8
	for <lists+linux-kernel@lfdr.de>; Sun, 25 Jun 2023 11:54:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231979AbjFYJyw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 25 Jun 2023 05:54:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46394 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231960AbjFYJyt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 25 Jun 2023 05:54:49 -0400
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2077.outbound.protection.outlook.com [40.107.22.77])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 035C918B;
        Sun, 25 Jun 2023 02:54:48 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hHHdpIzX0Fop37YTWknfjB5Z/dXU4Z3KgwjkBqeieIkPYvW4SeL1t7/0a0v2oZ+BGOtwx5c7ugsa02DZcwr2MYLKq1wVfe9RHQy92Gdtisfkz/l0/O7M/38QNwkIku+DM7yaO3krfckfUH6I9SJp9jpCM4io774EcMRZNpML+ZUlZRI0l4dkim0iZ3XpD7sn5lKHgJ/8CeAJ7e0bbaJ4PtDZZ+1QlkqMXIP6ziXxoZD7hdBctwpUHOAkA/nW45k0UJ19wbMg/oLXlk0r8+2hJeZMxbEr8z0ktXEWJYGQOPRpKSxYz7UJ8v49w8KvOTYZX2lGoZsC8GhZ+oJtmDw0gg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OhvUNmnMvvHvCygalaGDXqwurZdsLRZqdkFH73aaxos=;
 b=cOpm/fjMYzGsuHPQSXmW6WPDTPEeVWiKRbOUJUvPDUHHbpWN2GUODinCGmldqhjUd335u6MfHUuKcZ2m1+oNbA5W7nAGbHhOzuO7Su4ocnLJ4jkzzMZEIf3QNNi2UX58zCuaWOPT37kItLdR+7Lw0ILq73t03cp6Bxg93Riy+fai2VmT+9qA68HcCDSlkgUXPEFIhEIi3dQZl9/t294iO+r5bM7v2DBPeZI1ePteqTLWW0w4K8NeRnAumGdBna4K5hKBN58Jb8tjuyW96m7+IPIxojYmsYu+/bKKfIq5ldo2o9G3N6j2cn+fsKhA303NPay+MKxhOq2dQlF8Xl3eVw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OhvUNmnMvvHvCygalaGDXqwurZdsLRZqdkFH73aaxos=;
 b=SrmOBQzHKKsyOzKkWf18/2wQD9Sc1coqOC6SGDnbffv2gEcb4BRE/DutFXmyQa4BFKFuib6XPV+ynRlxdpyvXO2wSsjiIp1Ojbn6c5H//2FBn/PLAMlQMMen8fVdI+D5wrV4WGuSb6xQpIATbOl3vj/FxevV1wNSl8v9rK9+Wvk=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AS8PR04MB8404.eurprd04.prod.outlook.com (2603:10a6:20b:3f8::7)
 by PAXPR04MB8816.eurprd04.prod.outlook.com (2603:10a6:102:20f::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6521.26; Sun, 25 Jun
 2023 09:54:45 +0000
Received: from AS8PR04MB8404.eurprd04.prod.outlook.com
 ([fe80::ef9f:1e01:e8a:6a4a]) by AS8PR04MB8404.eurprd04.prod.outlook.com
 ([fe80::ef9f:1e01:e8a:6a4a%3]) with mapi id 15.20.6521.026; Sun, 25 Jun 2023
 09:54:45 +0000
From:   Sherry Sun <sherry.sun@nxp.com>
To:     robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        conor+dt@kernel.org, shawnguo@kernel.org, s.hauer@pengutronix.de,
        festevam@gmail.com, shenwei.wang@nxp.com,
        gregkh@linuxfoundation.org
Cc:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        kernel@pengutronix.de, linux-serial@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-imx@nxp.com
Subject: [PATCH 1/4] arm64: dts: imx8dxl: remove "fsl,imx7ulp-lpuart" compatible for imx8dxl
Date:   Sun, 25 Jun 2023 17:48:54 +0800
Message-Id: <20230625094857.29644-2-sherry.sun@nxp.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20230625094857.29644-1-sherry.sun@nxp.com>
References: <20230625094857.29644-1-sherry.sun@nxp.com>
Content-Type: text/plain
X-ClientProxiedBy: SG2PR02CA0126.apcprd02.prod.outlook.com
 (2603:1096:4:188::11) To AS8PR04MB8404.eurprd04.prod.outlook.com
 (2603:10a6:20b:3f8::7)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8404:EE_|PAXPR04MB8816:EE_
X-MS-Office365-Filtering-Correlation-Id: 4049d090-8ecf-4f2d-d571-08db756234b9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: jMs/CYGpcHI5dWsgRAIiVwQiJpXfwdP2mA8cm+47qU33DbQceiEw1H90+r1WTeTURkZ4O5uK1cg+TWhPDcDKExk3dlwyP9pjY9s/aKz9J6oYGKRFXSA5u+AEeliUPI88r89zNXpNsL/rUbCBIzRa0HHWKxCl1J2e0dj116gyAi8/C43OzcWFd+t8c4fzHWakKm+1t/8jTuqdYhy+33HX7aW7oDOms/DRkYUEp8tyrQbbuQAiWUMnTjr0ovQarO1z6HHsFDloMBJsT9gDm8GSZZaXDLDtkKtOQTHeqFpXqlkU0xF5hvZdpmDDGE81RpmnIX8s/1vrSBrCGudXiWreh7mQ57F5rKugGmxkeE8d/jjqolFMLpTxtPO9nQ/BkIYA/XSpBJ2x6PiaukuWX8ceQWIpiAT5fEiwixuazW/w7kzy0BC0zraNphLoIaY2ae/ECEzu55TXYtFT4LS8alXJ38sUxO3rZnxpOKlIGHFtb08zn4agFUDLk56NOTf1cUCbCs+XE3CuiDsd7EA83RvK5w2+v2VxlLhjpA60XHfPoMyRPGzv3RZOIm8pNEiSpRyTHeu1CDp/hAauk9gdPpGqiju/t/UiluSzGpCPb86WV6qgM7w6ICftjxzqA160N2BWbOZdYaWTfXpAc27QQVNHiw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8404.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(39860400002)(346002)(366004)(136003)(396003)(376002)(451199021)(26005)(36756003)(5660300002)(7416002)(44832011)(66476007)(8936002)(8676002)(41300700001)(86362001)(316002)(66556008)(4326008)(38350700002)(38100700002)(66946007)(6506007)(1076003)(6512007)(2906002)(6486002)(186003)(52116002)(6666004)(83380400001)(478600001)(2616005)(32563001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?2kst42OHCVZBbTmK+hZ4XHjWjrXmYT0XBdG+VVFj8IeOup8wrTIXHiJX+ptT?=
 =?us-ascii?Q?wXUJoH6KBZBvmeymogDHbl0HQeuhWT0XxO510aP6L/W1yKirYWNJQ1S0QYIC?=
 =?us-ascii?Q?woIDsdNTf+twS9kAxVkQ0iVdhttzIwYEuslqUDE43nAz/pOD7qpws1QuNK1w?=
 =?us-ascii?Q?+qs7JBPtP9KUOhjQOUQM2za3mgfEhAYoe2YurQueZmBsMNACmeGe8tNuk5wF?=
 =?us-ascii?Q?qVwk8kn4+ieEvTJryGs8bZVpmhdLiIbEJGiU7rCOgAz30ScWjohIyiB6lqUl?=
 =?us-ascii?Q?urC647CrQdKN/mQOWqfYcBFMlDObAnu8OakNZrjg3nYjsUbPAebeo9NhbV3s?=
 =?us-ascii?Q?ZfLPuZQt7jBKp122XyVaPRkBctl026pqeoY6akuyCMgxFnM3nz08HQ+eW0D/?=
 =?us-ascii?Q?HWoHqa7h773LVdDEqoQq49JZ+GJqyoa7VrPbaa4eV0OwTEhwFT1rSRTal82y?=
 =?us-ascii?Q?K10s4FEKWsifdQH212P9UKUFyOy2yVfOrNljtlWwOK6JfyXHUiYADyYQ1sZb?=
 =?us-ascii?Q?SFUOTZz6P5kqO6526J+DrHdPFvEkMmnpBUNmMQARjU/gjmPCCtDWzwwfuw57?=
 =?us-ascii?Q?ptZG9DvOAP6b96+GfweZFfTi2KIn9xgP1BXRlGN9VIsIhSN5G0r6khv154ja?=
 =?us-ascii?Q?DRA1SpQ5Gv5HzZ5sDKRzbc7oyLjSENeQOPWw5iDBoyrBuXeadaeV1vx187Oa?=
 =?us-ascii?Q?85748VA2VDMNiZlSviyScLse+0TyQsxQirEWyuld9SvyeLbthg8czjXfCAvv?=
 =?us-ascii?Q?KweB86dpYNwULDJZSyZgKQ+fBaKJLORViEHC1un3Kl+ld+I8ndNiPK2F/3SA?=
 =?us-ascii?Q?ADa9tgcEhD98uamtQCZEplElmXKiypNEdNTVHcGerSPsxa/s3Fqd23E83wto?=
 =?us-ascii?Q?uP7uku24sPOzf3EuDw6IiT7J/iW5DnHzpQu7Wu/wV/z2+MhhBcz99MzKL0v9?=
 =?us-ascii?Q?DoGgApulcktqNFQkAXVKJHLzcb+FOrH9Eu70NJL6eGLhCy8XrOSsSaBgG7F9?=
 =?us-ascii?Q?oWuKjtBx0h8ijuzMOVQEK8jp3hmUV/b/nyX0TGuk8evl1xrAYSozfyAtJfFa?=
 =?us-ascii?Q?qCzesdOGAyDuyKz97I0hen+EOZKT20+hqtYxkY/t1ZdChCmQoLH4+NE60zGI?=
 =?us-ascii?Q?sGBE4aIv15ziXJ6QrVQGoM08ErlxI2EY6V3DCfVnvNf/Lzy48l6XBBHsr1Gi?=
 =?us-ascii?Q?Wmo6qauKUynIVdyBCu8FLgilq0cXvCB11aFCEKHrDPWQMDK8XOx0+PqRugOy?=
 =?us-ascii?Q?jfD2DS7gyr3SkfZHz95SOxb+JiWOlhSgAVfpZbL8QkwN346ewMzz+jgf4aj2?=
 =?us-ascii?Q?X8AlE85oQLOy+ejl1nRea2ZaHkTqE8qg7zfyWJdpJ4fOz3/4iXt0FsTDWg0p?=
 =?us-ascii?Q?v2FH90wRfIQRs9T2M0jzzE6isjR38DKd+kiNsYM/V+WkqcWRlo29Ia7SJtg6?=
 =?us-ascii?Q?vPUg843reNQoxpO5AI3jO/fm5+qFXLsv6kN66hS2S9a7JiSWA/thoKDOWxll?=
 =?us-ascii?Q?vV+ZbVUl/71kWaUQ0VmmB6/0FidjI0KCrhwj92nn1hDioUfDMerYiZ7zgqsq?=
 =?us-ascii?Q?ZbnVBV5rIG23MBEclNw2blz2kp4FYlETzOO3Ey7V?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4049d090-8ecf-4f2d-d571-08db756234b9
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8404.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Jun 2023 09:54:45.6808
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xDehR8p96PyHWsefOK8OaKh12j1BPVuQB2q8acc+QJN+ZBg62T0lLg6ukOnb6ft4CMQ/+4OSdsyNZwpDmUggsA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB8816
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Drop the i.MX8DXL backwards compatibility with i.MX7ULP since they
differ from clocks handling point of view.

dtbs_check has the following warnings:
linux-next/arch/arm64/boot/dts/freescale/imx8dxl-evk.dtb: serial@5a060000: compatible: 'oneOf' conditional failed, one must be fixed:
        ['fsl,imx8qxp-lpuart', 'fsl,imx7ulp-lpuart'] is too long
        'fsl,imx93-lpuart' was expected
        'fsl,imx8qxp-lpuart' is not one of ['fsl,imx8qm-lpuart', 'fsl,imx8dxl-lpuart']
        'fsl,imxrt1050-lpuart' was expected
        'fsl,imx8ulp-lpuart' was expected
        'fsl,imx8qxp-lpuart' was expected
        'fsl,imxrt1170-lpuart' was expected
        From schema: linux-next/Documentation/devicetree/bindings/serial/fsl-lpuart.yaml

Signed-off-by: Sherry Sun <sherry.sun@nxp.com>
---
 arch/arm64/boot/dts/freescale/imx8dxl-ss-adma.dtsi | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/arm64/boot/dts/freescale/imx8dxl-ss-adma.dtsi b/arch/arm64/boot/dts/freescale/imx8dxl-ss-adma.dtsi
index 6881330ab4c6..e2eeddf38aa3 100644
--- a/arch/arm64/boot/dts/freescale/imx8dxl-ss-adma.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx8dxl-ss-adma.dtsi
@@ -36,22 +36,22 @@
 };
 
 &lpuart0 {
-	compatible = "fsl,imx8qxp-lpuart", "fsl,imx7ulp-lpuart";
+	compatible = "fsl,imx8dxl-lpuart", "fsl,imx8qxp-lpuart";
 	interrupts = <GIC_SPI 228 IRQ_TYPE_LEVEL_HIGH>;
 };
 
 &lpuart1 {
-	compatible = "fsl,imx8qxp-lpuart", "fsl,imx7ulp-lpuart";
+	compatible = "fsl,imx8dxl-lpuart", "fsl,imx8qxp-lpuart";
 	interrupts = <GIC_SPI 229 IRQ_TYPE_LEVEL_HIGH>;
 };
 
 &lpuart2 {
-	compatible = "fsl,imx8qxp-lpuart", "fsl,imx7ulp-lpuart";
+	compatible = "fsl,imx8dxl-lpuart", "fsl,imx8qxp-lpuart";
 	interrupts = <GIC_SPI 230 IRQ_TYPE_LEVEL_HIGH>;
 };
 
 &lpuart3 {
-	compatible = "fsl,imx8qxp-lpuart", "fsl,imx7ulp-lpuart";
+	compatible = "fsl,imx8dxl-lpuart", "fsl,imx8qxp-lpuart";
 	interrupts = <GIC_SPI 231 IRQ_TYPE_LEVEL_HIGH>;
 };
 
-- 
2.17.1

