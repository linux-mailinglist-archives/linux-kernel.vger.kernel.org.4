Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 486356B3481
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Mar 2023 04:08:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229814AbjCJDIp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Mar 2023 22:08:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58714 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229612AbjCJDIm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Mar 2023 22:08:42 -0500
Received: from APC01-TYZ-obe.outbound.protection.outlook.com (mail-tyzapc01on2095.outbound.protection.outlook.com [40.107.117.95])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 92A9CDD37A
        for <linux-kernel@vger.kernel.org>; Thu,  9 Mar 2023 19:08:39 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Q9z3wkIElx3wFrXWvGhIDIUYvSdX+GCpOb+gLhKAtqpuM5igNKGTzf99gUiNh8HC+KsuY2xA0U/NKLbS1nAt3P+ifc5tUBg8DD/x93pjKAOI52xNM3f3CV3hh4USrVn9LdHjHuhB/THW4S7mlMGMmWXAgBb9ga77vdAA2NrtNtZXln5+EGPp6Qwhvqx4dUFSVOuiT9Xt9ZKIdR380oc9z6dcgA9/qAg++PAAmMEHOrs6V8D1xOyD4oqI4bnq4VP8KiFNNyQQpPMQTEMeiOihYXHmTPtCqAaAtIb8Q5aa/F46fLAI3ZW/JOx0cnNm0etuQci1fHVA3L4b5Y3AOG0PeQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mpuXT1ik5hM+N9WXxYwTeK78MnjS/swJvr170u+j+pw=;
 b=D4Git9QLJCaq9snWpOw+eejGNWRshxPIqSxvPh84ZIITz/g5CRSvCEyZ1aBXYmr2OqJDWVnlq11jPDd/12dXbYtwa/PRlyyFB4ykmx8YUzACJVYLeFCquHahb7mGYKwuDmxmB0lcmbj4cDRw/urfuHoMU0cGVzHlFpCAEFusLDeSonX2k/d/dtuyYvxUwJdsoZa4X+HbTyAwhxCHemZAs96tRwThtaLn7jvPqxvMIHzf4J81Q8dSsgt1q6E4F6diEjsdATf+zg9gJhaPlyAppNLC0dagslVIMQcS9QCuTneu7sz5KAHq8ib5xKS+vdHUyeH96usVG1YtQGhXIkyXBw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mpuXT1ik5hM+N9WXxYwTeK78MnjS/swJvr170u+j+pw=;
 b=UIJk9LKL9zMm2AhTMTUa/bc2l/ooSAQ5uTfsd8SstjPgWhWuHft4CHDKCJXWMtHkitfvlE4bBI0iI42IWWI/H7ZNnM6Ruf+wSZklx4lpwswNtdzIhPwOGgeZssle6pG2GZDWVbFooqD2hqlYo+X0pslnQTYPZ8mz1/JfJMVQWxkQgrdyPupVUzZvvEKr3bUBXdpnQpOGaw8VAT8w4uQlNBK6cxUUAtRPAupKR2LA4olguLxjDdZ33e1jKxqWawhVQmtQG0uJ7+xTDRh8fKD7bQ8rVAgvVT/69LsNHwnvq8ccWVc/xRfL5KlGHdAmhxohuVEtr1+Q1LAuOORc3mzgvA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com (2603:1096:101:78::6)
 by KL1PR0601MB4275.apcprd06.prod.outlook.com (2603:1096:820:73::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.19; Fri, 10 Mar
 2023 03:08:36 +0000
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::daf6:5ebb:a93f:1869]) by SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::daf6:5ebb:a93f:1869%9]) with mapi id 15.20.6178.019; Fri, 10 Mar 2023
 03:08:36 +0000
From:   Yangtao Li <frank.li@vivo.com>
To:     almaz.alexandrovich@paragon-software.com, jack@suse.com,
        dushistov@mail.ru, brauner@kernel.org, ntfs3@lists.linux.dev
