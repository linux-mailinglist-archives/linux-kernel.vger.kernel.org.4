Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 82A5065D112
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Jan 2023 12:01:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234677AbjADLAy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Jan 2023 06:00:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37118 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234836AbjADLA3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Jan 2023 06:00:29 -0500
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2067.outbound.protection.outlook.com [40.107.21.67])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B14C813DC6;
        Wed,  4 Jan 2023 02:59:19 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=P7qq/i10Ga2BbByoZjfsbvQAb3NchhW8QpsNcr46fJDWUMG8+UMpSrnAHwTrOKa/rng6FLoF+XWzKuozYZatIiNxTJNpT3YkYB6qXbOnuvAyA9XjP62XMX6pNwXwEfn/PkuDBjiiO9yuskriyHUWxgiiENCuF0w/3KlrH86wkHuyMb1RraJR2T6nEMNO0+LOAGVY0VtwonzLngtgRQMmir+QDEmEiL0C+iXiKURXvRgN2YvEdpfolIGrITEGrxbAQ8neJbLBQ7d4n2XCM5gKEWWuk2NvRqc1wpR4X3nX++ozz0t25OBvsA4/fDOOfyL+pd3Ix8in6e5v63ORlp3x8A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qUcaYBHP3lHtx+REsZVGYuOoqVURmCn1HjcXwmfr3iM=;
 b=exhzsFqN2osoX0urb0dV45ZTWzp5XTDjyjLc6vp2E1+yvHPN66HdzMLHv0xklIgrfMWN73mGUokxOiY3TUyJCwEm/84oBfgeWwHsCqtNJtpb+F+eXsy0qEuwoP5rwgIfsMa4dMjxZ6n08hT1+/7/8APG6yi3uqflx7qEPtH/vnuBpBqErnnX3b5nkBimt2feVvlsjReB+W0al7sAcevjt4q7XkwsTdJ2rmB67LB++I39TNy6kpc3v+4wttmBkdva5HHWEIkEpFhGhDIsDCbdS0UFIYRBqcvyHJK1RgxMONaQMjPtEO6ssfFqYkNrjri07SBID/xE/S6coOvbP293UA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qUcaYBHP3lHtx+REsZVGYuOoqVURmCn1HjcXwmfr3iM=;
 b=drzN7+TA4puzKaql2eo+hazEspkATp2D7Fngv2g4t0SiWSmrk/QkBPiAoUIS3xCiyYfqxYLVKuUWe5Cd/TlxA6EZJOTebVLuiyO+jxZq5ewpRyet2cGP9mn5f25G53gs0ue6hy+APxRlBUE4qZbHyECpLOMZvxSYY5ze55Ya6pY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by PAXPR04MB8408.eurprd04.prod.outlook.com (2603:10a6:102:1c9::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5944.19; Wed, 4 Jan
 2023 10:59:16 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::29b9:5061:2054:174b]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::29b9:5061:2054:174b%7]) with mapi id 15.20.5944.019; Wed, 4 Jan 2023
 10:59:16 +0000
From:   "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
To:     abelvesa@kernel.org, abel.vesa@linaro.org, mturquette@baylibre.com,
        sboyd@kernel.org, shawnguo@kernel.org, s.hauer@pengutronix.de,
        kernel@pengutronix.de, festevam@gmail.com
