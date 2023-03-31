Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AAC206D1837
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Mar 2023 09:12:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230112AbjCaHMP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 31 Mar 2023 03:12:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36058 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230156AbjCaHMN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Mar 2023 03:12:13 -0400
Received: from EUR02-VI1-obe.outbound.protection.outlook.com (mail-vi1eur02on2053.outbound.protection.outlook.com [40.107.241.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD7D4C676;
        Fri, 31 Mar 2023 00:12:12 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=erbHM6hEDtf7trTARNLBU+ZcsZ0hEsSlM0jL6p+K9UJLMhsvF1gsUT8P8nA1nJui+uCWGL0gHfYr5EPZ9DOuHe+t3RTUyYjZiKdkKiENZo1lJo27GqERtKwTeNzzM+Ook8R/7UO3LWiyzZw5ntfgp+qqYD/hJIBteDEeKON096BBZQcMWET8Xl5kDPUPgv6vsABskNxj60/zHIYPe1yMZGaavY1ip0ql4aQ7Hba3jFGkDaDJsMVkaaw02IAX8SgLbo9/K2JvxMB44IKZUR5ragbnHh6XL1oENbv3jNYPfWX2TsX8M3Q7c/zTdq6bTgtWKPmOpQGZwUksGM/ypuQKaw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hUOZ5c0jkvVBtmhe/iNhF5yYOK0Vqx4MHm5k6fGxzEU=;
 b=RlNhg3JEhzhhORCdwsVBxKXrBvct8gSnVPt43xL8+AH5fC5ZYrfe3oC6buSpymdSfuSQuWKvwp0p3XW8p2K2juwxRN6TraCg+maEhrl5UDdy5nQwXlek97ucMZTAxMzFOTQCNMkhRVvXsAM+wVCwd5BJsj6xgqmrUduz9M2Zc2/p2fdyMGyQgJ8e5pREo0AQ6QBhy/KbQPdKQB1uZ7KWgUiQhHNN80IMdOA2P1DNdxM0egi1a41yeU7YyAUcrHBpWFN2WPktE5Mv3rtJcW8guuRJgL2epi2rKNI3Hl9wvtpMaetdizCygSvVvld0ZjGHexxX9DjQOAjNJy/XR3iPnw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hUOZ5c0jkvVBtmhe/iNhF5yYOK0Vqx4MHm5k6fGxzEU=;
 b=VXY6djB/ZjCnSMTZMB1utKk+HmxjYVUfYAeM883M00bG/BCN57kMz7d7FP+N8dXpMKPpMQIho/5itGXRstpcLI1u3M1d6ewCo3D0YZWabKzk5xORJwM8Be2lzOtS6TCvRdm0yCW1gcWs7UOJDbfky64WVKqTu/BfUM79qQAY4OI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by DU2PR04MB8981.eurprd04.prod.outlook.com (2603:10a6:10:2e0::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6254.23; Fri, 31 Mar
 2023 07:12:09 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::778e:19d0:cba0:5cc0]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::778e:19d0:cba0:5cc0%4]) with mapi id 15.20.6222.028; Fri, 31 Mar 2023
 07:12:08 +0000
From:   "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
To:     abelvesa@kernel.org, abel.vesa@linaro.org, mturquette@baylibre.com,
        sboyd@kernel.org, shawnguo@kernel.org, s.hauer@pengutronix.de,
        kernel@pengutronix.de, festevam@gmail.com
Cc:     linux-imx@nxp.com, linux-clk@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Jacky Bai <ping.bai@nxp.com>, Ye Li <ye.li@nxp.com>,
        Peng Fan <peng.fan@nxp.com>
Subject: [PATCH] clk: imx: pllv4: update the mult table
Date:   Fri, 31 Mar 2023 15:17:12 +0800
Message-Id: <20230331071712.2483351-1-peng.fan@oss.nxp.com>
X-Mailer: git-send-email 2.37.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SGXP274CA0020.SGPP274.PROD.OUTLOOK.COM (2603:1096:4:b8::32)
 To DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU0PR04MB9417:EE_|DU2PR04MB8981:EE_
