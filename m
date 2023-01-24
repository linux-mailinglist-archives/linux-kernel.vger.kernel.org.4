Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7BC9F679D91
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Jan 2023 16:34:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234760AbjAXPeH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Jan 2023 10:34:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46168 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235206AbjAXPeD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Jan 2023 10:34:03 -0500
Received: from APC01-SG2-obe.outbound.protection.outlook.com (mail-sgaapc01on2123.outbound.protection.outlook.com [40.107.215.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3657E15552
        for <linux-kernel@vger.kernel.org>; Tue, 24 Jan 2023 07:34:02 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lfJiHr3hWxcdzJh3l8qYWBk0Pm6/16ZZXqcrQOsGAk44KciKexclnEpE34Uau/nXQOml79vN1ClSIbevWAxf64C7Zs2oWCfwydIDq250ohaqvcOvpYl6GKm0i5s49BqIA7zyC/LDMCZHb6jbAYStpSUEYFkRsU/q0ivDtTBVGAac39Df9Yos44bpNHOuk36xX+c8j60LVAmdbeM5S0mNS5azDCzHWqiNBQJ9Gzf4CTJbfgDckNQ2DFx5TcU3+r4zHm/tdvg+ZFLx6PW9zQQY3JP/Yiy53fZawKaR2szD0ggMcG7Sx6nYGfCqYs27KVR1WAuLx5m4I1Nf5ouzRWsTVw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GWTwX2GEQqTlCLwksBsX1n06U4YmhekP4Gv4TwhYbzA=;
 b=cSwk+NS2GAzKMas6/UdVQsn8MzNA/lRUOtwdq7Y2CtKYMhqlAz4gpPlfS38DVYn/Pap4frU0aoAIo8GuONMAX11YBabJZQB6NJqaTP9Gr2H5yzfvO5bVr2ofC5Y8k1hg0WHjZUttUmZsLOxRjrwwkVwtQGneT4zkUpq776X46Wu0E32dw9AUij1txRas/HeNRXOJX3hqCSiO6n0E3FN06HQIbXNQHQB6OXXn4oBrfMnUShmTIgmE0HVBO8GCfHd5mVZ7slLt8yDMExDjOLKEvf/8HfJgzStSNHIVt2bzSYHe4FRcELgabahBMWZca07jxDfCx4nGRdqe92TXvdZciw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GWTwX2GEQqTlCLwksBsX1n06U4YmhekP4Gv4TwhYbzA=;
 b=iJxcMkTZCv9lrjSru1+JdEHghXGE5kE7BXAs5EfcZItrnZtsUfbLV0sr3D7qRi1Kz/wwTgyE7ne+KkL+2fGF2RA5+xJ3TnSjTIjnsmfKkPxYa+DcVqkiM1CuAFz2OXRMYw73KBYwn79lV9Hggb+L4uA3Vg2uquCuBIGoyCSrt8Em1MDcZwNQFFFDfbxc2Bn5WtOWyY/d6DROSKhuBRJHZQv/nbSO/6sjTZDhygOa22Ou7MomhDc8FH5TzRM0WAiDkLYPNMEA7mKew0B11I9ilAaVw00yeDIhL2V5WFhgs43DpvtXa6gtM3Cgc6YUsglI8CDR4UGSscuyBJpoJD1zXQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com (2603:1096:101:78::6)
 by SI2PR06MB5019.apcprd06.prod.outlook.com (2603:1096:4:1a3::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6043.9; Tue, 24 Jan
 2023 15:33:59 +0000
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::3e52:d08c:ecf4:d572]) by SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::3e52:d08c:ecf4:d572%4]) with mapi id 15.20.6043.016; Tue, 24 Jan 2023
 15:33:59 +0000
From:   Yangtao Li <frank.li@vivo.com>
To:     jaegeuk@kernel.org, chao@kernel.org
Cc:     linux-f2fs-devel@lists.sourceforge.net,
        linux-kernel@vger.kernel.org, Yangtao Li <frank.li@vivo.com>
