Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CBC8660F48D
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Oct 2022 12:11:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235252AbiJ0KLM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Oct 2022 06:11:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45824 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235170AbiJ0KLA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Oct 2022 06:11:00 -0400
Received: from EUR03-DBA-obe.outbound.protection.outlook.com (mail-dbaeur03on2059.outbound.protection.outlook.com [40.107.104.59])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A6992951FA;
        Thu, 27 Oct 2022 03:10:51 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VOenv7W04nJB/qvkrZsSJknsI+mvIPLaGetHP+WjmHQykQ4UqmbXb9RUwF2de8NvTCzqBFJe/3mMSjTDzVP81s9Yx9FnZzUYJizAcUL7xQjm48TMOg1kXVtxsvqxBMf0KqXwI6z5Id0VSjwCVb9nNd3YMdqT/fU9LA7K0dSwQPPRS5FGWMgraWZL6Z6ZF4BBVndUJPaF3RYLLqcvpEeDvN+v+7tm/RwXoywob0O4z+EPQLh2MSdBzA/Ui95JOsKHVnVbz9IuQg6OUVc9TikyzxwjZXyNVK0jJOTFYlIE26gBcmFS6j2U5+nfK2vDj2ZoNkXbZfK8feywADOn7CqPtw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=E+mx0kAtvjjSUhuPw5XHfBGS5hP6FVbE4Nm6S/QxU20=;
 b=EsB2E6muVce82PNP8HjJ7ryaVi49HUcFIXH+0BBSUh4S+R4tUc/6TYACrNjWsCF6bCBF++P4dMf57Y5H7XQdlkxzez1vasETxmFcBRq4qiculgkHFYJd1/5nt6VblusCbtAMmhtt6PdKSuyCjpIEPGg2Bpnyg94V89wsNyFlkKQMws3M+gd948a8Q7WHmd44wJyTxmJ1D7Qs4gI0IiX5guuywG9H9zYbhewu2kmBpuSfILE1BTaYVKu/GArMD1u8pDnpRp17ngQzRkNrnbzMz64xhjQJ73dYw5kXfGVOS3lm/EAeZ5Tp4fY4zYs+XPmUzUCoZeHVIgH8b2syUCKf2A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=E+mx0kAtvjjSUhuPw5XHfBGS5hP6FVbE4Nm6S/QxU20=;
 b=cBgMNzHh9ROiNL/tjE7Y6hop4A7ncmF/Lrk/QSZQQFzh3Wi/8u0BJT4q285vJf/NmZYlr93Nq4tFMzFSgjP/7PD2VdF9hiqYKYxJE8aqL9/azKUJoxz/R6iO0TWS191mCPTqLRx7UtPIoqat+yn2DMwe5W8lHYXXKljvoqpfr48=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by DB8PR04MB6875.eurprd04.prod.outlook.com (2603:10a6:10:11f::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5746.28; Thu, 27 Oct
 2022 10:10:48 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::1587:379:da06:2f18]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::1587:379:da06:2f18%5]) with mapi id 15.20.5746.028; Thu, 27 Oct 2022
 10:10:48 +0000
From:   "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
To:     abelvesa@kernel.org, abel.vesa@linaro.org, mturquette@baylibre.com,
        sboyd@kernel.org, shawnguo@kernel.org, s.hauer@pengutronix.de,
        kernel@pengutronix.de, festevam@gmail.com, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org
Cc:     linux-imx@nxp.com, linux-clk@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, Peng Fan <peng.fan@nxp.com>,
        Jacky Bai <ping.bai@nxp.com>
