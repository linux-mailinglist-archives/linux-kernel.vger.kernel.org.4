Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 54CDE6CB601
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Mar 2023 07:24:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231694AbjC1FYO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Mar 2023 01:24:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52282 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229654AbjC1FYL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Mar 2023 01:24:11 -0400
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2066.outbound.protection.outlook.com [40.107.22.66])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A96AE19B6;
        Mon, 27 Mar 2023 22:24:10 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dJS19Wg3F7Hg6awp1k59Hty7w920CSwx7na0j11mSohenbDfIQBKzD6N+HQyo/X/XGLFeeVc4yLhamH4LbuJS83NVJZ8Whh8sdrswAdvF9/fYirXnzG0NZVhvPKNDyzR2sGRkCJatbbP9Dn06pS7lbtE3MXKAK4SJQCpsINckRKAqQBhA5FuFKg2dlChy19XhAM7jSr/imsIdg8ujaM/nGNi8+DJ3EYclOg/F30koYeMu6vg8dsQI9/ITWxa2jWzaiZeyZixjLP8CDiZPoaDzxCwVrdQ/MDGs64zRBvJ+yHss49WjCuJ4+58fQ9qOt3kwLhHWiRTbkpC43btzxjbJQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hR6FJsLQdxrPiUOWnyP/PqdGpoti46e6AujRPKzNIPQ=;
 b=b60TNPwpd4xyh+ibLERd739VmhxKbc9uN7klgWUqA3Gj7LX6s263j6hvNdqqk7dCszsl0fyVu3DhXFo/upi4TRmpEHSZuYCoxi6q5RSZ2QYR0T1Er+A6GozkObmyR2PpFAw4kWgMaIMozEvIByUoergLdv5bfmSiqhp+jQIcS95p/HPPPv+9jTYD2E3hLpVeRaXCOax3gVubMCHYiQYfTqzplli5ltT8mOHmPOv1AFOEHYB2IfuXelAQ23ANJCXxhgEWjLnP7M6wfJZP6db5W7SrSNEI/UjYxHMyhqXq+A32h7+A/ViokZdQlmMYaLpCU6c9anOW0dd0UVdH819UVw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hR6FJsLQdxrPiUOWnyP/PqdGpoti46e6AujRPKzNIPQ=;
 b=DvM5OxbaJl+ODbLev26+vEe3xHJfc4nX2zbBSXBgACgAqX5dzlcsh6LzXojWv5aYE3m7QsiFS53dzCyRo+Ytj2h/VDRirPJqIo0q3Mu+0AttXsNQ29q4FYMcwFt0Lkl/if5AHay5txM9rNOMD2SroGK8mXceRD8SPvlUaG1oHvY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by AM7PR04MB7016.eurprd04.prod.outlook.com (2603:10a6:20b:11e::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6222.29; Tue, 28 Mar
 2023 05:24:07 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::778e:19d0:cba0:5cc0]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::778e:19d0:cba0:5cc0%4]) with mapi id 15.20.6222.028; Tue, 28 Mar 2023
 05:24:07 +0000
From:   "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
To:     linus.walleij@linaro.org, brgl@bgdev.pl, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org
Cc:     shawnguo@kernel.org, s.hauer@pengutronix.de, kernel@pengutronix.de,
        festevam@gmail.com, linux-imx@nxp.com, stefan@agner.ch,
        linux-gpio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Peng Fan <peng.fan@nxp.com>
