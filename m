Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2D39173DF8A
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Jun 2023 14:44:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230447AbjFZMoQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Jun 2023 08:44:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40280 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231236AbjFZMoJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Jun 2023 08:44:09 -0400
Received: from APC01-TYZ-obe.outbound.protection.outlook.com (mail-tyzapc01on2136.outbound.protection.outlook.com [40.107.117.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 88627E7A;
        Mon, 26 Jun 2023 05:43:58 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eZBKAR46KuW3U9kIIsCu/037HzrcgTALiiGt4RD8XGOvwAOaePnSzMCn8k6fJlXI+ttCEuxOniidWS+yCxzynhEDZjHQV/NU70zfecEkjNeq31BWJVgW2tm201+4VndKqKgXLbwc3kE9iob3q+7ZhPnQSSJnrlWX50U6rdsUv6+UZtbgPFqSSJjvEDUFB538WKtm3k++M8TNkBjMAdfOFv8HObT82gqKY30KWm27LVnSr52Db0Aw03VxXlPkQ+jiBhJzKmMDLI9/IVhfcvovO6FQqgt6UTIciUPro0dwJjfnFKJYm4hs2CZHLO86xSyd9A6HZrhGDls+mBL0S7CXKA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mvr6q5hIprXukXxxVQEtdkFdgv8kLCz1V0DLeMY6tvY=;
 b=e2WffHwSUUXUOANmUO+8Z+Tlg0KqRVMoTaMq/I3jzKOlX6ecPSXlrpGkmRBNbpOSj3dhb/JtJeYZuafPsIVrvtq9cLdKKlfEBYjSbUhOVRmLRgF0lJzQj2PBKzUbY/1ffo9R2RcT4wLYXTtgKPJLnd5rsy/s1mUPwcBDfSIJ1m4jQjsQqXB+zU4wBrWlY7O5SXW9yDByS2hIgrGpF1vM1PMfW8yIfO6Pa7qVTUcEH+fn6kYUAS9tV7d2xN98Zw7mqFNu6lP68eoPZlQ1/DtI6ADya4J+/8uj/HnWTvJtia4vEnpSCdc0mTBjiY+3xNzBuWzxztgum+32KHE/oumVvA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mvr6q5hIprXukXxxVQEtdkFdgv8kLCz1V0DLeMY6tvY=;
 b=cEUkw8+kdnU8IQ5xRL+qW2ECiIZYSBZ/vH/Yc5CMgFwHVHsrQrN5zN2GZ9QKIkQAz3+rmgZlgZOpd3F2VydwPLN8r9dqfOPbmO7ICPPfrpS8tCvSS+rn0DD4DLo4DE4iYIHqwHqORC28EgtAGq994RFxOl9OjOEpcGiJLYWfiWM/sFmZqcIqoXytKYbnoVVyqEmRDZMumubhz1j2UINsi3xZ+TqqLW/TjGPo1Q5OpZXXwhPsYEpRbwVOj2bxvKa06hLRsWzj4qPpffuoXBQPfJryVPmVbrkFE2gBm3+T8Z8iwXjh34NQqE4/9qXmkyfva/nKzzRDA9CqQj+RtmFxlw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com (2603:1096:101:78::6)
 by SEZPR06MB5320.apcprd06.prod.outlook.com (2603:1096:101:7f::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6521.23; Mon, 26 Jun
 2023 12:43:54 +0000
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::fa0e:6c06:7474:285c]) by SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::fa0e:6c06:7474:285c%5]) with mapi id 15.20.6521.023; Mon, 26 Jun 2023
 12:43:53 +0000
