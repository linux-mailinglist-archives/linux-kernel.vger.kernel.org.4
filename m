Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1F80D749C1F
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jul 2023 14:43:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231980AbjGFMnc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Jul 2023 08:43:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45424 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231826AbjGFMnC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Jul 2023 08:43:02 -0400
Received: from APC01-SG2-obe.outbound.protection.outlook.com (mail-sgaapc01on2072b.outbound.protection.outlook.com [IPv6:2a01:111:f400:feab::72b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2897E173F;
        Thu,  6 Jul 2023 05:43:01 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lZmfn5Cc0cyXoeZpNFfKOfZMAMTDDjIaBna8Vw+vWBtP1ZNm3UWTUJWw1NuvhmaTZ0p2x9PhpoIfogZ1J8klXhqzZX6DJVbyY2XvcMf8pgukH2vvt6vep1mNcnlDsiJOGO3swxVAfTWGramSlKhYALEiqlGOGwuBoMyurcFiPhmFfmE11onDOhqu4pQJN1udw0Xn5dXu3NzKAH/IySvGRlNUgxkipVKvYy+u1n9C4dFV6n8XLV+/vueKnVRGCUyfWno+yobAIx5kn20cZZEO/bOCFR5atk1tX9iFTee766P+bP+pqL+31zShnIz0IGbNSutZPrk2Eh+pCqDpNEEhFA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/gJ+kc5zqXxGzHZ0TgeaDNa6Cd2eGtYLUPZrc4Vi/oM=;
 b=QVkI+v8cfwj3/V+6cEDR9hUX+SmkvtvNQiX7uvNGFAiwsJC0CQgf+843GETOrLq4x3J9zZWm/BV1lHmV5PQQrX2AD7xmuba/SobM7WndlzHgNkF/MzagdXjO8zpQT9xqOuAAkcx9ziR0dyqcOLR7ZzmUsHI61tOOUK3uV7GLqC3WE7pN5BE0wl1tU+7t9jzGZ51TlUGCiFO3uHnsFObzWskzIKJFt3dGYxoBdwZZETqZHLAmj3AnDVFSZiLzxIP3ep/qMJZ1gj7TznfbUTJKFDyhplFu5ixcv3F9dywbiETU9uRrFwfTmwemyxzgkB94Pei0PD2PYox3a3Mdit41dw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/gJ+kc5zqXxGzHZ0TgeaDNa6Cd2eGtYLUPZrc4Vi/oM=;
 b=cIedfWcQNTqTuk7YSN5lMk2k9LYkRYOnbnC9jT7OwKEmyceR1k5drjkCBYInvlvMS1UGhjvjUFDtMb5FvKoqKmvF6X/WFHZYsMTSOEFdQPWhQt10fIiL5OcATdZO5vqDkjHc73BUi0u8+aCgDflLZG6onRSq6f6x+jnOUBdCwwEW03BljDq9v00b/SVEvfNj3lMBASOh7CJZjZdRHALiQt2slO0KVxjBRokSqKOmuqF742ZeYHj1FYdbbEc8b5ohAParwTsAKhtCW948ayOALq/UHvJRJLCcrDnS/h3QZHT6o4e+hku2o2P22tCLD9ntA45firccLPU00edV6KioUQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com (2603:1096:101:78::6)
 by PUZPR06MB5602.apcprd06.prod.outlook.com (2603:1096:301:e8::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6565.17; Thu, 6 Jul
 2023 12:42:57 +0000
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::fa0e:6c06:7474:285c]) by SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::fa0e:6c06:7474:285c%5]) with mapi id 15.20.6565.016; Thu, 6 Jul 2023
 12:42:57 +0000
From:   Yangtao Li <frank.li@vivo.com>
To:     Sergey Shtylyov <s.shtylyov@omp.ru>,
        Damien Le Moal <dlemoal@kernel.org>
Cc:     Yangtao Li <frank.li@vivo.com>, linux-ide@vger.kernel.org,
        linux-renesas-soc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 5/8] ata: sata_rcar: Convert to devm_platform_ioremap_resource()
