Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 96F22654B83
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Dec 2022 04:04:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236017AbiLWDEY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Dec 2022 22:04:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57334 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229603AbiLWDEW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Dec 2022 22:04:22 -0500
Received: from EUR04-HE1-obe.outbound.protection.outlook.com (mail-he1eur04on2049.outbound.protection.outlook.com [40.107.7.49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 75CD32CC99;
        Thu, 22 Dec 2022 19:04:21 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mpcsEH+sbiT/2YZBC/fEvILOlf/Cfx7egFvVbi9EKFnXYLAq7Gev/h5x1BsPEtbAHN+gFxk2YyXGC/Jbx0rpwA5C8POiMiSkpHCt2twd63juAosMhjllCj+/4GWLGyBIQ6WV1TQrJSE1j7EbRRAmnBz5QrgJNvvco3wO44KDpUKNivVexT8TATcZZQFwXZl7wDsUKpOkoAaKBGp+Omj81UZFkxsYdCPLf+HG5Wy+fLNHesActd+sgSviNWnzsPaC2Jf3dUGMyPj097ft2sKh86XB0r15YOxdAyyM+ETD9EaBlN1ah5ASlWHcdRv18L4OrRWPLG3gp3tHS83i073NZA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HQkHl0auoFVmyBNLMwNOFNOsJjy1jZ3UyZO5mI+57v4=;
 b=MT7aIK8rNUNkZp1C3sGUE8vt8k9YFww6YRH1+XG89Ya2Jp6nMrRTq1OpIXbOxpKF93BsAhLQ59GH7KNvP3SUGkaTLUbk7Lmtl/ATPBC1aovMiCsd9pDDnx/spnjLb2yk3+zUne77e7S6we7qwiBQO1U7IZ4sQg+s8HQ455JflGFCbqb493qLGbjaTKfIhy+iPPi0CALIQWkBDSTd7fXpYpL2lUbP1RDNxRcyQ+ikWR20KxjKePnfrUssAulW2hwQdVnlcdmXH8/4nVh62xHADHQGu/BSNhzINR2qfNq8i44K0kH1zZh+F5LPZO/wXR55g2RlqGxOiUYz5uw55fejUw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HQkHl0auoFVmyBNLMwNOFNOsJjy1jZ3UyZO5mI+57v4=;
 b=MGXT8apW8aCW83UBTNfNrblUXf1jiWWYglPzQ2s2mOAjkG1EPdCxedGtqTyVcf1XoNgw1rQRF56TJWrOBCKWB6jYnTcAZT1ty/PH4mGguTrqIaszXFhPrjRl3iFOUucjWriDdO1+Cj88ruTdP9pmF+FMkIJtM0jHGmSrJN0ot+k=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by GV1PR04MB9103.eurprd04.prod.outlook.com (2603:10a6:150:22::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5924.16; Fri, 23 Dec
 2022 03:04:18 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::e33c:46f9:ef88:8973]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::e33c:46f9:ef88:8973%5]) with mapi id 15.20.5944.013; Fri, 23 Dec 2022
 03:04:18 +0000
From:   "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
To:     abelvesa@kernel.org, abel.vesa@linaro.org, mturquette@baylibre.com,
        sboyd@kernel.org, shawnguo@kernel.org, s.hauer@pengutronix.de,
        kernel@pengutronix.de, festevam@gmail.com, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org
