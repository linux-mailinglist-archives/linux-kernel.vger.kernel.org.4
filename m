Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A3356749645
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jul 2023 09:21:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233562AbjGFHVX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Jul 2023 03:21:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42972 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232538AbjGFHVH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Jul 2023 03:21:07 -0400
Received: from APC01-TYZ-obe.outbound.protection.outlook.com (mail-tyzapc01on20701.outbound.protection.outlook.com [IPv6:2a01:111:f403:704b::701])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 12F4D1BD6
        for <linux-kernel@vger.kernel.org>; Thu,  6 Jul 2023 00:21:07 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fOjsK0HMV1EfjrUs4xyf9NxcSi+oQlFWyvWJ2JKQEATfWHtM0epET/kuS+NI6Cn1OIanOdJNroZ1y7HDoSEzsJHWa3hnXchrLif5EOjFvEjiQR6QrOmY9OitC32x+I2nHqee04RFwLmkWwtINqPFrSjA50zHce0cmiNLBr+0TfEcdX7cLr1TWgdgbA7TZ8izii1blAveZFKTDKZXguS4fWfEX1K6YgkZDxq+4xiCfaAzCP+HerOAWAwxZvYcUq3vo5UvkzmaxtIt/hGjvf+bkS7abm05f2eu6l5cYFcU+h8cx6mqoP6pyRIYaRolX0nVciylP1zz3fPfPHzEcbGxMQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=y8pRmkKBI8O3MypEM7GtqWqLtYsVpLMjYadD36x7IkY=;
 b=CUKLMYoU9D3JSZjbVuo6Tk4jI3vafkJQz1eJ3mIHDoxZ9+2RWQCVz9OJ4rIFtGiq+UolpvTIC5TLaL1zOwI4iL3udtaB3qmVmTvA3HbZv+kd0AEoRFuvX/v1aSqm4g1ft2znlVcphPvEE6jxE/9ApBJCSssmylTb3cVdzOdPb1y93srkYbTjr3rtX8jd3/VAIi93Db1MgdUiU7IOedWt1b2RoBOb6J4PIcalg2l9rXUCDdWG2XbXEwzfl3TlgmbMg9/ZpqQjPhx++oojRvjDpe9+SlP43/Z3NRz9OHdoDJpNyaDUx5jxMsPZUKX7YJK2vAmTrsLg21oykC5o4/5/vA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=y8pRmkKBI8O3MypEM7GtqWqLtYsVpLMjYadD36x7IkY=;
 b=cEbUO7CgMbxIFjZJb4ambWxqNWlNF89HirJdwWt6O1LG1Y18eLT4OHF/GIdUlMJUaPicYjXz+gwlvXiw54cAybWSw/7v9SNKqy+hNrFbILgb2Qv4Exg1By5q0hAISIl5qa53RykR4kKyHeRL/clCz7c+VHxd2ddnGSDKIh/b7kpbnUz3QlwuBRvhb8g6Ot8D1NMyfLS+rHINvXY80adyYv/AbNkwB011Y1GO1B6lEkg1FyqfyhWbdv+pGPiGvouY0vYnOoUR1GE8jTFgABb5cBTQz2BhdKmHIOm7cN3IZ8kZ6SlVsq8TvpXlnRpk3gWFP0txcj4FzKuaKFBINGtfWA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com (2603:1096:101:78::6)
 by SEYPR06MB6081.apcprd06.prod.outlook.com (2603:1096:101:d6::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6565.17; Thu, 6 Jul
 2023 07:21:04 +0000
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::fa0e:6c06:7474:285c]) by SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::fa0e:6c06:7474:285c%5]) with mapi id 15.20.6565.016; Thu, 6 Jul 2023
 07:21:03 +0000
