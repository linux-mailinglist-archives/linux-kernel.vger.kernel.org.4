Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A0C9863709F
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Nov 2022 03:49:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229820AbiKXCtC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Nov 2022 21:49:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41948 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229499AbiKXCs7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Nov 2022 21:48:59 -0500
Received: from APC01-SG2-obe.outbound.protection.outlook.com (mail-sgaapc01on2137.outbound.protection.outlook.com [40.107.215.137])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 86AAFB480C
        for <linux-kernel@vger.kernel.org>; Wed, 23 Nov 2022 18:48:55 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mcSTiih3mf5wjEU2HSLNtKfur3jKUn7qw1oONEEtwSp23LLud/tqsO/hGXd7wY/le4TXWLFbUdSrx2awvc2yuQ2MgYVSqX9mWldgB+NxBxB3msCYhws3qT/W5jl/SSdWFMoXlVxux7jtMhlQwmACUylU5Rz5afSoLMkFVK+80H925DjGfhO+6VW302AUiUPM/aHkcskrVjmjkb4K77Nqnb2ki448mfXqoOknItOWO5XgxKHqRmu7vzn2uzP3V0ljs7riOZjvHvEsy8koO7qKs6eFujl8fRrTOwO9Xx+NL1NJeyvypls4+QOo231GZMbGQU+YpfiTd3vycJWHIIA58w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CaRiiTNhizZcEMOxj0LZrOudMI9ZawVJ7KPxqIUpqg4=;
 b=jmzYeOIEuvGZbcRUJ4Q08FbNK2Jd+hxAaaOOAgb6n0vjBd9/wm59niK3bE6XrbQA1ozqEQRUZcddsO7N8rlGZBomje8G2ZHA+f2M1oI0K4YAwgR2xbahZmcKC6DVcK0y1wgK1T5wSYyuYCa8WYliRIS72qdrJWXmtlAIgg/p8cF9Flpa7DsVTWGCk+it69MSsP/5i3cHyBBKepTDkyVVfP8yVZzh4Vtlw7mGtZ2hdPTwY4n/PBN+vHao0a5Gc5oP997NcOowhwSpdDsCAXf/JuQWoO6Q6T7bDzE5x2ny+D+j2jEXGrbbER/TzHshr3byA81nlz+e7/aFp52iCeZMTg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CaRiiTNhizZcEMOxj0LZrOudMI9ZawVJ7KPxqIUpqg4=;
 b=QF1vXGWpIXyXoUHGO+btNIrYUDTAxkaEbIhQOTwILFaBl5lPQ805EPg0dwh6UEhBiFzGE8Nbxv1df1VIoQsMwheuTNu/CQrDHaeFVzvE0t4ls6pCp+T+O05DdhXvHh/vDP9Ieq+8BZgv7FPGCqJQdKT6H/LBwqG80q9H28ofVIdVKW9olWpLogoRWj/l6Z5miOy+CbLVoUoTEFMGR6SZeNTQhcCRxauUAk7EAVb4CzmN6HFdrufq9lOK5jjA+E4EOy8mIx5nI1el+FiOwzTa97isY1C2PAOuRSA1cuB2JsWuSsfo49+jPy6JI1Do9NYRqTEa6xh+f3qtzKmit+0CBw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com (2603:1096:101:78::6)
 by SEZPR06MB5504.apcprd06.prod.outlook.com (2603:1096:101:a4::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5834.15; Thu, 24 Nov
 2022 02:48:52 +0000
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::1230:5f04:fe98:d139]) by SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::1230:5f04:fe98:d139%7]) with mapi id 15.20.5834.015; Thu, 24 Nov 2022
 02:48:52 +0000
From:   Yangtao Li <frank.li@vivo.com>
To:     jaegeuk@kernel.org, chao@kernel.org
Cc:     linux-f2fs-devel@lists.sourceforge.net,
        linux-kernel@vger.kernel.org, Yangtao Li <frank.li@vivo.com>
