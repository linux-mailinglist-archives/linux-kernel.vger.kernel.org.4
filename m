Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7082E67DFF1
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Jan 2023 10:21:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232954AbjA0JVw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Jan 2023 04:21:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35720 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232937AbjA0JVr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Jan 2023 04:21:47 -0500
Received: from EUR03-DBA-obe.outbound.protection.outlook.com (mail-dbaeur03on2061.outbound.protection.outlook.com [40.107.104.61])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 65F5026867;
        Fri, 27 Jan 2023 01:21:40 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KkJWSWj0HqLSGcLl2MyavJgFgvsXXJk2rcZG8W7bkiJbjjcMV0WpNPJRKYMxOoVzmRGk5egI+3MOlztHMmmN7P5lzRGGDQDgY467AN4v1E+Cu2GH5PZZJi0GNK4f8nl8RpotKxnWOcFwKuuosPk2WvOf8MzDjmV9YQOQiBRPXaxGZRow0O3y12q9kI+P9s4D7rBKQcXYQU6dwXQxeN4tUE29GFew6CMTZLk+eTWGW2J+27W0OL6DFXunXqKEh2yKyuO/AXsmzpzg4yPXmCF3i/Yk1Cd1FPwoXQ4NVN9GO274n94g36k6c3D/QxHLodDtvUGrxMFiY9aB8wqVKtQ+5A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8lc5MM1T8vUGaBjaF/rjasRhwDWKTZxJI6RGsmSNl7M=;
 b=Mh2aKQp7dPRCrRs+zX69lnmEWkWCFpLeJadc09kCeKGzP5I431AXd7ZET7cMbpO6fadSdr3AiZI0aJjb+wu9D6kselDCXWuF+BU0mG+qIkyc4MyUEJWSe6QhQ2bTln0+i2W92TxRlWwdygHkwxvmVVGZ3kFrAIMYaKgSpv6K8J6I4DVOgzJw0qEeGooCAKRrVU9DmPu8L7J4DJfqWiuNLFqupHjRZbDUql/OtyVUQj3YNVShbdCQR8ICTpis/Hs0ZTkGwTbnv9pllqYRbOTGJrWMIrEsYQm3zXiy1umpRg4f+7syzo/7EAgqoFa9ptTCCDylpItIrIMh+myWAy+rBA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8lc5MM1T8vUGaBjaF/rjasRhwDWKTZxJI6RGsmSNl7M=;
 b=WMwDfj6IiyF0OByfrQTjlvTkICednDkr4XA6geWoi2kb8W307d1ULIKg7uiXLv7X39VFqsfopbWpI0dnxlcEPsoMFoDJkmXGLHsoqQp0M2LsA3al7NZ14ISPQ/BG6BoX6TAUmvhc2WB7huEGcQcVrxPA4xBqYU8Fy0kneaEEa30=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by DBBPR04MB7530.eurprd04.prod.outlook.com (2603:10a6:10:1f5::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6043.22; Fri, 27 Jan
 2023 09:21:37 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::e203:47be:36e4:c0c3]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::e203:47be:36e4:c0c3%9]) with mapi id 15.20.6002.033; Fri, 27 Jan 2023
 09:21:37 +0000
From:   "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
To:     andersson@kernel.org, mathieu.poirier@linaro.org,
        shawnguo@kernel.org, s.hauer@pengutronix.de,
        arnaud.pouliquen@foss.st.com
Cc:     kernel@pengutronix.de, festevam@gmail.com, linux-imx@nxp.com,
        linux-remoteproc@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Peng Fan <peng.fan@nxp.com>
