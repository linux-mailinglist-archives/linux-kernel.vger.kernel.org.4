Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EFFDC73DF8D
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Jun 2023 14:44:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231270AbjFZMoY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Jun 2023 08:44:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40264 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229736AbjFZMoK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Jun 2023 08:44:10 -0400
Received: from APC01-TYZ-obe.outbound.protection.outlook.com (mail-tyzapc01on2136.outbound.protection.outlook.com [40.107.117.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C5C010C4;
        Mon, 26 Jun 2023 05:44:02 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PtC+yvw7SD5A9waJYhYc8ayxC0CwKLv/Xnat427dBrvfB81vMMRuszHyXL3oZvQQ4Q05HGbLvzWZo6VGCLbt67HpF3xqozLfZBH3pdJe2Y6nDqkrKQqcEAm3OVW7H502EXF44cgKEoTk2OE8rbi4oULxeLe6XwdBbIj4ZFSFfbDCkGDYXozurXPbcNMgvJei6u2zrtNHm0La3WS4uIYH21uBBabZIC+rwaa3kVD/KHz/0bgDkKlt2ZPMpcLRrh2SneYQRBwD+D72vsbfcT7N0kVh0WQTtySW/iTfOh1h+Ocmila/c8Z2FTtZzqhh98pQguKjRhVM1hdEur10QhUsWA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/Q8iWy4Ib3U9fQybucQ9dbTjbgZldNv/RPDvTadx198=;
 b=VOu+Pin+0pdicaMsomTF7DeXajNc9gbQ25CCFRdEQAPpFpfQ2MtaKo9EcCg1Z+UlegvcRpR/r2gyWVU7MtmVj7R70+kN2XVX6K8Ht0as6i2iEEBrujXkub7uupn9/8qXVAZzjkHeDJRcFQ/LcBaj8I7EGafun/J8NXGf5hUclJec7OlcnI2LwkOYSxUHE+iqgIA/vW0P6YI6PDWE3u8uW3um8pwoi1aos7XvWu5vPATOI1AFEke5r/VLsI1+HYYlGiY5f8wo4ksnXzvN81/SgFjzY9dDdvwHwkRDeLggyglKf5OQY34Z9r4J5PIokPa3DpUiX0vh386pEouZyxZY3A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/Q8iWy4Ib3U9fQybucQ9dbTjbgZldNv/RPDvTadx198=;
 b=HqaN2b28vO9Fm7EoVIAhEWCOe437bGQE253SVjRgGYf4zMbAK+0LOPyyajSd61ame+kOQWv3Mb01QC5uzIFy1e/C4lWO9e/2dHESpSJME8gjOzlmuCqxLZ4BJXvoPwE08DFmY7DA8El9XwwaRie7PSuFIBsLynnRYq+JUwnmAUUW0+I7mLwPNIFJqm7Z4x+edqZMiPwS7d488GpgCpf4NOOLa7qUSeaTeAtuwSKuTKvFEwbvapTIAB8TxitcTagtBhcvR61VSbzPODQgNmGzwYzhXkZ+1gcKUWTqtwtz1Jgr01KPv2LhmXopEnoJXyHgZ7VrQpym2iZC0vQyeBN9ZQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com (2603:1096:101:78::6)
 by SEZPR06MB5320.apcprd06.prod.outlook.com (2603:1096:101:7f::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6521.23; Mon, 26 Jun
 2023 12:44:00 +0000
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::fa0e:6c06:7474:285c]) by SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::fa0e:6c06:7474:285c%5]) with mapi id 15.20.6521.023; Mon, 26 Jun 2023
 12:44:00 +0000