From:   Yangtao Li <frank.li@vivo.com>
To:     Liviu Dudau <liviu.dudau@arm.com>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>
Cc:     Yangtao Li <frank.li@vivo.com>, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH 6/7] bus: vexpress-config: Convert to devm_platform_ioremap_resource()
Date:   Thu,  6 Jul 2023 15:20:41 +0800
Message-Id: <20230706072042.31296-6-frank.li@vivo.com>
X-Mailer: git-send-email 2.39.0
In-Reply-To: <20230706072042.31296-1-frank.li@vivo.com>
References: <20230706072042.31296-1-frank.li@vivo.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR02CA0129.apcprd02.prod.outlook.com
 (2603:1096:4:188::19) To SEZPR06MB5269.apcprd06.prod.outlook.com
 (2603:1096:101:78::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SEZPR06MB5269:EE_|SEYPR06MB6081:EE_
X-MS-Office365-Filtering-Correlation-Id: 0ccc42ea-d6fd-4216-a65c-08db7df18e1c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: BZhDyyrMZ6a9d3ZTV6lnjAmyqM25YL3HcOzRbqYsCrG1QG6LeTkcuUCwsfHXG7sJGaOO8AowsG7YaJo59bQUBO3DV/CWlyIaCPTTRyD3V7UIKsK+Nr20yVZ2kB6BDbnYOw9hP2SP00/U9va4iIxG65DoXxx1oTSdToxbWsR5vqYOItligbEqhiy4yExVhjqVeKOQWkrpqiRY52/k8/ufhVh8iKxuzuIVgWWGPsYE8C6yHPg74Ug9rx3ZflkOUD2xQHh/n23LKiyB4Au0awl2ujshG2kaKX+AgIB+up1vlU/N+5ozDbPvpu508iFWLTXGbCUURIjUwkEVIi1LWf5fy7O2kstVu1AuOxiQUQ+xDm1iF9MD54R9zSlN6fnshWEuisehnmKlZbvqqhDi/inwdckhqqvOd119fH0Qrq9mTCm5a/h+3CPz1iBlr+8UXEBvTLsfxXCtp9e+qE3lqR4y//OgpxhIZs9eH2rUxftZl8BI5MO+AlFFOZeacHWXJNEyh8+b/0gULfhMCms1XTCkEUEL6PY+LGp4f6C7P4z23dDQR+0Gqtco/FQwMqcFDltlxa7arrlKzkKU+wImRNoir0wPncyDEqoVWvSgjjG9bOdGMm7TydQU+k5LkRDAMRTQ
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEZPR06MB5269.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(396003)(376002)(366004)(39860400002)(346002)(136003)(451199021)(38100700002)(478600001)(66476007)(66946007)(110136005)(52116002)(6486002)(2616005)(6666004)(66556008)(41300700001)(8676002)(8936002)(38350700002)(316002)(4326008)(186003)(83380400001)(6512007)(6506007)(1076003)(26005)(86362001)(5660300002)(2906002)(36756003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?GIep52U+eMn/DMn31q9tLz66MqpE+jTI1+6um5MvCNC+x1874tAsNbhHrP98?=
 =?us-ascii?Q?Jbfie9w6RrvQi9WafwKsF4kmIJAWUDo3cvbJfst+Wo2vM4XhxDslAJh9C1nW?=
 =?us-ascii?Q?UFuDF/WEDsH7GEOiT6cYrNr/U7UL/0Qe41oRXnX8WcOFrsosoe4pyc81PDva?=
 =?us-ascii?Q?vZ5Ck/n/x7YuPvp+htjtoL0iQjEl7g65jjAv4GScL1PX6tNT2EgvILKPsaGE?=
 =?us-ascii?Q?6f5K0QIJ2B1PNYpen+X5bdkzOOGh4xFVUxLHnmQp5JESIUbziMtkA9hhUJEb?=
 =?us-ascii?Q?IiUmcDiEGI7GlDAX0KNL5crukBs/0Vvk0VdtwFvfTO6N+9ymhVN4g/Nferj9?=
 =?us-ascii?Q?rcCX+Qvastb8lhnLXVS3dHuk53q6U0tubEkbZqx2ACOZg+7CxfFnNYqlJIg4?=
 =?us-ascii?Q?c+nP/VZRN0iaOvmVtJA2j9pSXunPvNr/XV7IgMK5aDS7U0iU/ZHlgj6AE4yg?=
 =?us-ascii?Q?0ZjAlqy0tlA2kze8mC7vUyomfZtisLcscR3c7dFrrFhdxM6wEDIWQglMTlfW?=
 =?us-ascii?Q?SvVP0kSqFuVjr3yHi58kH5v37p8QWHllk1lJJPxNaaTLDlIJkU4Gkr4Yobk2?=
 =?us-ascii?Q?WhpoqhxtSH2MHKcFIikwe0KBqmPWgUM3zJ4VrKfchAw76gk8R0H2LxXQh7xM?=
 =?us-ascii?Q?KoCtiuTcUhdE5etIKjhzvlBgNoDt4j3Um5dbzp2vPh3fi299C1Rr75az3xDb?=
 =?us-ascii?Q?IvtygXevy6RvBaapZ2cjOZ1dYbA3wYQuQ8Jan0X2sv7aJBLAXw/hxIWm0Ptq?=
 =?us-ascii?Q?ZWgWs96thBiDVEP5SYeVPdSbXfqsUdjqJLsZ1Xb3G9OTNr3rjQED0OgHL5yn?=
 =?us-ascii?Q?5Lj5DRzmRLGxijl1J1E8Br0oXHYqt6yJ0DKmd4YRmooDhM3Vr6ioY0Om6MMX?=
 =?us-ascii?Q?xmT0qJ9haAYrxvRvv1vwYGmcTE72zNBIINDkSJrn9xjyCKGiPgol7HSxKCYv?=
 =?us-ascii?Q?xXIH/R7dxex0hqhTRSdsSSyzADq21X+C7BZwyGJJDZUykZ3ir+mBvCnZ4A04?=
 =?us-ascii?Q?DOSTeKOlhJJcwtRgdHLoNg2M1ovNgxOnUIEHpAAQrnZPKvn3Oa5gAFGgmj5d?=
 =?us-ascii?Q?US5nl+84Is45fkvSkWgEJSz6G3jinIBwQxzSF6ponUE68mTtnIa7S9vZEww+?=
 =?us-ascii?Q?D6TQw5l1yzSeWTdcBvINMK5dYDZRWt11f94gllRS4Miak40FEiVmqPIBCY6m?=
 =?us-ascii?Q?Sx/l+ZCwOB7SYvyri2TF378ZKSJ8lGKlGKdpK/hQWPZZgGpPdLeicZl+So2d?=
 =?us-ascii?Q?9YxzpYjo7f5OEVyhDzz7lf3R9PCYczi0bb01TorKmSrky85j3ulhYWQd39uI?=
 =?us-ascii?Q?DzA3jqcHfLNjp87yzPKrloGx2Av/T9Nkr+S6+eBsJo2iBHF3mZaPzjIkONLr?=
 =?us-ascii?Q?RmY3XITMWk3OnVUSvESo1gSeV9sCYxXYCWF1YYzHpOit6W1IfHNyEt9uYcqz?=
 =?us-ascii?Q?Eriy7l3hIGv+hft4vSLyrfO+yji8MURywsUz9KYZ2O8bAD+AI8V9wxprBme/?=
 =?us-ascii?Q?XBIhxgBfulDGnlfqPc7Bc7LSFoiefiMiibycZmuuI4NcawdlLtIpAwF3XlWY?=
 =?us-ascii?Q?oD/AKERBd8H8WXZuMwABZxvywAFzjqNVHBnEoRvU?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0ccc42ea-d6fd-4216-a65c-08db7df18e1c
X-MS-Exchange-CrossTenant-AuthSource: SEZPR06MB5269.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jul 2023 07:21:03.0319
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ihOPt8ZqDtzVUD5iedaFtxW0rJjRwfbHC8RYocINnEWXsKtHosPph+CkvZo0LFHYm1KGwY3RkBLkoxsw9/1jPA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEYPR06MB6081
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
 drivers/bus/vexpress-config.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/bus/vexpress-config.c b/drivers/bus/vexpress-config.c
index 472a570bd53a..c4e1becbb2d2 100644
--- a/drivers/bus/vexpress-config.c
+++ b/drivers/bus/vexpress-config.c
@@ -350,7 +350,6 @@ static struct vexpress_config_bridge_ops vexpress_syscfg_bridge_ops = {
 static int vexpress_syscfg_probe(struct platform_device *pdev)
 {
 	struct vexpress_syscfg *syscfg;
-	struct resource *res;
 	struct vexpress_config_bridge *bridge;
 	struct device_node *node;
 	int master;
@@ -362,8 +361,7 @@ static int vexpress_syscfg_probe(struct platform_device *pdev)
 	syscfg->dev = &pdev->dev;
 	INIT_LIST_HEAD(&syscfg->funcs);
 
-	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
-	syscfg->base = devm_ioremap_resource(&pdev->dev, res);
+	syscfg->base = devm_platform_ioremap_resource(pdev, 0);
 	if (IS_ERR(syscfg->base))
 		return PTR_ERR(syscfg->base);
 
-- 
2.39.0