Cc:     linux-imx@nxp.com, linux-clk@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, Peng Fan <peng.fan@nxp.com>
Subject: [PATCH] dt-bindings: clock: imx8m-clock: correct i.MX8MQ node name
Date:   Fri, 23 Dec 2022 11:05:40 +0800
Message-Id: <20221223030540.62018-1-peng.fan@oss.nxp.com>
X-Mailer: git-send-email 2.37.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR02CA0024.apcprd02.prod.outlook.com
 (2603:1096:4:195::18) To DU0PR04MB9417.eurprd04.prod.outlook.com
 (2603:10a6:10:358::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU0PR04MB9417:EE_|GV1PR04MB9103:EE_
X-MS-Office365-Filtering-Correlation-Id: f5c8884e-30fd-4930-62b0-08dae492619a
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: HqOkO8P8kn/HImGfh5DqcrcdWs7IeHsVM+FWvgejs3q/kuTp3psi+s/u4jy7SeRd+QbBSWocCWTNz4+Poo2hz8OtGq/btvrNJeXsQutLOWYQ7BQq+SOBY0G75blgUsYK5u1NhBKGK0Gn+bJwNhLgWwmhwgCPpyUCJDkIlX6vL2x5D2xA9RQcqHAN4mKzNgTyEZJ/abSMzZD18OVBR2q+5CbjgzBC4acsKnrR9pmo8EsyMZWF+wbA9mvU7vIACEefu2ZOIbzVZ5xeFN6YZoL1oh2X6H+s/c/QBzFWdneLijR3ut1k3PlGvOEIAaYZU6vODOyoFNQHfnevGtQPcPjxZRB8wviB9dzamdZO+59Jk1NTwNl8h795NkLugopzzCP6NB32SSb75ozGv8aPW/WYupNxV4aMx3IV+GCd0tpKd0C8odVfMPIY9bPECxKQL9Bfie9QP+81tmmTl4UcpHmQ7YAFfcMJTWUGjdQaKr/dR7TSJY1Kluz7d1wcJm67KIcR1k8CNap6NWaZT4PeLYmDDsFPnkD4ZqEQUOOUEBaKj1M5WHk1a1e1Kd8YMe90gFNjMzXMdsSMXRSwea+TOXUW/C4LQZFRrwgCk9/BdTU5XGICkM98hirNMMX8Lo2wgB5sb3aHwsHIM0oestBfM/B30/8t/bbiloxCk234C3TPGe77Zsb9Fal5qwuZR0/h5SKYYl96Y+A/i5bds6Z//ZO1wtL+ARi/YXli+5mHb4fZqe9XzboHBsAQfAUwPlUaVBbj
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(39860400002)(396003)(136003)(376002)(366004)(346002)(451199015)(186003)(8676002)(7416002)(6512007)(66556008)(66476007)(5660300002)(38350700002)(4326008)(66946007)(921005)(6506007)(6666004)(52116002)(8936002)(38100700002)(83380400001)(86362001)(316002)(1076003)(2906002)(4744005)(2616005)(41300700001)(26005)(478600001)(6486002)(32563001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?zer3LPspcLLuyhsXkkLiMzkD3hZ1rtMuH5Psl4tmfIK/2ricKib7FcomGdux?=
 =?us-ascii?Q?wdaaqv6MKh+X6Usryx6kOhd8x1TqTUCvLIyqPlZ4byN/329fBJzdrZDSMcHn?=
 =?us-ascii?Q?PS6hsXRFWQZ3Tx7hDDjJKmezHDaELL1lIzGYFKCM6vN41gvd3Ut4CyEZNQru?=
 =?us-ascii?Q?OfAQkSLXNzRntctIftLuU77jYMKTun/Pvd4cVwKFwYOYZdWHsMYNiBSJAXox?=
 =?us-ascii?Q?zqaPzGQFEEhxIOLAU/eAvptvBjcdQJNLGUgvKVPjvkfoFkP+J3YF7WaxB5Ql?=
 =?us-ascii?Q?xT7Zv2NxTWOCyg0wfk5u/tWnb0alRlFb+GGveHG3riW575WYMvMftUti8Ock?=
 =?us-ascii?Q?mBL+nZfnJ/Fd8Rw7kE+NTUGX2GZ0Ar+8uTs76jKR/pgOl4FI2+dvo9ccn8E4?=
 =?us-ascii?Q?7UHz2z4Op90P8DBEdVIJGJHuVZQeBgd6cDXgYRqzGiKUQ3zFu66N3m0U4mDZ?=
 =?us-ascii?Q?7SvNYWUKgsCLDB2TZIO9mkjzNAApJLfi8XicdX8sQ+KnDuG9s68lgDlUXTFo?=
 =?us-ascii?Q?GCgL4kRg1V8g0lC+ZuXiqFbcoYHM/3z8IhhY8owCT9xXy9ZIUgU3tXaKQxFn?=
 =?us-ascii?Q?f22d2jvVZFM+kNqtaIXHguYfs1XCpj8jx6RarOL97mxB0U9MOMT7Z2K332x0?=
 =?us-ascii?Q?BoRJyov2K3agScTb8+iJD4v2QyuBoziZ2pEMyRYPjTwWghaql0acj+XRrGWJ?=
 =?us-ascii?Q?fTC2pAhzRO/zg0wNXTasPvrsXvxZatej8Fjwxiuc8g0PYjx5GCHqSTPQxRjH?=
 =?us-ascii?Q?+UGF/6v3Q6/qiDTXc+sRJSV8QjGDHwU/TWmW/06awr631squXwWF5HsJ5way?=
 =?us-ascii?Q?QSly+vPR5MQzc1OMTu8ju+CK2NpgeUNnkn1IoeokBzueWOAN3QAk6+NPd+RR?=
 =?us-ascii?Q?z1VuCOJ+Wl3bd3Hmwr4B8j7qcgHUxWD8Fob93EKf/X58XYkNL0FvWFRxxoh2?=
 =?us-ascii?Q?Ock48KqCMm/MONip0o/ZeAiw3owW2D6nXsiaQgHF+3XqxCAfTbAlBkndNe9c?=
 =?us-ascii?Q?i/5pQ+Gh7PoQyxilhif8jM/9p6GnfUo/7A0E9xrTlpZKJIuhYbSJWuGxe2S/?=
 =?us-ascii?Q?wO7kthMvW/X1AxUHXvsMrqT1l0ADAVaxCTsip03gA3IWgYBRz7cn2xu4YX+u?=
 =?us-ascii?Q?+N+JmdHAGhely8hlFD6Nj43q/MQNZBOFwo1NyCd3k9l+yrrLHNM6m0PM1C4P?=
 =?us-ascii?Q?VqZp3MVwm/AxF5ZalfJzktP02adGHJX+IKStvsaAtpLoDWlTLjs5bknPgc+8?=
 =?us-ascii?Q?O4uFQ7iEEaw3cG91f1bxNP88dbcw1z+QyTlS+fALRs5Qf4q1ohTNuWDmTtO7?=
 =?us-ascii?Q?1D6TYzlJ05G7VSDZCebeLm9LUU+uiJpvDUXtPxnLlNlKI0hpSijr0qTdXfHz?=
 =?us-ascii?Q?TDlVqMtPT/reBfJMc/LNgWkOKjjYJEVYCBCnFwhcAw9oukDfZ9A+xV2jn8MH?=
 =?us-ascii?Q?QSNgPtur/NJuM7y5etZGqwwnG/wPlba1Wakya83xpQ3qcET4TF/IbQatCWM5?=
 =?us-ascii?Q?Sw3PJqcamvPuiHXryFQKZF7jNClp9C3wKtQO+lzLdvv+FSkYGsOAzFC+hloM?=
 =?us-ascii?Q?NpfaGLmMCvppheIgD2M7TMA7PDA/GGwX+CW94UOm?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f5c8884e-30fd-4930-62b0-08dae492619a
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Dec 2022 03:04:18.3336
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: QoDtUpWVy99aRzsLOXz/w6y6J43uAKW6Ybi5xJvC6mWY1F9yygjdUPGH+LyFjeuM61Ac0hshskjaqfpoKpp6tw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR04MB9103
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Peng Fan <peng.fan@nxp.com>

i.MX8MQ CCM is at address 0x30380000, so correct it.

Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 Documentation/devicetree/bindings/clock/imx8m-clock.yaml | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/clock/imx8m-clock.yaml b/Documentation/devicetree/bindings/clock/imx8m-clock.yaml
index e4c4cadec501..0dbc1433fede 100644
--- a/Documentation/devicetree/bindings/clock/imx8m-clock.yaml
+++ b/Documentation/devicetree/bindings/clock/imx8m-clock.yaml
@@ -108,7 +108,7 @@ examples:
     };
 
   - |
-    clock-controller@30390000 {
+    clock-controller@30380000 {
         compatible = "fsl,imx8mq-ccm";
         reg = <0x30380000 0x10000>;
         #clock-cells = <1>;
-- 
2.37.1

