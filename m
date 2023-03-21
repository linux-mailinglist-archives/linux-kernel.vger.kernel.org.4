Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6D6A76C2CFE
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Mar 2023 09:50:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231270AbjCUItp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Mar 2023 04:49:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56788 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230136AbjCUIsZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Mar 2023 04:48:25 -0400
Received: from EUR03-AM7-obe.outbound.protection.outlook.com (mail-am7eur03on2059.outbound.protection.outlook.com [40.107.105.59])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4FF6C44B3;
        Tue, 21 Mar 2023 01:47:46 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ObVUo2SZIlaHXZyWlCxpQH7MUkLdbUA2sglgWVx9TMuspgkLLG2NvLM1XppYnMnPHq/p/j4K5AYln4je003HdXFpxl/kbb1rxcA4pQIuEg0i37niIZboj7RUwkrQFYd58O5bUMvHzn+vGROfsI4RVk1zeq4/HcMS/8i4fGlqRIFxDQq46F7t3ILP9BwbjtbueI86oz8d4U+3blGXVLTqD6VSFDBQcWoqf7Fyj3QjaxmOj6mbVYnE1id49vzXpV8mtGJLJ3yTXRPXlrkub+QLSl1Qg3JtFT4L5QQ6DsJUOoSw/ES4/MjJ8b7ZYM7tCCGY/hPfUyCc3XO67xNd5ztTIw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7nPkEt9QyfswdMet/S8eQ4hsytlZBf0Um1MloIm3Uq4=;
 b=hPcXPe11D/YCNxTA+b5quju/LZHed16FVgBOKMll7nNhyc58IpvWtzII9ptLbluB6o06JnqiXieT2SfgYpkIFiYJiczChBxCKmsDTlB6c2Cy4i86gPMIsi8RwPGpjQSvZU8334kbO1KTvrb0Uw3mq0XiIccoq46bSXmXBQpUTAPOnKkhdc9cZzXenPBQGcJ3vBSoJDfDYzkyQDklIOVM8GRUK7XGC14oHh3OEJFIvFpIk7ViXL8yDhPB/ulyKdSJkUA1gWBLMvvTPJXADKYSAJQyscW29m8UYGYLjsCYV2nFfO4NZeRe3SFvFXjjeaqNiDir/Tl+1S9iBYPD51CAbg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7nPkEt9QyfswdMet/S8eQ4hsytlZBf0Um1MloIm3Uq4=;
 b=Gk7I35fyDJXdR7NBbiEHxBa+HB6otUtkSNX/4xuc2qsZkW/1DfjdquZvEqQrjCMrxmuKlk2nAK8siVEmP99e1wrYHDORqTvWsbBRZxCs8W8TzvtCKIB2QYz6BemR1xD4+1w0PG0061i7CozzKowdC0DKZP2P4eSgh+zCvYmjQEs=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by VI1PR04MB6944.eurprd04.prod.outlook.com (2603:10a6:803:133::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.37; Tue, 21 Mar
 2023 08:47:40 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::f55a:cf12:da08:6d2a]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::f55a:cf12:da08:6d2a%7]) with mapi id 15.20.6178.037; Tue, 21 Mar 2023
 08:47:39 +0000
From:   "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
To:     gregkh@linuxfoundation.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, shawnguo@kernel.org,
        s.hauer@pengutronix.de, xu.yang_2@nxp.com
Cc:     kernel@pengutronix.de, festevam@gmail.com, linux-imx@nxp.com,
        linux-usb@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        jun.li@nxp.com, Peng Fan <peng.fan@nxp.com>
