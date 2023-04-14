Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9FCD76E27F8
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Apr 2023 18:05:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230511AbjDNQFJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Apr 2023 12:05:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49526 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230313AbjDNQFG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Apr 2023 12:05:06 -0400
Received: from APC01-SG2-obe.outbound.protection.outlook.com (mail-sgaapc01on2113.outbound.protection.outlook.com [40.107.215.113])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 414BAB466
        for <linux-kernel@vger.kernel.org>; Fri, 14 Apr 2023 09:04:53 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZXG6TPhdGoSo14b5lzEPm2p68T5StF4sIR1Pp36Yj2GK0/KoSJSjK8XmUUnbXyeLX8OO2GUoFh0e6Gk/on5/og1ZiSlv0E7d7IyEDd3OOz2KsAGPyDaq1oDj3pXZJSk9Zw8+xC7BAPA7Pa0Yvb3iI9NsDg6q++0Vl2BZqKj8om9GCZZZP7K2Hz533+qGqTOCiI3cDivdfVRoiJQlLfQpF+6GSi25dUxBPtQ4nPBd1nBMFu0s41UtQeQofM1aQustmbXM89EnQvtx5aKvXQ3dwdxClZtqYIiifHIwMm/ABuBB7n9Apd/6H3AgMdzBtF8iqUDZb4CUqG+CIydYB+Mpvw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Qkx4FSO4h+cv5qAsVcEKsOmFXrEvR3x+FQ58lH1dAyo=;
 b=PixFavNfdrCnim6HIxYU3c9TbM6tUUq3CCrxdHl3cuL1mdo4/m/fqrfZ+9LxfNGsbPALN84t2YHHmd47l4iAyKMWLrQ+Hk1nGdSjozvMsJZnuCLTvbvoCMybLYOoKvDSX8e3jvUTlPew33Xj11ntfFgoLQjINied0zIi7U2oR8HS22pt6yP22n6jreH6P4/mh5ATkAefO9lccybv7VNRCC6bmq7j5qP1ql9Dk6vFfOwohueZswPIlsJo1oPhvPNxgTDsumopArGFa9vJsdbbOLUQSJ7Q9tQgAEjc+ZZuT3JKGwSSozYL80AqKnLhkQzHkfPiWcsgw/1W8LLD2F5OAQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Qkx4FSO4h+cv5qAsVcEKsOmFXrEvR3x+FQ58lH1dAyo=;
 b=VWhvxThPCCvACw0oG8dZJGpegmeYnWKyQ0ws9nqMo5dF2dRosSJRomWMGV7E04VRFOMSDpxAGghdKYk4MxeBIPLP7JEI3BxbcANc6jFPibN73cmpVvcHHQjojdFghwtpTnLtlIHEaXFd7bnvsd/mXu0Ufoywk+VeKVFz8RnZd/cxvnUpRGjHI8fGo6uYnM6y+wih5dtKvB7AIuug6tHsb9tmOOAjnHtB0HbD+V4p14y92TwGlv+s/V3Ew4ese6kOyCyPIHMcOBPVNHLHPTaFYBjjKvTRg/uSs1wFWF8t/3mZxa6RqsZ/0LBUAAomwy0w2FOU20RR2v95I0C89N1NaA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com (2603:1096:101:78::6)
 by PUZPR06MB5887.apcprd06.prod.outlook.com (2603:1096:301:117::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6277.38; Fri, 14 Apr
 2023 16:04:46 +0000
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::a3a1:af8e:be1e:437c]) by SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::a3a1:af8e:be1e:437c%6]) with mapi id 15.20.6277.038; Fri, 14 Apr 2023
 16:04:46 +0000
