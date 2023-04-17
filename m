Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 58B686E5030
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Apr 2023 20:29:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230196AbjDQS30 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Apr 2023 14:29:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40506 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230186AbjDQS3V (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Apr 2023 14:29:21 -0400
Received: from EUR03-VI1-obe.outbound.protection.outlook.com (mail-vi1eur03on2073.outbound.protection.outlook.com [40.107.103.73])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0BAE25FF9;
        Mon, 17 Apr 2023 11:29:11 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fH/UOpEFqnICZh3q7PmiJhzf/vRgL1qPsGzHi4q6XsBRxO+ity9WfEXmTRzCXJh3s4+fI1dinOkFr4EzDEjAdqMF2fcjbFBWyBsiRqtOCAkzCSEZjz06WhJBttvFfCgcPmzIdJTj79dYIy7JnGnSbE1x5Cm8Urrm8IpTlja6ADadtYuNIPGUbFLiH7eGFfTrY77JHKjxqW6950CqJTVtw+lq4qnufLOxr8G4cpEjaV4ZaRtG66HVL2JEFBR54MpXX85Scd3j04GItxruzjryds2L3NXy2bUW3OajVVYBBU27qpxLOrk3FHMKxP5yRdtgKtyFmZVt/dYTLKax85Ycpg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=I1vjg6WIHSzP1B/qS6wkhrIqR6SWMbqvNufkKzKsiQE=;
 b=Klq/lYysUW1W5yY4EEIc+u3dXaoK79XlQG7T6UuLck5GI/Mmy61+FvJguHfwWx0POjuJYdQCOl2l9WnO3X4cGuq5+9B6CQhHR9I8Rs8zkinojwOcS4IjEQZBid/GZFpeYF2gGgpat29geQEOHWz5jmu935wZ191LfEEEI8ahIvme/rPbo+OuDORqFJ1gJRjI8s50PKaL1ZNZ9VKFVrU+qSydejoKrzZed+RFUeqIM0x3WdW04JkYllrbjY870Q5LTLS8dshkBTn5qnbhTeBRBbFNRNQczLlnygEUKOxCQHsJm9wsam0yzATGWbdvmTXIeKeU8q5cfHKG7528wx9P+g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=I1vjg6WIHSzP1B/qS6wkhrIqR6SWMbqvNufkKzKsiQE=;
 b=f19nOxv2AqteK995z/5HZgCBZrHbL1Azg11wIpGvdlYZvFGYerMOqYMYuSPTgGhF513aMTwfmFhadiTN/4kB5vJUxl4cn//aETlny9+sp7QjdjE3OJ18+rCXe7Nayh0698D2/4q3g3gcFrLcBxDhVHFeUb/1ReeFXkdem2h+PNI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from DU0PR04MB9563.eurprd04.prod.outlook.com (2603:10a6:10:314::7)
 by DBAPR04MB7397.eurprd04.prod.outlook.com (2603:10a6:10:1a9::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6298.45; Mon, 17 Apr
 2023 18:29:09 +0000
Received: from DU0PR04MB9563.eurprd04.prod.outlook.com
 ([fe80::dca6:e1e8:f142:2bc5]) by DU0PR04MB9563.eurprd04.prod.outlook.com
 ([fe80::dca6:e1e8:f142:2bc5%9]) with mapi id 15.20.6298.045; Mon, 17 Apr 2023
 18:29:09 +0000
From:   meenakshi.aggarwal@nxp.com
To:     horia.geanta@nxp.com, V.sethi@nxp.com, pankaj.gupta@nxp.com,
        gaurav.jain@nxp.com, herbert@gondor.apana.org.au,
        davem@davemloft.net, linux-crypto@vger.kernel.org,
        linux-kernel@vger.kernel.org, leonard.crestez@nxp.com,
        aisheng.dong@nxp.com
Cc:     Meenakshi Aggarwal <meenakshi.aggarwal@nxp.com>
Subject: [PATCH v3] crypto: caam - refactor RNG initialization
Date:   Mon, 17 Apr 2023 20:28:39 +0200
Message-Id: <20230417182839.782924-1-meenakshi.aggarwal@nxp.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230405103306.1763491-1-meenakshi.aggarwal@nxp.com>
References: <20230405103306.1763491-1-meenakshi.aggarwal@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AS4P189CA0031.EURP189.PROD.OUTLOOK.COM
 (2603:10a6:20b:5dd::11) To DU0PR04MB9563.eurprd04.prod.outlook.com
 (2603:10a6:10:314::7)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU0PR04MB9563:EE_|DBAPR04MB7397:EE_
X-MS-Office365-Filtering-Correlation-Id: 3eaa1d3f-49d2-4ce5-8d81-08db3f71a233
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 3i6vRAuOtyEhGi/vXFLIvMq2GoFl/kQjAGAHUSuuxo/e1t/Q7VacrsgGfJeCj/ZS085WGPX60lwv3swuyfHi75hNC5Ks7+oLFjzWvi20MtaWN0ZHHoC5Hzuwd5l0nYBWjWdwNhdV3FTVXbXx/wM7k8MPUNLiN/zX1xdia26GnBkpI9imBEi3qjuBT00DHbvAb26Hez1IMaCAVKbbHtP+5aFdZneNdQ+MiKy41TWVRF+sYtaTd0YBzUXQMnAnMiypXzB4503ieVJYeSMXRQeRyKzE7zffsUnPtdjDXVUX518IQbITfcOMmsgEKmJqgNweqTqD+NojZseymY6j0fuhScKUj6ZV8jpdiOKQvzRvofC01CjOhlEj/Sp7jsv54G+YWSfZI570TIoK/XX8xGUz7twfWCw9d5GmPwGesWXbxQRyufPGPas5cXOharGZQ4lf/5UtshA1wvawcijqAdPpvxgUGyV8i3O+3272dxoZHo7Mt+nAqQNhyyOj8Ng5r58TSVd3T2HEezVxW7VUgAOJ8fSUbHwWqXkASjkE1JkI2CFfySdq+fs1i9onZeAPU0j20Xh3y7aGVwEq1ph84rGvKhfLtmGFrSOVnNu0LaSjXPX9hw4RxCYprBAcNKn4p8DYyCC6RvJwt9RSrUi7+7dkKA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9563.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(39860400002)(366004)(136003)(346002)(376002)(396003)(451199021)(5660300002)(86362001)(2616005)(83380400001)(186003)(1076003)(9686003)(6506007)(921005)(26005)(6512007)(38100700002)(38350700002)(8676002)(8936002)(478600001)(6486002)(6666004)(52116002)(316002)(41300700001)(36756003)(66556008)(4326008)(66476007)(66946007)(2906002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?bI7h7qDQ5MZYi0xJw4KBUEj4dZBWE8ImOGpwZXiEqwFnxGpavuyXWeKpF/Mc?=
 =?us-ascii?Q?U6du/7uwVDE+RDd2e1ZqHLFNnBYpJybQzImTzRb6P3ktvNS7MeX+ZeEUM7Iz?=
 =?us-ascii?Q?gQeqGGghv8IIfwKswiN4NqYIw2sWPlEOLRUCu86+tIlQMktUlsAqK+CVHn7b?=
 =?us-ascii?Q?PZ8xAUlleSm0f0XBfO5QkjZAMTAvgJNGRDRsQJ0Su8tOJ1ss1nclvR7Axj0M?=
 =?us-ascii?Q?iagS2jeduRaHCrO487u25e7i4JjbkfnlnlSoePpZrffns8a6Ppk/+n0u2Vjq?=
 =?us-ascii?Q?HSiTO/SAJHg2ZoH6iuU9a+xPZnKQErRk+yNR+KnRkbiRI878DCJiHG6bNMW2?=
 =?us-ascii?Q?cTnpIO1iZoeBpoFUHpEQELImQ2bvmiSCoQTsyo4qXLC1QMNNO+9iRpgYkcgI?=
 =?us-ascii?Q?CqjeK2SOtIxKvJlRnpRR8TNgvRZusf0Eqb/2ohw0zeaeQHbUt11Thwl6M8oS?=
 =?us-ascii?Q?05cvJeoR9I9hC2BIUZnJJATKE4I8lhVZTJydDVsEagrnelzgYF1NPHx84pAt?=
 =?us-ascii?Q?ZjCw9EIJC/jX9Z5jqw37eFgT7OOBZ9uIqdTXARTsm5DnFjFnO8TUbdU+OG4g?=
 =?us-ascii?Q?loJlcDkxGNlcgY/qIXvhCe6NkMgWeWaODXHL4ORFpS5NBVJ+8SYmT3BL8BK/?=
 =?us-ascii?Q?rLXYoT5Ob2Xr1akAxWYDjPjiUDGi8cJYOU7phrvRrOyKFQ0WCU4kYV3t6ACF?=
 =?us-ascii?Q?jidD0k1Fs5eT72Th57CiQWbfvD7Ncx7fv00nDa71+qWIGspfcTMTlru2A+Jo?=
 =?us-ascii?Q?Gl0WePhN5t581fiePBL1pL91iWJbAV3DDyJtUdMGPOzsKIsuf27/RBhytT5Q?=
 =?us-ascii?Q?ajMa+0YhfyyJgRt8kHujzIHvgQwmJTyh98BPkuuowS7+pCpfqnbOMHgugvbg?=
 =?us-ascii?Q?FzI/+JhgAzjtxei3/gJ6oiwZyEfY7xrJL+edaoO63sV3pMF/ih841wAlc19y?=
 =?us-ascii?Q?1QcEvAbNmuejKRMUWurbMFjBTNQbK49DSqA8hkpqSWwTrscqw86LfobwrMyW?=
 =?us-ascii?Q?J/8GXEeKTUcaMMEM4LvdLueXEa17kR0ixqESn//6IET78iIM67wGdNMnP1pv?=
 =?us-ascii?Q?n6H3nFdXeEqfSElaAyBL/8rRmytUoDsD7h5vlI8YXqQFq3MmsayqpH4S6hYa?=
 =?us-ascii?Q?etbsWIcCL71+yXted1u6f9L8+SOqJvAxs1bMGwzD0viCsVpvvNAyEpzG8k1e?=
 =?us-ascii?Q?tunqTEfneXKc3LWfQSR8VQmoJ4zEFgZB+0CR0G5vdxC+TboBNDlFIOWUaxEB?=
 =?us-ascii?Q?hcCJWwBV6x9c1DsOiRDKUDET64c49xVNh75zoBrOGj0+i9+x9w5mY8R9zg+a?=
 =?us-ascii?Q?+J9hi2/UsVfOnnjZ27iFXjLhZR2Bx8wxbcnoFTUuqIWr+hdZnGbPuIxeBPz5?=
 =?us-ascii?Q?j89dCgUtd1j+zHySyc8Q35ts850n6f0x5Retr2kJ8LtwrLFFexBGLNMt78xk?=
 =?us-ascii?Q?4RztEzNjGVJahCQ8wWsSOcO2JnFx5qhceUqv2Mc1Vx6FB5MmJVjRMrx//a+y?=
 =?us-ascii?Q?8jPzudwXERoEzV8JmYpoD5nWaXbHgwK+bQ3mM8V0OKNGRqaPYrcbw1r3HiqN?=
 =?us-ascii?Q?nXvTkgsXUnEvWC8d8chTtdSr8XUcgrcOCfsMQy/xWdTW89/2tO9rR+aiSu3x?=
 =?us-ascii?Q?Nw=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3eaa1d3f-49d2-4ce5-8d81-08db3f71a233
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9563.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Apr 2023 18:29:09.0640
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: BZAj5SrFhssQs2OmG7/MOz+F7SXitJYS3gxG0FUI7WKIlHVFK11Z7kd0Q/aMgsW5ie7YcItv6q3S3+luZWCunhAWc4Xz6YbmAvlBiuMZjqk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBAPR04MB7397
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
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

changes in v3:
	Incorporated review comments

 drivers/crypto/caam/ctrl.c   | 205 +++++++++++++++++++----------------
 drivers/crypto/caam/intern.h |   1 +
 2 files changed, 115 insertions(+), 91 deletions(-)

diff --git a/drivers/crypto/caam/ctrl.c b/drivers/crypto/caam/ctrl.c
index 9c5a035e1b96..7070349943c8 100644
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
@@ -616,10 +615,115 @@ static bool needs_entropy_delay_adjustment(void)
 	return false;
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
+			  (struct caam_perfmon __iomem *)&ctrlpriv->jr[0]->perfmon :
+			  (struct caam_perfmon __iomem *)&ctrl->perfmon;
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
+			if (needs_entropy_delay_adjustment())
+				ent_delay = 12000;
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
+			/*
+			 * Entropy delay is determined via TRNG characterization.
+			 * TRNG characterization is run across different voltages
+			 * and temperatures.
+			 * If worst case value for ent_dly is identified,
+			 * the loop can be skipped for that platform.
+			 */
+			if (needs_entropy_delay_adjustment())
+				break;
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
 /* Probe routine for CAAM top (controller) level */
 static int caam_probe(struct platform_device *pdev)
 {
-	int ret, ring, gen_sk, ent_delay = RTSDCTL_ENT_DLY_MIN;
+	int ret, ring;
 	u64 caam_id;
 	const struct soc_device_attribute *imx_soc_match;
 	struct device *dev;
@@ -629,10 +733,8 @@ static int caam_probe(struct platform_device *pdev)
 	struct caam_perfmon __iomem *perfmon;
 	struct dentry *dfs_root;
 	u32 scfgr, comp_params;
-	u8 rng_vid;
 	int pg_size;
 	int BLOCK_OFFSET = 0;
-	bool pr_support = false;
 	bool reg_access = true;
 
 	ctrlpriv = devm_kzalloc(&pdev->dev, sizeof(*ctrlpriv), GFP_KERNEL);
@@ -768,7 +870,8 @@ static int caam_probe(struct platform_device *pdev)
 
 		mc_version = fsl_mc_get_version();
 		if (mc_version)
-			pr_support = check_version(mc_version, 10, 20, 0);
+			ctrlpriv->pr_support = check_version(mc_version, 10, 20,
+							     0);
 		else
 			return -EPROBE_DEFER;
 	}
@@ -859,9 +962,6 @@ static int caam_probe(struct platform_device *pdev)
 		return -ENOMEM;
 	}
 
-	if (!reg_access)
-		goto report_live;
-
 	comp_params = rd_reg32(&perfmon->comp_parms_ls);
 	ctrlpriv->blob_present = !!(comp_params & CTPR_LS_BLOB);
 
@@ -871,8 +971,6 @@ static int caam_probe(struct platform_device *pdev)
 	 * check both here.
 	 */
 	if (ctrlpriv->era < 10) {
-		rng_vid = (rd_reg32(&perfmon->cha_id_ls) &
-			   CHA_ID_LS_RNG_MASK) >> CHA_ID_LS_RNG_SHIFT;
 		ctrlpriv->blob_present = ctrlpriv->blob_present &&
 			(rd_reg32(&perfmon->cha_num_ls) & CHA_ID_LS_AES_MASK);
 	} else {
@@ -882,91 +980,16 @@ static int caam_probe(struct platform_device *pdev)
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

