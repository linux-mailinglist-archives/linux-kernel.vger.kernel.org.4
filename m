Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5F0D0687923
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Feb 2023 10:41:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232334AbjBBJlr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Feb 2023 04:41:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50144 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232014AbjBBJln (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Feb 2023 04:41:43 -0500
Received: from APC01-PSA-obe.outbound.protection.outlook.com (mail-psaapc01on2109.outbound.protection.outlook.com [40.107.255.109])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A73D83262
        for <linux-kernel@vger.kernel.org>; Thu,  2 Feb 2023 01:41:42 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PEElaf3lY/RUOe5vKLzxuqGTJQktpAMJZ8tgGyGIktPs+kTn9VlSO18PMqlXFL/71EDzMA7kfjoT5dyIS0YsIb0YB2jRLfQwgu8Y4ejjmqOLaTWrq01u4VLx8mxlv8bGXr4Z2GOQeHEW5T0NmbhxYwcXZvLTvSOdZcAwhdYKJncV7JriyFlMtYnfmZZAaB/il2GVfAQ7GQQbi/samFtOS4kGq1Ipi7cAfd9zqAGNJoWtd/b84MUGDf1wGIC05cAHqNLIkOKiaV8OiLwSfnUG5KxuAP1VSLigF0dTDKkaPwpTitKlYTlFEneKCRC2R4cN2RlEFzoNs1rl1ZaXZ5AQ7A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=d6ey7vAAt2izQwAOGBj5q+b3OAqGK6rdZflWN1o2NPQ=;
 b=MMDOmiGmHMa/hbbENpizCB3oT8/ZKOQj/T4hjx973DEzYqSx1ufkWvWqLmW/+E7eCmF3ru69KZeRhCzenIMzQpclPZisMoulNVXHKy4OCtnAGboAcpI29YfCcUrAgIB/zQey1/CVwjq8w65HHGY4JpzCEVD4fM3ttotKVKAMCehmCd68DN+Q+31SyQX5bOjkR+iQ5ZSsnbGLAtMWAMFw12X1MYDCBMXMcleZoa7jonH9yv4sWUwu07AvfjoulS4HE+tCP/agLYrsQQo8vMvAPaI4yMb6v7m5kTBXWWqkCHQDKv/LWsHYQ1Qj+mDmIEjlURJARR9R1zaDT31G4L+tDA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=d6ey7vAAt2izQwAOGBj5q+b3OAqGK6rdZflWN1o2NPQ=;
 b=UdgCOSI/xuKi+TrwBHFiKwrw3CDWteK2fdTVRMS+1Q5iiQKgQVYbIXGAym1Tw3fDlX88FcLBvz4PyhDWyXo7rHXenpNH34jam+pL2OPJrPJCn1HhsMRLLKyArmFbNIkmHa54U2fvXTgabGUuzcr6eyaMHBvmXKNkof8IZE+P163Hu7d8waArLeVHWxIwUdZZQk9UZwRFApy5xHm1SkUfyubOyfaIct9cYebDMsIqOWhb0w3scX6x5FWMoFBR7d2bnZEqAfeOXQPTVrxuJX6nvjUREpt4G4W1Pyqs41+nJEyy9pKXQ/ijgT7+UMNt+ib7qW77EJUlQ9o0VxwSgCG8bw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com (2603:1096:101:78::6)
 by SI2PR06MB3914.apcprd06.prod.outlook.com (2603:1096:4:f8::5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6086.6; Thu, 2 Feb 2023 09:41:36 +0000
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::3e52:d08c:ecf4:d572]) by SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::3e52:d08c:ecf4:d572%5]) with mapi id 15.20.6064.022; Thu, 2 Feb 2023
 09:41:36 +0000
From:   Yangtao Li <frank.li@vivo.com>
To:     jaegeuk@kernel.org, chao@kernel.org
Cc:     linux-f2fs-devel@lists.sourceforge.net,
        linux-kernel@vger.kernel.org, Yangtao Li <frank.li@vivo.com>
