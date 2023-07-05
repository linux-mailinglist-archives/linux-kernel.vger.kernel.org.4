Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B6A37747E1D
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jul 2023 09:22:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232033AbjGEHWT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Jul 2023 03:22:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44636 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229697AbjGEHWQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Jul 2023 03:22:16 -0400
Received: from APC01-PSA-obe.outbound.protection.outlook.com (mail-psaapc01on2105.outbound.protection.outlook.com [40.107.255.105])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 023CF1A4;
        Wed,  5 Jul 2023 00:22:13 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Q78mJkuYuFGtcLDGy36fpIVfUo8x6Xdaehq1Ydk/bKJE3IF/TvxJz1cS0Tj+QeprW3o78uliFG3sxN0I8MvfZ23YRDMafhjtLrC2b6d1pVocNbpapFs16PUJ/IPiUZHiR2uckaGMyeIPAXxQYvqVxfNOkMqPJi6L/Ms9Oxfab/4Pt9/EuefhNwaN+3YuQsCPyd8AuM2EWRBJSsWGQVa7t2Fmg3Br5uELweZ5pyx1VDdFy7z2rRCW0M0Q+8sxg5C6o4qah4+HamAYvmWC4krhDNd2my9VSL1DMy0DHV4RQTZgammMa0n0kcNffOUhOVrf84J7KBW/Px+DJH1MvxEzgQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ni4NMIq9gwaRLZlMszJncfYmUddIMbEeqAHECI08eto=;
 b=BmI4vbNWute0kVT4QdLHnOGUtLf6rnNFHeIHkrVV3W47SCihK61Yv7lra5F1hWqTCXdIRdyRT+5LBJvF2YY9cV9WWQJXg5d1XBexTswhCsi2golyImBIukOOZN9/lt3nKCN+HjoD1DZ5yPYN/x75cWHY7Jeh3ik0xgBJT724UgEq3qZceclkqebyrdEuQqE5hzaDxqF68UTQSsgRv/1vM7V+sqOd1TJA6mH+iQqhe95MuAVTsVanFBMWNLbcQ/2Hihw65MU/VBCm6bOtC7HpaSMmkAZoPTQ9VtTtshBarIeYtlalojbCk9SsaDO90+rOfzNIz7olvoNNY+N/700ZBA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ni4NMIq9gwaRLZlMszJncfYmUddIMbEeqAHECI08eto=;
 b=OW4V7VouM4qUeLIpPiwPgYq6tOncCLElQ+F+lfHAExIhroThtl/S/AGyo6CHxrQrmwuRbvtscRMWuIYj3iR0ns+5qdp7aqRp126YZyv3R1HM/nlATU/4YZOlGTRyIjgavWENxjdaJMOPyawhsVF8XZKGCZxlmEHfbTMjfQrJd3UnbHIUmrg9DQkvrjX9cGm3pxK1KOGFULHckTnEf1IpCni/5I/Wk3fUQ6UGZYb91ZcFPP69jxvLbP0deS+DUAyodljG8q6IAp6G0ra3bFGt0UzDyLRNQJaNVmpXKqQwDnAih+mo438sRq0N35Z9Svlbw+eOF1MlFJVC2KTmRpyKLQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com (2603:1096:101:78::6)
 by SEZPR06MB6058.apcprd06.prod.outlook.com (2603:1096:101:e3::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6544.24; Wed, 5 Jul
 2023 07:22:11 +0000
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::fa0e:6c06:7474:285c]) by SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::fa0e:6c06:7474:285c%5]) with mapi id 15.20.6565.016; Wed, 5 Jul 2023
 07:22:10 +0000
From:   Yangtao Li <frank.li@vivo.com>
To:     Daniele Alessandrelli <daniele.alessandrelli@intel.com>,
        Declan Murphy <declan.murphy@intel.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        "David S. Miller" <davem@davemloft.net>
