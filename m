Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AA01B749AEF
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jul 2023 13:40:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232380AbjGFLk2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Jul 2023 07:40:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41172 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232548AbjGFLkM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Jul 2023 07:40:12 -0400
Received: from APC01-TYZ-obe.outbound.protection.outlook.com (mail-tyzapc01on20715.outbound.protection.outlook.com [IPv6:2a01:111:f403:704b::715])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 74FDF1BE1
        for <linux-kernel@vger.kernel.org>; Thu,  6 Jul 2023 04:40:07 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oN99nlQfPICQlQsw8n4f9+9AlimfzlgGshBbSlK5agn5x8S1xolmf4hwTFh2+Ivdh52HR313JbeQPtG/d2QMk64CBAbtOCfTbzGKlQtC8PFV6d3bbrJ5zOJ488ELFn48zJHZD2bBt7Zf7Rdcd9krq+QHbI9GStlAEKT/7ogzix91E8n97cPuHAw+YhxtGwXEdhrVExs7vMPpqz+rKOf3/r9qbjEJq94JXmUXrAIxncEeXRFnicFCwtr7Tv5AkUE9C8fn+Q9TzQFZUjig5LIi89rX6uf4rR8GcXH35KrA/1ZmCIjrSELD9xNnCwtn05LHpyqZYWs5U4CK1r4PZVltyw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/2MHiBYA9ICZTtqbjm+Dtl3zcLbRsS/YtVgq3NRwfac=;
 b=ZfjabWJb6YIxhMvHJimM2dQjs7LBpa6919oo6YTK8FWzBC1zLBk7xf8YFc98PZgRePT20azUoJopAANJfZK2ntKm8VH7nzvNs91xyJuz9MQIrsGNZ3ZKPJ8JyeTzaYzvzo0fY2EuZ5P0gKFt4BJlCR2FyxmDRUOBqzQIZp+rqscauTIbJdH5ZfxPER2rydq+GmQbz3gH8sMBl8VXGX+9nKo5Sg95od0SOMp/jO1NqDvV3eo5gEsrn/XupZGYrE9kpUKSHT7Y/S1BfgjE/A5ggNf6cPXrcDfC1jCQr4tiVCyOO3CXzjZCu5pP/fHotGPmeC6a722B7gPYX6/SFwv+xA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/2MHiBYA9ICZTtqbjm+Dtl3zcLbRsS/YtVgq3NRwfac=;
 b=ZY9sJjUWOhqpBy4waZB9ZDokpnq/7OSyN05IVUIeGHI6dshAJBKxvJhQgk1TUBR0cal3MeVB/2qiDNTDX6wIePrnoKuBT0Car4TBhKe0xPp1wYA0TOeNK7fIuiyCpmikLTIoPOWjj4s6MX50GcHZL64beRg9nqp2t4eOGWBjTq3r+X1tHRZrubl35nNLAR08pxpge3ttweQMeXk2LiyNgfHC2l26eP42gE7HEAD4phvq0pdEKPLPKkjScP+smLKoW0mSzDZQkq5FqfW2CjD4SAwT8ptkDm6rj+s3EN6DLvn4oYl53pR6f8kWDKkoyxRadW9Aqi1scn9JpmitwsMbAA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com (2603:1096:101:78::6)
 by SEYPR06MB5889.apcprd06.prod.outlook.com (2603:1096:101:d2::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6565.17; Thu, 6 Jul
 2023 11:40:00 +0000
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::fa0e:6c06:7474:285c]) by SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::fa0e:6c06:7474:285c%5]) with mapi id 15.20.6565.016; Thu, 6 Jul 2023
 11:40:00 +0000