Subject: [PATCH] f2fs: fix f2fs_show_options to show nogc_merge mount option
Date:   Thu,  2 Feb 2023 17:41:23 +0800
Message-Id: <20230202094123.74342-1-frank.li@vivo.com>
X-Mailer: git-send-email 2.35.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR02CA0020.apcprd02.prod.outlook.com
 (2603:1096:4:195::7) To SEZPR06MB5269.apcprd06.prod.outlook.com
 (2603:1096:101:78::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SEZPR06MB5269:EE_|SI2PR06MB3914:EE_
X-MS-Office365-Filtering-Correlation-Id: fd24b0b3-d606-4efe-4daf-08db0501ad31
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: wK7R86B++jA7rn0z9MGp3xX9PXipJTHAKxDCNrXuQdCjzi0YPpzv3RHdLD5p6pofck7msTmfi8JeUfoA6RYT7JUx/n6pn0hiEtGO8IdwB+tuW061KkDIOphRy6F62l9DLlYyalIJY0FwSiBttXx1xbeFJSfnE7YK/8iz2SD9XROmq5hFn7ws0kp//yIdTV4t9bi6Q2lQvYy5S0CJxbjmL3TLB21EUq1drCv2pM1f+5CES50dbQq+10Z5mmFB4nOK8Y7apilL93wl6wjVei3aLtMZnUfNQNvHTFFv3r3mkE7xX6YtfYBvJgnGHJROvb326WB24mCmAp3v1g7vbUF6gqVwYREQk/jphZRZ8ObD/v4TCjTBsZ3dgObVJovISTNISz8vpeQiK9sV11Dzp4MesLWYuclGw68qUbV2aTMVMF3TFy6BQRioKOeJcHgbmDFAKj/V0VYx5TeFIlVe2lfBaf8lye+mp6nwNfs9CBKFgr4wZRh5FkbMFSR9u8NyhO7Fj/hL2sVKI9G1rM0IqDXLugQvXLXVUhM3bXO1I43YIztO1OB8nSENg4BNDcSPECa7MmS5h/lcUjhIqTfa6cC43k681ryHqeA/xX66/H9Fzw1NvM0Qhjqqcf6e6rTLSrr1PZg1aml9p7Xiotkot7+xplryqTP43Hn3ENzYfR+GrcRjlVe2H+S3Em320xEoarkFYqSNg2WRg2P6ZC3yNN9nbw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEZPR06MB5269.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(346002)(376002)(39860400002)(136003)(366004)(396003)(451199018)(38100700002)(38350700002)(5660300002)(316002)(2616005)(86362001)(36756003)(186003)(6512007)(2906002)(26005)(52116002)(6486002)(6666004)(478600001)(107886003)(66556008)(66476007)(4744005)(4326008)(66946007)(6506007)(1076003)(8936002)(41300700001)(8676002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?D/ftA8Cl1iE9vq16Fac2xg9EeCc6rNpJFjorX5hf8RGDTtPI8zgQ/XlFAieN?=
 =?us-ascii?Q?BqY5yUGXnTmQFX/Fl42N9yFTV/3CDTz6AZrSB6kVLmBP0NYuVLvPhF7iK8IP?=
 =?us-ascii?Q?S8QvKjRLW21h2wS1ztSsO6DZQuRjQni7ijZ9x39V6iXNqEiAjOpYhP3b4wRk?=
 =?us-ascii?Q?o1PTCXM1yrZNcXhwN5snEtPJfIlf3hsc3pbgH1Cx7L2dxnDqOD1o6rK9e6EW?=
 =?us-ascii?Q?LyCkdDPEoGejTbbMOA9pUEG08uiVvo3s4QHckUm6LlTy2iPB2mS3Y1QiuVqP?=
 =?us-ascii?Q?mvlAezOVAL7dI58MaJa6a+j3JYvcD/38nqYG/iBdQp0ciCIBAZ8VkuQzUIDZ?=
 =?us-ascii?Q?YH9v6voRRi6wPy8U1FwqQPc0lqDQFUmry3pa53GaFxNHAfO5yPhJBIZQWbEC?=
 =?us-ascii?Q?JJpHDiKIL60VzaVT6ne3YSge6xLtf0aqBQEI0Ysro4yVA8mzfVLFsnBX3lI8?=
 =?us-ascii?Q?GJ+FaIUkt11B2yImg3y3GZbhG46ThLl+xRDweSwOB9emCA7+XfcgM36Kvg0l?=
 =?us-ascii?Q?g3WGHLEFWBvZj38z29Uq5LUk6eO9ibjq0q0WOFQ8bqYIusc29ybchZ24Xlzh?=
 =?us-ascii?Q?T1tDIikF1QGdMjwO4ydywy2MGSqE87gg1cNZgeu6IE597YfvCk25QfR6kuBS?=
 =?us-ascii?Q?hLUCy9NQWkhXPGD8RFosv98iit7j2tDbsnWaIILLoKGXD1BhVtwKwD/yKaAe?=
 =?us-ascii?Q?oGyWt6mO+GTb2PyZkGb5fuSxPgbs6osV7IMDz1xoKfX7Rlnq1wZolWS6wJQG?=
 =?us-ascii?Q?MV/47vtK2nid4F5FHrfed+kNpM/ULPAGfRDTLFPmR1i46BnaS4pvZ6LXhmbL?=
 =?us-ascii?Q?9ReZUx/c1a5eVdl2NTGyAgSrH1nnYGwkgYqEiyXxsT0JeK1AU0doaiExvHDq?=
 =?us-ascii?Q?tnb3BcR5euISe9FRSUaDI9efw15eavF7dOSOOETc6VpiTt+Th8FsaXsNKDMz?=
 =?us-ascii?Q?uS3ee04+zfO2FSoP9vDHA1X6BlT8UvYYrg5NrIj9cV3gPV6KV1aNBIfHuGyK?=
 =?us-ascii?Q?YWS5yxkNIXp5i3FN8fp8px4/evH/dZ8tzxsfOhAnw/J9bWBvVz5e9JgV05rX?=
 =?us-ascii?Q?8IafrMTejcuAciceg/G5bifpoATO7ock29Hg5i9Qj84icqXVC8mvwZXkEBUs?=
 =?us-ascii?Q?s+YpLFG8V2sQheT0Tmo5Fzn1uWkVLrDmlQdmY1vMdO0vvwZsuY3U3Osg4uAA?=
 =?us-ascii?Q?9CP9cDPhl/44A6NmCaxpdg4vYKQG4UA5IGmWBjL5DXNVy8urtyt3KZBK1joL?=
 =?us-ascii?Q?amkevqkTTthdFd45GOgupD4kTP043BBb6pearajimTNEodVFCiOItJSM+xQF?=
 =?us-ascii?Q?FcPyFYhxgADwdXy5L4mfJoR0OrooW5mShbFYCwvxqvETEspp0YntP1XZ6jeO?=
 =?us-ascii?Q?LUx+GNdyxtf7taISTDAkvNGCdSmFm8/rQnlfI2ITaUc7GhiI1zeWQuC7zUBN?=
 =?us-ascii?Q?w/Da1zoZR4qUluAfKM6tW6zoOeqv4oF4KCkv8P3owmTBta0gk0jBtzXdqYSf?=
 =?us-ascii?Q?hYoexoXgqA8vxlB5rCNlGQwJ2KH6QyN1AMomUBoguP4mCyUjDQ8DmK6Uvnvo?=
 =?us-ascii?Q?zX2hvnyx4Tcjj4CiZCH74EKsuyfJgVWsDsE8i1MV?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fd24b0b3-d606-4efe-4daf-08db0501ad31
X-MS-Exchange-CrossTenant-AuthSource: SEZPR06MB5269.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Feb 2023 09:41:36.4039
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: VxM6B2m2XwS9TKeC4koMrsj3mTEq5NG67Kjcfz7Yt7ascz4id3T/IOJwYmL4AYX969s3Ds6pEbRqMN6pSQDomg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SI2PR06MB3914
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit 5911d2d1d1a3 ("f2fs: introduce gc_merge mount option") forgot
to show nogc_merge option, let's fix it.

Signed-off-by: Yangtao Li <frank.li@vivo.com>
---
 fs/f2fs/super.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/fs/f2fs/super.c b/fs/f2fs/super.c
index fddff5deaed2..4ec2cbbc47eb 100644
--- a/fs/f2fs/super.c
+++ b/fs/f2fs/super.c
@@ -1902,6 +1902,8 @@ static int f2fs_show_options(struct seq_file *seq, struct dentry *root)
 
 	if (test_opt(sbi, GC_MERGE))
 		seq_puts(seq, ",gc_merge");
+	else
+		seq_puts(seq, ",nogc_merge");
 
 	if (test_opt(sbi, DISABLE_ROLL_FORWARD))
 		seq_puts(seq, ",disable_roll_forward");
-- 
2.25.1

