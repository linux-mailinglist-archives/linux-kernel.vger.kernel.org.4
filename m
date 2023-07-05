Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 833D6747E1F
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jul 2023 09:22:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232223AbjGEHWW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Jul 2023 03:22:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44644 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231809AbjGEHWQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Jul 2023 03:22:16 -0400
Received: from APC01-PSA-obe.outbound.protection.outlook.com (mail-psaapc01on2105.outbound.protection.outlook.com [40.107.255.105])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC7B51AA;
        Wed,  5 Jul 2023 00:22:15 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=haoyYkSFptOUUb8hDAn+6oUKGi7NQw0mSSTo42aIU08l+QpMFyh1gjWK9fSG2b4ZUEttmLsHkuG8umNDBskMsXgUMWpiikALrN5bVT2TdjHMP9+a/lmhkNDUPMFkDNUHA8DLRbgUdtR/e4MYqbMYSIG3vYsKLYjgoDY5Hmds+BpGEtbjX4cq4qQvg6ovkmRgtyvnH1Jeo0SfyRbP12Ywa6SsHM1VrD5/btWlNWLtbSVjz2iSlpIk8JExkfXV2IjQUxGmuClW2yn+7p8+LaBsKDBfLdPhQXb0lsl+2C8F/qPUZmYWOoNZYP5rDFudZwHLjWd+mopherPA8ctTzu1UfQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=F3R5YyqcPwxpMQtiojJc1md+fTHDdQXOdD1Y5PaxsZ8=;
 b=EdWO4SH/ybshG+Gd7O0GgJCgAL4molZm8BECYHEfUqdWyVhF+De4DvDdAMM+zn290WFoiw0umE09TNxG1f2hH6dz2jrYKyW1WI/u/RN+miqrY0zExVp5eX+ti2GLGDnBbEihjX8cSW8vHhEAiR63bCzzHCJm9JDSyqksh/iti1v0u7GcrawGA6UwBxc38pBNJoK9f4BUxeslUi/dd0ME9Fro2d5oXWx58+npgFKuXcX/6/I8V+Fzwn2nsmceutit6N7ZaRzTUt0ek49DVYgGHohs782/NZ4Ijk6tELi/Q/OdXW8Ufn/39ueL5phC+shdVLdskXoEywIm1MW3hcAsyw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=F3R5YyqcPwxpMQtiojJc1md+fTHDdQXOdD1Y5PaxsZ8=;
 b=HeaySCT2brIPG6GPTw451FjtHuthfl077zvqnvJDMZw1nnA5jmtOifpebHD/hCFNIrIj/CGlJRndp4WBbGt0ueIZ4+Dp+lpMkybaeoyRahNwGgjvh5//y3w6S+tguDHyXXGf/AL7W+uCvTDgvwTP8CqegqvA+RExvcr2S7sDYCSgy/0ECNJZywLc9YrIa4G0bVWhHel6k+EALjo+d48jpXjb0lfocwcrptR2PTccg5sWIVCYnEy8vzph9xDLc2trwyTJhV8B6OOwEff/skxE9rDja+1ECZSffRGeAdijsrfrJ+e3YgS4tCFNToKqGZGhnZjGvfEMF/h0LUzb1Pe1OQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com (2603:1096:101:78::6)
 by SEZPR06MB6058.apcprd06.prod.outlook.com (2603:1096:101:e3::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6544.24; Wed, 5 Jul
 2023 07:22:08 +0000
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::fa0e:6c06:7474:285c]) by SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::fa0e:6c06:7474:285c%5]) with mapi id 15.20.6565.016; Wed, 5 Jul 2023
 07:22:08 +0000
From:   Yangtao Li <frank.li@vivo.com>
To:     Herbert Xu <herbert@gondor.apana.org.au>,
        "David S. Miller" <davem@davemloft.net>
