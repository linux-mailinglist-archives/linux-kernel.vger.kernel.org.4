Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9A4A374A9AA
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jul 2023 06:06:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231802AbjGGEGv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Jul 2023 00:06:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49624 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230130AbjGGEGl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Jul 2023 00:06:41 -0400
Received: from APC01-TYZ-obe.outbound.protection.outlook.com (mail-tyzapc01on2103.outbound.protection.outlook.com [40.107.117.103])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EBB2B1FD7
        for <linux-kernel@vger.kernel.org>; Thu,  6 Jul 2023 21:06:40 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Iq6ZUCQ6KzGF1jUOdO3UB3fzUE+ltEdAGYLzLgraTL/E8FCe5rR6bQ5B14hJlmnXHD1Zl6rzg6iKHg5Yhv+9lI/l72dh4M5xW5+p3mmuC/dvSmr+LvQOhbUsTFsPzfhLXI/AV2b8QkYwRJbEaO2FAf8uqggx43f+SeUEsXIgFI4/VXrbeSp6ZCc+41gAWt6dPjyg0Ov0/ZONVYqAMJAvdVpsp5S19d8fBa/xv8BcU7uVyooJVc+7Ud2QnUANfm2zSvU34j7+swi6KwOHB2J7HEau9HMoNqZNGws40cKqxfH5+DBrhT9qcKppAelzElUkXEj5RZhKX8T19lLrG1vIHw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ipUKdMlVF+i+Cwge672wAT5nGsYk9M+cH8Qu2fYtoc8=;
 b=L/141FFx+/xbBpbpmuplMxpDb48l5esBDlR469Vzis5ZXOU2Lf87KXOc1kuTysy7tbYdr+2mCwKmHOn+wbCtIRcavyQwiLW5KpzfZMs7rlyyq6vJvaPAfh9cDjHll4afpNrCSupftrDr8sp3hsL3iBHKSG/Enyrjp8jcZmAfIyvSqhZRoXLp9hdcP2cHSaMfNWPOpc7OqhaqgN0oIgIQf6BX8fofBkseDv6J+wXCmyk6dV96KLc7nQKpjy4kJEOa/Yrmct7mgHXr5xsA98SB+qRfXbQwdGcG3FitCw0KYTY/fVWkGVCpEXCJwkdu3IUISOxArhug9hJqvii3T5xzpg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ipUKdMlVF+i+Cwge672wAT5nGsYk9M+cH8Qu2fYtoc8=;
 b=Y617a9/nMhE+p7J+PViNEyBBuxAOhG5wgYdbvekle262Zdv5f8O9E/rKF/OTWTv/492ntyVDfJQgmh08Kh0C5V2Ua34AcYPoiImIHahrz0BbcGQLOk/fo2WqT8lIRnKw+jBQ4EHmHDVCPP7YZ+nPM3B7CUsW5Onm12gTkSoC7R777qZZJQ60xJG3bJHeSWv+Csg2bvdqkhaTW/Vlm52pluwfjLYCCYZwyLMnpZ1fhr/zfcVuyg6E8pvM5DcwRvPO7FF/ek/UxtCsWaGQZ8af+66Ntc2yvRnyL/fL1XGpmpb4oUKEou+ANBRDdmrKOPrRQStbsOSmo43KcLxvK68D1w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com (2603:1096:101:78::6)
 by TY0PR06MB5470.apcprd06.prod.outlook.com (2603:1096:400:264::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6565.25; Fri, 7 Jul
 2023 04:06:38 +0000
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::fa0e:6c06:7474:285c]) by SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::fa0e:6c06:7474:285c%5]) with mapi id 15.20.6565.025; Fri, 7 Jul 2023
 04:06:38 +0000
