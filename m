Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 591575B89A1
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Sep 2022 16:00:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229917AbiINOAK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Sep 2022 10:00:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48050 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229815AbiINN7o (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Sep 2022 09:59:44 -0400
Received: from EUR02-AM5-obe.outbound.protection.outlook.com (mail-eopbgr00074.outbound.protection.outlook.com [40.107.0.74])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 796F7BF42;
        Wed, 14 Sep 2022 06:59:38 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LM0kNYkfLlU1nYrobdDjLy4SoVAp7DOJvEvi1NihWOfKBWCZ+wtc31Eu28pYvvsCnHdfcYrN6wTa2PDCOhMLA32m0mKoEhB1TH0IqGOPLs0yTQawvQFhZ4CGUht2jV1lK/qQ6xMSgRA3ED2KY7PxIBXpL1UtcWGqC4O6j68Al1jTeTV7F/5cUzIZSKsKgovucDAf7dX0kYG3ksezMY6LfWsmuVdOdE7WJSX8eWp9IYa16XavXiCkbb+Q3pjVWjS1lDzhwc4IoF8p5WR5S0U43LtNPaFIcowOb87ucF9j1U7eBsX4NhKaeAH32Wynm4dBDPz0lMhOsXDueKbvtsenfg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EHhiC5QsF+JzIhG6doRHhCQtHC9jdJD///6vKdKxEAs=;
 b=Hy+4aJcqBksNGCD+6/UtbfWxe+d5HU759yyWjH6YHp7bpuDibjCC6Y6pWOrdOesYEH8ZW5oBZD2SAeOWTKNqXTSarwwcd6s3wGbhRmq+VigmdprMpk1t4t9V+FOwfdWa7zsyQMoObQ+DqnPhVCjDWZEwsxj1TX3KWSC2D4vq70307ELveZfoaerOzY7aRIudLDiA1YpdN1m73g5LtAfKc0nfUitXiqXk+kjVdhj/tj12nJF2g1Z05mHfhtzDCtTe0QQG6K9cMOnrIg3Ya55AABDmc0ZI+xxhN+yWWbh+cAkYrqXOtKvyq6UpG7j5ojj3WNXZtDQOcH9ssWvzt1I35w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EHhiC5QsF+JzIhG6doRHhCQtHC9jdJD///6vKdKxEAs=;
 b=mtbICgTK9nlhSevXMr1ihLR72PLRuGg6AGtDamH5djqQPYYhScHlWGE0wOPGQi7rYR6sPig/GcPWFWFU6iUaxj4YnvXgssbRut8egSv/b691Hy2OcXhiblbjurfMtVUDtKOcWHJVifY3LrvoFYl+M4QK+wzFkRr1fAcfknEgOss=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AS8PR04MB9176.eurprd04.prod.outlook.com (2603:10a6:20b:44b::7)
 by DB8PR04MB7129.eurprd04.prod.outlook.com (2603:10a6:10:127::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5612.22; Wed, 14 Sep
 2022 13:59:35 +0000
Received: from AS8PR04MB9176.eurprd04.prod.outlook.com
 ([fe80::a552:97fd:60f4:edd6]) by AS8PR04MB9176.eurprd04.prod.outlook.com
 ([fe80::a552:97fd:60f4:edd6%7]) with mapi id 15.20.5612.022; Wed, 14 Sep 2022
 13:59:35 +0000
From:   Shenwei Wang <shenwei.wang@nxp.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>
Cc:     Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Marcel Ziswiler <marcel.ziswiler@toradex.com>,
        Marek Vasut <marex@denx.de>,
        Alexander Stein <alexander.stein@ew.tq-group.com>,
        Max Krummenacher <max.krummenacher@toradex.com>,
        Matthias Schiffer <matthias.schiffer@tq-group.com>,
        Denys Drozdov <denys.drozdov@toradex.com>,
        Tim Harvey <tharvey@gateworks.com>,
        Alex Marginean <alexandru.marginean@nxp.com>,
        Reinhold Mueller <reinhold.mueller@emtrion.com>,
        Shenwei Wang <shenwei.wang@nxp.com>,
        Viorel Suman <viorel.suman@nxp.com>,
        Abel Vesa <abelvesa@kernel.org>,
        Zhou Peng <eagle.zhou@nxp.com>,
        Shijie Qin <shijie.qin@nxp.com>, Ming Qian <ming.qian@nxp.com>,
        Peng Fan <peng.fan@nxp.com>, Li Yang <leoyang.li@nxp.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        imx@lists.linux.dev, Rob Herring <robh@kernel.org>
Subject: [PATCH v8 1/5] dt-bindings: firmware: add missing resource IDs for imx8dxl
Date:   Wed, 14 Sep 2022 08:58:44 -0500
Message-Id: <20220914135848.118616-2-shenwei.wang@nxp.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220914135848.118616-1-shenwei.wang@nxp.com>
References: <20220914135848.118616-1-shenwei.wang@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BYAPR03CA0003.namprd03.prod.outlook.com
 (2603:10b6:a02:a8::16) To AS8PR04MB9176.eurprd04.prod.outlook.com
 (2603:10a6:20b:44b::7)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB9176:EE_|DB8PR04MB7129:EE_
X-MS-Office365-Filtering-Correlation-Id: 679b83dc-7560-4280-7efe-08da96595ad0
X-LD-Processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: jFlwPyZT4QDjrTjLOIWjiNN+Du/yij5BSFlf/R/rdcVPtdhvst5waEsXNAJDDQjx5TyW2pRjG1s3JyQDiltrp4hZwI9+NSXAdCWZt+D2E5YlbvSPF97y9zzduTgI+4Wa8QcwpSJXZBaJE3SltucvGgqM10umBbeNg+6pJ2+NI36DTROwEMzYGvIReJ+lhFd9vp7k5C2u4d8Jt19442VOOwYfTL1fGslpsqPak1vZYDBz1KI7rJpmf0SvH/8hc2IFyJndVYpjw7kH1nKt3tJSTr2lvtjLb3T8BHEEkkx+6HYKjSKS/aSI4IuhHQrFfYXBVEf1cmjsivcDaV8HUDWw5KD2u/dlG16Lpjy3+pehDljiN/QRcPUPsJsVKZBP2Bb+gC8jk2aWniYMbC15yizW8JBBWq2v77DNUNniJaCGQWpoABCf5fMUsqR0q6v1nnSe2aceK8hSdDuvJiv7fgVoRhP8NCxau2uZK5em/Zg3z05S1Gc32+kr0RZoX1WPy+ngYfO66tm2ztQ1udskydNyS1OG0qQAfS12R7M3LwC0kUTG6xpRb0ZzQr768jj8Ea/zXHiwJqIEkK8wb6qSxg8BFxEcZVO07JaOU5RPPIL9gdSi4hDNfdSGLtn0caM5bAV5SfqzM3j9Xo5VRWg1ZhPAhE8iOnCt1dcgVZYo0heRtkiQ2SXc1D3ujxbaSYBr+hDhJO84SdIWA5Rtbns2uSWDPk587+B9NqgjmrNDN4XX5LYQG1WFB5A4nCEtjkTAn1HpYFOyQqdylfT0cf5eLALXRsy4l30F/zW0WrumlNrGU1g=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB9176.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(136003)(396003)(39860400002)(376002)(366004)(346002)(451199015)(38350700002)(4326008)(5660300002)(7416002)(66946007)(6666004)(55236004)(1076003)(66556008)(38100700002)(8936002)(8676002)(6486002)(186003)(44832011)(41300700001)(66476007)(86362001)(26005)(316002)(110136005)(2906002)(478600001)(54906003)(2616005)(36756003)(52116002)(6506007)(6512007)(32563001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?q5zS65AKIe8nkfo3BDvQa6OIbNNsGxKBHHdPmJlmIgz4/Qccv2ASbmCRRyIx?=
 =?us-ascii?Q?HVRb3e2q14Ec2IHFY3JwxPyQPbBukumCvCta4EbVQXRJUHep39a43GENVPXZ?=
 =?us-ascii?Q?Yo0ZKw/8c+08Pg8u3DBYHoLRSnZeBOfpspqrM6nYEZ9C1YA/MMlBWj+QfZ9z?=
 =?us-ascii?Q?5WT9MtKwCe6krQ26ZfEX3JAeK0nxGge/yU0xR8Rdo8DbIKwhsVyTY0Rqruye?=
 =?us-ascii?Q?WlfqRRXSai+ruvJLhIUSLauu9ylZpwYB/YfDJNb6wQjRPn5eF7UtWFboZwyT?=
 =?us-ascii?Q?rVkX2n3GHfXQqiCzFBGe8Q6kCQZkbs1jt7noY93/R+yy2Nj9IBBTDu4jOf/j?=
 =?us-ascii?Q?LlNkAfdi3ZzNakefWz/gOb18UtDQz+iEF3B0fhcC2o2vGjNjTZHV+7LIZbPz?=
 =?us-ascii?Q?t3sI02K/cydh8KFnPzuXDrUZZ+8K57w8vFW2oeUflVcH4+7y39l0wPy/3gNJ?=
 =?us-ascii?Q?QyeYobJHj70KCRtwtychdQLNc47YylfNX6YNK3pD0Bs0jG+oGaHEUAMMO8GJ?=
 =?us-ascii?Q?0Maz00lyOkuCqg+PAt4Bm8EDnPru6beGw3Sby6skP/lefCqwEj4j2fz6wOQO?=
 =?us-ascii?Q?eNGy1S17yz4k8QrGpJDTtQDDn4L+d5PjZmSX87llAbxq+UPyvZp65pQBfdms?=
 =?us-ascii?Q?Hii2Jr/O+3EtGidl2OEDSJ9podI8jkqlQ2313Ua6LYTNSu5A5OUCufJm18+0?=
 =?us-ascii?Q?Prdhu8GOPWGHG7hRKocKhQq/NOAhzXVf91+iqcVi8F867yn0pBJ4kFGxs07d?=
 =?us-ascii?Q?BU0hOFZ8KcAZnIJZ/q5B5y3TJF4l/uNIpWG0/IKvK9Jtq4GEDxYUYRB1wyeX?=
 =?us-ascii?Q?xVkYVxto1PYqUMtNGKOicyX9/Ie6ZhVg669+slzdojgRSszGzO7nij/uHAwb?=
 =?us-ascii?Q?aUfMeYo8VymBJhfKiib5/uPql4fxbUKr9XcHeLbWRChxnB/HfPt4FyuIGv+B?=
 =?us-ascii?Q?ipEezBDrXwJucZbuoo9Ioyrde9Nrtns12IxCUVCBx3aQThKreHGx3hd87aZI?=
 =?us-ascii?Q?gSdEw1SH+heVR1h/K3j4X9l4qI2zPfjTHZKCBYeD29hfvuzPMPnKkRPVKPJd?=
 =?us-ascii?Q?9QFQh7dukskSjSfKZg5gHJlVlt1b6qdAPocXk8lbKeos4F8JmG0y0KU/+eyZ?=
 =?us-ascii?Q?/Bcpz1c9o/9/7SnGvi2NSvVJw0LoXI2pYC7frhYIpgg6bIHtZ3DsUlkTV3fw?=
 =?us-ascii?Q?lHsOff4tOgcUS0ppFBvGC7jvmeepowBC4YWT1fQxWr0SVn5QznapNLN67p3V?=
 =?us-ascii?Q?zs821GJuT6awfiz8cPqvfXbVcP3s81mjdS9C3S+DmmAaMo4nFTrD450qswW9?=
 =?us-ascii?Q?HQAZ8eA+h1QsTgabpdgIMOnfdJYXmeJpKuI4w9OfnbjUu4+jX0nYpCDfruON?=
 =?us-ascii?Q?6Wu6E9tdJ3HX1XcN3ErlsyrmA7KSC7o/nQzOuCxnomtWFoISTJEgHjMFvFKQ?=
 =?us-ascii?Q?MqvbhJivvWcf08DX1Or5TVhjFTn58VOYGKDGtIIGqGokBe7Na06ZIZ9DLdTY?=
 =?us-ascii?Q?gfvvZcqSBp6n7ZymYeWPOj6PFJzMbY4awnxL0oZnGC5oklH1Rcr7MAaIJmmI?=
 =?us-ascii?Q?goYh0ILdt3HgKRKRxJbQfIS801ih2IKD5ZlCGYVu?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 679b83dc-7560-4280-7efe-08da96595ad0
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB9176.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Sep 2022 13:59:35.0434
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: g7V5k8wH1I8sThBCtXJy8zAC9T0sGZU1Cn/MkCvy3swW6/VmZLePMlinHlumt5nFLiZmLnQA6Li5kqExm1uh4w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR04MB7129
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add the missing resource IDs for imx8dxl.

Signed-off-by: Shenwei Wang <shenwei.wang@nxp.com>
Acked-by: Rob Herring <robh@kernel.org>
---
 include/dt-bindings/firmware/imx/rsrc.h | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/include/dt-bindings/firmware/imx/rsrc.h b/include/dt-bindings/firmware/imx/rsrc.h
index 43885056557c..1675de05ad33 100644
--- a/include/dt-bindings/firmware/imx/rsrc.h
+++ b/include/dt-bindings/firmware/imx/rsrc.h
@@ -37,10 +37,14 @@
 #define IMX_SC_R_DC_0_BLIT2		21
 #define IMX_SC_R_DC_0_BLIT_OUT		22
 #define IMX_SC_R_PERF			23
+#define IMX_SC_R_USB_1_PHY		24
 #define IMX_SC_R_DC_0_WARP		25
+#define IMX_SC_R_V2X_MU_0		26
+#define IMX_SC_R_V2X_MU_1		27
 #define IMX_SC_R_DC_0_VIDEO0		28
 #define IMX_SC_R_DC_0_VIDEO1		29
 #define IMX_SC_R_DC_0_FRAC0		30
+#define IMX_SC_R_V2X_MU_2		31
 #define IMX_SC_R_DC_0			32
 #define IMX_SC_R_GPU_2_PID0		33
 #define IMX_SC_R_DC_0_PLL_0		34
@@ -49,7 +53,10 @@
 #define IMX_SC_R_DC_1_BLIT1		37
 #define IMX_SC_R_DC_1_BLIT2		38
 #define IMX_SC_R_DC_1_BLIT_OUT		39
+#define IMX_SC_R_V2X_MU_3		40
+#define IMX_SC_R_V2X_MU_4		41
 #define IMX_SC_R_DC_1_WARP		42
+#define IMX_SC_R_SECVIO			44
 #define IMX_SC_R_DC_1_VIDEO0		45
 #define IMX_SC_R_DC_1_VIDEO1		46
 #define IMX_SC_R_DC_1_FRAC0		47
-- 
2.25.1