Subject: [PATCH 2/4] f2fs: introduce f2fs_set_compress_level()
Date:   Tue, 24 Jan 2023 23:33:44 +0800
Message-Id: <20230124153346.74881-2-frank.li@vivo.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20230124153346.74881-1-frank.li@vivo.com>
References: <20230124153346.74881-1-frank.li@vivo.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SGXP274CA0004.SGPP274.PROD.OUTLOOK.COM (2603:1096:4:b8::16)
 To SEZPR06MB5269.apcprd06.prod.outlook.com (2603:1096:101:78::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SEZPR06MB5269:EE_|SI2PR06MB5019:EE_
X-MS-Office365-Filtering-Correlation-Id: 3a6e1fa0-f0a5-4c94-4ecc-08dafe2069a2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: AqLaTs3e0EY/WjmCF4MKS8pt60Cg4kTJMqg8pbVs/GHPMoGR+DEJ5sFsLZzfioJ8ZoMdgT+JoVesq8rWZkaQ9rhQEua0vSzqkr2fpKpJl3hSt1UNqWSVV2KMNc20P84REP1/tK6e3IkM2iIlqLewRJE6BYlnVdA6XshcK1FlbLLNkTVs9McT4CUGrlkHdg49WY6z/1DJ4vHRcB4znDRV9XZMaLFywPDnORDW9Tf+SRaLbppNtnY3kBmG31rU0rZe5YQ14j3sRE/vmgKIYoAm4GrbRtyPY2+1h5Cqlwm0Wf23BMUin8PfgWxcTf3iIrlKfsIUiDcIzqcAQNuHUUAMlP7rrWQbJOzQeNTwgThfX3Ys0/PjCYrh+JDCY0gvoYgKDdssKJQH8HGSBxa50CWztoglO9E2JtA2RF2Kg5YQE2NFnVUzlCTF/cvhG/4ZEElN7rpPKvByHnQUOVzLLeXlJomrJBULNELDkc/K308pJCCE85bQyXColUqgbO+yeB0REzmySlKZH6n7G2A0C15gKWrs4/Wb1KzMHsr2ZhBHKBJRM8dDfo+MTclZa/LDh+CM5s8DQqUWye8x+9V5iScPT0/1uKAIdUkN8qfVT3CjSMDDoUpEjjjxIL3kgf5qpccdzZ4MWysqMbD5pjpDltdO+vD9f8TbreUKkTCkLSuxTrt5eG91kjS83YLu9PmgeO6LKRLRHPTtMHWhpUkbEQ9Smg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEZPR06MB5269.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(376002)(346002)(366004)(136003)(39860400002)(396003)(451199015)(2616005)(2906002)(6512007)(26005)(86362001)(186003)(38350700002)(38100700002)(36756003)(8936002)(52116002)(316002)(5660300002)(83380400001)(41300700001)(6666004)(107886003)(478600001)(6506007)(6486002)(4326008)(8676002)(66476007)(1076003)(66556008)(66946007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?uSG714e7Ld9oWhlX3QneEh9e4ayOY1MqvVNaA26drbknYP+IxHjU2Nh6gDw6?=
 =?us-ascii?Q?k5O8JN9AbJoR7Npxs12FtYGf94+6T8uQvnzEqF7pF3qIuxKxaNYjxoxK971g?=
 =?us-ascii?Q?/OQ/Y4B62c3CwevDx934BfT5w7/fJ0CjsEP6AG93M/GExl0p1LwywKWhSo15?=
 =?us-ascii?Q?BFDGZR7oE6NzXfEW8N/9gsqN7xxRSQgLU+et1bt39EbHnqIZ3ALfL221vIBt?=
 =?us-ascii?Q?DkUouX0aICCPi7iIWx75VX7RfaWjyug5qKFgzAedFBpwoVReFM/2pn73tv3g?=
 =?us-ascii?Q?iezQlvoaDaEK1kB2qbyq37mveaGC0hPOngm78KVlW+c2wstAcLFaqSGY86Fb?=
 =?us-ascii?Q?wCDaM7298Cnk5nyMs0OOLc/A5kYfukOHYe0itZd1BcXT9R5BkRogqQKmK3R/?=
 =?us-ascii?Q?jC/lC1nNpCWlvtV7TzeAGuxqwQ8HVd/E5H42qbuF1IrZBvCA6FhLoP+aqbmK?=
 =?us-ascii?Q?pL/ssFMXXWz5JCfHQXZCP13TZggqDV9D1ewviVzeTt6NcNoK2s4Zv/0Bsumw?=
 =?us-ascii?Q?u5xuTjG9fjOJBB3JfmCl6tuihXmQMquIFT3qQ7MgEm6gAqmhkWKc4weKWsL6?=
 =?us-ascii?Q?b4vKk3D3lSX1Yj8Vbj8Ktp1DX4J39ilrDYKcKX43sydAIqOdwp7iforrdF0D?=
 =?us-ascii?Q?PONfYxbLLOnqQFFeVslvNCO9Fy5B13VTgrJcb9jP60ni74DyI2PnZC6ECGjK?=
 =?us-ascii?Q?q32MQzupBRvbMj/xLsMFe8xUQnKZpTii/VyLBffvZlhqBIlKUTvcRIOj4iB6?=
 =?us-ascii?Q?7IWO33eEceYZ773wC+xKphHY/gocXE+ocHzOp3xyRVyv1KL8b/etZZHT/Om4?=
 =?us-ascii?Q?QF1KSIxJ/KxLjncDguMEI1/Ll9XDEck1Ty+VlZeTHI5hFIsJSxtE4b2AnmU6?=
 =?us-ascii?Q?/rNlh3EQniAPWp1uHZQk7fpvsZJ7QCF7wjYegcIVhFzdBr/KZxjAAwZ3gTF/?=
 =?us-ascii?Q?fRup1YxOQ9bE1uFT5ZQKVSOe4lwkNtBRO1wvT9sJzxoGaFnCH4Tw0faP5wck?=
 =?us-ascii?Q?DhDR2LAH76GegcshyzCMq/rSGki9M1eh3jNbKt0LfEx6+WqNgl9FcHTIAhMM?=
 =?us-ascii?Q?gyyT45TAjttgFFrBlCwM7wv29wEt14rq99/d8Jhty/GhBI2l/TJ90dqBLCWu?=
 =?us-ascii?Q?YsSfuUGR6V3dNgGKAcb95umo2xYZYxbvhNZOTP4D1WzDnATK1CTWKw4pIT7E?=
 =?us-ascii?Q?N/Lmfy9V13q9t4Uvkz76vSyc6vC9qrC9zG5ByYZPpSOI+dHSr02JvJqx4yfM?=
 =?us-ascii?Q?CslIMq+PllXj+GHhunpQKrQ7nUW1THgpa6fJGjwg8Bk/iu3Q6dA7IaMR5cjK?=
 =?us-ascii?Q?755RVgWLIuXVGzkg7yxXVPVWKGfbN/8EeRLWyE/sCwupdS9tV5BJDB32gZyE?=
 =?us-ascii?Q?L7LvVADg0ebUoDEcNociJfhh8ixw7xBwgbdlTD54IO9cIOtvDOUZrNguGBop?=
 =?us-ascii?Q?2bGc8G/L7rc90NxzRGaNWFNObkYudFbjv6gHpenKDAuXaYHoQRK9uYdVamcU?=
 =?us-ascii?Q?SwVIulw06twaURFkrP1qls3ffGO2MjFq3+APNhdVK8ceSxmzgPBDhOvv0TmN?=
 =?us-ascii?Q?DFgg/TTXbhx/KSL1pRGnbBT+g7onYPLUoQZGxpuH?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3a6e1fa0-f0a5-4c94-4ecc-08dafe2069a2
X-MS-Exchange-CrossTenant-AuthSource: SEZPR06MB5269.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jan 2023 15:33:59.2573
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: E3YsLk4w62/HtYXRS2GiKu2emPbfS70A/6oR0T6QQ8RJjRZSdeWbadFauECvKTBuxC2z4YjcYtzv9kXOdFdJZg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SI2PR06MB5019
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

f2fs_set_lz4hc_level() and f2fs_set_zstd_level() have common code,
let's introduce f2fs_set_compress_level() to do sanity compress level
check.

Signed-off-by: Yangtao Li <frank.li@vivo.com>
---
 fs/f2fs/super.c | 57 +++++++++++++++----------------------------------
 1 file changed, 17 insertions(+), 40 deletions(-)

diff --git a/fs/f2fs/super.c b/fs/f2fs/super.c
index ad5df4d5c39a..b5fbe9939390 100644
--- a/fs/f2fs/super.c
+++ b/fs/f2fs/super.c
@@ -588,40 +588,12 @@ static int f2fs_test_compress_extension(struct f2fs_sb_info *sbi)
 	return 0;
 }
 
-#ifdef CONFIG_F2FS_FS_LZ4HC
-static int f2fs_set_lz4hc_level(struct f2fs_sb_info *sbi, const char *str)
+static int __maybe_unused f2fs_set_compress_level(struct f2fs_sb_info *sbi,
+					const char *str, const char *alg_name,
+					unsigned int min, unsigned int max)
 {
 	unsigned int level;
-
-	str += 3;
-
-	if (str[0] != ':') {
-		f2fs_info(sbi, "wrong format, e.g. <alg_name>:<compr_level>");
-		return -EINVAL;
-	}
-	if (kstrtouint(str + 1, 10, &level))
-		return -EINVAL;
-
-	if (level < LZ4HC_MIN_CLEVEL || level > LZ4HC_MAX_CLEVEL) {
-		f2fs_info(sbi, "invalid lz4hc compress level: %d", level);
-		return -EINVAL;
-	}
-
-	F2FS_OPTION(sbi).compress_level = level;
-	return 0;
-}
-#endif
-
-#ifdef CONFIG_F2FS_FS_ZSTD
-static int f2fs_set_zstd_level(struct f2fs_sb_info *sbi, const char *str)
-{
-	unsigned int level;
-	int len = 4;
-
-	if (strlen(str) == len) {
-		F2FS_OPTION(sbi).compress_level = 0;
-		return 0;
-	}
+	int len = strlen(alg_name);
 
 	str += len;
 
@@ -632,8 +604,8 @@ static int f2fs_set_zstd_level(struct f2fs_sb_info *sbi, const char *str)
 	if (kstrtouint(str + 1, 10, &level))
 		return -EINVAL;
 
-	if (!level || level > zstd_max_clevel()) {
-		f2fs_info(sbi, "invalid zstd compress level: %d", level);
+	if (level < min || level > max) {
+		f2fs_info(sbi, "invalid %s compress level: %d", alg_name, level);
 		return -EINVAL;
 	}
 
@@ -641,7 +613,6 @@ static int f2fs_set_zstd_level(struct f2fs_sb_info *sbi, const char *str)
 	return 0;
 }
 #endif
-#endif
 
 static int parse_options(struct super_block *sb, char *options, bool is_remount)
 {
@@ -1077,7 +1048,8 @@ static int parse_options(struct super_block *sb, char *options, bool is_remount)
 					F2FS_OPTION(sbi).compress_level = 0;
 				} else {
 #ifdef CONFIG_F2FS_FS_LZ4HC
-					ret = f2fs_set_lz4hc_level(sbi, name);
+					ret = f2fs_set_compress_level(sbi, name, "lz4",
+						LZ4HC_MIN_CLEVEL, LZ4HC_MAX_CLEVEL);
 					if (ret) {
 						kfree(name);
 						return -EINVAL;
@@ -1094,10 +1066,15 @@ static int parse_options(struct super_block *sb, char *options, bool is_remount)
 #endif
 			} else if (!strncmp(name, "zstd", 4)) {
 #ifdef CONFIG_F2FS_FS_ZSTD
-				ret = f2fs_set_zstd_level(sbi, name);
-				if (ret) {
-					kfree(name);
-					return -EINVAL;
+				if (strlen(name) == 4) {
+					F2FS_OPTION(sbi).compress_level = 0;
+				} else {
+					ret = f2fs_set_compress_level(sbi, name, "zstd", 1,
+						zstd_max_clevel());
+					if (ret) {
+						kfree(name);
+						return -EINVAL;
+					}
 				}
 				F2FS_OPTION(sbi).compress_algorithm =
 								COMPRESS_ZSTD;
-- 
2.25.1

