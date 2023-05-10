Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A1B0B6FD943
	for <lists+linux-kernel@lfdr.de>; Wed, 10 May 2023 10:27:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236528AbjEJI1Q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 May 2023 04:27:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41484 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236497AbjEJI1G (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 May 2023 04:27:06 -0400
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2047.outbound.protection.outlook.com [40.107.20.47])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8CF6C5258;
        Wed, 10 May 2023 01:27:05 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kCiVuatuzUggbVq7CJEicpIJKG43Yih2jdyPAim9jvdLDUv2TlgW1JapIzZYryImdTIGroCE2tmNIpAYOUZDbPL0SytObJH619upfk53zExE0BGrchvXgW4JzgVjtCsGf45kDbPf7pfo3yPIjFxcWU+9vc/2rpMrcJ0ZWIzQuX9lT8MjkhnuBzBOLlTebz0sYaI37vPsElOy+lIEQrySIo5oVBfIUOFjX3O2pTfJP1n+YNjh8TnefHBFooijfCArf9GyOZLRjtYMKHA4Vo2TNuCWVx84kwshqfRJv1tSGrydvlSF1+MTUqUGkZ/sqV/+zFVUKoTI8zhr8EeoTUfnTg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tOxJv15RDOT2sbZpN6o6/C03bxB2PP0rVn0r/DGIYE0=;
 b=SkyhlufFedlphhki6S57O9JJ1qMP6wQUk2byGxE53ecOvMl7XUPbUJRDmn4kVciQjaTmAngtRvooUBAVModgeKjEBqeYbEtLuijf8mOo16xD6DnB20lqryjGW6yehkwl2CZGGdHLM7Q+Az8xlFG3ZAIp2Fow3feuFA2+UxlalpZQ4y/YbDXFKn5I05a5jX+wkEopQ6zBJKtIBNkDTdWR2ALDkjYtj+qaIGtKDGRo8iDJqj3ZtEWXLiczlC4hYCc3Sj2BREpEuOGxmbwHAZ3maoY7zKqnK6DzXkSYLhHWKOMCicgw2LJ8HjL0Y13WU+zoxElHzW9bGcNAwVz6Pjo+3A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tOxJv15RDOT2sbZpN6o6/C03bxB2PP0rVn0r/DGIYE0=;
 b=UhPz7llgacnoeUT2W+W1BhXeDpHSqm9VMafsGRSC4J/By/q7P62wCRIHBdFxLO+2Ku3fEjo8JHbvnVUonOXc/AzaeSsLptrxGGEeRIJu9P2EmxNn4jNAcgMy2EcUhn3aWe7wUNF4RNUDWr7FQS9Z/dvmi/uFICwUQR03+qlO/Tk=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by PA4PR04MB9368.eurprd04.prod.outlook.com (2603:10a6:102:2ab::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6387.20; Wed, 10 May
 2023 08:27:03 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::b999:f2c6:a8cc:7b4]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::b999:f2c6:a8cc:7b4%4]) with mapi id 15.20.6363.032; Wed, 10 May 2023
 08:27:02 +0000