From:   Yangtao Li <frank.li@vivo.com>
To:     Lee Jones <lee@kernel.org>
Cc:     Yangtao Li <frank.li@vivo.com>, linux-kernel@vger.kernel.org
Subject: [PATCH 7/7] mfd: hi655x-pmic: Convert to devm_platform_ioremap_resource()
Date:   Thu,  6 Jul 2023 19:39:39 +0800
Message-Id: <20230706113939.1178-7-frank.li@vivo.com>
X-Mailer: git-send-email 2.39.0
In-Reply-To: <20230706113939.1178-1-frank.li@vivo.com>
References: <20230706113939.1178-1-frank.li@vivo.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR02CA0013.apcprd02.prod.outlook.com
 (2603:1096:3:17::25) To SEZPR06MB5269.apcprd06.prod.outlook.com
 (2603:1096:101:78::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SEZPR06MB5269:EE_|SEYPR06MB5889:EE_
X-MS-Office365-Filtering-Correlation-Id: d4b58276-9d17-4391-5c5f-08db7e15bae6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: YhCWt7zqqVf3Tlv5j1tABLBwqPo3wyNV+Che+vSi5KBw1WI4mPyiSgexvQNS8WWYgdXtOdT1yYvmc6PfrVwUf4fhjqmY36jEIRsxaXjVIq1DEfOnGdU9QfF0Wy7fDv3jT0A045v1h1dvX0paE2UZZ3OKD1DEeNMntiHMf7khz9yPH1J5SlTY7FjBc/D1tBwd0bYnnfBCaU3laatzvQh59cNpW+z7e8MgegiFlV+0Bdlgt8emnO5nKta95Iv8s+Oco6MpleLyzIl5JNs2LPdyZLbJJGPwm4GaTHnLSafxJ82GHHlH0aWkIxaM9dt4c3j2t0VL0OktqvTCo9rnQGiDpaHVP/vA2lczcLAdXm8D1k9h2XOpSlxb9Oh4AV+OlmtzHkv8V9hpQPnUIaVySFWnOlqEtph2RZozWZuSNy2i3nlADR4lLqwaEa5lzjnM8z7hLhK1dbzLzCSjIdD6qmLCgSOvwJgRliQ9tOjoxJKXi7oWUsVS4v57ucTIwc/EaWF4N7hxCkyJC9Ir2+X8nRoUeWzTZ+5keNxy7zobRhMBKngQBeWwpv7JKiN4run6lQWBRzw7O6/+t2V8+OSt4Hie7b7s3AcxSsdu7+W4xubRWU9yVS2CBzfU21Iqj3T7m+pq
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEZPR06MB5269.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(136003)(346002)(376002)(396003)(366004)(39860400002)(451199021)(36756003)(86362001)(2616005)(6512007)(6666004)(52116002)(478600001)(2906002)(38100700002)(38350700002)(26005)(186003)(1076003)(6506007)(41300700001)(8676002)(5660300002)(6486002)(66556008)(66476007)(66946007)(6916009)(8936002)(4326008)(83380400001)(316002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?+ckSnnVmPButL7MRrPSZDNQq1B723+mBNZj1IsA0OIvmM0NPHLLMQ8lP7sPl?=
 =?us-ascii?Q?OO4PihzF7SJsJVxh29DA6s2HorvEFrdwzDyZbxqmi5o7Ut5T/6d1lk8HjNCu?=
 =?us-ascii?Q?70JcB/IWvXXdkwq3VJ1pVp403Px/8uVBpX5LQeuzXgc5VygeuDeLF2YvaxjI?=
 =?us-ascii?Q?wnsHkKPrs68ulXAitIZQfn7ljFT3pel2B8/UkdmAS/3R40VE2hYuiebWpXp9?=
 =?us-ascii?Q?ebj8/OJ3kjYyJoi1gg3TIKBiy62vpBH36tTDGtViGlBHCfIi4jKWNiHnNGXw?=
 =?us-ascii?Q?zjrjg0RE4V+0YTld3l19Yi+U1smPZIANqmI19SkgbhSFt2ak2GYzGqeoacrt?=
 =?us-ascii?Q?Pfv+EEDd5jR1+I074r/Y9T4CmMT1AWBhQLNg5f560aH3ZnbuObA0oE3yC90Y?=
 =?us-ascii?Q?8b5ovGUivkuXlJaO6D68Xd7m6YILeLdnA9jQrxDwiWWpnrvB50u2WKmjTVZF?=
 =?us-ascii?Q?GEgqIYXjiwucU4CMyd0ZqLB1CrjJbtqr9l/slOIgQVsBMoL7jjefE6suKIdl?=
 =?us-ascii?Q?w8u610xNsWHKR1jv+OYyx/iYvaD0BOs3s+WiIfbAv6tkdy0ayViSC+exIxIR?=
 =?us-ascii?Q?dBGbjEZbbeIMnl5jXtGdASQ6pz/Yi3VkvupGq1nK6FqDB7VRkTUxDUgDTzB3?=
 =?us-ascii?Q?gYYHjgiLtU17LNQIIqagVGE/40qLUAQjznwjNc+zm/zIsiiTTJb/JqTTy+pS?=
 =?us-ascii?Q?NaYR8cfVNMSsOO7hI6JzIKOFd6lMKzAIudIao/C7/cJMmzJqb5QmJ4JCdAA1?=
 =?us-ascii?Q?/Fty9RcwUONkCwtsWsb2vlq1JqsRVb7Te8E5zJvkBHqKXrGJF7nzNfeGPEHL?=
 =?us-ascii?Q?ndk3eCHpX0WFkn7Zkhx7YpbGyRfRskCHR/CTZjiSmPV1DqQxmd6Gy+ZkzBn/?=
 =?us-ascii?Q?lLkIwx4tC+n5DD2yVITyX+REBUlO8Q1hHt3kDasIuwT5m+HMjKTf6u/I4iy1?=
 =?us-ascii?Q?7vGXghDnODt5DlK7I5K/npKOaQWN8fw5QOFKfgymdaTrFIJVKxgc6f6yNZQJ?=
 =?us-ascii?Q?Tvl/x2YsXPYn385qjqQC0n6JijLwINSlblIbGAIvjtz22CK69E3WQrOTB5Bz?=
 =?us-ascii?Q?VqLXxgNXrUyhBOrAqKugdZB9RrAfYtH/9pWFlC8055h56RjZ+7OfvvmYYuUU?=
 =?us-ascii?Q?ZgPsu4+oadQBIX81KJuDNOUDE1e/tBsCp8HNPxHfZWvFEafQsZGpmGi7lNno?=
 =?us-ascii?Q?rGSVjM3dg6GmQTd+o9GsljznC5oJvAWYjqlRNWxuTJvnxZghEKDQX8cXaJRQ?=
 =?us-ascii?Q?xmEbBYrlVqSrXj4qevDKMga7KoUDRQhXqJwSe8qL4iSijBnZNWNXhOo+yiMb?=
 =?us-ascii?Q?DxqzNPC19S2dyH0OwSAt9IP3GJA0AqbaZr6e6nAHI9/nvMe604tJjfE8MSCw?=
 =?us-ascii?Q?vSJxUZgEDvrHFEbF0qaWKRsMrlhuXNxqwCMyMPSVDehuFTwOkXdVOacxoqDr?=
 =?us-ascii?Q?YEaUOsOZMjABJyYJ0wD4uOX2WuX4tWhMXHSAJL/lMUQ/HNJpRvKXneU3pH2j?=
 =?us-ascii?Q?SFsprd0nMy/MOB7cVfumApkuncwdgIGrD6AQ8BWIJDRH5uYi882P0Gs4MfFg?=
 =?us-ascii?Q?HKvlMShZTmTe7zW7tAysiX7ubE6w2djaHJs6kGck?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d4b58276-9d17-4391-5c5f-08db7e15bae6
X-MS-Exchange-CrossTenant-AuthSource: SEZPR06MB5269.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jul 2023 11:40:00.0119
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2SjbS3Ntge+zN8pqEEfJWtYkMiuf2jcDwH4K4yyu/4bSkoPOtDKZIjioNr5SfNcyMwxESj+pBT6TL/2cW8r7JA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEYPR06MB5889
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
 drivers/mfd/hi655x-pmic.c       | 3 +--
 include/linux/mfd/hi655x-pmic.h | 1 -
 2 files changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/mfd/hi655x-pmic.c b/drivers/mfd/hi655x-pmic.c
index a58e42ddcd0c..98ae40ee3f05 100644
--- a/drivers/mfd/hi655x-pmic.c
+++ b/drivers/mfd/hi655x-pmic.c
@@ -100,8 +100,7 @@ static int hi655x_pmic_probe(struct platform_device *pdev)
 		return -ENOMEM;
 	pmic->dev = dev;
 
-	pmic->res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
-	base = devm_ioremap_resource(dev, pmic->res);
+	base = devm_platform_ioremap_resource(pdev, 0);
 	if (IS_ERR(base))
 		return PTR_ERR(base);
 
diff --git a/include/linux/mfd/hi655x-pmic.h b/include/linux/mfd/hi655x-pmic.h
index 6a012784dd1b..194556851ccf 100644
--- a/include/linux/mfd/hi655x-pmic.h
+++ b/include/linux/mfd/hi655x-pmic.h
@@ -52,7 +52,6 @@
 #define OTMP_D1R_INT_MASK               BIT(OTMP_D1R_INT)
 
 struct hi655x_pmic {
-	struct resource *res;
 	struct device *dev;
 	struct regmap *regmap;
 	struct gpio_desc *gpio;
-- 
2.39.0