From:   Yangtao Li <frank.li@vivo.com>
To:     =?UTF-8?q?Niklas=20S=C3=B6derlund?= <niklas.soderlund@ragnatech.se>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Amit Kucheria <amitk@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>
Cc:     Yangtao Li <frank.li@vivo.com>, linux-renesas-soc@vger.kernel.org,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 4/6] drivers/thermal/rcar_gen3_thermal: Convert to devm_platform_ioremap_resource()
Date:   Mon, 26 Jun 2023 20:43:31 +0800
Message-Id: <20230626124334.15100-4-frank.li@vivo.com>
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
X-MS-Office365-Filtering-Correlation-Id: 27489156-4d24-4c9e-7328-08db764303d8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: /bbTi5fW2TdZinTdde+aWlqL+WIafBttX+ShsucPbP+UqRZ7AezNo80sv4ud9jb82z2BhbelVLGSZyFJtCeTdkQqL8z85lhenyYRitWG2CphZJLlzIF9lQplf/0EeXXR+zr7xdcpxJuzkGganFMZd4lPpLbhhrvWsnzgltgOIxFxrS2GIDx/JtyqB87ueNGx2tnAy5w564mN+ZxzWvRdQLViqLY9pq+i37Ny7qZseVzGVSKEAT2bWhPtWS8uxaIysyXHRJGCszq/+OiNPYBR0ObGRhEXRejEqzlTVYl/IetKccLel6b57EXmCnK2axatOse9VaDNQH6IFr97dQUEO1Gr3axqW2JLXsfAXl1gqpeAadB/CaZeKUJ7q3GozDqx+5Y7PWXvD7Co3UrLPcuNbaLxtzqcBdZ2DIFLtm2L89Av8nXIDGeoBdY49DC0ZudRSgk1RPC/MRu4uwLc1PklyH2th21CB75MrsnN5DsJhQAAyZ0d2Wdgd7iWtzLpBx7OuAeTxykJ+9ut8nSpw3O3pVP32YdsVvVTL2iIxX4m1Q7KmxfetTzJNkBHNXYbosmsJbJMYpqW0jy6Q9YJ/PP7zB4dQdsg2dUWJtUx3Xcw+n8oVqz5YYDGbAHpbgCzl4dA
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEZPR06MB5269.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(366004)(39860400002)(136003)(346002)(396003)(376002)(451199021)(2906002)(6486002)(52116002)(6666004)(38350700002)(38100700002)(83380400001)(2616005)(6512007)(26005)(186003)(41300700001)(110136005)(86362001)(478600001)(36756003)(66476007)(66556008)(4326008)(66946007)(316002)(6506007)(1076003)(5660300002)(8676002)(8936002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?5tJw2FOGln0Tu2E/BYd1wBy0HCBSBFfWIxoP6aE1fgweFtjJL1/SeRZkfDWN?=
 =?us-ascii?Q?OLRX0pqVk5lqbnAZXsfD9PC0zxHeNXdU0OfyOIGYixyX6X3WOhB67kxoOklO?=
 =?us-ascii?Q?WP/NsMlJ2uc4hCwuRGTtLmAowH8xLKvhZ6ngWe4W0gdcNRytTEdnWwnU8dM5?=
 =?us-ascii?Q?CvBnvEK8mpKErc8H7kfDCeYQSwJTUumIY4Cn53IhsRx8nRifRZzP00bQe/T6?=
 =?us-ascii?Q?hMg9QI4rl3wUsHObYCwtCyYt00Sbmg0APw7W6yd+njqi3iYzbTIy8gciBnEL?=
 =?us-ascii?Q?qyr3/LUVJLuHqoWHPx08PV7HAG6oqyDK7OI3jmImA6b1fDrM1WQDAZ4pCPXw?=
 =?us-ascii?Q?xJUIjj7CT/rI+XfZxumvevkUowfLh6znEii/cXvp84XhgnkPdS9UR7WFDsP3?=
 =?us-ascii?Q?O/A6EYHAkPBp8xsruAB4t1tCtuvZz9UDH+uKAWyLDbD9kWepyCgBII3ut9Ai?=
 =?us-ascii?Q?01oc8Efj6aSKSU+29yvl3fpvm4R0eJ00cly+7QfII3LFwl3VRK3HVcfo1tMC?=
 =?us-ascii?Q?lePsPIYtxY78VUTjzO0HkUCDsX4Jf5HHKXEopu7OrUFhdLDKUVv5SpmvKX9d?=
 =?us-ascii?Q?RSTw7cXtu4DP/PsWNMYwlZunD9tyzIxuVWvQz1TLf2oPqmpozZM+S9dxB7MY?=
 =?us-ascii?Q?V/G5LstKKP+y9qDkHqhstLaGyGfVTtQGoUVq0Hqr8DPxwy87NL0t/HBtLwFc?=
 =?us-ascii?Q?DeSw8k2/EAfoVlo5AeL1uonqtC8HOtEoK0uzzjzNHSU4IykjApqiWq9xgNTB?=
 =?us-ascii?Q?hR7Z1VSaVsj4v1VJcfvA4CiLZT5zTypkvHMxXSGKWNcyKbrZ9jv7OJASHzl5?=
 =?us-ascii?Q?NOt1uwEJAcJLmmvxRty5y3zLNR4/ETPyUmYhDRGOPTabAkE5a7OEihFYoZ/V?=
 =?us-ascii?Q?6ccu1/lK1paatAVK8MXOeX0Fs/CbIPztPGy7JhS2z/RkDDln954ZIpX/dGIo?=
 =?us-ascii?Q?bGD8da4h8kFH3notZ+lI24DOScJd4pPjyTuWneTesT4l63coPdVdc35/bZRi?=
 =?us-ascii?Q?SP+ETos/c0/FQcc4H1hM8jQGcOnKRzWKVpB5nJlsCNbpqF0zoB5MVr3aY9Ga?=
 =?us-ascii?Q?Sd3//6M3Rq14/xDoTWfnstUJj/0VbC1mTMzFTQQOwiktj/IzEp4XCtaA6vXx?=
 =?us-ascii?Q?HnO2prgtUyZDrG3HoZJgVIl9JLii1Xl59CLaKhnqXGSNw13ZR4bz1LM+PJap?=
 =?us-ascii?Q?excfrxcMaqJ+ry/ZEbA4zXwnE0W91Na0dUPS4NVUtMu7vXr+2lvWXS+DtBZz?=
 =?us-ascii?Q?JKKjNAIoHcoBzuFQqqcJZhQw2f0m+plkAvsWErcqLtvqnvukzvbaNehGXXte?=
 =?us-ascii?Q?fHaacGyEei8JBD0LjhI1QQ60dZRUvjDu0PPCxcc2q6gOwbtSgZMRiVh64s84?=
 =?us-ascii?Q?8ivX29ppOLdvOd1kLEzRiMioyLUdB3Th04hvSlaaXmN2FL1zWSMGLnshdvki?=
 =?us-ascii?Q?Ij3ewreBTisDAUXvUR8M5/8VZobiawhUb5Bw8ohvscqqguxPDn1tTj5pC0xc?=
 =?us-ascii?Q?zR2XBiYzKA9ysfwpEkQSoMumj7ZOnUYUd+OEC2uQ0pkwMy13Ejy5iFBYKQYH?=
 =?us-ascii?Q?RQb06aOgEkTMQoaeDUgdqniyF+3Kx85kCzvGQNZ8?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 27489156-4d24-4c9e-7328-08db764303d8
X-MS-Exchange-CrossTenant-AuthSource: SEZPR06MB5269.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jun 2023 12:44:00.4568
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: OxfdeJE1sSYix3VZSz9vDMfZvlJk31sWopWFfIK49eDxbIr2YVuij69t/7s27Kn0e4Jn219l+CJ/dfTonCPr0A==
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
 drivers/thermal/rcar_gen3_thermal.c | 7 +------
 1 file changed, 1 insertion(+), 6 deletions(-)

diff --git a/drivers/thermal/rcar_gen3_thermal.c b/drivers/thermal/rcar_gen3_thermal.c
index 9029d01e029b..5c623f13d9ec 100644
--- a/drivers/thermal/rcar_gen3_thermal.c
+++ b/drivers/thermal/rcar_gen3_thermal.c
@@ -481,7 +481,6 @@ static int rcar_gen3_thermal_probe(struct platform_device *pdev)
 {
 	struct rcar_gen3_thermal_priv *priv;
 	struct device *dev = &pdev->dev;
-	struct resource *res;
 	struct thermal_zone_device *zone;
 	unsigned int i;
 	int ret;
@@ -504,17 +503,13 @@ static int rcar_gen3_thermal_probe(struct platform_device *pdev)
 	for (i = 0; i < TSC_MAX_NUM; i++) {
 		struct rcar_gen3_thermal_tsc *tsc;
 
-		res = platform_get_resource(pdev, IORESOURCE_MEM, i);
-		if (!res)
-			break;
-
 		tsc = devm_kzalloc(dev, sizeof(*tsc), GFP_KERNEL);
 		if (!tsc) {
 			ret = -ENOMEM;
 			goto error_unregister;
 		}
 
-		tsc->base = devm_ioremap_resource(dev, res);
+		tsc->base = devm_platform_ioremap_resource(pdev, i);
 		if (IS_ERR(tsc->base)) {
 			ret = PTR_ERR(tsc->base);
 			goto error_unregister;
-- 
2.39.0