Cc:     linux-kernel@vger.kernel.org, Yangtao Li <frank.li@vivo.com>
Subject: [PATCH 2/3] udf: use wrapper i_blocksize() in udf_discard_prealloc()
Date:   Fri, 10 Mar 2023 11:08:20 +0800
Message-Id: <20230310030821.66090-2-frank.li@vivo.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20230310030821.66090-1-frank.li@vivo.com>
References: <20230310030821.66090-1-frank.li@vivo.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR02CA0026.apcprd02.prod.outlook.com
 (2603:1096:4:195::19) To SEZPR06MB5269.apcprd06.prod.outlook.com
 (2603:1096:101:78::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SEZPR06MB5269:EE_|KL1PR0601MB4275:EE_
X-MS-Office365-Filtering-Correlation-Id: 37d3bb09-82d6-4e5d-42f9-08db2114bd1a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: wKbXx5Zcr7mJN27dtamiZ1keGus/fHvD5q3Q1Cei9YEEd627AsU9HlYyfnAmoPkFuswoRHKD7cDXnXT/HYNDmExb59V/C/ajgprCJg3ckJxFiZrvoWJehymOcjPeHvRZPSMxxbnm+EEB6ZpXRMLs7MS21TUtWuM5msG55C0WUsT6IY5xABcAU5GIxMoggyIK6ZOaZtB8Sg1vHJFAOVjhDBntQnGn5185WhCJtzFCORvxpe5Uw5JHfGOc/Pod4QTqBPyhLMuz40p1+4D6kyO8JgVd4vexkh2rf4cNnEV3edaN1np0AJI/DRykhlOVezyEpWNB9GQ9b+T+djwyapOmeNgHoEF999Gm0B+oCiKaQUx25atRZ3Db3/WmO1KiiBTxlgnqkJYnmjLGVYoL9GQ6Cu0OJAi0Rd8Rk9CSbw3YmfqyhdbBiC7bAJtK4OVqtzMqcnosSUY7m0i29QaY8Ercp06xKnhZO5jK/FyV02BSjB87ATdsiYQyp0jJ0bDKUTk420oAM5cGx2WVrSSAwwzbj4fLdrsi08JtMLSnp2gjrv+vu/vP8DBDQBcohqEghzKHyhM8DX3uuYbi6GQUjC8ALPLp7tF4WN3LAhxDtQRawv2+5AybMIuHSIFdR+o1ijcxsxtix8CtyshmxFx1yw/XLm7Ca16hsb9fRHLAOPK2+9rK3Wmj/RpZbyTbf0jbGGU/MWBKOakOJolkTa/LBZxGSg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEZPR06MB5269.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(376002)(136003)(346002)(39860400002)(366004)(396003)(451199018)(4744005)(36756003)(5660300002)(83380400001)(107886003)(6666004)(26005)(6486002)(1076003)(2616005)(52116002)(6506007)(6512007)(478600001)(316002)(4326008)(66946007)(66476007)(8676002)(8936002)(41300700001)(66556008)(86362001)(186003)(38350700002)(38100700002)(2906002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?8FPwq2CiB/Z9gdRKl+DlbHRyOYW6EWQwjvvm4AwxE/qk7yJivjINAQIr9mmL?=
 =?us-ascii?Q?jYTDbfRnQWfAuYS2VvP/R1iTtG4bi1/R+a/O2Q3PNeed7LJENtX7JUzH0WH7?=
 =?us-ascii?Q?bGzTHOvs34qbWmLfBUbBihmXIcicSLMl0Bm3JrTT5InTWywHX8p8zgC8hnll?=
 =?us-ascii?Q?TEsTPqJ3su5kXlLfnseN0BpVwkapx6UX2mqy9/C5NUgvnZowZ+bKYdGJN+91?=
 =?us-ascii?Q?NrJhuALwg1aM2knhmUQHftgMIGynGBX10nJt9NfdWbLYj4TS6EqWAn7HYsYH?=
 =?us-ascii?Q?q/YF/YNqll63FCeRl7nIuXsyCAxC6D/yc4DQ1HmgqIFVU0Lr6C8fpN6/hAMX?=
 =?us-ascii?Q?Pkm1+9ZU0exvTzbGNJQ6ovSmLGa9eFOMtVJ2mSqsnFYpi6npB5hzd6amC4jf?=
 =?us-ascii?Q?54NqtjSWW/ymhEMa3/t3zox00Rna6EKz+wXObyAvI0XTPOA1rDhhg4e4AXmG?=
 =?us-ascii?Q?osnSeZNjph7KEypky6gfOzo86c6uw96GfGon8VUERy5+M0HEb+XaOEHAg46n?=
 =?us-ascii?Q?hJwMOs24ykJHO7gRDobcGnknjbyrzYzzyp1dcl70vZr7VRFrZzZ7OsXtP7dQ?=
 =?us-ascii?Q?ty1UPsBPebeGGk8rHU3DvOZfW30h24C4ZrJDvkoluDljVT1OqGLJnxQhCtEB?=
 =?us-ascii?Q?WWzco3+QWcyVhaKqUr6jbnpLsGt3nAL2liwMOWNWT2psAUGk0RzzPLT/MGV3?=
 =?us-ascii?Q?Z2Y08WyJGELNvIqSxR4WTgFsKiBnXhh64HErnVi06bMtv0a9qlkuvXa5s1DK?=
 =?us-ascii?Q?5Vibylt2WbAok4qmbQIDr2wGdi3oYJ6hgwSxrg3OW1aakJCmTee/2wiRNoit?=
 =?us-ascii?Q?IoAMPMJ2QaD1t0rr9L6sRytTUDLKaYNuFYNavdEaFXB6016iaaWdadioqxtU?=
 =?us-ascii?Q?PvQo6gopyf68DuHoFOWqOhX8SRDaY6d3aeQQZJvwmmL9QA42RT3rhfSF7MlE?=
 =?us-ascii?Q?lwGax+GgOfushGuWgKR+Ht8FFkIxCSzw78WrSM2oZNk2zIPueIuv9q5UuPVp?=
 =?us-ascii?Q?Gt9QXZd47v70w9xhdnDs3tXQUBE1A0k41abjQBUo5fpuq0t95lKuZpz/yeYD?=
 =?us-ascii?Q?8Y7cN6VqcK2qcrgmqmvbUwsE32BbMyNqYdRBDq46pFSR0wSNRHc4MfMsHTHM?=
 =?us-ascii?Q?dmuvr6qayHbdtPNnA+YPUVCHhhKeHOyDVzNcBaZB5M7SKnsDP1HMVaVlw58W?=
 =?us-ascii?Q?2OV+7g5f3kxeaOjo6+yy0Eol8yGxpJK2jZ4/JNbIx44xCw6+w2k4GxzL+r/o?=
 =?us-ascii?Q?fBSsQb1AMYUIoWibfW/QpeJrP5x02XlXaKACUefuFem1QZ2dmRiA2tH4e8RP?=
 =?us-ascii?Q?33yzboTcgblzI/dcCooGQkxVXdhxqlxUrUVF4g1bsDxydenYe+daukUmlOdT?=
 =?us-ascii?Q?tD96gOMjZ0i06coKXk5m8ifiVigvFuv2Rg0IyUHmTHC7jeGeI+xNK+gpgENs?=
 =?us-ascii?Q?pa84Icz2VXtU3x2eiGQqNlSmFlwUmJC40pSLyg8/qWbNxU5bvkFQEOQHgdoV?=
 =?us-ascii?Q?rL7sCV5PRe9lOhLbAhGk21yeHtOgoafio99b7XnuGdAzA77Bz1BtVc4FEbK/?=
 =?us-ascii?Q?80kTjRn2YCvzDbcrFM6an1kNkTj0qLMR5LQDG1LD?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 37d3bb09-82d6-4e5d-42f9-08db2114bd1a
X-MS-Exchange-CrossTenant-AuthSource: SEZPR06MB5269.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Mar 2023 03:08:36.1390
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Xx6N4k19eqFGLs5EP2n8fIbjOAs6cSlmzxFV/31OLsW+zLxaJuYJPpFW7xHMRdoRq8+QvkCJTbolzPtbSzK3og==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KL1PR0601MB4275
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Convert to use i_blocksize() for readability.

Signed-off-by: Yangtao Li <frank.li@vivo.com>
---
 fs/udf/truncate.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/fs/udf/truncate.c b/fs/udf/truncate.c
index 871856c69df5..2e7ba234bab8 100644
--- a/fs/udf/truncate.c
+++ b/fs/udf/truncate.c
@@ -127,7 +127,7 @@ void udf_discard_prealloc(struct inode *inode)
 	uint64_t lbcount = 0;
 	int8_t etype = -1;
 	struct udf_inode_info *iinfo = UDF_I(inode);
-	int bsize = 1 << inode->i_blkbits;
+	int bsize = i_blocksize(inode);
 
 	if (iinfo->i_alloc_type == ICBTAG_FLAG_AD_IN_ICB ||
 	    ALIGN(inode->i_size, bsize) == ALIGN(iinfo->i_lenExtents, bsize))
@@ -149,7 +149,7 @@ void udf_discard_prealloc(struct inode *inode)
 		lbcount -= elen;
 		udf_delete_aext(inode, prev_epos);
 		udf_free_blocks(inode->i_sb, inode, &eloc, 0,
-				DIV_ROUND_UP(elen, 1 << inode->i_blkbits));
+				DIV_ROUND_UP(elen, bsize));
 	}
 	/* This inode entry is in-memory only and thus we don't have to mark
 	 * the inode dirty */
-- 
2.25.1

