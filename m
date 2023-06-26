Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9527273DF90
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Jun 2023 14:44:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231379AbjFZMob (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Jun 2023 08:44:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40306 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231285AbjFZMoL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Jun 2023 08:44:11 -0400
Received: from APC01-PSA-obe.outbound.protection.outlook.com (mail-psaapc01on2098.outbound.protection.outlook.com [40.107.255.98])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 43E5010D3;
        Mon, 26 Jun 2023 05:44:06 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=l3e+1Ji9lFe/hfVzI/c4ixxWBPLuM6Khfk2ACnzQC7PPU5hR0GBy0whmHxZ4eXNgZAQCoiaSztG76YnvXVWxy34xBRNUoxgoocvryQ6MMYaOlielz+0D4IaDeq8EkmnpbzV9ujsee4eEjPhz3BlwawEX0gmLnsgX/GnlZmB2wlfFeIvRJuz3gdM7Kdfx+7zjDW4xAfKketyFTx/Tp7+gjBRht+vt4EdobtCqt+8nEJhm4AsYp0qEd61NOrW8R91L0uSlJcU+w0WBvKAMgASlUsCnWeO+IynhX5mLcrlMOGt091QGlpnjZtiOQIMAkHmg9L1iNhgOTj5Lj87F4yS0aA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ioGTAIn2Wd+JRgNa5Bg/SoYzMaYuYvU5PSPJ9jcgDrg=;
 b=RaZCaq3/Sy0liMHCfzx6icwhNjyCNPxm6fn2BVqmbxaQpx/finPU/sdJoWlAalvJe0zf8a6OHuKwRlvC+VPl7l5bwAPj/RFRibNDNX3HVLPHBhBGQfLRY9kOr53Xlp08rYiAZnQQcXoSM3vpbGLRS6NOaT5X8wjvjas/QjS1iTU2OqXaBbXxm4GDsKGTr47TVvjZHP7yIJVuawGeq2P9U41yR8p5lYgz459A4SKNklZ7p7V0DKMxFEEo2SKsZBp0u/v7cPG/W9pNnNz7FtNQ47HCYSuM3RGh2HmpU/LJ7Snp02hwXS6zp3nyQ6Kr2hQ/gYIIG3IUN4apY4HGi4hd/w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ioGTAIn2Wd+JRgNa5Bg/SoYzMaYuYvU5PSPJ9jcgDrg=;
 b=QZNwaZcP8uonWZXnlsGBfM+PGGK/8aUerVB2tFAN0iVa2XORsM89bOBh82Au1l0ESZSv7iswtBc/ktoNS4VXK0c540bGSw5Z49nKhhh4N3XnDoLmNfJ0ru3RBtqBh212DNXN7W24eHFgKZhCzcm/Y4mr5bd0UONIsQdZXxdWqGh6E+tb7L6A2OCOg+OrH21cgUNyQFDULveEIwBXyshP7sRfI4BI/NPm+0tXG6sIjfFmRLPtGyfrOmiJX+9GjrpS+kq3NXbMfqhs0wRcji4sSaDzVRstb+RIQMoqIisvHnO7Xr5/asTwezrUpx6rCvzbWudSUtPtAP3t/mj75IDRdg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com (2603:1096:101:78::6)
 by SEZPR06MB5320.apcprd06.prod.outlook.com (2603:1096:101:7f::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6521.23; Mon, 26 Jun
 2023 12:44:03 +0000
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::fa0e:6c06:7474:285c]) by SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::fa0e:6c06:7474:285c%5]) with mapi id 15.20.6521.023; Mon, 26 Jun 2023
 12:44:03 +0000