From:   "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
To:     robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        shawnguo@kernel.org, s.hauer@pengutronix.de
Cc:     kernel@pengutronix.de, festevam@gmail.com, linux-imx@nxp.com,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, Peng Fan <peng.fan@nxp.com>
Subject: [PATCH 2/5] arm64: dts: imx93: add ocotp node
Date:   Wed, 10 May 2023 16:31:50 +0800
Message-Id: <20230510083153.3769140-3-peng.fan@oss.nxp.com>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20230510083153.3769140-1-peng.fan@oss.nxp.com>
References: <20230510083153.3769140-1-peng.fan@oss.nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR02CA0004.apcprd02.prod.outlook.com
 (2603:1096:4:194::14) To DU0PR04MB9417.eurprd04.prod.outlook.com
 (2603:10a6:10:358::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU0PR04MB9417:EE_|PA4PR04MB9368:EE_
X-MS-Office365-Filtering-Correlation-Id: eff41c22-a3b6-4963-dd70-08db513054c1
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 91e4xsRjjURcjLC2LsxWs7gfOsolgIyZonPwsj6ea1HcEq44B609r7OpC9uvlN7MsHlgbfgPjS055TaetBS4yvyynWGiCTW4bDC0Gua2lRKK4e1Nc/p27jSNfggSLi36MTdVI721t/bbJHXVULGWu3j7DWi2CLRid08HnTXIxQMjoHk8Z4VOCd3SlFurWyyk4Q5Mvt3SnG6+RmLdADVPqcQC62geWw8JZA7dZ88TotlcogtooOOflPmGhiI+9I8sojWUuDPmmqJoS56qLPWwP7f9uAkHLSCfOgMktOZCvO9Ta0EuMcK6PWkKAf+qOXMXssx0oLB7jjpWQci3KLhAjluJ3GEJ695rYcRdazV2Z/lkL8SQTsOBpD7IXCLhZOudnR0/T5X9kkBfiWMFCBdXdE/VslfUCPFDUPZK7lehL702/cOwZwNlFcmQYcnHsf1YulqCB7ibTwzXa6yEelnZA4JaKX0xTS1hrIz5vzu977xg20Kqgcxb1ppceKkj8RW+ByHCVipHD6cIBYkZ4zMwMEgAUrskSEHfsKcafR7bEx82QDG1nnk05k2U3aeqN29zbX+o5r3jfChJYPNHzSF5IclAo4om8zjKNUPcCMvIN6iMvZ8A+8tkYwwlVTmuKpIR
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(136003)(366004)(396003)(39860400002)(346002)(376002)(451199021)(38100700002)(38350700002)(4326008)(8936002)(8676002)(83380400001)(2616005)(66476007)(66556008)(66946007)(316002)(41300700001)(6506007)(1076003)(26005)(6512007)(186003)(478600001)(86362001)(2906002)(4744005)(6486002)(52116002)(6666004)(5660300002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?uA2UJDKm2sBeMyTJ7mvLifbFspDp7GD4dvL88dXc6kOoY3174jQzoGSBayFV?=
 =?us-ascii?Q?2D3fM0m38FaTIjjAKSzdGdTOc5+RgyFZrAFRmgG3DbZ/Cv7H40Rs3X+m5TXZ?=
 =?us-ascii?Q?PVsfpmTy87IzubrYlrH5VJeaHQ2jfi0seRWC3lM8JhoMLS1GDiiqwqvdMbGw?=
 =?us-ascii?Q?ALiOst6+ln2AakjSkTYdbqJGurAqjoHI8EKT6MN2p3POSNSUwo2H3jjnOn/3?=
 =?us-ascii?Q?z0eCNeZe9/ICASj0zRgEMBBYy6Ep15NXh+NUN9QL7UIQgVvFuxT8P9utnbqb?=
 =?us-ascii?Q?aK9WQlXYx2aVNjsGyhE07DethUXNAgKbo4dXAEl1rQhY94vKSsjqqUBNT7Yz?=
 =?us-ascii?Q?XEkS8V+KlwiSed/EkS9p/fNgUAl8UIrJcBysW8AfwvTvf3dfuZS6QO9sGjUT?=
 =?us-ascii?Q?DFD0+f1e8Fgy+Z7vn79bOIU1w9A9L60Jl5q61kcTMGpzUD8y4JfWhfRCV+zr?=
 =?us-ascii?Q?AvZTh1SUfiDWkS9Lg9S5btIRGPFhBSK65OyVRZHNtBvtpxo7c79KgTN6BKnc?=
 =?us-ascii?Q?FpXfkBpfx+xG6c9QHtd8yT9ivBtQkEJxdtyeigsBcjp9p7AGfs6pPUT1AHQ7?=
 =?us-ascii?Q?MIlsqxK0FS+v94ex66YuW+jLmXbz/3cBKIu4ksPq5+cfRYp3Bsn1L5X8iiof?=
 =?us-ascii?Q?Tqcj0VHuLaKh0do/8rmnQpmB2HsZR9JPAeNQ+/2GU9PIqA5/3bFQLgvIsgkS?=
 =?us-ascii?Q?Vk+D5tunily5N/GP9UOru6AOPAmCK45tIac5fE+gSjR/qjhuM3XcGAg6wN3j?=
 =?us-ascii?Q?BL3KJ/na6c+008GYjoIk8oJhA6wznsDVUZ5KbmI2ZDZDNOklXDgvG6rdS2dU?=
 =?us-ascii?Q?hElrijUGVdXClONkSIUvr3K+3g6/ZrCr61XtF0EGnpcwvC/EYgkrdwNY4H+e?=
 =?us-ascii?Q?9sqhB6C5I1c+BoYeOH32qH6kptRlvbubiRcSnFmSVKDCo74fw8SATFjdBdp/?=
 =?us-ascii?Q?5TTYm8u/ruGG/BFk8mH0qAdi5uDSUdfgKibGoxbGRl88IEnF5qJyZYfnxQl9?=
 =?us-ascii?Q?h3uGmaDO44jgsTdxXNRXEHNjSHBjIB+UuzLKuNyBdDTuFa87Ryv+aoU+2uma?=
 =?us-ascii?Q?dGW04UA6FEdx+zQV0Dl8SJDKe431yz8r9qX4j6nMjOO6DWL1V9olAjR07gvB?=
 =?us-ascii?Q?ARbWkcT7K8XXmZtEdXbmDtQbL8vcGCvLfOIZyDKsWpRhRBqUNWNBq2j6Sayf?=
 =?us-ascii?Q?9MfpdXcfcncUwzWUJKkMyLLSMuGIMdECltoWsOb76eSN7zIzKFw+XtyWU5kx?=
 =?us-ascii?Q?UHG6d16LDvw1qyv0+oGkhR1FJf31L2VtRZ2XqmIxhNS9w0ftj3wV3IpKnaeY?=
 =?us-ascii?Q?973nM14k8nG0alzHBcNFPj4AzH5pu274Lhi8jwHQNbs+lrb7Wcj/wEmO2pXf?=
 =?us-ascii?Q?wMPO4Ngu8UISqwTA272NvSU9bZwMocJ/BrI7n2tCOuYpK3oRBEOfv/cZmjO6?=
 =?us-ascii?Q?/mNDVpyZ+5x7EbV/tYI1XqgOWn8enbxhaVkNXl5SWXXhE2y8ePvlNgP9zTOs?=
 =?us-ascii?Q?vjYJwsa9B9KTKkM2MVOTVTKNM2Z5/ObE6vc3P5OcExray0eAOxQNQRoFf0U5?=
 =?us-ascii?Q?MsTcKrrjp9r2msNwo/s8Zgzv76eHAy+/DmZy6IRE?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: eff41c22-a3b6-4963-dd70-08db513054c1
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 May 2023 08:27:02.9129
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vBZ/dRonFUA1h5nVLlBhYdijOsIFoYvF+pa6yqr5MmEtXqtg34JzguRMhP22OhhbUbRkJ4+nEu4dRGxic1dDpA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR04MB9368
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Peng Fan <peng.fan@nxp.com>

Add i.MX93 OCOTP node

Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 arch/arm64/boot/dts/freescale/imx93.dtsi | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/arch/arm64/boot/dts/freescale/imx93.dtsi b/arch/arm64/boot/dts/freescale/imx93.dtsi
index a04c63d4dc06..8354d17a6a3f 100644
--- a/arch/arm64/boot/dts/freescale/imx93.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx93.dtsi
@@ -805,6 +805,13 @@ gpio1: gpio@47400080 {
 			gpio-ranges = <&iomuxc 0 92 16>;
 		};
 
+		ocotp: efuse@47510000 {
+			compatible = "fsl,imx93-ocotp", "syscon";
+			reg = <0x47510000 0x10000>;
+			#address-cells = <1>;
+			#size-cells = <1>;
+		};
+
 		s4muap: mailbox@47520000 {
 			compatible = "fsl,imx93-mu-s4";
 			reg = <0x47520000 0x10000>;
-- 
2.37.1

