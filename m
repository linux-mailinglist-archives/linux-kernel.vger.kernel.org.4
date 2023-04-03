Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A2C6A6D3DD3
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Apr 2023 09:09:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231618AbjDCHJB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Apr 2023 03:09:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37956 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231546AbjDCHIn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Apr 2023 03:08:43 -0400
Received: from EUR01-VE1-obe.outbound.protection.outlook.com (mail-ve1eur01on2070.outbound.protection.outlook.com [40.107.14.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E63DC83CA;
        Mon,  3 Apr 2023 00:08:29 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GHFPWcBcPBUUo2RuGBnVsQKf5TAjxrNTorvj/BPjpZce6X1Ucxh+Rtl39REb7UphXmxm0OSLdXt3EsCBlf8inpJYyBIGM9vPKTcXZk4tX2Fqt3rBKXEfmhZkADEH0+T2kjOrD1wko9hWI+9PQvGWWGeCiLqjaHk0hzuCSWRoepcBdeJRKntw3XfuysmJTZFhxrIJYdzd2Vv59LPtVXrJ/yadeL4ZefKyh8LGDI1ZfPLKhmMJfvprdFBTN7nMtFFLAxu7ycU6YfXqFZU9IvQaSfnZwsNdH+vLhb6l/0RYC83DnKt8UxHW3jqTrdKb6cTmQ3itgVSKkRJ5bIEj1s0grw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PD7fguA+0DuPJzyBK/J3/AbOnO0yns7W2/60PUlIy2U=;
 b=FQcd/JQOuejvqYELsBxiC2DVzUADO2fNG1/ltxzxJW/uQmRbN8RHaCQzWcpCx9cJk2SW1bXzfv+gaOXyKh4F37gAPoFisZW8mYuFc+fPTsgEWXeFwKImQmh8N2U0fAbce56oSIbMQVM2U6W+PWZTlTevDc8r+LE7vu6u8IOSKCGBUhUHttPNkxYmiYNxZsaXKxez0kCNsXF6ZipFXySkh6j7ClRg10phUoEigmg/X5emw9LsDUGGyj3MZUOC2oLW7aGbPjl4WC+btgQhlv6VO2KM+mTt9S4+drJIyUy0yiM1mMcHuPP1a+3nAx4ULFVSRf2j7UkjubhaDKh+EcVa8g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PD7fguA+0DuPJzyBK/J3/AbOnO0yns7W2/60PUlIy2U=;
 b=dU1YVv4XzGcisesVCz4kSFCRiHGm6KNSIEYWjR7TKYQ5sTVLwpG5O9Pqk/HgzjYviHyGduGykgQDXHobvtGXRTFn99d/ymgnJRceORA04+m6Bity9ncD5C6z7gyGost/cmvlEl1ewFXksMWi9oAp0yox9GIFCTLgcgfTD1e3Wh8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by PR3PR04MB7401.eurprd04.prod.outlook.com (2603:10a6:102:8d::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6254.33; Mon, 3 Apr
 2023 07:08:26 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::b999:f2c6:a8cc:7b4]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::b999:f2c6:a8cc:7b4%4]) with mapi id 15.20.6254.033; Mon, 3 Apr 2023
 07:08:26 +0000
From:   "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
To:     abelvesa@kernel.org, mturquette@baylibre.com, sboyd@kernel.org,
        shawnguo@kernel.org, s.hauer@pengutronix.de, kernel@pengutronix.de,
        festevam@gmail.com, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org
Cc:     linux-imx@nxp.com, linux-clk@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, Jacky Bai <ping.bai@nxp.com>,
        Ye Li <ye.li@nxp.com>, Peng Fan <peng.fan@nxp.com>
