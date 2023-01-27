Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F142E67DFF5
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Jan 2023 10:22:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232937AbjA0JWN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Jan 2023 04:22:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36380 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231551AbjA0JWL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Jan 2023 04:22:11 -0500
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2043.outbound.protection.outlook.com [40.107.21.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F84379630;
        Fri, 27 Jan 2023 01:21:50 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DqcV8dRGexji/nliGXlvqTOBCUL0WNHHFHtPJbx2+0mCJlljDUo09GX5RjLdpLHjcvsqB5k79zEqjqMOZGLYhFYwAxwnXrp0P+KRHxu6CwbMGxlovVJzfemy/JY13UgpPzVZvrZzb8Eoqy5GJvTgaXtH3N/1gx8poYzpbjxUqKi1s7FXG/CD+FU6uUIz83OlN6BlvAAFTwWMK5oUkyRUTqAZt04UxCkqkHYBGgYdHTmHlUMA7oJo3D9otvrZlyTFi650Gf7dZ+EmqmiSsv9SgSuo68yY9u796S56QoaacpmSBddltFLjRhqajz+WQJJqoPSiwoTLp4aHLv/0l2dcUg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UHjHnylbi4Bm/ezwRvCS3z8MRLYZ+drBLaIaTBOTV2Y=;
 b=QuYiENaUEjsk8LAqWRWJR8G0DkT4om5+5jXpU8EqjKQqpHE1JFMZiUVNLJzmO98tY3yVLhHQ8LrrhE8/MLpasbqdZsp7wqOD8GWdLAygAEBOfX1RiOjiYvvEGU7oY9i77GlJ09YHp45UPpu8D/Fk7vZit6AHyD784YxSNRfkbmn+FBXaA/xN7A7V4tWML+GdLeSzEufjJvlM4gk1BSfQwi1r0EbQLT1NMps+gvq602aHpOiLD9i9u37XaCvoLfurC+2r+9XL1eeAEHRrGfqLdJNylNZYzNDIulEXdapEB5TQckpMU97fi5HW2CHj2S7XsOLFWDgOa0l6pRZZT1grRw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UHjHnylbi4Bm/ezwRvCS3z8MRLYZ+drBLaIaTBOTV2Y=;
 b=MC0swOAYXscpDMwcZVzIoQ8IreZy08JtN0miSINHeoQhRPlSHBJNGMTihrRSHbNVHBivmfdxR52gjUFcRAm7xDPzeJ4SxJSxJAbUXaWwq7nm7pv1CTTw27SmYZTLChyd3+sMncTbvZqzMDiR1ArxaFyvFmdLOngc55LgpaSx9Ys=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by DBBPR04MB7530.eurprd04.prod.outlook.com (2603:10a6:10:1f5::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6043.22; Fri, 27 Jan
 2023 09:21:45 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::e203:47be:36e4:c0c3]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::e203:47be:36e4:c0c3%9]) with mapi id 15.20.6002.033; Fri, 27 Jan 2023
 09:21:45 +0000
From:   "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
To:     andersson@kernel.org, mathieu.poirier@linaro.org,
        shawnguo@kernel.org, s.hauer@pengutronix.de,
        arnaud.pouliquen@foss.st.com
Cc:     kernel@pengutronix.de, festevam@gmail.com, linux-imx@nxp.com,
        linux-remoteproc@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Peng Fan <peng.fan@nxp.com>
