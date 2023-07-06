Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 71252749813
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jul 2023 11:16:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231772AbjGFJQ3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Jul 2023 05:16:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60984 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229556AbjGFJQ1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Jul 2023 05:16:27 -0400
Received: from APC01-PSA-obe.outbound.protection.outlook.com (mail-psaapc01on2100.outbound.protection.outlook.com [40.107.255.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF6FAAF;
        Thu,  6 Jul 2023 02:16:26 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KQg2l9U3FZwPKer7Tr+6BMCuTknxh2PaVDmRl8/b9Q+CsGtfwF77PvlNRXwEmxlcyjVeveog9TWikvpunioNL+zXR+/l3VCTRqDkyTu+vzpigX/K17SQ86vC/hPvoa8zgW1IXr5zMVJKl08hiA8NdsGAsyHKpgqu7Io+WcrGuGyzgtOOrgtTNpAwQV+Mujd/wJZanOZ1eK41+JSRGQEC2LdarR6egO7aZ9ki9cN79dgo+iuh769Kg5bHF5u5aCqLOnKeg+z8pARwSZWmwXki+7+HP57/cTviqNKC7Lp807Bv48V1aOsEyLEIeDVOu4dkJyM0c49UmXlF9I3rD84J7g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TC40/Mk4pipYtQMPyX5G7aM5k75xPSo9LeZORXXwFLM=;
 b=iVZwERdTueaVUWkcP/g3KSptDC8Nl76uoVohYGMYG4e3XZXekd3GKCyX9urPrW2NFQuhiKhOYOW2er+gV7aRY7Xhwrf8Q4xnk9vK9V4f8m2uR90sauZgqxZrx7K9GaitTSK1oVbQCyrkTbUB1gH6vJfXg4i09VyCBBEPgeTV/r7HP4P5XWd/Q9ZBeSbbhL6/o8JAMkN/btjPbWJFv8WPM+UASn3/tH7s4tN5kXcCmnCzy4OYop0QE+NySQR+gnhy+wELHh337llEHpTe5EayjGh24Bel1B6J3P6qhIAK90cIJVaya1asys9O/veIILJ963/tVl14ZV0yIO3RbaOLjg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TC40/Mk4pipYtQMPyX5G7aM5k75xPSo9LeZORXXwFLM=;
 b=YPpV2D6Kzr1+ckGZxDnqD1v8CRhzKqmxD5VhufI0tByx6qBGjR/bghcaCHdi/QAgsOOW0K0QIJ7i5q82ef2SwiKRYm9X8J61LGdHHDN1cJgJ4AUtGkiqcBh+sm2B175NribjWTzNlFwIxneNETyd+uw5+hjVr1INj/5Enb1+w8s35JAXyKFm7W2vZK1ENa/YajSb/JHqiFmOy85DDEVq9uvKDPg+nvz3kcUoHcNxQwHNhsV4rbc0OxKhaDly3JVVpRM9EfmAWeRFp1uzb1tEPnf95AmK/IJXURj9MO1Ia9PXcOY/Qd66XEjCHAITPunLsY91P5knapZEL3EC3ttsKA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from TY0PR06MB5706.apcprd06.prod.outlook.com (2603:1096:400:272::6)
 by SEZPR06MB6644.apcprd06.prod.outlook.com (2603:1096:101:181::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6565.17; Thu, 6 Jul
 2023 09:16:22 +0000
Received: from TY0PR06MB5706.apcprd06.prod.outlook.com
 ([fe80::d6ff:1295:38d7:a019]) by TY0PR06MB5706.apcprd06.prod.outlook.com
 ([fe80::d6ff:1295:38d7:a019%7]) with mapi id 15.20.6565.016; Thu, 6 Jul 2023
 09:16:22 +0000
From:   Zehao Zhang <zhangzehao@vivo.com>
To:     roger.pau@citrix.com, axboe@kernel.dk
Cc:     xen-devel@lists.xenproject.org, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, Zehao Zhang <zhangzehao@vivo.com>
Subject: [PATCH] xen/blkback: Convert to use time_after_eq macro
Date:   Thu,  6 Jul 2023 17:16:13 +0800
Message-Id: <20230706091613.40136-1-zhangzehao@vivo.com>
X-Mailer: git-send-email 2.35.3
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TYCP286CA0015.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:26c::19) To TY0PR06MB5706.apcprd06.prod.outlook.com
 (2603:1096:400:272::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TY0PR06MB5706:EE_|SEZPR06MB6644:EE_
X-MS-Office365-Filtering-Correlation-Id: 0cfb6c15-44c5-496d-0214-08db7e01aa79
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: qob8ffNRD+wzU20BEmolrHKDTaimOfoJRM/Ktyh8gfiiOjn545q71M632RsMINJIi1GRuRud+zbKeT21h2LyV8p21bVRVcy6u+0DYx8fT4DBW1U4XOPYmh+uUKnCvMlwiHCfn1kvP38obepKYq3Xvse/qIyhjl+ODFmd9QkcxMjPpzzXClcbdBNnxPbhCEGQe4SxeIa7r9LlqqGBc/JFi5WOYsAgVjKbQaTv2QDyt1XO3ovkRvpcB3hk1y2ZG4lF44FsUrLIZrDvu4AK7ldNq1nOotheToVwX/aGqZHGioOIvVUlJtyTRRSOUaKj8ezNkAG3p3MGvGlLxeoVf1mPoM1O8jb0gBN1HozmAtHYCGqKENs7UPc2SZz4TNHxESoAxZySwOY1K36hqup31gqt1VtCfxQrf2nFecpLMIHFH6b8kgIviBRj6McTDNMElqc0NXbtwd/1Z5gASkIGH0uLTxAuiX7mjN7j9hPZ/aQlTPEFVMGPNadBZjnSclPqluJrlXUW/AxkTc1T+l3opjNQ7+IsSD+Usorw8gK7zEIBT9isJK2eBI37CWv0nK+hax8aoU+wWzzq4mNsEQNPEBY8Np2NReCBEL3GjTb9hf1t3tcJrmAMmj3jpd83HYsrvt0g
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY0PR06MB5706.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(396003)(39860400002)(376002)(366004)(346002)(136003)(451199021)(2906002)(5660300002)(2616005)(86362001)(66556008)(66946007)(8676002)(8936002)(6506007)(6486002)(6666004)(26005)(1076003)(478600001)(52116002)(107886003)(186003)(6512007)(38100700002)(38350700002)(83380400001)(66476007)(4326008)(316002)(36756003)(41300700001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?cxLkbjFMD31cFBSS80uSjWUy1fz8HLX+CTquCDBX4zzdb9wHOwUInrMXAzBy?=
 =?us-ascii?Q?Vp0lRKEZE9MYYDLsjNPoQCQkBGI8jwx6G7ZojQeFMGjs5QN1AvIPEezZAPrn?=
 =?us-ascii?Q?GEr15q6r/zz8qGJleOBeABX9vfRWh0N7oTl+IKOvx40Ei2axN2qkQHzJ6vte?=
 =?us-ascii?Q?zEWzwcWkMMV6uiDFTm4IdwAsBbcSb06iToI53B9tF82wk56r0tD3GddFRcWV?=
 =?us-ascii?Q?oHhZzYhJeTZnj6wYC+4AS1VCdzTI9RgIz46BscmgIUNp/XqObVOw9BSQgc4A?=
 =?us-ascii?Q?TxnLmqO1T8HwuC5Z8yOo5EPTonI5Vws+A9ecrE/4gmw+rhqJIOWY+ns+IrY5?=
 =?us-ascii?Q?F65hRCD1e+oT3xflkX7m8ypvTzTIW+SzvbxGMmKx9OD3wPqWKQYMeZ925MZZ?=
 =?us-ascii?Q?aBYNkW0BDL7jjVsT8Fvsm+PWnuUadEfzCOGP1qzB4np/QmjQO+UVZ2comdXx?=
 =?us-ascii?Q?oJ3rblqGv9XvbHx9d+DM4TuIHrIh9HjcE/q60HYrPTEbwoLxJfhnXxs/kaCc?=
 =?us-ascii?Q?/IK56aeF61nccJ64AP8lJgdJe5Pc/rd9xqcwGMk7xQD0qxJ57anz8mw5HYFf?=
 =?us-ascii?Q?BsKdiHcBeeW0Uin7dSamQ3X5O6NmblvQT/Hdg0jJyj3nYC7HB6J7j1ARZMMh?=
 =?us-ascii?Q?bWu2p96KcY2H8BD/nAXZEFhkKMdlsv9w2pgAL40y3b4QkupFfM5KcVXP05/B?=
 =?us-ascii?Q?0qHYKv16kc43dHtWHMZF/F+Hjt70AonNyaUiRo9fgOUlbNgsq9Twx223D2jd?=
 =?us-ascii?Q?3/xeglGMB5z1fSk3gxTYl80Q01c0J/c8t75qibbCi9h9LSTcypUM3sq5n4/L?=
 =?us-ascii?Q?AVDHto04YT3FQPhxXCGWZ+Ul4BUEg3wSnKjcKNIqs2M3amBQHV92EQr6PCA1?=
 =?us-ascii?Q?X5iy6FiSTmi1Y0KE+RReHhQnyXSZw3RFLSWOcWJtjy2SuiESGPQDgP6PknXI?=
 =?us-ascii?Q?8u9JeoA+KbTy+NcT+hsrr+cCIVDl2G0QFABhVKXFvaoMuOw/y/6YuLoWzHKB?=
 =?us-ascii?Q?KYMg4ERUMgrEiQqx/+h6qTMmI80A+5+myXvfgPaSZJy5/X5nkpgPzUAqPVAr?=
 =?us-ascii?Q?U0yAQGdikZxzgwz+L3pIBlBrrzlKxB9FB8/gGm6iwBemVy/UYEySfpTvmArd?=
 =?us-ascii?Q?0n7u9B3nR9ZJTgzRDur3e7QkM78C5H2b6JV3C5oPeAdmpxgJpmyN5Ao8G8+g?=
 =?us-ascii?Q?2q1yposGeJcoOk8Av6KE5WDAVqi4EEH6GLlcY+dBZTwYv82mo4NANTOhzSFq?=
 =?us-ascii?Q?4sqLnTuLHNUQlgiHW+OyYhL4fbomXOEhHdAyFkkrnPsDgxQ1qJqSvDri8osq?=
 =?us-ascii?Q?u69QyKb/M4tKsJcvfmP/gFnbTWfFZNIHK2X93+hcyqz5pvuV/a6Rj+tg5AOH?=
 =?us-ascii?Q?LxkuiIYDEE7EwDGruhmKcvohpQRjM3kuxZVGtL5ekOMPU70hIabt8+Jn7bLZ?=
 =?us-ascii?Q?gJp2oWSk1hh0ltPpe5w3DYeqsWJ+ZhNsScbgx5rHhCrs8gCbq/92L/wnwvaQ?=
 =?us-ascii?Q?mdqi3R+0G3QgAuIs32ngLViv8abOjVhnJQuqIb9E4jJ7TcaOqZUfM3xWrTE0?=
 =?us-ascii?Q?Og9RO5567X8/Geif6jGSz95O/83EKkuERxFS4MYt?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0cfb6c15-44c5-496d-0214-08db7e01aa79
X-MS-Exchange-CrossTenant-AuthSource: TY0PR06MB5706.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jul 2023 09:16:22.7995
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8VOZVjM2kgNNbV09fogH6VvaM81sWFIbx7bxCXQT+r3yDYZMBdO6tBF4evhKmWHHdb8PYXd4I3v9yzhSXyhyEA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEZPR06MB6644
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use time_after_eq macro instead of opening it for readability.

Signed-off-by: Zehao Zhang <zhangzehao@vivo.com>
---
 drivers/block/xen-blkback/blkback.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/block/xen-blkback/blkback.c b/drivers/block/xen-blkback/blkback.c
index c362f4ad80ab..77b1b1785eb3 100644
--- a/drivers/block/xen-blkback/blkback.c
+++ b/drivers/block/xen-blkback/blkback.c
@@ -42,6 +42,7 @@
 #include <linux/delay.h>
 #include <linux/freezer.h>
 #include <linux/bitmap.h>
+#include <linux/jiffies.h>
 
 #include <xen/events.h>
 #include <xen/page.h>
@@ -134,8 +135,8 @@ module_param(log_stats, int, 0644);
 
 static inline bool persistent_gnt_timeout(struct persistent_gnt *persistent_gnt)
 {
-	return pgrant_timeout && (jiffies - persistent_gnt->last_used >=
-			HZ * pgrant_timeout);
+	return pgrant_timeout && (time_after_eq(jiffies,
+			persistent_gnt->last_used + HZ * pgrant_timeout));
 }
 
 #define vaddr(page) ((unsigned long)pfn_to_kaddr(page_to_pfn(page)))
-- 
2.35.3