Subject: [PATCH V2 4/7] clk: imx: fracn-gppll: Add 300MHz freq support for imx9
Date:   Mon,  3 Apr 2023 15:13:06 +0800
Message-Id: <20230403071309.3113513-5-peng.fan@oss.nxp.com>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20230403071309.3113513-1-peng.fan@oss.nxp.com>
References: <20230403071309.3113513-1-peng.fan@oss.nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR06CA0013.apcprd06.prod.outlook.com
 (2603:1096:4:186::18) To DU0PR04MB9417.eurprd04.prod.outlook.com
 (2603:10a6:10:358::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU0PR04MB9417:EE_|PR3PR04MB7401:EE_
X-MS-Office365-Filtering-Correlation-Id: a0191e40-4832-4e6a-466a-08db341237f4
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 1zEKM7JNJbNFNBvE+jwUXlnr4A1NbauONvTaztpAfu2dnpHx/yQdrREwk5BYCaksFTf9mOCecRilP77ovYQYA8smUCYsrbIeYPWZA06OpLHS9gI78s2sFv/meyYus0hB14l2X+La1v1q8MYLuB16LDQFrwtAIqSFMF6ewf7IeprGloqDvjbskTN2Dl4dRfmRKE4p4SSSFXnV+3J2A/ZIVNeH7NeG3m7gDuK2aKzTeSoF3Bl9WAYT0LZtSL+EEki+SweopIunw2L7xT3t2Y1EIayyuXeESD0BBYT/f3bnvd9DrlFxEtIGALvCBFltx1Hr9TI6UqfxDEsx6wyULZyy8lT0BrUNrRylwUy1c6TDe0JfkyTg8dUl0bysIXRPQPDzsMqXzNQhKV4W82QQzcOo/XckqE4qsj1jij91Oz0023sFDe15QQSUdd8cGlN2/AHoPc/HX3eBI0b6B7+GCb8OYHxvSAOCm+/KY5jT+luNsG0hZMiHMGvXgyMYZiaoS2vvLI5o2WVq1hwnTVIsxbT8AaBQhP/h0hKAAVzngk4qAzf+roJLlHBhvWWXbO6hMeElens5uMXXlVJFc1lpyCvjLxlOAQ7BA+KCD8SgPpk04vhf387XvD9On6mwPI1SdnKM
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(376002)(136003)(366004)(346002)(396003)(39860400002)(451199021)(83380400001)(8676002)(4326008)(66946007)(66556008)(86362001)(66476007)(2906002)(41300700001)(316002)(54906003)(478600001)(52116002)(38350700002)(38100700002)(6486002)(8936002)(2616005)(5660300002)(6512007)(7416002)(186003)(4744005)(6666004)(26005)(1076003)(6506007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?dF4W3GWQWOhjnaKhqHRkVn0hRVguvGoMqIklwx1wxe5/LLkhKqBGT6qSPUrt?=
 =?us-ascii?Q?I9lQP2kTa6eUm2JTad6pNqj89s/H7bQyqTq33Kk5gqe3gj1uwe6jkuZmI7wv?=
 =?us-ascii?Q?dMYC6ZffsAJdJs0924ZOIt4/8wBpj/WcYA/dyc7U1rgLOr8/ZE9JR80pknvV?=
 =?us-ascii?Q?WSFJhAGRSrnKaTaD3PzthnYZKygZRn1n3cciUZO+eFkwZhM4aubguULqH2yO?=
 =?us-ascii?Q?TQf7zWf9X3QmD666Slu2gFNAGEwPDxq2wq2rVfOye14BDqR6j+pBHXZ3eZao?=
 =?us-ascii?Q?jMS/a2WaLj1Rr27tDiajfSWlvzBDET7adJnhDGZNcDier/AeJOBm8CU0Ixp2?=
 =?us-ascii?Q?ylsoR7zdkCIt3whT9sIO/jBfaVl/DsOf26Rp0FO77hucxNd1IYeee96RmkYQ?=
 =?us-ascii?Q?2z17j6piewWnH9jhKUIXrFcQjpGMXkl1SBxz6BsMroJjPXTaDk5cxb94qrM5?=
 =?us-ascii?Q?ICg09J8wjMm+gKTihWHhp2WA3erKfl/eBsLYaDk/Eby4MekX6vzX2N1MqOL+?=
 =?us-ascii?Q?8kntinphOcd82mzys9zilkgc/rG+9FcZCkUnfcBTCchdVrJEct3Ki7ihfc/j?=
 =?us-ascii?Q?jYOeZUdWS0ZyZGjB8HNl0biBj6dzTNxDPIXoUQBohGlmnC1tiFfZ+r/hF5Qm?=
 =?us-ascii?Q?2GUq+Wjqw7/G94YJFyRCDtXj1zAFAhB+hfghxfdruR0Y1TLJpAqmuLvEJ4mQ?=
 =?us-ascii?Q?npYo9VSJJ0mXOat9Ec+PpM11tHSQWJmMhutiYPZEOEzT7rnWuEkaxpqoasip?=
 =?us-ascii?Q?Fvcv4JmqZMBF1h7v4qJ9wIVdwJqDCUYU97uANsXAPYyJ3+PG42Hdeq+CDNBg?=
 =?us-ascii?Q?OsnouX293gWj7/L81ZCR4eHC4Genbab70Ser1UnQAyu/HJ4hpPPyufsuioyx?=
 =?us-ascii?Q?k7N0gmQ3tVhr29ZwysjbQ/ZiiVvq9/A2WMnWT2l3Z7cQidFj9XDfwBQU1UJ9?=
 =?us-ascii?Q?Ic0DEFxl/NULAG0IOfBTpD8dY6bb+Idu7A9oQLPwZSo7a+uCvBB/0im0g5jO?=
 =?us-ascii?Q?CDkZ/7jPVgjIxuzfQuTO2QzQajQyTTfFpqAQl03J1ybLfhZ+3yxsj5sFJ8ad?=
 =?us-ascii?Q?7NRHGekGtEG7E1nlKS63SPLhzlh2QtiDmqW7tzlln7/5/z8m3Fnm/As1GmkK?=
 =?us-ascii?Q?aYeeL6VkN9RYFDRcczBgIPfqNrUjSvmNwb4hKpwAmJz0Hwg9eU5rie1U5ZJu?=
 =?us-ascii?Q?Lu40H66eDt19cZ6MeKFps0X2e+Fee3qjOXDnJJ/ntLWoqXpU+20EEF180dql?=
 =?us-ascii?Q?vbGkMN7eSyRncDUDd6TuHV2/zI3ZAM16C7T/vpIE/+hginsjNlnbdIONR78K?=
 =?us-ascii?Q?3CTBx3txbMm3bUJEuHvKpmCsTjZsrIgWkwv1LMHvNdzwjwNGdCWpAZulcK+c?=
 =?us-ascii?Q?sJWucWdI+6bCPBwNhqv79a8JpUineFPeXlh+0aJkvNhjoSNFRWynzCjfxUfZ?=
 =?us-ascii?Q?iKfvxm/Ly7GVepwVk0DJWcNQ5narE8aS9MORz0f3+FIKSyfKcvfKSbAaK2i/?=
 =?us-ascii?Q?KZvzzWAmOKZCkddATpqUMZTIZzWMAJcqbWPy9rYwR0l8/66IIIOSRorsIl+6?=
 =?us-ascii?Q?xH1BqJOKlvmYq1M6FYqeYBHrJy++oSo6H0m+Xog7?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a0191e40-4832-4e6a-466a-08db341237f4
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Apr 2023 07:08:25.9870
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8ZThYQW0AdZgMgxFFEgK8gk4ljBG0Wh2/124/yIobt6efZcfuPF9zEtKcHP+3VS6k+NQnA1fYomd5mkUQyO1Hw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PR3PR04MB7401
X-Spam-Status: No, score=-0.0 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jacky Bai <ping.bai@nxp.com>

Add 300MHz frequency config support on i.MX93 PLL.

Reviewed-by: Ye Li <ye.li@nxp.com>
Signed-off-by: Jacky Bai <ping.bai@nxp.com>
Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 drivers/clk/imx/clk-fracn-gppll.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/clk/imx/clk-fracn-gppll.c b/drivers/clk/imx/clk-fracn-gppll.c
index e2633ad94640..c54f9999da04 100644
--- a/drivers/clk/imx/clk-fracn-gppll.c
+++ b/drivers/clk/imx/clk-fracn-gppll.c
@@ -85,7 +85,8 @@ static const struct imx_fracn_gppll_rate_table fracn_tbl[] = {
 	PLL_FRACN_GP(484000000U, 121, 0, 1, 0, 6),
 	PLL_FRACN_GP(445333333U, 167, 0, 1, 0, 9),
 	PLL_FRACN_GP(400000000U, 200, 0, 1, 0, 12),
-	PLL_FRACN_GP(393216000U, 163, 84, 100, 0, 10)
+	PLL_FRACN_GP(393216000U, 163, 84, 100, 0, 10),
+	PLL_FRACN_GP(300000000U, 150, 0, 1, 0, 12)
 };
 
 struct imx_fracn_gppll_clk imx_fracn_gppll = {
-- 
2.37.1

