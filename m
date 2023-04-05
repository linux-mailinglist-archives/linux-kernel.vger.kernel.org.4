Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D82036D77C7
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Apr 2023 11:08:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237665AbjDEJIo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Apr 2023 05:08:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39878 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237394AbjDEJIa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Apr 2023 05:08:30 -0400
Received: from EUR04-DB3-obe.outbound.protection.outlook.com (mail-db3eur04on2075.outbound.protection.outlook.com [40.107.6.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D428010F9;
        Wed,  5 Apr 2023 02:08:28 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ai5jWHJb69H67MSX6NNEaeVjyCj9vGfOTW5yt5FIqlSQFamQpn55vlNLfvpwX3sNyhy3GncmLMmMRLJiKM05cRs3UsaOFRqnlDb7sUmws2RSONOTckgG4QBMBczoRty/588SbUGBLUyZC4rxX4FcbktP81Do0ytS93T3edcAFQcMMDMvxG8fdoHnSbk9h/pqHYmApSRgZDsvMEb+z1PeSYXq6ydfzSHlgE309n3D9nPCzW029lMvvd8yLVv8JU6ys/XAaM2T537gEJeFlFjF1xpTRHfI3hiV35gPe7FnOHq9hoQ/QhfJrz8Ru0KPlflUViLsFAEu63S2bUrqXjZv3g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ei7J33+PihTCCgUfyvNxA1s2Hz/Q3GjwGH9WjKWHp3c=;
 b=mv50FRPEpjA8mOb8ibyND82mEFqy6ueKEShVOJka9puu6K/PWNZb+EiE3cT10eaa0qbUk+ttG12rcjTKNf02IgdMWP2rxGKxnkrzVVBTCtoQhy6RAo5tarpMtry4agQ5ZGzGKYt1Yk5yvKiexFg6kopMCPUCrUbsLEdyuw96dq13vq3EfQZTr1Z6hY7BSGzsoqt95lC4Zw8MjtZuXGfK/KPdKfkTcTM68OZyCglw5YEKb0Jdu0TT6fz8esLB+NDAUNXJT8lAx8shJaPMQSux9VwVtUIY0OwWYxrbHujGMX/uBufGkjLIx/V/SDkezcy3boY/z64eUFoeh3exI2EA4Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ei7J33+PihTCCgUfyvNxA1s2Hz/Q3GjwGH9WjKWHp3c=;
 b=Cmc4x/uJ+r2kwEPBOMs6zfP4UDPt/cwd7SzNuya1bkAOdHDsaJZCH5TP1dE1LS11cw+tZjheL482GV+L5a6/MuhcNWA7x7nrX9wp88ZspHZVyIjPKumNr14LvKAEYjjnd5oKUcoZeBKS6GKWQMvSPM1Bonqa9gsOk2LfkWtWzvM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from DU0PR04MB9563.eurprd04.prod.outlook.com (2603:10a6:10:314::7)
 by AM8PR04MB7473.eurprd04.prod.outlook.com (2603:10a6:20b:1d0::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6277.29; Wed, 5 Apr
 2023 09:08:21 +0000
Received: from DU0PR04MB9563.eurprd04.prod.outlook.com
 ([fe80::dca6:e1e8:f142:2bc5]) by DU0PR04MB9563.eurprd04.prod.outlook.com
 ([fe80::dca6:e1e8:f142:2bc5%8]) with mapi id 15.20.6254.033; Wed, 5 Apr 2023
 09:08:21 +0000
From:   meenakshi.aggarwal@nxp.com
To:     horia.geanta@nxp.com, V.sethi@nxp.com, pankaj.gupta@nxp.com,
        gaurav.jain@nxp.com, herbert@gondor.apana.org.au,
        davem@davemloft.net, linux-crypto@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Meenakshi Aggarwal <meenakshi.aggarwal@nxp.com>
Subject: [PATCH v3 2/2] crypto: caam - OP-TEE firmware support
Date:   Wed,  5 Apr 2023 11:07:52 +0200
Message-Id: <20230405090752.1708455-3-meenakshi.aggarwal@nxp.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230405090752.1708455-1-meenakshi.aggarwal@nxp.com>
References: <20230322061716.3195841-3-meenakshi.aggarwal@nxp.com>
 <20230405090752.1708455-1-meenakshi.aggarwal@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AM8P251CA0029.EURP251.PROD.OUTLOOK.COM
 (2603:10a6:20b:21b::34) To DU0PR04MB9563.eurprd04.prod.outlook.com
 (2603:10a6:10:314::7)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU0PR04MB9563:EE_|AM8PR04MB7473:EE_
X-MS-Office365-Filtering-Correlation-Id: c57c5c55-76e4-488d-8a8d-08db35b54d73
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: b45e8ecsKgYB/JW3wfSwx70qZIiusczzz7rUloWAwg2n5wSrx0YKy0bHeDj21Agsm4tTA6DuXDPZVUijAja95sUSUdZ+/jdmS4b8G7SO6keLDcLpeGFGU4t9RJ7/k1+N0ZoOm7561tiQZe9r9samdfPGyVHLEe8LLSMYnMNx5t0v7hTfs2j8rKXp1Os+DOvDsj/DBXY3WmuTrfhSoBjiwj/nIewss3HCpNu/jtUkIcWvWkOC8Jen1fLwvPVU5yAGbSl1WHdhnD8dxvNewD/YPzrNWjCtChTCuLtwevdgpPxPIUqC5/VTEbqx0vYqVXKD5O9wVZyv0ox27YOfVDxV7UhfldjFDaxW65dvKgFhX4dcUqyNra3J8kTBT5qJICwY8M6tFLFDR2dV+8q3Ig1SP93O/FateML8noFL99xrS5SRaJbTrXkZkV0LWddvphvBCPSjtBX4Lffx2CVuHNiwJGWuFby5yWxf2KoEH4DGDyl1aVY6MX1zDu1V+UQNn8nwbJ17IFRWmIQoDbQQOu7CncrsxZPaJI9R6+U9m6BsagJ1gihq9H1kNnxImcxSAAfy4a7oAFjz45t2gH/fwRWX8/U57RkTf2LBAtfbCleC8xKX15nKaGsZJ+ETwJ6Bi76OQCFHI9eyzKbYavSxjVZpYQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9563.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(39860400002)(396003)(366004)(136003)(376002)(346002)(451199021)(6666004)(86362001)(41300700001)(36756003)(186003)(6486002)(4326008)(8676002)(52116002)(478600001)(38100700002)(2906002)(66476007)(83380400001)(66946007)(66556008)(316002)(8936002)(38350700002)(26005)(5660300002)(2616005)(6512007)(9686003)(6506007)(1076003)(309714004);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?4wz6ZRgOEhL7MOrVJ6V27PT/Zcf5yjQ9EOmcjokEyzCcNSucswviLaUcXQhT?=
 =?us-ascii?Q?lkDOrnIMWgQdBKybaUmJO6DpceUjYw8ZWOA3EZrx/Z82mGP1KvAb0lTwMs/B?=
 =?us-ascii?Q?rP8m1JjicDHVrSfk2nUCbRHRF43OiHASApBk93Sa6G4XWp93DcjkbaYvKAD4?=
 =?us-ascii?Q?7rr0UwfDEKk2XS/8th7TzjIUofuT0sm+yj6S0lZpoSDvy1K9+APxhMtvo9Si?=
 =?us-ascii?Q?la2L/aW3p/Uyoae945jVwsfxA9aGhBWBV5UTZ1bTekxXFhWLhEOEt0g2f14n?=
 =?us-ascii?Q?PVpF2P2SXLwl55ZOQtrFUUTXz0PZ8PtLQw1oNp5FfLjrxaNAJGg8KRrU04JV?=
 =?us-ascii?Q?ky4eUImsKUKIZMPShaEEDiAdOniolP/2A4/YJ8XxykjvaER6axLKOxdibHJw?=
 =?us-ascii?Q?Un7GYTOmDg2rIn4lmNYL+Q03jbhmKfwnRlvX/b8d6E6heah8LEWBlhlSLiKV?=
 =?us-ascii?Q?h4yWmoarOQ9j5IXMrQc/VbwRT+z+mTVal//J1vR0wAiixyY5ekPXj7YFGI7L?=
 =?us-ascii?Q?/O0ah9SB1/WzOqsE+tbfnotQwzkLrKhMMCUVpj4qE0rZVTdVnCaau7vZgtuv?=
 =?us-ascii?Q?lxjgWAJRsdiJpKruEPc1l+nvqHuEqnbowVGewhmtiTP17Z/fDfmI7BnSip1B?=
 =?us-ascii?Q?5TMcOoK3WeTqPeZXkIMMRUBX9ZXshE2sO96mn39MVT5LtQsTpDP2CCsblgq5?=
 =?us-ascii?Q?JkfaC8NiSJOobGJT6Mu4CVQhaiOTpko2j9Wi+hew7QwOntE4PhydNfEphRBr?=
 =?us-ascii?Q?QxrI497oGcdhb3H/w6wEldAIxP+TWP1/Sg40YzlbudgSkPHlo6RW+/MdXRaX?=
 =?us-ascii?Q?ryMcpIEUZsarisrnpSIFgJJu3OmDTehwzIufnMqVcmWqUVlMWikhImlphXZC?=
 =?us-ascii?Q?bYCzmIrJ4Hs9T3waevz6F02SEZFVfqX3C3oQtop/iPUKI/sTedRITrJMklt9?=
 =?us-ascii?Q?gFxUIQNmbfhur4pBoVPWLmf7OqoNxU9sgDmWgS5yq2LMv3INAzBvvzbGkRxq?=
 =?us-ascii?Q?Xv0nkExDxQxe9XpS09F7Ea3As6BGdqUXbj1AWPegJVJOGEa8g/sZXOpvYqMj?=
 =?us-ascii?Q?/YwgHbTGn0iskXuJaHZPsaLcwfnEpPCM5Bd0JTLEJhAaeH4aJqWP6xAjR94G?=
 =?us-ascii?Q?o0HzKvylK0EUvvCJjGXgunxJi8tzVcM1VtdwU7O/G+j3gQRoQu0eyTGMJGao?=
 =?us-ascii?Q?X9YItUyZPVRo+LaCM5vH9f2Hbi7+FmCw4dey848FYF+PtKxzwxU4QIF4vW3V?=
 =?us-ascii?Q?rmQp7NuMQxIv3xaxja/tN8zTMpLWS4gnjRR2b8giXB6ZO+bQ6EQ49AYhCgCk?=
 =?us-ascii?Q?0zMmbuc3shDUoegbuc4R3P3fPk1iU0v0AYn5X1R+3vZ85YdLiryYi8PHQ5Q9?=
 =?us-ascii?Q?UoPnnCHmnGCB5gvMJk7i/yk1eFMKeBamnvH+D6jg2DOK+eNcQH/mjdRMEids?=
 =?us-ascii?Q?ZPM4J1PvWnIkcl5BnpeXKj+O+lURsX5VpQEj1uYipeiml6gau9bAMID+wOKw?=
 =?us-ascii?Q?g+fKKuYGUS0QUFLj4uHzjTQe+CxeOs1p/G8ZhYuUTcu2QtuixCT0RL4Skpyx?=
 =?us-ascii?Q?5ObIWf2JUEhrw09N9/Bpn9BQpYxP5dnTm6sdtMrAmle798QUncxXYjWm5s9h?=
 =?us-ascii?Q?/g=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c57c5c55-76e4-488d-8a8d-08db35b54d73
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9563.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Apr 2023 09:08:20.9550
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: XXYco8enPe/21usqiZwaRvJ6ZVd5CPs1/VdzuyAoUoRGeryYrm/Uc3BT1cCCtQtJeBcxP25vcXtbcqYj596rba9FyRuVvG4qmBA6Lmzbkek=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM8PR04MB7473
X-Spam-Status: No, score=1.1 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        RCVD_IN_VALIDITY_RPBL,SPF_HELO_PASS,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Level: *
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Horia GeantA <horia.geanta@nxp.com>

caam driver needs to be aware of OP-TEE f/w presence, since some things
are done differently:

1. there is no access to controller's register page (note however that
some registers are aliased in job rings' register pages)

2 Due to this, MCFGR[PS] cannot be read and driver assumes
MCFGR[PS] = b'0 - engine using 32-bit address pointers.

This is in sync with the fact that:
-all i.MX SoCs currently use MCFGR[PS] = b'0
-only i.MX OP-TEE use cases don't allow access to controller register page

Signed-off-by: Horia GeantA <horia.geanta@nxp.com>
Signed-off-by: Meenakshi Aggarwal <meenakshi.aggarwal@nxp.com>
---
 drivers/crypto/caam/ctrl.c    | 23 ++++++++++++++++++++++-
 drivers/crypto/caam/debugfs.c |  3 +++
 drivers/crypto/caam/intern.h  |  1 +
 3 files changed, 26 insertions(+), 1 deletion(-)

diff --git a/drivers/crypto/caam/ctrl.c b/drivers/crypto/caam/ctrl.c
index de1f0acdb712..9c5a035e1b96 100644
--- a/drivers/crypto/caam/ctrl.c
+++ b/drivers/crypto/caam/ctrl.c
@@ -633,6 +633,7 @@ static int caam_probe(struct platform_device *pdev)
 	int pg_size;
 	int BLOCK_OFFSET = 0;
 	bool pr_support = false;
+	bool reg_access = true;
 
 	ctrlpriv = devm_kzalloc(&pdev->dev, sizeof(*ctrlpriv), GFP_KERNEL);
 	if (!ctrlpriv)
@@ -646,6 +647,17 @@ static int caam_probe(struct platform_device *pdev)
 	caam_imx = (bool)imx_soc_match;
 
 	if (imx_soc_match) {
+		/*
+		 * Until Layerscape and i.MX OP-TEE get in sync,
+		 * only i.MX OP-TEE use cases disallow access to
+		 * caam page 0 (controller) registers.
+		 */
+		np = of_find_compatible_node(NULL, NULL, "linaro,optee-tz");
+		ctrlpriv->optee_en = !!np;
+		of_node_put(np);
+
+		reg_access = !ctrlpriv->optee_en;
+
 		if (!imx_soc_match->data) {
 			dev_err(dev, "No clock data provided for i.MX SoC");
 			return -EINVAL;
@@ -696,7 +708,8 @@ static int caam_probe(struct platform_device *pdev)
 	caam_little_end = !(bool)(rd_reg32(&perfmon->status) &
 				  (CSTA_PLEND | CSTA_ALT_PLEND));
 	comp_params = rd_reg32(&perfmon->comp_parms_ms);
-	if (comp_params & CTPR_MS_PS && rd_reg32(&ctrl->mcr) & MCFGR_LONG_PTR)
+	if (reg_access && comp_params & CTPR_MS_PS &&
+	    rd_reg32(&ctrl->mcr) & MCFGR_LONG_PTR)
 		caam_ptr_sz = sizeof(u64);
 	else
 		caam_ptr_sz = sizeof(u32);
@@ -761,6 +774,9 @@ static int caam_probe(struct platform_device *pdev)
 	}
 #endif
 
+	if (!reg_access)
+		goto set_dma_mask;
+
 	/*
 	 * Enable DECO watchdogs and, if this is a PHYS_ADDR_T_64BIT kernel,
 	 * long pointers in master configuration register.
@@ -800,6 +816,7 @@ static int caam_probe(struct platform_device *pdev)
 			      JRSTART_JR1_START | JRSTART_JR2_START |
 			      JRSTART_JR3_START);
 
+set_dma_mask:
 	ret = dma_set_mask_and_coherent(dev, caam_get_dma_mask(dev));
 	if (ret) {
 		dev_err(dev, "dma_set_mask_and_coherent failed (%d)\n", ret);
@@ -842,6 +859,9 @@ static int caam_probe(struct platform_device *pdev)
 		return -ENOMEM;
 	}
 
+	if (!reg_access)
+		goto report_live;
+
 	comp_params = rd_reg32(&perfmon->comp_parms_ls);
 	ctrlpriv->blob_present = !!(comp_params & CTPR_LS_BLOB);
 
@@ -944,6 +964,7 @@ static int caam_probe(struct platform_device *pdev)
 		clrsetbits_32(&ctrl->scfgr, 0, SCFGR_RDBENABLE);
 	}
 
+report_live:
 	/* NOTE: RTIC detection ought to go here, around Si time */
 
 	caam_id = (u64)rd_reg32(&perfmon->caam_id_ms) << 32 |
diff --git a/drivers/crypto/caam/debugfs.c b/drivers/crypto/caam/debugfs.c
index b2ef2273298d..6358d3cabf57 100644
--- a/drivers/crypto/caam/debugfs.c
+++ b/drivers/crypto/caam/debugfs.c
@@ -77,6 +77,9 @@ void caam_debugfs_init(struct caam_drv_private *ctrlpriv,
 	debugfs_create_file("fault_status", 0444, ctrlpriv->ctl,
 			    &perfmon->status, &caam_fops_u32_ro);
 
+	if (ctrlpriv->optee_en)
+		return;
+
 	/* Internal covering keys (useful in non-secure mode only) */
 	ctrlpriv->ctl_kek_wrap.data = (__force void *)&ctrlpriv->ctrl->kek[0];
 	ctrlpriv->ctl_kek_wrap.size = KEK_KEY_SIZE * sizeof(u32);
diff --git a/drivers/crypto/caam/intern.h b/drivers/crypto/caam/intern.h
index 572cf66c887a..86ed1b91c22d 100644
--- a/drivers/crypto/caam/intern.h
+++ b/drivers/crypto/caam/intern.h
@@ -94,6 +94,7 @@ struct caam_drv_private {
 	u8 qi_present;		/* Nonzero if QI present in device */
 	u8 blob_present;	/* Nonzero if BLOB support present in device */
 	u8 mc_en;		/* Nonzero if MC f/w is active */
+	u8 optee_en;		/* Nonzero if OP-TEE f/w is active */
 	int secvio_irq;		/* Security violation interrupt number */
 	int virt_en;		/* Virtualization enabled in CAAM */
 	int era;		/* CAAM Era (internal HW revision) */
-- 
2.25.1

