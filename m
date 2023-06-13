Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7E3B272E237
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Jun 2023 13:51:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242250AbjFMLvO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Jun 2023 07:51:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44062 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242320AbjFMLvB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Jun 2023 07:51:01 -0400
Received: from APC01-PSA-obe.outbound.protection.outlook.com (mail-psaapc01on2120.outbound.protection.outlook.com [40.107.255.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 955E519A5;
        Tue, 13 Jun 2023 04:50:36 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XhZWqg0DZG3BcWOBLluYIb2AcGITFhdgDIRjjzdwzkuBFWLIeNFukr8suA+dyg8SCIyrWreJR576fZ2PbdMa9Dpe7BbPFeclBRtjqamnh98RPEJp5Gln/FKrpkvQK7CiqcL8siBZc23xhWJ/EOPGdI/B0ZoXmB3XH7P5liG915EBDYu838eHgLbvkVflXBNnvjo6ygRUorFoLUyYaSZRbR8C1Y/fHc+5b9rIOVu0OkwbUEsLl7qogm4q4uxKYcDvrY34LvGTcow122DAe6BKN0bEKFDO1tzrtjbucP/2nFygfEeJNtlg42wgb0Pe48mj7NqkE8E6483sE/PjbHT/Zg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8Pr9qBctCVaevJXoBWp1s+yu+Jl1AW10bs+xBt7Ltq0=;
 b=i+hoySgJsKZ4MLamZ0vOIxb0tQB52SzD60SBQkF8gO8zYua98CME9JUt03AfJ+AVe5o96QNkgpiepDdr1SE6YhEBH1nQHC5IHiBwalVCQqMcxfHlzht3bdPyQNPkebb98BwUSXF48PplAJuKZR1QfKep1jiVfbxFOSM75JGIOvKOOyDhav+3Bv0cLBlxI0ROmnqBRwtA//MXUhNnK7TdBfU6Dh3pTNW0yCNLjKA85Lav99qujOUmHV/ZOekkeWGQ3yLbjSFV0kU4rCw6fOKXGaUyJ0g8t9JTu400x4C6g3WILes1IblSM4pLb9rEt16qA+ioJwObFL7jHLlE2qV62w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8Pr9qBctCVaevJXoBWp1s+yu+Jl1AW10bs+xBt7Ltq0=;
 b=G122aYRP8GeyCcnGayOCqwFHAdHPbiMW3FY1HUOGRcCRL1Ism3Cgi+IBnMVV6r7Gxd+lsXevA5gPe7FwzYjhGoLMSUA4GcYvsdltQBLjp0w4zWZ5m3xXVaLuZ9zF8KhX5xS181uLolzrFOzL0WqnowCkoxN4ok2F055EtgQWcFn3upzR8NHuKQDqsm3MWZGKzFGwkAFZ4HnJ1E3CMGflMyAfK4j+zSx8v/lp3XR6otSsJoK0a+AcUZHzJLPeBHjVU31Pu0BdEE4IUeuS5yxGZudcmKUV4sovp4cyO/Br4KWakGunEnsqvAuqt6N40BJ7sKPhfGunsm6AnQRaBZ0i0Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com (2603:1096:101:78::6)
 by JH0PR06MB6416.apcprd06.prod.outlook.com (2603:1096:990:d::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.33; Tue, 13 Jun
 2023 11:50:23 +0000
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::76d6:4828:7e80:2965]) by SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::76d6:4828:7e80:2965%3]) with mapi id 15.20.6455.039; Tue, 13 Jun 2023
 11:50:23 +0000
From:   Yangtao Li <frank.li@vivo.com>
To:     glaroque@baylibre.com, rafael@kernel.org,
        daniel.lezcano@linaro.org, amitk@kernel.org, rui.zhang@intel.com,
        shawnguo@kernel.org, s.hauer@pengutronix.de, kernel@pengutronix.de,
        festevam@gmail.com, linux-imx@nxp.com, thara.gopinath@gmail.com,
        agross@kernel.org, andersson@kernel.org, konrad.dybcio@linaro.org,
        anarsoul@gmail.com, tiny.windzz@gmail.com, wens@csie.org,
        jernej.skrabec@gmail.com, samuel@sholland.org,
        thierry.reding@gmail.com, jonathanh@nvidia.com,
        edubezval@gmail.com, j-keerthy@ti.com, matthias.bgg@gmail.com,
        angelogioacchino.delregno@collabora.com, bchihi@baylibre.com,
        niklas.soderlund+renesas@ragnatech.se, wenst@chromium.org
Cc:     linux-pm@vger.kernel.org, linux-amlogic@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-arm-msm@vger.kernel.org, linux-sunxi@lists.linux.dev,
        linux-tegra@vger.kernel.org, linux-omap@vger.kernel.org,
        linux-mediatek@lists.infradead.org, Yangtao Li <frank.li@vivo.com>
