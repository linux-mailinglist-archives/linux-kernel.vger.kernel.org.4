Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 852B46D4139
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Apr 2023 11:50:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232211AbjDCJuq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Apr 2023 05:50:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33992 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232067AbjDCJuT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Apr 2023 05:50:19 -0400
Received: from EUR04-DB3-obe.outbound.protection.outlook.com (mail-db3eur04on2075.outbound.protection.outlook.com [40.107.6.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B4F601A444;
        Mon,  3 Apr 2023 02:49:23 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cugCpf5ObAKUth6XctEYd2qePsS9BL9tk6PLyzgBM2Bn3d9cgbeVcHhPVMSO1wBSgqIIZpWPV0poIL+y6C/C1tbPlsaX7YvuAlfaoN4+AENY7kq1l7TIPu6aOsl2iicd2xV0kx8ArjEQXTyKkYa1h6oB+RDqNA+aYI2RrN/0zRsZNFM9fSNYKz+biOENnStBmJSzintfrYwU//sZtr/3WGNskgPuwMBC2qQfC9UKgp1kiQkPfkWu8eIOUgCrDw4lFX9dgI3xvBdjC3IjNfEBQxx9oZN8oCHS7u6J/vBjag5ZalUkIuimWz8yITjtkKecp7UwzZFjm3JmETzI4PPaDQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YQ82eJSqbsMwdwdcVQ1YRbVTFOf4x2bv6//OwnUJ1ag=;
 b=oEr1oWex337sPAWK5CLGdri1ZyH28gI97GTVCu8fSZrX/Geo06f6yWP419oX5x5f5TL3yB1EN29XRrsk8sPuZLjb3R98MTUJz5R413URKWDvZp9aPUGtDo1mzEGiaecibNwmrgjzhOvPwz5Pmt2IMr3UIpP63ZQ3Sq0461tXyZOJVRF0RwkiM6JeIss/vlYxwG1zcRxDuranwsvsDHKfBc9lfDJi/8iZYLDrhHr3/cffX54l9Xl/1oDIKWVfhsLT9cIyXDcjAclUcp543Vd/kw6dtaQrQM37/I5ub4vz2+2LYh5CQRFs/9A8g5o7NgkBJWu9HCf9k39qbgPZfoMuCQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YQ82eJSqbsMwdwdcVQ1YRbVTFOf4x2bv6//OwnUJ1ag=;
 b=IPbWjPwZ9IDLTJZQq3nL8ddjocfObjS+3+wFUOHOkXr1FBA/9hZSBuIdRz5irSkUE18pWm8qrde1CIqLmRFNUjvhEGD1PTN3trZU5MzXiQL1MUbDijjRV2/ZDMxssFv/gJtyHkruQKGMHMivtGpxtEr42yrDD6rqjYhtyUGKUvE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by AS8PR04MB8070.eurprd04.prod.outlook.com (2603:10a6:20b:3f2::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6254.33; Mon, 3 Apr
 2023 09:48:27 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::b999:f2c6:a8cc:7b4]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::b999:f2c6:a8cc:7b4%4]) with mapi id 15.20.6254.033; Mon, 3 Apr 2023
 09:48:27 +0000
From:   "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
To:     abelvesa@kernel.org, mturquette@baylibre.com, sboyd@kernel.org,
        shawnguo@kernel.org, s.hauer@pengutronix.de, kernel@pengutronix.de,
        festevam@gmail.com, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org
