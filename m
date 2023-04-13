Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 55A0E6E104F
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Apr 2023 16:47:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230369AbjDMOrB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Apr 2023 10:47:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42112 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230271AbjDMOqt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Apr 2023 10:46:49 -0400
Received: from APC01-TYZ-obe.outbound.protection.outlook.com (mail-tyzapc01on2136.outbound.protection.outlook.com [40.107.117.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 59BC5B47C
        for <linux-kernel@vger.kernel.org>; Thu, 13 Apr 2023 07:46:27 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aMlxuw9gJlk1m7uCzSdAKy7nIxatprI1RRUKSqApwaehT3Cp4sIKPgYlQ3pPCdUyWqRUrf3rKwysFQB7yI7lFPdVUpWX0k3c/zVhiZ+BIg11JlLCOc/1XyG5ck+GiW/Dt2LVrOw7BAbjPPrTxI/c8RaVVAfruWnqnkZBtIW3sSOwyPRg0/Twp8f+YqUxp8FaEt24R7UtxTaWr5Eh12HiuNUHnypLgpK0uoiwUWNBuIAb68PLtKuSUaiPLNUj8LlgMcNLUjyQ4BKH/ARKAmQJs/I09emPYcaAXnXHqmVdT3D0s7Run87QtpDXmOdr3AthWs7Dy5b8Z65tCHM8l+6mFw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=k0bIwNHFqHscET6v4z8CkEnz4mga98wkRk8u5Vg9I8U=;
 b=BvYOa+CfzJX8+50K0LVYMYtg3xQE7kHIeQWEqUfDS0FcqYsYBYbO6TKzJsWuZ0mtPmM5VidOlgJq7rXFfP7oAh7TDtHFaAJFXFw7qcX3roEhQtONogU+JG5KclEpBPEktkes23IctUCUU5JyiYSdeq5aIt4PZALnPYMXL5fBPseCRP1KMxkpRgUSQhKHI2dL8ik9WYrGX2aMqCQiUZ8OWL15guSoDc1A/uWW5MwavexH1ttGMKJzDQxBn/+YdU9uP0sTmmaxmMKOCXupaq6Z1PjwvE1zkCi5cTourjqWlY+lDiu5TGHLHV+chEuEvwBkJ3RPhFbLwv0hpG3jQS5MgA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=k0bIwNHFqHscET6v4z8CkEnz4mga98wkRk8u5Vg9I8U=;
 b=Njv2ccRZYhZfdkTjViLOKbnal80OTnFuo5JyolyxVATPPV1O8JvVn6siLfAaIfVduux0njWjoo4LjxyRbH7NbmMyj5M3YDtaLhsJzlp+3ZIFIrMSxqNKcu+EE4dig+KhFElL0zNTU4XlZwgDCs4FJAFF+Y1qWQoCrZJNWpTAIIeuCp5hh5J3RXYxHLChkg/outgea2y4+V/vEDzlKibSoY89k15KB/3Rd1RJSenRjSbx9pxWLF0LEdqiDLcefbMN3CWjKWzOKQB3At1dzQJpCXPf5Ha63MLHYzV+jK3Ho0r1Mcczp/SH/G0gx4TV1+LCNSoBYtd8IZiQ2AR1okTckw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com (2603:1096:101:78::6)
 by PUZPR06MB6067.apcprd06.prod.outlook.com (2603:1096:301:115::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6277.38; Thu, 13 Apr
 2023 14:46:08 +0000
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::a3a1:af8e:be1e:437c]) by SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::a3a1:af8e:be1e:437c%6]) with mapi id 15.20.6277.038; Thu, 13 Apr 2023
 14:46:08 +0000