Subject: [PATCH 3/6] dt-bindings: clock: imx93: drop TPM1/3 LPIT1/2 entry
Date:   Thu, 27 Oct 2022 18:11:56 +0800
Message-Id: <20221027101159.942843-4-peng.fan@oss.nxp.com>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20221027101159.942843-1-peng.fan@oss.nxp.com>
References: <20221027101159.942843-1-peng.fan@oss.nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI1PR02CA0031.apcprd02.prod.outlook.com
 (2603:1096:4:1f6::11) To DU0PR04MB9417.eurprd04.prod.outlook.com
 (2603:10a6:10:358::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU0PR04MB9417:EE_|DB8PR04MB6875:EE_
X-MS-Office365-Filtering-Correlation-Id: ca36d366-cbe8-49e4-b4f3-08dab80384e6
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: NwSHOOVTgVMJ/UEr0rowkW2mZWBkrboIKV6EE65SY5KU6asql4qbBXZoLDw7YH844R5075jLzswpSaUUFfto8JjeJACDPDMDTBKtSPUKhU8ZLWkwCxPvKOIicGysDLKM8Wury8Ci/F64JdTQUTrkWyRRaRnbivhzAMQPLCSCx0QVlAaykkflJ15GIRiKQTSy8we8K/CDVQ0SDFuiVxapptSrFXkV/C+t5rTzXqMdPW8OGsliHSaqyewfZTBYSi9g+9vdG8E6lWof4OTPzIqV07npuDQoqHNea9KvyFZbauuQZtWsEtro0RSphNp05nGEhDTaAYuIRGaXfSAkU711FJh6z4U9E48zRaXFRZRTeRovKfr/j2YsqpvfI1c1JzYfyhXB+zv1dqpZDHOhJZFA/rN24sqobKrAkytTH5kT65YaB8vLPxcH3J4LX0rRmBzcfP6Juj/vAuW27SdmdREttHhgAu2omOYZI0zA623C/OpSA6ZhIO3C9JnkOZAd5i4hq3Jrns7Ql9kz+onAAdTRGaoegArZtGOlG83KrAm5EB+Xz8W2ybDy+jRZLRf4p5xlL93V3hNQwKLV5F/xwboHQptwnNIl2Pw29K5U2K/dfBhGU1ZSfjyG6PyjGZ/LNUhNC4oL/IkAYQRlzU295p1e1U1OrVIW1xWlbmZAnG/id4ZRN4ZcbzPWYufHAComPOKndqQ7TM26Xh2u40tylppIcU77+d9GGmjUfr9jC6mFqmutPE6HHYoLucxbgqvc3Q6Mv/26UlMHcOoLn/nu16Yb/CI5TNfB+i21IWdsENdNBXk=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(396003)(39860400002)(376002)(346002)(136003)(366004)(451199015)(66946007)(186003)(2616005)(6666004)(921005)(83380400001)(38100700002)(38350700002)(2906002)(7416002)(41300700001)(1076003)(52116002)(4744005)(86362001)(5660300002)(8936002)(478600001)(26005)(6486002)(6512007)(4326008)(66556008)(66476007)(6506007)(54906003)(8676002)(316002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?YN9nHolBwPfKykqEKMWyAxeN0m6FTIHqYl4HtLZaHaBBYfMdAaC3U3ltiXdn?=
 =?us-ascii?Q?w4psM9+nGx7H9fU8qd34A+HHaTjOoJ9gE+47RiK8wLZByTHKP498cyWHrHh8?=
 =?us-ascii?Q?+YJ7Q1prv7KAxsYmEejUXV4JroGGE2WXPnJdgsXBiSWz6aD2b729bkI7lNGo?=
 =?us-ascii?Q?iwfNb4XEVMrCgwfLiLZHh834dU9z/vgoRA+A6uEYhZaZGJwp1XM6NmMLbpbZ?=
 =?us-ascii?Q?N9o15hSMZSmCqmh6u2Mmr1wbetwQvEDe1s4ZkBlDkZ0k/XrYqi6QEy+MOsHi?=
 =?us-ascii?Q?eFsgcc5y0faCGHIIxNuvEnTVeKYkY41hWUfU1sQHvUXYq5+/E1mJwDNxNpm/?=
 =?us-ascii?Q?Bi8buMl+FTmP9v3NrcIcf17ux0WQRTV4VPQUOnap9wOG5PlcjK6aSh9YDoyR?=
 =?us-ascii?Q?3zGDrDQXc6Eg6Jq0kHT2Pi5N46wA6ih4EPnOxTK9qDeUCpQUjE/evnrcQmei?=
 =?us-ascii?Q?3Q5Sr72wggwn9OLnc0tx0y98lSW03jlaM+OtaCHKW21SXClN8+mxGDzcyBd9?=
 =?us-ascii?Q?E+61B0XRp7rkqFX6ie0EfU/o9Fgmq7eXXLHfzhzsRv6xk1y5bULcEq4g9pW1?=
 =?us-ascii?Q?QkKI59z6y+ig6kOuTD1Zf2lnDj3x08DD2rLZhzhevtnZznuc/rDS9BW/5lo2?=
 =?us-ascii?Q?+aOgkboquwirmY8IWbEcll/sUrY3pU8+3ae2EcQ3TflGvs+YnrzX0sj6R6Li?=
 =?us-ascii?Q?96XqCj/1L3omR/WWiD8eYUcRSOu9fj4ZqVymqWWPGYtMJMUHn+bSh53VYSlQ?=
 =?us-ascii?Q?v9GnTk2vaqHesaeMw+/0jO6RGB63kPT1c0D7RaONxPEq96AVLcg3c2ejdyxc?=
 =?us-ascii?Q?bNZIkoswK7v7G1TJHJ4r2Qqpp5wuRgaAQOkiakc9jb37h6K/TNw211T1oNYS?=
 =?us-ascii?Q?WW6RD0uUosQu1Om19Ybp2AhzdvnrT/yyjT+ZzTEGk4JboiE8EKFcCCgZ9Cyf?=
 =?us-ascii?Q?vGxHJJfIm4rQeK0n20scSDyXXak5Wdvui4PoqcsU6yf8+rlM996CztrzuTKm?=
 =?us-ascii?Q?A0EETz6dnTRgWNIt4x5fTGsA2nC8B4BEEAYhtnompVWTwEWFk7UgCxxmw088?=
 =?us-ascii?Q?kKTKP5Xf3YU7cgqi4PciiFOlCvqh2+zsUjnvclXe1KjE0pz8ZzHnlAiRGwKr?=
 =?us-ascii?Q?y5cK8nFJezBi0yPJySR4WXTT1gpMIlfVyPicwQIYgE/QPGhXXk5P2h8F4ol7?=
 =?us-ascii?Q?LAHnZU7RjPIc7n7oqZJuCVvR8D6GgaauXJ4/ozunAhHTm1N1ErvjC6isgT2U?=
 =?us-ascii?Q?qO4pbgPMR8kZoFis1sILVtkmRflTubU4c1dHfOJAesg76bufNdqBbIeikABD?=
 =?us-ascii?Q?0hXF39GrDQn7XW6wansYNUA2ObTRDWhc4V5AFikZVzphk4ngLiAfNhYsS3fc?=
 =?us-ascii?Q?6HLqT2gpLh4ZY95BHW7VLzMN/bybDn10q1ZnfaIl2KrJ1Rbi70yBqeg3bU99?=
 =?us-ascii?Q?ju0cpGre6a2IdlR8d3SOD5+ZRn/IyXC1BiMBBaPzYpw/Op3kwUIIlQuqMKYH?=
 =?us-ascii?Q?oj5QH77+9QG7X10JcgUA2jC1T7eCHLZmRFRFEr+R/fc1Ck1ZavcICauYsRuy?=
 =?us-ascii?Q?W2fjeSqTdMQZG6uEVtTwAhm4Egu8mdXc+26wZgRs?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ca36d366-cbe8-49e4-b4f3-08dab80384e6
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Oct 2022 10:10:48.4220
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0HU9r0LUlq/M92NEowTaYzcGCIxHK0bI9PHESf0Y19NtQe6bNI+r/urSPZoSP0KeFPHgsQYVReFCWJHaYEnbcQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR04MB6875
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Peng Fan <peng.fan@nxp.com>

Per updated Reference Mannual, the TPM[1,3] LPIT[1,2] root clock entries
are reserved. So drop them.

Reviewed-by: Jacky Bai <ping.bai@nxp.com>
Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 include/dt-bindings/clock/imx93-clock.h | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/include/dt-bindings/clock/imx93-clock.h b/include/dt-bindings/clock/imx93-clock.h
index 19bc32788d81..8e02859d8ce2 100644
--- a/include/dt-bindings/clock/imx93-clock.h
+++ b/include/dt-bindings/clock/imx93-clock.h
@@ -28,13 +28,9 @@
 #define IMX93_CLK_M33_SYSTICK		19
 #define IMX93_CLK_FLEXIO1		20
 #define IMX93_CLK_FLEXIO2		21
-#define IMX93_CLK_LPIT1			22
-#define IMX93_CLK_LPIT2			23
 #define IMX93_CLK_LPTMR1		24
 #define IMX93_CLK_LPTMR2		25
-#define IMX93_CLK_TPM1			26
 #define IMX93_CLK_TPM2			27
-#define IMX93_CLK_TPM3			28
 #define IMX93_CLK_TPM4			29
 #define IMX93_CLK_TPM5			30
 #define IMX93_CLK_TPM6			31
-- 
2.37.1

