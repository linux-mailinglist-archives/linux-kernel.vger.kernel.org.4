Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 40EB873D101
	for <lists+linux-kernel@lfdr.de>; Sun, 25 Jun 2023 14:38:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232262AbjFYMin (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 25 Jun 2023 08:38:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58414 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232210AbjFYMil (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 25 Jun 2023 08:38:41 -0400
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2048.outbound.protection.outlook.com [40.107.22.48])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 129B41990;
        Sun, 25 Jun 2023 05:38:14 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=E4F+FuT+y6YQpChzfS/MX55rPLEXGIaVKUpg7Ov0h8z/YtHDyCwv4ZI96kZGahihnbbWHJy8pNjXtF5L5OFHiezqd5rhE3UviB/bTLaGm/7qG9KsIHqoG13W723gzmYjk+MqEc0i3Z4ac1eFVEU9BIOOvY8pUc7GcPP+IMUkYqiQkVlQaNcjewTXAvKCXRGCuE4k5p++rkrBJ2xuEneg7FuBVwTcTXewj67jT+qGUx2OIAoz3GwhFz5PyXQtAC3HaE9hHbsHE0/6fPB1pfGEgvcyZbYYQZ/U4EfsmCYRZUuu7lFNSkYLoOK9/4RiTDftlwgZvKPEAmCoQA+JumCCeg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CC0IUbqrGmwoVFSKwLQLjZ8Jajuax5+buZ+hpyh1cT8=;
 b=Tw7WWpKWxPxyMVJNINA70wvI6KlNBJpoS49YfiqkSelL67ygqAOfGXZQ07WL9wu/p4PzG0LPB0BBGVNO/UfjhX/sRrXFgjymBECELyYNxezUhYrXKTHj2v/luHGipqs0p9rNOyfpwRikPIiIPK5dbiQr07M59GejCk258hegExzdjjpMxQEMWkrdME43LNnX/uAL7q0LUccQzXh+vZpgbeWSuQgMEqpmvyUGiAgn95J9Q4TmfHpiqKcOtgOOmTsp6s6g7Jjvx0bLm+JdvbmbaHUwnLWY6P5Y98r96p9PTmk/asaBbia2z/qdEzZ85kUxo7wyYPN+Q8kHWAeOrpDG0w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CC0IUbqrGmwoVFSKwLQLjZ8Jajuax5+buZ+hpyh1cT8=;
 b=Dc+0j+WkngRNsP6DnUKn1GmRyB2RSsf9cxFR9lfq2vk7XlyotGTgUJeB6aqR+qcUu13oZ/gr1MoHJDi6Xws6jZiz+pHROYHklCVPYYblbMGB0mjWRZ+VceXqoTACqCOPw9sd0Ri81liU2cX3TWs59miZMu3efOWmlrUY8uCUmjg=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by AS4PR04MB9314.eurprd04.prod.outlook.com (2603:10a6:20b:4e5::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6521.26; Sun, 25 Jun
 2023 12:38:07 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::efff:43d6:6f46:eea]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::efff:43d6:6f46:eea%7]) with mapi id 15.20.6521.026; Sun, 25 Jun 2023
 12:38:07 +0000
From:   "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
To:     robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        shawnguo@kernel.org, s.hauer@pengutronix.de
Cc:     kernel@pengutronix.de, festevam@gmail.com, linux-imx@nxp.com,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, Haibo Chen <haibo.chen@nxp.com>,
        Peng Fan <peng.fan@nxp.com>