From:   Yangtao Li <frank.li@vivo.com>
To:     =?UTF-8?q?Niklas=20S=C3=B6derlund?= <niklas.soderlund@ragnatech.se>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Amit Kucheria <amitk@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>
Cc:     Yangtao Li <frank.li@vivo.com>, linux-renesas-soc@vger.kernel.org,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 5/6] thermal/drivers/rcar: Convert to devm_platform_ioremap_resource()
Date:   Mon, 26 Jun 2023 20:43:32 +0800
Message-Id: <20230626124334.15100-5-frank.li@vivo.com>
X-Mailer: git-send-email 2.39.0
In-Reply-To: <20230626124334.15100-1-frank.li@vivo.com>
References: <20230626124334.15100-1-frank.li@vivo.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR02CA0003.apcprd02.prod.outlook.com
 (2603:1096:4:194::13) To SEZPR06MB5269.apcprd06.prod.outlook.com
 (2603:1096:101:78::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SEZPR06MB5269:EE_|SEZPR06MB5320:EE_
X-MS-Office365-Filtering-Correlation-Id: 9e425134-940c-462c-ac3e-08db7643058c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: qrTRQYIVOYZCXXqvaHFl86i88pEM6c6nJ4EKjOWgEM/rH6XoOfKn7VpgVoazKRWhR2zrZVylXyVDC5HaNfLOKefOh4mSiEYsNYnUkotX+BALByE7SwlTMn71jOLbLhN1UWS4CMABYbFn9sP9BEdqtTyZQK/32+u82erLl4ealRGbxEY84VNYkKUNvz8+fq9movwISslNd2pqc4n0T007s4OKV+6mpQRh2SH+SBWO4GwPYbqBHgQVDKwC9h2csr2nlYG8dvG8rdniNOx3+nR7ZuToTKi/oGCXy61gJx4xKicF65p9ersJ2YkhbexqfFwCOltDJKtEiiUxfc3YCuNYaFjzpTCHqfvoOlGi/VQ5gE3lKVoddCmm+aQ0gmI6UDc5uzwmQSFEBK5gTxCnNRxK59jmvpUe7uTce1rDTehw8sbHW8w05zS6ET5pzB1/I5sn2ZPMn5mni1I/gRpRT5niwQb+Q91g0qcU2HFGBTDx/P/gdB2WkDILtWTqQspVwhhNTeZKPV6TCzKQwM1pgP33czWNtss8IHQnIedaOKtc/gUPionHSOi7KQU8msmFNkHKKPjCbaTd98QQBn/qSruLNMyHcfM6toXkjW3CS0ZwXf5dnwTJpMVspjE/WaoVxcC2
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEZPR06MB5269.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(366004)(39860400002)(136003)(346002)(396003)(376002)(451199021)(2906002)(6486002)(52116002)(6666004)(38350700002)(38100700002)(83380400001)(2616005)(6512007)(26005)(186003)(41300700001)(110136005)(86362001)(478600001)(36756003)(66476007)(66556008)(4326008)(66946007)(316002)(6506007)(1076003)(5660300002)(8676002)(8936002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?VpC42RuVzVjJ5vgfnn2qRetO9rAwQq8GEVKNOSdf3lfQfpISKzZ9h+hN7RZO?=
 =?us-ascii?Q?LbwGBsNg/lu9r+mjtHnbZvg5REh/NMke+yd0pHMCGah2uGUCgzYnT+sktDah?=
 =?us-ascii?Q?nt10dsO3dtN+I4k+yvrLAc0FthwuS0XGrF8S22tyAL7IIQhScSN3GShyTRNR?=
 =?us-ascii?Q?C0RJQm+L+EOH1t73c1tgjRQxcNe1xIaKVOck3iEGA/AZnNiLzN0+8TFoBNPb?=
 =?us-ascii?Q?XolIpbf4RaxoXm0ugr8fmIo8tTIR11gYsy8Ld89T9mDlZF/MF7CdjIq0XnHx?=
 =?us-ascii?Q?sSyC7h2ersCRbB7+NQnfL4jsNaPF0TkPRqjP2OoTxIElVEptS2aIQpAZ/AGR?=
 =?us-ascii?Q?YSQICUsn5vmVVOuLcxWOlcJrhPraSRZdMNmPQKgCs7URkxjBl/VOFhuDDX48?=
 =?us-ascii?Q?7lIlBEWlmVMDyhqqhrwwdTfOChzK53iGFLKrPlu2O+N8/x2HdGZ1QgQwwPap?=
 =?us-ascii?Q?skQ/H4FK3DH3hVUYznkvWoqazfvHSNDpi0JnROIOmcwDHICpK25ifjzACHvQ?=
 =?us-ascii?Q?o7ebUK4q/F31+eu+C94UBEHMtG4UIm5l3Dy1fqTIEGPbpXAt/BNmizeLkI++?=
 =?us-ascii?Q?E0iK3Op0One28lcz6C7/GsTsJo5K9aoSw1wZ/tPMs98CBByTEcakzVNid6rb?=
 =?us-ascii?Q?JEJMM6fvFcuOCw1NWjPEgxKXLbpnFHIopt7IuAPDWO+v9aE3tRLNPqFDAdsK?=
 =?us-ascii?Q?+EMPvFV36tAYIuZrPTuAj+l5nfpcyfK4vs0om4bAdzp663ltMktTnOKtu33V?=
 =?us-ascii?Q?iKDdO2xsfqh1c1W+ets0GJLsjgUkyMt74SMf69Dqx2mho+JYLHeGIqvP9rbY?=
 =?us-ascii?Q?QkNUjcsFJOpYPG67fr3GhhBOoIZMw1laMo3ue/gfztEBN0jFFJenhrHARygR?=
 =?us-ascii?Q?vVUyVC4TFdc15TTE9nAT9f3V7jur9m7VKrkgdCtJfXkwbCVKKZuGbxys5iL5?=
 =?us-ascii?Q?0pQxJq/g6wvbn1HKV9QxHZRv9rd2dI71hEoc/Xp0gr7mUoAiEq7sermDWzC2?=
 =?us-ascii?Q?nKNIYZM8aqdBZkmECgCVJz5ga4TD/u5S0C/tXDXQcXDVNxZJpIe2W9NEnANg?=
 =?us-ascii?Q?/C1MTWIfTQEKASxmSi9nCqHLLCgQRKTnEl9WzWJc8B7iVRra9DCE59vpTMKq?=
 =?us-ascii?Q?xWhODXScM2D8CsiyWuNtY0a8kuC6HKWPotQBml1ONbA+omX70t3W4ob7GsxF?=
 =?us-ascii?Q?DuxNWZ8Adkim1dv12YS4svzKGkZGUsD6bhmJ4D3wXgIvwIKbyOo5LXXL8+Ww?=
 =?us-ascii?Q?cOsl/pbCtP1Pq5YT231rg0kH9VgMLRERVGaQvT1JkD6vixtViwSo8EvO+ziD?=
 =?us-ascii?Q?b55IT4IneGg/79Yu+vb9xC4A29yya2MCADNpMjkW2kzIES3gkv4Jy6YX9m3I?=
 =?us-ascii?Q?09fRUbNZEAPmADgMvCEn+ebD2/vRfpIjc5hDAc3uoBr3922XLuMzd2MpFxkb?=
 =?us-ascii?Q?LycRHKXQ59Dd+s8Qqz7EGeR2HOg6viL3ihnWGcfDKqJT7GO3APVb78HBneh0?=
 =?us-ascii?Q?A83OM9t5/DWfKEgRwF0UTacg2verIEtJNBYRj9u4tTvVL8v4gTVLeMFiL6hg?=
 =?us-ascii?Q?TQ5CoGgF1D+RHr6pVDbHEl+iRzwKZk0SJL3YMsVv?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9e425134-940c-462c-ac3e-08db7643058c
X-MS-Exchange-CrossTenant-AuthSource: SEZPR06MB5269.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jun 2023 12:44:03.2966
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: a8fCcJDYlmplDdheLD7wVTYPOm66Z1zK0dQxf6fq7DD51NDZeJSy3GKyqdwSavtYNkXrnTl3F0LJFxpWRsEjcg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEZPR06MB5320
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use devm_platform_ioremap_resource() to simplify code.

Signed-off-by: Yangtao Li <frank.li@vivo.com>
---
 drivers/thermal/rcar_thermal.c | 11 ++---------
 1 file changed, 2 insertions(+), 9 deletions(-)

diff --git a/drivers/thermal/rcar_thermal.c b/drivers/thermal/rcar_thermal.c
index b8571f7090aa..04a52d82022c 100644
--- a/drivers/thermal/rcar_thermal.c
+++ b/drivers/thermal/rcar_thermal.c
@@ -397,7 +397,6 @@ static int rcar_thermal_probe(struct platform_device *pdev)
 	struct rcar_thermal_common *common;
 	struct rcar_thermal_priv *priv;
 	struct device *dev = &pdev->dev;
-	struct resource *res;
 	const struct rcar_thermal_chip *chip = of_device_get_match_data(dev);
 	int mres = 0;
 	int i;
@@ -435,9 +434,7 @@ static int rcar_thermal_probe(struct platform_device *pdev)
 			 * Then, driver uses common registers
 			 * rcar_has_irq_support() will be enabled
 			 */
-			res = platform_get_resource(pdev, IORESOURCE_MEM,
-						    mres++);
-			common->base = devm_ioremap_resource(dev, res);
+			common->base = devm_platform_ioremap_resource(pdev, mres++);
 			if (IS_ERR(common->base)) {
 				ret = PTR_ERR(common->base);
 				goto error_unregister;
@@ -459,17 +456,13 @@ static int rcar_thermal_probe(struct platform_device *pdev)
 	}
 
 	for (i = 0;; i++) {
-		res = platform_get_resource(pdev, IORESOURCE_MEM, mres++);
-		if (!res)
-			break;
-
 		priv = devm_kzalloc(dev, sizeof(*priv), GFP_KERNEL);
 		if (!priv) {
 			ret = -ENOMEM;
 			goto error_unregister;
 		}
 
-		priv->base = devm_ioremap_resource(dev, res);
+		priv->base = devm_platform_ioremap_resource(pdev, mres++);
 		if (IS_ERR(priv->base)) {
 			ret = PTR_ERR(priv->base);
 			goto error_unregister;
-- 
2.39.0