Subject: [PATCH v3 12/12] thermal/drivers/generic-adc: remove redundant msg in gadc_thermal_probe()
Date:   Tue, 13 Jun 2023 19:49:04 +0800
Message-Id: <20230613114904.15749-12-frank.li@vivo.com>
X-Mailer: git-send-email 2.39.0
In-Reply-To: <20230613114904.15749-1-frank.li@vivo.com>
References: <20230613114904.15749-1-frank.li@vivo.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR01CA0038.apcprd01.prod.exchangelabs.com
 (2603:1096:4:193::20) To SEZPR06MB5269.apcprd06.prod.outlook.com
 (2603:1096:101:78::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SEZPR06MB5269:EE_|JH0PR06MB6416:EE_
X-MS-Office365-Filtering-Correlation-Id: ecdf1ccc-90da-46e7-d3eb-08db6c045ed7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: uhQ/De8QTalBp2/TPplati30U8C7ArrM0M9uiyWsFb+w1zoCfa/iOTdSUStpfJJm81bowZqQspAtYyjmwjd1x7tqlcyu6DPPCF6AnkKyH59FUKsm6alnii9IYa/OHQb4V/ZQZhOm4EhEVPT1xMf+KLkFCdnaWxTeioOzm0yJt6ugJ+vmdD22E1sRDPfeUm6IzgzCbDp/fTbnG3GvTF3HQtmxjxZVLkQ/woEfWiQYcXkwjAzwz1rylFFBRxrsCphLLf2LfsV8U+Ao9cgPxFzS9KmGaUVbAq6GDnH2S5Sd6MKJVQNMXXxjhYW+7Zx0xb3eM9EmfXMfH5jAaVsvjOY593dwh37E+hiY5IgczHSwGe9uqLNgtFn+KHD+vXV8Ai7I/0MVot6+xnxfIwyXljMoAl+fn3FnbkwSw3yTnaFrnOzxpHYqJHYlh6QdTg2nYCY9s7zsW9GbmhXxHBdXmucO8lDBxfLzmR6oVoIkew/2kIuUHVS5QS+PgIFV8T3jgnLslgCsSgMJpbz9eCT+et8aRtAeXtVm7VBJddKa21PpH0fZ88/c5O2thV2rDrGSTE3bI3HsOeYEViV1OnbKVpI4THz4TjqcISD5rwBBicWNRZrpK0uScrJ7CCSHV4tkCr+WkyzuBjWzkSLT3Zx0MczcpMQFxB/x7uykptQ2mTfWwWA=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEZPR06MB5269.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(396003)(39860400002)(136003)(366004)(376002)(346002)(451199021)(36756003)(4744005)(2906002)(5660300002)(86362001)(7406005)(7416002)(83380400001)(38100700002)(52116002)(6666004)(6486002)(1076003)(6506007)(186003)(6512007)(26005)(107886003)(478600001)(921005)(316002)(41300700001)(66556008)(66476007)(66946007)(4326008)(8936002)(8676002)(38350700002)(2616005)(41533002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?DAy/MloQVJQVYSZuKHCgFVLQaeiAKoUewktiHRFPdVw/Lx+ukZZSWjXZDqzN?=
 =?us-ascii?Q?pJaffIxT9HOuS8t3KvL24wMp25p7YKNem2HV68t1BGyInUbi3reqfJsAo82C?=
 =?us-ascii?Q?EnV8O1HEl2h+S3jN4ojGf4lLAu7C+MfsHtB0GJlov+0gCV6SXKJcpL+0Co66?=
 =?us-ascii?Q?4CvrDvjRtrSDZkpuJ1LWWGruG1+d0p3FXFCL/jm9i8Q1XxLAIWfL8xXe3aZK?=
 =?us-ascii?Q?5vQ4L2QFXzsLFocOqXHW6GHMcr5gNqt4igPnOSFlytf4SbI52QoqX7C07S5V?=
 =?us-ascii?Q?czP/JLvHgHf9fPFWSm6eWFMp7NfO6gsHxT0tYihU5ucgC8hQ+WCjrg7lWQq/?=
 =?us-ascii?Q?FI5I71J/HzLPQYXvRo40yoUcsZ4Z2/DbeYKTePbvT4A74HPms5RZddNcsK58?=
 =?us-ascii?Q?ov/mWWCQrYD2LtktMN7YigOBk8S/9ycoaXKwgWOMRUkQ8qa6rYtbg/TiKAv9?=
 =?us-ascii?Q?RX1nONE2toOIwTCRAHak32CyknT/llc8hBVYRNFCfk1GKQg8U1kucyDvDXGM?=
 =?us-ascii?Q?svrSy24GsPw0KVSCRcf/qDqyKjpFYjvtZazijtj8A9Z/eheWAyBfsmruZ7Vu?=
 =?us-ascii?Q?9v6T/AdGikkDBePtGSE4wFP+v2hmc5V/bBl4hMHeh+hC/zmaPCNOtfHe8DkX?=
 =?us-ascii?Q?CtQ/tLhG9WGVRDUzbq0rJiX9XtZa7HFm/Ky8Y3ntcfarwCl/JhUyCMRxwXc8?=
 =?us-ascii?Q?SVrTKnpi2RDYO2tzX3eUcEcZOgL4Z3D6PerOl+5bpxZvSdtzaCx8GdGqgZe2?=
 =?us-ascii?Q?ieIN18q1dgUg6r9PhkzJbfCoPDygpoS/mwL5idrPT6XNF7nC/mdMId70Svbp?=
 =?us-ascii?Q?AQRW/qL788QhWKLs9Ws5DYEDGtG57k6iSf6EbFQWhwDxjaHpJ2o4b9YOGyH8?=
 =?us-ascii?Q?iQ+b4twP77BV6wEJmvx0Hbv+/epNelBPLwyqG2iD3yppv2hNJoK86IYqQmRU?=
 =?us-ascii?Q?218KFvj3FaRA+QMsXnTbB2d0q1httnq8ZNvkj8FfH3s5E0K3Khai49NcgOLU?=
 =?us-ascii?Q?48e9DqjFB+kY9XwBg7DpKZrPUbNtz3AJTEq0DSEEiMnmmw/yYSM0iI8Qpvj+?=
 =?us-ascii?Q?UEZC2orPVXX0kGYTiqUkSce/MPhsI+EU7OACNPUmW7EkKsl5WOff6d5PIUA5?=
 =?us-ascii?Q?T2T9YChCmSNK6oQgTRiFm1JNHLWxHsPvtwUZLDeqHzsNObJAGJLs78GI1Nbc?=
 =?us-ascii?Q?kNt1kk6gcuEuJBRA0Poa92S0wKhfJ77JI9JdA6dKajHpnJFnP7br5+/QrEdk?=
 =?us-ascii?Q?GSj3arDrVMdkTcH8ei2i79GafJ9crQs4f7P0MO07T5cQjuPaYSH2GxU7jB5f?=
 =?us-ascii?Q?R4cr2bBqTp9jsfbyIozAduWeVcT1IhAJO6b05LHfns/L8rl+uLkLJKT4uObu?=
 =?us-ascii?Q?kJvyyCivhRJiv5hfCZWKaUFBElKA0sHXDmFMuv9WV/hruxmjYR91YgiE9F0L?=
 =?us-ascii?Q?smjMkDMfrAmz2mhTG8XXzbbERBAwZnUPWYRz5SnkYhjr7dOxwe9NsTOZ/QVT?=
 =?us-ascii?Q?eWASa0mYfa5ayzKghSdS2EbOuLzrghL+DQAlMwu50usWF5zO4ZBkU37zvGEi?=
 =?us-ascii?Q?DbQl3OATquStAd3APSerVXH8v8xkxsDQ0UnsSi7r?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ecdf1ccc-90da-46e7-d3eb-08db6c045ed7
X-MS-Exchange-CrossTenant-AuthSource: SEZPR06MB5269.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jun 2023 11:50:23.1611
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 54HurNZ5J7iK+/qnVoEUE4F0Cxrh5F57DqoaaJBdQkq2ic8FYvOmv14r5woPIoaivzX8I0cq0VojJWiEQ3iN9Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: JH0PR06MB6416
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The upper-layer devm_thermal_add_hwmon_sysfs() function can directly
print error information.

Signed-off-by: Yangtao Li <frank.li@vivo.com>
---
 drivers/thermal/thermal-generic-adc.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/thermal/thermal-generic-adc.c b/drivers/thermal/thermal-generic-adc.c
index 9531bc2f2ce7..f4f1a04f8c0f 100644
--- a/drivers/thermal/thermal-generic-adc.c
+++ b/drivers/thermal/thermal-generic-adc.c
@@ -155,8 +155,7 @@ static int gadc_thermal_probe(struct platform_device *pdev)
 		return ret;
 	}
 
-	if (devm_thermal_add_hwmon_sysfs(&pdev->dev, gti->tz_dev))
-		dev_warn(&pdev->dev, "Failed to add hwmon sysfs attributes\n");
+	devm_thermal_add_hwmon_sysfs(&pdev->dev, gti->tz_dev);
 
 	return 0;
 }
-- 
2.39.0

