Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 18F62666EAC
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Jan 2023 10:52:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236020AbjALJwH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Jan 2023 04:52:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32980 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239579AbjALJvd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Jan 2023 04:51:33 -0500
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2064.outbound.protection.outlook.com [40.107.21.64])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A1334DFD1;
        Thu, 12 Jan 2023 01:47:27 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dreWj91xOd9qoqIqAIIp3X+rXFGGtf3rfyjoJnwZk8xla0FiCKBM2ykss8v8xyCL6UbzbuUKrMrPdmfIZYsM84HkP6TioKAfF6ymZbenLaUIP7zQP45MONEeJ91ScTMMoXZR8KzN20ORcQVZjICqlPSluyNU+g3u7ruxNe91hQJn35S+IE5gGaqj8CQmXnbjtjCcct5vadXciOkERLGS+29Eko3TbGRG4voluqqJ7rv2ELVCJ7DKfvWjv2lB2q4XDYqjg3Yvvqvz8XImf5X6A8PNtZPERqY+2YHsXSduoroUyDyh/4FMq7BmcqnIeSRpMBNjtPZV/c9XQH7L62avAg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8RaL0VK+3IJ65OdJWEwLw8K7jniU9Ua6iV/oDCSzMCs=;
 b=IblO3T2dGbYRjkO1XXSILuAl9xCiPANHv4DgFn/GT08fxnJvYQmOEcUaWBxy1Qaxswc8QJJaLJ3aYSp1TyhyfIUlMZ3y8FXN1FSBpFWtkBu2DTjK01E7Zo5Q6+TPUxepY7xzNVlfPH46k/OQG0I0TssMEk1MPjl1wEOn+zRMHo3hLnyXzN4IFhOSHtEi1v+swdsnFlM8FVXZLtdbLKtaxtUYFN7qstI5T87UfapKgikiDhvoUNEjEfGj58s3ySj6UId88/mfwahB6dKyTwABn04D2r2ZU1JMvL9/6+YcmzjlAGcflvLqSS/Y2/krdAJclgRh5Wm7LD+jRi01U1ec3g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8RaL0VK+3IJ65OdJWEwLw8K7jniU9Ua6iV/oDCSzMCs=;
 b=VqzDquCYwzHodLcmCgyOX+snhL8a63T8oJUrfqK8NYBr7aONQUts7qWM+ki0sobfgot+CEXoXenV/yiGRbGadL5RpTNBAkj4lB4dJ09ltYxma68ifU9cUZr/sBnilFwwPVKe8iQsrCcD8Al+i7KSNFIskwmjBVWy3MGub8TySnk=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM6PR04MB6341.eurprd04.prod.outlook.com (2603:10a6:20b:d8::14)
 by DBBPR04MB7739.eurprd04.prod.outlook.com (2603:10a6:10:1eb::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5986.18; Thu, 12 Jan
 2023 09:47:24 +0000
Received: from AM6PR04MB6341.eurprd04.prod.outlook.com
 ([fe80::3a82:42b3:f1ed:5c3d]) by AM6PR04MB6341.eurprd04.prod.outlook.com
 ([fe80::3a82:42b3:f1ed:5c3d%7]) with mapi id 15.20.6002.013; Thu, 12 Jan 2023
 09:47:24 +0000
From:   Ming Qian <ming.qian@nxp.com>
To:     mchehab@kernel.org, mirela.rabulea@oss.nxp.com,
        hverkuil-cisco@xs4all.nl
Cc:     shawnguo@kernel.org, s.hauer@pengutronix.de, kernel@pengutronix.de,
        festevam@gmail.com, xiahong.bao@nxp.com, linux-imx@nxp.com,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: [PATCH] media: imx-jpeg: Apply clk_bulk api instead of operating specific clk
Date:   Thu, 12 Jan 2023 17:47:02 +0800
Message-Id: <20230112094702.27604-1-ming.qian@nxp.com>
X-Mailer: git-send-email 2.38.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG3P274CA0005.SGPP274.PROD.OUTLOOK.COM (2603:1096:4:be::17)
 To AM6PR04MB6341.eurprd04.prod.outlook.com (2603:10a6:20b:d8::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM6PR04MB6341:EE_|DBBPR04MB7739:EE_
X-MS-Office365-Filtering-Correlation-Id: c317e963-b801-49ba-447f-08daf48201ef
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: BNw2Ysh5dcgVLfkjH5xhA+oJgyW4wtQR2OqFlRFMQchfKTR2wRLYCBB+pts8X8zj2nulfWzjP1uSOn7iWs14601XceYQ0hcqpmXh8fM1o+aqD3BEeDA+XtfqEmcRFrgMn7Rh6QSbBnA2XWoDkQivKm+WN+z+X37KeUAMWJfMBbMnzjEmrWDa+Uk/DyZnHFCrXP0khLGy3Gvm8zN83fRznG2G1bR8O0PKVamTd1T2vF7NSI1NrGZffeGp0q2zVLbee3y9RDVO0WbtUj4/X72imL8fbgECM+TlImU6YCFVqVdm+gZ12sX1LHA4Pv7sEdw/sjby2xsCkEMlFRu12yGNLiaLFchj5ZL9nJb0sReOkmQdHyD5/snPwmy7ftTTrImTmY6LyVlxwk6tZse66u+cpY5/4NpjCwAkQyNYJh8PE8KlLzi5+SVYXTYs3ul0+FXpFNJg5pJWuIdKxSmzWXyPGf9py8TOYLkOCxLLbMA+RqgOtdXaZIBlcqTeELa3+rlJV8gd6iXSz/AKXkAmvAeMhHd9vyuAkQh6ics6n6Gh1Cj4cdoJQiBqE520XOgvDgZvfEVc0kayHa0fSPK3HgCZ6faFmv8dQkykAL6idlmVH55HmOsXRpeF/OmpFIaQ9wTtopykXFXOrJTOMU9COO/adh2aP7F7YWC4Kam+/3af+ToPhwLYpR9wVVFS/Cnmee4SU7mSrWbCcVLLPgJTf7qZkg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR04MB6341.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(366004)(346002)(376002)(396003)(39860400002)(136003)(451199015)(2906002)(83380400001)(44832011)(478600001)(1076003)(52116002)(66476007)(7416002)(66556008)(5660300002)(66946007)(8936002)(26005)(6666004)(36756003)(186003)(6506007)(6512007)(6486002)(2616005)(41300700001)(38350700002)(38100700002)(8676002)(86362001)(316002)(4326008);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?OCM72dgF4sD7zJletWXrP7ElzXDAWnMTdliI/7tPTFJVeT3mUCimq1CNLOuH?=
 =?us-ascii?Q?A0zK3nz5KsPlyHjkorA+5PyNm71AD525NE+HDlL4MwPR8VoB+TLdbSjw0omq?=
 =?us-ascii?Q?+ht6v0La0luWzU5LVKwGn75Pfgw6UstiB4UwNpxPJzD8k5zzVTmuf+VaIvY9?=
 =?us-ascii?Q?SXC6XE0UwByGlpunkYJM8doaIANdobeNsRoINfKdLSrmwkqn4B6bEDAzAEJL?=
 =?us-ascii?Q?K6JqtnGBZWQ3j0otWfCDv8mSrvMQQ6AVBm9Kp95uLc3+V2IPQAyzS6iJTdwh?=
 =?us-ascii?Q?/yDu8cgrQnEHPeYNlOuB7+U8L5xAgKfwy2X4PvEmBwgK7Cz+x3TAPR3FQuDR?=
 =?us-ascii?Q?OjqcUknWEGNoQsQAtEbmafszEw9iMRYx6uQas2oPmmSKvtNApbGli+1TByVV?=
 =?us-ascii?Q?pe53CHg09u1am5WIxfhMKS99/pLn0oVhp4Px39/qr7qdj9L1JQoBTQbl+ZDS?=
 =?us-ascii?Q?Vn3lsXnYqW8wQZ9dxLP51n0FYeOMPIKttWqqzEdLmWIepQ8pgn5jje1mvCkB?=
 =?us-ascii?Q?4a3lTAMoQ0aeZvVImrpzdThbXLT7asuJ22AfFFzVg3UpjxIkb3mUHM1te+u/?=
 =?us-ascii?Q?ByT5vKpN22ih+XwZlRayS1aRX+ccyD/mTBI7NK64syUpvC/bUEYvJ6B4OSS2?=
 =?us-ascii?Q?ocDLLAkWO6R+bzCbNirNocZbHua4vK2h5p2QKaD0QgjsBnzWJMEy6RyXvrbd?=
 =?us-ascii?Q?BlleSmh9aUV21+kXC4BRf6Uk1ENb10KnZLrw3SeULB0YH8N8pvMgUg59aVah?=
 =?us-ascii?Q?sTN/KhJaLTvGaJj5Hd8RUcefl87EazyyUBXEyZaVXibV8RrhUl1jFXUu8UuE?=
 =?us-ascii?Q?Smor743ZnLrbx8NA6e94vlcQGAbbbw4JxyeKKz/Bp5QCq58MgqghcFQ4QCv/?=
 =?us-ascii?Q?RimwTP3rL0sVyHUZSvQbGN3lheQpw0ZY0z6VF8QcTBXG69ije9x4dCYLrCKb?=
 =?us-ascii?Q?qr6Qx+GqPTMX8rKvvbITKuhm5cVKbR+6ck4u9LwVT4WzW1FBIknM/d8X2jza?=
 =?us-ascii?Q?AaDHVH0gMAJVdn3TCBDB9byd2RyfYfXvLiOJNtGtY0zJUD+C883GVFTc01tY?=
 =?us-ascii?Q?7CM7nQYS2uBQGal10KvZn2LWYu3JhWGS936vCQtLQbXNxQqlxAnblmw64c4Q?=
 =?us-ascii?Q?619vyAC+wdz02DVqvwYj8/VX9IOiaEaHJocH7nmoLP4clvzCjQ4UhTdVx62s?=
 =?us-ascii?Q?rz/cELyUo76PdWls5EjnHhGzlxyQk97Tg9fbJ1/GG2zNto/u0HUum7CuCHLu?=
 =?us-ascii?Q?Ec+Qcxk0/HJzRpf+zWxnVWJ/jqLp5q/GAK+qAIux/e2F1alukAla50A/VX4L?=
 =?us-ascii?Q?e5eUK+6NotOYstLgMfiAPbptoIFJD9GbhCfaWxYmJCno/UpvieS6/IY5jdWK?=
 =?us-ascii?Q?PtNjkABJqk9cL8H5YG4tXIQiA7jpyOkEIwUGaw3CIH4tCnmVk8DvwdLgmjam?=
 =?us-ascii?Q?GmOCLTKt4pk46r5++O+M0DUfp/HsR8yWQ48FzZ9z6LCU9VG1pTh1MJmP3dXK?=
 =?us-ascii?Q?fJ/pBICPoWO+NKoQ/bGH3BWYBJ5/rSJLCQIBJHc2D9hx6EYWLe1+W6Mlf7Bq?=
 =?us-ascii?Q?MUZ8NQTWYoB2H2q5HH3o/3qCnOrLNq6avE51ZEfX?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c317e963-b801-49ba-447f-08daf48201ef
X-MS-Exchange-CrossTenant-AuthSource: AM6PR04MB6341.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jan 2023 09:47:24.3292
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fGr5+clt+pMvm2OyYRjh2sCh1ikBAhqSq3aGT/sgYHzUUcr1/s7dgTaG2rffde3vEiV5vWXcuf1yLb9oKvAOiw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBBPR04MB7739
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

using the api of clk_bulk can simplify the code.
and the clock of the jpeg codec may be changed,
the clk_bulk api can be compatible with the future change.

Fixes: 4c2e5156d9fa ("media: imx-jpeg: Add pm-runtime support for imx-jpeg")
Signed-off-by: Ming Qian <ming.qian@nxp.com>
---
 .../media/platform/nxp/imx-jpeg/mxc-jpeg.c    | 35 +++++--------------
 .../media/platform/nxp/imx-jpeg/mxc-jpeg.h    |  4 +--
 2 files changed, 10 insertions(+), 29 deletions(-)

diff --git a/drivers/media/platform/nxp/imx-jpeg/mxc-jpeg.c b/drivers/media/platform/nxp/imx-jpeg/mxc-jpeg.c
index f6f87970a6c9..d3d4dba8c280 100644
--- a/drivers/media/platform/nxp/imx-jpeg/mxc-jpeg.c
+++ b/drivers/media/platform/nxp/imx-jpeg/mxc-jpeg.c
@@ -2758,19 +2758,12 @@ static int mxc_jpeg_probe(struct platform_device *pdev)
 	jpeg->mode = mode;
 
 	/* Get clocks */
-	jpeg->clk_ipg = devm_clk_get(dev, "ipg");
-	if (IS_ERR(jpeg->clk_ipg)) {
-		dev_err(dev, "failed to get clock: ipg\n");
-		ret = PTR_ERR(jpeg->clk_ipg);
-		goto err_clk;
-	}
-
-	jpeg->clk_per = devm_clk_get(dev, "per");
-	if (IS_ERR(jpeg->clk_per)) {
-		dev_err(dev, "failed to get clock: per\n");
-		ret = PTR_ERR(jpeg->clk_per);
+	ret = devm_clk_bulk_get_all(&pdev->dev, &jpeg->clks);
+	if (ret < 0) {
+		dev_err(dev, "failed to get clock\n");
 		goto err_clk;
 	}
+	jpeg->num_clks = ret;
 
 	ret = mxc_jpeg_attach_pm_domains(jpeg);
 	if (ret < 0) {
@@ -2867,32 +2860,20 @@ static int mxc_jpeg_runtime_resume(struct device *dev)
 	struct mxc_jpeg_dev *jpeg = dev_get_drvdata(dev);
 	int ret;
 
-	ret = clk_prepare_enable(jpeg->clk_ipg);
-	if (ret < 0) {
-		dev_err(dev, "failed to enable clock: ipg\n");
-		goto err_ipg;
-	}
-
-	ret = clk_prepare_enable(jpeg->clk_per);
+	ret = clk_bulk_prepare_enable(jpeg->num_clks, jpeg->clks);
 	if (ret < 0) {
-		dev_err(dev, "failed to enable clock: per\n");
-		goto err_per;
+		dev_err(dev, "failed to enable clock\n");
+		return ret;
 	}
 
 	return 0;
-
-err_per:
-	clk_disable_unprepare(jpeg->clk_ipg);
-err_ipg:
-	return ret;
 }
 
 static int mxc_jpeg_runtime_suspend(struct device *dev)
 {
 	struct mxc_jpeg_dev *jpeg = dev_get_drvdata(dev);
 
-	clk_disable_unprepare(jpeg->clk_ipg);
-	clk_disable_unprepare(jpeg->clk_per);
+	clk_bulk_disable_unprepare(jpeg->num_clks, jpeg->clks);
 
 	return 0;
 }
diff --git a/drivers/media/platform/nxp/imx-jpeg/mxc-jpeg.h b/drivers/media/platform/nxp/imx-jpeg/mxc-jpeg.h
index 8fa8c0aec5a2..87157db78082 100644
--- a/drivers/media/platform/nxp/imx-jpeg/mxc-jpeg.h
+++ b/drivers/media/platform/nxp/imx-jpeg/mxc-jpeg.h
@@ -120,8 +120,8 @@ struct mxc_jpeg_dev {
 	spinlock_t			hw_lock; /* hardware access lock */
 	unsigned int			mode;
 	struct mutex			lock; /* v4l2 ioctls serialization */
-	struct clk			*clk_ipg;
-	struct clk			*clk_per;
+	struct clk_bulk_data		*clks;
+	int				num_clks;
 	struct platform_device		*pdev;
 	struct device			*dev;
 	void __iomem			*base_reg;
-- 
2.38.1