Subject: [PATCH V2 2/6] remoteproc: imx_rproc: add devtype
Date:   Fri, 27 Jan 2023 17:22:42 +0800
Message-Id: <20230127092246.1470865-3-peng.fan@oss.nxp.com>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20230127092246.1470865-1-peng.fan@oss.nxp.com>
References: <20230127092246.1470865-1-peng.fan@oss.nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR02CA0019.apcprd02.prod.outlook.com
 (2603:1096:4:195::13) To DU0PR04MB9417.eurprd04.prod.outlook.com
 (2603:10a6:10:358::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU0PR04MB9417:EE_|DBBPR04MB7530:EE_
X-MS-Office365-Filtering-Correlation-Id: e2733a51-f8d9-4935-318f-08db0047e40a
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 5zvo5XpdHvx5ms0GUoH8F+DSp2iwHgZMx6zDsbQBJk9gEzL0mJppWb1qQ4xBMCv7NHyiU9hLKJH3ZHA2wjPb+lAmy4QKB34Wx1Aku3hfDc9YF8GIh9ApI9F3yvzxux39nXbVbOSZrvJKYFpBPas2n18+vEyvAfIKz5ke2/fwhxh5NlbPdI1c2fCyET2S3iIOmpiA7Zn4lcIHB4xmUvqn32plNnhupDr8oqqCSDQTFYxsFj87lC1KW6p6OLMcm5aiJYbfaMHBZXcL1QpCrRrt+PJ7lX19tGsQKw3yUKgP5E7TllmLOSjbjDyQih/3H6I5g8IByPyiqRPCy29vLOGwOU/gjb6Yat+oPEmvvLB5p/FLOGgWaOPKSXeuJGmo2I25XslKS6TnX7AMcYHjutbJLUXFt2om7HCDvbonok8IWWf6l4nGcfyBai/AqDcTA5UExT+5bzUhQtJTkVWxOhqWqgAbpePGXZDd022oD2qlLBe2CDktOfExrNtAyIdoZotu2i4aMnIadw8FWXVUw2WHKtC3eKc79ZIRL0UOFq+Me3LqNKrs5YohXF6EWvGnERltj/FX2zqLRy1+cQKQqOo89V13CSFCcPaZ01vHAuvihnQBcKdM3I40wge5T5CLun1QPni4QOq877KAJm3KwTUvIOXwQThKelGfzmv/D7ZQAvH4+scrH6ANqyp34fDk8GGMwJWANV2/2T15WcsnvyjOCA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(376002)(136003)(396003)(39860400002)(366004)(346002)(451199018)(38100700002)(1076003)(2616005)(8936002)(38350700002)(2906002)(316002)(52116002)(41300700001)(6486002)(478600001)(86362001)(6512007)(186003)(26005)(6666004)(6506007)(7416002)(8676002)(66946007)(5660300002)(66476007)(4326008)(66556008);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?yxhScg6A+bIcYwC2Tw6YrLkQ/MGQo3fVYRYdrNZSDzO+4D7Y8J6cpwS8o7Fu?=
 =?us-ascii?Q?+R9ym3AFd5nqx3GkufiIQgAOogkAzB8We/bacwU+rr1dNikkQAu8GbwqgamI?=
 =?us-ascii?Q?vKSWRpV9xG5UD7K9ogqq80maggPUkg9N2lgakJjfaSWvOW6XOAe/k3i+KISS?=
 =?us-ascii?Q?RsABYj9Z6QCjtbPGcTy3/0PLknE0rdxp8ZN4ZLa9KkElSQjJLBjAeufC8W55?=
 =?us-ascii?Q?lARu5vOVOV64v4hUhYKgT22lOXROYPMTSGame8chtFiNYy0dWve2M2QqCNXo?=
 =?us-ascii?Q?NwBvKRRoFjXl1medKLDvanGUeCLslRM7gJtvh7jw2vxSJwTlsU2V5ev9AXVu?=
 =?us-ascii?Q?vpyTcww7egYyPllQBBqVfDVjEnaqBU371X4Khr3QwBRX5vZQ33rR0xOQmL6W?=
 =?us-ascii?Q?/6d9NCLtvtgOYoN6e1QL6Rb5I2pNQTwcNtJGjlavroaBcYYV8r6s/ZVSIp0k?=
 =?us-ascii?Q?W2AnXGp4EBV21/5YmzOZHnnd5C18bkKQH7XoI4qnZzty6dfKFySfEuD18UCO?=
 =?us-ascii?Q?Efkpzdl7R9u/WUsxFDC5x/6pNKqMVdzXxYRtIhfbXbgkg/6/5rudIGTUMSkn?=
 =?us-ascii?Q?PsesiSqy/qoqwlB3FjAdCzWe5iAK28jpou+KN9uzl1ZNb6iTbDKosYKPATnH?=
 =?us-ascii?Q?v/CNL0iiE2KlB8Zhcl8o9OFDpXWtSxoMBBzzxPvd8mJxkyWUTnAKyHIAfayn?=
 =?us-ascii?Q?cPH49lqW+NCmKpCmfpcDOnnLCKM7e7DQNtORk2JWA8jjJL2TQ90kB0sO5mxG?=
 =?us-ascii?Q?qrc2/xIhuO2UDO4RoIL+Y/2cnIxVW7hrkmBWeoH8KZ/b2W9AuiBzQd5Tbf3d?=
 =?us-ascii?Q?mu/C7tBywuczsXWECuaR8t6oTzJ6FgMDLVfpExgAga6bbUOq55yNZmcbZhxU?=
 =?us-ascii?Q?wX35rAC1g5aJamNw3ICnwIf2J+ISz1gmfoGj7OQlUgOFhQjYXnIAEMo2x3WE?=
 =?us-ascii?Q?ATZLSqCWdpWvo9uP1AmVF5pQh54Dg5lWxQ9XWrMlxD61LVVBbEq44ULNOO8N?=
 =?us-ascii?Q?fCgvGi4VBp8P/W5fkWR7keHZ0bMsRdxTwIUKmvVp9XzwnkJU1n4C4eWWCrq1?=
 =?us-ascii?Q?o97PwidwOc/toV2sqeio4o54iXwA7TC4DkLX3V17lwnyF6AsS9KpzFiseZC3?=
 =?us-ascii?Q?uAUah3FpOTaNIEr4HfZQK1a+rg+cmM9FLRFR+oMz2IL6yrRStTaW22gjEG/7?=
 =?us-ascii?Q?DnSUtStJttsDZ63/PmqJQWtePF4YJxlg29lMZwPJpoOY+IP/G8DegH5q2CPM?=
 =?us-ascii?Q?1wNWOaVAEoYBBYvVSdAlEfMEh8bAAcBZfG323D1HyLbLOl6smRxSS2SttXsV?=
 =?us-ascii?Q?HzkM6iptVUWBrdLe2JA+W36DE/Udo11TFaNKDLzT67ZgMm6ys5hrJ5coA0Rb?=
 =?us-ascii?Q?7rgeYrF7tACi6tUvn5MixDmPqv4D9H6rQuMdsfG5SwAsRCMdiRkegKMAs+cE?=
 =?us-ascii?Q?z2CGzZ3Kt49FAQxwWEy/xmjmXoeOCxKmnX+UydMnAtuZpvinYoUdehK3ybaU?=
 =?us-ascii?Q?LHcImMcJ7UyMay/+QYzxhiWUyZr9t501JQWwwrvQmNYgO9RPwco3X7sLy45T?=
 =?us-ascii?Q?ya7Zn8GE5da10EhbxMOx6b2nsmrB7Yf+S/KgIQj2?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e2733a51-f8d9-4935-318f-08db0047e40a
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jan 2023 09:21:37.5826
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: lUhANCTVEwrf4Tm9GN01N/IQuDjyWhTZSfbVFhYgkN27W7Y6Ic0b/cW1R6uLXO+KqHDqMb/y2rUCHBvEZmaSdw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBBPR04MB7530
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Peng Fan <peng.fan@nxp.com>

Add i.MX8M and i.MX93 devtype which will be used when parsing the
firmware.

Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 drivers/remoteproc/imx_rproc.c | 3 +++
 drivers/remoteproc/imx_rproc.h | 6 ++++++
 2 files changed, 9 insertions(+)

diff --git a/drivers/remoteproc/imx_rproc.c b/drivers/remoteproc/imx_rproc.c
index 9fc978e0393c..8a282fb67a4d 100644
--- a/drivers/remoteproc/imx_rproc.c
+++ b/drivers/remoteproc/imx_rproc.c
@@ -289,6 +289,7 @@ static const struct imx_rproc_dcfg imx_rproc_cfg_imx8mn = {
 	.att		= imx_rproc_att_imx8mn,
 	.att_size	= ARRAY_SIZE(imx_rproc_att_imx8mn),
 	.method		= IMX_RPROC_SMC,
+	.devtype	= IMX_RPROC_IMX8M,
 };
 
 static const struct imx_rproc_dcfg imx_rproc_cfg_imx8mq = {
@@ -299,6 +300,7 @@ static const struct imx_rproc_dcfg imx_rproc_cfg_imx8mq = {
 	.att		= imx_rproc_att_imx8mq,
 	.att_size	= ARRAY_SIZE(imx_rproc_att_imx8mq),
 	.method		= IMX_RPROC_MMIO,
+	.devtype	= IMX_RPROC_IMX8M,
 };
 
 static const struct imx_rproc_dcfg imx_rproc_cfg_imx8qm = {
@@ -349,6 +351,7 @@ static const struct imx_rproc_dcfg imx_rproc_cfg_imx93 = {
 	.att		= imx_rproc_att_imx93,
 	.att_size	= ARRAY_SIZE(imx_rproc_att_imx93),
 	.method		= IMX_RPROC_SMC,
+	.devtype	= IMX_RPROC_IMX93,
 };
 
 static int imx_rproc_start(struct rproc *rproc)
diff --git a/drivers/remoteproc/imx_rproc.h b/drivers/remoteproc/imx_rproc.h
index 1c7e2127c758..43b105ff0175 100644
--- a/drivers/remoteproc/imx_rproc.h
+++ b/drivers/remoteproc/imx_rproc.h
@@ -26,6 +26,11 @@ enum imx_rproc_method {
 	IMX_RPROC_SCU_API,
 };
 
+enum imx_rproc_devtype {
+	IMX_RPROC_IMX8M,
+	IMX_RPROC_IMX93,
+};
+
 struct imx_rproc_dcfg {
 	u32				src_reg;
 	u32				src_mask;
@@ -34,6 +39,7 @@ struct imx_rproc_dcfg {
 	const struct imx_rproc_att	*att;
 	size_t				att_size;
 	enum imx_rproc_method		method;
+	enum imx_rproc_devtype		devtype;
 };
 
 #endif /* _IMX_RPROC_H */
-- 
2.37.1