Subject: [PATCH V6 06/10] arm64: dts: imx8: update usb compatible
Date:   Tue, 21 Mar 2023 16:52:09 +0800
Message-Id: <20230321085213.1624216-7-peng.fan@oss.nxp.com>
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
X-MS-Office365-Filtering-Correlation-Id: 6fd22ad8-ccce-4a9d-8fde-08db29e8ed31
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Z1aWGtRiqRPAQQmBcBQNNc1tDk+Gs0x3w+myT0Aohr8K/prTrppf3xNnunap0WheZBTah1ViMpDR/T9czUz3gPu2aC66fvFKb05RJWe8/dtbpiyZ6vIVNM/blYJIxkMYeb1wVgNNuSjFogpfQNvGGkhaWGonVUJavKL5yoXJ/SLPEUuCx8ruio7R0oUuc/xLOf0iol0FVNk6mpPfFv7oE0PHOcFvsi0tiwrNTu8UngJ3Nxc5Q7W83rdBR03tiIqhkH+h5XZx18uyYqT7sR4mfrYHVQlPorq5Ucrs/J/u5JhDlK+sD2w5rf9VnakLl9LXoGW4i7o9xMqoFnrvX7ylGpnQv8HwtYI7UBhV1TOKeLCRmgOotFFeZV6QxAdLFtcDi08fwyhwsMJhG8bZorJVVTwGQgacXXgjtBysebPUklBrWqeRUuIh0aQLzBxNNrwno5noSIq7H0xfVwoWDG16zeBOyD2HZysSmbwkno4a/ZnPyxYq84zB14C0Lff3m4J+sK318X9T30E9mku+vKsEC57/fMJVUem2cnHt6KZGlFm5vNnvAHqy4bwf0m7cGRYkXDke6OvX/MEXFgltHthe7pcSiv8r+aprwHQj8xDEJ8WumTL8xfiB0pOiWnW6cBZK8AVtwhrKOUykNwOPscqZ53qkWzAeMGNtjtVnnaeB9jAw6xRq5h/gWZIu5/YHOo/LjVo8HVJReSTh++x8TTv7Qw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(366004)(346002)(39860400002)(136003)(396003)(376002)(451199018)(2616005)(186003)(6666004)(6486002)(6512007)(6506007)(26005)(1076003)(52116002)(38100700002)(316002)(38350700002)(478600001)(2906002)(86362001)(15650500001)(83380400001)(7416002)(4326008)(8936002)(66556008)(5660300002)(41300700001)(8676002)(66946007)(66476007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?E1RqkJCIZMcgmnQAarrHvvhqNWA09CjMftlvF4xq/1aOSZ/GB6s/ULOxXphr?=
 =?us-ascii?Q?RdSaIJg1eKZl9Bjk9CoL6fp78GI1gnBXSM8CcW3SeVpxQlKuP5AEUgAjnBxO?=
 =?us-ascii?Q?uX+3ryRIkbP466HjXuw/t1WDMCY4UjnPp4c5UAyLxNDppw5/Fhxndu2+2mi/?=
 =?us-ascii?Q?5jwNddF5TyIhNdOp7asRlnRiug49T2Ddj0X085ArresL2qfUn0TGY7n1xcvD?=
 =?us-ascii?Q?ocRYVzzm/uOmq3M+ZKAY3VzLvIWDEGLa8my6boIV+Fq3IC+WrYSxTA2ht/5A?=
 =?us-ascii?Q?m2Gy+G4JLVsupzEeJo4IUV3FIKmMOY2ZCY912XsooP2Im9PQPrr0BAEoQczm?=
 =?us-ascii?Q?Bt7vhzUMcn5Zi6jDNAykt612Tl4H2R6dbzmE9Dw/vhRJr2UyH3LTg3mpt7vL?=
 =?us-ascii?Q?lja4p4Ug6AUM+cdM6qOLnIRd14hGYR6u0SdRzdN0G1JiOcvCo3cZC5tpLbJ4?=
 =?us-ascii?Q?0BpcshSl3UdonZsDKx90dZw3kCWWIhrjF23LOWYxmtJlWbZqWUtXYamUvacz?=
 =?us-ascii?Q?eXGukKsb9uBeK06cGQwOgesmiBDmqWXcxVsm14WBPAXHV8iaJnVbZOxasuFs?=
 =?us-ascii?Q?Dy2vm9xJZC0Kl+9/6BSFAzTO8TsnqJ7kR5cLz9ZM1H6xcXnU/cxVeDwQ1aq6?=
 =?us-ascii?Q?jFMWh95mDf7ClGPQ+BMsIHZ4h8QJr7IjqrxS/o5k7OuoEZWoSwrFg1NON5Ar?=
 =?us-ascii?Q?2U+GYUyNecgBlSE0+GAUql9bu9OqQJ+OVT1yf4ZV7yWhjwWzhRYy4H94AWa2?=
 =?us-ascii?Q?EOeE97HAynIMhOH7ERpXXsSEQM4sRaEXv4kE6ayxFdEtBcIafL6+VqrOHcu3?=
 =?us-ascii?Q?DF+h05omxpa3KCQgzNJ0UA0Hg7eTIZAWwBLm0jaNVlJpJnxpxYD+aBhZR7VS?=
 =?us-ascii?Q?CnWgWOJCTKJq3Rmj8mq2nGg34UeclMRLsWXBdOKubhhOxV5bwXDusej/P/Us?=
 =?us-ascii?Q?V/BcMmzMQNmSJHVAYkNQ5vSwU+Cg3Jl5la6fU1ft6VPUV7dXQEyC3K0eaBTj?=
 =?us-ascii?Q?gjVQPb6jLnF2ypVc0Oay3jx+TUGeM0JinkV+eO9XNnUKnCcKtBpG4E4WFOHP?=
 =?us-ascii?Q?4SEqDJPiaus44m8c0/+w1/5ntH+IKUqLXukwQZi8xcUo9hycnpmbBe9Ksdfu?=
 =?us-ascii?Q?sj3zyXt+1Gdn7B5VDFgsD9PlgTjdgV8zMcTTDGOJf5cIgIEmcK+RwUFY9rXe?=
 =?us-ascii?Q?RDSLI+GLL5juAZqYGFUnE404f/qu6HGtYBCpCRT5R6ZVw/Us+qTvtCXoMj0R?=
 =?us-ascii?Q?ZNmfANfG8FrHxED3nV21R+XLtXUqT+mTrE/2R69TAT//4rqvDiIbbpUemxLQ?=
 =?us-ascii?Q?DadGRYhImAzkp6CwatNa2N8NYYC0Ce80xYIpmNuFmgOjjtQnl5qdSck7vR02?=
 =?us-ascii?Q?ICJDMGAqS9OtHofi2/k8bjnzNOXpoNqF6iT4t5uzFxWBB5fcMaQBTs/GHPso?=
 =?us-ascii?Q?GmXjsGYK7PUfu+p4tPlOtg73cCRaqnYQ/kMuT123wCgaGIUIRRCC9zVwarN6?=
 =?us-ascii?Q?CpNvZ0drAR05/nnNHIKNWRfqjJD6JQxzLOGoy116wriVAsWQRYxe7R9QN6XO?=
 =?us-ascii?Q?Udn59Zbwy6vqm3n/mzCaZem6c1C1NV1rgtrwnb6U?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6fd22ad8-ccce-4a9d-8fde-08db29e8ed31
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Mar 2023 08:47:39.5718
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: SlGIEwAyr/yxVXtq/vuhKKSta848AufZtqm3u3XJX8sD23keq6ur6mFyqDAfw2CJ9RD7wMLvsMrkfkGFSSEb/A==
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

Update usb compatible per binding doc

Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 arch/arm64/boot/dts/freescale/imx8-ss-conn.dtsi | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/boot/dts/freescale/imx8-ss-conn.dtsi b/arch/arm64/boot/dts/freescale/imx8-ss-conn.dtsi
index 4852760adeee..6ed084862345 100644
--- a/arch/arm64/boot/dts/freescale/imx8-ss-conn.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx8-ss-conn.dtsi
@@ -35,7 +35,7 @@ conn_ipg_clk: clock-conn-ipg {
 	};
 
 	usbotg1: usb@5b0d0000 {
-		compatible = "fsl,imx7ulp-usb";
+		compatible = "fsl,imx7ulp-usb", "fsl,imx6ul-usb", "fsl,imx27-usb";
 		reg = <0x5b0d0000 0x200>;
 		interrupt-parent = <&gic>;
 		interrupts = <GIC_SPI 267 IRQ_TYPE_LEVEL_HIGH>;
@@ -51,7 +51,7 @@ usbotg1: usb@5b0d0000 {
 
 	usbmisc1: usbmisc@5b0d0200 {
 		#index-cells = <1>;
-		compatible = "fsl,imx7ulp-usbmisc", "fsl,imx6q-usbmisc";
+		compatible = "fsl,imx7ulp-usbmisc", "fsl,imx7d-usbmisc", "fsl,imx6q-usbmisc";
 		reg = <0x5b0d0200 0x200>;
 	};
 
-- 
2.37.1