Date:   Thu,  6 Jul 2023 20:42:35 +0800
Message-Id: <20230706124239.23366-5-frank.li@vivo.com>
X-Mailer: git-send-email 2.39.0
In-Reply-To: <20230706124239.23366-1-frank.li@vivo.com>
References: <20230706124239.23366-1-frank.li@vivo.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI1PR02CA0046.apcprd02.prod.outlook.com
 (2603:1096:4:1f5::14) To SEZPR06MB5269.apcprd06.prod.outlook.com
 (2603:1096:101:78::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SEZPR06MB5269:EE_|PUZPR06MB5602:EE_
X-MS-Office365-Filtering-Correlation-Id: 28c83ce9-53bb-4071-c66f-08db7e1e861d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 5MK9lrZF4LInQcqL5GLSUQ9gEBuuD2WZwJNYQWIjUEG6I3nzSIcjJ9KZo5AgjiT5KXkFvhUfoQg2qYuigNhmrXwyRiErEOgb+iTC7j0/GRlhYkeM3UM7bx2yUPTOlj7f5YtNdFvl4WeEgMUin8S6wdsdlBuYE1RbC7TIHw98728AHZsmxIYfhmd7yjAKagsGjCCyNV2yE/JEuR66SE7c3sssXka4sMmV2X98M4dsL7NOISBW4YM+wj1cv13ufHeKJHhGVCkG+xAp+es4MsMQcJHytkrBwomnYoqSAECyKwkA5MSWfeC34fd3ba9Z+y6pBqNae1kCN9jgh3SkIVczE6NVBKVhosX3o4uuHGxc5PAzl2zrk1DGHrKGTrBsKG+/Rq4r+0WeLO0bXuNC9zd8h58CMGA3JrpDhA6MKuhVJNGeNYSGSEHSE/F9xgbQLZFPLGTaeyBIIMdbGUEYxNYhzwfFwp40A5FKvWxF/7xK8Z3S0eD2wM9RCkRXSe01IDOpRf4mZbhvk2Alj2CCKCRgGfcBJgI9E5FghkJIqGWyDHsCrPhBmfiiT71SQN0EywZAokbMIhVsxWd8UNSNdtrPCkublezjFVoih95vNT5lPMtoex5j9NNABAhunoJ12H7e
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEZPR06MB5269.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(346002)(376002)(136003)(39860400002)(366004)(396003)(451199021)(5660300002)(41300700001)(8936002)(8676002)(2906002)(316002)(83380400001)(2616005)(66476007)(38100700002)(66556008)(66946007)(4326008)(38350700002)(6506007)(86362001)(186003)(1076003)(478600001)(26005)(110136005)(52116002)(6486002)(6512007)(6666004)(36756003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Nvj2UbdWBq2sXKdTR4/XOMnhHPGSgYa8RBWco6B0FWwT9fQOKWbGzlMHSpay?=
 =?us-ascii?Q?oiutuy5alut/AofYt1Ev8W7BLhtmZzoNbJJzdQSL/6GcMZzHNwfuvvQsvYmp?=
 =?us-ascii?Q?ZNE2xUG2RsTiylsV7R9ef18JVU+wcrr9vtdOCgHBZwwufnyGpE7T0GIHdWua?=
 =?us-ascii?Q?X1HjpJXb4sXApT2G3XqCadzkt4n4AOIfUEdS6G1Ad9YgcLeAMs3FzXs172nw?=
 =?us-ascii?Q?6MhAE8MZnLxXu+cXri/UT6s1gGg0CgQctymTY3dFGMR3+sn9GEJZASDcxCnQ?=
 =?us-ascii?Q?BZR0ghlqiwmqYt0ny/pIoX/wHIqKNmfFoinBm7rfAnQ6KIVOgVx6yvaaQxvH?=
 =?us-ascii?Q?30yCHrOvPWQrdKHfZLJi4qb6aVtDqu4bgTri9llQM8iYzEjtbAKGyLKHomRO?=
 =?us-ascii?Q?zewT/azA7ehIJo4ipkbDQxV0B749X3vw5yWC5Lur8eATH8+cdN/wNWCbyCH3?=
 =?us-ascii?Q?MZ+8QrHj6uqgq21Rxzek8XHjYkytugR8Cb6pKcczciyXq3LkfUkuyng4kiCc?=
 =?us-ascii?Q?Ba1me0LLKGKYhSGucOQEDg17xKb0d5GE+vcSmAGPJr72eBRKVLxsFLcTexNf?=
 =?us-ascii?Q?OhkhhSD36TPZKgEbiUMvcVn/MLa5iTx9bbEMkdEZVLpQJYMV/a+zSyXwKMNv?=
 =?us-ascii?Q?pWVMbmSOd1Pq5LEadi0jwRk1J5bjc2MkjxULgdpZ/eSgOrfnJmmhItNv3hLM?=
 =?us-ascii?Q?6qQAlB+lwfmsWKuKUENe/+3vJWgmL+PHkb9ONiIBgYWMyPXMEezbJcZW+1SY?=
 =?us-ascii?Q?8c9QyYYzn2nd337D5nqcmm3YHC+ah7B74bdbubQXLgcWEYMZZpLPxbh9gqEd?=
 =?us-ascii?Q?fRSkYbbyI9CSSnOC4eFPb+5srbQVimnJDxvIQYJhAQlyLTr5n6b3WPUeS8AM?=
 =?us-ascii?Q?JNaLKrtDS6zOYTAjNPWaU2s+2g19pOdiDloAYJtUPq+kZ1vnSdjRAcbgXGBM?=
 =?us-ascii?Q?kE3oLL74JDldD/qnxvPhNZeBbiEeYSLs+kejdE8JuSmGNNK10ORcnts26FKG?=
 =?us-ascii?Q?QKW5rsvIjWMn3UiK8l6bjLEmeHXq7ApjDiUgn43BBxrURd4JwkolhBluWJsL?=
 =?us-ascii?Q?oVUq6A8fcLdVzZPd9qBsFMHl3hjEEoGCWYbwj/6FJuWGMZl+JDYDH/7/A/bA?=
 =?us-ascii?Q?Uaqv3ZD5vTy7JJx5G5DaOXdqgzIyStLcxZcrIk9wl/NvMS29hORbNnAteAzp?=
 =?us-ascii?Q?KkGUmOfsJ548Ns/bZ28arxvqA3HHSAX10NCNcSutQ9n14kixcChZELt+SIh1?=
 =?us-ascii?Q?E14c1ynDShg0xN/c3yoRwYJVQyDEbWCsoomv6eVPTyNVvly6wNPvhouASbi5?=
 =?us-ascii?Q?zNWkxqtQ+2RYoj8ly3iP/aZH4MGEzkK+Fyj7LYtKuxfeUzR64BEMy1qsmGTz?=
 =?us-ascii?Q?Ka1f3MM/3To+YqMl2729L/zhaLURqfVm6pIZdn6MAuZC8syGat41RswNXmEK?=
 =?us-ascii?Q?l7UculeFENLaUbCKSyzQRctW4FAObnHJ3oZNLSc8NF/0I3OaH+biGvzJO6Jc?=
 =?us-ascii?Q?ZsoggBhXeunsiZr/NzRBAoKToHzgZnR4SDLO4peBfblw+eA6hobQISLu8LkU?=
 =?us-ascii?Q?fUsXIKvzo5evDByn7x1R3fChvld07TQ5wQb/VDhN?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 28c83ce9-53bb-4071-c66f-08db7e1e861d
X-MS-Exchange-CrossTenant-AuthSource: SEZPR06MB5269.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jul 2023 12:42:56.9640
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Vh/nnjHe2ikVp8mu+cN8lpxDtAHjdIJm9s9vyqbga4Ji/lDbACcKQdSmWvFu3RSHbo3oKZmHe07d6vn+8vQ4hw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PUZPR06MB5602
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use devm_platform_ioremap_resource() to simplify code.

Signed-off-by: Yangtao Li <frank.li@vivo.com>
---
 drivers/ata/sata_rcar.c | 9 ++-------
 1 file changed, 2 insertions(+), 7 deletions(-)

diff --git a/drivers/ata/sata_rcar.c b/drivers/ata/sata_rcar.c
index 34790f15c1b8..63f8337c2a98 100644
--- a/drivers/ata/sata_rcar.c
+++ b/drivers/ata/sata_rcar.c
@@ -861,15 +861,11 @@ static int sata_rcar_probe(struct platform_device *pdev)
 	struct device *dev = &pdev->dev;
 	struct ata_host *host;
 	struct sata_rcar_priv *priv;
-	struct resource *mem;
-	int irq;
-	int ret = 0;
+	int irq, ret;
 
 	irq = platform_get_irq(pdev, 0);
 	if (irq < 0)
 		return irq;
-	if (!irq)
-		return -EINVAL;
 
 	priv = devm_kzalloc(dev, sizeof(struct sata_rcar_priv), GFP_KERNEL);
 	if (!priv)
@@ -890,8 +886,7 @@ static int sata_rcar_probe(struct platform_device *pdev)
 
 	host->private_data = priv;
 
-	mem = platform_get_resource(pdev, IORESOURCE_MEM, 0);
-	priv->base = devm_ioremap_resource(dev, mem);
+	priv->base = devm_platform_ioremap_resource(pdev, 0);
 	if (IS_ERR(priv->base)) {
 		ret = PTR_ERR(priv->base);
 		goto err_pm_put;
-- 
2.39.0

