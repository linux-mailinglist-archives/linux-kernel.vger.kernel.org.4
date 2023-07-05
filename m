Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EDB0D747D9F
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jul 2023 08:55:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232046AbjGEGzT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Jul 2023 02:55:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56038 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232029AbjGEGzA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Jul 2023 02:55:00 -0400
Received: from APC01-TYZ-obe.outbound.protection.outlook.com (mail-tyzapc01on2122.outbound.protection.outlook.com [40.107.117.122])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A8CA61BF7;
        Tue,  4 Jul 2023 23:54:27 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZuqpYIiG4JpunWOhXyuvHsj87/TJdnZCAHz/UzC4bsl1QUjZNm9tH9lhJVv8B2lRZWaLHK0gefnNWVy6adhPVzZkXw2iyoB/oLhx+H9UjgaDRaD/fHk0D35ek/FZsyusgq9jPbWHxjzMqpS7daraECCgwRmypCD59QWC8olIr59wFSxuQi1fBZNVPopOZg8kuJ+C6ioYc0aC8ICloWnJoy4By/bnFwm9SGV129S+icRUjgZwGJa4cgAqsHDWmNtFqpp0AHIp1ufuWUs8k4V/qPvSrNyCgRu9plmgvQ+86L0MMI6Q0NJBuH0UpdMtx7dO4rp1qJ5Qoi7kWF71mincTg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xR1DL/vFBmz0SgAEn+k5xGVjFO5PdALrdwptsjpJNtU=;
 b=G6zzd/dKlFhTMKOHJ3Iu/umwmDryNy/UsoaVjXuRMLn6hLjDHNhI0j+yTDUNwWcj80YqnOD7IxC3zt+zcV+tRhze4PI76VYhqjnTCuomWMjQxtP8+x67qY+OBigMaGwRHSrOJA8I4FNU+e84UksKZHC79YkLq5IzSgpZD5ZbCWKxqvOfee4EUhYAfIRbPmG0amQiq6VKa74+wR1fm332oBjt7TySzNHCx95hjvO5YGK10FRWUtyYIGKQwUaCVCi6NIUvMieCd4PSWYXAQ5I6VCxmyNsF/PDfdVrGiBVtdDE1K1PXeZJOHe8wY+z3KkaTfNY9IqnLWYJWmQ/qE+4R/A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xR1DL/vFBmz0SgAEn+k5xGVjFO5PdALrdwptsjpJNtU=;
 b=UfAuSfjtscQyB/JUrHW1G2p2tHPpXWKY5IhYTX+0B9u3KciXY19SgU4COE9wka8MX93//D80lU/fLtYo8F5X9QsVC1xz2PGNCUB2EqFg3s87apAfw0m579xVtTVX+WqASU6WIgWOnwKdU+J/PDrSNnQnJ8mrd3BLm4/TQliIBzhIKENjR6IqL//m4JG19co3BouINjVOsSYdlB+b/zvjH79xxP62hc+1SAzra5DYFeuKRw5ojQ59CEi7Zh0qKrWprKnRlErQh88KZ8RTnZA9om5H16HYY0v0m83CczKOwLLETbijUtuuUncRVeh7MynKOV6yOqBKmAmj5+9qul+7GQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com (2603:1096:101:78::6)
 by SEZPR06MB6087.apcprd06.prod.outlook.com (2603:1096:101:e7::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6544.24; Wed, 5 Jul
 2023 06:53:53 +0000
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::fa0e:6c06:7474:285c]) by SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::fa0e:6c06:7474:285c%5]) with mapi id 15.20.6565.016; Wed, 5 Jul 2023
 06:53:53 +0000
From:   Yangtao Li <frank.li@vivo.com>
To:     Andrew Lunn <andrew@lunn.ch>,
        Gregory Clement <gregory.clement@bootlin.com>,
        Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>
Cc:     Yangtao Li <frank.li@vivo.com>,
        linux-arm-kernel@lists.infradead.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 13/13] clk: mvebu: Convert to devm_platform_ioremap_resource()