From:   Yangtao Li <frank.li@vivo.com>
To:     Jan Kara <jack@suse.com>
Cc:     Yangtao Li <frank.li@vivo.com>, linux-kernel@vger.kernel.org
Subject: [PATCH] quota: remove PRINT_QUOTA_WARNING support
Date:   Thu, 13 Apr 2023 22:45:57 +0800
Message-Id: <20230413144557.20700-1-frank.li@vivo.com>
X-Mailer: git-send-email 2.35.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR04CA0190.apcprd04.prod.outlook.com
 (2603:1096:4:14::28) To SEZPR06MB5269.apcprd06.prod.outlook.com
 (2603:1096:101:78::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SEZPR06MB5269:EE_|PUZPR06MB6067:EE_
X-MS-Office365-Filtering-Correlation-Id: fa75566b-f17a-433f-78c3-08db3c2dd128
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: XX+89oImxuIWK5GLHoJwsD3H+U88DnOQJdVoGDuQgFut5rdAJnsxFNdVeApfv8KTrnJCvrHfxz94fVq7gx7OZPEyouJePivmPDYY9yQeLjYiKzQ1yM8Ij9S5LuJapc/0fCn9buM3E3rnHw5zSqiSG7R7RtMzF90YflR9M+I+WSsKQbrVvci27Jp25pOB1HdEO0EF0zIairjkNPlpPMPLkDJUTTceSxUW1wAOupUiJtOkMY4ndpdqf62QPox7r/ykZTyxlgzxdi3pGZnZtlqzRyJQx57B/37b4xczjN0dj6GuwQ+8D+s6YgxnNX4nYeqtHqTutJrE10RXeeGzHKQVs0p1RL9VMeqoWOIHFrtlP21QKMhS0Ld/SCVNQw/HfYRXg8bwq2qZbtzv2/g52F9YjSsi3/iUwsGFIzuo5MuX0yljZ/xZq/xKEMS+b2ePm1V1YzXgI1ze966HrpuSculHPvZwnvBWJsCoTEBgOZyzy7kj2Rj/mIDJFbUNKAvo2uA6u0qh7yGgKiRSplTSaDyntVQCe4qOVv3YLSQq13cSdD5qap+Rmec6rVmUweKPnY11zJm9F+Rt43JMWbPWLm4yQOAzXy2PcDgYwkoO2k6PRwgoh58SvpMbgakjMo6PaSLE
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEZPR06MB5269.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(376002)(346002)(136003)(366004)(396003)(39860400002)(451199021)(86362001)(8676002)(15650500001)(8936002)(41300700001)(66946007)(2906002)(66476007)(66556008)(4326008)(38350700002)(38100700002)(6916009)(5660300002)(6486002)(478600001)(316002)(83380400001)(52116002)(2616005)(6666004)(36756003)(6512007)(1076003)(186003)(6506007)(26005);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?AMGwoyW7rYH9kibcaxCnb4/XzcqKx7gXEHOBzMYadMnHtJi9uRhkBVytl9KG?=
 =?us-ascii?Q?K/+hdNBprRwgsdfLefd390Fu11JyVU79VbPRrq/WaqJd/xTEk303au35PD9M?=
 =?us-ascii?Q?GzcxfdGGLgLk4choKQerGh1sDSSIQcZxA/qQ2PXIRrTasn8aRBOFO6VSdmiA?=
 =?us-ascii?Q?TiFoH9bVP3t5j30kKubzNwGTCtxp4D3bu4YSgWIoC5J/Gx/s64LslQTBe+mX?=
 =?us-ascii?Q?3xfs3YHad5Pd4EDKdkOVyZ8NtaDvtl1ovN42TVEIWe+rLv5gn2dgPkJ6VauE?=
 =?us-ascii?Q?0ALWEJLlRC9nshAmBrjMnilYvSpaKa3//R5evsXOlHOqP7FV1YkjZzBrYDe/?=
 =?us-ascii?Q?yrIXZciYgfVVE0J3Vhz+spHIJjF5ghJoYqBtknQQxUSIYnoIHn95fJXobSn5?=
 =?us-ascii?Q?wxBtnjQn9OHoD35GaMZoZoN/iZcoMcl3Plz/IKbSrnkTbXyaDRwt9fLSaT4E?=
 =?us-ascii?Q?yNDiDEHA19fNZM2nLj4xBWccMr8rUyCQhlgB5kmfRMo8qricY+ygY1Ho30Fm?=
 =?us-ascii?Q?XbXn8rxBTR3eeyiX2usZR91LKCP9tI9XJfFxhNaUGXBcg49MUVQIaBCYkw/Y?=
 =?us-ascii?Q?1AqzHtuuV85gjFYwiqwv4jjiHQTRy7nTST3i9s0hEQ67xvC8CHlkzydLeawj?=
 =?us-ascii?Q?/k4c67oRqtIFE+Qwa5XA5/AG6PWxk2Xked8ym1vB4WItHSxK/rjhbinjN0J4?=
 =?us-ascii?Q?9Z/WHiNcfIfW446RIqTHCTbz/PYHVEKn9ZIKrbwFr3qO8gmpmC5Aor40m2b5?=
 =?us-ascii?Q?7GWC5n3K9JDGmHUySNCcubZXM5iQ6bAj6TyPjNYyggVrR+oIE4HHbUf8jg4V?=
 =?us-ascii?Q?YJFrAx7zeslv0rD/sYrZWefojtFVw48F1yb8Ek9P3iimi8DCZFt0t3kbuJOh?=
 =?us-ascii?Q?7Mbtd8+jsN7L3nS1g+8iGnU7DezvbI43qxxo0JySLdKaMZnvl/cI8cUIEwYZ?=
 =?us-ascii?Q?h1alekTTSedGHc8tzq58ejmeUf18O35x6GsD5PhbYviCy6HOW4WmVJYJLWVH?=
 =?us-ascii?Q?7XJ8bynlkSVAu0Pw36wKYLyGgKsWhP5ycGZLyedO2kPYsc9MqB3t8FZehSpi?=
 =?us-ascii?Q?CAx3sem/n7dH3LF46sfhClGf9jzq2dKm9XWenrH9fKNdvyAWaTB8veneB1eX?=
 =?us-ascii?Q?m07jAdOq5rdSIJxUvnjGG3+RTMfdWyiIen5ufTG0hwXwhuGH++x6Fuisavp+?=
 =?us-ascii?Q?zuyaa3+pCvJsgmLlp6j9GayRkgkbLpiu0nBW2UhINVMW8cjbNOAjMKH8VIFP?=
 =?us-ascii?Q?2R4tzmjjGjVeDNgQRYL2CKIpR+zHi/pCSRK2OXDozrJtHUqhVBCVUQ21fSqe?=
 =?us-ascii?Q?85HmOJ91SZVCjyIfwtroZZQ5PBLgjaRr3rdUh5dIs8Nx/UMczmyxp3jLLOSa?=
 =?us-ascii?Q?Q7qM1NB0CezZWE4tGxi+QgxX7frC7Niv4cZoL1k5UJag9iIrg32NIxha/9p8?=
 =?us-ascii?Q?GA2p17shABLyTESPPry1hNRD7aRhfEO82Nm+LOHYQerHBc2tyAf/gpCZ0QqP?=
 =?us-ascii?Q?fVwb6ze84uJr08HZwcBY7aCQ+8fvkxqZiG00qpZ00uMhpZkB9REzjMBUye7W?=
 =?us-ascii?Q?rHd9HkwZSHjkBcFTAcs209ZSHVliZh6Sn1s0IIVE?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fa75566b-f17a-433f-78c3-08db3c2dd128
X-MS-Exchange-CrossTenant-AuthSource: SEZPR06MB5269.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Apr 2023 14:46:08.4750
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6OKRGooNYca2cGmSvxCsKSVPdchlgq3MiBo58HNBH1GBZEAfN18aDV7/bGmJtDeDG/NULG30vaMgA3BIq8FDHw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PUZPR06MB6067
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

It's deprecated since commit 8e8934695dfd ("quota: send messages
via netlink"), so let's remove it. User should use notification via
netlink socket instead.

Signed-off-by: Yangtao Li <frank.li@vivo.com>
---
 fs/quota/Kconfig | 10 ------
 fs/quota/dquot.c | 80 +-----------------------------------------------
 2 files changed, 1 insertion(+), 89 deletions(-)

diff --git a/fs/quota/Kconfig b/fs/quota/Kconfig
index d5a85a8062d0..1b3bc0a99515 100644
--- a/fs/quota/Kconfig
+++ b/fs/quota/Kconfig
@@ -26,16 +26,6 @@ config QUOTA_NETLINK_INTERFACE
 	  hardlimit, etc.) will be reported through netlink interface. If unsure,
 	  say Y.
 
