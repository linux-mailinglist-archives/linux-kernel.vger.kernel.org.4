Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2FD736BFAFC
	for <lists+linux-kernel@lfdr.de>; Sat, 18 Mar 2023 15:46:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229896AbjCROqf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 18 Mar 2023 10:46:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55368 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229697AbjCROqc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 Mar 2023 10:46:32 -0400
Received: from APC01-TYZ-obe.outbound.protection.outlook.com (mail-tyzapc01on2093.outbound.protection.outlook.com [40.107.117.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 59336231D6;
        Sat, 18 Mar 2023 07:45:50 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YhXLWVsVfJ7mnOdylui1dcrFYw+zmy9tVUup3fUyDD5n4s9o/33V07HMf4b1p6tDtEHNTsSsT5Wz7OVoNcD6n7K8q/DJt6dwWpjDgpmZoJPqsmeFZVMDQoWKolX667oJ08hR5TlZSJvmE8GKJzPvxl1B2jhY3IQZhASrviDZl87LaYzyv3K0L5E9/qE4m7zzUmPvDRISZhefdlWhEALocyrdhAdwZwFjSZ4hqHKtF2ZKf6T/rV6RSO3nf9X4AknwY5uiDNXSUIhf3dS9Nap+be6FxZ/15DztXaSYBVkkjKvOO1BLlDd0a1EJfHDLT+uTPFdAVL0xJOxRO3ucAuzJeQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5ABVaGWq6+pqdvnxH1HS8iSdqh5p9v1Isg9QcR1uEE4=;
 b=gaUInh7UPl0y4DyUzwXZSjmrfGv9XG8IY/3vuJI9VxnvN3r42GBre7VdPg7votS3Te85vnULfJofKiVd74WmZSOl47K8O7g4yp4lUO5NkggQAPp46ru3Ut01JZeiTTy6K/DtJHvuy6sYq0qg1S/Y5dNMe5nZIVEhSFu7AHF5SHu4DvO9WezbBDeHYc/9IJmsgwZ7USJ10ZoCTSrPjlEbq5h5aBRyqmBUx1hJYSTKOQvJDe+kqA0gzQsmlMoyZe1iIPEXEVS6e1xlY4s/jdvZZ90CxDcaymE3SwWgn/1TKIYBBZSzYCGuyaLASD7g54UPn+lukfv2kPdSfevCXx0MKA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5ABVaGWq6+pqdvnxH1HS8iSdqh5p9v1Isg9QcR1uEE4=;
 b=D4l5pKzImqwcrp9EuFgOlshNOB/o33iuFb8AV3cyFf7hCUeGmhjXxmg8aLcDoPUzQozjPjeMgkGUtPaIZ6i107ieQFkCYfu/vl77OR427i3tiqlu2APAGX+E0OPqzOLvmq3s1yV3d0BmMgDOs4Ab9BYSvek6DFTdjDfDLaeagZV3ADp38EEB4GuuL9J7kFkj8990lLhy2iz69AjYwsbwXl0Mxbd5PU37sg6TVqClAfp6aCjUDs/rnd+qzj7Mx6lGunat17RD2NP21KiTeeUFbNBnrjC4kl1ZCgl3ZlofQkaENtqt//SUvKx56dA/8lBkS3Xl4j5ugG9PcfrtQauG7g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com (2603:1096:101:78::6)
 by TY0PR06MB5283.apcprd06.prod.outlook.com (2603:1096:400:210::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.36; Sat, 18 Mar
 2023 14:45:08 +0000
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::daf6:5ebb:a93f:1869]) by SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::daf6:5ebb:a93f:1869%9]) with mapi id 15.20.6178.036; Sat, 18 Mar 2023
 14:45:08 +0000
From:   Yangtao Li <frank.li@vivo.com>
To:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Amit Kucheria <amitk@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>
Cc:     Yangtao Li <frank.li@vivo.com>, linux-pm@vger.kernel.org,
        linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 6/9] thermal/drivers/tegra: remove redundant msg in tegra_tsensor_register_channel()
