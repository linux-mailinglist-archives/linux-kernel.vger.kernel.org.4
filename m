Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CB4A8690077
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Feb 2023 07:37:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229765AbjBIGhn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Feb 2023 01:37:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34462 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229761AbjBIGhd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Feb 2023 01:37:33 -0500
Received: from EUR02-VI1-obe.outbound.protection.outlook.com (mail-vi1eur02on2046.outbound.protection.outlook.com [40.107.241.46])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E839E3EFDF;
        Wed,  8 Feb 2023 22:37:21 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jMB8vtzRHtd/SrY+C50VX9Erm4NyY/yGoZ7zruJvrPXzz2CtoSY6ZcKRs8mt312BsP52oZm3vZ205lmbbn8CAHdADG8ZS1zF+WvvF8sEESxXIyVdPIbXZWtEuiMRkp8GmIxRnhy2pmm4WmXX3Bw4rpCcqIp5KxqatKYUEyFQfy0/AVBVTrxGGObk6iY/Hw93ds4GifowJbVan1g/enH5rDVEx6cC2A/CLW15i8AJTEZ2CqEcda+ZL+Qo7dlFbFQMbY+FuWP6OST6D37bojZtqhOj0fzmovnp68cjQSklj3ZutKVs3c+Rfx2kPjeRWzC0us6vk47Lqd1J0RTOGvyQVQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UHjHnylbi4Bm/ezwRvCS3z8MRLYZ+drBLaIaTBOTV2Y=;
 b=NZwbWhwWUFWpMN5EiYArDhi/bHbIro9QuUVZ+TOzNeACO995IqAxTHXv4fPtwoxl9lMhcHle8TNbJ+hC8wX9b6ji34j+hz76Gm3wuifLWQmxhMA5Fo1S6wYsfNLjLz8zS18qihIf+XEefvSpMgL20jq4BICRjwdRVc9SDFGghPjlFdxWVAl6yohTkw5TAvN4947RNwektB7jBgLBMRFAwfF6FjSL5Ij3g5kKfVRQqPokE3QAD3BuUodswhkZz2czMIV7eNZgbs4Y3Qd8Y3eDUWym7olwHmu9wKlTavRy2LML0ldYD3NxAAxcm8YUzdScRMqxSdKOkl9WdlsH050sDA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UHjHnylbi4Bm/ezwRvCS3z8MRLYZ+drBLaIaTBOTV2Y=;
 b=i8Gj2LTSNRs6BLcIgoFbIijjI4EMn9tvtbO0SyNGFixLOobnj6lxfT2nk8m6OsdGHKDi2hGb8vrt6wrDBXMqbDCWqzpqKNVZejZXxZiSTclQCFrUExZYrKuLo4vCUSpGeU633PwBPLRsThUhwjNmlPjdpE9cKlxYZtrkmaTzo0E=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by DBBPR04MB7979.eurprd04.prod.outlook.com (2603:10a6:10:1ec::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6086.17; Thu, 9 Feb
 2023 06:37:20 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::e203:47be:36e4:c0c3]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::e203:47be:36e4:c0c3%9]) with mapi id 15.20.6043.025; Thu, 9 Feb 2023
 06:37:20 +0000
From:   "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
To:     andersson@kernel.org, mathieu.poirier@linaro.org,
        shawnguo@kernel.org, s.hauer@pengutronix.de,
        arnaud.pouliquen@foss.st.com, daniel.baluta@nxp.com,
        iuliana.prodan@nxp.com
Cc:     kernel@pengutronix.de, festevam@gmail.com, linux-imx@nxp.com,
        linux-remoteproc@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Peng Fan <peng.fan@nxp.com>
