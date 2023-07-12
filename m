Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3FBD174FF09
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jul 2023 08:08:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231981AbjGLGIG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Jul 2023 02:08:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52750 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229512AbjGLGH7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jul 2023 02:07:59 -0400
Received: from EUR02-VI1-obe.outbound.protection.outlook.com (mail-vi1eur02on2049.outbound.protection.outlook.com [40.107.241.49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 19D3012A;
        Tue, 11 Jul 2023 23:07:57 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DQQMPMezG0EFjb26y3O42D+oH+HjV/G8sLpaRZ0Gw/+OaEFCX5fEjMLf3sQN1E7UnF/dsi5piGvqCN1awRF+gs7H+fas4yDT4R6TVZskJRvnAWH1HPSQpK3yXhscCmVmXluM3ZYjf7/PN4+1EUMOvvV4FAsleJ8XWfg7nODZkVMyyP6j/bY1cRBACSVcgVggBbE7IaHOpYksbc/Fi0LyXq9fiPkWo3hIv3VdlCMCerezS8qWB6mTgz6x6m0qo+1lfqEPQVFj5WvF+QUkr8io6Rn/PU152VRBDZFyhqp3tsnepKyPmzViPY+lWcnsQsAHYQYWaGYiljwr9NRICzoU2w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=g6W9t4nOlz1eoOehogaf2YHBTIeCyNSmO5U4WG/4EpM=;
 b=Z0vU4Y/ny/KowF2bhUIfaNptvfZ76J+76EZxTEaVJITuWO/mwbiXxUWHQNphcqXo5X/69HgD3rUSFuMc3WRnCbmjnZ8fPqnSEzNW8eeY8NbNfEj2SfTFiiusu5z0VD+yr7QjqXFjy+HhPWP1kfUsm6OydwhAa82wSQvQU48CN4AxPNB2fXam7GqfVur6iNlUjZiJgyEO00k9qgRX0PKhPBKL5/xMptI/c5EWhfD+nUSMwuGhgIHGn6UO1oAYXqgm2NyvJ6iSAyTSEoWAek8RxixBlTAjNrG21/FDvXrKW8l5fGU8FdrxnHksd5Mezp48OqfeWPEQvGGxDpTRb/soKQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=g6W9t4nOlz1eoOehogaf2YHBTIeCyNSmO5U4WG/4EpM=;
 b=AP5k8w5+NLgsrOmA9oEVBUamu22ElyH8VIbCafutcdrUymXcERxsdCuVz66wcnJYZydsyCM0Dl3U1v98x8TKQGDJ15JSmt/Cg9VS78Pmpf+nN7TsmPtIzD7qWZe5hXbU++XibTzssG8IEokFZq3wt4b5vOYBODCQ32GU2j03OOc=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from DU0PR04MB9563.eurprd04.prod.outlook.com (2603:10a6:10:314::7)
 by AM8PR04MB8018.eurprd04.prod.outlook.com (2603:10a6:20b:236::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6565.32; Wed, 12 Jul
 2023 06:07:53 +0000
Received: from DU0PR04MB9563.eurprd04.prod.outlook.com
 ([fe80::adc3:90c7:4b37:392c]) by DU0PR04MB9563.eurprd04.prod.outlook.com
 ([fe80::adc3:90c7:4b37:392c%5]) with mapi id 15.20.6588.017; Wed, 12 Jul 2023
 06:07:53 +0000
From:   meenakshi.aggarwal@nxp.com
To:     horia.geanta@nxp.com, V.sethi@nxp.com, pankaj.gupta@nxp.com,
        gaurav.jain@nxp.com, herbert@gondor.apana.org.au,
        davem@davemloft.net, linux-crypto@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Victoria Milhoan <vicki.milhoan@freescale.com>,
        Dan Douglass <dan.douglass@nxp.com>,
        Vipul Kumar <vipul_kumar@mentor.com>,
        Franck LENORMAND <franck.lenormand@nxp.com>,
        Meenakshi Aggarwal <meenakshi.aggarwal@nxp.com>
Subject: [PATCH 2/2] crypto: caam - add power management support
Date:   Wed, 12 Jul 2023 08:07:28 +0200
Message-Id: <20230712060728.3562376-3-meenakshi.aggarwal@nxp.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230712060728.3562376-1-meenakshi.aggarwal@nxp.com>
References: <20230712060728.3562376-1-meenakshi.aggarwal@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AM0PR03CA0075.eurprd03.prod.outlook.com
 (2603:10a6:208:69::16) To DU0PR04MB9563.eurprd04.prod.outlook.com
 (2603:10a6:10:314::7)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU0PR04MB9563:EE_|AM8PR04MB8018:EE_
X-MS-Office365-Filtering-Correlation-Id: a518dbc7-88c8-4f48-e2a2-08db829e5470
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: DGyEqrCvbgfyGaSCbJ23rkSoUddI+5UJHe3o4eOP9W9sNRpYcm4FgogNgN1twXkeZwuikBB9ERGjJJ5y6MdbnYPr7A01Fh29IGeTHgoLY+OjZy1+CwxAh3DchgDcbmjKw9VVGRrWlgqqHMTHRW3IroI5MX0mAQplN59ZAsDdxRlIohOOkQ9/nwPgW3ZYJptWj5CKp3InlGzh7+LJyU/Kfgw4zCywjAjk6+wa93dY1by+i10RHrS86oOniaiVLq+3lmxukQKMrqn9tysRdL3GMCPHhdvE3944UZsnOxzBEK5pAnoe4cHFqxiQqbO1PNTwwWoH+r5hmzxUTYbZJyNITIMA+oMRrSf6mEolTPXYgXLr5T/IUZI/7MRqplYGohZ6DerZxcy+Db8aZKY01GZin22lzJ5TjvA3JmT2mV3Nw7aq5x//2/jKnDoxxdoBWL+gnhlsDuIeQ7krz8kfFDDJOFp4CaF2iUjIx2W740XiVls4fty6fLfdcZaNQuy6/sKcSDOk54nTGQTpyv6jbDSGPzhygptCvCxkNdFYKtUYmyKZ+FUTdIFXACh98jF+JI4uKYRYN7h5g0E5vp0GKuBB3yTtUpcqBJV1QroAfgleg8cazmg+P4j+2AmLV0voSAFJ
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9563.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(396003)(376002)(366004)(39860400002)(136003)(346002)(451199021)(83380400001)(30864003)(2906002)(2616005)(36756003)(86362001)(38350700002)(38100700002)(41300700001)(52116002)(4326008)(6486002)(6512007)(316002)(5660300002)(8936002)(8676002)(478600001)(66476007)(66946007)(66556008)(54906003)(6666004)(26005)(186003)(6506007)(1076003)(9686003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?shGuxMCuXIa9x2t9jumHzLdBnbon+1dvckoHAMAaGzmgxYvJSvKfo4w3g9+U?=
 =?us-ascii?Q?S9M2MbI4nBryxKuTIIdZeD2yWUApEgaBE1Z3iBHZ93M1Y97slCZs9dqz48zU?=
 =?us-ascii?Q?cTieUgY6AVSTkdqHif03suZzbXFeQyVbGEZn6PZldlaUEeGlUBrYs2fm8sHa?=
 =?us-ascii?Q?J6t7Hz/y+1GQg/DLmg7lrYddHYZHbUQmpnlLJ+7MPVKFRY6oZknVuURekODi?=
 =?us-ascii?Q?aftdWxPfQzWAlMGI27D079lK1XpAT17vhwQCzTveAX8KvrZ/DDsy8m1dsqp5?=
 =?us-ascii?Q?UQAfaaB33sjlM7dAW7x5EQ3EWneHZDik33nFJ1RTqLbGqWaKW640C8uhFqhI?=
 =?us-ascii?Q?GBh65cW2Z63Fjtobqwx7TC7eEJfB3m8PYdjHGUTCDG+7MYfWg8gG1mImlWi6?=
 =?us-ascii?Q?dIT/mzSSDq/vdIiKxmE4+eblMIO6Fkb8JaF95KC9qgnhKvquBnWEHiJAfRNg?=
 =?us-ascii?Q?HTImq8H7cSQ7ibDwD5WwHwtBYGmL1hhUW2VwdRGZjC6VpUODFDqaUsc3ZdYD?=
 =?us-ascii?Q?2QHYavjzicUP50TihM8srjWi9ynjvq44eIcNxu13We0idrY410aKUs5/Ku+H?=
 =?us-ascii?Q?6rD5rzAQZ/90jFz49G+Na4xWmhAjQeWPAYkh1PR0GkE9f06Vu81XeljmrqBI?=
 =?us-ascii?Q?11QOU1mPJ5pTl+qSMdAg6ev8wt1KREH4jKGa8flNlc54RoTwFRpfIrDYt4LK?=
 =?us-ascii?Q?EQZf8WXKlo+4z5pgFXfYSMd8heVNj86CjZwZz4oFFcsklbWTlduvAKnJ8YgE?=
 =?us-ascii?Q?oZmmwMh7A76w3ntWr6dqUu5zt0wu7YfgS1I0QbT/zEAkISslXDrsicrgP/Sq?=
 =?us-ascii?Q?8/Cw/OONvscG9Vel+GLCWB1FrtFL16cmA9TPtA2TFKx4jw+YHUuyW7mSLZ1V?=
 =?us-ascii?Q?XcSX7jkfJvD9bdoM9mH4pCOtJG91kdqRGiJuhCQ2V3YKvL1DbL7p16X1ESvk?=
 =?us-ascii?Q?3EormN4F57gk39TwYj5wxsIRDbG5Q6bXOuFwWu6sl253RlcZhNBOPHJvhnV3?=
 =?us-ascii?Q?xWXCSy3VQsg3lU6vcRsiIpZ4vUekg9IzLjNY5YDqrPPteKW+AhUC8qdS7697?=
 =?us-ascii?Q?1nqkMo3lyn4epzKPi1PkM0SbL2TwVCVBS6Y0t03H+b/L/l0oqBxlu89yMsxQ?=
 =?us-ascii?Q?D/g76cx+B+y501HlUUT/7gbfopKqu5dCJKhVVUCqpxNjaNRwkb+uCaHbUuu/?=
 =?us-ascii?Q?98IcMXOjkllGfKoNm0jsOpBnTsnrV955X2LTzTw3y8wBRnwyHp8pxXsazzDi?=
 =?us-ascii?Q?jYBhLo9aZg0EZo6GvWdkWkdN+lYppwPWcsoWQCKyp55AhEww9RJGGZijx1Bp?=
 =?us-ascii?Q?kmd0EiNQ9UbRPubE6CtgaKAZm3lgYJRnLvLwm9d7PXTGgesgvn21dubG7rMA?=
 =?us-ascii?Q?GCUZb6ZUFI81o8bBn9LOdPR3qmM9L5fBCXYpOeRjAOy5VnhjvgP7xKCE8+iJ?=
 =?us-ascii?Q?+2dWJVBhANrLQcxB5C+OQVoQeY7xzyiR3sfb3V6TIaroxsiKBbL2QMsa+B+O?=
 =?us-ascii?Q?/EuLDIdKVy6M8dB/jmz070tHMcyEMKsxN7gOtoRD/CNSZg2oct7ngvyBt/wY?=
 =?us-ascii?Q?Mqx955aPLIwh8UIFqDU1YZKfqLsPlEaFf6VDsNCduDcMOFL9VqncCO2NnwdL?=
 =?us-ascii?Q?wA=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a518dbc7-88c8-4f48-e2a2-08db829e5470
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9563.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jul 2023 06:07:53.7557
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: L5A+6vZVkgLIli+15V7GYroi/NIHULbgkUtTaXoYvFdlbJ1LU4f/yesaGYm6FEeu1B7C02XPsPO0JSq8iTZ3tNnaOVQopu2u0emI1J3lVh4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM8PR04MB8018
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Horia Geanta <horia.geanta@nxp.com>

Add support for suspend and resume operation for PM in CAAM driver.

When the CAAM goes in suspend, the hardware is considered to do nothing.

On some platforms, the power of the CAAM is not turned off so it keeps
its configuration.
On other platforms, it doesn't so it is necessary to save the state of
the CAAM:
 - JRs MID
 - Address of input and output rings

Signed-off-by: Horia Geanta <horia.geanta@nxp.com>
Signed-off-by: Victoria Milhoan <vicki.milhoan@freescale.com>
Signed-off-by: Dan Douglass <dan.douglass@nxp.com>
Signed-off-by: Vipul Kumar <vipul_kumar@mentor.com>
Signed-off-by: Franck LENORMAND <franck.lenormand@nxp.com>
Signed-off-by: Meenakshi Aggarwal <meenakshi.aggarwal@nxp.com>
---
 drivers/crypto/caam/ctrl.c   | 114 ++++++++++++++++++++
 drivers/crypto/caam/intern.h |  33 +++++-
 drivers/crypto/caam/jr.c     | 199 +++++++++++++++++++++++++++++++----
 drivers/crypto/caam/regs.h   |   3 +-
 4 files changed, 328 insertions(+), 21 deletions(-)

diff --git a/drivers/crypto/caam/ctrl.c b/drivers/crypto/caam/ctrl.c
index ff9ddbbca377..64b6cd09d8a8 100644
--- a/drivers/crypto/caam/ctrl.c
+++ b/drivers/crypto/caam/ctrl.c
@@ -740,6 +740,113 @@ static int caam_ctrl_rng_init(struct device *dev)
 	return 0;
 }
 
+#ifdef CONFIG_PM_SLEEP
+
+/* Indicate if the internal state of the CAAM is lost during PM */
+static int caam_off_during_pm(void)
+{
+	bool not_off_during_pm = of_machine_is_compatible("fsl,imx6q") ||
+				 of_machine_is_compatible("fsl,imx6qp") ||
+				 of_machine_is_compatible("fsl,imx6dl");
+
+	return not_off_during_pm ? 0 : 1;
+}
+
+static void caam_state_save(struct device *dev)
+{
+	struct caam_drv_private *ctrlpriv = dev_get_drvdata(dev);
+	struct caam_ctl_state *state = &ctrlpriv->state;
+	struct caam_ctrl __iomem *ctrl = ctrlpriv->ctrl;
+	u32 deco_inst, jr_inst;
+	int i;
+
+	state->mcr = rd_reg32(&ctrl->mcr);
+	state->scfgr = rd_reg32(&ctrl->scfgr);
+
+	deco_inst = (rd_reg32(&ctrl->perfmon.cha_num_ms) &
+		     CHA_ID_MS_DECO_MASK) >> CHA_ID_MS_DECO_SHIFT;
+	for (i = 0; i < deco_inst; i++) {
+		state->deco_mid[i].liodn_ms =
+			rd_reg32(&ctrl->deco_mid[i].liodn_ms);
+		state->deco_mid[i].liodn_ls =
+			rd_reg32(&ctrl->deco_mid[i].liodn_ls);
+	}
+
+	jr_inst = (rd_reg32(&ctrl->perfmon.cha_num_ms) &
+		   CHA_ID_MS_JR_MASK) >> CHA_ID_MS_JR_SHIFT;
+	for (i = 0; i < jr_inst; i++) {
+		state->jr_mid[i].liodn_ms =
+			rd_reg32(&ctrl->jr_mid[i].liodn_ms);
+		state->jr_mid[i].liodn_ls =
+			rd_reg32(&ctrl->jr_mid[i].liodn_ls);
+	}
+}
+
+static void caam_state_restore(const struct device *dev)
+{
+	const struct caam_drv_private *ctrlpriv = dev_get_drvdata(dev);
+	const struct caam_ctl_state *state = &ctrlpriv->state;
+	struct caam_ctrl __iomem *ctrl = ctrlpriv->ctrl;
+	u32 deco_inst, jr_inst;
+	int i;
+
+	wr_reg32(&ctrl->mcr, state->mcr);
+	wr_reg32(&ctrl->scfgr, state->scfgr);
+
+	deco_inst = (rd_reg32(&ctrl->perfmon.cha_num_ms) &
+		     CHA_ID_MS_DECO_MASK) >> CHA_ID_MS_DECO_SHIFT;
+	for (i = 0; i < deco_inst; i++) {
+		wr_reg32(&ctrl->deco_mid[i].liodn_ms,
+			 state->deco_mid[i].liodn_ms);
+		wr_reg32(&ctrl->deco_mid[i].liodn_ls,
+			 state->deco_mid[i].liodn_ls);
+	}
+
+	jr_inst = (rd_reg32(&ctrl->perfmon.cha_num_ms) &
+		   CHA_ID_MS_JR_MASK) >> CHA_ID_MS_JR_SHIFT;
+	for (i = 0; i < jr_inst; i++) {
+		wr_reg32(&ctrl->jr_mid[i].liodn_ms,
+			 state->jr_mid[i].liodn_ms);
+		wr_reg32(&ctrl->jr_mid[i].liodn_ls,
+			 state->jr_mid[i].liodn_ls);
+	}
+
+	if (ctrlpriv->virt_en == 1)
+		clrsetbits_32(&ctrl->jrstart, 0, JRSTART_JR0_START |
+			      JRSTART_JR1_START | JRSTART_JR2_START |
+			      JRSTART_JR3_START);
+}
+
+static int caam_ctrl_suspend(struct device *dev)
+{
+	const struct caam_drv_private *ctrlpriv = dev_get_drvdata(dev);
+
+	if (ctrlpriv->caam_off_during_pm && !ctrlpriv->optee_en)
+		caam_state_save(dev);
+
+	return 0;
+}
+
+static int caam_ctrl_resume(struct device *dev)
+{
+	struct caam_drv_private *ctrlpriv = dev_get_drvdata(dev);
+	int ret = 0;
+
+	if (ctrlpriv->caam_off_during_pm && !ctrlpriv->optee_en) {
+		caam_state_restore(dev);
+
+		/* HW and rng will be reset so deinstantiation can be removed */
+		devm_remove_action(dev, devm_deinstantiate_rng, dev);
+		ret = caam_ctrl_rng_init(dev);
+	}
+
+	return ret;
+}
+
+static SIMPLE_DEV_PM_OPS(caam_ctrl_pm_ops, caam_ctrl_suspend, caam_ctrl_resume);
+
+#endif /* CONFIG_PM_SLEEP */
+
 /* Probe routine for CAAM top (controller) level */
 static int caam_probe(struct platform_device *pdev)
 {
@@ -771,6 +878,10 @@ static int caam_probe(struct platform_device *pdev)
 
 	caam_imx = (bool)imx_soc_match;
 
+#ifdef CONFIG_PM_SLEEP
+	ctrlpriv->caam_off_during_pm = caam_imx && caam_off_during_pm();
+#endif
+
 	if (imx_soc_match) {
 		/*
 		 * Until Layerscape and i.MX OP-TEE get in sync,
@@ -1033,6 +1144,9 @@ static struct platform_driver caam_driver = {
 	.driver = {
 		.name = "caam",
 		.of_match_table = caam_match,
+#ifdef CONFIG_PM_SLEEP
+		.pm = &caam_ctrl_pm_ops,
+#endif
 	},
 	.probe       = caam_probe,
 };
diff --git a/drivers/crypto/caam/intern.h b/drivers/crypto/caam/intern.h
index b4f7bf77f487..fcf0a080b5d6 100644
--- a/drivers/crypto/caam/intern.h
+++ b/drivers/crypto/caam/intern.h
@@ -4,7 +4,7 @@
  * Private/internal definitions between modules
  *
  * Copyright 2008-2011 Freescale Semiconductor, Inc.
- * Copyright 2019 NXP
+ * Copyright 2019, 2023 NXP
  */
 
 #ifndef INTERN_H
@@ -47,6 +47,18 @@ struct caam_jrentry_info {
 	u32 desc_size;	/* Stored size for postprocessing, header derived */
 };
 
+#ifdef CONFIG_PM_SLEEP
+struct caam_jr_state {
+	dma_addr_t inpbusaddr;
+	dma_addr_t outbusaddr;
+};
+#endif
+
+struct caam_jr_dequeue_params {
+	struct device *dev;
+	int enable_itr;
+};
+
 /* Private sub-storage for a single JobR */
 struct caam_drv_private_jr {
 	struct list_head	list_node;	/* Job Ring device list */
@@ -54,6 +66,7 @@ struct caam_drv_private_jr {
 	int ridx;
 	struct caam_job_ring __iomem *rregs;	/* JobR's register space */
 	struct tasklet_struct irqtask;
+	struct caam_jr_dequeue_params tasklet_params;
 	int irq;			/* One per queue */
 	bool hwrng;
 
@@ -71,7 +84,20 @@ struct caam_drv_private_jr {
 	int tail;			/* entinfo (s/w ring) tail index */
 	void *outring;			/* Base of output ring, DMA-safe */
 	struct crypto_engine *engine;
+
+#ifdef CONFIG_PM_SLEEP
+	struct caam_jr_state state;	/* State of the JR during PM */
+#endif
+};
+
+#ifdef CONFIG_PM_SLEEP
+struct caam_ctl_state {
+	struct masterid deco_mid[16];
+	struct masterid jr_mid[4];
+	u32 mcr;
+	u32 scfgr;
 };
+#endif
 
 /*
  * Driver-private storage for a single CAAM block instance
@@ -116,6 +142,11 @@ struct caam_drv_private {
 	struct dentry *ctl; /* controller dir */
 	struct debugfs_blob_wrapper ctl_kek_wrap, ctl_tkek_wrap, ctl_tdsk_wrap;
 #endif
+
+#ifdef CONFIG_PM_SLEEP
+	int caam_off_during_pm;		/* If the CAAM is reset after suspend */
+	struct caam_ctl_state state;	/* State of the CTL during PM */
+#endif
 };
 
 #ifdef CONFIG_CRYPTO_DEV_FSL_CAAM_CRYPTO_API
diff --git a/drivers/crypto/caam/jr.c b/drivers/crypto/caam/jr.c
index 96dea5304d22..1801638eb1c8 100644
--- a/drivers/crypto/caam/jr.c
+++ b/drivers/crypto/caam/jr.c
@@ -117,6 +117,25 @@ static int caam_jr_flush(struct device *dev)
 	return caam_jr_stop_processing(dev, JRCR_RESET);
 }
 
+#ifdef CONFIG_PM_SLEEP
+/* The resume can be used after a park or a flush if CAAM has not been reset */
+static int caam_jr_restart_processing(struct device *dev)
+{
+	struct caam_drv_private_jr *jrp = dev_get_drvdata(dev);
+	u32 halt_status = rd_reg32(&jrp->rregs->jrintstatus) &
+			  JRINT_ERR_HALT_MASK;
+
+	/* Check that the flush/park is completed */
+	if (halt_status != JRINT_ERR_HALT_COMPLETE)
+		return -1;
+
+	/* Resume processing of jobs */
+	clrsetbits_32(&jrp->rregs->jrintstatus, 0, JRINT_ERR_HALT_COMPLETE);
+
+	return 0;
+}
+#endif /* CONFIG_PM_SLEEP */
+
 static int caam_reset_hw_jr(struct device *dev)
 {
 	struct caam_drv_private_jr *jrp = dev_get_drvdata(dev);
@@ -245,7 +264,8 @@ static irqreturn_t caam_jr_interrupt(int irq, void *st_dev)
 static void caam_jr_dequeue(unsigned long devarg)
 {
 	int hw_idx, sw_idx, i, head, tail;
-	struct device *dev = (struct device *)devarg;
+	struct caam_jr_dequeue_params *params = (void *)devarg;
+	struct device *dev = params->dev;
 	struct caam_drv_private_jr *jrp = dev_get_drvdata(dev);
 	void (*usercall)(struct device *dev, u32 *desc, u32 status, void *arg);
 	u32 *userdesc, userstatus;
@@ -319,8 +339,9 @@ static void caam_jr_dequeue(unsigned long devarg)
 		outring_used--;
 	}
 
-	/* reenable / unmask IRQs */
-	clrsetbits_32(&jrp->rregs->rconfig_lo, JRCFG_IMSK, 0);
+	if (params->enable_itr)
+		/* reenable / unmask IRQs */
+		clrsetbits_32(&jrp->rregs->rconfig_lo, JRCFG_IMSK, 0);
 }
 
 /**
@@ -470,6 +491,29 @@ int caam_jr_enqueue(struct device *dev, u32 *desc,
 }
 EXPORT_SYMBOL(caam_jr_enqueue);
 
+static void caam_jr_init_hw(struct device *dev, dma_addr_t inpbusaddr,
+			    dma_addr_t outbusaddr)
+{
+	struct caam_drv_private_jr *jrp = dev_get_drvdata(dev);
+
+	wr_reg64(&jrp->rregs->inpring_base, inpbusaddr);
+	wr_reg64(&jrp->rregs->outring_base, outbusaddr);
+	wr_reg32(&jrp->rregs->inpring_size, JOBR_DEPTH);
+	wr_reg32(&jrp->rregs->outring_size, JOBR_DEPTH);
+
+	/* Select interrupt coalescing parameters */
+	clrsetbits_32(&jrp->rregs->rconfig_lo, 0, JOBR_INTC |
+		      (JOBR_INTC_COUNT_THLD << JRCFG_ICDCT_SHIFT) |
+		      (JOBR_INTC_TIME_THLD << JRCFG_ICTT_SHIFT));
+}
+
+static void caam_jr_reset_index(struct caam_drv_private_jr *jrp)
+{
+	jrp->out_ring_read_index = 0;
+	jrp->head = 0;
+	jrp->tail = 0;
+}
+
 /*
  * Init JobR independent of platform property detection
  */
@@ -506,25 +550,16 @@ static int caam_jr_init(struct device *dev)
 		jrp->entinfo[i].desc_addr_dma = !0;
 
 	/* Setup rings */
-	jrp->out_ring_read_index = 0;
-	jrp->head = 0;
-	jrp->tail = 0;
-
-	wr_reg64(&jrp->rregs->inpring_base, inpbusaddr);
-	wr_reg64(&jrp->rregs->outring_base, outbusaddr);
-	wr_reg32(&jrp->rregs->inpring_size, JOBR_DEPTH);
-	wr_reg32(&jrp->rregs->outring_size, JOBR_DEPTH);
-
+	caam_jr_reset_index(jrp);
 	jrp->inpring_avail = JOBR_DEPTH;
+	caam_jr_init_hw(dev, inpbusaddr, outbusaddr);
 
 	spin_lock_init(&jrp->inplock);
 
-	/* Select interrupt coalescing parameters */
-	clrsetbits_32(&jrp->rregs->rconfig_lo, 0, JOBR_INTC |
-		      (JOBR_INTC_COUNT_THLD << JRCFG_ICDCT_SHIFT) |
-		      (JOBR_INTC_TIME_THLD << JRCFG_ICTT_SHIFT));
-
-	tasklet_init(&jrp->irqtask, caam_jr_dequeue, (unsigned long)dev);
+	jrp->tasklet_params.dev = dev;
+	jrp->tasklet_params.enable_itr = 1;
+	tasklet_init(&jrp->irqtask, caam_jr_dequeue,
+		     (unsigned long)&jrp->tasklet_params);
 
 	/* Connect job ring interrupt handler. */
 	error = devm_request_irq(dev, jrp->irq, caam_jr_interrupt, IRQF_SHARED,
@@ -635,11 +670,136 @@ static int caam_jr_probe(struct platform_device *pdev)
 
 	atomic_set(&jrpriv->tfm_count, 0);
 
+	device_init_wakeup(&pdev->dev, 1);
+	device_set_wakeup_enable(&pdev->dev, false);
+
 	register_algs(jrpriv, jrdev->parent);
 
 	return 0;
 }
 
+#ifdef CONFIG_PM_SLEEP
+static void caam_jr_get_hw_state(struct device *dev)
+{
+	struct caam_drv_private_jr *jrp = dev_get_drvdata(dev);
+
+	jrp->state.inpbusaddr = rd_reg64(&jrp->rregs->inpring_base);
+	jrp->state.outbusaddr = rd_reg64(&jrp->rregs->outring_base);
+}
+
+static int caam_jr_suspend(struct device *dev)
+{
+	struct platform_device *pdev = to_platform_device(dev);
+	struct caam_drv_private_jr *jrpriv = platform_get_drvdata(pdev);
+	struct caam_drv_private *ctrlpriv = dev_get_drvdata(dev->parent);
+	struct caam_jr_dequeue_params suspend_params = {
+		.dev = dev,
+		.enable_itr = 0,
+	};
+
+	/* Remove the node from Physical JobR list maintained by driver */
+	spin_lock(&driver_data.jr_alloc_lock);
+	list_del(&jrpriv->list_node);
+	spin_unlock(&driver_data.jr_alloc_lock);
+
+	if (jrpriv->hwrng)
+		caam_rng_exit(dev->parent);
+
+	if (ctrlpriv->caam_off_during_pm) {
+		int err;
+
+		tasklet_disable(&jrpriv->irqtask);
+
+		/* mask itr to call flush */
+		clrsetbits_32(&jrpriv->rregs->rconfig_lo, 0, JRCFG_IMSK);
+
+		/* Invalid job in process */
+		err = caam_jr_flush(dev);
+		if (err) {
+			dev_err(dev, "Failed to flush\n");
+			return err;
+		}
+
+		/* Dequeing jobs flushed */
+		caam_jr_dequeue((unsigned long)&suspend_params);
+
+		/* Save state */
+		caam_jr_get_hw_state(dev);
+	} else if (device_may_wakeup(&pdev->dev)) {
+		enable_irq_wake(jrpriv->irq);
+	}
+
+	return 0;
+}
+
+static int caam_jr_resume(struct device *dev)
+{
+	struct platform_device *pdev = to_platform_device(dev);
+	struct caam_drv_private_jr *jrpriv = platform_get_drvdata(pdev);
+	struct caam_drv_private *ctrlpriv = dev_get_drvdata(dev->parent);
+
+	if (ctrlpriv->caam_off_during_pm) {
+		u64 inp_addr;
+		int err;
+
+		/*
+		 * Check if the CAAM has been resetted checking the address of
+		 * the input ring
+		 */
+		inp_addr = rd_reg64(&jrpriv->rregs->inpring_base);
+		if (inp_addr != 0) {
+			/* JR still has some configuration */
+			if (inp_addr == jrpriv->state.inpbusaddr) {
+				/* JR has not been resetted */
+				err = caam_jr_restart_processing(dev);
+				if (err) {
+					dev_err(dev,
+						"Restart processing failed\n");
+					return err;
+				}
+
+				tasklet_enable(&jrpriv->irqtask);
+
+				clrsetbits_32(&jrpriv->rregs->rconfig_lo,
+					      JRCFG_IMSK, 0);
+
+				goto add_jr;
+			} else if (ctrlpriv->optee_en) {
+				/* JR has been used by OPTEE, reset it */
+				err = caam_reset_hw_jr(dev);
+				if (err) {
+					dev_err(dev, "Failed to reset JR\n");
+					return err;
+				}
+			} else {
+				/* No explanation, return error */
+				return -EIO;
+			}
+		}
+
+		caam_jr_reset_index(jrpriv);
+		caam_jr_init_hw(dev, jrpriv->state.inpbusaddr,
+				jrpriv->state.outbusaddr);
+
+		tasklet_enable(&jrpriv->irqtask);
+	} else if (device_may_wakeup(&pdev->dev)) {
+		disable_irq_wake(jrpriv->irq);
+	}
+
+add_jr:
+	spin_lock(&driver_data.jr_alloc_lock);
+	list_add_tail(&jrpriv->list_node, &driver_data.jr_list);
+	spin_unlock(&driver_data.jr_alloc_lock);
+
+	if (jrpriv->hwrng)
+		jrpriv->hwrng = !caam_rng_init(dev->parent);
+
+	return 0;
+}
+
+static SIMPLE_DEV_PM_OPS(caam_jr_pm_ops, caam_jr_suspend, caam_jr_resume);
+#endif /* CONFIG_PM_SLEEP */
+
 static const struct of_device_id caam_jr_match[] = {
 	{
 		.compatible = "fsl,sec-v4.0-job-ring",
@@ -655,6 +815,9 @@ static struct platform_driver caam_jr_driver = {
 	.driver = {
 		.name = "caam_jr",
 		.of_match_table = caam_jr_match,
+#ifdef CONFIG_PM_SLEEP
+		.pm = &caam_jr_pm_ops,
+#endif
 	},
 	.probe       = caam_jr_probe,
 	.remove      = caam_jr_remove,
diff --git a/drivers/crypto/caam/regs.h b/drivers/crypto/caam/regs.h
index 0f87bd365582..873df9de9890 100644
--- a/drivers/crypto/caam/regs.h
+++ b/drivers/crypto/caam/regs.h
@@ -584,8 +584,7 @@ struct caam_ctrl {
 	u32 deco_rsr;			/* DECORSR - Deco Request Source */
 	u32 rsvd11;
 	u32 deco_rq;			/* DECORR - DECO Request */
-	struct masterid deco_mid[5];	/* DECOxLIODNR - 1 per DECO */
-	u32 rsvd5[22];
+	struct masterid deco_mid[16];	/* DECOxLIODNR - 1 per DECO */
 
 	/* DECO Availability/Reset Section			120-3ff */
 	u32 deco_avail;		/* DAR - DECO availability */
-- 
2.25.1

