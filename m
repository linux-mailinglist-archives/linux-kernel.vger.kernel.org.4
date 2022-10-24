Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 443AD60B788
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Oct 2022 21:25:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232486AbiJXTZn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Oct 2022 15:25:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44934 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231282AbiJXTXE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Oct 2022 15:23:04 -0400
Received: from APC01-PSA-obe.outbound.protection.outlook.com (mail-psaapc01on20714.outbound.protection.outlook.com [IPv6:2a01:111:f400:feae::714])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 90C9B114DC0
        for <linux-kernel@vger.kernel.org>; Mon, 24 Oct 2022 10:57:40 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KWY2aZSOOgAMjyOd8TmzZJTFzVVgTY8CKlJY59oZ+oD0Kw3aLl8hOvirCR2//OTWYtbEpCJjSFiLrMDDfH50eopDK4GvecxcDtFHYhLMmrRglTcugZTlfzeu9EAkR4r4L9qpDGOGuetnJ1S1sNDL6ILBCjUFak0bd2U6L825GLY8VVWGjQdl8ONBq2ONlaBAyiXpQpqZq8EmmaTiQyQusQVH4s4ekOGqsFQPAReYpmnG+2hLW10wNWI5uxyhY7jBFMslIu9GIK7H3J2u4iiG2er6agzrqYCL9UCH/cL8F77UaYPRepN6xVBe84OHCjVZzmdILFhNq0oBcK8dhVklDg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DJuYJRTZDba9KMvD8fVPY2yJ15td7zaIKsDLJAQQWCY=;
 b=m0tWhbmcirL3PjVsKAI7FWTC/nHFnuVWVVAmmqiCXtFrHvEEyLvfOYu0YXNZMSJCjmYxFORSzLBChQSDrkDJqHYqwUwfXQIvq75QOmnAM2FrJDD9gHMnFXC29heYyWUsbJxzzM15TrvGJC5ise9eMZyJ/KGq7DAXEAcxzOs3NTl6G6Pwti7sd2+ykehkycpx24SyUkJRzy3bL/j8DIQ7WQt3cqINa3KArRnrT08FMiTi+oZjB+hpzDv/ZxdWAHxfMrLhBvnF42PuOhUlsPwh6NE6gtMWfB1jEd0mSTRZKdYw0zpZVo8SQ8gebKpMt+MXT1txRbjQhyagtqXOMfnryg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DJuYJRTZDba9KMvD8fVPY2yJ15td7zaIKsDLJAQQWCY=;
 b=pZKdfwm8O6fhiJ/ndH6KPHaz2UmE9hKsni4jPw1S0kK/nGLyzwg48H3R4eyXWp+mBX08yLYiMY39mW30vRHNs+cOlo5WEuT9yCefAdGrAIC8y3nApuC5RlCqCN8r88P8C16FAwdsxo+MHO0rS9BnpsXmtacGc0rMnPwKs6U4NIsSDHLYvpTaV3virON2LqGPBC/bnrHVFRePgCNXyFBfRV3focViqFv/kltTbdZfVtfV0PkojcuoyyFVbWkxfTax9eBIaSjWZY4AyPYRzZcCbh67l5VjvkiI/AauMJDoQKOVnyZbrC6mzFsy94ZanHvIfgVTaeScNxHWZhVlLVDjeA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com (2603:1096:101:78::6)
 by PSAPR06MB3992.apcprd06.prod.outlook.com (2603:1096:301:37::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5746.21; Mon, 24 Oct
 2022 17:54:11 +0000
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::c84b:5a6c:d66f:c0fd]) by SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::c84b:5a6c:d66f:c0fd%3]) with mapi id 15.20.5746.023; Mon, 24 Oct 2022
 17:54:11 +0000
From:   Yangtao Li <frank.li@vivo.com>
To:     jaegeuk@kernel.org, chao@kernel.org
Cc:     linux-f2fs-devel@lists.sourceforge.net,
        linux-kernel@vger.kernel.org, Yangtao Li <frank.li@vivo.com>
