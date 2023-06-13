Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CC2C572E242
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Jun 2023 13:51:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241681AbjFMLuj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Jun 2023 07:50:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43686 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242229AbjFMLu0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Jun 2023 07:50:26 -0400
Received: from APC01-TYZ-obe.outbound.protection.outlook.com (mail-tyzapc01on2133.outbound.protection.outlook.com [40.107.117.133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 23A2019A5;
        Tue, 13 Jun 2023 04:50:14 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iVMMY7rm20LQ8CAUSCDAzMxYrLczh92xVpab8dnhM/OrpmX6oWZQXo/Iu4AVt+gMvCKVVyxBS5JSDbLhTrzj1282IEgqX+mEuDEVaSzRL828zLt5aCKqIyWf/CYKMjfhFgxkGBSWAZdBf+Gw4fXdOi3cDPWiDJ0OSMjtA/dcqUblMZGKXRurxgsl8xVNdLbdMpawKJpijmyv0La1NjnjSuVppLlAu5ylvz0gxE65r8ZGo8Ddg/43rcDLWm14fVuxwPR3ntHeZCVXwXhYyX4BL55c5Nl3FC9oW8O6eeK3fowVkzdzG0vc+XRhbMR/l4kMxjs+bzDCV+HgVYgy43eqqQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Bk4+vwP2LX5ms3J7DsZ/rzhNLWz2N6SaCmE9A+Op7eE=;
 b=W0mOMSDm5qqBFr+zDcKxa2Dxm33394WZQpPaR++gf2PRQpu6Qo/wImgVyHUJz5pLJkrXkfQj72y+jLXIXeDkI227fZ7hLZ+XbpJfYK0amOZhUIn33TcyGLlwUIC/Ppa+kqQQSFHzcBrXuJPBWc/pp7ZvSZoTd7u3sExiOJQI/OlIkhXnY6TrAzbtsU8+vseapooAX3o9ZqQkvFybNvIV48RlUwN+5GOzeb9xLHthQNyLjUBYDPk/OrKPCo619L7vrthaW16egDRA6JJMIzAovW4WctQYudTOxmxdW+jNFSHvcyO8VkU/N1Or2Pc0ZZQdQu+tSEbHcd69Fz+hWWXz4A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Bk4+vwP2LX5ms3J7DsZ/rzhNLWz2N6SaCmE9A+Op7eE=;
 b=ZNKOu2JQNtwVesmTz9LT/e3fpBgR7OZ63pbo9tSMrwneGa0DnUbDsYJtw1qNqYxPKTR/DkxTd8kkffNisCQOQr2POoy3HoTfcDgpeWPamo0JJwZGwyLNKzZcw8/McNTvrvta0iy6eo4E99q9iTcahmbJVoDMQFMbDFFeHcIpSohjLhdoGiqvP9nUmlzZCtVXrylYYBoZJQmxYlg8M1SDct8/qLp6LcxQUODOw58CxVEY1vv0yrFGbpw51xiM0u6PzOVUB34GxzRrSYUxedVfRD76XAAs9Y91Pwqam8wbW+r8EuVS9Gc/Jyj0oNBZ+O7mfetfrEGzHZO33zxZZ+dF8w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com (2603:1096:101:78::6)
 by SI2PR06MB5315.apcprd06.prod.outlook.com (2603:1096:4:1ea::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.33; Tue, 13 Jun
 2023 11:50:11 +0000
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::76d6:4828:7e80:2965]) by SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::76d6:4828:7e80:2965%3]) with mapi id 15.20.6455.039; Tue, 13 Jun 2023
 11:50:11 +0000
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
Subject: [PATCH v3 10/12] thermal/drivers/mediatek/lvts_thermal: remove redundant msg
Date:   Tue, 13 Jun 2023 19:49:02 +0800
Message-Id: <20230613114904.15749-10-frank.li@vivo.com>
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
X-MS-TrafficTypeDiagnostic: SEZPR06MB5269:EE_|SI2PR06MB5315:EE_
X-MS-Office365-Filtering-Correlation-Id: b5ceffa2-2978-49da-3e24-08db6c0457f6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: q7VvTzA//gjKALn6aFbKhpt8kbGD9ZZpI29XC3y3pXywAGS/C6CKeDTQLeuFcKhPIyLPBZourTBYKdYbWIO/ZFIRrxO/Nr3vFbSFBCV8U7M4J3aGWsjmUJAD7PEIErcnx3X3dzIpxfR6kUPRQnLVjysKGQ6kRJa3fguBkDzur+pVljMG2bxCpRmrU+k8MX7bh5Uqe8D8/DVuXXWGosbJKDgBKa7wy+eSOW7T7Jw/5OtLske6BlzH7iNOh2Ka74JPLKgLDVGg1lAnmgPbCaK2gV2yHU/04gri52klxXAFks2Q11qXKGa+3va5VESNwA+gcUZNbFtJiSbA9k2GL7b91DdQ5JHdIWp2liX0twfZqYvhPIo+OC29knuMs3108WXA2JQu8uO4MlA/6VNn9syRnM4+NtmLRbVBip/CTQcwDlD+Ikk+l9o155uQecDliaKSDUMivBDMZx0bx4gUlYVDJvGwz2EaSCTl0QqHT4pmP8fdMJULzzIfSxmdVaMaPQ4p2qfHp+GEgCLgt0vXJQ6uCnkEf9mlx/IMETr0q17+oOBQeU68b80CD+mHAqGcMEj01Rv9oDUEHBYQkMsNwT9jeWPaZmFaxcY2OPb77n6gI6E41Ls34uFDQMEejr1EIr7LusktlwqQxJPtJo9kq5qc1w==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEZPR06MB5269.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(376002)(39860400002)(396003)(346002)(136003)(366004)(451199021)(4326008)(8936002)(316002)(7406005)(7416002)(66476007)(41300700001)(478600001)(186003)(2906002)(4744005)(66946007)(8676002)(66556008)(5660300002)(6666004)(107886003)(52116002)(6486002)(1076003)(6506007)(6512007)(921005)(26005)(83380400001)(36756003)(86362001)(2616005)(38100700002)(38350700002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?1y/IPMEzD+Sqc0vWWmFGhJrU9LVB4QddQZWQ6mE/x9EeWV7vgsYhM6OIF3Dj?=
 =?us-ascii?Q?xbhMtXUaq+E6dl/BYAmMCD0JZ2LS6qMG8YcHHiuWwn1IEGCGopuiqiy68Nb4?=
 =?us-ascii?Q?tV7vt6PulDeZcfknzbnI8tTlRbwsTfoyyNvARd/X1Ws8ZabtHWL4JV3MIbcW?=
 =?us-ascii?Q?PBCTL5WmdPOSANBt8Ic4v+mlwI9wd7Hmva8WoB/9KZwGZ8Eif5MBUvcf4oER?=
 =?us-ascii?Q?q53gbPqqBKgTZHqGuJN4/EONfV6+UDIO2V7hbMmOVqYHApJXSD7fnDgqQ1FK?=
 =?us-ascii?Q?eGSneKTYAPXHu7BTMGBvzQZxbbWJMRrsK+n2tGYTrz06sUeIPwbhztAV9381?=
 =?us-ascii?Q?V0jO1BSzvTUIiCG7QASYsZkCQjBQsdXLisMH/q3Vht7955PLDBcmWOhMqeV9?=
 =?us-ascii?Q?4oEWrXABdbo2lHiaTOR9hkNVikCFQNlvEnLBaD9FYociF+5TYPZgeLCTcwAK?=
 =?us-ascii?Q?9PbVAdcCirQDnyE7moh68UIcU0w6WqEosk33phUbxSRdsKjkA/N+xg0e7GJy?=
 =?us-ascii?Q?+qzkzy9J2zd/HRDihsgEvbOkNEfRE/7Rf0TD5C7ONGkhdIJBZ2QofYUT+Fbj?=
 =?us-ascii?Q?8d/tuTlMUPt9sq9zM0t+YhEh+Uux4442/yplMN+R8CBmiwdNrKAYmPOZAc6B?=
 =?us-ascii?Q?nchzjGkX5gG5aBFJDDi62Y+1zckWOscnEB81Cq+v9qmg+MW3TT9CqOVx/Aaw?=
 =?us-ascii?Q?b5xN5sB5ZOlq/NfxTM/1yhgdSx3JjeWxjNF38UoD9VW8wXuJhHk69c22CvYf?=
 =?us-ascii?Q?3InvVye+VTet7aLpnOO0s/h1J0COCIAQIt+y8CS1cFY0utm9mJ7eXKdhyjON?=
 =?us-ascii?Q?SloD4pWbgArnlFfxvz9yuom83A/CQQs1mrgvcWyHwcGaGV7zaTTI3b4p33VF?=
 =?us-ascii?Q?+Pp2B9jamUCaEp/BWxH7vX3pfUyH1NdPqYPcLWv37f2he0IDHksyI0fy7/u2?=
 =?us-ascii?Q?s1VtfLVmYFiW1FDoQ0zkxt41wz853CwHjAGP5G6Y+oU/86ZxjIK3vwsD5NmU?=
 =?us-ascii?Q?gkpFlb597MQmc4EcSQpPsIWtOxC/tYM99ADOgmogJj5KQajQkszzV1Zhl+Fn?=
 =?us-ascii?Q?ve6o9XZSENJmS/TNZLlgsTaw+J2xi4ExDxrSlidJqJ4aKKtvbtRrFggnYKyE?=
 =?us-ascii?Q?5kNqJJ4E4USIqcARon6wYWIwM37Net6HoozAkNy38oZLtITQ8euKhjoxkKQh?=
 =?us-ascii?Q?8Gu743snhas1ZiuNfBI77C49tM0VMqbWk5/aDw19r93g9vEw2IUqfKU7LdM2?=
 =?us-ascii?Q?WBuvV+Ez5V0ROQV0F7NGycUEArGVu5rwQOcQzrGSEh4MBvv5nEx/3mgpp2FN?=
 =?us-ascii?Q?M9EiMgGATWRB+1PLTs60BIFz9Cdvdayh32M+26oOLv2nhPuBiYbQuQaLsFGe?=
 =?us-ascii?Q?R8S8Vg0iE+Ifw3LrikjIsT/gjLPh0mPrDVlnm4OEWZon0hxX2LaimWkotPd5?=
 =?us-ascii?Q?xJ6ESHbIZrYpyJE9xPx4zRNKvkkeZWqAbeDY6fp1yCR2M3R/yhVHfo4FgqKj?=
 =?us-ascii?Q?ZKobpkcweUHmsnbWNTFFB1uWuiUWuzy0ZpVxCT/2+3bRxfBKjGoUKWnpNBcQ?=
 =?us-ascii?Q?X4t9nr/xN6wKmYsvvb7tkbBOCnbsqZ2FeVqRvnob?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b5ceffa2-2978-49da-3e24-08db6c0457f6
X-MS-Exchange-CrossTenant-AuthSource: SEZPR06MB5269.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jun 2023 11:50:11.6141
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: KfIXBgZPrn+Bo+rvLkwLD18IQXXwAXYlLXeVyxsAZ4OgWWcLXREkeIcvhCNCV77glreBiVAN7vGRx3ltS9zIxg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SI2PR06MB5315
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
 drivers/thermal/mediatek/lvts_thermal.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/thermal/mediatek/lvts_thermal.c b/drivers/thermal/mediatek/lvts_thermal.c
index 1e11defe4f35..b693fac2d677 100644
--- a/drivers/thermal/mediatek/lvts_thermal.c
+++ b/drivers/thermal/mediatek/lvts_thermal.c
@@ -998,8 +998,7 @@ static int lvts_ctrl_start(struct device *dev, struct lvts_ctrl *lvts_ctrl)
 			return PTR_ERR(tz);
 		}
 
-		if (devm_thermal_add_hwmon_sysfs(dev, tz))
-			dev_warn(dev, "zone %d: Failed to add hwmon sysfs attributes\n", dt_id);
+		devm_thermal_add_hwmon_sysfs(dev, tz);
 
 		/*
 		 * The thermal zone pointer will be needed in the
-- 
2.39.0