Subject: [PATCH V2 4/6] remoteproc: imx_rproc: force pointer type
Date:   Fri, 27 Jan 2023 17:22:44 +0800
Message-Id: <20230127092246.1470865-5-peng.fan@oss.nxp.com>
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
X-MS-Office365-Filtering-Correlation-Id: 24d1fcdc-85e8-4e6a-73c7-08db0047e901
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: gN55yGiD6p8CcxpvV/6NKv76gGn/u5k3lRz1zct+ztZPDG1ZTzGQ6vHkWqvBwSxdAJPr1e9RukwHKoOH8Hks4TN8PKnk4uNE2n9D4vySTG3pi3s4cu3ILWTnBTUZkRWrh9JENbxtoF4ahZ1RtFPGoW/CJupigvW+RAHPWF7Cu+36Nz43zUHsZY1w/EyZVp7lvUN420ibvFTlkgpdpTVWDUch0kj5Ij85qqDxeXu+h/4KRAj+xgf89IbSY9Blom3w5PS1lZDA6bmF8bvXuv3WnaqFDDMsqo7HqR6m3Xjqng/Vjkn7RpLHwsGEjD1t1ImOFMDkJYD/JdNPHbpTiNEPVu5yuzMfEsJJEXR7b5wnHPcudS0tMEWFkwzCPUC42xTzNcT44R8lzpnHbbMijiPBOY+ICSy1sxIVvKTRljH4ozFiOiJ2S/AH0xryJ5jgeecffuNyiYhQKwRy/oNGBeO4YQXj2q2iV3sjkep0QQgMdQ7rcr+Sp9/G+rEpmWB54ZZn0vXRdszrIejkXCGBubjA6W6R3sagO6ITmRF7LC7TVktiFOKep7+vlcyFXMhimQ62icSA2evthX8vbITj72q/pVjWDPP2blB6JHK1VPtCEooxgLFwX8hHb1yx+shYpQtPIkyjyke3Mo9o/xWNu3VBR3w6GqFXzPGmoS2Tflj+MzKy0hhMeJ4GSB7Z9Yt2iGB+hQkVP1lbRCfOmBbrBi6AVw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(376002)(136003)(396003)(39860400002)(366004)(346002)(451199018)(38100700002)(1076003)(2616005)(8936002)(38350700002)(2906002)(316002)(52116002)(41300700001)(6486002)(478600001)(86362001)(83380400001)(6512007)(186003)(26005)(6506007)(7416002)(8676002)(66946007)(5660300002)(66476007)(4326008)(66556008);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?TzYVpiFVMIHWT2QLTI+MIMejGlLmYZYCdIdvLBGKuTJl138h6hnc4Nz74faL?=
 =?us-ascii?Q?j2HoD7XqMg0v8YwYQEZQozXCBxmiSVJGeROn91iPlYh3uLYbnCgLQ7Hjho8t?=
 =?us-ascii?Q?a86wczKnMLhcBUpYtffJUi3QXCRtD/QmEOfW6D416q8yuRjx4LBgXxLDYVH2?=
 =?us-ascii?Q?B7cZoVEzaJ0nnrKMfMkp9OQeMwqAEfTusj4AmsFG25Q17b+lJpjrBjeDo9s0?=
 =?us-ascii?Q?X4bnHMkjwUOj/aeCfLgl3Bo8cqwcXUPNl/z4EDF+AQ3P7a2r2aBHmZxAe0dZ?=
 =?us-ascii?Q?FQQKgn9qdRxrGIiCjySWUzUdWQ7ZW38Y9AUol6HWgUTtFClrNoGeg6iQr/GE?=
 =?us-ascii?Q?Eh0ykGN/IVcCiYHfhQm1NMTyrL0us0ALqdoaDEaDwSPsi7CeoiSEbpyuYzlO?=
 =?us-ascii?Q?w8yG5Ux4KrUk4s8qVsWa2LVmP/USpQVuSvbgvB8Mkl2i5ArtqLYAsLx/PWPV?=
 =?us-ascii?Q?uK2WATGqVnlBoVm9fPDDW9gDie+VU4/keliamwqz9ZPfjqFXcF43BPgGhrHE?=
 =?us-ascii?Q?R82ehQWRrD0kfKtjjL4Jq/On2RjHJ+hIVSjFZS4O3ot4LZwDznZg/jbf2XHv?=
 =?us-ascii?Q?8M/UX80+m1AuV6IgXZ6loLBn32L39cTQyDUk8mVm1jhtSg4UDq3OcegvSm+E?=
 =?us-ascii?Q?f2pFwrp/VIZ+O5l7uXc05+E7D0Vg5K6rtbWaDoz8c3sFrK377DwDeRFuw5NL?=
 =?us-ascii?Q?rqKSftLEKNOgYScjbCu+PW/bwp9sQ1+efS6e8e9aXUpJLKa5NTc7yIxCKapl?=
 =?us-ascii?Q?3xiDV7lN3FCT/3/r4cU0FUHqZqZbqmeSYYX1r4h+pPra3f8Mfr8m/mA1NLRG?=
 =?us-ascii?Q?Qd/avOpgPOIm98dtswSxh1vDhVuOFMNofX4w0Pw4x9ImEqmoL9P9bydsOmul?=
 =?us-ascii?Q?6uOh8MAopaMU6AWqa4URW+TWp7TA+UUFm6KbgyWRUGhpa80yzd2tCvW4v5gU?=
 =?us-ascii?Q?biYvS/ypmrE7k5frYj8S6gQ6IhNqrEu9rO+qXrmlx+wXIvA8FgVsPtB/Ynmp?=
 =?us-ascii?Q?ygn4HzGklCLkHfBWkF9fjYnun11S9y4wpCsC0bsd97J7ml/FmWSKzU8y8kbU?=
 =?us-ascii?Q?JVi3KzP6X5FhCZi/vQyOs0aDKghQMs5dg/zbL8xbD6MA4I5AipYEl1gTuRk0?=
 =?us-ascii?Q?mSBDHApnLNAQq8BfrzpxRhuwHjmV0lkLt3yqzTHVxwYEWTKYFq6iv5YOJ1/U?=
 =?us-ascii?Q?xhvNeinBoB/TT811D9biax/j34gcz0Po5x827fBzd67Tf+pDDMZatZKFfz40?=
 =?us-ascii?Q?bdoxrgvAl+8rRxiZSZWOI5L9qD28Ug7h/S2Qyf37f2EQuqlGBAvZvymSNmEa?=
 =?us-ascii?Q?djOyX2m1O8l3G/bxF1c4jwTv9EN0XDJAiHCVN35QjNwIryeR+TXkAMLkaxwX?=
 =?us-ascii?Q?Qukc1Pa3ed/TW6vxxJLjU0uIYQDnbtQeKKI9EIzj1jklr4/gBI5N/hWYHu/N?=
 =?us-ascii?Q?UjVYgoycHshCw830AQwiPCljpitf1iW5RoGOFOniUwTCcjcgfqaRoG6UFJiX?=
 =?us-ascii?Q?irMSAktjmwgcb9g3Q9jNZEHD8oYg5qQ3sjpS/1XWklZB+CfUfD3n3hHwf305?=
 =?us-ascii?Q?ZFdKnHXIn5w1IhcTAOVXNPUMcbn3zfQsPR5I06bM?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 24d1fcdc-85e8-4e6a-73c7-08db0047e901
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jan 2023 09:21:45.7264
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hcXlyAHnb6QLPcyjgpXorZBIKOt5n0ZqTnXAysCBJijChgTMr647ztvWzUH/LfTQ+eVdLHT9a8mQ2/INge+e3g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBBPR04MB7530
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

