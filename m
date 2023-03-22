Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E32216C42E1
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Mar 2023 07:18:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229975AbjCVGSG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Mar 2023 02:18:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45760 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229968AbjCVGSD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Mar 2023 02:18:03 -0400
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2040.outbound.protection.outlook.com [40.107.21.40])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C64C5B5D5;
        Tue, 21 Mar 2023 23:17:54 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YqnvWurwnBREeVQYuNq1HkvJykgQwpn9GntP131VSBs8c/3Z96yI9b3IsEe9but8EjZ1CD/k2uwx83mO7deYWLlULmJbTPeD0KfchW/0dq0shenY+qiJeGTvWWP7pOEbSubYy/q/m3Y2byKpiPUAjY5JxYHGgFj5HOBV+PljHiZ1UqP9MajGIG8pRM5PCxnpkVufMDtECvcvatTgpJ+BqE8Z2IWjoagvfaO6aY5Mn1e5HCR4HincVe2e6qT9C2/2lx/wgEeU3tMEzXq/HYjbos3Yfcf27W9dpSo3yn1hjKsD+o+EBK1vlfMQ4wP6VBi1cjXcHKDXE+5Z/RJ/FngxNg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NF1bKVyeEcuJi/jVR47Sr22EeG9tC4DjwTNu69dU1/E=;
 b=j5WaOq2g7hgkDjv6fYvLKF31ktOl/nmWx13iFDqA/Qs2e2DIl5DwGOf5FOyS2cMQUo+X2KArN+qKxfvEeb0rfT10YIDkfAbmQP0chbtHUohkTF78WOHp175fYMJsJV+WPaJwFheLuY2eG+7T/8qj8bfOFWlnLpOKPuasrOa+hEDDIK9kA/IKn4OyDp9zrFuazAM5ujMyD6VUiDGFqvV3jxwNuNK9cgntDoWP9wzn+dMICM4YeQyUSVForiyFSEXK8h1JFaf2Wr2Y6vsflRFVLjZid/1DqkAdi05f9LECey1nlhvoHS9dTIHRMsnS8vKQlUiE+mX1+QIwEVTx5zGckA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NF1bKVyeEcuJi/jVR47Sr22EeG9tC4DjwTNu69dU1/E=;
 b=dw8wlNOB9ngSo7hVWEU3iK4St/IyNX7dzOUY5nXrVBr8hWAEZogRBA0YNYZqlp6mGLg7N2l2YESSGguHq35azNlcD2MrzLYq6B9hm1/8cjDF6N90r7wN6vLJ93lobKC+UwtoUbi/y0wVPmD37icAMXCOn+9HRBaKKDkckG/6iXA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from DU0PR04MB9563.eurprd04.prod.outlook.com (2603:10a6:10:314::7)
 by DB8PR04MB7020.eurprd04.prod.outlook.com (2603:10a6:10:126::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.37; Wed, 22 Mar
 2023 06:17:52 +0000
Received: from DU0PR04MB9563.eurprd04.prod.outlook.com
 ([fe80::a518:512c:4af1:276e]) by DU0PR04MB9563.eurprd04.prod.outlook.com
 ([fe80::a518:512c:4af1:276e%6]) with mapi id 15.20.6178.037; Wed, 22 Mar 2023
 06:17:52 +0000
From:   meenakshi.aggarwal@nxp.com
To:     horia.geanta@nxp.com, V.sethi@nxp.com, pankaj.gupta@nxp.com,
        gaurav.jain@nxp.com, herbert@gondor.apana.org.au,
        davem@davemloft.net, linux-crypto@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Meenakshi Aggarwal <meenakshi.aggarwal@nxp.com>
Subject: [PATCH v2 2/2] crypto: caam - OP-TEE firmware support
Date:   Wed, 22 Mar 2023 07:17:16 +0100
Message-Id: <20230322061716.3195841-3-meenakshi.aggarwal@nxp.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230322061716.3195841-1-meenakshi.aggarwal@nxp.com>
References: <20230302062055.1564514-3-meenakshi.aggarwal@nxp.com>
 <20230322061716.3195841-1-meenakshi.aggarwal@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AM6PR04CA0042.eurprd04.prod.outlook.com
 (2603:10a6:20b:f0::19) To DU0PR04MB9563.eurprd04.prod.outlook.com
 (2603:10a6:10:314::7)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU0PR04MB9563:EE_|DB8PR04MB7020:EE_
X-MS-Office365-Filtering-Correlation-Id: 341aa3d6-10b3-4c54-35a9-08db2a9d2abc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 8nBtsgSkSd5xgBQxK/nkAoPGHweJKTRC49g7LkBss1B3cJJaqG4RTGJEkKN3jlm8RJagDxD/r8wO9rchB6exJHaKtCN7ptXOPKNdK0U7SVLGGKljbiJyvc91GZ33vIGpe0LCcLW7L6fI7mh8YuKbNgEmIEc5ZyWVks6iflgTi6/AATIFfdk2n+V8Tu06TxQqpGOBxFzMteuDWn/xs/YuNiXt0g7DRn1JM6XkVEzA3Ifj7Le45dfovFmzWH2Lf1O1ONJY3BoauYVmC7kOlYn2YWFZSKNy770Hm7JPAlPdox2W049I1ljYSK+nr0gszuK9NiU0clRFg7FXQdXk7A/TvqIK3Yjj3NamWPl8ZJEBAVT3fWFXxQI/5QC/YSbfA91ggxmrsAz+wsikiBgB0cgxArj4AV34mUa0XyNrtea8NU0ULnvykrqFESYO2WpOd5aQ2OfOHLHiBfeakyLf9jr8zaG5YGdpWzblRJfsuLfxXbTKmchPzgu8neX6c9y/VLDGTrU7n3q8MkWUG3+k1nBL5VTM6jxQHULY7VEkv07T29RdHtcw4Z0LHmc3+f/HGPm5ctVMUzYlrAlbmaruwdzz/7QjkoIwMtTp16A2y6CJ8G8w9Qpo6iYbfPgVCTDO5O1X3or/RL+I8SIZxT1gRfw2HSQPLvFCGroDW3lLa7H6Ch59GqXTDfHFwefi4WDOIuYgSX0Cu4IrV8U42rtjraVv2nqf+NRDFcL/zxp+JPbb+dY=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9563.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(376002)(136003)(366004)(39860400002)(396003)(346002)(451199018)(6512007)(2616005)(83380400001)(478600001)(6486002)(26005)(186003)(6506007)(9686003)(1076003)(8936002)(6666004)(316002)(66556008)(52116002)(66476007)(86362001)(38350700002)(38100700002)(2906002)(5660300002)(4326008)(66946007)(8676002)(36756003)(41300700001)(309714004);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?aQxd6U+WUoWqeB1AVwMjYs4H0QijfeOwrBeEYzpfaO2iaALnwgo1j4Ku8vSO?=
 =?us-ascii?Q?g4mXd4gyO71MKlEpny3+INhbYu4t2oIjWkGejyCyS1H43/819JP0o6FfZayr?=
 =?us-ascii?Q?yRnyj2m0pusu5e073D/nFPh5yQpM5fTzCexl0OEW7j+0ubwM6dvjNB+FBgy0?=
 =?us-ascii?Q?pJseN8wFnhWZ8vm3ZQFNUH0F1hFfn9944SNpCkzTAwdSTt9/gdo2C3ZdIGOp?=
 =?us-ascii?Q?OrGL/Q3A5pgI+dKS2d+IywmpsUC1HJR1qjq3nBmhI3VTlW2oTDb/3F86qv+T?=
 =?us-ascii?Q?SEW+9nPey0/JgfZTCtPQNTDfZtvXcvRVzdm/SqiEgWSM7OX7e1hfvfQThS13?=
 =?us-ascii?Q?E2JbWIYI0uVLNzk6ZJBAQDGevVofvH2l2EsBFmyjVLDCm/R3kCi+fE2588rQ?=
 =?us-ascii?Q?hajJbq4dgOBFix26DYqDL4ElQTwzRsL5lYgWrBIsIyLuPNVQreCmcjZH/6P+?=
 =?us-ascii?Q?GOL87HREaKV1o/DJBpWOHLe8TqM905KLdf8gndHR1prVlLOo5qB+k0O8L50M?=
 =?us-ascii?Q?83sL52+pXnFg+LAAUUxXoSRWlscWuZIgptkmy7kxRuzfty8nImY/EfLHGSqn?=
 =?us-ascii?Q?ohVNPeaus6WZ1iIsqFDxOmnfkmd/MLMKtXBxwKlV/W0ezpLXoAqxQi6KiQTT?=
 =?us-ascii?Q?sL8HT2yJOPlUSCoaSXv8TzNRm8leAgWlk+pWUiHFlsnauG6LMV/wl+o9TJCE?=
 =?us-ascii?Q?4TJGMmpffufmRaTmEWUzPZVzHTc9xRE6U3kR1tsIpkCxsGCbgwCy5BTWcmu0?=
 =?us-ascii?Q?m2rBpSehWtO6M7MPaOK/rgnCDbZJlGiPV9f9KaLbyqEhlwpLqADAbUVs9/r+?=
 =?us-ascii?Q?5FiAefs9XGhujxGGGDWdUIgXzVYQqdijM0RC+5mbcHe2YbJIh2y/PVOkzvVN?=
 =?us-ascii?Q?uRTMHXooURMSOOh6vCI5TBAeXRAkbIMkPyc4V7fOYJxT7drorme3jbfPPGMP?=
 =?us-ascii?Q?xa8iHoz2MPwH9pTWb2B+7DJ9fi1KXkduDjtLrw+xJLjCXGXtqvu2wrgsiCzu?=
 =?us-ascii?Q?nYiwzRVTep0aNSqgtWQMiqSmXqByKDLUOPq8WXWnG2Mjr44xiqNxvx1F97Fq?=
 =?us-ascii?Q?9s/6YVJ+8az3JV6b1Y82ENRT1ys0W+7FXc+/S9IjE8EICN69g8aLkIMoxqiF?=
 =?us-ascii?Q?UW//++79COApvR7s6gfDFnQxtlUmYJBEhzR3HEsshF7qpjJ4utE0/KPboUZB?=
 =?us-ascii?Q?P2itWH+Z2ZltwZd9BXyJyAMArW8axZgSA7tdJalSUrLBG85y+CPDn8iPUp8o?=
 =?us-ascii?Q?SUsN3hhVR1CIDnUXPD8Axgce5WjplmChfPbCguZoHSAR45HOZZgKNvl5dadQ?=
 =?us-ascii?Q?dNnC9Ta7i1sKOIjk1/jBgkf5os/lLoHmR5kkbPbY6mF+xS7xAG3tF8p0uv9l?=
 =?us-ascii?Q?v7jG68OAKf936vucf3QpopXRvViGb2bQiQfxcn5HoZ/4fYXRwMZMoJo1HGAp?=
 =?us-ascii?Q?FGhgbkec7/9d9Y9m3WNA0ggSc9fZlSm9wZ2m47RmUXVYrIEqYMpqvZCwiUSK?=
 =?us-ascii?Q?r64VdAEZMlZhD/6rInXmtg+InqbI/uZY//yBlniS/hxpLri4wySTJ71eWyTp?=
 =?us-ascii?Q?kqs6+dk12Pf0DkAGuZ4yzhDWXrSzJJu8SAQ8vrvWuLtqZynBbq2ZkWSEB4X+?=
 =?us-ascii?Q?fQ=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 341aa3d6-10b3-4c54-35a9-08db2a9d2abc
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9563.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Mar 2023 06:17:52.1078
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: LT9d2zTkCXtjKBKf+gMFskFepjlPWfXx8AVXyDk/rHNiE81r8d6oyM5mij7LJglxF5F5OP2+I6Z0dwqvuTL2vKnBf7aLC+G9Hwc8P7sWZ+w=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR04MB7020
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_PASS,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
        autolearn_force=no version=3.4.6
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
index ae07c1e5fd38..d96c81540957 100644
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
+		reg_access = ctrlpriv->optee_en;
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
 
@@ -943,6 +963,7 @@ static int caam_probe(struct platform_device *pdev)
 		clrsetbits_32(&ctrl->scfgr, 0, SCFGR_RDBENABLE);
 	}
 
+report_live:
 	/* NOTE: RTIC detection ought to go here, around Si time */
 
 	caam_id = (u64)rd_reg32(&perfmon->caam_id_ms) << 32 |
diff --git a/drivers/crypto/caam/debugfs.c b/drivers/crypto/caam/debugfs.c
index 798ba989a8a0..cec93498836d 100644
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

