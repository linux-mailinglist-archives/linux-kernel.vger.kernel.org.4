Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F1FE35FE76F
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Oct 2022 05:11:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229968AbiJNDLm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Oct 2022 23:11:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43892 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229888AbiJNDKd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Oct 2022 23:10:33 -0400
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2082.outbound.protection.outlook.com [40.107.22.82])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A66AB13F22;
        Thu, 13 Oct 2022 20:09:53 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ck6KY9mlBzVqiJve6bxTBQmRJiJJFWVgsQLawCTXYjIhDygqKCb8G40xNXppL12hlAGbPQIhLbQh6IN2N4+rRD8r7tpayYNu2asLjgtC+oNTqxYFs2WgVAa+mjzTjJI6Nta0mwFTtVux40qWnvdY9Mhgxjt+B0Gzds0fdBL5SyVnX9q7fniQ02nUTQ/9rjjoEr2xx5jiEL5eRX+kk0fECHhLSMgyitafWqLIgnu+D1mBGU0qq+VhrVr30f1ABp401TDzvGEfDru3lFjF1ACcIn/DZWFuB5u95hbkeb1hJvjiXEdUG06eS6o8uYg8vWkBRdq7vAgPd+R4flz98JcgqQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=R+WdwO2aQHI1u2J5cop1FJI2ntOHTRNGQ7fQDHotXgk=;
 b=AiRPyZa4cgKOInZpwxVrnH9QAm1/hFTKcM3gu55ueOp3YaMx6jSPOjgcjvEipfsUt1wdE9F5dy+Ekje01Elllj+JyI5O4fOcVwCnaYLsirOlrO+hUnJ6Epu2pNIeDl64LuM3aJMp8CvyZs9Sn5OEXuAFCGN7MREeLt7EmXeZCfPLNG3MewoBtzHY3KGR2ojoh6m2xFzPdsxc7QocG959cPtWEks76dJPzUExo+NmopVkWMVDy00oghaylK6fPhaedp8ILUVqn+vDDJuch4q5IIb8jtLrJw0HlZzkvkvHKJXn2I1lSFJ35qWAc/xTm6vdXtLP4rdATjcFkzw33hCQYQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=R+WdwO2aQHI1u2J5cop1FJI2ntOHTRNGQ7fQDHotXgk=;
 b=DidINijepKWUGQOc/mMORUst54XEJN0RSmr4VJkzvg59pg2VmsH9w3PWCvIvi2VftVca6etYgdDvKxhGQru4B9puAMFRFvyWP5ybOP9xFD8IhVznvlZWTGETNXbJXEhLMSyaDjm1BKtjVcUU4h1qeDyrehYZmIQ+XuDuXgdZGNw=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by DB8PR04MB6956.eurprd04.prod.outlook.com (2603:10a6:10:11b::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5723.26; Fri, 14 Oct
 2022 03:09:40 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::ba6:d7ae:a7c9:7a3a]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::ba6:d7ae:a7c9:7a3a%4]) with mapi id 15.20.5676.028; Fri, 14 Oct 2022
 03:09:40 +0000
From:   "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
To:     andersson@kernel.org, mathieu.poirier@linaro.org,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        shawnguo@kernel.org, s.hauer@pengutronix.de
Cc:     kernel@pengutronix.de, festevam@gmail.com, linux-imx@nxp.com,
        linux-remoteproc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Peng Fan <peng.fan@nxp.com>
