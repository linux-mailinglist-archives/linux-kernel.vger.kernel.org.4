Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D02796763ED
	for <lists+linux-kernel@lfdr.de>; Sat, 21 Jan 2023 06:12:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229749AbjAUFMf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 21 Jan 2023 00:12:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48856 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229715AbjAUFMa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 21 Jan 2023 00:12:30 -0500
Received: from APC01-TYZ-obe.outbound.protection.outlook.com (mail-tyzapc01on2134.outbound.protection.outlook.com [40.107.117.134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D9E873152
        for <linux-kernel@vger.kernel.org>; Fri, 20 Jan 2023 21:12:29 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dOe/QxjMi3U54+yhGU2aLGRCz7Ousk10gxwbwRL0PVaCmHGhsXBOYKmhDOb6XSgem/nmLijnBmhhMjiwGxDLV7oOJGbwZJpGFzOdDqZtIfyrzAIicv5vd9DtPZlrur3FfrzBRQg8XnzIw4uhxorExq33/rNjKMhgPiIKoHyivWzSTIDyz6mv4kOHi/GbLIZWBKNcpRn156fkC6Ids9Fxwt5E9yag0lpIFjD2fO+gt7AVmOw8nnAgclvIVT4p3Gax+j88lYKoOMFl1mJKohnsXTEFz+lPNKGKXLw20FgpzQ/xiCwp5pDaHjYeNn0gQ/0nK3yN7NsIubqqYbqen3zUIQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=20mJGHcAaflykKc9Cso8rSKoQFvflxJOxP/wZgB0Hr0=;
 b=BZF1fyKwRH1jHmcyecTUJseAnIJ+VEMazWcvOKvLZamVOXhBgVhgLBpyU/4bLNq4KftkktY3Eg+w4K/baIXw73eWV4I9gzzk1nXcSY758QXbl23Gx5fAxw4FJ50GzfuZO12GEVrP7NQmMkm+HUfDB8DcjIO7wr5bAoXtVhADKsP5luTVOjv8AbvbYOmztXuoFU3nbyk8aPpD7VWQIFfFrvEsAO5AKEkxrYIHC4bCfCUJA6TI9qioDSLdyhIcjReOIIakGrnp1CxnBT4eZp49o5TbTc6NVZsTHxuU0Rzrb4a5nKKDx9i4QtUVdgSV2bwZIJ3OoA34thmi9J1q13pmWw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=20mJGHcAaflykKc9Cso8rSKoQFvflxJOxP/wZgB0Hr0=;
 b=CBwV7XVb3KMzNdnJH+qwOyqFZk3/Gt1txo/z6QlEGu1QYVy19NlssP3v9FW82a3saQJOtojrXsEMrUSk4R8MkZCwwq+pZOmVg0RJ1fxsLUjtQ0lehTrMIYAYzko6y+ddHQy2Kf2tORB7a5yudcALUG2VUZkVlNLUarh6dPefbKmqCvzvlWDkDFV7AyGiQRqfB0JDA0sXvgeN0ghLBO4tzZX+ugh8VLxMr1zBWvSBo8hSYSlSu/5am8Ue0+9b5wrY2Iv/kM42wGTAiSFF+5NMm/+3TXJx5iJI/lHjgzf71jFgVl4c9ZwKExAvuq6jx0GbXMOKr03wbosS4e4h9q3Tgw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com (2603:1096:101:78::6)
 by TYZPR06MB3885.apcprd06.prod.outlook.com (2603:1096:400:6::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6043.9; Sat, 21 Jan
 2023 05:12:22 +0000
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::3e52:d08c:ecf4:d572]) by SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::3e52:d08c:ecf4:d572%5]) with mapi id 15.20.6002.012; Sat, 21 Jan 2023
 05:12:22 +0000
From:   Yangtao Li <frank.li@vivo.com>
To:     jaegeuk@kernel.org, chao@kernel.org
Cc:     linux-f2fs-devel@lists.sourceforge.net,
        linux-kernel@vger.kernel.org, Yangtao Li <frank.li@vivo.com>