Subject: [PATCH v2] f2fs: introduce f2fs_is_readonly() for readability
Date:   Thu, 24 Nov 2022 10:48:42 +0800
Message-Id: <20221124024842.4809-1-frank.li@vivo.com>
X-Mailer: git-send-email 2.35.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR02CA0077.apcprd02.prod.outlook.com
 (2603:1096:4:90::17) To SEZPR06MB5269.apcprd06.prod.outlook.com
 (2603:1096:101:78::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SEZPR06MB5269:EE_|SEZPR06MB5504:EE_
X-MS-Office365-Filtering-Correlation-Id: 53847685-3d95-42fe-1b8d-08dacdc66bdc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: X36UBTqGAs2o7RsMfUE6pDg4CoekUHEjCbmoDKz9TC28kcYxs8RCHqrA/HTmo768skNZC6Wn5c50biMAWM0SPfZo7DJ42yykjOH2IejpghCop0tFO1oLrDCwM7Rw+ojnJGrG5M43o0N3NhnJUQc4x92rKOHFdDefx8gmvhD0QTbTvMnW6W363y2u7gPwuIGEj/Ev8QYzib0t/n3qqwv9uLbnbXLbxqIyoapQ8i2rt3PaR/gy/0EPu04bMquNIYRWXvJNGKfyazSKqnng1M7Kr/z3tu0CKeo1EjjfExjwBFotQBlMe1f36AvOguGzO8Qcgc6t9cVJj9BtPaI5Gh+6DaI2fdvJq4Jo8eSFNAuCSvfU/4nU70E2WxJAAvxMMb+AUjG6OdWzqjBXx22Ju4Zo6d655kR0FMBH9VN8+A9mmPtguiqiNGL9JAa/8XiMyy7JF3Rwr6NLEq756cDUwcyXNkfVapG7lLNnKAElUrNJJJSVFd1R09phUpGLr33nLnf2p5khx19LUPXkFgllQforXupndKE9V4qrHoE6AAoehrCGOK4kFdTafK88mWhM8lvAXhR1Kp5sPU8URBL8DYxlWfOcBSp8vp1IrrBxCVCCPYIfi+pjwUku7CQJuY3mj9oQ8jYMdNaLB3wu0r5uU9eQnuBqKBOw1M+UHS3z5pT874rDFJ5wa1JkMIqMlbvmgTfv
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEZPR06MB5269.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(346002)(136003)(376002)(366004)(39860400002)(396003)(451199015)(66946007)(1076003)(83380400001)(38350700002)(186003)(38100700002)(41300700001)(2906002)(8936002)(66476007)(6666004)(52116002)(107886003)(6506007)(478600001)(2616005)(8676002)(6486002)(66556008)(4326008)(26005)(316002)(6512007)(5660300002)(86362001)(36756003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Wi2gUIngN4PCjpnQCQO3o+4aeZiEEAxcdJUZJFk4iPCWZLlUavSsXgp09eMG?=
 =?us-ascii?Q?kQswRwOIqHTFw1u4RkGVECHlvhS7/mulbNc/40H5wXp8Ny6NNri0fsYiwXos?=
 =?us-ascii?Q?3D2NX0T+uajwLvPkbtlX7QKiMC5jizRFyk3/6ZYlUb8KqBYeE/0cIt9byR7T?=
 =?us-ascii?Q?nrr+3r6qssY8+deH1oeIUTKTEsEmYitSJvaBEyAD0jhbcR1h+tYPJudoUmQM?=
 =?us-ascii?Q?NJY1zJMb9t/xXbEl0pfEt1pgD59lSKNe8rIYqQUX3+ndRX7q0YJAwqaveBaA?=
 =?us-ascii?Q?tcBNXl3NdM6hQdJkVgPhHIeFpkt4FyCIiaYyIzm6NDVEgsOVsZK/WP0+NMs0?=
 =?us-ascii?Q?52GhKcc7fKCTmlop5OykoiiDxiecjguMutNs9TiMdI6sRIOwf7+42REf28v0?=
 =?us-ascii?Q?aizE0jcxkl1ty1+aVBCBcYr/enHa+r2XljF9hxGDxi9SBxCChDXA8PIHPbTD?=
 =?us-ascii?Q?fxMxydvNlvJSruPMM0OHLroIP2bQ3FTAegOrLC4o+a9yi4U6C0BXJWB9ykr8?=
 =?us-ascii?Q?hZPOKKIQJdS8XvhjPmDBUK9hBJcafhJc6X61olhpoWoxVn/OH6OsCd5SMehy?=
 =?us-ascii?Q?TuKzTIfJ5OH7TG99QPm8w9RsLtzmqaniTjGt3x9BvfhJb8D3Oszam0D2A8aN?=
 =?us-ascii?Q?WA/TKj1Hejs7Q2izzT6Uh008IE6zoA38QHlMxxVUIk6o5vS8av335C9mC148?=
 =?us-ascii?Q?2uGbBtvT+O/FEVsGLkQ0I6ucAkcdZjnuQKikiin/p4bayikcEH0sxNJ7P4Ee?=
 =?us-ascii?Q?ilcseNxnEdkYNXbapXuKh5LPSEjZ9eBPL0lzj3ijuVw4J9Vx0Fb2HGNUNbfN?=
 =?us-ascii?Q?9JByStzAy3jVJAnO46Ae63cK3E0OCGzsD0B1IewndgqwC5r3zqi67HOlsah2?=
 =?us-ascii?Q?dP/MNNDNi6Cv/4JFvNJiH5uRvbRAGK0+8+VTteafhKIMGpPbxNxD6J3UymWR?=
 =?us-ascii?Q?XGC1wPMRStL43j+Uhqr8wvsbjc553VpE918DRLVJ9rh9kqaIkufPFxuBguxQ?=
 =?us-ascii?Q?8B7bP2WeT5o1XQAG9JPgvld5FA5J6BBmhBOKLYyIJEK6w5QX2criZYWHvW5J?=
 =?us-ascii?Q?k45GerOLasbIpZTYD9PFSXixw3J8kqNaCYmJ4iCuf+tdYuuG2gJ6xWDIekAa?=
 =?us-ascii?Q?c6CDFqPHnQpd2a6gNbDbJYJ1H250WVzXyceYQfG1PjsvKvgWJ3bIFKMNXK0R?=
 =?us-ascii?Q?83OXAmhednQMdp3v5wzFBj0oJPWeO5GnoR4deG4bBfe4Fvd77vzpxcOo1InS?=
 =?us-ascii?Q?X7QJG/gN7j/6pNlpun0ukDJi5lF6hi+p3QoDLQhbNI1qSc/n28MM1DZ+NYB0?=
 =?us-ascii?Q?kZNcRV1pWeLSLsoARZ+3lWSnizurEVM0AeG3B+eeB6oDP7MWk7bhQCvMk/x7?=
 =?us-ascii?Q?OAaYiF40FvxKe4SmxhbKg71ocNTDovlUe6jYWzSusox2Eikmex5PmkEfFuuR?=
 =?us-ascii?Q?xaFoAlZAHecHLFQnDImvJcsOtfda95bUJfno/4KSVvad2eiUmu+P0s1Ztfc6?=
 =?us-ascii?Q?GjV8/r1S/6cmKTUu1yuZITlogHJ92UaC8CvtNCjUJOCXHC7FseG1bBvxeGaV?=
 =?us-ascii?Q?LvSjNSBdZOFAhm5qkxcDh1iOcExCPHxjwhNDlNlC?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 53847685-3d95-42fe-1b8d-08dacdc66bdc
X-MS-Exchange-CrossTenant-AuthSource: SEZPR06MB5269.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Nov 2022 02:48:52.4714
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8GhYTd8V2a7UQ3hZPxJFBRn59+B2UaahrzaVmRMue88gxfQ/nRu7m7NGePDm459NMsm+rLRpoGf2U5J5UgzC+A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEZPR06MB5504
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Introduce f2fs_is_readonly() and use it to simplify code.

Signed-off-by: Yangtao Li <frank.li@vivo.com>
---
 fs/f2fs/f2fs.h  | 5 +++++
 fs/f2fs/super.c | 5 ++---
 2 files changed, 7 insertions(+), 3 deletions(-)

diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
index f0833638f59e..eaef7ccee5ae 100644
--- a/fs/f2fs/f2fs.h
+++ b/fs/f2fs/f2fs.h
@@ -4576,6 +4576,11 @@ static inline void f2fs_handle_page_eio(struct f2fs_sb_info *sbi, pgoff_t ofs,
 	}
 }
 
+static inline bool f2fs_is_readonly(struct f2fs_sb_info *sbi)
+{
+	return f2fs_sb_has_readonly(sbi) || f2fs_readonly(sbi->sb);
+}
+
 #define EFSBADCRC	EBADMSG		/* Bad CRC detected */
 #define EFSCORRUPTED	EUCLEAN		/* Filesystem is corrupted */
 
diff --git a/fs/f2fs/super.c b/fs/f2fs/super.c
index 31435c8645c8..39c6be61450e 100644
--- a/fs/f2fs/super.c
+++ b/fs/f2fs/super.c
@@ -1353,8 +1353,7 @@ static int parse_options(struct super_block *sb, char *options, bool is_remount)
 		return -EINVAL;
 	}
 
-	if ((f2fs_sb_has_readonly(sbi) || f2fs_readonly(sbi->sb)) &&
-		test_opt(sbi, FLUSH_MERGE)) {
+	if (f2fs_is_readonly(sbi) && test_opt(sbi, FLUSH_MERGE)) {
 		f2fs_err(sbi, "FLUSH_MERGE not compatible with readonly mode");
 		return -EINVAL;
 	}
@@ -2085,7 +2084,7 @@ static void default_options(struct f2fs_sb_info *sbi)
 	set_opt(sbi, MERGE_CHECKPOINT);
 	F2FS_OPTION(sbi).unusable_cap = 0;
 	sbi->sb->s_flags |= SB_LAZYTIME;
-	if (!f2fs_sb_has_readonly(sbi) && !f2fs_readonly(sbi->sb))
+	if (!f2fs_is_readonly(sbi))
 		set_opt(sbi, FLUSH_MERGE);
 	if (f2fs_hw_support_discard(sbi) || f2fs_hw_should_discard(sbi))
 		set_opt(sbi, DISCARD);
-- 
2.25.1

