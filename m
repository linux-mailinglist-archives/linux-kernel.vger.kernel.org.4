Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CEFFA7330EC
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Jun 2023 14:12:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345293AbjFPMMM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Jun 2023 08:12:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54174 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345307AbjFPMMF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Jun 2023 08:12:05 -0400
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2043.outbound.protection.outlook.com [40.107.20.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B9DA30E1;
        Fri, 16 Jun 2023 05:11:58 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CiT7abhuw/o/GFlC62UtjbOY1hbzyWj6uYji+Mw9Zv1mB5YQ6keqkdsh3IFmPBsUgwLsGV13QsJEp5Q9ZWMXNWYdF3MadRrXhH8AT5bplsA6NLC55n8NWRIR2fUfkDKiMlI2jSHuHd64TFjfOQW+WIKTdGXs23cXbjaLTV9p6sbn0V+h0t/c9Vz5oW3rjEmj0QtG0B4odmgD+I0/LntZkslxJ1hwkdJOm7Rduk+Jw3ep31PVv9kI8fEN4nfE2A+r9TtEoFZQSkvv6o8w+okdk+y9kdsyKAjE1z2QrwbPpPke2VoFvxJQ7oyw7o+lwJEONtW/XKLBh3OfuCwNKxvhPQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YHiD77pAAzPBugeWMFhcAYCk1lUw1jKWzJeiBfJPJts=;
 b=jfSyxqfRO6zOJiYzNAtIhKQ0k6ie8I0t8MIYGS0/Z9SyiVkRoQP0hI/GTH1PQGmD3RkV6CApdlrwZHnzTrolRtxiPek0ti2+v3UtEvLj7fT5fXdkX04h2mkxTSOd4spBAnmp43+IzjW3wYom/8B9j1Xckhi8I9YtPO4LzqvyddYyyZ5JR9WZ4+vmMByvV+pj5Jj8yTXBw1ZJ7skqs+NMOmTittjAAF/eedVtcDTbOABVaaOqoMLTrGawGGDKvW7jcpHZb4IsI4TfxpRtPmwNM9iGcG7vqT3C5P0CoWDamTVNzj0BZ8T/eyHK4GksQVrqn5ZikgdCGz8BdnWpw2LRVA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YHiD77pAAzPBugeWMFhcAYCk1lUw1jKWzJeiBfJPJts=;
 b=e4PRXqeWh+xHVMZzA8JyZpZtDpdKCX4Xn0KbKJC0VLpmlvSpFKevESdiCNG6Q7UgYDjCwSwrR/9CY8bZ9k+zPtp0Aq8CIvLT0swp3GyGhab/8/iqlKrAcqqYTdSfzxHUy8GQgxJnNzfmC5JG2sdlgkDMN3CW9tB28Ag7Wn1p4ug=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from DU2PR04MB8630.eurprd04.prod.outlook.com (2603:10a6:10:2dd::15)
 by DB9PR04MB9892.eurprd04.prod.outlook.com (2603:10a6:10:4ec::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6500.29; Fri, 16 Jun
 2023 12:11:56 +0000
Received: from DU2PR04MB8630.eurprd04.prod.outlook.com
 ([fe80::413f:a9d5:4c09:9dad]) by DU2PR04MB8630.eurprd04.prod.outlook.com
 ([fe80::413f:a9d5:4c09:9dad%3]) with mapi id 15.20.6500.029; Fri, 16 Jun 2023
 12:11:56 +0000
From:   Pankaj Gupta <pankaj.gupta@nxp.com>
To:     robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        conor+dt@kernel.org, shawnguo@kernel.org, s.hauer@pengutronix.de,
        kernel@pengutronix.de, festevam@gmail.com, linux-imx@nxp.com,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Cc:     Pankaj Gupta <pankaj.gupta@nxp.com>, Varun Sethi <v.sethi@nxp.com>
Subject: [PATCH 1/9] arm64: dts: imx8ulp-evk: add caam jr
Date:   Fri, 16 Jun 2023 23:10:50 +0530
Message-Id: <20230616174050.644880-1-pankaj.gupta@nxp.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI1PR02CA0038.apcprd02.prod.outlook.com
 (2603:1096:4:1f6::15) To DU2PR04MB8630.eurprd04.prod.outlook.com
 (2603:10a6:10:2dd::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU2PR04MB8630:EE_|DB9PR04MB9892:EE_
X-MS-Office365-Filtering-Correlation-Id: 55405058-a361-4e7f-360f-08db6e62e0be
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 178jGqdC1T2TvtASMMyE6XUfYg6gaUuQGKJIUsyTvA8CUSdJ93rC1BpaAafjPyWJsO/Ymj6pKJTUDsJwPf0a3SBFzZ9uG8n/OLshb32gUtUi4sjDLqKyezs5hfHr188mbsEog3xav/nrbuoOJLmimw07M8b/KTyX/x7cMZtI8+cbtx2oabPhukHPWQiFKOEWK7eSHxFPlc+XG090dd8d9ZLVZsjVoCqL8PYzP9qcPORZB/KHZbnLAOL7J1d7bUKjo7tvjf/wIL3FzrMqvm9PXzDvGRWAJlMVJNWOR/mdAQ0HaFZkj5VhJwRFdXXWL9F7kagmf0ZyPKkDNIQHq0ik8l1d2Uk0+Yv6ZChNGPZBlv4mYIlC6UVgAYpOZy3RiPzxbaK2cYoxOI7fLljfPHlB+uMfqc21/LTiPlvhTnbV71DN7qQeKdUH8R1EyM0Od9s4SsK5yedaaby0Hb4fzPyh1H+T6S5KyZCaGTqRkdq9nWtVEqFVTgax2mlos3xA4ZUw1tbryGrXchPU0qv3nAeJxiWo8Pm0mfV0oeAifeii3mNcdTnh16OpFFsu05A+QwjYS9AYsHrDMcJcs2uNfu+dOTBWYuBJQ03g7JhBKHfLfYGiLtxI6ndyb9PWv4bWJGXfYR21fYLQcvusNZQBPItm60ZxXP8PYHU8IUnEXkc2NTE=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU2PR04MB8630.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(366004)(136003)(39860400002)(396003)(376002)(346002)(451199021)(83380400001)(66476007)(66556008)(66946007)(6512007)(1076003)(26005)(52116002)(6506007)(6486002)(6666004)(478600001)(2906002)(2616005)(186003)(54906003)(86362001)(44832011)(4326008)(8936002)(7416002)(8676002)(36756003)(5660300002)(921005)(41300700001)(38350700002)(38100700002)(316002)(32563001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Wq+KyD+onr0Ff6WgvNA+Ojwm+1STFyOyTtAcrmzFDphJNHHjepyjG1AJaIpA?=
 =?us-ascii?Q?UCyGPhToePFMYE4lO+8pbhZgm5/VQvjPu8ZkLGSw/NxXvAboelm+nTULKimN?=
 =?us-ascii?Q?e9XdSpOqF3YetZi1dNqKzUiLd9sO55m9wskay9616w3bScFGbfQgfa/smjrC?=
 =?us-ascii?Q?OPEmR3p+RPNIMZZHEIg26JQ5ndqrGPR6C3yPGu64dnfnzR9Wz+h7kExEjwaV?=
 =?us-ascii?Q?cO8dKmjudBtlRqDv5r9E1xRETrnLAfzSywdbHZKSVZJF2Xjvii2A0XdrmlW8?=
 =?us-ascii?Q?nWdxxa1cJo/TONOOEySCJ/UtaubROawHfApKFY9LIUDpZxPHd9hfVokgYvII?=
 =?us-ascii?Q?N0jA7bVoRo4Al9i8mqGzgh9YqqrOiruaZ7CQOxnk82ZA9CrZfZnhpbkZBxZa?=
 =?us-ascii?Q?iykSj86MdAT3zKW+J9Cnm0XNiK8wVFEJCuXtdn6tzYNMseZyBa8pRlDy53oT?=
 =?us-ascii?Q?em5/pGn2PvMyJZsTMcjFKAgBkIC7SPa681AR4ymL1pulMg7PsR2b1aM8DlrW?=
 =?us-ascii?Q?S4K8Pv3bS2bnCOPZCA7h55CB0MtoC0HzglDIH4fdgPBb0TlDKoNDX+LE6pae?=
 =?us-ascii?Q?3RBazc+7BUPg5yI1cQgEFf2CpMGz4xtJwWFmTOfxKG+gEaJ/jRxggVgtDKyS?=
 =?us-ascii?Q?XybM2inI4/7yjNo3Gb0CWkaSLKRrExutTNOoYlcmjynLW3Cf02KoNVKDIz5q?=
 =?us-ascii?Q?VWJ8XspvTNoVARYPbcFGdYYN+741K8O5lJkCdzoqJO26K0eZpTzHEeMDytxR?=
 =?us-ascii?Q?W2klh31oWFbH31OREEqYfVUyYLvUhj+i/6rOFeoG8Vm3f33Aid4FAv2PwgkR?=
 =?us-ascii?Q?qEvVU5qQxOU6/fBfurTRRldbp2oLsziFyZgBusv1WWWkKd8hKFl6LpVGZf77?=
 =?us-ascii?Q?ZoOsrYoXnZZxAFjPWVuRVzcf14vbWmPrWi8PNpmEzW8tw1plJsq6XPoXBofl?=
 =?us-ascii?Q?FZt68swC18XgWcSYDzuKiCCOhKHy1oywgccaZoHU0TKPhnYE9y1ogRzMjjoS?=
 =?us-ascii?Q?gQgmwnVVBZvmcMXP8bU/FQlux3+20jjWIQiWPqjNWIp6CzCGvBUda798lqGm?=
 =?us-ascii?Q?+OoCWLotxpeDZiTwH6bDotUHYrnIpmKJyVmNGHYrS1wH08DuIw/q2xyCCpF1?=
 =?us-ascii?Q?tC7i19JyitmeAAoUWr1sZF53lEP3NR+FDqkIbnLia507rgwZJ8x9d+cB+931?=
 =?us-ascii?Q?aBLeUPVkWfiK4lLJEvxsM44zN4F34cE6F/ONiQbtkukZZGd7CTpNHXVHd4R+?=
 =?us-ascii?Q?HgdWTNTEfQ4RzcYZ4O935oJMVC9ELxNYi0P9kPWtuWUPTNtYCnX6YiEBKcho?=
 =?us-ascii?Q?JEkj4bjKmPJBKerqce4ZKu09UV4BQXEj4anKzUeXcFGaXnwAJxLDUsI30985?=
 =?us-ascii?Q?5keNKiKQVlFzHkAZTDoSeX0WLbDpw/KEKVBmEN0yj7DxA8O2j5L30VXo/O6i?=
 =?us-ascii?Q?yvZy3NqAtlpuGQXUSlnoB3CuskaHm4+3pQHdNAAFOeAbK+++ASlv0P+43bBj?=
 =?us-ascii?Q?XLKo8OjZmo5BgkUwUfL9cU/59mk9FoytV3eoghR/5Elhh5hvzyL1LQlWKBjK?=
 =?us-ascii?Q?p+V+fsL+E4d0o+fFBFArCxjGRjyLskMftoNjPXGL?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 55405058-a361-4e7f-360f-08db6e62e0be
X-MS-Exchange-CrossTenant-AuthSource: DU2PR04MB8630.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jun 2023 12:11:56.1458
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: G+RVM/rCdHAcNaOoOK6sxy2ilz3ybr0qCDtr5Rf5lASnJZ1u72DipBACQ4BCK5GjlROeUuHRVNtEjqS66sCNEg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR04MB9892
X-Spam-Status: No, score=0.9 required=5.0 tests=BAYES_00,DATE_IN_FUTURE_03_06,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add crypto node in device tree for:
- CAAM job-ring

Signed-off-by: Varun Sethi <v.sethi@nxp.com>
Signed-off-by: Pankaj Gupta <pankaj.gupta@nxp.com>
---
 arch/arm64/boot/dts/freescale/imx8ulp.dtsi | 32 ++++++++++++++++++++++
 1 file changed, 32 insertions(+)

diff --git a/arch/arm64/boot/dts/freescale/imx8ulp.dtsi b/arch/arm64/boot/dts/freescale/imx8ulp.dtsi
index 32193a43ff49..ce8de81cac9a 100644
--- a/arch/arm64/boot/dts/freescale/imx8ulp.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx8ulp.dtsi
@@ -207,6 +207,38 @@ pcc3: clock-controller@292d0000 {
 				#reset-cells = <1>;
 			};
 
+			crypto: crypto@292e0000 {
+				compatible = "fsl,sec-v4.0";
+				#address-cells = <1>;
+				#size-cells = <1>;
+				reg = <0x292e0000 0x10000>;
+				ranges = <0 0x292e0000 0x10000>;
+
+				sec_jr0: jr@1000 {
+					compatible = "fsl,sec-v4.0-job-ring";
+					reg = <0x1000 0x1000>;
+					interrupts = <GIC_SPI 82 IRQ_TYPE_LEVEL_HIGH>;
+				};
+
+				sec_jr1: jr@2000 {
+					compatible = "fsl,sec-v4.0-job-ring";
+					reg = <0x2000 0x1000>;
+					interrupts = <GIC_SPI 82 IRQ_TYPE_LEVEL_HIGH>;
+				};
+
+				sec_jr2: jr@3000 {
+					compatible = "fsl,sec-v4.0-job-ring";
+					reg = <0x3000 0x1000>;
+					interrupts = <GIC_SPI 82 IRQ_TYPE_LEVEL_HIGH>;
+				};
+
+				sec_jr3: jr@4000 {
+					compatible = "fsl,sec-v4.0-job-ring";
+					reg = <0x4000 0x1000>;
+					interrupts = <GIC_SPI 82 IRQ_TYPE_LEVEL_HIGH>;
+				};
+			};
+
 			tpm5: tpm@29340000 {
 				compatible = "fsl,imx8ulp-tpm", "fsl,imx7ulp-tpm";
 				reg = <0x29340000 0x1000>;
-- 
2.34.1