Subject: [PATCH 1/2] dt-bindings: gpio: fsl-imx-gpio: update gpio-ranges
Date:   Tue, 28 Mar 2023 13:29:11 +0800
Message-Id: <20230328052912.1957000-1-peng.fan@oss.nxp.com>
X-Mailer: git-send-email 2.37.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI1PR02CA0039.apcprd02.prod.outlook.com
 (2603:1096:4:1f6::9) To DU0PR04MB9417.eurprd04.prod.outlook.com
 (2603:10a6:10:358::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU0PR04MB9417:EE_|AM7PR04MB7016:EE_
X-MS-Office365-Filtering-Correlation-Id: ef8f03c0-ab63-4ba9-65f1-08db2f4ca6d0
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 3gsJ2JxsObyCFaMfWft0YvqnBrZy93/13olUn5GGuSTpAxedam6OOaCwm+UkkW777IWIwNHzO1WzCdtoyaU5bAxSRWYFc6sF6OvVpIHEsakywYojJ2Izv5aLTYSOiqm/5b1CqF0o+XQPPGH4lX71AmSoMBVeLT/JlmtIhG5eTDWOeLfX4JCpnAFYecof6tB8gAZeRXEFBN55T+sIyLc0sEZYe8NQVWpkLOaPcv0FYOfSCYmNoykvYYxCWg6YSpei5RmadMMwLo0mdgG5zK+BRBMblFWtGLwnwBnDNEqHR3U2ekAIyoHZk3YtH7fDL0/UtZzH5IRiXW2JO2daK02/R6tstcfsUbZF5ie0as1nWEoto1nbHGDkYc5mNYzMor3neIbJZwyq6/n7+y28vroq3Up6u/qwVo062rAxOlQRLkSQJlU95DFWIwghS78dIg9AZKGmDJpopf13N8hntqKh3Zpk9oksCy+kU+iXz+DFyd/fXAq7Qg0UoyVg6cQBSmTqr+uEtFnaim2uCToDuQXwkEb0ZO2Wv6XvdBscDrvLvJJJ77vJwTX+3mJ3YNyQShptyghFhQyQ6kxtt533TkqkQ/uIt/w7ZQMjEgu5m2JP4tnYG/Vf8ZSM3Rfrf3kdqFpI
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(376002)(136003)(366004)(346002)(396003)(39860400002)(451199021)(2616005)(83380400001)(8676002)(66946007)(66556008)(2906002)(6512007)(4326008)(66476007)(478600001)(316002)(186003)(52116002)(1076003)(26005)(7416002)(4744005)(6506007)(6666004)(86362001)(41300700001)(8936002)(6486002)(38100700002)(38350700002)(5660300002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?K/+jBgkY3kFp+LKokFiwNitr2Njo9vvkYfmdfmTuG++XECbjw4AV2Y6lLcTr?=
 =?us-ascii?Q?isIdF5Bm6gnMoenK0iDLjF0Rpc9iNJiA50/XqKEDtYi5zoZqnNZUpGH2RC27?=
 =?us-ascii?Q?MPyYCgapsFlLgYjKUjyyQLMuQKhSQPsLhPgldGPRZXyymbHtGKZBYO6Yz/pl?=
 =?us-ascii?Q?o0uKr38BiG3JcUSRuJPRWVQSj0fUZnaVDTZAJrNsmreJK6R6XXaXIPPQ3iGT?=
 =?us-ascii?Q?hzH7yyz17cVpRfGj7hHUvfWXtstMXSAt9mVF3JniNLGhxePuqIKsdqIkc9fS?=
 =?us-ascii?Q?aRcnytNqRMBQg4EJtcETSBik5klIcPtyQ+bos8xQtpPHvYy1FpUkYq0pxV9l?=
 =?us-ascii?Q?sM8+pL/Yw6OFqgoI/LSKkaOFaaOM5SYXfUiNqXhWWVeU/0fSWnuXpr9GqT4o?=
 =?us-ascii?Q?BYuPwFOoDTcL+g8FdKrJvDOrBzXTJoPfEsM1rKrMxBNmUUaQkt+H4i/ZEP4d?=
 =?us-ascii?Q?ZKtQxygkeKdnyFga6g8UjgP8wKs4vl72B2g6zYYWZ7YI2FnBALGYHcyTdlYp?=
 =?us-ascii?Q?nQOQbnpLbRlFhmSD2BCP0ucA6RrXEzOkzWHR6oaqsaEnk3BL73kNCVUPN+Xe?=
 =?us-ascii?Q?8bq6G8RNGdJMbRzphPPcwuzmjhlX4U9sejXB8VKqYcULneuhjZQwJWLWijiA?=
 =?us-ascii?Q?iMCPggOQqmbvqQtv6i1lP8qvzxc35SQ6bH7wbLIPeXW6GZKtXWy+OU3AsF0i?=
 =?us-ascii?Q?bk4eRZgif6zzwjsqJkBlkdX8npFUCVoMSHMtk0CvFFrusTLoQalvg9S4IaEo?=
 =?us-ascii?Q?Xr8JZLUH5vqXITo79436uIizZOrInpNUUseBASmoQgtn3s/xp0Hu63E5t2h3?=
 =?us-ascii?Q?tvRwcZn2Gvnbu4PHw8vB4URLRuj3KToW1SJVajnKhZe4vtupLI5uPeyQcH5Y?=
 =?us-ascii?Q?VqCEffjSrsZRu2fFNBNKCES7vQSGjbxPtN3t2xct8z9yuKNqZAJQdaTclCLE?=
 =?us-ascii?Q?bM7QVv6mYQsFwwmidVsVaRUSVK8kamO9Wq1KPm5q0C1Xjo6oFtvnNYQnCieT?=
 =?us-ascii?Q?YpdrR6YnWGMHpSEq84X/WRg+p6wNUE+iUZjZV0HEH9ELijHXXI3nYC4l76ff?=
 =?us-ascii?Q?OnJSYr6L54N6EF33G7zfNIj8lpK0KcKi75dBtnfqUHODUpmNtcPfoBlVm6Ym?=
 =?us-ascii?Q?SeTax3tGod8gqhcarxLCBQ9wjfyP7NEJNzC+eCwtxM/urcvEaX2KHPeD3UYr?=
 =?us-ascii?Q?bBHe4XSBxmhLN/7dDFT5uV7e5PMnZhWkVlUND4IT3OaQxN1f892BKvBNdiEt?=
 =?us-ascii?Q?kHJlI52+V0B44lJe3vH50ki7cAfLVgXCjBETo2jkrqPic8cuKDI4tIYV8mqI?=
 =?us-ascii?Q?6N8+sYDfG8z9pA7mI3G3cY0uGnpXqPQPQp0BHWEaZ/0O+jtSEp9LJwzd3NZL?=
 =?us-ascii?Q?jsrE50uQ91ca3Oc9rSG3PhCn3zqd7NYIoVkIU1fyk5Vyg7FxZpcwyS/5rovN?=
 =?us-ascii?Q?gmr6nVWqNFY6OwC+55gcLl7PBZFWJzYF6a7hoOt8BROx/38FeY1Q2yVZseTa?=
 =?us-ascii?Q?wAby2pRRra/Qd7BN5wE+6RESNyKR8oX7ikuP950Ru7+a3xoI7ly4tncWUZuX?=
 =?us-ascii?Q?AmM//tE+UqaSjnx/IK8XLteRyFzhew2VT8pObX4I?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ef8f03c0-ab63-4ba9-65f1-08db2f4ca6d0
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Mar 2023 05:24:06.9322
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: CebxJhMkjg/sz3TeSKGGdmbOVNGPi28bmc/LAvibN+OWXMemaf7FG893MMQGHSYf71pg1gvVXyCYQ5Sm22uX+w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR04MB7016
X-Spam-Status: No, score=-0.0 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Peng Fan <peng.fan@nxp.com>

one is not enough for i.MX8, so enlarge it.

Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 Documentation/devicetree/bindings/gpio/fsl-imx-gpio.yaml | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/gpio/fsl-imx-gpio.yaml b/Documentation/devicetree/bindings/gpio/fsl-imx-gpio.yaml
index be56c3faec0f..e303455eadce 100644
--- a/Documentation/devicetree/bindings/gpio/fsl-imx-gpio.yaml
+++ b/Documentation/devicetree/bindings/gpio/fsl-imx-gpio.yaml
@@ -66,7 +66,10 @@ properties:
 
   gpio-controller: true
   gpio-line-names: true
-  gpio-ranges: true
+
+  gpio-ranges:
+    minItems: 1
+    maxItems: 16
 
   power-domains:
     maxItems: 1
-- 
2.37.1

