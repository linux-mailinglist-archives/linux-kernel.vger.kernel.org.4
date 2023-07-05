Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4602B74841C
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jul 2023 14:27:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231441AbjGEM1H (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Jul 2023 08:27:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41636 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230268AbjGEM1E (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Jul 2023 08:27:04 -0400
Received: from APC01-TYZ-obe.outbound.protection.outlook.com (mail-tyzapc01on2123.outbound.protection.outlook.com [40.107.117.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 485ECBA
        for <linux-kernel@vger.kernel.org>; Wed,  5 Jul 2023 05:27:01 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cNKfpod5AOoUYft88SNNziIXHtT3ruM/RLB9iK07BmtDmtQHsgApTmvrIndYSnrx5GCgivzm09kUPqkpzDFhGbAtyb2L9xKkTjyWsFzIT+PDBMYvNutFZbx7q7gj+/UQsuUqTbZUOfQE0H2BYfU00YAxlaxkbm4lxqwXGrdpolaxAYzHoM384FEp67kmjwAZOlxDQPOa39hBsZgUI3Cdvf8MFXeS8AZ2vMccQfXEjVxJWdR+npVxVdamZWNazAFLH6Rwc92yXErW0KXyoEcy0Z/N619LjHI/1qLpednPMBHsNp5juEe2dGRh+OMb3dT3UMRcl4Ht2yUptfO5fde6lw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TFxHYJR/4nXa4lOf8EylzoBGBV7GiyifWeeoPOewGLM=;
 b=L6Z19SchOdoPEB/nb994itO4BKpPZbrncuuKtK++9FA8EcGb+Juo4rWfaIrDveEvXq3vmcC/TXVd5bKGUNrPkA42LDhJAB8ExOQLc0h7S3lD5Fo3gGzR2zRQkpUIJFtDFgZw8f0qB8mK+1sdjbv9Etieaj9FBrB0gYmmZ3HnDvybtgw9LhESaJFE71vLDmCgXTvsQbwfzlXW0bd9h1t7xG8kWjfVpHsF5M6id9GM7i/sOJkSgDvaTAeD5i6FQXIvm3edRFuH5T007IvZ4/v8kFEs1ZiHuAIaAFPFknR/IKXtHvm1oXptcnFmb8+eVmqo19gKOs23hjQ6g3q2Gy+L8g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TFxHYJR/4nXa4lOf8EylzoBGBV7GiyifWeeoPOewGLM=;
 b=NpqictLgMt+dcilr+SAyCxwUTPuelPwHj81JBNe8NRMAjFZmgpW2dF5XwIzDLdhrlzAkGWXtp9BZjmRzZyCaLdZJlBoy9hpbqNTeowB0tl3A93RnjEOaOLvFq1JVKZYWcUSg5iqEhlyG72H0oixpRq4Et2hjEwx80/j8V1qMuIxA6PrFal9ZOhLt1VFxBsj1yohe1Uqy0QT1G9bqINXd5wylr3bXb7Wg379icUD0wN5mYMnrpTcDD11DuFImnCZh6mC0LC6+M5YZ8rGJ6n66rNcjYCe5SMNtdXEb5Gfj4is2fBqVfjYnA80TjhFpk/2Ae8hEp+nPlrT4S8oHpb+Mew==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com (2603:1096:101:78::6)
 by KL1PR0601MB5551.apcprd06.prod.outlook.com (2603:1096:820:c2::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6565.17; Wed, 5 Jul
 2023 12:26:53 +0000
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::fa0e:6c06:7474:285c]) by SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::fa0e:6c06:7474:285c%5]) with mapi id 15.20.6565.016; Wed, 5 Jul 2023
 12:26:53 +0000
From:   Yangtao Li <frank.li@vivo.com>
To:     Nishanth Menon <nm@ti.com>, Santosh Shilimkar <ssantosh@kernel.org>
Cc:     Yangtao Li <frank.li@vivo.com>, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH 1/6] soc: ti: omap-prm: Use devm_platform_get_and_ioremap_resource()
Date:   Wed,  5 Jul 2023 20:26:39 +0800
Message-Id: <20230705122644.32236-1-frank.li@vivo.com>
X-Mailer: git-send-email 2.39.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR04CA0001.apcprd04.prod.outlook.com
 (2603:1096:4:197::12) To SEZPR06MB5269.apcprd06.prod.outlook.com
 (2603:1096:101:78::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SEZPR06MB5269:EE_|KL1PR0601MB5551:EE_
X-MS-Office365-Filtering-Correlation-Id: 3905f0a5-50cb-4d9f-524c-08db7d531d53
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: F7Jd34oUih0LCrl7mUVGuJ0uQttoFIK8GMjWkjxT/pPJfxfg3s7yhAR6HI+uxVlgXXMNEa+Jl+s55X5tOxoV0UNaX2U6X4zgQpiE9tRAGI+AnYLo/rEd1C5awg03KIdWPCTga1Bh5b9HYyXCjaL1ytnk8s8plQfUIBEU05cz6uzJ97tp/H/h9YBR+LNThvO/PVCl9QEBxUzJ09lTaERV1AAo6HFpRtfEwvXK6279pU+EJFbWslYawi1t9Jhfxkv7SN1+aZpbpkLmfIN1vgbC3LsTOVtbTul8BfeXdlEqb6fPUkHOwm6hwqmxnQ5TLt3cv9XxLrEmCGhWE0olLJMGSJD0QLKZ6uljPtMslpVnONKwnS0tpdGvO1KdUfqvZ8aks9wU90GSMLVVdZwHXUVxe1admTNFqdIwOaYEY9dG5d7Li4A13JchmTFEPZ42vEpn5uLR8y3ung1HCJeCPN/ZcRXPRhy9VkPLk3aLOKUpQnDgSlBRmA6ZajXxZA8T4IoznlKBJVkD6r+VD8Wqb7lMLAUs6kLnkzxPuQvrk0xLIRmcz4MmC/4RWkwwm/R7ePdoEIPH+oIBXQoE27jJyFoYwUIyZf1NBxp6UXRaGqBWjkn5JEgDFYrFseuyhWbJXgou
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEZPR06MB5269.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(39860400002)(376002)(136003)(346002)(396003)(366004)(451199021)(5660300002)(8936002)(8676002)(41300700001)(316002)(2906002)(83380400001)(2616005)(66476007)(66556008)(4326008)(66946007)(6506007)(38350700002)(38100700002)(86362001)(186003)(478600001)(26005)(110136005)(6666004)(1076003)(6486002)(52116002)(36756003)(6512007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?SZu3yCWxqQSDTdAQ3ITPSJhckcbhiMZmIvn+iLR0t0UYD9IWKJWXSpwrV0yE?=
 =?us-ascii?Q?5nT673qg8/ApzberEzE9pJpzBUlNrNosXWjMxpRemDKZYyzpUdQqCIik+iDw?=
 =?us-ascii?Q?klDyit8Jkrruk0LEXz3gBYYVJ7pMDhbPFrCSpUlV+JvzjRfSoi6XoohBYaca?=
 =?us-ascii?Q?oVuDkIztBC+MoaqdpxBGVuUJY1dZD4tMLXQ1KZ18E7yGaJIZr3o5keuaY4ID?=
 =?us-ascii?Q?FNc3FwrrqvROiAqzto3DdBZ5kaWevlEfwgOY3tPbro4mdI+QODG6+X3edoNK?=
 =?us-ascii?Q?AJvMgQB8vKvXhgg2JRZ6W8TJ6+hOangOekPZClUKcAvG49iWdbDdDA1Raz+q?=
 =?us-ascii?Q?dQ9Hp7NyQEOrifzWZksZlp4xZBxhTmT0zSRf1iNgGB/pOunhsF3IPdpz326j?=
 =?us-ascii?Q?mk1fc+GNImhGD95QnLRZpChfSMVQGlH6e550SppLpYUSYLEr0oXjEOPDTLx5?=
 =?us-ascii?Q?hnxjrrai03DfFcUA+TXS8oKWjDZaiweV6XYhmpkwG6nLteAPgx3imaj4tKj4?=
 =?us-ascii?Q?DFW8N5BspE22JySFryIyM5UzXdmEV4NleO6CgXMn1qfLY6lbtEmrXbddC2kN?=
 =?us-ascii?Q?tH1t4lrtsUV28GMtEsvLbNmHh7QBtff1uhikI5552Lbak/5HDxGesDyTy2TU?=
 =?us-ascii?Q?YEmmjfWYTNftiAZwRcg08g22/EnzwrGdxQ68wC5ENOqxyxRTON1KgyrUU1Om?=
 =?us-ascii?Q?bC2DstdCA0BDTv7wvwE91gK5tUIqcaGhd6LC/jKxOor8uxZ1eW6KLgfcLFe/?=
 =?us-ascii?Q?iWuMYkpo8HqE8lij3dR27mp1WLOaudqmzDg/JHy+QbJ+IgXcUZvTKd25c4jH?=
 =?us-ascii?Q?k00oRtMA7b2WgdI7x/cvQ5LgL1A678CPPWP4YZ5dWsu413u30vckj0uqDSny?=
 =?us-ascii?Q?WSajMqnfN5Yje6/JUwZzdo5d8lXf/BxiIDbErHqQ9ZW0YziJ07QpstDbEJAy?=
 =?us-ascii?Q?kc/hLQ6sLbL48koS4PXp9/seoObjWqMA1u18AVi8a7R3N2yuUD1zbwSvF95M?=
 =?us-ascii?Q?9dtYyYEN7q/uwXfeausXkDvLt0MOSVJrb0bM8mcrLbB54ckp7G6zZgNU4X4E?=
 =?us-ascii?Q?QMoNMESJKGncq1X/6ZwuqAdFEy0SgG3Ny1WLbIb/UVHKat8O/EdTw5MNJXrw?=
 =?us-ascii?Q?DIV2NWeigxejchbp/VA385gsxwvqKqiKB00L4U4p2osG84g1oy91Q4K8YMox?=
 =?us-ascii?Q?FOLMKpj6PkqnhbQzIVjz5LCG3W/dhmTWkz+qEEWDmw4RRDFYRcpWOr8qFLQZ?=
 =?us-ascii?Q?SWePFzy1jQ/1Zv254hZSO7GH4TsF9STmP6y7D86wIDyX37IiPrk6aPMU0oJ7?=
 =?us-ascii?Q?NjbZN4s0uB+1QUbC31g/NxKByDjp3KJj3pFA9Od4fZRtyYq+wretzm32dQ0M?=
 =?us-ascii?Q?Edffmytzg7N7D5QwFYfnp/ZXxg2hweQI7ZEzWBudKkwmHihFP7LD+BCn53PL?=
 =?us-ascii?Q?Hw9bGPIMB3vJe9k3Lb4tyJfENiaMct78Wyt0lq09KvuGSYyzQ3WnbDSBxckn?=
 =?us-ascii?Q?TsrOTD95B8Srttz5TNk2mQaBuxyJ9tGfSAK/PUvw0Ucp2Zibq1SU0F1slL4Q?=
 =?us-ascii?Q?4aZDSHyCvFFoFDwDXrpGxqKZinQJJdZuX8iMtGAb?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3905f0a5-50cb-4d9f-524c-08db7d531d53
X-MS-Exchange-CrossTenant-AuthSource: SEZPR06MB5269.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Jul 2023 12:26:53.2357
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: d8IEr/OmZIqsUBsSoil97Hw1rMItzaTedLQkLW0J1vIcitMvxKN03esv8zLp6NFlnLXbHrxOh0++cM85Nn5H9w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KL1PR0601MB5551
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
 drivers/soc/ti/omap_prm.c | 12 ++++--------
 1 file changed, 4 insertions(+), 8 deletions(-)

diff --git a/drivers/soc/ti/omap_prm.c b/drivers/soc/ti/omap_prm.c
index ecd9a8bdd7c0..b2cf0a1810b9 100644
--- a/drivers/soc/ti/omap_prm.c
+++ b/drivers/soc/ti/omap_prm.c
@@ -943,10 +943,6 @@ static int omap_prm_probe(struct platform_device *pdev)
 	struct omap_prm *prm;
 	int ret;
 
-	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
-	if (!res)
-		return -ENODEV;
-
 	data = of_device_get_match_data(&pdev->dev);
 	if (!data)
 		return -ENOTSUPP;
@@ -955,6 +951,10 @@ static int omap_prm_probe(struct platform_device *pdev)
 	if (!prm)
 		return -ENOMEM;
 
+	prm->base = devm_platform_get_and_ioremap_resource(pdev, 0, &res);
+	if (IS_ERR(prm->base))
+		return PTR_ERR(prm->base);
+
 	while (data->base != res->start) {
 		if (!data->base)
 			return -EINVAL;
@@ -963,10 +963,6 @@ static int omap_prm_probe(struct platform_device *pdev)
 
 	prm->data = data;
 
-	prm->base = devm_ioremap_resource(&pdev->dev, res);
-	if (IS_ERR(prm->base))
-		return PTR_ERR(prm->base);
-
 	ret = omap_prm_domain_init(&pdev->dev, prm);
 	if (ret)
 		return ret;
-- 
2.39.0

