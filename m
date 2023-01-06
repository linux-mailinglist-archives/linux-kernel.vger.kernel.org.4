Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2967C65FA6B
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Jan 2023 04:42:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231875AbjAFDmb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Jan 2023 22:42:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44276 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231923AbjAFDmL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Jan 2023 22:42:11 -0500
Received: from EUR02-AM0-obe.outbound.protection.outlook.com (mail-am0eur02on2057.outbound.protection.outlook.com [40.107.247.57])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A95946A0FC;
        Thu,  5 Jan 2023 19:42:02 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Enxzq+IxHpTyAGM9cS3xviSCBBjP2+JRw3jb8g9Q0oT9Myu7EprZMHTbrkO+69hvkruwOJE4AHdcBZvO6zcVLCsOjDssPKZq3dxfET9T9AEtmOJBL3Huq8ONh9DKUmY7bPIvLQvM8Qh3TL7oSK7aQgzUMQxRIZbpBqMVcbz+Pk/FUzMFjSqfnFUCdbhVTX7Sdr14blbYffJyORCMhZVOpl9/2CKNviEvtrTkKzAGFj9u8ElJeVHUjTxEwplkcdx7/58rCk3GCu8ggIjCycDUCozv7NHV7rtSQV4Wof4mv27/XUNQEiYn2L7j9WsmzSPK9vVwwUOsmzv9THaSRTA54A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xYjpcui40d53tWYIiBAMBJIEqPJx9z+VymgxfqhVTZ8=;
 b=dzYEOSkYTwbBLhoYM1oFY4xa1k5QHgyi2OXf8iewBl9i+5VloRGI3tMhBDSMwa96KZycxxe+hWtW3k/wh/DLUh2tmaIAy+MxDqFBaOfrkfCWo8ylOBCtpikQVqcdvxNx/909hnuqwRhzIum9sNNJi64jjz9I1mRi9G8vz1UhNAn7XyGZ1fXQhznjpmpkCGGZPExh+rckcud3kyvPDPP//09nKAtoCeEunUx7RRLEeAUvkjtQkur3ZPqHXdZet/dmLEvCSpJmX7d8vch0XHD9ktBGUsgpJVYTPib+9A573dEGBzh23kEYwRPeNFpPf/MnYxZHJyPuwCF3AKNB9U+TMA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xYjpcui40d53tWYIiBAMBJIEqPJx9z+VymgxfqhVTZ8=;
 b=B12EREubryABvAAgQa9lxXk8BbJtIAVDoSjSfSTU6RSIpTTdiF7Er7JHSyVl7gBpTjztnX0X84Zz7R2UrBEvz0tM/mIGsh4DsLeFpe2W/uymWmJnHbDIVvQeJkraAAN6E2R5W1mkwFdM+hpxju8QGr7ctlCgXYvL9x+hoj0HyzA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by DB9PR04MB8480.eurprd04.prod.outlook.com (2603:10a6:10:2c6::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5944.19; Fri, 6 Jan
 2023 03:42:00 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::29b9:5061:2054:174b]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::29b9:5061:2054:174b%7]) with mapi id 15.20.5944.019; Fri, 6 Jan 2023
 03:42:00 +0000
From:   "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
To:     andersson@kernel.org, mathieu.poirier@linaro.org,
        shawnguo@kernel.org, s.hauer@pengutronix.de,
        arnaud.pouliquen@foss.st.com
Cc:     kernel@pengutronix.de, festevam@gmail.com, linux-imx@nxp.com,
        linux-remoteproc@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Peng Fan <peng.fan@nxp.com>