X-MS-Office365-Filtering-Correlation-Id: 9235cf97-2b29-4902-a3f1-08db31b73d79
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: JyTRW3rkHV/mAr88am3qo2jyfARCEm0+tCAp+2H28Fh3XJMZXjdzEjI2iP4UkbOKN35exG5L4Ja3Ephy5mMxy+9eT7R4jfLXoP6U4JsFteu6K03Avt2eYJ8CPiHIQuQOpGbkyyx40PpgvdptfpO2otZZS13KWTWD2mt2A/KPK5ldvO97cNPWy5GOAasq9pFmBX1JjfdkkNvCOeEl5IYgLXzBfj32KbfBPuFDUTrPHYrI/E5joMgRPbNEtLu43YZ2OfKSfN4Yq+sJaT3sQxD1eJGpEMCL2+yXfnnwnu1llxYAJAAcEyTXBN8r2M1f9PfXi8n3cW5ESRFtFpc5uAKiFQcwzAAAzosVsqK1djKMIzH1DQrX4QOoPINNNvDYsA3K4ZRMOsyFKJ/YlQtIMa/xFQ4+Jy8tPCqXY8ufEcD76cdZFO076u0UGQ4tHTulm+sTsZYaganFMuutNxYZelcLD/e0ZfJMBXmgvHqch6Wg6AjFSH+DkqFm5PAlsMd7jm+vMy7Wh/Tn5Cx9CX+Om5/pq4XeraS4AjRg48TEyQDgxq/4QI0IhMYIdTujpNEOQc1+j4ltG0D9D7M3KfAjq3X6liFLXF6l5nzsPI8OhA6mrSmn5FHdLn/djYRrES+1pUHn
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(396003)(376002)(39860400002)(136003)(366004)(346002)(451199021)(6512007)(8676002)(4326008)(54906003)(316002)(66556008)(6486002)(66476007)(66946007)(26005)(1076003)(6506007)(6666004)(186003)(38100700002)(38350700002)(2616005)(83380400001)(41300700001)(5660300002)(8936002)(52116002)(478600001)(86362001)(4744005)(2906002)(15650500001)(7416002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?itsTVDNFU0ARsRWz+YLgQ1m4Pv2tiGjX5+0uqQrIIZJkSVHPJqCvU26NRYFr?=
 =?us-ascii?Q?Q9l78+g+j//nmeW6uA6QPR6OBJkwV/G7NISgZncM1upWlyrjDyYwAlFCU0jj?=
 =?us-ascii?Q?ZkcfTjmpFzZ3uptt9pdMudGUmU1r9oG0ejCx2qLTv5cnyo1cAtPYSu48iO+O?=
 =?us-ascii?Q?faeC1rpoZixtR5/HzC0Syx0i7hZ6T4qVCRlDMcZLODp1F9JJSuU1JqT069LT?=
 =?us-ascii?Q?FtFmjqH45S5jiYpu7wmJwlMqcgaUe2FBMFcr7t0j7g20rl3MLjFDzktUaurc?=
 =?us-ascii?Q?SXLpHDAMUYRi3AHH5P8koKVqq3PBg9uY3c1oyVJg+Ejjb3HKryQE2Zujh9ml?=
 =?us-ascii?Q?pVRkCwHYndOiZ0ELi0AdSEyp4kLWd35MvWAqi09kLEzzq9ZkJVJo3gbrr/L3?=
 =?us-ascii?Q?oxQ/vhlsic39r/wY3lXbcY9XZn/hTwmPvBGYsvW1oWZjdcQer6zfhfLR6/bP?=
 =?us-ascii?Q?SVHSJfeJn1aq4w1TZ7cpESocVr6I7BeuEgNDwnH25rSRnRYdstq/J8AYpnp+?=
 =?us-ascii?Q?naykVrREkoPEo3Q/nDoxbs14WqJpDwbReGYqsBn1zS131310hu/nUG3RNWjp?=
 =?us-ascii?Q?5LegDcRkccVEdSkWkJxr+v4JvvOeaitKCUKzEI2zKZ2q5mw/PLL2tGu8q0UX?=
 =?us-ascii?Q?W8BVkOrokDrnOICkmHHCRSd35gOxqsiIiHNx+0RuTUOJSYeBcSkrJjexsf++?=
 =?us-ascii?Q?oKkS+so3dgtz1xomlwxHSOCHZc8u71fAX1LuN+HHwir1X4DwqH1ShXa3xnix?=
 =?us-ascii?Q?ScOOxlV1GL5D3E1Lr0lzaMNfVRCeJct/WMf/TdbDH9QjUPiKHvJES+/9RsQm?=
 =?us-ascii?Q?iFJw7V2OO9tc/Un276speajZMplkNvLag8Y0MaLSZbObvTHsHPxHffk5Gm3G?=
 =?us-ascii?Q?08CBZBZJ5W6GCxUaXSZQ1r5GRMW8y2LNCTqRCAgsicoJT6OVgnUMUeX6XusJ?=
 =?us-ascii?Q?vLldp+3XqMVdOn69k+fmUcEt7i8yiRBgzGL319xWpAay3NW1V8ciVitm5IJP?=
 =?us-ascii?Q?H7AUSUAEif/pC6AjSswcEL6CmsRjpGP9wkGNn63uLm2T1GOzCJn6MSQF72LI?=
 =?us-ascii?Q?QkPJUKqlq2pf7yWRTPpfrY2OLuik4dEpVjBxOhecR1qQxaTBFuNQocPwsjaD?=
 =?us-ascii?Q?cLk1FcYZv9SwPLDqdPr3bMNDEa0iGOblHn5+zB7YPVU9ws8ojgbt4zV06oQw?=
 =?us-ascii?Q?7OU3BVq+MoIbPZ5hUzBfmQUr/PY6CmgzK+jQmFo6w3wngy6ygZTh17jOKEHy?=
 =?us-ascii?Q?NXwGNR1RB4WSHjZllfh+mQiPk7wveyxYoseA/CSwcZtU9699EnF9uShf5uPh?=
 =?us-ascii?Q?JzFtgUSB3hJ6OolW4sR7lCoVsmjHkRmSZAXf/aH3gwi/So6o1RqpnQLlzcy1?=
 =?us-ascii?Q?ySCsm2nilhBtt/fJFLiLa2CUvQ2dqigoFqbG2F55ig63wZ/KKmjRyaU1UGyw?=
 =?us-ascii?Q?DTqsrvJyTRQEHj7UMatFxR/cqi4A4fgA3DO9b3pi7Zop/VgefSX7/FjQ8c+8?=
 =?us-ascii?Q?qQXAsYZucI76g1XaDOqmrkFWu8Ni9PIikcfTrbj3Qx0rzucIPxVqY40WEFQM?=
 =?us-ascii?Q?uLa6vmpqpmYUraEvZ9YpYKXdQMFzn2UPR29YIeSb?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9235cf97-2b29-4902-a3f1-08db31b73d79
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Mar 2023 07:12:08.8775
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: lI5/q3ppsmUC3mX8vOR+txC4+ozw8pcFiY7IDixVghWkayb5e6ATBBps2UpuFKb5BUzRiTXo65E5EmoHZVyIHw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU2PR04MB8981
X-Spam-Status: No, score=-0.0 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jacky Bai <ping.bai@nxp.com>

On i.MX8ULP, the ARM PLL can run at 960MHz, so need to
update the mult table to make sure the ARM PLL can
get a correct PLL frequency as we expected.

Reviewed-by: Ye Li <ye.li@nxp.com>
Signed-off-by: Jacky Bai <ping.bai@nxp.com>
Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 drivers/clk/imx/clk-pllv4.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/clk/imx/clk-pllv4.c b/drivers/clk/imx/clk-pllv4.c
index 6e7e34571fc8..adbaad3e0110 100644
--- a/drivers/clk/imx/clk-pllv4.c
+++ b/drivers/clk/imx/clk-pllv4.c
@@ -47,7 +47,7 @@ struct clk_pllv4 {
 };
 
 /* Valid PLL MULT Table */
-static const int pllv4_mult_table[] = {33, 27, 22, 20, 17, 16};
+static const int pllv4_mult_table[] = {40, 33, 27, 22, 20, 17, 16};
 
 #define to_clk_pllv4(__hw) container_of(__hw, struct clk_pllv4, hw)
 
-- 
2.37.1

