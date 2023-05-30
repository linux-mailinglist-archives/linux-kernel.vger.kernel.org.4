Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A8FEA7157BC
	for <lists+linux-kernel@lfdr.de>; Tue, 30 May 2023 09:57:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229774AbjE3H5N (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 May 2023 03:57:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51144 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229739AbjE3H5L (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 May 2023 03:57:11 -0400
Received: from APC01-TYZ-obe.outbound.protection.outlook.com (mail-tyzapc01on20702.outbound.protection.outlook.com [IPv6:2a01:111:f403:704b::702])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 29059A0
        for <linux-kernel@vger.kernel.org>; Tue, 30 May 2023 00:57:04 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Dytt+o1hlBYBFFVe2a1HATz4xjaQe/+C36nUKQTzVjZW/wWDH9Jvi2QyIhfVppritiTePFHaEGiL8UpdsvKNSsQl9hozVJytMQyoxuwVx0R+mOcS5tVnUOW9FsgdmTHqneF0xdzs/a2/ATxLoKtHdHTQHGUoleWUfg4v4UG5uPjd4qmi4CvzEbiSvnmNt/Uyfu9jukJ2QwqkIyvjlUdvUwVZdR7a+47flCulUhV1L5ibYw7hOjEHh6iZ3DkCCxfdPRQ93au7q/hU0T+ToakQ6WzgWOiDbL7dbyy5EAXzgv1jdn2BVqDztVolzsVI5ly+Gmmm/s1JYrFyXrTykzwWLw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Z8IuOvZqgrFTVCxedT/o+g2yxiOwOy0hnQ7cKgAc9LQ=;
 b=fidn7YKwJeCaAqNmSTRD+v5u7epMOKCAZYztnXfmx3w+ZOAl6MDxRhaajlOjkSMMr3GbTcLlTAWUmgioAZK4gMVFXrMuyA5RMwgVYlOejD8lrnik5RM44kFWr0idHjAig5mAXLBsJutgT7hwoP9S1l11M7jUF5E6beOlCY5aO5Xvg/D2dRkYnQLl8C8ImuW44DbhrySyxVnFu7H6t7zznKUiDkH4V9Fr2E3tbq9m8G4vF5QGuv6eeZK8hLl5QFDW47Zd/UkENPFp1HMadBIZ9vzYcrWz2RNQhPRXH3awcsUbII3qgslReXn04iEXcqr5sbYu9I8vLgtQL0vJW4sjgQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Z8IuOvZqgrFTVCxedT/o+g2yxiOwOy0hnQ7cKgAc9LQ=;
 b=lM+Gb/ln3Al4JOjqS269wkcPU5nagRVFwz3CpYm40RDwdtpwBio9u2kIHeGJ/gLmxakrHZOVf9CA8+wqeHvVxYl8MqZvUB98GCW8i9APw4fwhQBSbfVC7O7aliyZDtF+z9vlTHYza5a1I09nfWlZGBfjqT8SLZbN3pDVLoSXbZIKlxJw+qq3vtQjOQnbgnkh54Xo2dhmiP27dxbqnXay7HKeEiapEeFqiHxkiPKVX7cyBgha4L2EbH6A9bJy7qccJB2s52/18/8HZZiASXtX+G3DAaxFjSKlLKi8ZYMwkv/Bc66kLImlYj14MaHA1cwmrq4TQxX1ltWLH1pU6Ey4Lg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from TYZPR06MB6697.apcprd06.prod.outlook.com (2603:1096:400:451::6)
 by KL1PR06MB6520.apcprd06.prod.outlook.com (2603:1096:820:fd::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6433.23; Tue, 30 May
 2023 07:56:59 +0000
Received: from TYZPR06MB6697.apcprd06.prod.outlook.com
 ([fe80::f652:a96b:482:409e]) by TYZPR06MB6697.apcprd06.prod.outlook.com
 ([fe80::f652:a96b:482:409e%5]) with mapi id 15.20.6433.018; Tue, 30 May 2023
 07:56:59 +0000
From:   Lu Hongfei <luhongfei@vivo.com>
To:     Josh Poimboeuf <jpoimboe@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        linux-kernel@vger.kernel.org (open list)
Cc:     opensource.kernel@vivo.com, luhongfei@vivo.com
Subject: [PATCH] tools: Remove unnecessary variables
Date:   Tue, 30 May 2023 15:56:49 +0800
Message-Id: <20230530075649.21661-1-luhongfei@vivo.com>
X-Mailer: git-send-email 2.39.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR01CA0181.apcprd01.prod.exchangelabs.com
 (2603:1096:4:189::13) To TYZPR06MB6697.apcprd06.prod.outlook.com
 (2603:1096:400:451::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TYZPR06MB6697:EE_|KL1PR06MB6520:EE_
X-MS-Office365-Filtering-Correlation-Id: 6ef001be-c9ed-4e2e-d85f-08db60e3720a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: nwTudou47d+dHOv5LLxhJomwy3wMfNiTR35LlrqeFQ7jAKbEzM97bIKDt8Wsu2JIDGIJAv5m/P3mcI2YTNHMtbo6SRXzMhhVt2XrXLZqfuS9vzIVmPmNZqNu4SajQ3tuE68/+k3aHpATS97R/DBG+fCK1DeaPP30qRkqTdHO8w8qvEvkSrKSAiQ34F1NoIvyyWrluPXMvR+sZarEvaihJ8r1KCue/cpAJAKQwE6uFsVUzJQT2a+0eJbMaEGlRq0Z3wEJM0/Qv8ZMZBAWaEtJFVJWKrZE9ZbLeuZ2jf9z6HYfID+HC4QbciJb7bBhbGD0toFkIzzljj9loXZImvwaQ3EVF8cfedPZtF3cOla149x7tZyp+G3suGjY3FqOowBTjEwEjgcEpD0lhF1JvCioUFX+sbbnrdyXGhVF5/BcnGSTc+RhILAyhtu81AHIy8o2FqcV4KSbhoQSYYjMk2BCzfkJQxG36krwZW5h7wIGpu9Pkhp11q18krUg09vhctNbYlljJdUYMuCncdTJq2r27ExlrIqHi8/K5yHsjewf5DaegY/wjvTy0ZlC/ei0rHkOcbIrGMhIrbdploHi+BqJdq0sDY/bsNQsCVmY1WD8SlJQcSg9B37RUMou+/9zbS3L
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYZPR06MB6697.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(39860400002)(136003)(376002)(396003)(366004)(346002)(451199021)(38100700002)(38350700002)(110136005)(478600001)(66946007)(66556008)(66476007)(6486002)(41300700001)(52116002)(5660300002)(8676002)(86362001)(8936002)(107886003)(26005)(2906002)(1076003)(6506007)(186003)(6512007)(83380400001)(6666004)(4326008)(316002)(2616005)(36756003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?bC199B2yMmzchAXoCwrnmoV1v5v80VDbSYCypFjWWAaPTE8G6eOXSrCHzl3M?=
 =?us-ascii?Q?HrtYR+sTyn3J3kDVyt69O8Nx97vSzp1mbiIXgVB6vXbTHp/8zZZICHhHthAe?=
 =?us-ascii?Q?p0su2dS5hMKwHPtfa2Bk/d9SVYX17wzrKOkxSPzTVKC5C32ATxOFxf23jHnW?=
 =?us-ascii?Q?waG+RlATFSvJyt/fBKTZRvFX3SXFeijSVMcQ8atQcT8nZ4D5f0bYE+ppCcqI?=
 =?us-ascii?Q?BMjiiyAlP0TFW7u2YxjqZC0H/siMOtaKhP4Md+T1RiXDn1PrTI1Zw02lgxrU?=
 =?us-ascii?Q?XlT/MilIGkdlwCl1moOrFRR1ltbRdn586GYNHtJYa3XQJlNTBc9tiGM1zs4t?=
 =?us-ascii?Q?e1Qm8+PJZGwlm7T7JPFiZua0ze+aD8cdZuoowzn5NtDEQeQdFwMM59nxxWPC?=
 =?us-ascii?Q?9rQEY0NuQA/ticMZBUOkz9P3JcWClPp7Sr5Bb1UdguFZtwUBXzZ5Y/qqA/qG?=
 =?us-ascii?Q?fSiELkCtk7vikZo1QDQ4ws6FALl6PeNh2gh7AqCMTTaEyk2MQXD406RSudMO?=
 =?us-ascii?Q?K7Cj7s23OG6ezMIEihfoM+qpsHSGNC5YWj9CKoj9P1zJSMZA0qxPcT4DAVZD?=
 =?us-ascii?Q?+Z2eKS/FXMB8aNalWr31xHzugrg8CD8nnfEYns6l6++GGe0mEv/cD9TwXUBp?=
 =?us-ascii?Q?L4j48alL1VY28NaF0/8ZOE2VtXN6i2B+PSu3L74CdyMIYxDhjt8AodhWg4od?=
 =?us-ascii?Q?iCpA0bfZt+z/B02cdrOk/ouECfn/idyMaOC6EZEEVQx87NS3giITxY1B585m?=
 =?us-ascii?Q?82Y3L4FyUH7Nmo+WweZYOwW3TsNAsesrec7KHZh7PMfwbCaha7CowIAuTO6o?=
 =?us-ascii?Q?JQRgNyufMoz5v+oVtyO3a0lpfwiZgZhZHVlWP0wQm11kFgyvY0WjgLMyA0gt?=
 =?us-ascii?Q?ygLZyvDs9lojNwPHXnp2zNd8ArIlZln/1UsrwNPBEWxdOIUOEG2YN7Rl+QZq?=
 =?us-ascii?Q?hzAKRJHIYm7syE+B+jRJdl8tEatLhObojVcgI4kss2PasdgqTJpGoflT5/o4?=
 =?us-ascii?Q?7GWeAJJJO41d630Zh/oXzclPH9HT3fNas/zwQJIXs0EX1tkh/2C8eWAiiVB0?=
 =?us-ascii?Q?0zOLr7a6ShwEmL8VBSiuLNUtTg9nj1a+ckZYK+NLL30YBg9EDmqO+Z5wOVMt?=
 =?us-ascii?Q?XZkjmwoQ1SkQ/eL4kHIYZ3ncGipk61fUobIls5yirs3UkvR9mE6AP5G75V9C?=
 =?us-ascii?Q?LMIX5PVC8AwLkZ033HmBHOjVesrRBoVjlNrDkLbCaIJ6jh02CTYGX4M5yzlb?=
 =?us-ascii?Q?OXQARAf8zVTEYbsUrAPNA2GbosT2rnoKmFDXJoFVVzVJ7vgeK3toN0Qdubp/?=
 =?us-ascii?Q?xdq30JAmr23NM3NFhrgAH5LlYGu71hItsiaJZy6RoeQcHqhl9Wby38Opo/pT?=
 =?us-ascii?Q?RM7aIHuXFuJ2i+EBzU8h6YvSnNBPdip2qg4JaS+P4fAAhtmTGHBYIu2W8VH1?=
 =?us-ascii?Q?LalPxGH+2fryi2H00y9av3dDUBQjtItGPK0t95lOBJfDuC9tgI7x9lbmKAQe?=
 =?us-ascii?Q?w4HaOqULtm8TrAcSf11lQIpOhfRmp45OyLwyrrpTG6W0AUTSQhgyDuABPnVn?=
 =?us-ascii?Q?tP7BKyErZAJPPiO/Wf1gRK61W32xtxdXeWi9N6jM?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6ef001be-c9ed-4e2e-d85f-08db60e3720a
X-MS-Exchange-CrossTenant-AuthSource: TYZPR06MB6697.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 May 2023 07:56:59.2446
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6jmU53xiXSGutQoi0YZp72XX9Tr2/7kNKm6ntOMP6I/h48d1ilUachavlyKREDAyMrAxvF0mjUPTrGpNhhjzag==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KL1PR06MB6520
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There are several places where warnings variables are not needed,
remove them and directly return 0.

Signed-off-by: Lu Hongfei <luhongfei@vivo.com>
---
 tools/objtool/check.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)
 mode change 100644 => 100755 tools/objtool/check.c

diff --git a/tools/objtool/check.c b/tools/objtool/check.c
index 0fcf99c91400..b60af6965c1d
--- a/tools/objtool/check.c
+++ b/tools/objtool/check.c
@@ -3841,7 +3841,7 @@ static int validate_unwind_hints(struct objtool_file *file, struct section *sec)
 static int validate_unret(struct objtool_file *file, struct instruction *insn)
 {
 	struct instruction *next, *dest;
-	int ret, warnings = 0;
+	int ret;
 
 	for (;;) {
 		next = next_insn_to_validate(file, insn);
@@ -3943,7 +3943,7 @@ static int validate_unret(struct objtool_file *file, struct instruction *insn)
 		insn = next;
 	}
 
-	return warnings;
+	return 0;
 }
 
 /*
@@ -4178,7 +4178,6 @@ static int add_prefix_symbols(struct objtool_file *file)
 {
 	struct section *sec;
 	struct symbol *func;
-	int warnings = 0;
 
 	for_each_sec(file, sec) {
 		if (!(sec->sh.sh_flags & SHF_EXECINSTR))
@@ -4192,7 +4191,7 @@ static int add_prefix_symbols(struct objtool_file *file)
 		}
 	}
 
-	return warnings;
+	return 0;
 }
 
 static int validate_symbol(struct objtool_file *file, struct section *sec,
-- 
2.39.0