Subject: [PATCH v2 3/5] f2fs: add sanity check for ipu_policy
Date:   Sat, 21 Jan 2023 13:12:02 +0800
Message-Id: <20230121051204.81251-3-frank.li@vivo.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20230121051204.81251-1-frank.li@vivo.com>
References: <20230121051204.81251-1-frank.li@vivo.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR01CA0008.apcprd01.prod.exchangelabs.com
 (2603:1096:4:191::10) To SEZPR06MB5269.apcprd06.prod.outlook.com
 (2603:1096:101:78::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SEZPR06MB5269:EE_|TYZPR06MB3885:EE_
X-MS-Office365-Filtering-Correlation-Id: 1f8ef59a-3920-46b8-e4f9-08dafb6e1409
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: gYp96CzRx0yV6mMnxyeJLIFL4vComMyRF/DGpfuEQqzosLu05SXthFIoIv4wv6jHh49CbY0OR0usonSAkkm0QS5ixx6SGe0sn/NqpuifysykGpb5lgiy7wqmoR0GF+OsuAusKBevGxQSrEzpg/Cs7TTdfv2X2kkEtomN7GIQW97QhpGNcMOoFcgebdt01Jdn+28Js25bu8xiTyBfA11fvrMoScngETNPTkUkIrw6wM89B+NblL9Dy0tnLb3msW1UXnjhx0rJUqjGT19KOmtke1meT5Gsw7gjf7n4RF7RtKncR9khEj82WQ8x7JDfa5E4dE2oxiupD/JCrtxntk6zr8llApGCpXKF27S3JNB5ZXcb2g2NpYrOF5d5P+zAnRNtojw7ZaCK6nq1Y9yPgAWPCfAXno1md1lIkGvtVjbK1zo2CjMRgAuP59qpeEmbGdDTsmrpXCPSyUXroQxnkSbnYM4Q1a4swjT7yRi/0zeG7qmML3o4yXplb9rYSDsOqgMW5nvTY7fkOh/L4LHB9umssjMnYrDVRRTO7Oy+O3H6m1Wp8bj82Gg+Q1ehpxr9HApN1rGzEWsBr11+yMamk+ghi1Jiac/P0k/RJiIqt7vT4BQracDv4RVLx+izJ64Uh0/PGaMvqp79I9qQw4VgUTZl9X6txBFLwx0xhPXKoALZK7P7nsdvVus8gcrRwYPt+l1y
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEZPR06MB5269.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(396003)(39850400004)(136003)(346002)(376002)(366004)(451199015)(38350700002)(38100700002)(86362001)(6666004)(5660300002)(8936002)(2906002)(66556008)(66476007)(8676002)(4326008)(66946007)(41300700001)(1076003)(2616005)(6506007)(6512007)(186003)(26005)(83380400001)(316002)(107886003)(52116002)(478600001)(6486002)(36756003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?2S2yCjDdkwfGEmmBWeDvhyDpCRVW3+oP5wIQkAj0HAudrHoL4BYxFVNt2Kax?=
 =?us-ascii?Q?SjPgNK4r2slZdA2f/IPnmLfxeBT/tk5e/pgXXN6Nu7twu+MBRVk9HPd29Cby?=
 =?us-ascii?Q?6dYaB17zZ1ONBse7m7KWkURlO6aYHGk3cl1YWvWy8DAQwed/xwXwAKpNwtMU?=
 =?us-ascii?Q?fhbyUHQhi3HsGdbjkVmQE6nIseaR/VXNDM33cqlgwk2qq9310GlFdzg7JLEd?=
 =?us-ascii?Q?YiLLr3E3EDrTI3jq90p9lpkF5wX9ZT6eUPKzyHwIpq0MuWw7Vi6+HJn9wFg2?=
 =?us-ascii?Q?/QwRQXR/5NMIa2X5Rhskow6uN0HXzVM/r0bS3NRWkGQffn8mDRwioEmYb0z7?=
 =?us-ascii?Q?HQCchxDI2CmlcyFYKnQZcncwX/25RiXZ2x5o6TeFqwXVb5MkLh5X2r99eHtM?=
 =?us-ascii?Q?nekaVQWXmWkOTY/fvwrTFxZsWMsdHUQjZUDwfOCU/0Xc2SgvNE1Fb+rp7Wj4?=
 =?us-ascii?Q?EUwbX9/37tdXqXLZiH7PE/T0MURP3dmfgoldzQ1vVaF4KlqwXf9wX20Js0P1?=
 =?us-ascii?Q?NxIP/fidipTcZytEER/ZPRIOshuLaHGIvuuFfCNoioMg2WyGeyZUzawJr0GV?=
 =?us-ascii?Q?mVTYOsLqhgRmKsZjn/S82PquYlswCavNgDkUeytdTZJGnOHeOh+vne/ht97j?=
 =?us-ascii?Q?O2rbmpDlDdG8il6HvZcfalKU/6T2r44W5G4uSj1F88PZEpeZav96QNDJKxGp?=
 =?us-ascii?Q?Y/hKGK8kw3SQ8w2fDX4N0IWWhi7uTW1InU9MH3lopSS/u4nBRU0uu39GipL9?=
 =?us-ascii?Q?Y9Xd8enW5e9fzN4v6saSgYrUpxFnQtBnCaLRFkZv9AWpoCyQVkPMMksvP992?=
 =?us-ascii?Q?qkq17YkkH6YkhVpFHAlf8NWA8EDrx+qAhX63e5wig0rR3KqqgVmsBtiyHra0?=
 =?us-ascii?Q?9s3b+vJJjJrq2A2cLa7MIvQBtu4OUPgm+8xSKA9Az5isuY5hl9A8D6kp/KWv?=
 =?us-ascii?Q?rwrIsEnB7mEfDwSKjy9xm4WllphYRSpRPeI/zK6CP5uKICeFFymQpjifV++M?=
 =?us-ascii?Q?gRozma073JRB/rvEne2rzBUHZLLQ7HZGI1S/S18WIAKQ1PPuxmAzjZSTRnad?=
 =?us-ascii?Q?EYgESyT4F2tYJYU/8biz1LrY4QD6hKw4m1BW45clu8OXFMbzV3P98teTa2Pu?=
 =?us-ascii?Q?A4IqMSrhzxa56Y1ylHBiz4Cp6HfXLHG9wVrYF8KiPj2TuQ+FRJ5lfcs2hIco?=
 =?us-ascii?Q?f4Vi2M/iCzgyte+gYwzC1Ew0eLcpSPdXgnzAMi8x8i5adjikXdHIuqT547zi?=
 =?us-ascii?Q?8fa9E16l3PyHEmBT0x6fljxytx2kvpgulPfP5XD4cS1xWni2uoceJcX9cDMf?=
 =?us-ascii?Q?En6tXVZ/8bZ2RRb/a5BZzoPFOvDzUbNO6qWz/FCnl6/JrZz4pAHnVpns/atI?=
 =?us-ascii?Q?PSSxGKQrVP18LthmhN6Oz3h8s8eXaWpJzNsG+PvwmCgEijJDMTT1LgDuI38r?=
 =?us-ascii?Q?k3AZUrqoxZa2m00oMQcz1PhMStQ+3iXdx1s0gutEJSXdMNEAgf36tY6gAEyz?=
 =?us-ascii?Q?vy3aYNOj4nOI8mA7X2IYdpbi5eWJ4BvkKojam/tMvPNQnEy3SI/NdsGRRFx+?=
 =?us-ascii?Q?1l7oj1BF8yaFqWNlxDwGqeSvvybUhZ/jmbxIyQAW?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1f8ef59a-3920-46b8-e4f9-08dafb6e1409
X-MS-Exchange-CrossTenant-AuthSource: SEZPR06MB5269.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jan 2023 05:12:22.8450
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8Zu9hAQoNwwOdznphn82wsURi/PE6Sbnh1iHj/Zx0SxgSzLiCxE2fbMkhkl5qyWRc3hzM7q/RL4HyB0u8QVzRA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYZPR06MB3885
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Disallow the value set beyond the range, and disallow to change
the value in lfs mode.

BTW, convert open code to use BIT().

Signed-off-by: Yangtao Li <frank.li@vivo.com>
---
 fs/f2fs/segment.h |  1 +
 fs/f2fs/sysfs.c   | 11 ++++++++++-
 2 files changed, 11 insertions(+), 1 deletion(-)

diff --git a/fs/f2fs/segment.h b/fs/f2fs/segment.h
index 704d27ad682d..2cbc24f64a5f 100644
--- a/fs/f2fs/segment.h
+++ b/fs/f2fs/segment.h
@@ -681,6 +681,7 @@ enum {
 	F2FS_IPU_ASYNC,
 	F2FS_IPU_NOCACHE,
 	F2FS_IPU_HONOR_OPU_WRITE,
+	F2FS_IPU_MAX,
 };
 
 #define F2FS_IPU_POLICY(name)					\
diff --git a/fs/f2fs/sysfs.c b/fs/f2fs/sysfs.c
index bdc761f36310..576e6416ffb9 100644
--- a/fs/f2fs/sysfs.c
+++ b/fs/f2fs/sysfs.c
@@ -452,7 +452,7 @@ static ssize_t __sbi_store(struct f2fs_attr *a,
 	if (ret < 0)
 		return ret;
 #ifdef CONFIG_F2FS_FAULT_INJECTION
-	if (a->struct_type == FAULT_INFO_TYPE && t >= (1 << FAULT_MAX))
+	if (a->struct_type == FAULT_INFO_TYPE && t >= BIT(FAULT_MAX))
 		return -EINVAL;
 	if (a->struct_type == FAULT_INFO_RATE && t >= UINT_MAX)
 		return -EINVAL;
@@ -706,6 +706,15 @@ static ssize_t __sbi_store(struct f2fs_attr *a,
 		return count;
 	}
 
+	if (!strcmp(a->attr.name, "ipu_policy")) {
+		if (F2FS_OPTION(sbi).fs_mode == FS_MODE_LFS)
+			return -EINVAL;
+		if (t >= BIT(F2FS_IPU_MAX))
+			return -EINVAL;
+		SM_I(sbi)->ipu_policy = (unsigned int)t;
+		return count;
+	}
+
 	*ui = (unsigned int)t;
 
 	return count;
-- 
2.25.1