Subject: [PATCH V3 4/6] remoteproc: imx_rproc: force pointer type
Date:   Thu,  9 Feb 2023 14:38:14 +0800
Message-Id: <20230209063816.2782206-5-peng.fan@oss.nxp.com>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20230209063816.2782206-1-peng.fan@oss.nxp.com>
References: <20230209063816.2782206-1-peng.fan@oss.nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR01CA0197.apcprd01.prod.exchangelabs.com
 (2603:1096:4:189::8) To DU0PR04MB9417.eurprd04.prod.outlook.com
 (2603:10a6:10:358::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU0PR04MB9417:EE_|DBBPR04MB7979:EE_
X-MS-Office365-Filtering-Correlation-Id: 17f127d6-ba41-4b39-1f9f-08db0a6817fc
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: zbqkmLwBnDZu4tR7sE1sgW4chqq+B1+3j3gcgPM2x8ebIbFYlnrWgV7jT9hpP6DlR7PfvdqXGJhlisn8RUhXqqv0gqN3n8dAo8m7y7ifTdqP6dmITIZFtoW3iH2wN6To2CEx3hzpy6YPygresLBCBP9zsdrI4aHmQhS4d+ewjhajJh0OwZeuhmmCygS9iV9A++pBBHILGCeiggdx/D8jNziolCIj5JIwYKGsJm7Srvs3N6tCEaUZEllaQgZI/g8dlN0I2Rf2HtqcHxT/P+V4E0+FwUE8vLmrjWTJXkfGLoxDM8PcUw12AFKOCQ2dkWR2rZTRO1P7gAq2jlxTPElYSHVu4jtHTvRDLZVOvj4vB9glW8glrTgpvXpKhBJyhaQzmOXy8r/ST6hdALbSCmoQl0ajryP9tUEKZfqMUhKzX+SaPUzdd5dYEcbg2P578cq8WALur/M5u+GgMfVnA7oXOnZjAkwctyM+Qca1hK31ThOxTWh13qVDS/3jRcQVAkWLUdC7se1Z6bwCzkgiHvmr/vplNACFXIDwDZ/YBiS7jK7kbVrkejqCTxsyaYJPxozlSRb/bk7ODQqbAjlOtZHSaCPG/dU1q9n6/3eQgtTWt+jSdjnjfwXQH8jFGDmK8jOUKDmBVQ3E9qpOTUOF6oWNsUmhNuJiLzIdDVg0upuctyZdwljcVJWD5yhCWDkiROhC4cSFAshlO1Nt6I2HZJAFaA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(346002)(366004)(396003)(136003)(39860400002)(376002)(451199018)(4326008)(8676002)(66946007)(66556008)(66476007)(41300700001)(38100700002)(38350700002)(2616005)(316002)(186003)(26005)(2906002)(8936002)(6506007)(6512007)(6666004)(1076003)(86362001)(478600001)(6486002)(5660300002)(52116002)(83380400001)(7416002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?+KYhBLHR8Sn+fg6Ub0FsuNtO6ahbon3cmJ0I3+vc9kOoIU0sFjw+5R5HgLSp?=
 =?us-ascii?Q?JN7gV9nxEw0N6DNhrDujoAmV8D3B2k0MEO69c6lz75MZswywscME98LIrER/?=
 =?us-ascii?Q?A393Y/LUsqbY93ltf/bGuvaWiPi9ce47klMrPNT2jHeKYcpa4tMtqys3OQNw?=
 =?us-ascii?Q?XDuGGaHly3fOz0/boBDiHcNoJL43jTmS3Pyhz1aXnW47SSgZzLAlBM6poFDy?=
 =?us-ascii?Q?y2yBpYo8mI8Id+uNluo00BJFkFzLG0PAjvEcRVpQNCV6Cpo+HXd2JTYRIL/K?=
 =?us-ascii?Q?rl95X22JoVuh25lBZwYMG5TdCtFDcCGHHO1Wopl5mRZsQHg1HHZek3jTGCmu?=
 =?us-ascii?Q?cJ7E6+/Wqc53ZzTZwtb/H+nJk/tsevYsWo9mMmpqPLkRxwCuvGGJQekQnoQ3?=
 =?us-ascii?Q?hnXxz4p/muBFZ3Oh9irJ1c4pdSP4QWU0HtSzhu3INRKJ9DFPiqjSZ9J5RKF/?=
 =?us-ascii?Q?vTRbwGdFPfi/atRkWc+qqFdVt+SFoVGyCzjs9feyQIqP/2sDR3hSI2bftafA?=
 =?us-ascii?Q?zpg5dxEbV718fbetl39HCSSox5iLaj5zUm/pOrHugKpRSHZ634CGRUtW9kdf?=
 =?us-ascii?Q?FmYtm5AB5kchPots0QOMYVn1S+swQLK7Wf5mpQ3pVrLdAOrA2EpLLdsii1oL?=
 =?us-ascii?Q?b18//skKeuHF9JaCkVX2C39tscF+ahQ3DpA2hyazd1gJTZM5TQ2zkT2UXlZt?=
 =?us-ascii?Q?wWQr4rzOWxqyxlRqtXfEahLdplcERY7tzbkBwqq+rzMx+jMjkL3R7ERQCi5P?=
 =?us-ascii?Q?HoaSf+yTLSWDQ4PXnp0uAHTVNG41LijgRc6+5N4CVBUYnZhNP5MljrjyeY4f?=
 =?us-ascii?Q?okVrZc64lShw1fbrctP6jSKU7zw8VN1D6Sh6HeClJWlZZpKrtoMcgOvtgTCK?=
 =?us-ascii?Q?CGwXb9TmrXoVQWwvQbOUWrWht/EXACf/SVtVVFSYxcc8ECqZS/48vj6LQYaw?=
 =?us-ascii?Q?+vO+ZbStqhIReKdGd9Ifm0o194G4vUpzSGtH8yV4mfQQHzp+OIUsqqBVQB+P?=
 =?us-ascii?Q?FYRoeViYXFdCldilkZ0zjQCxAhaBKMcLhi4u4C+3/2EU4RoGGSt4kKov9Ooi?=
 =?us-ascii?Q?C6OQGOjb4feJmrU4uwaAgWKVZrLX7OcfgD8+zpWnKJ56rQReDDoScUNLqmhq?=
 =?us-ascii?Q?M2QW73JHS6F1pZTQjQkXDK+BMRnU2r+JDUVxQvwVYa2Vd1vFOYdPSoe/bLfe?=
 =?us-ascii?Q?G7XM8pA9I33O7M0S/XY62+0KANXGZsMSwrWio6kYdOJg3BWu2fmU8j/zdwni?=
 =?us-ascii?Q?/STBWjupddmELwwT/bdueFTVu76T8pF8kHzBcmAsSlFC+aaqLCLcOxOYDHqz?=
 =?us-ascii?Q?EDYBnafFMVY4GFI+Z5yzFx/pSD+ss9UcM1eybwusZ+3xNN5taQcXrvRi12jP?=
 =?us-ascii?Q?NEjOz44ilXWJcK0Xn6Juo/adNS/ITMMVbyXmsSq4Iu+vU+zRgLdID4NT19zj?=
 =?us-ascii?Q?XB0u9ZIxwriHdvmq3lgaxgwVS/3YcQ817+vrNaRkV9KTiQzb5it4RIRk990E?=
 =?us-ascii?Q?rKXbDns+I6UG1UF855sV7/kXYRTejDmlPZKXPLy/ybg0LSJgz3OrzIXegeLY?=
 =?us-ascii?Q?OSKfbnohN67j8JtepDPZo0A84UH5m+WJLh1BWnR1?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 17f127d6-ba41-4b39-1f9f-08db0a6817fc
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Feb 2023 06:37:20.1301
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: J6BkVhA2Ir7D4uPYRSJfQBIlTRB/ISEHXHRtewBHSAqQDAElt7ckhfGOwqD+Kktd0Coh49tTxpj68LDsA80RbQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBBPR04MB7979
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Peng Fan <peng.fan@nxp.com>

Address below sparse check warning:
imx_rproc.c:498:12: sparse: warning: incorrect type in assignment (different address spaces)
imx_rproc.c:498:12: sparse:    expected void *va
imx_rproc.c:498:12: sparse:    got void [noderef] __iomem *
imx_rproc.c:515:20: sparse: warning: incorrect type in argument 1 (different address spaces)
imx_rproc.c:515:20: sparse:    expected void volatile [noderef] __iomem *io_addr
imx_rproc.c:515:20: sparse:    got void *va
imx_rproc.c:631:17: sparse: warning: cast removes address space '__iomem' of expression

Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 drivers/remoteproc/imx_rproc.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/remoteproc/imx_rproc.c b/drivers/remoteproc/imx_rproc.c
index 13199e593b47..295e0e0e869a 100644
--- a/drivers/remoteproc/imx_rproc.c
+++ b/drivers/remoteproc/imx_rproc.c
@@ -498,7 +498,7 @@ static int imx_rproc_mem_alloc(struct rproc *rproc,
 	void *va;
 
 	dev_dbg(dev, "map memory: %p+%zx\n", &mem->dma, mem->len);
-	va = ioremap_wc(mem->dma, mem->len);
+	va = (void __force *)ioremap_wc(mem->dma, mem->len);
 	if (IS_ERR_OR_NULL(va)) {
 		dev_err(dev, "Unable to map memory region: %p+%zx\n",
 			&mem->dma, mem->len);
@@ -515,7 +515,7 @@ static int imx_rproc_mem_release(struct rproc *rproc,
 				 struct rproc_mem_entry *mem)
 {
 	dev_dbg(rproc->dev.parent, "unmap memory: %pa\n", &mem->dma);
-	iounmap(mem->va);
+	iounmap((void __iomem *)mem->va);
 
 	return 0;
 }
@@ -631,7 +631,7 @@ static struct resource_table *imx_rproc_get_loaded_rsc_table(struct rproc *rproc
 		return NULL;
 
 	*table_sz = SZ_1K;
-	return (struct resource_table *)priv->rsc_table;
+	return (struct resource_table __force *)priv->rsc_table;
 }
 
 static const struct rproc_ops imx_rproc_ops = {
-- 
2.37.1