From:   Yangtao Li <frank.li@vivo.com>
To:     Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>
Cc:     Yangtao Li <frank.li@vivo.com>, linux-mtd@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 03/18] mtd: rawnand: mxc: Convert to devm_platform_ioremap_resource()
Date:   Fri,  7 Jul 2023 12:06:07 +0800
Message-Id: <20230707040622.78174-3-frank.li@vivo.com>
X-Mailer: git-send-email 2.39.0
In-Reply-To: <20230707040622.78174-1-frank.li@vivo.com>
References: <20230707040622.78174-1-frank.li@vivo.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR01CA0112.apcprd01.prod.exchangelabs.com
 (2603:1096:4:40::16) To SEZPR06MB5269.apcprd06.prod.outlook.com
 (2603:1096:101:78::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SEZPR06MB5269:EE_|TY0PR06MB5470:EE_
X-MS-Office365-Filtering-Correlation-Id: 29b62914-ffa7-4811-7434-08db7e9f8fc7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: BXcewIYhCT5SBdGXf7eTrqDHtmqXZdCrL8cn1cGUwJCv6oNTt2tHY+He2Y0QzwOVDCsk7Oqc19OlqBXlw46Pn48SNBND/vtcrLomTwexpOyjYfnF7344P4NLfKFsKPQqzFpRt3kuju7XktXQkB6iACUXrDwIK1ag+j6H3A5GzHnA+nOwlClP+sJ8YJETgo+gf9+pA2WR2MTHsaAFAxYhvwASM7x25JFyrLCkPuV0FkqhJhfAPNaZ71n2FmoKmnCZ5w3x5EAGrWN31aTvNXKjQxhZxElU3ULYmJ9jUECyWYuF+jmaK5m79HpHTS+EGzzRDpnAWjc6K+tghg12IXi48MYDXcBKKekMn0v5UNv+uMRtJmUQEP1zBt6b7TNvfwwk5MUG6GQ68zTtdxDfNLFDzwS2dkURpjNyaLuA48uOsKXuqFMVKvXV7Drf/Vp2qTyuMKcy9vn+qbs3odHPcNdJ55Qu4ll+l7fwg5cksOrkIJO6yx4lFHn2V/qy7GgP2HOLFJVavCxZxrumGc87W8F29JbZlqx604L8MarqLhcLrBZoSE1WElNSOPWObNWnSgu1CtTtgEyCZUpWH252789bsHsb+QaCa9SmBjgDczfj7m5+dEvLlY0tOsJ/O1DP7up1
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEZPR06MB5269.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(376002)(396003)(346002)(39860400002)(136003)(366004)(451199021)(478600001)(6486002)(52116002)(6666004)(110136005)(26005)(186003)(6506007)(1076003)(6512007)(2906002)(316002)(4326008)(41300700001)(66946007)(66476007)(8936002)(5660300002)(8676002)(66556008)(38350700002)(38100700002)(86362001)(36756003)(83380400001)(2616005);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?uD53sLu830oollqJIbL/ItoltrZiWGz3EHwgc5MuE/Vm1UiWn2ZIPRECc+kc?=
 =?us-ascii?Q?LKg/wPQXLWmR6JAF5P4CoF30jKNQt4/xlJIxfJJSusksiCWcyPexj+T3YwsP?=
 =?us-ascii?Q?ZxBGHSivYVaqAJpPVsMM+NH8wCZUxVSSfnzO8xRZ+9NMzmMkIzsx0lsTlfuc?=
 =?us-ascii?Q?Tt6V5N1RTpOvJ86OZ151RFeA78yT21eriP7Aw8jjlpU4SSmgvDVH2WfArH3T?=
 =?us-ascii?Q?tKDK8rJyidEbatUXfktUvDG6fbkkOJ6hOdgMkUs0DpdYKoPkKH+rCeMBBBfP?=
 =?us-ascii?Q?O+/mn0ZArqiE3KMjtYLL+TysfsjuSGt9odiFAEf11eU2mQa9mi7kt9hO35gB?=
 =?us-ascii?Q?Q+/76VriTF18ZlGcodtNTnblELdaFksmKF/U/hFxzwQRetZofKpVCBPAXoMf?=
 =?us-ascii?Q?svkuQPmP2ocKO4OqU/V8Yv9rhUfqzg1kRPhYHGs877jFZ254rQrPrjcgCVxu?=
 =?us-ascii?Q?rpGYEjAyajkXhaiTWb4lCytN32ci6w11KowYBh7snVID5psAtf8pW4qTPjjH?=
 =?us-ascii?Q?MF9FcCC4FeI2dPFyMNtsYJsCPrPlwE5k4MyZnZvavO9Jyb55tQYNGSEHjdrt?=
 =?us-ascii?Q?BV4W3lDJH+EYY0WzGJvZjbeNTz4oKfNkfAVbwtHw5jAZp8vDsTI6DiXjTsR8?=
 =?us-ascii?Q?NZncTxn8Y+IdWeDBdkyXhcuc51u9gV6BpLjWrPIXIGtB/LQLnV1oYy2Fczeu?=
 =?us-ascii?Q?ipix+KSToGjsq8/99mp5DwWxpjRSdGBSUR2681wUauAu/YvnHVV0ftN/qMx/?=
 =?us-ascii?Q?VmOQVn4ptyqUBA+v5psyMHzicxdUnMdpoPJH+H9kMxbfw1qEUS+aQtiIMT4Y?=
 =?us-ascii?Q?69jokWaz8/TVNAoEj2oYK7+4pnaLrMTZVZKowjVO7etK2CebVLv8qK4DKb1t?=
 =?us-ascii?Q?adXU86BxXTWMo6FNdPSk1fGL1gHR4uNolwOQGc2KqsCIl7k2AGcfqcUc7Iqc?=
 =?us-ascii?Q?7rAZpZ40OZ04eD4y1o1SP7gfAi7oXVXFZHMCVMLeHMlNSlg0IY7zcNqX4rWE?=
 =?us-ascii?Q?jUpBrMN+WjPWM38ywgMLq3aLMPhw1xM+KrThTeaNiPthwbsybP1MV1k9YC+a?=
 =?us-ascii?Q?eCBOuowOanciu6kGTwl2GT9XglDuvvAF4VFAlQB9uCWTbdyzQ8wlTSReNl72?=
 =?us-ascii?Q?IkpU0UFZJpOM7pZzFOiKgMKABD7srb6n4fB6gzo/oWeYhiJDiRVXcTsSBKQl?=
 =?us-ascii?Q?s11OFF9Vk4G+x4XfaVS9eVIyovZoh1QvenOeyTXjbr12SrDbyn6YpADeN5Ml?=
 =?us-ascii?Q?qMTfwvx/d4mS1CeEP9XwqPhr9OdBNI6pUnv9on8omLpNJumvVrx4DlCldnaS?=
 =?us-ascii?Q?+R+4b15OUHPghG/URQP7Ct3gSdp/LLJPgF6oVKXiogE1WO+cOU6Ylngvk0Np?=
 =?us-ascii?Q?mZ4YM/JvcLBmrT3c2qgQQwHvsQ8CxdsGDPlOv+HtWKk15BSdIoh9KuuuBcsg?=
 =?us-ascii?Q?Inv7urgoxm2Trdf45opxWuNNoS8zHoXJg0ELxJcKgT9t3XjwoELbyEAs5kIP?=
 =?us-ascii?Q?ju6GcfXvS2BRE4kgLnKNZnxoSA7NCmRdYuk8BMV5TWA9S3NUxT/SjiJY1m0S?=
 =?us-ascii?Q?Cs4KtdovzS01veUIC9R4mRtQHAJ6DMjslLb23dQb?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 29b62914-ffa7-4811-7434-08db7e9f8fc7
X-MS-Exchange-CrossTenant-AuthSource: SEZPR06MB5269.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jul 2023 04:06:38.2013
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rwLne7y8IAW4KsMaQ7Frynd5BQ0YdST44/ZM16tWUXEQFID07u9UKq+vetsQt7uuGddTFrnCkXkO+miBxFg9Rw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY0PR06MB5470
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use devm_platform_ioremap_resource() to simplify code.

Signed-off-by: Yangtao Li <frank.li@vivo.com>
---
 drivers/mtd/nand/raw/mxc_nand.c | 9 +++------
 1 file changed, 3 insertions(+), 6 deletions(-)

diff --git a/drivers/mtd/nand/raw/mxc_nand.c b/drivers/mtd/nand/raw/mxc_nand.c
index 3d4b2e8294ea..2f8dcda0f435 100644
--- a/drivers/mtd/nand/raw/mxc_nand.c
+++ b/drivers/mtd/nand/raw/mxc_nand.c
@@ -1696,7 +1696,6 @@ static int mxcnd_probe(struct platform_device *pdev)
 	struct nand_chip *this;
 	struct mtd_info *mtd;
 	struct mxc_nand_host *host;
-	struct resource *res;
 	int err = 0;
 
 	/* Allocate memory for MTD device structure and private data */
@@ -1740,17 +1739,15 @@ static int mxcnd_probe(struct platform_device *pdev)
 		this->options |= NAND_KEEP_TIMINGS;
 
 	if (host->devtype_data->needs_ip) {
-		res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
-		host->regs_ip = devm_ioremap_resource(&pdev->dev, res);
+		host->regs_ip = devm_platform_ioremap_resource(pdev, 0);
 		if (IS_ERR(host->regs_ip))
 			return PTR_ERR(host->regs_ip);
 
-		res = platform_get_resource(pdev, IORESOURCE_MEM, 1);
+		host->base = devm_platform_ioremap_resource(pdev, 1);
 	} else {
-		res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
+		host->base = devm_platform_ioremap_resource(pdev, 0);
 	}
 
-	host->base = devm_ioremap_resource(&pdev->dev, res);
 	if (IS_ERR(host->base))
 		return PTR_ERR(host->base);
 
-- 
2.39.0

