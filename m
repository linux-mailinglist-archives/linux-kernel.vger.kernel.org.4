Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 243B1732F73
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Jun 2023 13:08:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345623AbjFPLIr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Jun 2023 07:08:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59200 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345446AbjFPLI3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Jun 2023 07:08:29 -0400
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2062f.outbound.protection.outlook.com [IPv6:2a01:111:f400:7d00::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA1493C13;
        Fri, 16 Jun 2023 04:06:41 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Xr9ixyLEieFs21i4y0HAnJ8d1dcznk14Gq4bUvgT1EgFNBkw2J3KDxh0aYgauOZ6AIF/e/225t3d3dLKtHmZFmacnQtvS6SkwpqJz4KPrZk5UmzrehJ6nR0gZ2GK8985HgtrF2S87nQBq9/5B5a/4jG4peUu2SZ/zAT07vWCBwRqc7kR/Gvb9EeRhz3XItcF8MbSy69b2Rt+leQUtyVYNh5a8DN8ZdGQG7mZt3Q62qzWPoWw8/ufFoexk+zFvD4GZausJ+yhA/R8pXEOtGx8Lc9I/PzkVm/c9rLKjrA1Lqpo3Ncqie2xw2s34hO8aSJXsXffRvVGdmBcK+U2r7DrLQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3P4IeMRZLwo/YRicrA79JgdAVN0iC/qiXtjWlXoXLdw=;
 b=G+UitOGO4CfkxNet0JVB7bKsY9YS/2qyiysQ202N/lE81cU41Sb8sodrEV47YutJUZ6FggOES5SYM+h55d0z71WkvILPiB6iOAONyLTxa2KrSGuUA7JSCR26YZOAZWErsJT9JRcm5uJiNGEXfmB8GeqNchYNrXlV82mV7NH0LezEm4kAHo8b/Ck6NfqxfjSVkwtJEwlr/8Kst0rAtXqyGAaozzh+/yHBl8JHjLQSK/ZHsKwKNI9q6lzbzCabzK6eY93ebJb1gq6bk0rlc5oxatibpKseOdoshxe4CvsmuZPomctG/AOUKaRQYregd1rKdj+RORx7kGOhTlCcv2YMNw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=solid-run.com; dmarc=pass action=none
 header.from=solid-run.com; dkim=pass header.d=solid-run.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=solidrn.onmicrosoft.com; s=selector1-solidrn-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3P4IeMRZLwo/YRicrA79JgdAVN0iC/qiXtjWlXoXLdw=;
 b=UkOfWWoVFw95vhPfw1vx+khQnlo6IhSYNuK5h4HwGfoQ7tb0Vs8z13wxj+uqf4sTVq0YiawI9N2KL/wX9bheL0YVnNkzJMaaQkzHsiEvSBXvVyGk7C+EJSNW5I/8Yf1L4lgOCNz1JLaxv0F6MbZFYOpT+Wi8zKNXSwNdtPxBcnw=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=solid-run.com;
Received: from AS8PR04MB8963.eurprd04.prod.outlook.com (2603:10a6:20b:42e::18)
 by PAXPR04MB9491.eurprd04.prod.outlook.com (2603:10a6:102:2c3::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6500.29; Fri, 16 Jun
 2023 11:06:30 +0000
Received: from AS8PR04MB8963.eurprd04.prod.outlook.com
 ([fe80::5a4:421d:f180:9105]) by AS8PR04MB8963.eurprd04.prod.outlook.com
 ([fe80::5a4:421d:f180:9105%6]) with mapi id 15.20.6500.025; Fri, 16 Jun 2023
 11:06:30 +0000
From:   Josua Mayer <josua@solid-run.com>
To:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Cc:     Josua Mayer <josua@solid-run.com>, Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Li Yang <leoyang.li@nxp.com>
Subject: [PATCH 1/3] arm64: dts: lx2160a: describe the SerDes block #2
Date:   Fri, 16 Jun 2023 14:06:08 +0300
Message-Id: <20230616110610.32173-2-josua@solid-run.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20230616110610.32173-1-josua@solid-run.com>
References: <20230616110610.32173-1-josua@solid-run.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: FR0P281CA0043.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:48::8) To AS8PR04MB8963.eurprd04.prod.outlook.com
 (2603:10a6:20b:42e::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8963:EE_|PAXPR04MB9491:EE_
X-MS-Office365-Filtering-Correlation-Id: 5040a435-35e7-4c37-85cb-08db6e59bd10
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: BGU6UgpbhnFI+w0AB23lbVDmmSsHo5KBDC+tJXxZWkMx0xyRLVRVU+OSdvtMq1cpQkjJF2v71kKf5tDBkYyBvAlb5Zzo21lOgvm8UouJJUD6pD1/JPhdsWXfY1Mp14UmyY0Adqsj9ZPewefjU8Qo/JY6PqtdPqsp+lB6jR7gk1Ap5fqIA9fzPBuQ4RX2u8x42pKeOTVFDYF7NiTT9nZ+O+2tbaWMlR0fkA4KdBHtpNKX8YvWLiRKBnPf5UF256d4iA1pLUa7jNr0z2AffVeiL9uaJgQxEdEx1xJWjFMiPyicNj4DtanOWrFqil45ZAy9eLTlLGHXSWyZ2bNDfMbS53s8FhFvXiKm4Pd5Vuc9syGra5rQtxDly2vdo0a4t7OxzeGW9o4u7WK8RIhUMudHPA7AP/O3hCtkiQ0Ez81tK64HBg+u/X3ne4lZ+s+nWsQL/EFRACUoXZ0ke+1mq/L6MNciGbIgMWPvqn/wjPc09cplkKJHjZhdZMVvCu1Y2PkOzWd+VYzglSLWTes5jgwXskimcPjpUPKQfIa3B9zyhw5V5SMBxPeNkWLg6QaOThzMWEsnUwpkNROB+Trxd051TZz5j0pUfjzopypwfcBPCV2XALJYf+QGHeDLyQAeNuYH
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8963.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(39840400004)(366004)(136003)(376002)(346002)(396003)(451199021)(478600001)(86362001)(52116002)(6486002)(6666004)(316002)(41300700001)(38100700002)(38350700002)(83380400001)(66556008)(66946007)(4326008)(66476007)(8676002)(8936002)(4744005)(2906002)(5660300002)(186003)(54906003)(6512007)(26005)(6506007)(1076003)(2616005)(36756003)(7416002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?mp+3weGR80MNIxaIkGQFIpY8RbKTzpeeFGT9sUdWqRabSv+HxCulPKHXVhQz?=
 =?us-ascii?Q?tyIv/xvaxZAq7v6FY1cI+oNT3t2moFHyXbIbA7inuY6n4PvmyZn5EdMLqAc5?=
 =?us-ascii?Q?d1thrIzA0lyshE/TyzYQhR0gKPO6gevA449PQsUXwijMr3h+tQpiHMSawilk?=
 =?us-ascii?Q?waiz09tYt6DevlgAC0rAsY9XakWX/5StEMnzlRZWe778SZfwUtgOzcwOtsLT?=
 =?us-ascii?Q?n2aHEe/+ZyEwO2eG4c1D3WBXJuSC4vpC8HqFk2c3eLC/FOJGgM4qZ8mAmiUt?=
 =?us-ascii?Q?cnybJw8kDZU2rNbi+fzC5tjGLhYdsdXxEeOCv9ks4JLcerKp66yHAL9G/4D1?=
 =?us-ascii?Q?ea+G2Hjsc1PFKhNwuMz9lSHOrWUrCIOpTISRQPm6TLtUMZWAWz5WldYx+/W8?=
 =?us-ascii?Q?+CuX4KGjLOJXYDhf1CRIHaqvV1r3axM+DiGqMBn4iJG6do/2BAHQVHmiIVX3?=
 =?us-ascii?Q?02ld5WyqMBmAHJkMqOR84waJpjIrENsDxSQYYKcZpn9TVLivIu73NSBW38Xa?=
 =?us-ascii?Q?OJOXLU0cfU84wLB8J4Hmd6h6MIl4UIHmZB4mrir/cbw8ST90bImRQewGgMg6?=
 =?us-ascii?Q?Z1+qyrXaWEnMKFCgKu76+KpYn4MUcbxu5RBiTwDMJiXirDk/qsa6ojyVaDP9?=
 =?us-ascii?Q?SQ3OdrF3NuwfzlWodM+7t+UCVh6AaqxpZu6fP/d7MQt3uUWp0bIG7POZK6Z1?=
 =?us-ascii?Q?p4ETGwlYhdeUF2lVsCvP34x0mEC2edhKtp18NVfGGXfJy+7APC7ukhMIDtZd?=
 =?us-ascii?Q?0teDrkkmvqEvb6FC63r3m7H04Wc+pInU6e0H+spdHvGv2Og4jP6zei2/dSGk?=
 =?us-ascii?Q?yIJAo6uHLpr5q5x4uq8b+jjM1RHUpajI4paEhY0Wsxje1oqOayKoJrmPO5bL?=
 =?us-ascii?Q?f9bcZInZy+iDG4Vu2yypmc7TV0eTxQ0uKLd62jS69fDlfD5yO0zOp4Bo1aV6?=
 =?us-ascii?Q?Q9XAcQxGm2Vp6IsJ1tX4/06AzLBkiijOH4201fgf4vRAROMYO6erq3dswjcn?=
 =?us-ascii?Q?iUpvHQPdG0bn8Od8/K82VdRsegjqYVnGxt8ciTOLXG/UzYSzdTU99BAtpgf0?=
 =?us-ascii?Q?Wu051MhJnSjXWS8GIbkKveheZTUGw6KZvPWlaC6io57c3bBT+79N97aEMIxn?=
 =?us-ascii?Q?ZxpHm6rijYcpDOBthpzpoSCuLXkSwGORVWuR1tjRRjacgcBUHkU9IfBHsUyA?=
 =?us-ascii?Q?MZXZwAti/flzC0mh8SMPYURuJCz9Lk/TDHzs5+YP7Yp2qCnuW3bdUrjZnO+U?=
 =?us-ascii?Q?1wlUYRS36qNbYxTscZq2t/ciF1XIbHiAbti0Rv+Joo9RiNpLhNsIsp++4dJN?=
 =?us-ascii?Q?qpLzoCfsRKF+CPARpV2BkNbUfpZorAtPEKWdoFEQHP48XtKLUcEJg7nDpMdk?=
 =?us-ascii?Q?UOz/oFn43QPrudRD7ezDM/rAUTe1x70ShKKixjBsW4D6hRty8j6Th7Nz6XWG?=
 =?us-ascii?Q?ApDF3lX3Zpy2N+1F7Kc1v8efd2wvY96MQPXbRwmsNgjWJmEG7LDwDZ/djRzf?=
 =?us-ascii?Q?W9Eismzl/dQYd8Ju7aylVcDH8Wg/8GIK8vT21qvpxBztUl2uYON6Cd6BzxFB?=
 =?us-ascii?Q?Sl53ww9zi5rbhCnfffNIG32uZ2e0pz9XYFD+y1k5?=
X-OriginatorOrg: solid-run.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5040a435-35e7-4c37-85cb-08db6e59bd10
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8963.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jun 2023 11:06:30.7845
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: a4a8aaf3-fd27-4e27-add2-604707ce5b82
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: O/r3GNDUqmQ0qehmRfm1Zhtqf9S+B1KHDrb5O0H1mkuSVwNBKpouVW5QfITMUFnksMG8gdX9q84bXYyZicxq3Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB9491
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add description for the LX2160A second SerDes block.
It is functionally identical to the first one already added in:

3cbe93a "arch: arm64: dts: lx2160a: describe the SerDes block #1"

Signed-off-by: Josua Mayer <josua@solid-run.com>
---
 arch/arm64/boot/dts/freescale/fsl-lx2160a.dtsi | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/arch/arm64/boot/dts/freescale/fsl-lx2160a.dtsi b/arch/arm64/boot/dts/freescale/fsl-lx2160a.dtsi
index ea6a94b57aeb..2e68c05181dd 100644
--- a/arch/arm64/boot/dts/freescale/fsl-lx2160a.dtsi
+++ b/arch/arm64/boot/dts/freescale/fsl-lx2160a.dtsi
@@ -626,6 +626,12 @@ serdes_1: phy@1ea0000 {
 			#phy-cells = <1>;
 		};
 
+		serdes_2: phy@1eb0000 {
+			compatible = "fsl,lynx-28g";
+			reg = <0x0 0x1eb0000 0x0 0x1e30>;
+			#phy-cells = <1>;
+		};
+
 		crypto: crypto@8000000 {
 			compatible = "fsl,sec-v5.0", "fsl,sec-v4.0";
 			fsl,sec-era = <10>;
-- 
2.35.3