Cc:     linux-imx@nxp.com, linux-clk@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, Peng Fan <peng.fan@nxp.com>
Subject: [PATCH V3 6/7] dt-bindings: clock: imx93: add NIC, A55 and ARM PLL CLK
Date:   Mon,  3 Apr 2023 17:52:59 +0800
Message-Id: <20230403095300.3386988-7-peng.fan@oss.nxp.com>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20230403095300.3386988-1-peng.fan@oss.nxp.com>
References: <20230403095300.3386988-1-peng.fan@oss.nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2P153CA0034.APCP153.PROD.OUTLOOK.COM
 (2603:1096:4:190::17) To DU0PR04MB9417.eurprd04.prod.outlook.com
 (2603:10a6:10:358::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU0PR04MB9417:EE_|AS8PR04MB8070:EE_
X-MS-Office365-Filtering-Correlation-Id: 02b26729-60f0-4f40-7872-08db342892b7
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: W2+9Hq7OX6fmHC+66BKcjUBll5VOLFM6JTAKNC7Huob7SHXa4OxJAqHTjl4g63nNK2+oML1LBKlHJ9SWsD7wjQHE2oLXdYX1R1FATPgNz0UZto5kkSfEglA3gIlldHYSejvqoq0MSzBht581hSzw4cV2bgSGhxZ08GnOWUDJ9r21vSzDkH3/lYX6SHqXKS/8fIEo9Uj8twJl02pw1YmTDimU1h72kOHf3b6HNL94832PLp7eNVr8Kh5E26pBfvFMycjCv6OKKdI2QQ6H1qYvNLftjTAlLWSOaK8CDTX9j1dwAMbgv5CEfOX/KM+PZDZZnyoRquckmR0X9IQMJHtggg9Bozo5QbE9OXsZAAgOdybc3eoQ5hSt6upR389teX5aWCY98+7dqiz3HT9MQw7WqqGXNys9aruv9bVdzL7GOCPtarOQ9qDAU/bGlQhjeC3OOELJOp5vB992D9qgh+Jrx9fzQio2eJBPbEKahpobo3BZXL21t6MKjkV0TBIZBg+lKP+LDfXPpeChXLfpVyIhAzAz630y6MEnxIxZI/u9Edwxbq4CRrwqayz7L3rei5B5Vcf0nY3PZf3OFhD+RYayHo/c1Zw9Wv+dPz6eB0FdToWzgDRrFPSBCIgQSIPH52Bq
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(136003)(39860400002)(376002)(396003)(346002)(366004)(451199021)(8676002)(4326008)(66556008)(66476007)(66946007)(316002)(478600001)(8936002)(4744005)(5660300002)(7416002)(41300700001)(38100700002)(38350700002)(186003)(83380400001)(2616005)(52116002)(6486002)(6666004)(6512007)(6506007)(1076003)(26005)(86362001)(2906002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?QyVvYvvwwfgnK6y2c6stLpR9t39DXuhl/SunLf6XKp4WYTvgG9uw50k/jBbs?=
 =?us-ascii?Q?LmvDTJSDqvXabJIpFnbylFbmvlFrFeJW+ugR9iZ1Ae6mUR0ZvSt2e103Qxml?=
 =?us-ascii?Q?4+o6sJrb/iwOOz/3muHBorUFeDZkPxDxPqrP6jzOUk6DEWlz2596AikMtJuK?=
 =?us-ascii?Q?/YB7UURrOD7VtbqkdvpFQR578DY3tZCD3Fb50WwIH12jTQuBq4XrLkU4MFd/?=
 =?us-ascii?Q?ml82vGcYpoB8o1KQ7dAWvf3RKhXpgDTgtQZ6/OsRYPQuDnmOXnhauBCCyL4A?=
 =?us-ascii?Q?G8RlsNrd5iZon8HDSqjP6ImygrWY6+dF/94Wh1eREUxuKl+2Txk/lKGGLGvO?=
 =?us-ascii?Q?hTxc3NOrNZ16wvkoZJyv9KwXoSU1tS4G0ylrZ6M59NMN5rKB1cWenW9+cgrl?=
 =?us-ascii?Q?0uCXKDy8X80yEY20vNozlxu9elSSO0feE9QDKVSUKPBjPKicyq4DkMhzKPf+?=
 =?us-ascii?Q?uA2XUi0bYgjHDVDrZXuX5KbCQM2NYNSbq3yREsserY7ZfZVHkvz6ji8a9FBS?=
 =?us-ascii?Q?P8IKArw80bRCQtLKjfYI9DrZO7XXU1bUCS6ju0iuP9LUE+YXxHkAN+E12hse?=
 =?us-ascii?Q?TS1QJ3ZxV6GNUKkPBn57+dnaDuk6CKk9OjxKYS6lovVwf3ic6Qp2/tME0VgP?=
 =?us-ascii?Q?0je32BRnxjovVzkk6hKhYCCn/L5A4NxuASdqTw1K0leP431Luwc6oLGV5K+v?=
 =?us-ascii?Q?70O8jSLVZDr0yAxNm5OHeh5wtyD6gTTOvaJOy7FyOBbJ+uihgF74SMM8U9Ce?=
 =?us-ascii?Q?Z7gM/rPclTw6NzCce9R7rxjZCLvaEg5ZNQnOYr2EqgBZS8MmIt0e+AJ+RLvT?=
 =?us-ascii?Q?G1g54PPYzXYzgrejjRfpHcligdkWZgZSar0JYWUzVXyt7xw5D2y5TMqbjgU4?=
 =?us-ascii?Q?aNRxp+Lh80vd+90lksUElI1wD7MDtYlDvwQ4GbJmeujRByczL4ASABEhiZUO?=
 =?us-ascii?Q?pSrZKM0rgs3d8GZPEjB1O7gQU1W5jbx8yXCoUvUjVQJEwGVHQJwmYDFA3smU?=
 =?us-ascii?Q?hhsQJ/uaQPR5RkgbMtgxkZffMiEM66xFkml4J8dUeYDUHpJq4i6+rpX+EfZ1?=
 =?us-ascii?Q?WN20/ekm/TVBglCKjS9wNTPxc8PwtxpLbarvpmDeUo7KSHZXHwp6C/V/kkdE?=
 =?us-ascii?Q?ZIyzV1fiNJLA8kPiZxL46HBnE0a1INDrQEVGqEsu/ObCIM5qMclq8nAtbfD7?=
 =?us-ascii?Q?OAtQW3/gWzyNPYr00Y5wSEzlM8US+uDNFQnOJ8viUtEaSLqq5Gp/8mJbCiFF?=
 =?us-ascii?Q?j67t+8FZzjfQBQu9SYZSRueQJhZaktihtUi1x4QWVpLhJ2CkFs/+tIunoN5e?=
 =?us-ascii?Q?vL7bwcxPj8IMfVpmQAT+u6lSLAlZXqbROk6V88yIiA69TN1Th2LbB6k7TK2S?=
 =?us-ascii?Q?ooWoEm6WsVZ+WvIsygYEuF0wZZOksu5woUt91Sf7/c/zdoypGAV1bZBXgLro?=
 =?us-ascii?Q?z9TwRqM1KobbDWI3ycVBGW0e0xMMGwB64OhVzZT93JRmo2s5dW7WMAbEwh0R?=
 =?us-ascii?Q?/vg+Kjr4QxY0GKp0h3v9Sfjb8ieX2uCKG6p4Z9bhk5LSrGjuM0Ou60juH+QB?=
 =?us-ascii?Q?D1A3e6nayq4sLY46znxnG5O6ECxkLWyG7ksi6CfC?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 02b26729-60f0-4f40-7872-08db342892b7
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Apr 2023 09:48:27.1606
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: XeN5+LDbzZR0W2qMtEhlm3b9diuvuFlbTXNdQLJEsgieUWWTljpI4+DrESxt7i+60YD1Oiivk3CKNWjpNwNqVA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB8070
X-Spam-Status: No, score=-0.0 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Peng Fan <peng.fan@nxp.com>

Add i.MX93 NIC, A55 and ARM PLL CLK.

Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 include/dt-bindings/clock/imx93-clock.h | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/include/dt-bindings/clock/imx93-clock.h b/include/dt-bindings/clock/imx93-clock.h
index 8e02859d8ce2..35a1f62053a5 100644
--- a/include/dt-bindings/clock/imx93-clock.h
+++ b/include/dt-bindings/clock/imx93-clock.h
@@ -199,6 +199,10 @@
 #define IMX93_CLK_MU1_B_GATE		194
 #define IMX93_CLK_MU2_A_GATE		195
 #define IMX93_CLK_MU2_B_GATE		196
-#define IMX93_CLK_END			197
+#define IMX93_CLK_NIC_AXI		197
+#define IMX93_CLK_ARM_PLL		198
+#define IMX93_CLK_A55_SEL		199
+#define IMX93_CLK_A55_CORE		200
+#define IMX93_CLK_END			201
 
 #endif
-- 
2.37.1