Subject: [PATCH V7 7/7] remoteproc: imx_rproc: Enable attach recovery for i.MX8QM/QXP
Date:   Fri, 14 Oct 2022 11:10:37 +0800
Message-Id: <20221014031037.1070424-8-peng.fan@oss.nxp.com>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20221014031037.1070424-1-peng.fan@oss.nxp.com>
References: <20221014031037.1070424-1-peng.fan@oss.nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI1PR02CA0010.apcprd02.prod.outlook.com
 (2603:1096:4:1f7::17) To DU0PR04MB9417.eurprd04.prod.outlook.com
 (2603:10a6:10:358::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU0PR04MB9417:EE_|DB8PR04MB6956:EE_
X-MS-Office365-Filtering-Correlation-Id: 3dd242bc-f55a-4b0a-b9f1-08daad9188dd
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: NmdVaMV1tG40EQSVhgTdIWw6pO89LHT4H4Mg3jIPZT9fZovBve4b9ABm3ZlpV/zxKV+U5Wd6/EF10YNNQp423FUKaqttQ24/4+KRVsERmRd0sD5ABJHhSm2rvZ8vnZlM2i4Nh555WS6OqdxQkheZ7S0CaM+znczesK6aOrsJ9p6t0Y9dnxLq3nlV6Fdw5g56TIjpvCwH87B0z4rn0FcunJXs7Fi8HrsCdiVQFPIG+HFbuXJQDb/yalEx4MCSWBSzYpGBj7AmSjXJP2pC7IulDKVQmOAeHUoEB1yP9qhtEpcrTdVSHRlPTgMRbmJYbhElb9Gk+Y/PVsUEahEp4C8zbUk/H8wFOiPEhyzQoIJq/Bm4OTYX8F4DKV+bXjIFh9RizrpJ+9JjU2Q8o+pDvimAeewozdHMHjjj33nqfInCBtpztUaTkJtP746V7qN8X8aFqiDQ3+PCBCxbsw3x1GcjqgRj8RYJeuMv4lBATqvzAWAlnclh23sbYE33Tdu+VAdomz67jh2wIlRhAX5ytJtju6bvtQXUBpwuLnTmAHsRTRj7PBmytbMXCqMEgaq2+xn/x3fZ3WYXSNPUyAYEeLDlA0qmiKjue0GCRerUBYOw5LQFjrHacYHWHWEVShU1UHD+p1rOkUvVnY3NGM4psaql5RSgO5w2HbmOhSxD3106+4kJMNkTeRFSwiuZfbUIFoe7bsO1XqcdpN6Yjcr+bg9Rgi/oIyXhLpgKKbvvqMi+gHqNVhFqDDtPe9QmQRMGLOlRpGmLh2ZcavSClovt6MlgGA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(346002)(366004)(136003)(39860400002)(376002)(396003)(451199015)(2616005)(26005)(6512007)(52116002)(186003)(66946007)(316002)(2906002)(66556008)(41300700001)(66476007)(1076003)(4326008)(8936002)(86362001)(8676002)(6666004)(38100700002)(38350700002)(6506007)(7416002)(478600001)(5660300002)(6486002)(4744005)(83380400001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?m0is//TfkpizZp2zLGgg4QlxepIOhzL3iKRdD7wTz67LfU7MxtNyWNWyE5nb?=
 =?us-ascii?Q?hLI6mKbM6cRNQgKwxAwOMZRaokvcz3/EE/deq0V+mhc9h107LKyp0lS9/u1t?=
 =?us-ascii?Q?b3MQoboiZFr2AZpPQaZqqpfke7tTB4iK9rSybSKrcaL2OpEfTa9Zfylfztmh?=
 =?us-ascii?Q?3XZquvxxPzdUorYTuTkJfSPrSB1WQZ61K3TydhwJY1TowAF8rYiZ3a3422vY?=
 =?us-ascii?Q?vOEnxfUZFFClyLPozv2GfYrXB7W++12MBkdYyqk9DY4KkNT7GLKLp7I+IyJY?=
 =?us-ascii?Q?8ZuVo9gB+yARl+jxV22tBlHlk+bun60JUDAVGxt3Omk7NM+WhUn0X8lw4F2z?=
 =?us-ascii?Q?AQapCTZPPAH9+/S/RZ9MTjqXoUB0xiczSOyB6PN39PXvIXkOZPqnsweqRNef?=
 =?us-ascii?Q?DoW6oXyorBH9WzS9xEYqlo46EPuMrjvzoZY2UgO0jXCMwu+yQW755PHpM1Al?=
 =?us-ascii?Q?bqhQ9bDInqJC3M404MbPe0+agEP1Cwvn14JOIX3dYHHzi2JnAcbDXjn6tvPQ?=
 =?us-ascii?Q?f2sAGgC4dySmozlsIszqYeHA/MkYI6zbSVYLaT2r2sBgPrhMZSFuRyCSbOgh?=
 =?us-ascii?Q?/iyXCpmUL5tRZog6RpKI1QmptKjc1zvxeKdwgmg+MWr8PQhsFmrrs4+XfQf3?=
 =?us-ascii?Q?if/cWqcjOrD2ix2jUg/g44mQiMUjAJYZldAdr3ms+saYgYpgJvns7Cl4PPVl?=
 =?us-ascii?Q?rMHLHzFAsHTJSpWWZm5sFt1H18dSIOmoUtxNw6tNKEQqSqvJa6tcTCy+nrlY?=
 =?us-ascii?Q?napUur9i0MP48cpjn/x6v0uSaF0QNcHM4xO8+1VM+ck3EQ/lLE2KX3x0HaXZ?=
 =?us-ascii?Q?DwgBBYkM/QG0nVuNsL/pBTh0t0tVwverxUgBvJJ96DitvRoOShotYOstnOmv?=
 =?us-ascii?Q?pjF3Tv1WVEOK0Tn81bIpEtT3GPVgia7Ph8wUM888ady00L8ze53ixluTa32v?=
 =?us-ascii?Q?udNWeRS8UOIroNwCmKY8ue83FUbjJfbABLVN5+GJJrVY1eCJ38VKyH5m1rmx?=
 =?us-ascii?Q?iygAmuHgIRH4fxoy4codWgJ+Iq1Ec3JrCce86El7a3eM7jmNesUO9sPpVMpf?=
 =?us-ascii?Q?ZDA19CNnlUvkBDJz7GhbiBjO04D4xjXu81wgfhhlGH4ibRRdnToTYmsprdo6?=
 =?us-ascii?Q?PAUyMbhO+BxmdFEecLTMoeqm5SgLS56xbtKwu8jWnSQobL3Deq+205qkge65?=
 =?us-ascii?Q?6o2LfITzXWlQ0D2BYkjUV+DrOQTW5kVpMmPloyHldvZZESQN2G/DKqbapfGH?=
 =?us-ascii?Q?XpWBeZANz8HHF9R8DvLagYsgtLBqWuuRHS7vdUVZKg/tHjshFIQaDXNQ+bHy?=
 =?us-ascii?Q?CcooYOfNsQTrwIMo7c55xFpU636l3dSDThswCzJ3Kvs/FWHJFMezy5akigbQ?=
 =?us-ascii?Q?UcdWDTcUhBYdJiSxGidUAOyMqnRa1ixWl2XomtXePDJQigLR88SQVboBSXVc?=
 =?us-ascii?Q?kX6LBf3JsmX+dpavnRkI+CbQZnHAbasVq1+lw5P6v+W7cfby/ak0fnO9Kbxn?=
 =?us-ascii?Q?t7/JcTqt03UDZIK67AOBpgxSJRu1DVh4bJ16PY6zKjJ5WYWMEsAj7xqLNNoF?=
 =?us-ascii?Q?64lF7lFh8pLpYe0cGbIcsen1fM+ECKs57lSTt2bK?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3dd242bc-f55a-4b0a-b9f1-08daad9188dd
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Oct 2022 03:09:40.7879
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: kp8yzppbk2xMpUmz2VIvYe5vFz2dBQjuqh5uzsSlLn6gjQhBv3z2RePBfT96UW/DIHsG3ZsrLrDih5hsLjigDw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR04MB6956
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Peng Fan <peng.fan@nxp.com>

i.MX8QM/QXP M4 could recover without help from Linux, so to support it:
 - enable feature RPROC_FEAT_ATTACH_ON_RECOVERY
 - set recovery_disabled as false

Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 drivers/remoteproc/imx_rproc.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/remoteproc/imx_rproc.c b/drivers/remoteproc/imx_rproc.c
index 1183de84a4c0..2f82587b6ef9 100644
--- a/drivers/remoteproc/imx_rproc.c
+++ b/drivers/remoteproc/imx_rproc.c
@@ -939,7 +939,8 @@ static int imx_rproc_detect_mode(struct imx_rproc *priv)
 		}
 
 		priv->rproc->state = RPROC_DETACHED;
-		priv->rproc->recovery_disabled = true;
+		priv->rproc->recovery_disabled = false;
+		rproc_set_feature(priv->rproc, RPROC_FEAT_ATTACH_ON_RECOVERY);
 
 		/* Get partition id and enable irq in SCFW */
 		ret = imx_sc_rm_get_resource_owner(priv->ipc_handle, priv->rsrc_id, &pt);
-- 
2.37.1

