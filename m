Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8E187605C08
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Oct 2022 12:16:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229784AbiJTKQq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Oct 2022 06:16:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58536 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230440AbiJTKP7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Oct 2022 06:15:59 -0400
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2086.outbound.protection.outlook.com [40.107.22.86])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 04CCE17FD51;
        Thu, 20 Oct 2022 03:15:55 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fH8yD9bN4N/pN1IiC2eMvjeiyr9KtBmGPnqH74VQLLH03UUATFN3klCMcJRrMD8yT1cjggf2+w0c3DS9Sz/WR4M6zYOQ5381bW18EY38XXbVjD2TyDkiqUW8vPaFWjnQs0WnWWYeXXp7gzz13ZGkdG9qg6uQGwTzQ6wya49Nd3E3xP7c2wUpT+tcS7Tj9/JQ+42wKhvEVxK9Zwy0dLlr0jTiJt8RKdb86NmUxvzG05YT8+3MBgXCS96YfpjAZ888IU7ZDcQ0GWxZlZh0dE2WpobyUGiSypFkfi+xFNxsfDTatTZGrYakvc3wMXKkn7tPp4VypZ8OgUIch/xyUE+3pA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IAdcudts+18/Cr5FvV/DavzGXQJMJHz4KBx43mJda3w=;
 b=fjdIk8ok2MFbGRabsDHfVrweuSm4gucaMWhRzvNeP1jQDtVo8nuiQAKyXKTTKrYwe463ete543x+5PfhZde8weiApP83uw7fwshCrqyH1RohiHOG2Byp1VABB0QOnHtozlJWiU4IauaHVzzIdwjELiCmXEkckxt9E2kNGoYtFPYwa/gG1awbklfn5lspngsmkzFeGy9ijhS9Ixaq3VbnlHIpa2MjBdM4QjHHQXPVZw13En2kXRL4xIOYKcLwoPtSp/94Kmw9d133mHY3luW4HJXvBQOTxabd59TEGhZv76gljyipg3VTgjhxf83qahrOr0YJjLyrO+HZkKA6ZLJAPQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IAdcudts+18/Cr5FvV/DavzGXQJMJHz4KBx43mJda3w=;
 b=OvP9a8LHT1If4MYBv6pULvibsdGSIb1IzIpfYRHBgua69+gOmLesm5KcySOm+MXn0OMnLWUo+vAwVmUWyzEWEsavcUerTlepFHiFN+LKXb+kgf8Purg40+h3TUgPYlTBEdo9JaC2DpDzV1sdyygJjmVKqAboWVXCwiVikV1M/3M=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by AM8PR04MB8002.eurprd04.prod.outlook.com (2603:10a6:20b:247::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5723.26; Thu, 20 Oct
 2022 10:15:52 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::a5ff:3d28:4bbc:e1ed]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::a5ff:3d28:4bbc:e1ed%6]) with mapi id 15.20.5723.032; Thu, 20 Oct 2022
 10:15:52 +0000