From:   Yangtao Li <frank.li@vivo.com>
To:     Jan Kara <jack@suse.com>
Cc:     Yangtao Li <frank.li@vivo.com>, linux-kernel@vger.kernel.org
Subject: [PATCH] quota: move qbtos and stoqb to header file
Date:   Sat, 15 Apr 2023 00:04:35 +0800
Message-Id: <20230414160435.64119-1-frank.li@vivo.com>
X-Mailer: git-send-email 2.35.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2P153CA0046.APCP153.PROD.OUTLOOK.COM (2603:1096:4:c6::15)
 To SEZPR06MB5269.apcprd06.prod.outlook.com (2603:1096:101:78::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SEZPR06MB5269:EE_|PUZPR06MB5887:EE_
X-MS-Office365-Filtering-Correlation-Id: 79ecc79e-f3a8-4309-b60f-08db3d01f763
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: HgQmR/6pFZ6bClED9Z916SX7L/krR8r3tddB0nO49aJ1CnFKypQEnfqsKbmnTsf/nEmX88JLlZSxMh0VgAsCCcxA2+QivqSmEfhIiLNH6oL4DlpmuaVQ3/HtiRbCKFRN/CN9Jy58ptzhFHKVI2fb5NfBgMgF8r1i/52krUY+pLK1x9p7IW6pFoIZQtati7iqohKfJHX1EWkHDwzyIkzzKiJPeWb2Ae0PmqyM7oCMvOpXOAUEEoY3s7mDKtij9mNt6LUvIVXbtmgFcYicc42+pQlgTsp314G+635AKwnYf8p0Jqvocg0nn4IfGm1mDgRJT8YuC6KaRVMX4C8s4HTUmH80b9+GhSXgVHilrzAn9E4tW9EzGQl2g2hIPeEHLSIaVW0BGg3f52nVXoA6nkGd2maRhuX81jFGP9kLN6ZcV4xbzR4Fj9OLT4F6ESAz3FHZRe8wM5huf6CttKzfWJE+MPHZ2Bh6u6Vmbr3gMOh6mKtQREXs843cIDghJ0Kw/V8NYYTBsBAtXtVPXrbSyz4WUvinTt6Ab6h0wS29UC1yUYcD+h3QOnX4UdJs3l6crv+/UijmnXhq9BvZf3+tN6l593FVo210rb2wyS4044ITwwyAJppNCsx3vB/F1EQmpakd
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEZPR06MB5269.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(346002)(376002)(136003)(396003)(366004)(39860400002)(451199021)(66946007)(478600001)(66556008)(6916009)(4326008)(66476007)(316002)(5660300002)(15650500001)(38100700002)(8936002)(38350700002)(8676002)(41300700001)(83380400001)(6486002)(52116002)(6666004)(186003)(6506007)(1076003)(26005)(6512007)(2616005)(2906002)(36756003)(86362001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?a6G3n6RjcB4Kt3Dt9DAMYgJ16d7yd9pOdqlWCwblM9b6lKsq8vykL13lxwFX?=
 =?us-ascii?Q?NoL9V3IJ7SeH1S0e/tx8hkXIrDZe3T3+myhlZMR00uP65aTvHc2szHYtSmQM?=
 =?us-ascii?Q?kr7UA5b3oDmqHTIroKxa9MW3vzeq+wXWPjtkJYJHJzArJqTPoCcVoaaT1Nnb?=
 =?us-ascii?Q?GY/mIFnGa+JDnuLcR7zmojY5w5mfA/7CtyA70NDG1tT4ejzCqRfxICQ6mrju?=
 =?us-ascii?Q?QES5ADkVHZ6jjoKBDvUdbt9gdRV0SepQI1LXqF0wBW5xx6YD9dY0szwo6mUV?=
 =?us-ascii?Q?rpb14nv7fBSTXUcfAfzMsjaM7gOzaHyU52pW9mYHKSdMSSBmNzNWjENgjok+?=
 =?us-ascii?Q?LJNUgpSDmRQfe23caJPfimI1BR7Txa6OEMJTjRsXbijyj2rn7w1sZ6Q/FagC?=
 =?us-ascii?Q?8PBF3NFtHJGbN511xns88XAfsiHvA7V2i39CvROmA57f4nC7Y8H8qRSUuqUD?=
 =?us-ascii?Q?UR6alrucXdUanP+lW3+Y4wKRUfy1Hyt1gr9Bl8vmzi0Dgj34MuO0zloovZbN?=
 =?us-ascii?Q?fbCGfnswLQflg9Qjahb7a/V5td9QeAeYWrh76QyP6gy1Tmhf12KMkNeJMY5N?=
 =?us-ascii?Q?I3+nc+ybUWEPv9ko9ZVxjWWwmfcXDr2w1U3Dttt4qyloxup72J4202LPbiUh?=
 =?us-ascii?Q?hPMr2KiuHzaUtiDvLdUNYCWgJsYeXrCZsKCfvQeW3pCnDvj9NN3pJju2Y8iL?=
 =?us-ascii?Q?Ni9YM991o+aY7AKnr9fsrRq5FXVU23RmjJdndWiJV4G0rVsd2CL/b8/rONRb?=
 =?us-ascii?Q?HfcUcNYPNx72LxTq02K84teeffPx80Q+29hbLQlKgqwJ8bCdKUmP7euKdDLp?=
 =?us-ascii?Q?F8lgFjxZFSGCwNwUm8p4K24CJoOizTzZ8Ae9U5aOZmQDyehrIGBrVKHA89Xc?=
 =?us-ascii?Q?Pgp2OHBA15P9blgvxaeQnN+v7a7jOIqLwx7089lugAYyRGhOC/BtXuZ4PhEY?=
 =?us-ascii?Q?0SXm1c1kQXjGAUGPGIfbLJGt8jzfksqXlmMlwPGFL7nqfWyDE7sFKaVTNaIZ?=
 =?us-ascii?Q?gE5Cp9DJ0zG/sltVIkA7pd3cH1syWU38UKC1lB7lx3eN7xvBZXuvLnVRknhC?=
 =?us-ascii?Q?LRugYznL0Q4X41vtcdrbMZZQj31ESdsSTz/TJE6Jjt3GnafB20B5ReTlQ42P?=
 =?us-ascii?Q?LuH5KuY6ze3yhhJ72zEhtxg4RaYjrHZyCKgchlfv3P5cL2frSYEXKp6oTsrL?=
 =?us-ascii?Q?wF95oTR0FNcr1HgOljIIrWXtGxyx6CQdFTUj8i4QC05YpDaq9K00XYYSsmv5?=
 =?us-ascii?Q?8edXnWpMVqNxbwKRRRTng567vanH04/EjmYfkA/Jt3tqlV2PUPIQi/nKsPvc?=
 =?us-ascii?Q?YEzuzM5fRSrS2C66L5l1CpQApn1Z+Vr8vtIQfOzwz+PVSGp+Foum7BfH9OV3?=
 =?us-ascii?Q?PTwGUB5cJGuhGimCNipUtgnocrHjXnVRWAr11zAk5xv4OSW7PlJJiA8INv4c?=
 =?us-ascii?Q?id83SznrcqZVzJWFbb1QwSe3tMlumx09JZTFUc7yVMjkR9qGooOUVQSnjv/X?=
 =?us-ascii?Q?dVMFZtsmNfgYFv50Iziu/jFIOEJBryxGCfJb20DVzgfSa1Zo3aQd/Qfz6xTW?=
 =?us-ascii?Q?FmR4E9LBV5wA4fuHRCFKWxgOmAtGiR9jmj3G8zJW?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 79ecc79e-f3a8-4309-b60f-08db3d01f763
X-MS-Exchange-CrossTenant-AuthSource: SEZPR06MB5269.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Apr 2023 16:04:45.9409
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wc+G4pWkntwFT3ZqWJJRoDlSZqIF2xjj3xTCCxYPFVQmN9HquELBowta+qn23KYyuNGoakzu0bwM+RJIP3BNGw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PUZPR06MB5887
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

qbtos() and stoqb() are defined repeatedly in many files,
let's move it to the header file.

Signed-off-by: Yangtao Li <frank.li@vivo.com>
---
 fs/quota/quota.c      | 10 ----------
 fs/quota/quota_v1.c   | 27 +++++++--------------------
 fs/quota/quota_v2.c   | 31 +++++++++----------------------
 include/linux/quota.h | 10 ++++++++++
 4 files changed, 26 insertions(+), 52 deletions(-)

diff --git a/fs/quota/quota.c b/fs/quota/quota.c
index 052f143e2e0e..094c2844ede3 100644
--- a/fs/quota/quota.c
+++ b/fs/quota/quota.c
@@ -174,16 +174,6 @@ static int quota_setinfo(struct super_block *sb, int type, void __user *addr)
 	return sb->s_qcop->set_info(sb, type, &qinfo);
 }
 
-static inline qsize_t qbtos(qsize_t blocks)
-{
-	return blocks << QIF_DQBLKSIZE_BITS;
-}
-
-static inline qsize_t stoqb(qsize_t space)
-{
-	return (space + QIF_DQBLKSIZE - 1) >> QIF_DQBLKSIZE_BITS;
-}
-
 static void copy_to_if_dqblk(struct if_dqblk *dst, struct qc_dqblk *src)
 {
 	memset(dst, 0, sizeof(*dst));
diff --git a/fs/quota/quota_v1.c b/fs/quota/quota_v1.c
index cd92e5fa0062..309df78f1c22 100644
--- a/fs/quota/quota_v1.c
+++ b/fs/quota/quota_v1.c
@@ -16,27 +16,14 @@ MODULE_AUTHOR("Jan Kara");
 MODULE_DESCRIPTION("Old quota format support");
 MODULE_LICENSE("GPL");
 
-#define QUOTABLOCK_BITS 10
-#define QUOTABLOCK_SIZE (1 << QUOTABLOCK_BITS)
-
-static inline qsize_t v1_stoqb(qsize_t space)
-{
-	return (space + QUOTABLOCK_SIZE - 1) >> QUOTABLOCK_BITS;
-}
-
-static inline qsize_t v1_qbtos(qsize_t blocks)
-{
-	return blocks << QUOTABLOCK_BITS;
-}
-
 static void v1_disk2mem_dqblk(struct mem_dqblk *m, struct v1_disk_dqblk *d)
 {
 	m->dqb_ihardlimit = d->dqb_ihardlimit;
 	m->dqb_isoftlimit = d->dqb_isoftlimit;
 	m->dqb_curinodes = d->dqb_curinodes;
-	m->dqb_bhardlimit = v1_qbtos(d->dqb_bhardlimit);
-	m->dqb_bsoftlimit = v1_qbtos(d->dqb_bsoftlimit);
-	m->dqb_curspace = v1_qbtos(d->dqb_curblocks);
+	m->dqb_bhardlimit = qbtos(d->dqb_bhardlimit);
+	m->dqb_bsoftlimit = qbtos(d->dqb_bsoftlimit);
+	m->dqb_curspace = qbtos(d->dqb_curblocks);
 	m->dqb_itime = d->dqb_itime;
 	m->dqb_btime = d->dqb_btime;
 }
@@ -46,9 +33,9 @@ static void v1_mem2disk_dqblk(struct v1_disk_dqblk *d, struct mem_dqblk *m)
 	d->dqb_ihardlimit = m->dqb_ihardlimit;
 	d->dqb_isoftlimit = m->dqb_isoftlimit;
 	d->dqb_curinodes = m->dqb_curinodes;
-	d->dqb_bhardlimit = v1_stoqb(m->dqb_bhardlimit);
-	d->dqb_bsoftlimit = v1_stoqb(m->dqb_bsoftlimit);
-	d->dqb_curblocks = v1_stoqb(m->dqb_curspace);
+	d->dqb_bhardlimit = stoqb(m->dqb_bhardlimit);
+	d->dqb_bsoftlimit = stoqb(m->dqb_bsoftlimit);
+	d->dqb_curblocks = stoqb(m->dqb_curspace);
 	d->dqb_itime = m->dqb_itime;
 	d->dqb_btime = m->dqb_btime;
 }
@@ -172,7 +159,7 @@ static int v1_read_file_info(struct super_block *sb, int type)
 	}
 	ret = 0;
 	/* limits are stored as unsigned 32-bit data */