-config PRINT_QUOTA_WARNING
-	bool "Print quota warnings to console (OBSOLETE)"
-	depends on QUOTA
-	default y
-	help
-	  If you say Y here, quota warnings (about exceeding softlimit, reaching
-	  hardlimit, etc.) will be printed to the process' controlling terminal.
-	  Note that this behavior is currently deprecated and may go away in
-	  future. Please use notification via netlink socket instead.
-
 config QUOTA_DEBUG
 	bool "Additional quota sanity checks"
 	depends on QUOTA
diff --git a/fs/quota/dquot.c b/fs/quota/dquot.c
index a6357f728034..10b46c403bdb 100644
--- a/fs/quota/dquot.c
+++ b/fs/quota/dquot.c
@@ -154,7 +154,7 @@ void __quota_error(struct super_block *sb, const char *func,
 }
 EXPORT_SYMBOL(__quota_error);
 
-#if defined(CONFIG_QUOTA_DEBUG) || defined(CONFIG_PRINT_QUOTA_WARNING)
+#if defined(CONFIG_QUOTA_DEBUG)
 static char *quotatypes[] = INITQFNAMES;
 #endif
 static struct quota_format_type *quota_formats;	/* List of registered formats */
@@ -1171,72 +1171,6 @@ static int warning_issued(struct dquot *dquot, const int warntype)
 	return test_and_set_bit(flag, &dquot->dq_flags);
 }
 