Date:   Wed,  5 Jul 2023 14:53:13 +0800
Message-Id: <20230705065313.67043-13-frank.li@vivo.com>
X-Mailer: git-send-email 2.39.0
In-Reply-To: <20230705065313.67043-1-frank.li@vivo.com>
References: <20230705065313.67043-1-frank.li@vivo.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR01CA0196.apcprd01.prod.exchangelabs.com
 (2603:1096:4:189::23) To SEZPR06MB5269.apcprd06.prod.outlook.com
 (2603:1096:101:78::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SEZPR06MB5269:EE_|SEZPR06MB6087:EE_
X-MS-Office365-Filtering-Correlation-Id: 556d5df4-4567-4b78-4eca-08db7d249845
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: tb+cPK3c6GfOY2uNgRi6ob+tAWXiAzJYKfv8RKVQpMkTRp7tBfIlbCA19PHGMfhAubsk3sJlMX7qC2yIVYBx9zrwvOo7ho5gEno4xTjb0kteiLVDfMve8j70Ts23qAUSofyKKjq9q6fTVHHkhuCGOuocobUnD9hLhN6EQqeg3SYlsGYnRGRR4OBfWtZv1NG4gV6NcQqi/4mT8i913E6UOg8WMkQcxSkyBhyWugLp/Vy6Esfv+7hlyJJ6kXIbzftuJKAFJ8JKHVpS/pmxxWNtkY/HFG5euwIioS+axXrtlYj+iCHB5TrlUOJqPsGa08rIWE+QiAJniPznSjdx0dP+FOItxNJzh5yNAFfYYaRnmjiWwC4q+h8OlHgFmhmhzohzhe5olRMkM3LENvie2C3BAWPQ9l/4hlEWR1XOQpW52EXtAwGSdBUGBWZ86iXJ+W2uWrIsvM+PPKJhHI0v+j8kJy3Fgq3btxzMuSEA2K7ts4zAiWC4QCU3zz56/0l6iQATcpRipFa1kJiwOzmHzQamMmLl1UqzLOBVZxAVoESKHghoapNEH8FXYok78MB6sPP3gvr54YXVI54WH2sO2P/JKfljBb1jUIaqFnmV2GDmxmy+KY80R5Byh61b9S3kETY4
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEZPR06MB5269.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(39860400002)(346002)(376002)(396003)(366004)(136003)(451199021)(41300700001)(38100700002)(6666004)(52116002)(38350700002)(83380400001)(2616005)(186003)(6506007)(1076003)(6512007)(86362001)(6486002)(110136005)(316002)(478600001)(66946007)(36756003)(66556008)(66476007)(4326008)(8936002)(8676002)(26005)(5660300002)(2906002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Dib/WJiZ0QOnoDmFlm9YVSz1ujazJCFzIedOe7I+6rVfO7BP9JMbuDVVn52o?=
 =?us-ascii?Q?n0R/ffdP5P8zKHFa9/SzSIdycBo5P4YtuEYeWz1yK+FgPFKXfIiOSDLrOAOp?=
 =?us-ascii?Q?nYsT9dtQrW2FMKxiHicToRHBlHJm7elJtB9Rgr6l+9/3wve4Mz7dKL8JcpAv?=
 =?us-ascii?Q?SZJzzt+duDG7axtZSwWZ5pkyC1F4npPlYWuq70IAJIF0bEUy8mCYinW7rSrK?=
 =?us-ascii?Q?0CeODwVM9p0K0qVh7AD5ZWlZs1vpsNFBqz7KdMiorgRyAyXqHIxjv7K2p16e?=
 =?us-ascii?Q?iF9IjUvoo4amwSJKzJ2qVsUjEHlRfX0s6MrdoA8trW2tSOdNcqyu9Z0BHunW?=
 =?us-ascii?Q?GPTnhOQiyXxLCbLtliwKkgrFl1Ox+v7+T4kRF7avycapprEIs9uP6heWPVw1?=
 =?us-ascii?Q?GWAP95uovHcAe0YqoZ6mNWZyedumFWvPQBfiDyTBF28UMWgmDdqgPrHe6kdd?=
 =?us-ascii?Q?dDPKkgRgvjVCYS+jcQv8KlRcTsxgT6mUUQ1WFHbOrdlcWt2v1JZ0Kt+c7bcF?=
 =?us-ascii?Q?ru7wBl68I6R5+9tVFta0vajCdLs/nUgdVlZLHhfh601Bpafhq9svFNuefYTn?=
 =?us-ascii?Q?oCnRflLBRqqKTe/i8jNHz4zoBXO9+tF7/IOmfMYMj2Q2KLHCBw1A64kFlyOu?=
 =?us-ascii?Q?tGMW4Y07bVQts6UTpg15EfX6dbCk9aU4Jth/moTBYw2SjsXE6wayv9IqLHWC?=
 =?us-ascii?Q?XgNNm5HZSAkyv6u4I9Lqv9uX0jzJaXy+gMySWT4UaPM7fEDD7IXTfGZYeugW?=
 =?us-ascii?Q?kjKHQa86wSoIGuwu7nRzn5Ia1qrfWiMZGq+nuPHpRwJU02nw69apClb+H5Z2?=
 =?us-ascii?Q?FdYq47AbV/tcnjWBQF1K1pNjOjQq3Xbu9tv25XrzmRM2jjwTcFHRLOCy2DQC?=
 =?us-ascii?Q?3sLcWFX6No/+ntus4uhAov5svHXlwqRNreRE/+nzlG7ynIv0UVkV030v7T9Y?=
 =?us-ascii?Q?1PYCK8Blt5vAvAxt6OAYOQrSfBnefIiWLvHaWiuX3pcceyS/LqaPSEjOQXFk?=
 =?us-ascii?Q?LUdgwp/xMMUUSzvTxEI9pZc7hUvmNEgIXsJIM0eILsZiWHZ+l+iEg13carBO?=
 =?us-ascii?Q?LZFsV3ijbrNFkTXOpCbLEvmQohxZyhzA/ErE1Dm04ChPa99mpGsXik3z+8MS?=
 =?us-ascii?Q?MxA3aY8FOHAx/IBKgPbF0eZtTkndH/4gZ7ABFJ5TTaYvE9sQr7g1PG2yoRzI?=
 =?us-ascii?Q?eRPwE04sUWX50NknBMh/8Vhr6SrYUa9FDscNZzswBt0JT48x6mRjjOQRLCrr?=
 =?us-ascii?Q?OV8BCzVYufLjxt1GyTDfIB57REGCBHMD/dcYv1NV139lWN4RHkVes+GyW139?=
 =?us-ascii?Q?5mOy/OAJ5LETeZm8v1k6UPJSJHnF+b2mCYjjHmhKmfSTWv5dZ8JJxAqUuHzF?=
 =?us-ascii?Q?u4cFDQNKsNGrErgjN0Xgf46BQu1037fbapTuLaVdCN6gxRC+O8yCL3mNajx4?=
 =?us-ascii?Q?Ta6arHtrWgygfXz3cZlK5X5s702GQvhKvHyY/Lotn9PH2PHyPyqSIlT5x04B?=
 =?us-ascii?Q?aDdAaP1h6CzKr1t/GKtsw5TpulsI4yDVqL1TB9+odSXFinzIOcEPJHvc8vKM?=
 =?us-ascii?Q?nIgCcTL+TeogLxoTjuIh/TDG7XhGLUWZiuZPXfWa?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 556d5df4-4567-4b78-4eca-08db7d249845
X-MS-Exchange-CrossTenant-AuthSource: SEZPR06MB5269.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Jul 2023 06:53:53.1557
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8wTPZcZCxL6KYMaCKugLcU5voCpJgga51XpBrSop8Nb+0lvH4vOhmoM0I+XWYm/t8bU50r0GkrGY/48SiR7dkA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEZPR06MB6087
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
 drivers/clk/mvebu/armada-37xx-periph.c | 4 +---
 drivers/clk/mvebu/armada-37xx-tbg.c    | 4 +---
 2 files changed, 2 insertions(+), 6 deletions(-)

diff --git a/drivers/clk/mvebu/armada-37xx-periph.c b/drivers/clk/mvebu/armada-37xx-periph.c
index 3ae6078f6ff7..b576766e67bc 100644
--- a/drivers/clk/mvebu/armada-37xx-periph.c
+++ b/drivers/clk/mvebu/armada-37xx-periph.c
@@ -733,7 +733,6 @@ static int armada_3700_periph_clock_probe(struct platform_device *pdev)
 	const struct clk_periph_data *data;
 	struct device *dev = &pdev->dev;
 	int num_periph = 0, i, ret;
-	struct resource *res;
 
 	data = of_device_get_match_data(dev);
 	if (!data)
@@ -754,8 +753,7 @@ static int armada_3700_periph_clock_probe(struct platform_device *pdev)
 		return -ENOMEM;
 	driver_data->hw_data->num = num_periph;
 
-	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
-	driver_data->reg = devm_ioremap_resource(dev, res);
+	driver_data->reg = devm_platform_ioremap_resource(pdev, 0);
 	if (IS_ERR(driver_data->reg))
 		return PTR_ERR(driver_data->reg);
 
diff --git a/drivers/clk/mvebu/armada-37xx-tbg.c b/drivers/clk/mvebu/armada-37xx-tbg.c
index eccc1aeefbaf..e94c336e0f1c 100644
--- a/drivers/clk/mvebu/armada-37xx-tbg.c
+++ b/drivers/clk/mvebu/armada-37xx-tbg.c
@@ -84,7 +84,6 @@ static int armada_3700_tbg_clock_probe(struct platform_device *pdev)
 	struct clk_hw_onecell_data *hw_tbg_data;
 	struct device *dev = &pdev->dev;
 	const char *parent_name;
-	struct resource *res;
 	struct clk *parent;
 	void __iomem *reg;
 	int i;
@@ -105,8 +104,7 @@ static int armada_3700_tbg_clock_probe(struct platform_device *pdev)
 	parent_name = __clk_get_name(parent);
 	clk_put(parent);
 
-	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
-	reg = devm_ioremap_resource(dev, res);
+	reg = devm_platform_ioremap_resource(pdev, 0);
 	if (IS_ERR(reg))
 		return PTR_ERR(reg);
 
-- 
2.39.0