Subject: [PATCH 4/5] remoteproc: imx_rproc: set Cortex-M stack/pc to TCML
Date:   Fri,  6 Jan 2023 11:43:04 +0800
Message-Id: <20230106034305.2868740-5-peng.fan@oss.nxp.com>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20230106034305.2868740-1-peng.fan@oss.nxp.com>
References: <20230106034305.2868740-1-peng.fan@oss.nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2P153CA0017.APCP153.PROD.OUTLOOK.COM
 (2603:1096:4:140::10) To DU0PR04MB9417.eurprd04.prod.outlook.com
 (2603:10a6:10:358::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU0PR04MB9417:EE_|DB9PR04MB8480:EE_
X-MS-Office365-Filtering-Correlation-Id: a8fb7b01-4c6e-4418-0ed9-08daef97f79e
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 4Jx4C45/GhhUVIdWcy3Ga5xLWKr1LuXmvoCtxaEuLyE66rx/Huo2k+pgnFA4DSJmkksXgMSDVFt9wFP5uGrSeaVMuVdSS5/G5k6DnukPbPEYhedTamtKEclUuIRMb4QLZ7vbUIfxnRAZV5HPL96rHqReTg6NXRxvIoMT4NBfoKTvMNz94z7bx0CeVo2RpvljQjjo2ISQltDvC0d7PkalFe1Zy3dmDbE7a9YSaPfkdNLK+XwT0OoJh3qbDofKk/975CcynAhcTTOaY+SgqYwDewpSicgR0FxkP389/HF85JuAWpKix8q4RkRAY1uZA9cmgUhZtkFdOsll0Akg7PhxAR1oHLfSl2WAVMf4N64cdD+UIrWVaYYYBO2c91Jn7RgVulkd4B15tW31q8xL8LxQ/P4GxfFqNbksGAk6VuH4GobvdHm26bgva1ecOhEJmvkDf84gp2wO8nBSG3azUKOPGtEY2zK42VF9I0mw72QH6Wd9LmoSidtdxOijbVkhGngCFYgfV+mbsQjl2owPGXPrDxmbdi/ZgxcwfeVv7Yb4EtGv7t7OKPHuTKIzmhUcNq6Fqq8tfJzu7nLgcNkihkT2isH475AUs3o0f/9N1wIJePMQAQTt6YmNWr9m/9iHt8Opw8QGmYRezld0gU/bzEI1cwth+GJvmyKa9HaFSw91kePl1hDt6zW1fcQDlM8dJYLGWg6CzTQoOXFbFNZcURsgWg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(366004)(39860400002)(346002)(376002)(136003)(396003)(451199015)(38350700002)(38100700002)(6512007)(86362001)(186003)(6486002)(316002)(26005)(4326008)(8676002)(66946007)(66556008)(478600001)(2616005)(1076003)(66476007)(52116002)(2906002)(6506007)(41300700001)(7416002)(83380400001)(5660300002)(8936002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?lEAFr+rCpHYT0TrJmffcCAuHlwz281ipEOdhWVGtfnL0orM1FP4L6PZe2NPW?=
 =?us-ascii?Q?Tn56WcRewkH4R7F8nnvkfpJMA4eAxuReeQtrOsN5A9d9pio3x5Ax/cDPIfXu?=
 =?us-ascii?Q?O/wF2AtC+71F9YGU3EIfh8qgZ2mCthFwlfaBSZCYFpPbQ5Xz2u8hFD/HsOqI?=
 =?us-ascii?Q?zq3xU8cCVSB9we21vqLvM7txYTn1EW2EreTgtw9EplO8nNjcL8Voiijy5cyq?=
 =?us-ascii?Q?nJ7APJ3oOA3ICmPSCL1B6FA9Z3tDYm+vaZ3LVLzZEE9zvpr/8uoETYmVYDen?=
 =?us-ascii?Q?7MgDiHRePs05QT1fX4V6ILnR0TI9LSQVCRZM735sMGSwCtDjUq9goBhR+p+E?=
 =?us-ascii?Q?4vTtlANmx1wyICxw7UEWc5oZqzkvX3rNGsotUzN+sr9uLirWj3ZJLjDBirBp?=
 =?us-ascii?Q?AnMfPJJtyDWhh7dijvAenwjKoa8MFRfmoe8hNtNymtBds1Yn0zJk5iEA4A76?=
 =?us-ascii?Q?nyXB6JfPNchJsK8+p9WN2P/+0Fv++0K6mqnbcqBvyeRaSFwYdsyeMOEqAw0O?=
 =?us-ascii?Q?TnOWLYmikyF64jc8B+Dxpm40Nqy/VQ/hHHpY1/QrQZaXGZDWNfjoprjOzyU7?=
 =?us-ascii?Q?OT8rbAVFbbuZ4fzzH/Luiv5HZD5GAzqZnEOP6S3pBwbhfWYsbk3DHilswM9/?=
 =?us-ascii?Q?quvTScGOFC+eY3GFgx+cerxliXwIH5RU5nN8Ted01IsxQe3lK0nHbx6FAozw?=
 =?us-ascii?Q?23meF9RkKMU8DP5qvbLIdU8raeQa+cELzTdrZONvuVB2IB1TI3fWuxvyPjg9?=
 =?us-ascii?Q?OcdXBhBPX9PhIfV8vDYm5hwsa8srlM/qh4qet5BaIS85dxvdDmOfTkgkCyT5?=
 =?us-ascii?Q?lia/5WPePuTQWeqFOXbV7Wy3fgMb04wxhN6MSCv7YX9dzHDczbVE158NE490?=
 =?us-ascii?Q?yYyS428horOCZZOuYP0mDLIJndtyR4jwzp7jVXSQnXCy81ESyVCofpQZXCQO?=
 =?us-ascii?Q?iXNAU+6hFmv2aBLYyXSbcdFnoslnuKnynp1dY8hQQ/8YX5CZbJMyxVwLR29i?=
 =?us-ascii?Q?9xH5YH4ADRZQ1xWg0IOPtrg81VXcGw+CzIjh+hVSntsNCnYmG7DCx5X3GExQ?=
 =?us-ascii?Q?20LiEBJCwdokEIwSQL/sKQnfcCRgwMJAYW4w+9kzpc+WJSf8BuuFkf6hmJmC?=
 =?us-ascii?Q?pwvwYLWdH7qg9EZIlwsTukjglIKC5g79AeeT8aHTVpSE18Ydt6TTquN6UrDj?=
 =?us-ascii?Q?45780FXtr8HtYrc4KXt/qyIzNkFJPyiXMxC2ugKxXDU9KKuRb+1OKIyT9MTJ?=
 =?us-ascii?Q?GzIrVKJK9WmgswicQv1zd/z1jvAUNwxMdYZPd5q6EfyaoALiLBL9vY1LJKlk?=
 =?us-ascii?Q?FI16QSKbl9N5cPUxcdzyTQ1EzbQr5b57zB8Y25pnuxnllHvxJZZY9q+MCnYP?=
 =?us-ascii?Q?/dhbrSN9W4AfJFnjEQsXpAfhzGwio7LWdAtbIs5KZsPSqpaskpeNcJM9XUyS?=
 =?us-ascii?Q?5wPUxH38SG3KH9L6yHZ5YrgDB1yjm03K+FH96XtSR4+Ic7gliq3/9lSEwr5Z?=
 =?us-ascii?Q?G7nYXBzSK2eVknZmYCfMnXpkza2R6a0e1BsMlS9pp5YG3uwokQ7F4caYj4h6?=
 =?us-ascii?Q?qsmoT7JPZ6kZC9c8zpLGkwpTaZsVkU7HSAI7ANzR?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a8fb7b01-4c6e-4418-0ed9-08daef97f79e
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jan 2023 03:42:00.1339
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: gp0S0rpwl5l5yF4Un+8TS1IaYr8JdchuqXGgqL/Dr5dlSM01CY22l2unDMOYPkHgWmYwFdQngsFjYwUP2bFeIA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR04MB8480
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Peng Fan <peng.fan@nxp.com>

The i.MX8M Cortex-M core not has ROM. It has a requirement is
the stack, pc value should be set in address 0 and 4 from the view of
itself. From Cortex-A core view, the region is at TCML start address.

The stack and pc value are the first two words stored in section
".interrupts" of the firmware, and the section is the first section in
the firmware.

When the firmware is built to run in TCML, there is no issue, because
when copying elf segments, the first two words are copied to TCML also.

However when the firmware is built ro run in DDR, the first two words
are not copied to TCML start address.

This patch is to find the ".interrupts" section, read out the first
two words and write to TCML start address at offset 0 and 4.

Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 drivers/remoteproc/imx_rproc.c | 37 +++++++++++++++++++++++++++++++++-
 1 file changed, 36 insertions(+), 1 deletion(-)

diff --git a/drivers/remoteproc/imx_rproc.c b/drivers/remoteproc/imx_rproc.c
index 13199e593b47..2ddf89e15dc6 100644
--- a/drivers/remoteproc/imx_rproc.c
+++ b/drivers/remoteproc/imx_rproc.c
@@ -7,6 +7,7 @@
 #include <linux/arm-smccc.h>
 #include <linux/clk.h>
 #include <linux/err.h>
+#include <linux/firmware.h>
 #include <linux/firmware/imx/sci.h>
 #include <linux/interrupt.h>
 #include <linux/kernel.h>
@@ -23,6 +24,7 @@
 #include <linux/workqueue.h>
 
 #include "imx_rproc.h"
+#include "remoteproc_elf_helpers.h"
 #include "remoteproc_internal.h"
 
 #define IMX7D_SRC_SCR			0x0C
@@ -634,6 +636,39 @@ static struct resource_table *imx_rproc_get_loaded_rsc_table(struct rproc *rproc
 	return (struct resource_table *)priv->rsc_table;
 }
 
+static u64 imx_rproc_get_boot_addr(struct rproc *rproc, const struct firmware *fw)
+{
+	struct imx_rproc *priv = rproc->priv;
+	const u8 *elf_data = (void *)fw->data;
+	u8 class = fw_elf_get_class(fw);
+	u64 bootaddr = rproc_elf_get_boot_addr(rproc, fw);
+	const void *shdr;
+	void *va;
+	u64 sh_addr, offset;
+
+	if (priv->dcfg->devtype == IMX_RPROC_IMX8M) {
+		/*
+		 * i.MX8M Cortex-M requires [stack, pc] be put in address
+		 * [0, 4], so the da address is 0, size is 8 words.
+		 */
+		va = rproc_da_to_va(rproc, 0, 8, NULL);
+		shdr = rproc_elf_find_shdr(rproc, fw, ".interrupts");
+		if (!shdr || !va)
+			return bootaddr;
+		sh_addr = elf_shdr_get_sh_addr(class, shdr);
+		offset = elf_shdr_get_sh_offset(class, shdr);
+
+		/*
+		 * Write stack, pc to TCML start address. The TCML region
+		 * is marked with ATT_IOMEM, so use writel.
+		 */
+		writel(*(u32 *)(elf_data + offset), va);
+		writel(*(u32 *)(elf_data + offset + 4), va + 4);
+	}
+
+	return bootaddr;
+}
+
 static const struct rproc_ops imx_rproc_ops = {
 	.prepare	= imx_rproc_prepare,
 	.attach		= imx_rproc_attach,
@@ -647,7 +682,7 @@ static const struct rproc_ops imx_rproc_ops = {
 	.find_loaded_rsc_table = rproc_elf_find_loaded_rsc_table,
 	.get_loaded_rsc_table = imx_rproc_get_loaded_rsc_table,
 	.sanity_check	= rproc_elf_sanity_check,
-	.get_boot_addr	= rproc_elf_get_boot_addr,
+	.get_boot_addr	= imx_rproc_get_boot_addr,
 };
 
 static int imx_rproc_addr_init(struct imx_rproc *priv,
-- 
2.37.1