Cc:     Yangtao Li <frank.li@vivo.com>, linux-crypto@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 2/5] crypto: keembay - Convert to devm_platform_ioremap_resource()
Date:   Wed,  5 Jul 2023 15:21:55 +0800
Message-Id: <20230705072159.77221-2-frank.li@vivo.com>
X-Mailer: git-send-email 2.39.0
In-Reply-To: <20230705072159.77221-1-frank.li@vivo.com>
References: <20230705072159.77221-1-frank.li@vivo.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR01CA0036.apcprd01.prod.exchangelabs.com
 (2603:1096:4:192::22) To SEZPR06MB5269.apcprd06.prod.outlook.com
 (2603:1096:101:78::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SEZPR06MB5269:EE_|SEZPR06MB6058:EE_
X-MS-Office365-Filtering-Correlation-Id: 56674066-acde-4327-b872-08db7d288c2a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ViswoUS2bIbgO42uOszWH0OSPr1/HC4kXSAXaMwq5tplmn+y7JI8a5X404RpMTvJTSzcZbgwIym9qX8yzjYqHF5GiVCEDiWveDTqZdTw/0EvHmV7sVGABAolyxTD11eUXV7BhbJYnA66r+Ot4vVq85Ie40yk0Q9+nqNhYNLN9RTKpMX7aIzWgN476az/TuHxS89RTgXrdQdvlrhLeJ+MqDjziqnKo2xApl7kkApQnjqOTc3aVH8sIpWDV6cXap/Jhu49tNWGSVrctuW0H49cBdf6jjBbUfOIS2rwu+sFH1ougKGab39yNkoo+5/y1a3j2YYqs5MADBF0JEl4Gh53RwZScDQMcDPLecgMO6OHlgNK4tJJ82y3c4Ejbcqbek2phyGBbT1nIUzeuDkhGOWmKyuoKxuhbR5Agb+gp0jQG2XjjNLVD+zv+632LCC8pD5sWn4DyO0LwuaiBlynaqCIiP5Gto0o9nOJADvwci1Rk4zjkOXj9i2VsWmUe8V7H0ByyB3OzUAnA++B/EZaItP0iq2kM0tr0Cq3BjMQG3LbwJdIkfboqlTe7z7bFBmdKQLhaRG49Os+34+jLdEwVkOYqHAq5elsk+gj/UoxjeA2lW8V9emRqFrn+QmU/xH6qVKt
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEZPR06MB5269.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(136003)(366004)(396003)(376002)(346002)(39860400002)(451199021)(26005)(66556008)(66946007)(36756003)(66476007)(4326008)(316002)(478600001)(8676002)(8936002)(5660300002)(2906002)(41300700001)(86362001)(6486002)(6512007)(110136005)(38350700002)(52116002)(38100700002)(6666004)(1076003)(186003)(6506007)(83380400001)(2616005);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?MM3XFkU+u69AUkytMmbtytZvw833V8VP8TMbg3boJVmWRmN5dk4wmCi7vc/3?=
 =?us-ascii?Q?UzY7c6UpIl9C6klBMl7zORpT9SL/k/b9UQK1urSGpv08W/7OIYjIr8WxQCW7?=
 =?us-ascii?Q?hUGoemaEWK3hzBbM4vOEGWDIaxaRhF/6R+7NehT2+i49N8uJJO54xQckshpe?=
 =?us-ascii?Q?WeCHLdEmfzGxXcaQkKwGP0pcfSmAkoEruPgbLuFI5VU3U9oaZJiSOyaNDPy2?=
 =?us-ascii?Q?kl1o8RzSPePSGEZ9GEI8hIZxuE2jgAz5KaGIi4xPRoKe1p2lM1Da1mqLBWAh?=
 =?us-ascii?Q?2z9wskuu+8aqUKRaZCJn8TmURWKTDJ7/9yuY/ilE6WlxoGUcIdrjlKx4wp2f?=
 =?us-ascii?Q?7FNrn5QxvFfGFKaPRwLEA5DYYnpLCksqPhY4aiwVy3whNUyiupX1SZ39sFhX?=
 =?us-ascii?Q?G00ClDGtpVNzuc703AimbXOWTrUaoWRIzzfoB4WeC4cAHkbrLYB6fxail+vm?=
 =?us-ascii?Q?lZww2217TISpXv3GfN7KsG1sA2CiNI6gicdRmGZe+5qVF0WpZiU0wPDgC8Mu?=
 =?us-ascii?Q?/+PcIar+7xM0Saj/EPokKoS+az1FL7sExFFIBmTmlaovsF3YmWgEiXgxT3za?=
 =?us-ascii?Q?sOB6NMvxOE3O2YB6PpTo13PUoGkBZV4Gm0ihxvyqXJ5tea1EY7WBM8DNPkpm?=
 =?us-ascii?Q?y6y/1SyMqovkSUGy5XHfh4FW9dv2fyWMcB9hwyAAK6P0Rg3bcuXxrDhaUNA3?=
 =?us-ascii?Q?iflbIbQubNlH1UYqW2LQD+sGZYpuWYoBdU4UO4PThza8DnM0vBypS7eK37ka?=
 =?us-ascii?Q?XuvW0/sojRPLIMr0UG0ooU5SxyRFkMhL8VHcW3RkqO2eblOzX6XbMw83Blcd?=
 =?us-ascii?Q?JAd6HDUV9VQBj8GU1xk7EQqmal1M572shOB6B35rFVlNwANcVMd7MNzJmZ/5?=
 =?us-ascii?Q?OPv41r/AEL/iFJrgMPfE73r4JZoCEbT5f7m9v4jcQQ1j/VCjVCmtiBlVBS5J?=
 =?us-ascii?Q?DXSp/Aa+BlmYeWyrlWMxqiWB7NXcyEp/rth/P4yXkM28UJew+Oai+/aLWo3n?=
 =?us-ascii?Q?Q865dzpfv5AnT3zQeMJ8XnrhmO8+Ltww5QEq0TRG8gTXndpIvqEeHEMl5Dre?=
 =?us-ascii?Q?uSBXjzjui12EKJa9yDjCusbz7Qq+BAeIKLUf4bbHNrC9pOQHfYej0lQau9WU?=
 =?us-ascii?Q?e0T954sO+qOHKSiFj3Qsappt9DCykCBvMFBoqh9hISxOxHFneNSxpPgXQXKW?=
 =?us-ascii?Q?RR0VmVQ0YTcJeBpeSyzLrRWA3Y4iGQKe+qAnb6tWRGwqCwSumY2QkUqxQyQu?=
 =?us-ascii?Q?BeLmNNBuFmw9OPp2ubDLdO7/iceyD6ttTe/o9HBWNTqB/sX0uudvoFUlaGcg?=
 =?us-ascii?Q?cpLcYYfxazalndx80KJYRHFPn0riix3S2EyoeFg7m/Buy7DpCdYidrcwxGZS?=
 =?us-ascii?Q?Ncs6Zrr5Vas4B/k/LqSlq1HL0QY8YM0pbuCZn3V4b1mK0LVyGqxC+8NDxG9M?=
 =?us-ascii?Q?h3k4Ul+m607wd3jsivWX9Nuzt4osNu98fOmhjn9qdjiEIpJJaw7R/CmhdiFS?=
 =?us-ascii?Q?fE8SslJio76cJ/r1dVKCjsgXlfN32pBGoDB2DPlgnIbmeHWI+Y36/nzTo1Ly?=
 =?us-ascii?Q?UCLopt96NQqumvDOTu6WXLMLboQ0MTcNIxKsZQJ/?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 56674066-acde-4327-b872-08db7d288c2a
X-MS-Exchange-CrossTenant-AuthSource: SEZPR06MB5269.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Jul 2023 07:22:10.8772
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5TqWABfzQvp5TOxnKKMrJDPxS+xzb5ZmQUc2o8HxsnOsw9QkGzLGy2bAzGDyymZANIBYg0du6Fub74YriOLoBQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEZPR06MB6058
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
 drivers/crypto/intel/keembay/keembay-ocs-hcu-core.c | 10 +---------
 1 file changed, 1 insertion(+), 9 deletions(-)

diff --git a/drivers/crypto/intel/keembay/keembay-ocs-hcu-core.c b/drivers/crypto/intel/keembay/keembay-ocs-hcu-core.c
index d4bcbed1f546..51a6de6294cb 100644
--- a/drivers/crypto/intel/keembay/keembay-ocs-hcu-core.c
+++ b/drivers/crypto/intel/keembay/keembay-ocs-hcu-core.c
@@ -1170,7 +1170,6 @@ static int kmb_ocs_hcu_probe(struct platform_device *pdev)
 {
 	struct device *dev = &pdev->dev;
 	struct ocs_hcu_dev *hcu_dev;
-	struct resource *hcu_mem;
 	int rc;
 
 	hcu_dev = devm_kzalloc(dev, sizeof(*hcu_dev), GFP_KERNEL);
@@ -1184,14 +1183,7 @@ static int kmb_ocs_hcu_probe(struct platform_device *pdev)
 	if (rc)
 		return rc;
 
-	/* Get the memory address and remap. */
-	hcu_mem = platform_get_resource(pdev, IORESOURCE_MEM, 0);
-	if (!hcu_mem) {
-		dev_err(dev, "Could not retrieve io mem resource.\n");
-		return -ENODEV;
-	}
-
-	hcu_dev->io_base = devm_ioremap_resource(dev, hcu_mem);
+	hcu_dev->io_base = devm_platform_ioremap_resource(pdev, 0);
 	if (IS_ERR(hcu_dev->io_base))
 		return PTR_ERR(hcu_dev->io_base);
 
-- 
2.39.0

