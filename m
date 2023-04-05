Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DE43E6D79BF
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Apr 2023 12:33:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237446AbjDEKdf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Apr 2023 06:33:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44476 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229645AbjDEKdc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Apr 2023 06:33:32 -0400
Received: from EUR04-DB3-obe.outbound.protection.outlook.com (mail-db3eur04on2083.outbound.protection.outlook.com [40.107.6.83])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 36B0740E0;
        Wed,  5 Apr 2023 03:33:30 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nSS36NDBpkAoj4+LMrVtj6Fe5kckS7q6lWtW18EwxnHegzifZg3hvXI/qVWuiICmdvck7t+xeGeLxfJyY3VFxN4x3hS+JrhyqiEt7Th0VcRCbzO4QFmEhXHaDdIAmgqF+0jGRr4K9vbf3GrZeUYdyxBVZSvX+GfqtChXnYurR0dJ1qwU07e2ygo4HyRSRFdbZ7BopgO30k4wBlnprvUry9guvLJI4jy2AmThDFjqeG9qUrPFtRDEpn6cQhQnDjIKybBjLILbfZNxVsNvFGaSb1aFiJtwnhl9mzhuBon4zP1y8EzIdpuRuu/h2qsK8UGWKf/RC/YM5FirAUccSDrcgQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ngY9JEon8TqAqhSTZj3gB7h6pu45Yd+wEcdC2tvKo+Y=;
 b=DzFI4dXDhjceJ7tdO3OR9unSh6w/OSvlkCzk+AtsLRawQot3Aeor+/31Twv16BHJ2hvL7JmjAGDC8IteGMZuUdKEZTYwhMSILabi5VTzQ5+l4RS38pMgA0qxjoGd/sUzl7q4x/GFjl1T4owk29QdvKwWdeHC9QHoLwUlirUCLqVdiNJd1jLgxwWaP4DmIFSKgcyYGs0os4ILiDJOfswmgXOSEPMKiABHnqaBS+matKbO09H8OUz9+6qu/aH7Ct7vM2t5kztbo0xheV4qptima28ZzEOlVcl2/GJegHs9/Wk1S4JNqp/ahLZ4qrll011DSYrNfrizNWw37KkJSTvPyA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ngY9JEon8TqAqhSTZj3gB7h6pu45Yd+wEcdC2tvKo+Y=;
 b=M9f+Ad+MTwM/OBiGuGTTfx8r5gWQBv5BmnQXYeDrP3ttbcDuNQWHUtlMvYrHqvqGwk+yHyw3v/SQdCqmfMKHEGt1lBF0oiWWXDOZa4CPN+SUNzopODeRzn/dZyLSCFLxxTnFho6w5ANzW1EfIDJTTdkL1nx3Y1R8CYQSbyX89o4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from DU0PR04MB9563.eurprd04.prod.outlook.com (2603:10a6:10:314::7)
 by PAWPR04MB9766.eurprd04.prod.outlook.com (2603:10a6:102:384::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6254.35; Wed, 5 Apr
 2023 10:33:27 +0000
Received: from DU0PR04MB9563.eurprd04.prod.outlook.com
 ([fe80::dca6:e1e8:f142:2bc5]) by DU0PR04MB9563.eurprd04.prod.outlook.com
 ([fe80::dca6:e1e8:f142:2bc5%8]) with mapi id 15.20.6254.033; Wed, 5 Apr 2023
 10:33:27 +0000
From:   meenakshi.aggarwal@nxp.com
To:     horia.geanta@nxp.com, V.sethi@nxp.com, pankaj.gupta@nxp.com,
        gaurav.jain@nxp.com, herbert@gondor.apana.org.au,
        davem@davemloft.net, linux-crypto@vger.kernel.org,
        linux-kernel@vger.kernel.org, leonard.crestez@nxp.com,
        aisheng.dong@nxp.com
Cc:     Meenakshi Aggarwal <meenakshi.aggarwal@nxp.com>
Subject: [PATCH v2] crypto: caam - refactor RNG initialization
Date:   Wed,  5 Apr 2023 12:33:06 +0200
Message-Id: <20230405103306.1763491-1-meenakshi.aggarwal@nxp.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230320073848.697473-1-meenakshi.aggarwal@nxp.com>
References: <20230320073848.697473-1-meenakshi.aggarwal@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AM8P191CA0004.EURP191.PROD.OUTLOOK.COM
 (2603:10a6:20b:21a::9) To DU0PR04MB9563.eurprd04.prod.outlook.com
 (2603:10a6:10:314::7)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU0PR04MB9563:EE_|PAWPR04MB9766:EE_
X-MS-Office365-Filtering-Correlation-Id: 401b4b0c-bdf2-4bd6-9784-08db35c13138
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Skp8K7nZDsMlfYjxFtl248a7KLsOtDXedwVUqzMj57SY1XEq+HaNqoGlyBttaIY2Bbs89wxspBtOhXZQz+u3fURO8eijuoi5ClM1LWotdOtifIBur/SYEoXc4QT+YMx3vKmoWT/TBMxHK7frBoLHAS7qso0saSNc34ZyMxHfjazJW/NYVEI363M9PM1HVz7Tmh5ADUNywD3JDOVmuw8uOsp8FmW+Gbknk0++folOI7AZDnImSNvrnsI3Rqfx0g+GuLZhzX9lg6wbIaNe0yWjihd1gx+Zmuq+PRByUJx4acQ2uKSIU5PuJ4xb+tc0iEsn9mI3DDU1ZosPQh3YYGZh4QyRSYx0TTH0vucpUIBGWtYtqHpimBx/+FWCJbvj9/j1K3MmRx1C8vAshhURTEhU7xlTUpMWRf6ELc8J9ToYFh092YhX6ROmO2fL9llIY6KKz5tAb3Gea55FBm2ROy0F7EeWVbqltaQbntOAe1EhMz7+EPC8xJZlaBp8LQtZqDtiMM7xUxpT5nJ9oKLmBvexLBqzhRExwRilbrdpZCaxcZVQni6fQL1Tnhq4T/fuWk/vg15gRC+9Hs3m7ex7dfpQiEgygRfCO5PF3Ezz8JlRHzvRh6zQblmMFe05ND7Y1t1+qRGBlZgKXwGrDhL1MpRNYQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9563.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(376002)(39860400002)(136003)(366004)(346002)(396003)(451199021)(8936002)(66946007)(66476007)(41300700001)(66556008)(316002)(2906002)(52116002)(478600001)(2616005)(4326008)(186003)(6666004)(8676002)(5660300002)(6512007)(1076003)(9686003)(6506007)(26005)(83380400001)(921005)(86362001)(38350700002)(6486002)(38100700002)(36756003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?62BWzESOIT+L8ISCzTs6gqUkzclNWx+gmp9kFa+o2+KyhSPqo/dHcYe26/KZ?=
 =?us-ascii?Q?kHGQIRd44j0r5h3HMhIGM+vYq27fUt6yV9IRXZ5bYovN+K3hQnKeiqM55Kfc?=
 =?us-ascii?Q?sx2Yl1K9z1mYAxCpOCZySD77b6h6dQaWB9UGaNbWNfiV3w2hPeb8Y4FTk741?=
 =?us-ascii?Q?5M55keF0kBFxJFAg85vSF3Z2HX9pXKciTX81LkOuai3roiI0PT6v5cNJFGn+?=
 =?us-ascii?Q?O5oQgu+x4uCTa2asYTpo+En2y8gRnzj7HMLw4KLtV30peXbRXrBQT2wFxqu/?=
 =?us-ascii?Q?gsC7q4APR4Gf7yOkg0k159VSiOtN6WptQ1kmqD8bM9xFTPIC2yaeToL2tCSR?=
 =?us-ascii?Q?TiyFNqs0hr5w57OPtRzmgqOsqz4ALT6WsClBTRCxQSaxF+3k1yFE8t/qDECZ?=
 =?us-ascii?Q?eD5PTOcYR4rH7TOrx+OFNBxPziLHu/nz66zCsU6d8bUWwQ7OxM4AZp4HuZ3e?=
 =?us-ascii?Q?qIp5hZ8RiaPGCZyDu1Cw7P9mSPjaTP3Tt5iGy1vMoWJyvcJSy1S4hdtg/T3f?=
 =?us-ascii?Q?/iPZbLJIny66IICrG1Wga3VZrEGk4oX0vtDhF87E2g72wDuBMnZTQPfV/6Gd?=
 =?us-ascii?Q?v0Cgq/DzMix48hVvFE941SvBuxg0khtHFpv82QxpWOofM+MuERIiEYWt0Frw?=
 =?us-ascii?Q?nLXJV6fMWiD4O9R0EULRmxfiVogNan3FYY9nt4yEDUw/CFeJv5A+BlcOqf6P?=
 =?us-ascii?Q?qSXnm+torCQprxZg+mVF8A4a6EKZAKhuisMeDwT8xCAGWcXYU5XgEpkgvXG0?=
 =?us-ascii?Q?4PuVPLrxHPWTRF48jERo7ygKfvXR77cKnTVTA+rNNuW3MLQtWLcmba/DN9VZ?=
 =?us-ascii?Q?k9J9tl7KEA5J/Yi5jWiURkEXNX69g/25tEJQ9LvI9iuh9UpxLgUXw0Vhyelu?=
 =?us-ascii?Q?GsMBz2Zinedppok53IyZPvuCYID8AkKRax13A4cJl7TbH2TnA8ODf49GO8mD?=
 =?us-ascii?Q?6LQXpvUQUpC2ir1E0ct+au4sTmHtcQmoyRq2I1XAB4q6pNRJyRxhkvLqwuEy?=
 =?us-ascii?Q?AmYYAMvqiwsnVn+lSSiFgIMWnMX2FdlCr/1nTqBt60knxDdz+FYU4VJTodAg?=
 =?us-ascii?Q?dITd7zLYQpcKmh/13cc4jdQQPIoorX3DuARyUFOy0vXEz14+eqjKvFoLm4uk?=
 =?us-ascii?Q?ogpAceaCUEvp9jj5Rjw/8rE1LZXsGnSHLlKcN0qxnWg7xfMbGYfA2uPTxln9?=
 =?us-ascii?Q?BR6O+O2bidKxSNO2BxQtoT3WeTlA9UOBcpmSgOKwtwUG4dxtwyrZWrJD1BvQ?=
 =?us-ascii?Q?9E/8vOxAi3vDYToROOchgPXC2uVYOocyyFysrjc+Az35mvExkRPnj2N/taO5?=
 =?us-ascii?Q?OPi7J04A31DhRBoSbUI2+/KmPcD3curEvNbX1p+NB9xEnuaMBhdU7x8wHNMw?=
 =?us-ascii?Q?/NjH2hNj9JYXYvg1OrFmsSTFxGn18WTCIi1qZU4RfkHqW9T665MAOC5ylO4b?=
 =?us-ascii?Q?wERP0Zy53Gwk/cRNna4tW26kZone95dcfGHYqfrPWj9QACo+jPDWLEohz/eh?=
 =?us-ascii?Q?O5pp+fGwW35yAUOWs1/iXzo6hwOgtteblKaZnakFTwNFu4O9pWf9I+Q8z5UV?=
 =?us-ascii?Q?myOc/VRgAyCjGl7F6AfBshG/om6Sz3pKNZas720MEbrxQx/5tQSXItVDLe3Z?=
 =?us-ascii?Q?Uw=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 401b4b0c-bdf2-4bd6-9784-08db35c13138
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9563.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Apr 2023 10:33:27.5648
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: YgwKXvMFkpjIYTklVmday11nH9NkuvqpvLiqnD+2WkjTdC5bxeAfx5MxywPewTI/4nogWENK52YmJLD+r56Kn53jkJkPJ4iqy/AGdME15mY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAWPR04MB9766
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_PASS,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Horia GeantA <horia.geanta@nxp.com>

RNG (re-)initialization will be needed on pm resume path,
thus refactor the corresponding code out of the probe callback.

Signed-off-by: Horia GeantA <horia.geanta@nxp.com>
Signed-off-by: Leonard Crestez <leonard.crestez@nxp.com>
Signed-off-by: Dong Aisheng <aisheng.dong@nxp.com>
Signed-off-by: Meenakshi Aggarwal <meenakshi.aggarwal@nxp.com>
---
changes in v2:
	Rebased on "page 0" patches
	
NOTE: This patch depends on "page 0" patches, which are under
 review on mailing list.

 drivers/crypto/caam/ctrl.c   | 201 ++++++++++++++++++-----------------
 drivers/crypto/caam/intern.h |   1 +
 2 files changed, 104 insertions(+), 98 deletions(-)

diff --git a/drivers/crypto/caam/ctrl.c b/drivers/crypto/caam/ctrl.c
index 9c5a035e1b96..852d538cfc25 100644
--- a/drivers/crypto/caam/ctrl.c
+++ b/drivers/crypto/caam/ctrl.c
@@ -342,13 +342,12 @@ static int instantiate_rng(struct device *ctrldev, int state_handle_mask,
 /*
  * kick_trng - sets the various parameters for enabling the initialization
  *	       of the RNG4 block in CAAM
- * @pdev - pointer to the platform device
+ * @dev - pointer to the controller device
  * @ent_delay - Defines the length (in system clocks) of each entropy sample.
  */
-static void kick_trng(struct platform_device *pdev, int ent_delay)
+static void kick_trng(struct device *dev, int ent_delay)
 {
-	struct device *ctrldev = &pdev->dev;
-	struct caam_drv_private *ctrlpriv = dev_get_drvdata(ctrldev);
+	struct caam_drv_private *ctrlpriv = dev_get_drvdata(dev);
 	struct caam_ctrl __iomem *ctrl;
 	struct rng4tst __iomem *r4tst;
 	u32 val;
@@ -589,6 +588,100 @@ static void caam_remove_debugfs(void *root)
 	debugfs_remove_recursive(root);
 }
 
+static int caam_ctrl_rng_init(struct device *dev)
+{
+	struct caam_drv_private *ctrlpriv = dev_get_drvdata(dev);
+	struct caam_ctrl __iomem *ctrl = ctrlpriv->ctrl;
+	int ret, gen_sk, ent_delay = RTSDCTL_ENT_DLY_MIN;
+	u8 rng_vid;
+
+	if (ctrlpriv->era < 10) {
+		struct caam_perfmon __iomem *perfmon;
+
+		perfmon = ctrlpriv->total_jobrs ?
+			  (struct caam_perfmon *)&ctrlpriv->jr[0]->perfmon :
+			  (struct caam_perfmon *)&ctrl->perfmon;
+
+		rng_vid = (rd_reg32(&perfmon->cha_id_ls) &
+			   CHA_ID_LS_RNG_MASK) >> CHA_ID_LS_RNG_SHIFT;
+	} else {
+		struct version_regs __iomem *vreg;
+
+		vreg = ctrlpriv->total_jobrs ?
+			(struct version_regs __iomem *)&ctrlpriv->jr[0]->vreg :
+			(struct version_regs __iomem *)&ctrl->vreg;
+
+		rng_vid = (rd_reg32(&vreg->rng) & CHA_VER_VID_MASK) >>
+			  CHA_VER_VID_SHIFT;
+	}
+
+	/*
+	 * If SEC has RNG version >= 4 and RNG state handle has not been
+	 * already instantiated, do RNG instantiation
+	 * In case of SoCs with Management Complex, RNG is managed by MC f/w.
+	 */
+	if (!(ctrlpriv->mc_en && ctrlpriv->pr_support) && rng_vid >= 4) {
+		ctrlpriv->rng4_sh_init =
+			rd_reg32(&ctrl->r4tst[0].rdsta);
+		/*
+		 * If the secure keys (TDKEK, JDKEK, TDSK), were already
+		 * generated, signal this to the function that is instantiating
+		 * the state handles. An error would occur if RNG4 attempts
+		 * to regenerate these keys before the next POR.
+		 */
+		gen_sk = ctrlpriv->rng4_sh_init & RDSTA_SKVN ? 0 : 1;
+		ctrlpriv->rng4_sh_init &= RDSTA_MASK;
+		do {
+			int inst_handles =
+				rd_reg32(&ctrl->r4tst[0].rdsta) & RDSTA_MASK;
+			/*
+			 * If either SH were instantiated by somebody else
+			 * (e.g. u-boot) then it is assumed that the entropy
+			 * parameters are properly set and thus the function
+			 * setting these (kick_trng(...)) is skipped.
+			 * Also, if a handle was instantiated, do not change
+			 * the TRNG parameters.
+			 */
+			if (!(ctrlpriv->rng4_sh_init || inst_handles)) {
+				dev_info(dev,
+					 "Entropy delay = %u\n",
+					 ent_delay);
+				kick_trng(dev, ent_delay);
+				ent_delay += 400;
+			}
+			/*
+			 * if instantiate_rng(...) fails, the loop will rerun
+			 * and the kick_trng(...) function will modify the
+			 * upper and lower limits of the entropy sampling
+			 * interval, leading to a successful initialization of
+			 * the RNG.
+			 */
+			ret = instantiate_rng(dev, inst_handles,
+					      gen_sk);
+			if (ret == -EAGAIN)
+				/*
+				 * if here, the loop will rerun,
+				 * so don't hog the CPU
+				 */
+				cpu_relax();
+		} while ((ret == -EAGAIN) && (ent_delay < RTSDCTL_ENT_DLY_MAX));
+		if (ret) {
+			dev_err(dev, "failed to instantiate RNG");
+			return ret;
+		}
+		/*
+		 * Set handles initialized by this module as the complement of
+		 * the already initialized ones
+		 */
+		ctrlpriv->rng4_sh_init = ~ctrlpriv->rng4_sh_init & RDSTA_MASK;
+
+		/* Enable RDB bit so that RNG works faster */
+		clrsetbits_32(&ctrl->scfgr, 0, SCFGR_RDBENABLE);
+	}
+
+	return 0;
+}
+
 #ifdef CONFIG_FSL_MC_BUS
 static bool check_version(struct fsl_mc_version *mc_version, u32 major,
 			  u32 minor, u32 revision)
@@ -609,17 +702,10 @@ static bool check_version(struct fsl_mc_version *mc_version, u32 major,
 }
 #endif
 
-static bool needs_entropy_delay_adjustment(void)
-{
-	if (of_machine_is_compatible("fsl,imx6sx"))
-		return true;
-	return false;
-}
-
 /* Probe routine for CAAM top (controller) level */
 static int caam_probe(struct platform_device *pdev)
 {
-	int ret, ring, gen_sk, ent_delay = RTSDCTL_ENT_DLY_MIN;
+	int ret, ring;
 	u64 caam_id;
 	const struct soc_device_attribute *imx_soc_match;
 	struct device *dev;
@@ -629,10 +715,8 @@ static int caam_probe(struct platform_device *pdev)
 	struct caam_perfmon __iomem *perfmon;
 	struct dentry *dfs_root;
 	u32 scfgr, comp_params;
-	u8 rng_vid;
 	int pg_size;
 	int BLOCK_OFFSET = 0;
-	bool pr_support = false;
 	bool reg_access = true;
 
 	ctrlpriv = devm_kzalloc(&pdev->dev, sizeof(*ctrlpriv), GFP_KERNEL);
@@ -768,7 +852,8 @@ static int caam_probe(struct platform_device *pdev)
 
 		mc_version = fsl_mc_get_version();
 		if (mc_version)
-			pr_support = check_version(mc_version, 10, 20, 0);
+			ctrlpriv->pr_support = check_version(mc_version, 10, 20,
+							     0);
 		else
 			return -EPROBE_DEFER;
 	}
@@ -859,9 +944,6 @@ static int caam_probe(struct platform_device *pdev)
 		return -ENOMEM;
 	}
 
-	if (!reg_access)
-		goto report_live;
-
 	comp_params = rd_reg32(&perfmon->comp_parms_ls);
 	ctrlpriv->blob_present = !!(comp_params & CTPR_LS_BLOB);
 
@@ -871,8 +953,6 @@ static int caam_probe(struct platform_device *pdev)
 	 * check both here.
 	 */
 	if (ctrlpriv->era < 10) {
-		rng_vid = (rd_reg32(&perfmon->cha_id_ls) &
-			   CHA_ID_LS_RNG_MASK) >> CHA_ID_LS_RNG_SHIFT;
 		ctrlpriv->blob_present = ctrlpriv->blob_present &&
 			(rd_reg32(&perfmon->cha_num_ls) & CHA_ID_LS_AES_MASK);
 	} else {
@@ -882,91 +962,16 @@ static int caam_probe(struct platform_device *pdev)
 			(struct version_regs __iomem *)&ctrlpriv->jr[0]->vreg :
 			(struct version_regs __iomem *)&ctrl->vreg;
 
-		rng_vid = (rd_reg32(&vreg->rng) & CHA_VER_VID_MASK) >>
-			   CHA_VER_VID_SHIFT;
 		ctrlpriv->blob_present = ctrlpriv->blob_present &&
 			(rd_reg32(&vreg->aesa) & CHA_VER_MISC_AES_NUM_MASK);
 	}
 
-	/*
-	 * If SEC has RNG version >= 4 and RNG state handle has not been
-	 * already instantiated, do RNG instantiation
-	 * In case of SoCs with Management Complex, RNG is managed by MC f/w.
-	 */
-	if (!(ctrlpriv->mc_en && pr_support) && rng_vid >= 4) {
-		ctrlpriv->rng4_sh_init =
-			rd_reg32(&ctrl->r4tst[0].rdsta);
-		/*
-		 * If the secure keys (TDKEK, JDKEK, TDSK), were already
-		 * generated, signal this to the function that is instantiating
-		 * the state handles. An error would occur if RNG4 attempts
-		 * to regenerate these keys before the next POR.
-		 */
-		gen_sk = ctrlpriv->rng4_sh_init & RDSTA_SKVN ? 0 : 1;
-		ctrlpriv->rng4_sh_init &= RDSTA_MASK;
-		do {
-			int inst_handles =
-				rd_reg32(&ctrl->r4tst[0].rdsta) &
-								RDSTA_MASK;
-			/*
-			 * If either SH were instantiated by somebody else
-			 * (e.g. u-boot) then it is assumed that the entropy
-			 * parameters are properly set and thus the function
-			 * setting these (kick_trng(...)) is skipped.
-			 * Also, if a handle was instantiated, do not change
-			 * the TRNG parameters.
-			 */
-			if (needs_entropy_delay_adjustment())
-				ent_delay = 12000;
-			if (!(ctrlpriv->rng4_sh_init || inst_handles)) {
-				dev_info(dev,
-					 "Entropy delay = %u\n",
-					 ent_delay);
-				kick_trng(pdev, ent_delay);
-				ent_delay += 400;
-			}
-			/*
-			 * if instantiate_rng(...) fails, the loop will rerun
-			 * and the kick_trng(...) function will modify the
-			 * upper and lower limits of the entropy sampling
-			 * interval, leading to a successful initialization of
-			 * the RNG.
-			 */
-			ret = instantiate_rng(dev, inst_handles,
-					      gen_sk);
-			/*
-			 * Entropy delay is determined via TRNG characterization.
-			 * TRNG characterization is run across different voltages
-			 * and temperatures.
-			 * If worst case value for ent_dly is identified,
-			 * the loop can be skipped for that platform.
-			 */
-			if (needs_entropy_delay_adjustment())
-				break;
-			if (ret == -EAGAIN)
-				/*
-				 * if here, the loop will rerun,
-				 * so don't hog the CPU
-				 */
-				cpu_relax();
-		} while ((ret == -EAGAIN) && (ent_delay < RTSDCTL_ENT_DLY_MAX));
-		if (ret) {
-			dev_err(dev, "failed to instantiate RNG");
+	if (reg_access) {
+		ret = caam_ctrl_rng_init(dev);
+		if (ret)
 			return ret;
-		}
-		/*
-		 * Set handles initialized by this module as the complement of
-		 * the already initialized ones
-		 */
-		ctrlpriv->rng4_sh_init = ~ctrlpriv->rng4_sh_init & RDSTA_MASK;
-
-		/* Enable RDB bit so that RNG works faster */
-		clrsetbits_32(&ctrl->scfgr, 0, SCFGR_RDBENABLE);
 	}
 
-report_live:
-	/* NOTE: RTIC detection ought to go here, around Si time */
-
 	caam_id = (u64)rd_reg32(&perfmon->caam_id_ms) << 32 |
 		  (u64)rd_reg32(&perfmon->caam_id_ls);
 
diff --git a/drivers/crypto/caam/intern.h b/drivers/crypto/caam/intern.h
index 86ed1b91c22d..b4f7bf77f487 100644
--- a/drivers/crypto/caam/intern.h
+++ b/drivers/crypto/caam/intern.h
@@ -95,6 +95,7 @@ struct caam_drv_private {
 	u8 blob_present;	/* Nonzero if BLOB support present in device */
 	u8 mc_en;		/* Nonzero if MC f/w is active */
 	u8 optee_en;		/* Nonzero if OP-TEE f/w is active */
+	bool pr_support;        /* RNG prediction resistance available */
 	int secvio_irq;		/* Security violation interrupt number */
 	int virt_en;		/* Virtualization enabled in CAAM */
 	int era;		/* CAAM Era (internal HW revision) */
-- 
2.25.1