From:   "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
To:     robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        shawnguo@kernel.org, s.hauer@pengutronix.de
Cc:     kernel@pengutronix.de, festevam@gmail.com, linux-imx@nxp.com,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, Peng Fan <peng.fan@nxp.com>
Subject: [PATCH 3/7] arm64: dts: imx93: add nxp,no-divider for sysctr
Date:   Thu, 20 Oct 2022 18:16:58 +0800
Message-Id: <20221020101702.1867188-4-peng.fan@oss.nxp.com>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20221020101702.1867188-1-peng.fan@oss.nxp.com>
References: <20221020101702.1867188-1-peng.fan@oss.nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR01CA0039.apcprd01.prod.exchangelabs.com
 (2603:1096:4:193::16) To DU0PR04MB9417.eurprd04.prod.outlook.com
 (2603:10a6:10:358::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU0PR04MB9417:EE_|AM8PR04MB8002:EE_
X-MS-Office365-Filtering-Correlation-Id: e08c3ae0-3872-4460-76c2-08dab2841136
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: thb4KpkEaEbRG24wEYR9nMDr8/DTibsCviH7Uly7ySb+mmCItG3MGHspTj1ZV/MS77GsC5pabSASA1rXq3Ycc4AMPpF2NmLEcSGQx7gk8N+RTlONezzjjFiY5s2N8eQ9feSWtSFZl/sZChd0fQOS7xMHHL4ZaCgg2qWU8kBMzC8lGFfohpnBTx3Rjlv8oHwS8vQZaz1NhRiIlT1UFhequtKumi1VF1se3MAQcd1sIB2Shqd2lHIUstDzC/KY4ehJtYTZlKTHiaRvWonosd6bgtnJJ0RScm4ODlDUdVy9LCZLcDOe5/sipKqH2d4Nw64SYG9gwqdAxY5QJEUDZ6OkXHMFAFndb3Q0mnHVpxMZYeTYFkXRlzA49GS2x4MC+xJ8pVEpbJjus3KhqtQjYxQdyEgwk0YAR1uqjde97iivKJe3xbT6B+PdRNMrWxpT7c0c6Fj3Z6eaGlkCAlK4ZXkhZ/BTgdMFFkgxjZdFFgxHEO3Sor2zCXyfx81JZhRBeOhEk2HyJAJjk6fThrjaZUePtUfdra1/99tTq6bBwgMso6ESAtRPxYsgZ3MQP2AiMirCCsuZe5IC++hoNYmNaoPUFZQKkwqdFTPvNxbdd5EUePZbkHmk4QlFZzRPoy6CtLUaFKEtGDH/8ar4/MTuXbuxt24Wdj4gw7WLgylybZSnt1pzFn+VXdS2MQ3oHyFqt3bMFhsiPDlftS8rES4ktwnR4PKNc+vjcPqabrGXml4frnYXRGJdfMGrtYpd7oMJNkKAYncwsO7vcPWfxrISERIZ4A==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(136003)(366004)(396003)(39860400002)(346002)(376002)(451199015)(38100700002)(38350700002)(86362001)(2906002)(4744005)(6486002)(478600001)(41300700001)(316002)(66556008)(4326008)(8676002)(66476007)(8936002)(5660300002)(66946007)(83380400001)(6512007)(26005)(6506007)(52116002)(186003)(2616005)(1076003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?QkEM7kJC4Bc86JuuNK2n2zHcJ9XZfsf5320VcYKCV56iF0D46c85biRQ1Kcb?=
 =?us-ascii?Q?aN9veQn8Si/11F1D/k0U4+0tkjvcpBIfsZfpV4/2DxaR/wo2FWQSJP4SgoCl?=
 =?us-ascii?Q?lHb3J6LatR5YkYPu+eyQvJ7KLKt+KC+zUpurFJ+LBQq7jCh5Oq3o7L9zdwmv?=
 =?us-ascii?Q?h055jRP8S3T9XUGeHyQVEdWAIzDaO1pOi1lpMnfzH9TQOYL86QABMh2PkeUO?=
 =?us-ascii?Q?QLkGCVvvUf0c3do3vCMyRvvo16gEoiXpTI1Y89G/rQg6396al48rlpFBSuve?=
 =?us-ascii?Q?+AYiuflyob//j1CbYGFOg23NpTeu703ZeKDumqfWoW6yVmbpVETF/DYK7HHc?=
 =?us-ascii?Q?1KivuDbnmPrxnnUCaXSH+VPbS9HbyE730PWLl2BDi/VopqoeZ6ubQxBNFMMq?=
 =?us-ascii?Q?WIcuXUn6CsA6rrzfYpflUHGJCRIkD1T/duh8G3qDJUl6UX5Z1ILaQczuDORq?=
 =?us-ascii?Q?x2vACUXNNY2YOkbfnGGc1WA02gy9S+hTdJoLWQA6jGYx9C5IDSfqHIN5BMD3?=
 =?us-ascii?Q?UWd2LnYnqyWzqQ1rgl/ilDvMjG1mpBoqR7oAHwvN3Sh9ULZi4yVYaSIwfkGb?=
 =?us-ascii?Q?SYj+bDLP3Zz3i6G/kIiTFYWl2qsXrBCfqCOZbSEVDxBNKro++AHaFNUFdZ7R?=
 =?us-ascii?Q?YpWvXEcKBW8iiST6oskqsSv9k9xoNxq0YLfaEU1gHpnCR6idkmtb33Krscjd?=
 =?us-ascii?Q?io5Nvrg3tAOnGg438MS1HhnzyTME6ITePTNJaheBJ2fxIwaV0bGDzpxPGTJw?=
 =?us-ascii?Q?B/Y/W1rMDK1dt5Eu9lwzyNnUTUhRohgzHRYRWqx+U0EFgaoKiooc7ff1tHEn?=
 =?us-ascii?Q?s1SbFjyiKDMDwImLYleWlXr99CofMCgCa4xJWi3zW45CLFsjqxpqiGqbNvKJ?=
 =?us-ascii?Q?oGM6kGlbM3CjyyqlzmysLtFCzExySkf/UbQzW71JRLrj8f5CVwY19oDrPDdQ?=
 =?us-ascii?Q?6Wf05YHmPenRuMhj5JS2VqloBMYnCy5ToIYcE/aYh+nj15w0Rp7Ttvr/O5/L?=
 =?us-ascii?Q?+h7wXU+7RumeWFwIWIcnGghANQlSbxPttR3b2Py9Ak9nfQnR22uuzLeBzLps?=
 =?us-ascii?Q?D3La4Sy5v3M/6mDEen9Xd8xFy3eJKGGWY8sJlFgqe8hvKzXf8qc+REspqXEF?=
 =?us-ascii?Q?LVz+1CHlYiz3p/u79G3aj3Rz1j3qBJaNETjKk3tm7rLITOxxG08TClY75BA5?=
 =?us-ascii?Q?9lMkHag4+PwVzWwpHvMYvINFTLbGtTnriVwXBKrOteVe4ksMZLKq8zQtyrTF?=
 =?us-ascii?Q?CJEJmxehYjmEYZrek63rQz4wL79mt8YyL1xQCECkeLGRdsBfSfN0VmwYIEm4?=
 =?us-ascii?Q?qauq8gH7wNUqMR6VDnGFeAjPsL1HNKC1sC1UopfrK9/vPp3eLD3YwkPnbDPe?=
 =?us-ascii?Q?qjGSKw52aBKtcJWjp3a4vfuSu2GywQ5rsrnmVKgGmiy3suQQUIVwZG0jDzL9?=
 =?us-ascii?Q?AL+vcofM27Gnff/Q9WpzMp6+9/N83zXz/3mH5S9tr58sds2OjM5Iei0VTFIo?=
 =?us-ascii?Q?rseMBDnSOFbn3V8lMarZ/LQ2cL4MiNaTvKTxsBLtdTQzle0h3u3Ut3Q9POlY?=
 =?us-ascii?Q?p78RNkiNxM+wcSI50lhnSJOrsENNWHGADv0hyFxO?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e08c3ae0-3872-4460-76c2-08dab2841136
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Oct 2022 10:15:52.3523
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Bs0QXmTu9wSHQeFglF6HaoeqzAZK0vZpRyMPlsf8sytO2E+UGxty02wh+74rCWENM+6LXPOYfIi/VGFCqYmBQQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM8PR04MB8002
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Peng Fan <peng.fan@nxp.com>

There is no internal '/3' divider in i.MX93 sysctr, so need this
property.

Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 arch/arm64/boot/dts/freescale/imx93.dtsi | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/boot/dts/freescale/imx93.dtsi b/arch/arm64/boot/dts/freescale/imx93.dtsi
index 0247866fc86b..2d983e6ee734 100644
--- a/arch/arm64/boot/dts/freescale/imx93.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx93.dtsi
@@ -145,6 +145,7 @@ system_counter: timer@44290000 {
 				interrupts = <GIC_SPI 74 IRQ_TYPE_LEVEL_HIGH>;
 				clocks = <&osc_24m>;
 				clock-names = "per";
+				nxp,no-divider;
 			};
 
 			lpi2c1: i2c@44340000 {
-- 
2.37.1

