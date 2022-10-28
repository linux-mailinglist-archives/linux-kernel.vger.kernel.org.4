Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 63FF1610DC6
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Oct 2022 11:53:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230326AbiJ1JxI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Oct 2022 05:53:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38044 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229862AbiJ1JwW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Oct 2022 05:52:22 -0400
Received: from EUR03-DBA-obe.outbound.protection.outlook.com (mail-dbaeur03on2072.outbound.protection.outlook.com [40.107.104.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 477C61B4C42;
        Fri, 28 Oct 2022 02:51:06 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BTiNvFUs0ZO2I5MyU61xIcQq+tTz9Fm7uGGy1sTfb0sCfda+fmwhRAGo/4UhcIm640qXM7J7V7hTp6bReuxAfWkuBi98PnBoSyN1Jo6AIQ4Ji0WHowS9lAgayq6MwQx29quA0jWnlvV3KKp67TZoU0g2pjOLAgiMzB9mm0R/IqNix/ZxwcTccldjmDryBEM3LoRjjdyyXFzBHsgW+I0/Xvjmcse74wu762B9GqVW5ldfd87I9P0XTM3b0qHW35rXUAOcAmoz2ARi/VXL9KbNUGVglXa4rm4tsX+dwsITY87AZqi22sDAnaeavExwypGbqi04Mi8bY++FvWWP2XYO+g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JBupbEqng/SLogKyNbwJACyshilZfvz645synm/8LQc=;
 b=RWJKDOJ45OekQmTQKDnOstwDSZJcCz0bMyTGruGHNtnn7PLtfC5sTPVe1guQvYB62fCuIWy2a8cOq+dXam5N4G+Dmrpb8ODXA1i1uBEeQNfe/T0nx57aOH+hLawd3101nf/KVc1PcCWCFcLwMoF4FiAIq+EvuZSnsBqLUzENZEtD6Z1JIxTXZA7EnTHuwxI/CsJ1V9FL6wcGtrFox+OOxAb55zmlJbz2Go2ubUs/Bn6Dxkpr6j7yluvXxCpMUX1QpE9h47BZFOb0l8k3EYH5xODksbzCim5KotChqWxxFIq4Zf2yZwj2YyE+fS7+nFCP20BH73BO1//ddCqPOv8wgg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JBupbEqng/SLogKyNbwJACyshilZfvz645synm/8LQc=;
 b=hFmhd/89nwp8+ulH6may/8g/SwYEYWSZrOuwalUF2xF09r7DqpkxI7MYbb4c8gSiwFkeesZHJV9MjHr7iwCQGPJjnco2lWpKnBptzkZ95IcTbLU4gKUrZNUj9Xoyta89Gsf217h7ShwXb9LYUnaSIlGD9HgrVMfsDpQB3eu49eg=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by DBBPR04MB7690.eurprd04.prod.outlook.com (2603:10a6:10:200::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5769.15; Fri, 28 Oct
 2022 09:51:03 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::1587:379:da06:2f18]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::1587:379:da06:2f18%5]) with mapi id 15.20.5746.028; Fri, 28 Oct 2022
 09:51:03 +0000
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
Date:   Fri, 28 Oct 2022 17:52:08 +0800
Message-Id: <20221028095211.2598312-4-peng.fan@oss.nxp.com>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20221028095211.2598312-1-peng.fan@oss.nxp.com>
References: <20221028095211.2598312-1-peng.fan@oss.nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR02CA0050.apcprd02.prod.outlook.com
 (2603:1096:4:196::11) To DU0PR04MB9417.eurprd04.prod.outlook.com
 (2603:10a6:10:358::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU0PR04MB9417:EE_|DBBPR04MB7690:EE_
X-MS-Office365-Filtering-Correlation-Id: 92923f7e-1da5-4c8d-7d37-08dab8c9ed40
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: YwLytlnZaZ1kVKc2FmNVw/6TRz7mRfPdW1IoQ0MeMaoFIRJXWYgnpMDRAQkQqTDaHq3LvXZMFWjnwuMB7+wrHuOTzadQYmdUsvqbd5SQc/xGTOWsTEUHxWixTPzPtJ8hDRVBMkgP63ibt2dHfYqWO+Dz9YvqmgeNyp1mSbUAbh12WR3Q3kgaqDzIYgwnqW35n/LIOAECDD9kNKTkocTZUQR5YCTGFD41RnQfo4HLKNYiEl46otcmpqk6SW/6WVWdiTOasxTAZ9iTt7wL/H7SRColsjCdoo0fu6ixvNj7pHgjRkUzqnZ7GBoOTVarT3Yc64IZPAtt5CLfwrWmincmiSn4n6/O+SB1RyQmhFrCLimg2rll3JrS+8wP+onwTdZP7D0jaeGLi2dve4D88K9NVQAdyQS1IbluHFzViJZe1XZGrOVfZ4ciBas35otln3BXe7mPbSt1IL1QzH+LwcfNbEvu4SKWPn2lRk3y3WaRvRQZca6sAs2uHyma82fWFMYyGtEyot0Ogo+k5mN2VpfhSGftLHHhWELtE6POqWzKMu7BCI3RGV0ClIFX4MMBPcDMc0ImRR+IqYH1bKzM62gxy/6AXvwGVq1WcxM9UpmAZ0Ilb1G1nzsJzpLGPI8parBgWATwOGou/5+cIdTLPU9hRhuwl2YDbJjlGbH+9XpHV3X2bAarJ4gFAdtT1cnXqDGrGYAXZ0xC+xrvJgZcJHu8DH8kJWZUQMIhczMXujcoN/ly+yW/8N90bsSl7abhZQb1T2s2dLtUIfjgN9Msz7cnWGEofUekw9NnpXKq0bxtOoA=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(376002)(136003)(346002)(39860400002)(396003)(366004)(451199015)(52116002)(2616005)(6506007)(26005)(6512007)(478600001)(186003)(1076003)(83380400001)(8936002)(2906002)(316002)(54906003)(6486002)(7416002)(5660300002)(4326008)(8676002)(66476007)(66556008)(66946007)(41300700001)(86362001)(38100700002)(921005)(38350700002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?jqaQMaNtsFAnD9LfZ4MhhB8ALBgeXTwOnqbNZUItdEhKKoBBEU/y2/NdqY3J?=
 =?us-ascii?Q?PF0RjVqwIH7Urg/kf9QeJpq0tVMJwxK6eUTS6w+DtdI7BezwJlEW2WeDUx6i?=
 =?us-ascii?Q?t4Th9ftrxFsBb+2BCDc2TDz5YKYySmBdgMk4JY+6J0lAeQHCWau8F3gcb8Zf?=
 =?us-ascii?Q?FaikDzjp/RvZYGk/pfFiX6ofMLQRrkOX9X928wBvJBy9+YOZj37nn0UcTodC?=
 =?us-ascii?Q?kTcMGF16D02QThl0BwyXBx1y08G9PewD4sbBKS1g/dztA2pC6mje9mHxBp1b?=
 =?us-ascii?Q?KhVCRKFDVcMrEmMUWDh/H0rlieibt6GKsJ9AIyykqqtP87eP1FEy2qsp/LP3?=
 =?us-ascii?Q?Snc4VTSJq1qI9eAyN59/ZyOrl2oLoHsCs6rbS4QBDXNwEOJCCXxdwGgLHk4B?=
 =?us-ascii?Q?OHeP3JmcgsON3RSSeidM6w28391RNFRssJ5fj8s9jVLjwBIk8YY5ZskgTOkA?=
 =?us-ascii?Q?13pNYO3CNyuxCA8i5G8HPaFnGfEnrFJ+JsVRqHjXay/+UUS6AZ0ut/DvvK9c?=
 =?us-ascii?Q?VXYsAtBE/B+Zi/kjUui7OdfN4PdZXXpRelDjUOsfep7mp4ATP6ToXamh5Sqk?=
 =?us-ascii?Q?ce8S9J998Sh2LH9hijPX0i9QnJh4jE3gJXRRFMAOXEJW0IXjmM6L1pC/QbIh?=
 =?us-ascii?Q?6090fW/4r9FajVCSfzWtyvO3YD2tXRjSPZU2n/jNq884qnyGI49CLLi4j3Z6?=
 =?us-ascii?Q?eAUQz3TQlXd7Cm5rgJvtwUx4kM9GcgyO22iDmjFEhFj5OLaqqCYQsk64XG2l?=
 =?us-ascii?Q?KKrBLlfiua3CIukDHt0wLUZMvKuj5aFNaAvMUZq/R86Rqg5OPwvFST3Ba89s?=
 =?us-ascii?Q?QrsFm/112Z8l9qyVGweZfP2BiR779noEHDwnEsOExnDjVWYWMovktG23ziAc?=
 =?us-ascii?Q?moXU6e01XwgA0SI2oQffO2E74GSma6f8Lv0o0j7M8bwx3utuKQLcslpy50GA?=
 =?us-ascii?Q?CYnrDeFMYk2zUHtYs14odCjKjfsICkg6KTs4dp0rej9jDxzfhW1twXj4kFUB?=
 =?us-ascii?Q?x6JBEJAbPk1tjxdvfjvwlj2JF1sTLxEF+5GZzbv/wJBzEGAxmI5iLM8330V3?=
 =?us-ascii?Q?mEamu16ywRFK5N5p0KU6tCdifez0E/MXsuSO6vdYSdUEeC87ihzlx0Z6nX6l?=
 =?us-ascii?Q?8evkGOol5BkphMIJD/X8uMU1Cj8m98s56LXpKlhLnnEYVAo8dUth7tyHwD5U?=
 =?us-ascii?Q?gcEsLA3nyCESBmsHKNVxgksAEkwNZPFd8xp9Jqr2Qdr5BYZpFhCMO1/W4sVs?=
 =?us-ascii?Q?W+ffIu3KjYe7WDu2VeBz+/rYlhY56CDCqlCM0j6tAg7ats4rNxQXOpA/3pry?=
 =?us-ascii?Q?6I3eRiNv8QpL0cwwsX1GFB47EeCPA+X2TqnbRa4LJVRTbnS1gzHPW7nETwBl?=
 =?us-ascii?Q?rVYYotK/tXex1YNPG/7qJSi5aXt+ERmTi8ooQ+W2yGLQyw0FMPNuO5iQFOnp?=
 =?us-ascii?Q?Rn52hM9BISOx1+xGT9ZKffyvQpWeStligtVip3pW2MwCkAKL6ZzhViGrKcu1?=
 =?us-ascii?Q?jeOIYnKQ4tfxOAGfMGqVrRwFv2WF1jAy63QtxOOHxZ0YCvZI2E/j8tZGYh3W?=
 =?us-ascii?Q?SmcneRvmP8ytYSPG6bV4Y3QaGJMOqjh1aVI0zdrq?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 92923f7e-1da5-4c8d-7d37-08dab8c9ed40
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Oct 2022 09:51:03.7696
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ro/GpttWT9Lqil6MoB2QBbotb3A/Eddu1VvodiIbiJxBkVxocN1XFIj6RXUKIY+dDypqG6bs61TVN1jMuu2Aug==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBBPR04MB7690
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
are reserved, it is because writing the CCM registers does nothing
because the TPM[1,3] and LPIT[1,2] IPs source from bus clk, not from the
TPM[1,3] LPIT[1,2] entries. And because there is no SW entity is using the
entries since adding them, let's drop them.

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