From:   Yangtao Li <frank.li@vivo.com>
To:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Amit Kucheria <amitk@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>
Cc:     Yangtao Li <frank.li@vivo.com>, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 2/6] thermal/drivers/k3_j72xx_bandgap: Convert to devm_platform_ioremap_resource()
Date:   Mon, 26 Jun 2023 20:43:29 +0800
Message-Id: <20230626124334.15100-2-frank.li@vivo.com>
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
X-MS-Office365-Filtering-Correlation-Id: d9f91199-2b41-4ba0-33a4-08db7642fffb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Qj+wInAYy/iMRpi5aZOAl7oHo9m18BiuVZta3iRv4U9y5DWoaHdpVNJ8rWLK/jGhcVxto2fvmr3HIHkEPHev9o0leHrQJHK/HYFrb1McdWwoMYTrwTU8NjN438l+7nIuvLBjo5HzUT8TKw9nS8vttQSMo2ZoHG+++bmBHebxGAvFh5Us5waQdzcusioIhgo31hxFxEkkDObml0MSRvLXqgxEIfn8yPht9NNKW3N7Xe4+ZWavEAxq8xsnT7oUO1IaCisDjLudHjsrHt+lE2Raf6mnWgwJSQkuFXn5P+yDimO/WLNqx62p5gLDbJbQhAwsvkAQwdy8QGqXs/O507vesAuAbI0vdIudEMpsd14PK2hndmxprUIJliIMMHJ1CLkCQBmZVosYCX4U765T3i3ODXuVa57zlVtM3aTFrzpz7oOQ2d+rV0I9D6gOi9jcB0aNqNYlnUytqipLKKGd2S3TJwBeoSqAUxXLCSCIgecRPgrYQmPbnSkGNUmU6a0cwIBr96oE3yAwqKjk+2c0uRuVN4cjiplkiLz3QNgXXNn+g0bYygFm9HH2r2ITUjwnnCy96UwSLPKdI5sLnkIerOtLzMzZ6oILD7SpqdmLArO1qfc=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEZPR06MB5269.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(366004)(39860400002)(136003)(346002)(396003)(376002)(451199021)(2906002)(6486002)(52116002)(6666004)(38350700002)(38100700002)(83380400001)(2616005)(6512007)(26005)(186003)(966005)(41300700001)(110136005)(86362001)(478600001)(36756003)(66476007)(66556008)(4326008)(66946007)(316002)(6506007)(1076003)(5660300002)(8676002)(8936002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?c3CsKWHmMh7UkxD5wO+iD6fhJOl2X5ItZKAInClJw8gAQNGGaMUV51I69QDc?=
 =?us-ascii?Q?u4sSNn58N8R6FSMKgUrQzKuDhI1FrYnY4eTTd454lU53wyNN4OXpfGnBZWQi?=
 =?us-ascii?Q?jxTLhc33/Rx5qIVT6ovUugqBFoG389/2wQcLgHN+4e5KcrN11MveBFXs7cDt?=
 =?us-ascii?Q?GohGVhgkrd7JcQXPnGH3Z0ogyTo5py4aAVi5h1ISh1mYyoxflbgNbQ9jqLSp?=
 =?us-ascii?Q?dq8x+hB4lHMF0qIPZ8dnIMdtJ2+EL4I4MDOoI9WXgK3gkNvuNTxLVdKRRcgq?=
 =?us-ascii?Q?3LXGN2v0eNKCHRJnAyZyZAcw+/wiMyaar+SJcU+og5zirE35mpId7HMIFVUi?=
 =?us-ascii?Q?/+XMu8fXS+xHGeYgWb3cEzw8xlPLjqgKL8QgedCL/lt7QdIS+MMAhZaVzzO8?=
 =?us-ascii?Q?dwL7wi0FXOefvUpOjOYLJiRvaVKTf63ruPqCj5agigvSxM0tUkMhTMqLV2p2?=
 =?us-ascii?Q?FpuUuMGT+TbA8kmym8RbLn5en2X3CTva8A1pnGbMctTuGdJlwdPBh+BOUboh?=
 =?us-ascii?Q?EYfOHNBoKMB0J82KTiCzMx1ZdYGX4MNO0YsdO2h8TGQudc+kttlk+RwYIvWg?=
 =?us-ascii?Q?z6i73UEkD9mZiy1x9aC9laqYlIPUfZkWIei2xm/Of/BpH1Lix7XuWcJKvqsV?=
 =?us-ascii?Q?6zRvp1msjkeTItzOhHekZdi7Acne84yJWZsI7EWGr9JiycMK7PrCYrv1j9W2?=
 =?us-ascii?Q?/sVgwAhQiCa4KhFij4L0qcDrwD1hoFfmXA+JGKBSpxCbUKmj63YtcNDEjyYS?=
 =?us-ascii?Q?OSn6f064+olgB7/a2H89JTdFGVh3pwd1Kcq6ERXNFWDU9O66V+6sVV7A8emo?=
 =?us-ascii?Q?S5c4YSvRNUDgtRkWDc4Gm78F7VVHWkcyrwAb5pRhfdhPdF2lzyWOAYQEkl00?=
 =?us-ascii?Q?una2vGVKhmU2l1niaEeudIeDpH3B+uCAZnm3DDOGA1YPeD6aRC5eh9H0+XI3?=
 =?us-ascii?Q?0EhIbQ9BssbKraUXf+Td7FBMhnc1zv5btQMMDhysnTKXK9HxXA7XENjX6hRw?=
 =?us-ascii?Q?x39bK+5qqu36P7iTg92ULvjfFKhRpbJ14uXyXOM9CfYruNrSTnMAK6kOHyGX?=
 =?us-ascii?Q?PQ+aGQPB2P8KqYvFi0ea0sOx0wr1aMWd5PeU+kgfmsv6KnPBLKilLwm9tMDI?=
 =?us-ascii?Q?J/FPmScT/yQFrNpWjHigSRHQ+zLVzor9GKhAeHCtVes7qqa0BohOFFruwr9O?=
 =?us-ascii?Q?2BI/vEYzpxfIgm9wQEeVUGUysrh+12TIzM912CYmkpK5ezZbvVaJlWmdhWWC?=
 =?us-ascii?Q?ET7oeww3przskf7gh7zZTkRsUB+JynlYhBHs4rfx3Z2wnJ32JEFYh/N7gDNg?=
 =?us-ascii?Q?fSPe8OmByjAn6tvo2x3Bu/WIJqYiakdhvh47+2F/G5yZaHHxtCQf/uq1Tle4?=
 =?us-ascii?Q?ByJUJ/5FiN6fzI0tvLVJtHrqIJhcfE1nl/bOwAN3j+NwRq3M5zF3y0WEKUNg?=
 =?us-ascii?Q?klsn/NetEGPWZyj1TedFpzGFBWa6YpyD3aekDBm8G4+4XdCoaFBcOcOEs1vh?=
 =?us-ascii?Q?7CQV2MiXsbS+WAqr4LZd53fcLfi2LDwJBDS0uGN0alvSYCHVW01SvexRZSyM?=
 =?us-ascii?Q?7zKAgLtDOU9nybz5wRC+3nfIYyl1SA+X5mnijaM+?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d9f91199-2b41-4ba0-33a4-08db7642fffb
X-MS-Exchange-CrossTenant-AuthSource: SEZPR06MB5269.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jun 2023 12:43:53.9451
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9Xx6FMhG254SP34cZ/V3rc2I2iCGup9FANcTETzxT9bJ4pdkSQus5FOUuEgF3ol01Eb1N+YgIHJF6pWALDSW5A==
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
 drivers/thermal/k3_j72xx_bandgap.c | 10 +++-------
 1 file changed, 3 insertions(+), 7 deletions(-)

diff --git a/drivers/thermal/k3_j72xx_bandgap.c b/drivers/thermal/k3_j72xx_bandgap.c
index 5be1f09eeb2c..6c82b92d86fd 100644
--- a/drivers/thermal/k3_j72xx_bandgap.c
+++ b/drivers/thermal/k3_j72xx_bandgap.c
@@ -346,7 +346,6 @@ static int k3_j72xx_bandgap_probe(struct platform_device *pdev)
 {
 	int ret = 0, cnt, val, id;
 	int high_max, low_temp;
-	struct resource *res;
 	struct device *dev = &pdev->dev;
 	struct k3_j72xx_bandgap *bgp;
 	struct k3_thermal_data *data;
@@ -376,13 +375,11 @@ static int k3_j72xx_bandgap_probe(struct platform_device *pdev)
 		return -ENOMEM;
 
 	bgp->dev = dev;
-	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
-	bgp->base = devm_ioremap_resource(dev, res);
+	bgp->base = devm_platform_ioremap_resource(pdev, 0);
 	if (IS_ERR(bgp->base))
 		return PTR_ERR(bgp->base);
 
-	res = platform_get_resource(pdev, IORESOURCE_MEM, 1);
-	bgp->cfg2_base = devm_ioremap_resource(dev, res);
+	bgp->cfg2_base = devm_platform_ioremap_resource(pdev, 1);
 	if (IS_ERR(bgp->cfg2_base))
 		return PTR_ERR(bgp->cfg2_base);
 
@@ -400,8 +397,7 @@ static int k3_j72xx_bandgap_probe(struct platform_device *pdev)
 	 * https://www.ti.com/lit/er/sprz455c/sprz455c.pdf
 	 */
 	if (workaround_needed) {
-		res = platform_get_resource(pdev, IORESOURCE_MEM, 2);
-		fuse_base = devm_ioremap_resource(dev, res);
+		fuse_base = devm_platform_ioremap_resource(pdev, 2);
 		if (IS_ERR(fuse_base))
 			return PTR_ERR(fuse_base);
 
-- 
2.39.0