-	dqopt->info[type].dqi_max_spc_limit = 0xffffffffULL << QUOTABLOCK_BITS;
+	dqopt->info[type].dqi_max_spc_limit = 0xffffffffULL << QIF_DQBLKSIZE_BITS;
 	dqopt->info[type].dqi_max_ino_limit = 0xffffffff;
 	dqopt->info[type].dqi_igrace =
 			dqblk.dqb_itime ? dqblk.dqb_itime : MAX_IQ_TIME;
diff --git a/fs/quota/quota_v2.c b/fs/quota/quota_v2.c
index b1467f3921c2..d4282329753b 100644
--- a/fs/quota/quota_v2.c
+++ b/fs/quota/quota_v2.c
@@ -41,19 +41,6 @@ static const struct qtree_fmt_operations v2r1_qtree_ops = {
 	.is_id = v2r1_is_id,
 };
 
-#define QUOTABLOCK_BITS 10
-#define QUOTABLOCK_SIZE (1 << QUOTABLOCK_BITS)
-
-static inline qsize_t v2_stoqb(qsize_t space)
-{
-	return (space + QUOTABLOCK_SIZE - 1) >> QUOTABLOCK_BITS;
-}
-
-static inline qsize_t v2_qbtos(qsize_t blocks)
-{
-	return blocks << QUOTABLOCK_BITS;
-}
-
 static int v2_read_header(struct super_block *sb, int type,
 			  struct v2_disk_dqheader *dqhead)
 {
@@ -127,7 +114,7 @@ static int v2_read_file_info(struct super_block *sb, int type)
 	qinfo = info->dqi_priv;
 	if (version == 0) {
 		/* limits are stored as unsigned 32-bit data */
-		info->dqi_max_spc_limit = 0xffffffffLL << QUOTABLOCK_BITS;
+		info->dqi_max_spc_limit = 0xffffffffLL << QIF_DQBLKSIZE_BITS;
 		info->dqi_max_ino_limit = 0xffffffff;
 	} else {
 		/*
@@ -226,8 +213,8 @@ static void v2r0_disk2memdqb(struct dquot *dquot, void *dp)
 	m->dqb_isoftlimit = le32_to_cpu(d->dqb_isoftlimit);
 	m->dqb_curinodes = le32_to_cpu(d->dqb_curinodes);
 	m->dqb_itime = le64_to_cpu(d->dqb_itime);
-	m->dqb_bhardlimit = v2_qbtos(le32_to_cpu(d->dqb_bhardlimit));
-	m->dqb_bsoftlimit = v2_qbtos(le32_to_cpu(d->dqb_bsoftlimit));
+	m->dqb_bhardlimit = qbtos(le32_to_cpu(d->dqb_bhardlimit));
+	m->dqb_bsoftlimit = qbtos(le32_to_cpu(d->dqb_bsoftlimit));
 	m->dqb_curspace = le64_to_cpu(d->dqb_curspace);
 	m->dqb_btime = le64_to_cpu(d->dqb_btime);
 	/* We need to escape back all-zero structure */
@@ -248,8 +235,8 @@ static void v2r0_mem2diskdqb(void *dp, struct dquot *dquot)
 	d->dqb_isoftlimit = cpu_to_le32(m->dqb_isoftlimit);
 	d->dqb_curinodes = cpu_to_le32(m->dqb_curinodes);
 	d->dqb_itime = cpu_to_le64(m->dqb_itime);
-	d->dqb_bhardlimit = cpu_to_le32(v2_stoqb(m->dqb_bhardlimit));
-	d->dqb_bsoftlimit = cpu_to_le32(v2_stoqb(m->dqb_bsoftlimit));
+	d->dqb_bhardlimit = cpu_to_le32(stoqb(m->dqb_bhardlimit));
+	d->dqb_bsoftlimit = cpu_to_le32(stoqb(m->dqb_bsoftlimit));
 	d->dqb_curspace = cpu_to_le64(m->dqb_curspace);
 	d->dqb_btime = cpu_to_le64(m->dqb_btime);
 	d->dqb_id = cpu_to_le32(from_kqid(&init_user_ns, dquot->dq_id));
@@ -279,8 +266,8 @@ static void v2r1_disk2memdqb(struct dquot *dquot, void *dp)
 	m->dqb_isoftlimit = le64_to_cpu(d->dqb_isoftlimit);
 	m->dqb_curinodes = le64_to_cpu(d->dqb_curinodes);
 	m->dqb_itime = le64_to_cpu(d->dqb_itime);
-	m->dqb_bhardlimit = v2_qbtos(le64_to_cpu(d->dqb_bhardlimit));
-	m->dqb_bsoftlimit = v2_qbtos(le64_to_cpu(d->dqb_bsoftlimit));
+	m->dqb_bhardlimit = qbtos(le64_to_cpu(d->dqb_bhardlimit));
+	m->dqb_bsoftlimit = qbtos(le64_to_cpu(d->dqb_bsoftlimit));
 	m->dqb_curspace = le64_to_cpu(d->dqb_curspace);
 	m->dqb_btime = le64_to_cpu(d->dqb_btime);
 	/* We need to escape back all-zero structure */
@@ -301,8 +288,8 @@ static void v2r1_mem2diskdqb(void *dp, struct dquot *dquot)
 	d->dqb_isoftlimit = cpu_to_le64(m->dqb_isoftlimit);
 	d->dqb_curinodes = cpu_to_le64(m->dqb_curinodes);
 	d->dqb_itime = cpu_to_le64(m->dqb_itime);
-	d->dqb_bhardlimit = cpu_to_le64(v2_stoqb(m->dqb_bhardlimit));
-	d->dqb_bsoftlimit = cpu_to_le64(v2_stoqb(m->dqb_bsoftlimit));
+	d->dqb_bhardlimit = cpu_to_le64(stoqb(m->dqb_bhardlimit));
+	d->dqb_bsoftlimit = cpu_to_le64(stoqb(m->dqb_bsoftlimit));
 	d->dqb_curspace = cpu_to_le64(m->dqb_curspace);
 	d->dqb_btime = cpu_to_le64(m->dqb_btime);
 	d->dqb_id = cpu_to_le32(from_kqid(&init_user_ns, dquot->dq_id));
diff --git a/include/linux/quota.h b/include/linux/quota.h
index fd692b4a41d5..23a09bc954a4 100644
--- a/include/linux/quota.h
+++ b/include/linux/quota.h
@@ -538,4 +538,14 @@ struct quota_module_name {
 	{QFMT_VFS_V1, "quota_v2"},\
 	{0, NULL}}
 
+static inline qsize_t qbtos(qsize_t blocks)
+{
+	return blocks << QIF_DQBLKSIZE_BITS;
+}
+
+static inline qsize_t stoqb(qsize_t space)
+{
+	return (space + QIF_DQBLKSIZE - 1) >> QIF_DQBLKSIZE_BITS;
+}
+
 #endif /* _QUOTA_ */
-- 
2.35.1