-#ifdef CONFIG_PRINT_QUOTA_WARNING
-static int flag_print_warnings = 1;
-
-static int need_print_warning(struct dquot_warn *warn)
-{
-	if (!flag_print_warnings)
-		return 0;
-
-	switch (warn->w_dq_id.type) {
-		case USRQUOTA:
-			return uid_eq(current_fsuid(), warn->w_dq_id.uid);
-		case GRPQUOTA:
-			return in_group_p(warn->w_dq_id.gid);
-		case PRJQUOTA:
-			return 1;
-	}
-	return 0;
-}
-
-/* Print warning to user which exceeded quota */
-static void print_warning(struct dquot_warn *warn)
-{
-	char *msg = NULL;
-	struct tty_struct *tty;
-	int warntype = warn->w_type;
-
-	if (warntype == QUOTA_NL_IHARDBELOW ||
-	    warntype == QUOTA_NL_ISOFTBELOW ||
-	    warntype == QUOTA_NL_BHARDBELOW ||
-	    warntype == QUOTA_NL_BSOFTBELOW || !need_print_warning(warn))
-		return;
-
-	tty = get_current_tty();
-	if (!tty)
-		return;
-	tty_write_message(tty, warn->w_sb->s_id);
-	if (warntype == QUOTA_NL_ISOFTWARN || warntype == QUOTA_NL_BSOFTWARN)
-		tty_write_message(tty, ": warning, ");
-	else
-		tty_write_message(tty, ": write failed, ");
-	tty_write_message(tty, quotatypes[warn->w_dq_id.type]);
-	switch (warntype) {
-		case QUOTA_NL_IHARDWARN:
-			msg = " file limit reached.\r\n";
-			break;
-		case QUOTA_NL_ISOFTLONGWARN:
-			msg = " file quota exceeded too long.\r\n";
-			break;
-		case QUOTA_NL_ISOFTWARN:
-			msg = " file quota exceeded.\r\n";
-			break;
-		case QUOTA_NL_BHARDWARN:
-			msg = " block limit reached.\r\n";
-			break;
-		case QUOTA_NL_BSOFTLONGWARN:
-			msg = " block quota exceeded too long.\r\n";
-			break;
-		case QUOTA_NL_BSOFTWARN:
-			msg = " block quota exceeded.\r\n";
-			break;
-	}
-	tty_write_message(tty, msg);
-	tty_kref_put(tty);
-}
-#endif
-
 static void prepare_warning(struct dquot_warn *warn, struct dquot *dquot,
 			    int warntype)
 {
@@ -1259,9 +1193,6 @@ static void flush_warnings(struct dquot_warn *warn)
 	for (i = 0; i < MAXQUOTAS; i++) {
 		if (warn[i].w_type == QUOTA_NL_NOWARN)
 			continue;
-#ifdef CONFIG_PRINT_QUOTA_WARNING
-		print_warning(&warn[i]);
-#endif
 		quota_send_warning(warn[i].w_dq_id,
 				   warn[i].w_sb->s_dev, warn[i].w_type);
 	}
@@ -2936,15 +2867,6 @@ static struct ctl_table fs_dqstats_table[] = {
 		.mode		= 0444,
 		.proc_handler	= do_proc_dqstats,
 	},
-#ifdef CONFIG_PRINT_QUOTA_WARNING
-	{
-		.procname	= "warnings",
-		.data		= &flag_print_warnings,
-		.maxlen		= sizeof(int),
-		.mode		= 0644,
-		.proc_handler	= proc_dointvec,
-	},
-#endif
 	{ },
 };
 
-- 
2.35.1