Date:   Sat, 18 Mar 2023 22:44:09 +0800
Message-Id: <20230318144412.75046-6-frank.li@vivo.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20230318144412.75046-1-frank.li@vivo.com>
References: <20230318144412.75046-1-frank.li@vivo.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR02CA0032.apcprd02.prod.outlook.com
 (2603:1096:4:195::12) To SEZPR06MB5269.apcprd06.prod.outlook.com
 (2603:1096:101:78::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SEZPR06MB5269:EE_|TY0PR06MB5283:EE_
X-MS-Office365-Filtering-Correlation-Id: 5a162406-f4c3-4d37-d1ec-08db27bf5e94
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: +Amhp33FPibEkOTegAvCm/p5qiIk8cdYQaCQ5pX+DhDFKuor6KJqJqiZTy7OsK7w6/Bem1f/KYhjjSjG3dlaNwo+64PxCe2Dstq/WbB1Ch5KVOi106aGdf5dwIVN8Hju75N5jwjN/fMrK/c+c+vnlxAn8C2OEcC8wh5GnADrvXElOGGwwAsgEl++Y0AWXJuXC6fcFwPkbUyUVptjg0myU4+Gi+11rrbwg5i0K+Gh5ylxWyL6onOp5kiw9Uxz48F+1jqt/u1oddXHUh1dww36efOBEeovKZKJhPqIdj8UPCnnF2B/HUjbs+UGEDr24RPEpO2eqEcwcy2GtEX7ZgsKy+pgTlbFWhmgkHO5M2rOH7Qsdsg+xY6d/ERVHTadsSa0e+yENyoMyNM295TLYQzWhuukMksCBGdWU0FxPGZfAIK1lkN34CNmDurddM07DfJF1tLnYL3Mt7pLp8dOmcNL+dhHab7ZmCLw6NKpFM6hJSN25pqEYv3zuRnp6T5r++RLMmQJHpLMALPEKgzt8jI6eZCrUpoQwv7n+jwnHnBLDzIZxhuQdNf4sU+ybYxOt+CiKJUAQy9MG51aC0C9TZUKOVVAO/LEYvALFx2WyH+lLg2cRuXPQldkKKn5fsMXMQQ0J57VcdoJQWq1F+dU2BA2TDxczPLOVFUX/oYlJ+fvPSvjwwISYqC2Byl1mQlmazRDR619kO21Mr8iI/o2a11qWA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEZPR06MB5269.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(39860400002)(376002)(366004)(346002)(136003)(396003)(451199018)(86362001)(36756003)(52116002)(316002)(66946007)(66556008)(66476007)(8676002)(4326008)(83380400001)(478600001)(110136005)(186003)(6512007)(6506007)(1076003)(26005)(2616005)(6486002)(38100700002)(38350700002)(8936002)(41300700001)(4744005)(2906002)(5660300002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?ZP6wpyhLZ2H9UDihHj/eBi2JAH8fldeBWuJMe0PgfP4jHNhcS6BCwpSXXr/W?=
 =?us-ascii?Q?VCfG7qv9SJujcuqfRwLQl4cVwCkGy0j9f1L6cefGZ2o2OKK7UCJYjEJvJd24?=
 =?us-ascii?Q?FzWr6x2rE6adw42cRZSYDt355ug4lV9Mwq4IxGbQdIyDsvXst4IxFZ2L+WHr?=
 =?us-ascii?Q?6XpxT3dmO0RD57E9RhBtPK/znOjFJ59ey8N5PLxNqoXeb4s4EAnlP3uzPnIx?=
 =?us-ascii?Q?4DzlGgpyxB34pxESjK6BGX+wGAfJAEzbBAMdj/hUZ8QjYLoNCTO0URomhjZF?=
 =?us-ascii?Q?pkQ/0a5vaP77t9o1hZ4Zl/2/FsZxfoqu4gtvx/MlKnumeqwLZZ5pURMSLiPm?=
 =?us-ascii?Q?jTrxS4L3v/W01yli9xOOvcd/grboSYkR3u20UlwuKOzRfr0kvdiviBrg0+aM?=
 =?us-ascii?Q?eLUyTinG0CI8Sw3U8kLXP0WqBVdbujPTFacpt8t5aYmxNucbkgh7IzFy2rmA?=
 =?us-ascii?Q?zZmzwOEqDq76TbBQYfft8p2mfF2lEUjFcuduFkLHaRa1IqeiMdTHzo1jnIoB?=
 =?us-ascii?Q?hc/tNQhZ8zYNuqv32NgAuO6ZwBrrU6xAL+n6UQgzdVBlsH9axbQ1vQRWQmoS?=
 =?us-ascii?Q?/Yb5inBv1c4ceLYl8Eds4gDnefFr6btCAkT65UZpycG/PjtLd/HsunZ7UNVi?=
 =?us-ascii?Q?zx5fJy4S32FXckq9eOPFuuh8oSgWUHpwhjmYEXbqlCoXout0yPvwVkCT9j94?=
 =?us-ascii?Q?27cc8z86HxMY0px3PbZs0fe9ciChLl7JYITrn/+z2LHZVjMz8X/cSk1K8FWE?=
 =?us-ascii?Q?l+dqD7eZsfPtI09PeJBSlefN+7DRN+ZUt0qrneAaANC2kNyKJF7D+SXBw2uV?=
 =?us-ascii?Q?dJJhuXk8ThkYP28YRsbZqKqa7NRqEA0lhZbp/hqZa2neFmcpPwRn9v4HaEvJ?=
 =?us-ascii?Q?I+TodvzXNZIepcVFjlwwXPvCckNnbDgGu7Hz+NsYUi3Hmce6fFgt/OiZJoeE?=
 =?us-ascii?Q?mZU1GWe7u0d/j8TtRFpkkvweY1qvIyYRHgVXkCwHkXNVtMgJ2aGEVEil/BMM?=
 =?us-ascii?Q?noryTm4T1EcXkNQmgtZmNobydO5KsWDI20zbzZxvyG41+LN6P0r92vO026+L?=
 =?us-ascii?Q?HjvZJ921tzTbK2P9IJjWg26McSjjF1Y18rXSbuMe//BmUFQt0maH7Uxzh1jt?=
 =?us-ascii?Q?c1y9xvQlCbkg8ipGmtMKqaq2Kx7zdVg3nodhDJW7IeLX6aV8/7EnNo7aZ9PG?=
 =?us-ascii?Q?tOfrOHbTaP2tSkSUEoDcNdrNXN2QkstHff6gsiSbwd42JgdHrbftyixoRLtS?=
 =?us-ascii?Q?9t6puwBtvT3mfH0+FqkykdNvZs7UdzVfztx84xRTA/0s1GcpnzQiFUgCcV5U?=
 =?us-ascii?Q?pTmCXbovWDu+2EBA0X5qFZXV4MiV9EslGHzoeRfBNWcmrbkr0YT7XEPXL9Ws?=
 =?us-ascii?Q?1IS24FDfhCe7EEcB0hTZ4NoU+NeTPN2ojUxCj5nzGWOGWtgbNpYn3XENWhbB?=
 =?us-ascii?Q?YI57h1GkTlrStUeJktlFt6WaFrF/K+90+4xoApHQk3gsXqL8ghhrmAWb953n?=
 =?us-ascii?Q?eXRCH2ZWs/ALeVMY5lkepL3ue87QXQnzIb81dKnXQj7J/TWkPQBYRUlOgF1A?=
 =?us-ascii?Q?8HzHGZkOaPfm5tCyyLGYpYedL1td4uEElHUpWq/O?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5a162406-f4c3-4d37-d1ec-08db27bf5e94
X-MS-Exchange-CrossTenant-AuthSource: SEZPR06MB5269.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Mar 2023 14:45:08.4292
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: pNIRiYdYuWPWGKdhCOBf9rQcBT+1k/XDNQYxvZrNkG2cCKVqoLY/aVtWuvnvOHpw0GHG0I1rYUnXilxM+pLLbQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY0PR06MB5283
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The upper-layer devm_thermal_add_hwmon_sysfs() function can directly
print error information.

Signed-off-by: Yangtao Li <frank.li@vivo.com>
---
 drivers/thermal/tegra/tegra30-tsensor.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/thermal/tegra/tegra30-tsensor.c b/drivers/thermal/tegra/tegra30-tsensor.c
index cb584a5735ed..c243e9d76d3c 100644
--- a/drivers/thermal/tegra/tegra30-tsensor.c
+++ b/drivers/thermal/tegra/tegra30-tsensor.c
@@ -523,8 +523,7 @@ static int tegra_tsensor_register_channel(struct tegra_tsensor *ts,
 		return 0;
 	}
 
-	if (devm_thermal_add_hwmon_sysfs(ts->dev, tsc->tzd))
-		dev_warn(ts->dev, "failed to add hwmon sysfs attributes\n");
+	devm_thermal_add_hwmon_sysfs(ts->dev, tsc->tzd);
 
 	return 0;
 }
-- 
2.35.1