Cc:     Yangtao Li <frank.li@vivo.com>, linux-crypto@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 1/5] crypto: omap-des - Use devm_platform_get_and_ioremap_resource()
Date:   Wed,  5 Jul 2023 15:21:54 +0800
Message-Id: <20230705072159.77221-1-frank.li@vivo.com>
X-Mailer: git-send-email 2.39.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR01CA0036.apcprd01.prod.exchangelabs.com
 (2603:1096:4:192::22) To SEZPR06MB5269.apcprd06.prod.outlook.com
 (2603:1096:101:78::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SEZPR06MB5269:EE_|SEZPR06MB6058:EE_
X-MS-Office365-Filtering-Correlation-Id: 5fea12c7-08e1-4f57-b7c7-08db7d288a90
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: IV4LrkusXAXi5q7s7vhMo8xTouRmRRRze+/Y1ruLjlOpe2mCklbi+5skP9AodUYjtmSlj7kTISXjPJaUDpJJXFodHndfATTdSU4eJtF8Q7z2N3+mimxoERh5ot5z9m4/XuXAn70w1VXb3W9D0K9/OdfNNxTL2ZW4HSuT+2QMY4vsuKR8ti3rdvfAjERN8xrDSu0pRT4ZGPU7u+bRMm6Z8YEf423jxUHh55zuKp3gdABEKgCC3dtTiNP6R8NmcysQqY+Uz6Qg0nwbB6HMCovTxbwFX4RHjdNr7ZHq6uPe+crPO51ua5MLxlYjupPcmrYWi1mE9cIFJrgQuCaAO4Y6d2FNBZxIxIDsIcncGLy/ixj8MH1L7lmcBbjIMH4eUjpNbLUenrBLbm+e8PWvZz5fNr/LluVGSaaYFjjPmYw3diebiL4rah7ab/ATK+NH6I818NwpIodcJlMK7t0O3DPfKcb30zax530tJMfUQOs14NE7Nf2i44DSapp8koN9PTVJIzsBIBlNyfi188w3ihGcG9UxF7/phxf1V4JkrzAXOqBHllsgRcuZbJwPC+T1SCipMsNRcJQ/xMiGIQ1FYZ+HwvTUwm2ajWdHo9nTZxBj2nCKgVE8T4D+JtPMygNmqckD
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEZPR06MB5269.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(136003)(366004)(396003)(376002)(346002)(39860400002)(451199021)(26005)(66556008)(66946007)(36756003)(66476007)(4326008)(316002)(478600001)(8676002)(8936002)(5660300002)(2906002)(41300700001)(86362001)(6486002)(6512007)(110136005)(38350700002)(52116002)(38100700002)(6666004)(1076003)(186003)(6506007)(83380400001)(2616005);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?EUaH7ayYNHBAIG3D3gqbycE6puQ3KgnrUr0e6NUszXNXe1ISIMXXIBAnorGk?=
 =?us-ascii?Q?g/liuDIUD/u4erV95tQbzuSVv7OwyP/jtCSbO9st+1/Jlhi3oBjToKN3ToIb?=
 =?us-ascii?Q?ajQhWni+tmNeDmdAc6ncFyDR0aSmSj8x2euu0LU1WHLPFI6w9DA4xFWRYkvP?=
 =?us-ascii?Q?xXsT6+Zf26Oq8igGmJ1ua892zvBKCwlY8m4PVbjYHMCZjMZh+zfACT3MPQaL?=
 =?us-ascii?Q?2N+Rp7P0NJE49Qm7fZQgBauRukyP/IFHsAT0nS40gVGenAF+oMv3PgDEu6FJ?=
 =?us-ascii?Q?QBtb0OPwjomDPpgV08caPvKZ8p3SRf3Z6siGeggXpO7HMURPfJ3keDJMRbWQ?=
 =?us-ascii?Q?fQKsMP9RB/Rf5geVsJxlsSyA4GxYKORiDVEfSEU74ie86PGtbsagEfXhD5g0?=
 =?us-ascii?Q?GI68w1fV7+ZSodbRmDIGTyQNVoJNvI6rJQ2K4V5zrWxdUgvNhab5c1KrUvta?=
 =?us-ascii?Q?PnycM0hwzj9z7pisjCoGG5aes4hcFfBt40LttlqvittZPrGQb6Dr5M4j4lCV?=
 =?us-ascii?Q?3eqmPDGMuWgxBdkX/SkO/cBYu9T29boMPagd5AmWt2PdMObkcCKT4cwdcdnq?=
 =?us-ascii?Q?7FyDeGBjba0PqajpdjA9rMUDhQTtM+A4ZNNCbvIfvtKt4PcCevxndM/Nvpgb?=
 =?us-ascii?Q?CKQdsVjpmTlII1aWiDIsvV9G4WG4uzGSR/Ux9M9MCyAM529hn9EfOXBYa7TA?=
 =?us-ascii?Q?kWKPGxSvOlyL5YaYYt4cl2xrpycjxPF1j8i1+beXj42w1bOasEvLd+oCFjSz?=
 =?us-ascii?Q?/WW4PwO4rB7MTl+gwRIvlf1TFIIO83lwH7AOx7OKIuY6tK+wnlC9gobUf9nd?=
 =?us-ascii?Q?QhgVUbkH+4wJwGfAPx5w0UOb0TScQsgIng7D7KEgvrTy4JyWzubUK/bbNzdE?=
 =?us-ascii?Q?oe7Z7jX+F2CpTkWJGXTR0kS5NxBsIbkufle91eWMtsjV40NObIyWsEzGJdPD?=
 =?us-ascii?Q?p8HJzqdAthYrxYq05Hmhw+Fm/UdZGlHmwEefe07XXl3mhaBA7V1bLKXzY75n?=
 =?us-ascii?Q?jHlvwX8Kkr7l5MSHgJKAKHEq/uw8Rg7EKD7HvlM+GL7ZHHFkTNkkRI+7RBVv?=
 =?us-ascii?Q?d0prbEjzumWP5ghYIEh0+dXQNeIP6wHB83Sp0FIXulEd0E8JZL/Maa4HJtZ2?=
 =?us-ascii?Q?wkxvw9xefglWimZXsmyvTWgpeceCkYR240J6p3zZl3sGQzwEXn9YUHCR6j7M?=
 =?us-ascii?Q?2Y6GRMkNHVhkZrui25UdMQt1cMVz+Ynz2/gxGZUKMSsZnAXRtPGvUbP0D0NF?=
 =?us-ascii?Q?iyHFWuxEzpFZXhZFskiba84IcKN/27NLZR8JEZTtlKRjsjxli1Htns4OEZUy?=
 =?us-ascii?Q?Ac4sOpaE/+OH9NYsEj6n8Lp33QVUcLc8dQprcfhVYfLMYsCZe+N1h2BsPBDq?=
 =?us-ascii?Q?fwxJLRvbdrvZbpcYDwdf5xPRtcbERYj1WrQPOaMISLV9LXqrpoKlnUfzP6w2?=
 =?us-ascii?Q?a+SBJvl+jyr6mWUvqIB5qWB2NH0lmZHsCm8F2yQoR2Co/r626SnNptDQw1tk?=
 =?us-ascii?Q?PydYrTbFhpi1V6rMhPDxt8N4C7lLN4O/GE0ztcQ0Y3tC/veeWvJnP4J41+vS?=
 =?us-ascii?Q?Br8BnTbNqmaQ7aeL/MlYCaJEnhSUH50a0vwQI1zA?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5fea12c7-08e1-4f57-b7c7-08db7d288a90
X-MS-Exchange-CrossTenant-AuthSource: SEZPR06MB5269.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Jul 2023 07:22:08.2270
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: lfdIyfJoymqZ2jjLaK0vLEJtiOkwhTHdhZJFqPyXfvj14Ua3tvf+3oqQec0UwvIFl28KseYxuJ/Xvv8C4LBnyA==
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

Convert platform_get_resource(), devm_ioremap_resource() to a single
call to devm_platform_get_and_ioremap_resource(), as this is exactly
what this function does.

Signed-off-by: Yangtao Li <frank.li@vivo.com>
---
 drivers/crypto/omap-des.c | 8 +-------
 1 file changed, 1 insertion(+), 7 deletions(-)

diff --git a/drivers/crypto/omap-des.c b/drivers/crypto/omap-des.c
index f783769ea110..371a51094e34 100644
--- a/drivers/crypto/omap-des.c
+++ b/drivers/crypto/omap-des.c
@@ -971,18 +971,12 @@ static int omap_des_probe(struct platform_device *pdev)
 	dd->dev = dev;
 	platform_set_drvdata(pdev, dd);
 
-	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
-	if (!res) {
-		dev_err(dev, "no MEM resource info\n");
-		goto err_res;
-	}
-
 	err = (dev->of_node) ? omap_des_get_of(dd, pdev) :
 			       omap_des_get_pdev(dd, pdev);
 	if (err)
 		goto err_res;
 
-	dd->io_base = devm_ioremap_resource(dev, res);
+	dd->io_base = devm_platform_get_and_ioremap_resource(pdev, 0, &res);
 	if (IS_ERR(dd->io_base)) {
 		err = PTR_ERR(dd->io_base);
 		goto err_res;
-- 
2.39.0