Subject: [PATCH 05/10] arm64: dts: imx8ulp: add flexspi node
Date:   Sun, 25 Jun 2023 20:42:33 +0800
Message-Id: <20230625124238.4071717-6-peng.fan@oss.nxp.com>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20230625124238.4071717-1-peng.fan@oss.nxp.com>
References: <20230625124238.4071717-1-peng.fan@oss.nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR01CA0111.apcprd01.prod.exchangelabs.com
 (2603:1096:4:40::15) To DU0PR04MB9417.eurprd04.prod.outlook.com
 (2603:10a6:10:358::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU0PR04MB9417:EE_|AS4PR04MB9314:EE_
X-MS-Office365-Filtering-Correlation-Id: 8b320d89-291c-4acb-de66-08db757906fa
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 0Ze9XIeglKfej6yGQ2PqroT1CrLkcwwTMwRMBDL+4SBNrceenkemr5qSVYEe4sKoe73kxQaOsWneT9ddFfaCFpa6yGvKdcKzT010XFRwk4lk9SRvR8ZCW0vfCyzdwK/iey0owZXJJPB1vH35ZJmqy0JxRiNXuhjtLTnfJ44MuyEM4VHQ/Vk+7vsSjgpoBS8Sol4wvY0gtOVCLl0nEUbmvnQujfD8WvSd+BQiuFZLTf1I0fqhuOg3R5DYXyYSu4HDyU68Sk51wL4AvUxTarBcxkGzne0gY2ugGS0LP4l1TTyxoAxlnVkWA/c+fITseGnj8TlS+kpLmWIs1IzHOzuCgslYMaFXZBNmt2S0ikk0j+cWKYIMfLDNUlovBibOq+KENu4JZtuhbAl8Mzoz3+SGH4SI/QWY9YKY8fy9UdWQpWMq64H1fe6ir1H5cvlpQDyR8t/02B/yzEk/7yIibEU28DabRoE+RE0eN6zKPY9YLDyUAI38BqQhaTteiRGcbtJu7zdLekVxURNbjdSWp9q7YXrIXb8oet3JK6ppKUGn1NlaPWi5/DkPP/AqfE2OgppzLblUHf+V5Ei/JL4HqZnWp+smTWMqJjM3W20E6pEyI13sHZEmTvC8XiJtmN5TSO6xkUTDdM4K5qFoLKiOKxP0rA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(396003)(346002)(136003)(376002)(366004)(39860400002)(451199021)(5660300002)(4326008)(66946007)(66556008)(66476007)(478600001)(316002)(8676002)(8936002)(2906002)(54906003)(86362001)(41300700001)(6486002)(52116002)(186003)(6512007)(6506007)(1076003)(26005)(38100700002)(38350700002)(6666004)(83380400001)(2616005)(32563001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?MgWyQwQQzaoSBE7dXNELJruoZbatIPWHR/GmdT4gF5UHAdNOlYRs+3dIWOBg?=
 =?us-ascii?Q?6Uubu8bv5BSTsMKul+UVJvDyF911aLgSloY6LxZmXIQV17UWyiHsTr83ge2b?=
 =?us-ascii?Q?vNDwLpH8yHji5cJPYFc6Nlr6BX2iSF/VYuRyHWWasGh6XlN9fVYEBjEWwEpF?=
 =?us-ascii?Q?kxAbGEpirXyTZpUXkOo7QQfFXtKLDI8ajKDVqvi5LpvHNNf9/dkwZ9odDD5c?=
 =?us-ascii?Q?Qe/gsmjEe8iUBnPU8rU224BZJMYfYuzDiVSYyuF1mTnQWNbYLft0uekVzQvH?=
 =?us-ascii?Q?6IIJnL9RgE3hZJVGW8q191PMAoYTwpf2kV6S9CQ+uB0iCEqxtzDKqpR6a0Mf?=
 =?us-ascii?Q?geF/ZxQd/KL3q4rNnhXSAH4ecDjBGGtfZD9gm/XgJ66NeRau0UKhxC76f/P1?=
 =?us-ascii?Q?K8fFnvtfAYVDqE6TAekq2uKibZli28S8CVqlLJ+S9/eR25ehlqBmIdMJazcq?=
 =?us-ascii?Q?STBwyaZlQNDtphzVzgUaZciVG1o+ee4G0hZ8aD+petWCyUk2koWJXqtzwqsv?=
 =?us-ascii?Q?SBoFUWNdKsyJ7Tol87lz4quoIkKx4CJLLbWNezoc1l2qohOlAUlovpb0XdaO?=
 =?us-ascii?Q?Vn7BZytLZAk+xazRWiyAiicjSNPXPJKZZ+EOG9FbrKG8uFcIZs0+34NHKspe?=
 =?us-ascii?Q?LS/w9MYqj94htR8/rSY7VFE7UkIfp10W7nn7O7BkqBPs/M3IfKnwOzzNzmRn?=
 =?us-ascii?Q?i24SckxqMrJdIXo01Hb/YkgUE3Wbwn2D/AhVZxwnOhZPVH0VmBj3iPN0nNX9?=
 =?us-ascii?Q?ONE1Sq+m+jg/x+Rbv0MjI/otlWGg5a1mzsPrA7VmaRweNEz8lJQzk4X3zi40?=
 =?us-ascii?Q?FDDidWNnm+wOLhWYA77WGzEbzfVnsC5ng3VMUQ+YtPuRaxFWlVQzyMSU4MvY?=
 =?us-ascii?Q?OY+oNKLBU+VDtto11+RQu//qsYl5KWbu4xeyXLuZioRael1vFMaS2tMMpVrf?=
 =?us-ascii?Q?6tDouRIH67NUG6egXf7MpmKO66IaYHqdfeXMqfMW0i9knerIXdRNV6vPQQLf?=
 =?us-ascii?Q?lE7SoR6yjAGjTUUyFryRe/jt5vWop4XqOYjBKtSnoPfTtIa9Z0yqh1HDNmZI?=
 =?us-ascii?Q?tAMUKoLEbohX/7eUPsujS8Ds8+Az0/ByVKAploevZqSXIXJ81JYoKXPJKjtN?=
 =?us-ascii?Q?/CZtYZTsL4WaSpi4I2CZlub+aI0vSI8bMvWJYLkK+vCzPGaGS0D+w5TfeQ7p?=
 =?us-ascii?Q?83JqquqD8Gywy+b65d/R63I/zn7FUTQlmzRGpJEjSDNg9O+UFUshgV/Asfb+?=
 =?us-ascii?Q?HtTal9o2uvkozDpVO9LdLwle+XfE7B+AUX748kWZ8CulcV0TC86P+KgYMJ8c?=
 =?us-ascii?Q?XYvkYDEtwONuVx1FH0X7gByCdFclXQqPGcUmLWbZjb1Y37tUYjLgrHiqq9oi?=
 =?us-ascii?Q?dn5hG+8+00czi+r04GBNGwuMAQ4pfdKtmz0RL1SzAVaqurhndx6ZiYB00W87?=
 =?us-ascii?Q?4Tmk4CNF/UOpRw2NqnuvodOIA8nRf+rQemqAfpt1UP5zpb2ahfyJCCO/9e/z?=
 =?us-ascii?Q?58EMfPr4w1KG8VYMpZu/SVnx8MjoaXESe+fiFErCQmcXrKuk+dIy2fKQ1tVx?=
 =?us-ascii?Q?qF8V/+ZxbiBBwTnGPzOCgYKLq6zlK/A3OVnJ4F5l?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8b320d89-291c-4acb-de66-08db757906fa
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Jun 2023 12:38:07.3414
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: dHAIXbPEcyvMRkmnnTymdz+6QnbbehohGCPZPRnmXRsUurAj7B1ldzvbAtdehc9awTV2dqbFxxVEI+fGG3vnRg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS4PR04MB9314
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Haibo Chen <haibo.chen@nxp.com>

Add flexspi node, flexspi has a special memory region mapped to
0x60000000~0x6fffffff. This region is for AHB usage. So add this region
to SoC ranges.

Signed-off-by: Haibo Chen <haibo.chen@nxp.com>
Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 arch/arm64/boot/dts/freescale/imx8ulp.dtsi | 18 +++++++++++++++++-
 1 file changed, 17 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/freescale/imx8ulp.dtsi b/arch/arm64/boot/dts/freescale/imx8ulp.dtsi
index 16906c20bce9..4d317029490c 100644
--- a/arch/arm64/boot/dts/freescale/imx8ulp.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx8ulp.dtsi
@@ -194,7 +194,8 @@ soc: soc@0 {
 		compatible = "simple-bus";
 		#address-cells = <1>;
 		#size-cells = <1>;
-		ranges = <0x0 0x0 0x0 0x40000000>;
+		ranges = <0x0 0x0 0x0 0x40000000>,
+			 <0x60000000 0x0 0x60000000 0x1000000>;
 
 		s4muap: mailbox@27020000 {
 			compatible = "fsl,imx8ulp-mu-s4";
@@ -349,6 +350,21 @@ pcc4: clock-controller@29800000 {
 				#reset-cells = <1>;
 			};
 
+			flexspi2: spi@29810000 {
+				compatible = "nxp,imx8mm-fspi";
+				reg = <0x29810000 0x10000>, <0x60000000 0x10000000>;
+				reg-names = "fspi_base", "fspi_mmap";
+				#address-cells = <1>;
+				#size-cells = <0>;
+				interrupts = <GIC_SPI 141 IRQ_TYPE_LEVEL_HIGH>;
+				clocks = <&pcc4 IMX8ULP_CLK_FLEXSPI2>,
+					 <&pcc4 IMX8ULP_CLK_FLEXSPI2>;
+				clock-names = "fspi", "fspi_en";
+				assigned-clocks = <&pcc4 IMX8ULP_CLK_FLEXSPI2>;
+				assigned-clock-parents = <&cgc1 IMX8ULP_CLK_SPLL3_PFD3_DIV2>;
+				status = "disabled";
+			};
+
 			lpi2c6: i2c@29840000 {
 				compatible = "fsl,imx8ulp-lpi2c", "fsl,imx7ulp-lpi2c";
 				reg = <0x29840000 0x10000>;
-- 
2.37.1

