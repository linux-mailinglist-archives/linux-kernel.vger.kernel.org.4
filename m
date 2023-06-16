Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B61D7733174
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Jun 2023 14:43:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345330AbjFPMnN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Jun 2023 08:43:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40646 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345267AbjFPMnD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Jun 2023 08:43:03 -0400
Received: from EUR02-AM0-obe.outbound.protection.outlook.com (mail-am0eur02on2079.outbound.protection.outlook.com [40.107.247.79])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B184D30EA;
        Fri, 16 Jun 2023 05:43:01 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MbYLaPZBkNNrmSq9HW6OD/C8cUNGxQ/CPK52z0lpyESCm5+BRZEtTBVFpxcjrSCDjuPAyDUPKqW2ZyxzdycLVMra0VMA8gb80T9t3fUCVp2wc59ulgVRDEu8K4t9fNdcrC8moLdUklEECNy91v8GxlqAxipn/Pq3ZE85UhnkQ5vEo8GpYmjLfSmh8EgrwQuJc6GzpO2wpZjAkLuoTnXSx9dzJ3ESVBy2yjeNOg4KeqUY20pJdUzer/XRs0D5EgbYv2XbJ7vKFlREr5+z0OixToas9luluJr94QQ6YguLVO8bpemh3YCI5b+2++qrzMz4Dj1AYy9evePHFTU3teQJqg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qU/hXQmbgoFBqB7do2xjcaTLcO9DvPxSQl+o250+gcU=;
 b=oCLmpOqMD7z1Xm90KN8WlTAfD9wmGwWYjs+r7xDiv+ylw6ouqI4/qlRtTSoKpfpDSb9vQ/xcuu3kYZeLUHEopeM3K9FyqRElfQDOOw6ACCOiULF8QUndPbs+qwmSC5KcIywtEAdnMrNb5o6xLvLhS2dHdJdcjP2BbzQ3Q2sK3HoX9EZZzcZKUSATCrzuAc4HDGn2w8AC6avW57K01N9uc+WjzwCuc149Fc1OeBTtXl0Tl65gMlIxvTWLjzGqzWjLykOpkS3n38uugezGJ/wrH3KQoSTFKOYHta2RLPfnnlBSNsNiGx04bXgsNCwtUhPkpw4FnCZh8NcTZsos6KOITQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qU/hXQmbgoFBqB7do2xjcaTLcO9DvPxSQl+o250+gcU=;
 b=lNfC1/mGpfmglmsHUO30tl1tqD/2kJGE6po3A53j8Bb9VT8hy/VIFLrzoGdyd963Y77weii2UnezpXlhflS2U+lqf4NuSWiAqxHU6coBAXwnMaZu+Ttwqp9VqM9+eCUHTtbfPgcrKC9tnorw6dgun60M4XWwE9FssnQXd/bPcKw=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from DU2PR04MB8630.eurprd04.prod.outlook.com (2603:10a6:10:2dd::15)
 by PAXPR04MB8320.eurprd04.prod.outlook.com (2603:10a6:102:1cf::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6500.25; Fri, 16 Jun
 2023 12:42:59 +0000
Received: from DU2PR04MB8630.eurprd04.prod.outlook.com
 ([fe80::413f:a9d5:4c09:9dad]) by DU2PR04MB8630.eurprd04.prod.outlook.com
 ([fe80::413f:a9d5:4c09:9dad%3]) with mapi id 15.20.6500.029; Fri, 16 Jun 2023
 12:42:59 +0000
From:   Pankaj Gupta <pankaj.gupta@nxp.com>
To:     robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        conor+dt@kernel.org, shawnguo@kernel.org, s.hauer@pengutronix.de,
        kernel@pengutronix.de, festevam@gmail.com, linux-imx@nxp.com,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        gaurav.jain@nxp.com, linux-kernel@vger.kernel.org
Cc:     Pankaj Gupta <pankaj.gupta@nxp.com>
Subject: [PATCH v3 2/7] arm64: dts: imx93-11x11-evk: added ele-mu
Date:   Fri, 16 Jun 2023 23:41:39 +0530
Message-Id: <20230616181144.646500-3-pankaj.gupta@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230616181144.646500-1-pankaj.gupta@nxp.com>
References: <20230616181144.646500-1-pankaj.gupta@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR03CA0100.apcprd03.prod.outlook.com
 (2603:1096:4:7c::28) To DU2PR04MB8630.eurprd04.prod.outlook.com
 (2603:10a6:10:2dd::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU2PR04MB8630:EE_|PAXPR04MB8320:EE_
X-MS-Office365-Filtering-Correlation-Id: def2bccc-030a-4f98-6a8a-08db6e673747
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: c9REVDW9EbwzBjT9iUtAjZxQHjo03IROzl8HSQmjQrTr49DISr2wFQU5E/P9EraQENW5xqn6h7Uyiaj+xBgPxgerI6U5haJg9DLvTJfn/+AtF8bLnC0P7kN4eCyTHytLVisXzP2hM6vJTT4WhXAgmYA32F6gnxeuecy3svaYTyXcmxTUnvly4OTfbnmgViXj1/UPO92tGoL4LsGJrf73OfcZmqUYwedptVEnimMVzB7pIwcPhkqjZWAIp/zZkp9ge+Tl/V5SiLtkkcaJrJWwLSc1OkpIY6hxqhZQLv+dQnihAv2CVKHRvKxbv62hLmXGEl3KH9zPXzvxQTZqWc11L28lECrRsLQIiQ3gBSguBg+sht7UHbWpPF33jqzNYVrXDCGAxIodxuc647ExZ2/EhTjSa+omzM2LY4HepKYL4edEQFCDCoEwYuqWetjLTnbvkVk6kI3cO38BwFwu3zAPlwx0H4nhEm1UrcdlIeze6/RwshNeyc75/mzG1AovYVCfOD+1JsXTouPu0MX66o7mBqRoN4Noqwp0my+EX2QXnPnvV1LufdT6NU1+1XKJBaNqziib+J6Lt4ek9H8YQI0UpkYntrnxmysVB9ea2bSnZCLp3oHIVnk1a8jXfozcX9GToaTcvcUQLINYjDJKuGJuwA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU2PR04MB8630.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(346002)(396003)(39860400002)(376002)(136003)(366004)(451199021)(5660300002)(478600001)(8936002)(41300700001)(8676002)(316002)(6486002)(52116002)(1076003)(6506007)(7416002)(44832011)(186003)(6666004)(4326008)(66476007)(66556008)(66946007)(26005)(6512007)(2616005)(2906002)(4744005)(83380400001)(921005)(38100700002)(38350700002)(86362001)(36756003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?BGGjDVuonOynVwDNZv8FT2mXMDQnu0+XhaGBpszG7Tn/H3HarSHGgWOsyOtP?=
 =?us-ascii?Q?2whkKlVSTohSbC5oUcpmP5mejKOeaXFGAbTyvvK94aC8JrkhdFN1ekZDkZBs?=
 =?us-ascii?Q?etEn4Jv/Jen9rZ+F8y+7EOu239qBMcAl5uf6sr0zZ46XiT45GaWLn7sVtj5U?=
 =?us-ascii?Q?xPSu/A0AATfNLzE0wCnDaGlRxZeVOJdxzTPzjfLjI0kv1Fed9eSDphnpTdjo?=
 =?us-ascii?Q?D4MNajXUZtDKhKKlEJdBq0runx03JENW1H1vzLYmWU8sevN+pR8OHSzFDvFz?=
 =?us-ascii?Q?LjYZ69Q6XeU80KrvHwnOQD7+kzJXmvgbHlh+RMtZU/sINNlP0CVlPPzlYMQo?=
 =?us-ascii?Q?ZTBeCLAKAIETcK8oSaAz9vMfhmMKhmKrDfbEqil1Us1VBREc9tXdpPempgYK?=
 =?us-ascii?Q?nUaUwz5FEijtwiuW+l0TaUOOjJMiThI+XcoUWJCE3BYdimuoRsIr2T7GY1M/?=
 =?us-ascii?Q?oLFIVD+LEQP3VZt119c5pNVikJ01nkkFMTBaUuD7Or43aSY7oGNt825SZK7u?=
 =?us-ascii?Q?hajetlc1wXdAuezyzHTiUqh/qryqB0A+z30KKlh0Pk3/WZ3fzkEOxhFdCzvD?=
 =?us-ascii?Q?EHrPaU0zn12tuZIdabIGoVgpyEnrMFu8tyr4dufbDADG5LynUpFuE5lTG76Q?=
 =?us-ascii?Q?dEzMtm61AqQW4MgDAZ7dMS+msTTesPr3HCNe24+9HYo7KZbTmBlJ4VRYr3g5?=
 =?us-ascii?Q?48Uz8JDgUbjkmiW6FW5+YMWia1eLziRaYAA6pMBddbgueP9RQkszO5vGglJ7?=
 =?us-ascii?Q?dZQLTZSNr3Vr31YBNuT6WMx9BzjKUoj0K0+LNyEUkuBe4sFIFJzmn39BrHVv?=
 =?us-ascii?Q?XngAczXvxAM6zWSnspetcU3xVAQmTLVV2Qaq7qU888Kuvho4qh0Q3A4cYKXH?=
 =?us-ascii?Q?KccVOVQSx6ThHXS+Xra3+FmN6LH2eOo11j1T33Ybg6xSyiib3TsdxmqDTl6n?=
 =?us-ascii?Q?tSriAQgdQAQ4tUfd4dhdiOwYS9FtSjZWuzOz4PM3fVguRhtryLC2sMleGPWP?=
 =?us-ascii?Q?PO7JcAEVwzOMUzm9/j48ayzIJry3BiqGpO+EhejjZstlQOZwuhmJyGcm+CJ+?=
 =?us-ascii?Q?pkeUJLnOmeyNbIeQ/ykrL+Vr439a6pOjHDUsCn9D8yomwQRa1hIOepGTiAx9?=
 =?us-ascii?Q?IeUrMqeqpSjIgJrcHEw/Rjvl6YIE1aTknP2Tk5ixXZDH+cF8v9U1d2YLNkJ1?=
 =?us-ascii?Q?MzNI3onpZ/1Cpz46O8Q56ddyJuC0NE5R67kjeDyjsKJUisXEqxlbq7zoTjr9?=
 =?us-ascii?Q?sz9Ejoo4EJX/+9JY+JLdgAlbpbMtX0SfvVKyWs7/eMSb1cZA7olRo/5mrzTx?=
 =?us-ascii?Q?KEVUlTUfvhTVTpANX94K68OO87hAJkB1Quf2byEQVKFjw/xVi5JN7wAUp3Ah?=
 =?us-ascii?Q?yumdY4PHTHO65Os19FuLHHlR/so82xrYJmK77gM0Ku2r7l7hD7HCGqHh8j2/?=
 =?us-ascii?Q?hZb29ufFgTfBAp8qXmpdkRm8FGDIE09bRHOzxk1LT7FeFg/Yzj19U/8oHTz2?=
 =?us-ascii?Q?LdeKjV2cEAicYICjGAzpX7SlTdaoG7OnlBrZb17pmHc6En9woTFdoPipFMNn?=
 =?us-ascii?Q?D2+UxO87LZiI7WGDfSpTuUyH/ARWOcB6CDeJ21lq?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: def2bccc-030a-4f98-6a8a-08db6e673747
X-MS-Exchange-CrossTenant-AuthSource: DU2PR04MB8630.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jun 2023 12:42:59.4413
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: OeXheiLd54x79sfJvl7/UVbnR4WwjBXR5bufKGVY0mH2LVAPXjKCqETi32YT5D3zIOuzvAuxakCzpGXoxbwwmg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB8320
X-Spam-Status: No, score=0.9 required=5.0 tests=BAYES_00,DATE_IN_FUTURE_03_06,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

adde support for ele-mu for imx93-11x11-evk.

Signed-off-by: Pankaj Gupta <pankaj.gupta@nxp.com>
---
 arch/arm64/boot/dts/freescale/imx93.dtsi | 12 +++++++++++-
 1 file changed, 11 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/freescale/imx93.dtsi b/arch/arm64/boot/dts/freescale/imx93.dtsi
index e8d49660ac85..03ee20cf74ce 100644
--- a/arch/arm64/boot/dts/freescale/imx93.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx93.dtsi
@@ -1,6 +1,6 @@
 // SPDX-License-Identifier: (GPL-2.0+ OR MIT)
 /*
- * Copyright 2022 NXP
+ * Copyright 2022-2023 NXP
  */
 
 #include <dt-bindings/clock/imx93-clock.h>
@@ -788,5 +788,15 @@ media_blk_ctrl: system-controller@4ac10000 {
 			#power-domain-cells = <1>;
 			status = "disabled";
 		};
+
+		ele_mu: ele-mu {
+			compatible = "fsl,imx93-ele";
+			mboxes = <&s4muap 0 0 &s4muap 1 0>;
+			mbox-names = "tx", "rx";
+			fsl,ele_mu_did = <3>;
+			fsl,ele_mu_id = <2>;
+			fsl,ele_mu_max_users = <4>;
+			status = "okay";
+		};
 	};
 };
-- 
2.34.1