Subject: [PATCH] f2fs: add barrier mount option
Date:   Tue, 25 Oct 2022 01:54:01 +0800
Message-Id: <20221024175401.18888-1-frank.li@vivo.com>
X-Mailer: git-send-email 2.35.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI1PR02CA0008.apcprd02.prod.outlook.com
 (2603:1096:4:1f7::14) To SEZPR06MB5269.apcprd06.prod.outlook.com
 (2603:1096:101:78::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SEZPR06MB5269:EE_|PSAPR06MB3992:EE_
X-MS-Office365-Filtering-Correlation-Id: 46835af5-73a3-4258-808f-08dab5e8c16b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 1yCeMsqyP91+OYEimQv3+K8Lx0GwduKj9dF6N++rY6jKKqg72pvFiboF2qzs0gc3cvFq2ZE51ZBbZWodWlTGSb+XbBv7AQv5iFQw4036JufLIjwB4feqV7Fp7jfi7MtS2z0AvmqqSpxuuSxIcQQnxzQucRUP6EzWdC7MnhFrnst9I8VlIBKu4P9bhe6FRUk86vlEtmzQTCqLOroDBpwImNSwqyqk6edrb0btVpRMy88O4VF1i5RrtBasdug0p//r3WLiMPPwnD8DqjZA1Pa1E1mMfnx6FT+9rRY8/ZT3SzQfYuXLdygrQWTHtVqBJ1hvuGQbyRsNjiTRUvJjPseAavFMPSbKiwvcf5fDaTvNVzvkgumrJwuyRmChwkUYAWFsRZYlgafASz04i2JM0QA2TPjpNb5QI/pqiGJ159UJDRBji6UMFg8Snnm5Usfr0nuziDwCD2WlUPgMXWLx5YPujYkmDyqcn/0U0F/LGcG0W2l7U1IttO7jY9kAj+g0Y9G0A9HSQxlD/51nHLaWIHQtwCILlA3SCZBA4dgnAOPqAlkmuTNFF49pktM90xTYh6DHlPVplV00xNT3y4grElgAxoGOD67eBjp6/7XVTPW+PuSb2wHmK+IixjEez93gnjL8R4WROMQZ3ZeHs8HEkvEIhXbllYZhwmhBrD+Lv+euQcpmrjBTJqDyG3yipErLWHuOh2AxUbjvpxYNT+8lBCl1NXsmtn4p7uuL62zx7oZsPVYk3gr9DUs+PhTYaXfiCJZR
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEZPR06MB5269.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(136003)(346002)(366004)(396003)(39860400002)(376002)(451199015)(186003)(2616005)(5660300002)(83380400001)(1076003)(6486002)(86362001)(38100700002)(41300700001)(38350700002)(2906002)(8936002)(26005)(6512007)(6506007)(52116002)(107886003)(6666004)(8676002)(66556008)(66946007)(478600001)(4326008)(316002)(36756003)(66476007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?EJwP7cBkz6ElmKrVkFLykwiVLlGEtm6Pqqf0hyilK8SAEjSQXCAkXOaTsZlk?=
 =?us-ascii?Q?/50Wt+cSDZp4pyyGYhWFoHKHfekHvxwnVmHrzPY43l6cIzvmqWx9C5A6YfUR?=
 =?us-ascii?Q?RMdMsYNgvQGMhKXaGqCWC2Tuuqxy9qYBeyVkd2slTQEVvfbWWfkr0F/CpN0F?=
 =?us-ascii?Q?KoP32Edm1nyBGjzwLcY0MT55NyqhRGWLTd2kbrVK/LzoWYp4JLPrtzsZp3w8?=
 =?us-ascii?Q?Zj9tNh2uOGeXKU5VZWWyfS6geZwTNOerZYGIEwqTqLPWQLkds2wfnAhSoDYn?=
 =?us-ascii?Q?JFgBxDZLauKlK2TGt8Ua7KokANz/ZwOoFepQwL4tfoYc7E/PFD63hQ98hySd?=
 =?us-ascii?Q?R0uc9S+eW3A83Lcn5AIkkE+5WI76ttg3p5STS8f5qlyw5bLnDQyBr+Q3OZVE?=
 =?us-ascii?Q?064H+QlEQjdmcNR+qFXu5dBhMbnSZaEdPt/S3l+2QsrlBnYqBmcxnGCe21Uk?=
 =?us-ascii?Q?sa4sCl4S1TXA75Zwd1crL0VCRtVbY/OVEPyuDEEBL4quR7LXv/iBIcegZRRV?=
 =?us-ascii?Q?zN6c/Lmmfq4GUVZRt2TC0cx0bgMGIJ21P+JtR+BQS7wxDqyV8vcS+oXIf8vQ?=
 =?us-ascii?Q?iel+3qYGfZz55Iu4GS60ri+QIKD/s2vCAPLNcBGUHQbHomSG2jE2vPAY05vQ?=
 =?us-ascii?Q?HW9KBdhMFsG2DcFP+USC4yyqvQbXsqQRufZG5VwgnJ9hngB6JzPu/XSKbF27?=
 =?us-ascii?Q?M/mB688yYGGCvLeHMB5frGSgLGt1YYvVGLdgkZ3Z3Ai1SKUBCFIgBAnvt4cN?=
 =?us-ascii?Q?4g/KNH5rSKF4tw/OdyG3iM+qHxd+sJVHpQFs49l1hYDdGEFMw75JJJmiVAeq?=
 =?us-ascii?Q?krLMnuuGDGshVgq3mngjipNL1xh7UfVZX2/LJNM+hK1kbQVxjXu3Zay0CX4n?=
 =?us-ascii?Q?DljWwQv/rcL0BPGTIcljjvc64sRmNeLcjNWNGLXI5c4Lbm8LvwB29Nk4tnSb?=
 =?us-ascii?Q?zX+UvjT1d7z+FOSQQC0OBYVvtipfC0v/9PKqWLLXZ2vSnJBqNoeRwSF+lp+E?=
 =?us-ascii?Q?eZTIbtGSMWvhaKlmemAL58QH8/kjjeF8ieNli7qJW6hUvZs6Xo/bq/YS7YrP?=
 =?us-ascii?Q?pPrmhbvkNj5sbIK/+HYCl5vPo0Nk8kHQX6RBbb7BSUAhN/831ah/ZgO/V7Jd?=
 =?us-ascii?Q?79qA/BCSgqn0EqGYfvkGc6cR831SnY4xA4sciQCvsJBX919jVHvv64LUjdji?=
 =?us-ascii?Q?84dEwKE4qTtTdcVkcujZFx2TstUg48fPjCoUJLYlmZW91lcAtGFQq0CA4nKp?=
 =?us-ascii?Q?bN8i5UmE0+K8ehtYiFQhQ3aIGjVPHmmkRYna/9iCqC1aWaztF1+lzkElJ0ch?=
 =?us-ascii?Q?SNz9z29U0ntkHvet5lQOBVLgOwT189O24vG+3jaxXcFkhLfF7eFu1eQZfUXY?=
 =?us-ascii?Q?UkBO4M3n83IcBOJE1UKiCqwvAZ31ZzkadcqpxZ2YM0U9r6HRRGz3/8K1Vv1A?=
 =?us-ascii?Q?mgCDPoNdt+cvdn/l8uPU+4y8VXd5wAwfleq0n1vtdTnIk+CbIcrgP1ggvA4G?=
 =?us-ascii?Q?2sqAAQZDCEDXKrZ58eJDs3m+9wweHVGbKcMFNbYRVB5WLrFxQy6pRWQkzpxe?=
 =?us-ascii?Q?W+dYbYwNy7UMGE6jpkSBtVvY8XxsZT8f3NnKyqzB?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 46835af5-73a3-4258-808f-08dab5e8c16b
X-MS-Exchange-CrossTenant-AuthSource: SEZPR06MB5269.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Oct 2022 17:54:11.0153
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: NJVkfxC+joBDtFypTP1TuMt/CplZVyIqkF0gQu8uWIaKAMt+8xI5gLdc6X6paOHAtf6lYs9C3MtuYapsRSHoCA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PSAPR06MB3992
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch adds a mount option, barrier, in f2fs.
The barrier option is the opposite of nobarrier.
If this option is set, cache_flush commands are allowed to be issued.

Signed-off-by: Yangtao Li <frank.li@vivo.com>
---
 Documentation/filesystems/f2fs.rst | 2 ++
 fs/f2fs/super.c                    | 7 +++++++
 2 files changed, 9 insertions(+)

diff --git a/Documentation/filesystems/f2fs.rst b/Documentation/filesystems/f2fs.rst
index 17df9a02ccff..5eccc4b3eef5 100644
--- a/Documentation/filesystems/f2fs.rst
+++ b/Documentation/filesystems/f2fs.rst
@@ -154,6 +154,8 @@ nobarrier		 This option can be used if underlying storage guarantees
 			 If this option is set, no cache_flush commands are issued
 			 but f2fs still guarantees the write ordering of all the
 			 data writes.
+barrier		 If this option is set, cache_flush commands are allowed to be
+			 issued.
 fastboot		 This option is used when a system wants to reduce mount
 			 time as much as possible, even though normal performance
 			 can be sacrificed.
diff --git a/fs/f2fs/super.c b/fs/f2fs/super.c
index 3834ead04620..f0613ea266bd 100644
--- a/fs/f2fs/super.c
+++ b/fs/f2fs/super.c
@@ -110,6 +110,7 @@ enum {
 	Opt_noinline_dentry,
 	Opt_flush_merge,
 	Opt_noflush_merge,
+	Opt_barrier,
 	Opt_nobarrier,
 	Opt_fastboot,
 	Opt_extent_cache,
@@ -186,6 +187,7 @@ static match_table_t f2fs_tokens = {
 	{Opt_noinline_dentry, "noinline_dentry"},
 	{Opt_flush_merge, "flush_merge"},
 	{Opt_noflush_merge, "noflush_merge"},
+	{Opt_barrier, "barrier"},
 	{Opt_nobarrier, "nobarrier"},
 	{Opt_fastboot, "fastboot"},
 	{Opt_extent_cache, "extent_cache"},
@@ -806,6 +808,9 @@ static int parse_options(struct super_block *sb, char *options, bool is_remount)
 		case Opt_nobarrier:
 			set_opt(sbi, NOBARRIER);
 			break;
+		case Opt_barrier:
+			clear_opt(sbi, NOBARRIER);
+			break;
 		case Opt_fastboot:
 			set_opt(sbi, FASTBOOT);
 			break;
@@ -1939,6 +1944,8 @@ static int f2fs_show_options(struct seq_file *seq, struct dentry *root)
 		seq_puts(seq, ",flush_merge");
 	if (test_opt(sbi, NOBARRIER))
 		seq_puts(seq, ",nobarrier");
+	else
+		seq_puts(seq, ",barrier");
 	if (test_opt(sbi, FASTBOOT))
 		seq_puts(seq, ",fastboot");
 	if (test_opt(sbi, EXTENT_CACHE))
-- 
2.25.1