Cc:     linux-imx@nxp.com, linux-clk@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        aford173@gmail.com, Peng Fan <peng.fan@nxp.com>
Subject: [PATCH 1/4] clk: imx: avoid memory leak
Date:   Wed,  4 Jan 2023 19:00:29 +0800
Message-Id: <20230104110032.1220721-2-peng.fan@oss.nxp.com>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20230104110032.1220721-1-peng.fan@oss.nxp.com>
References: <20230104110032.1220721-1-peng.fan@oss.nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR01CA0017.apcprd01.prod.exchangelabs.com
 (2603:1096:4:191::19) To DU0PR04MB9417.eurprd04.prod.outlook.com
 (2603:10a6:10:358::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU0PR04MB9417:EE_|PAXPR04MB8408:EE_
X-MS-Office365-Filtering-Correlation-Id: 1285395d-2ccf-48cc-3122-08daee42b878
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: jtUOJ5A505AyIA7LMj0vhvrR6pL/kLgFhUO5zJabWZJGQrbcKA0vbnEWvSdmDoQ390VW9cDKZYL8N9Ra7Lmy3PKhoJ/AR4ni9YUmbG1kegS8sum/uKwAvGuxLrtHMQJgO8jxKyDf8MFRvuzkiVOlurMYkiUGoFvWJi3YrjFAUm/AA3IXwlhVYqwcouLSfyxhqFdLzpNaHC1TPClmrZAOENb7sehTBATkVVZrvDi9XbyvFwL8+xqZNaF8oJJiTLzaZYJQMou1jQ7CaeE/Y5cIO/QPvmE9Ni7AuBlc+M+1UVuV6VTLMVl0E0kAioBYr5h39CISFs97lcQgdp118FV+khUxY8g4q9XtlvFsfL6SF9PSEWfh6bVPeCeoAmgGZ+5lniobJieqTAMW8Pb+4lLE36JxdJKV+C4Xn5mj3/yrJ8GZF23EKDfeX6QM3b9PpVcabhgwmVHjVcQ6al7aRcawMT0VKGUM0CVs4RQHkhYAeZvZVzLQv7hxxMXoEOBGPmw0oLrEUCM9RfH9ZjW5vQpBtsIF2T1kK1//Pw8wXwHm7w+TEpTvA2LlaiEdyHMYYJTsdTk79CNVFvCauRw18Qq+TAm9aoMHfpW+dSwmknBACA9aCKUoOwxbg7g7saILY3O6ZPffZh5TnPLnsMhMoM/YiBIY5EB2VS5B6LWBF+t3FhBPIA5+XPgQ8QbKV7+ylwtU56783+G/B9lnyQSt0u4s2A==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(346002)(39860400002)(376002)(136003)(396003)(366004)(451199015)(2906002)(8936002)(38100700002)(38350700002)(5660300002)(41300700001)(7416002)(4744005)(86362001)(83380400001)(52116002)(66946007)(6486002)(66556008)(478600001)(6666004)(8676002)(4326008)(66476007)(316002)(1076003)(186003)(6506007)(26005)(6512007)(2616005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?PlIj87fXffvmaSAWpQqdUXyt23cAyY+PyOcnmW7E0JpPX0oEH8kGs5qfgLij?=
 =?us-ascii?Q?D/c43AbobEQkPITJP/6LY0X7WyoBNatnAmBMNOr7KgyepLfd4S9h/temPJL9?=
 =?us-ascii?Q?LDLXZlwL0nw5gCUXOZHcDIEZnJ4K0++dKggTJ9ZJYV9UJ4+Q36a+L+8JUt4S?=
 =?us-ascii?Q?fJ25utnWRVHEhLY2IAiq7AKiCFBt+iYZf9OsAdZvMqEFMNYokNd39JAkiVcW?=
 =?us-ascii?Q?lfx6A3tl+nrnPBMOUhI8XHumKS/cmt9Ybgc8ikmEuKZuNSa4wV5QE8qxtgoN?=
 =?us-ascii?Q?ioSDqanP/TpwS1x5fPBnhhPubV44ld1KEa9W0Rg2eF2lWkxl84HUJM3OEIy1?=
 =?us-ascii?Q?04W2rdOK5dqRIxilOIHwar1vFr4gGqWeTudITmozYLruKXwdX5cVB19/Yhqu?=
 =?us-ascii?Q?CKt8PkR/+B2OBzjXr7oD0ATA/wcg3BF0Qbwnzo2PvrX/rx4kDp4SlEwZzo34?=
 =?us-ascii?Q?QjPMVBK4pRwackbr5uPmZ7lWIsMHKzrvsB+Cgo7u1BJialXZbmj3u5NULIey?=
 =?us-ascii?Q?NtFxEgkDl8eaEYY5dUhHGVs8cVk+4LIs09ly85SUkbnO3Gor5K63kH1l53Al?=
 =?us-ascii?Q?Y1m5RbFQu6rPv4NbsXmOQnMWb8B8Y6vyx/6csVJ3ocRBRHFAWbt9OHIDeJTu?=
 =?us-ascii?Q?qrPKvF5mxMPWCzmHgdliCQmscmvPZDq9b8PK5kEty7SHlUAZpRgglSH4DS+s?=
 =?us-ascii?Q?FP7AebXnxCK/+VRFfkvkzNg5m6lBeuAFAfxUfv7TmjugHPdOGaa3ovAgzn5/?=
 =?us-ascii?Q?Dvzf6pNJy0ZT8mv4KgBZVHV/FHUqOIgSwo0xWyfV9AXNrrGfjZ2RQ3Mxg1JQ?=
 =?us-ascii?Q?LzbzaHkmSj65ELrR47GKlbdixh081/Ty8euzcyP/F3D9y+aQKC8yUB9w3ne6?=
 =?us-ascii?Q?TNsKtm/iG4gNHziKQYmjo8ID3VKO1IvE7w72JCknDL57CB1Jo9828oJn088a?=
 =?us-ascii?Q?taUbKROkMqBYJ3pqd08/RbiWuKY626sci69EZuHV+g+knFd0AB2qYlzxs2hp?=
 =?us-ascii?Q?fzGKuf80wh7KBvnLKz7+DO2KpS33cw4sZfCHUp6/LHlCbC3R/kwN/nQ58cAl?=
 =?us-ascii?Q?qVvPGV/6aBOAKqksVElJ7N+edqQvnzwFiBwhMUH684o5KfkQFyfpM0YDO20U?=
 =?us-ascii?Q?mQ3ZmslATq1/vsa2VYoux6JwiKeKIFPapUJq88zcfBgwqAvRK8pnp6BpUhkU?=
 =?us-ascii?Q?W9Xv1dGYWC9DWt1uLPzynzoHjWaa9SWiZ+u62CcPLgetCxlFnm+iNArS+qbk?=
 =?us-ascii?Q?7l4tIxLlpFDuEgh9xj73R+DL0+1tvOYNcUO7xK0vmnZ8oDVaTjmVURHsB+x9?=
 =?us-ascii?Q?Z1sLcHPW2bC30yhM3rdRXkYlEyjuM5Cnr+bJOaZ9DTbnujqKq8dPtiVGlMWu?=
 =?us-ascii?Q?qtMysE/BekiGqSKWRF3zrU1WxAjf/Im2SoxaO2AoAsYFRxwYwWF9VEBKXP1S?=
 =?us-ascii?Q?nyR3Yr0srnRyACLbHilhqJUYgC1mbtM1Q/kFkMoEvWyy3xi9t38kQyHAS1F6?=
 =?us-ascii?Q?p4fcTX1za+wqi87mbSstvkLql57d10tPxx/qntBXGFiIbalJFkJnHmxY/t7/?=
 =?us-ascii?Q?u/NdZSiNxE8No869GwJPGFUWyEQFX7tqLdC0j8So?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1285395d-2ccf-48cc-3122-08daee42b878
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Jan 2023 10:59:16.4138
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: QvxQSZxMzqM1+QqpTVw2QEaVa8QKWhZzAmS1W3EK9aZPo6x01ZY4HlxxDcsaT97mb1aLY8g0dvFUL/1MSxSnVg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB8408
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Peng Fan <peng.fan@nxp.com>

In case imx_register_uart_clocks return early, the imx_uart_clocks
memory will be no freed. So execute kfree always to avoid memory leak.

Fixes: 379c9a24cc23 ("clk: imx: Fix reparenting of UARTs not associated with stdout")
Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 drivers/clk/imx/clk.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/clk/imx/clk.c b/drivers/clk/imx/clk.c
index b636cc099d96..5b73a477f11f 100644
--- a/drivers/clk/imx/clk.c
+++ b/drivers/clk/imx/clk.c
@@ -205,9 +205,10 @@ static int __init imx_clk_disable_uart(void)
 			clk_disable_unprepare(imx_uart_clocks[i]);
 			clk_put(imx_uart_clocks[i]);
 		}
-		kfree(imx_uart_clocks);
 	}
 
+	kfree(imx_uart_clocks);
+
 	return 0;
 }
 late_initcall_sync(imx_clk_disable_uart);
-- 
2.37.1

