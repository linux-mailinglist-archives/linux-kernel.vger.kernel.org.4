Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 21DA76C0B7A
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Mar 2023 08:39:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229776AbjCTHjT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Mar 2023 03:39:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48812 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229869AbjCTHjP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Mar 2023 03:39:15 -0400
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2068.outbound.protection.outlook.com [40.107.20.68])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF01BEC41;
        Mon, 20 Mar 2023 00:39:13 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iAivnaOfnVuZTYoLgNbPwEmRBz7C49jgNRmoyzf8tOzfC2qkr9jIxEo4fCtNz9xaZBRDY0omtn9354D8hiJHGpQRnVJKN8ehCnu5cXbfXKaXAzKVRts6nYt8X0MCvoQelKBjRnYrn+FLWHzaEppPkKjY04xzvN4iVYeqUqJYhN/MnNG+w5+DH+1Q+ndeLW1RVLu1Jo/PXoVvMt3FEqUiHuc5JL30qwWJ8X1efpVMrE99eWbRqa9FTelPbNP667KXo0dSZHfnbXPTji6mIJLaTF2xECeGsaAIgDceA3YO/ntxDdmmmcz5MnPjcInjswOJJhXWiOyAA89d8Ji9v+qecA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BWutZ3wZjtGAKf0+AlimsfdoXoX7HWIy7+sA1Rw0Cbs=;
 b=RYq0EsvXl63lsOl5Htgq7FraKOcARzUORm+MxKIZ5Bxka2N7hiMAxZBeS95vJpKkQMWgOCIMu83AfqQJE5Ab1BKK0Uh2n2uSEyBCfYH5C0ukMmgEtmJTOXkcQSEOgHYyJceCaBq5t64U27QdGLcGIhsZDQw2N1C++E6bDS7ykHC11OhuQK1Jz7KASRmEuvMY3F/G4OULmSQlA2sjOBoYNN4y//8hhxJwAwObKhi/Kre5d3wrEDjA0zvtgcoktnA7kN2xHapWYzi0w8ztH7vwxXSRk9JwEq/eq7PPU4H39o02w2pioOfFCYADeLmrCyPDZvK6leHeNHIzGOsdC1+ugQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BWutZ3wZjtGAKf0+AlimsfdoXoX7HWIy7+sA1Rw0Cbs=;
 b=U9cUcn//fhZmMFjHs3r0sKKxLBKsES39MMZ+CCdtMfe3yqXovmDoCVNjCqtdt1jsd9x3+CEj8OC+ur87y7OxB1HB4Aeu/Uk6Stu2sU5kGkM8nNc/TqtXuzuHnTw5F4o135mYBt6eJm9S/LPMCjGFRLYBndJjf3/4PxYiat8b8P8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from DU0PR04MB9563.eurprd04.prod.outlook.com (2603:10a6:10:314::7)
 by AS8PR04MB7656.eurprd04.prod.outlook.com (2603:10a6:20b:29b::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.37; Mon, 20 Mar
 2023 07:39:11 +0000
Received: from DU0PR04MB9563.eurprd04.prod.outlook.com
 ([fe80::a518:512c:4af1:276e]) by DU0PR04MB9563.eurprd04.prod.outlook.com
 ([fe80::a518:512c:4af1:276e%6]) with mapi id 15.20.6178.036; Mon, 20 Mar 2023
 07:39:10 +0000
From:   meenakshi.aggarwal@nxp.com
To:     horia.geanta@nxp.com, V.sethi@nxp.com, pankaj.gupta@nxp.com,
        gaurav.jain@nxp.com, herbert@gondor.apana.org.au,
        davem@davemloft.net, linux-crypto@vger.kernel.org,
        linux-kernel@vger.kernel.org, leonard.crestez@nxp.com,
        aisheng.dong@nxp.com
Subject: [PATCH] crypto: caam - refactor RNG initialization
Date:   Mon, 20 Mar 2023 08:38:48 +0100
Message-Id: <20230320073848.697473-1-meenakshi.aggarwal@nxp.com>
X-Mailer: git-send-email 2.25.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AM3PR07CA0134.eurprd07.prod.outlook.com
 (2603:10a6:207:8::20) To DU0PR04MB9563.eurprd04.prod.outlook.com
 (2603:10a6:10:314::7)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU0PR04MB9563:EE_|AS8PR04MB7656:EE_
X-MS-Office365-Filtering-Correlation-Id: 87244610-fe09-43da-1753-08db291631eb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ePyIvwS2o+LHRnbkK29H29cIPsxPqyLGOa39KEf+bJbTMDPLkL8yLz9UdoiPmQx2FO4qMq5Rj4LaO7Si0V5hMzWVaIr2RR5H9QBjSyFss3+MO8/2sdPLqbW4TMa/ECf6SMlWuCGNnVrxKy9taWcuMY5+hX+c/7Oq0IfKOlzd8yru+oBEuUZ0TMXlH0NjKf/lVeqTqVc5yN45/WejSezmiTtJ72Palv+Zf53C6Th6XT1753XdCT5OQWNS6gPDjIssTGshfZXqAcggDOrXNc+lm9Th447RuBErLWoWJuxWZJ0nBvIYttYBIcKKKXLiTb+wm2AyPeU7K5D8Q74n+3IPf9C9ss5ZbdYYvxnskC8/sInYtRIGKFGzxty5mqXvmlJxmC0SYrcN8vBXVXBb4khthN4WEu/O1CaOgw4h096lek4piG8Jv3O4n8+3mtHzLNewB+gD2mT4uboeQVYpYXq0R5+kWJwaWqaCq0OKYek1AezP2YV2HHnxe4jo8bO/nXpDiozqElznXo8DXEib3DQ6wDLkDTLf2sKjcRELR/AP83WsVEwDHI5b3uVfvTue0mqUygf774aRoboL68bhOJF6ekkNfI9nWVRqjkXa6/UHxy0aaoV+lSu9FEgx4XOmPGoIZ8C7N6O/vUUh8iW/AzXAH5oWWKxETD03alxfI+cxtB/F4Z4HxDmr8hqev2CRFwoXOiGZQrch9DiMJg/QPfSgOuuT+qqntxFLEH0H8IcKCMs=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9563.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(39860400002)(346002)(136003)(366004)(376002)(396003)(451199018)(41300700001)(66946007)(66556008)(66476007)(478600001)(316002)(8936002)(5660300002)(8676002)(36756003)(921005)(86362001)(52116002)(6512007)(6486002)(6506007)(1076003)(6666004)(26005)(186003)(9686003)(2616005)(2906002)(38350700002)(38100700002)(83380400001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?5EnpOwCus2khdjQTxXshczSjOihB71h+q6APk84V9w3SyW9X7WGz5wfpPzKM?=
 =?us-ascii?Q?xeDPfjtmHSy2zmy8uffWD/9wXcX8E70tA36Tvks7LFlx5usXTHVFeb/DOVNX?=
 =?us-ascii?Q?8XMWO9sGDU6merFSXvbUJckny5uJM1/XIpQgMjLNm0AIj8W0JdOWMo1hUoHl?=
 =?us-ascii?Q?ShGO5pkPPe4aLggAHXacBf49rYPYMXmskRvtgNbkA6071ogp6961/J7Ykut3?=
 =?us-ascii?Q?ntteQ8ywckmqbzsVnHaW8+0JHcfnACfXuyWXqBVTUi+bWNhSJd1S5ly+rkq8?=
 =?us-ascii?Q?7b4EayXgbrUBVx4E6oRQGhw6K7dt6KNi/Mlkgu8NeXqL+ptT16nJCh2/xj5g?=
 =?us-ascii?Q?LyODVsqJ0VW6RQYvZVQD3aPjOXQTO6QpqlJTHFdNc5/JpqDHprjiQHXnzqmk?=
 =?us-ascii?Q?+8Gmwe3cmfEfHRh7huVvk5OCEDHPZNFDp6VRag8ACaSOY8+ivR7puffImbsY?=
 =?us-ascii?Q?lNhfyUMagvHuX7VXVHOYIncfG07t9O41E4R74IfZlmUezmVHglL/7Fn/4eZJ?=
 =?us-ascii?Q?x7y8vuxJtlbBMFbY92fB3AGRI5hRqap4zAdfByBsMWA1yflAq8twZDCBSBqv?=
 =?us-ascii?Q?SZ5OuS0QIctb/6owPc7lH2r20dmMpx4bSEK755nynauKTNq0lQC9V64LJkC6?=
 =?us-ascii?Q?AGF5eRivkYavjo3/Lxf6099RGr5bJI0z3Z7+GDBf3Y8p4k0UVAcKl2TtPRcq?=
 =?us-ascii?Q?LM/DGwUe1ULT0j9L4sLleC0alnlOwd6eYvdSUehqebdf3HUiTbNzhHbDBHcW?=
 =?us-ascii?Q?oAi7xNx2B6U2tjKywxMNiOx0aO4fGYFMUQdOqRP9BuhiEV2SSl3d4nOoGokC?=
 =?us-ascii?Q?sXlF9MEVCu4/eYM2DkXHEeavwlv0Is3HfqiLXdgy4zQf4UQej3eiWbvtx6D2?=
 =?us-ascii?Q?sRZqcir2h2kTzFuP+sWWvCUBX84Le778eHiekIInTQEeAWqB9mcsU5RO8DkQ?=
 =?us-ascii?Q?+qfLtmefhDFfzVCBJBnKRaeqOtIZiy7qD/AJfD2Vr4uz5nvsr+1Cwvxeihoa?=
 =?us-ascii?Q?me4ls72H8TlhTKyurtZXbHtpGt/GSB1lqsZVk675q0LPomPfWX2DmiBSq3mG?=
 =?us-ascii?Q?9QUSFJg8JAkhTqEZhZBv1E0Vu6uqpL81mRLEUAYenhHwLNkjftOpouoxtWUx?=
 =?us-ascii?Q?+ZP5OxPt4o/MT1IIPqEqW950+YEQGbCK9Mmn5fcTDAYP8XJ6nwQ5BlCEe1sg?=
 =?us-ascii?Q?wzyx8gwDRtGeiDD+H8lztLo3P+vjf9YxiUSWc2q6skAyFIslMeT4dD7zV1Iz?=
 =?us-ascii?Q?+Ybme5vY3f0cXi338mqyd9WXPEoo8aNA21Svqgh3zySNJ3jH9chYkm8QXbO1?=
 =?us-ascii?Q?XVsAH5vx050jOJJN3qPiRylmq5hFqKOCMi+tmzBf6sK+DkOSvs0tHtDgRpY1?=
 =?us-ascii?Q?I70EFTNQ9qG+TytKvwaLwWLPoIMbEbjahKoejDq6rsBayIEY9XwymeI84oiV?=
 =?us-ascii?Q?phOfgCDU4iA/GJHyMbl1WgpdLeX8BN0bUhhl5XHEttL77FGhSytgP0O4xQRV?=
 =?us-ascii?Q?2ngiLYjD7LY2ph4SCfizB+vGt93GapgqwVs2LN8Y9b8z/U/rvl8s+8Y5CS9o?=
 =?us-ascii?Q?xzh58TnuuYpsEz+YGqM3zL798xC+s5PRkljG59NSNmlSIp+R8qxjCsBCJ7Qi?=
 =?us-ascii?Q?Ug=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 87244610-fe09-43da-1753-08db291631eb
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9563.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Mar 2023 07:39:10.8285
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: MXusVXKWIXLQlw68MINRbkdHRhFP6qjCxg95XbdTQd567vIH8yz4tc0403/y/XTAfTZtSzeS46GjPXsP5/wENlZhT/kVI2VUunhj8WOkRr8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB7656
X-Spam-Status: No, score=-0.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,RCVD_IN_VALIDITY_RPBL,SPF_HELO_PASS,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
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
---
 drivers/crypto/caam/ctrl.c   | 199 ++++++++++++++++++-----------------
 drivers/crypto/caam/intern.h |   1 +
 2 files changed, 104 insertions(+), 96 deletions(-)

diff --git a/drivers/crypto/caam/ctrl.c b/drivers/crypto/caam/ctrl.c
index 5a6cd63742a4..cf93cfb0eb99 100644
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
+			(struct version_regs *)&ctrlpriv->jr[0]->vreg :
+			(struct version_regs *)&ctrl->vreg;
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
@@ -619,7 +712,7 @@ static bool needs_entropy_delay_adjustment(void)
 /* Probe routine for CAAM top (controller) level */
 static int caam_probe(struct platform_device *pdev)
 {
-	int ret, ring, gen_sk, ent_delay = RTSDCTL_ENT_DLY_MIN;
+	int ret, ring;
 	u64 caam_id;
 	const struct soc_device_attribute *imx_soc_match;
 	struct device *dev;
@@ -629,10 +722,8 @@ static int caam_probe(struct platform_device *pdev)
 	struct caam_perfmon __iomem *perfmon;
 	struct dentry *dfs_root;
 	u32 scfgr, comp_params;
-	u8 rng_vid;
 	int pg_size;
 	int BLOCK_OFFSET = 0;
-	bool pr_support = false;
 	bool reg_access = true;
 
 	ctrlpriv = devm_kzalloc(&pdev->dev, sizeof(*ctrlpriv), GFP_KERNEL);
@@ -768,7 +859,8 @@ static int caam_probe(struct platform_device *pdev)
 
 		mc_version = fsl_mc_get_version();
 		if (mc_version)
-			pr_support = check_version(mc_version, 10, 20, 0);
+			ctrlpriv->pr_support = check_version(mc_version, 10, 20,
+							     0);
 		else
 			return -EPROBE_DEFER;
 	}
@@ -858,9 +950,6 @@ static int caam_probe(struct platform_device *pdev)
 		return -ENOMEM;
 	}
 
-	if (!reg_access)
-		goto report_live;
-
 	comp_params = rd_reg32(&ctrl->perfmon.comp_parms_ls);
 	ctrlpriv->blob_present = !!(comp_params & CTPR_LS_BLOB);
 
@@ -870,101 +959,19 @@ static int caam_probe(struct platform_device *pdev)
 	 * check both here.
 	 */
 	if (ctrlpriv->era < 10) {
-		rng_vid = (rd_reg32(&perfmon->cha_id_ls) &
-			   CHA_ID_LS_RNG_MASK) >> CHA_ID_LS_RNG_SHIFT;
 		ctrlpriv->blob_present = ctrlpriv->blob_present &&
 			(rd_reg32(&ctrl->perfmon.cha_num_ls) & CHA_ID_LS_AES_MASK);
 	} else {
-		struct version_regs __iomem *vreg;
-
-		vreg = ring ? (struct version_regs *)&ctrlpriv->jr[0]->vreg :
-			      (struct version_regs *)&ctrl->vreg;
-
-		rng_vid = (rd_reg32(&vreg->rng) & CHA_VER_VID_MASK) >>
-			   CHA_VER_VID_SHIFT;
 		ctrlpriv->blob_present = ctrlpriv->blob_present &&
 			(rd_reg32(&ctrl->vreg.aesa) & CHA_VER_MISC_AES_NUM_MASK);
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
 
-	/* NOTE: RTIC detection ought to go here, around Si time */
-
-report_live:
 	caam_id = (u64)rd_reg32(&perfmon->caam_id_ms) << 32 |
 		  (u64)rd_reg32(&perfmon->caam_id_ls);
 
diff --git a/drivers/crypto/caam/intern.h b/drivers/crypto/caam/intern.h
index efe2bc2f1103..a5048605cd67 100644
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

