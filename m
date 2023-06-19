Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3821D734D75
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Jun 2023 10:21:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230283AbjFSIVI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Jun 2023 04:21:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58130 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230287AbjFSIUy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Jun 2023 04:20:54 -0400
Received: from APC01-TYZ-obe.outbound.protection.outlook.com (mail-tyzapc01on2128.outbound.protection.outlook.com [40.107.117.128])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F0681706
        for <linux-kernel@vger.kernel.org>; Mon, 19 Jun 2023 01:20:43 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=T/iDry9LZpgpAPhNnKkVAxMmYKEOF19NwNKTbyBqVCmHVaKQsJ7+EaWLPvx295XVBZL8LeJUTpHhrXNUdAR/RXYd6euuO8Z2jIxKjM3Rdqb1nHPS4KsF4BR8/Wc2Sshm9LPXK3HlojvMZwJMQPNITqUy948PdRc50BsioZAJiajwEvhEFdiHTgXJmhENY7TT2vp4yXifvqhJjjiVrJAVtpM1Qe0Yi6hpbOQDBTzmg0RRTyub7V51F3U0Wqh9juviWz7UnMLTwfaZiuaevSGozDkZHvwoc6xZBMG4/AmcvmQOZwBrs8fs0xFh+Jsc9NxMXuXbaIKd7BqU1x6EOIhUhg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zGng2fEH9yTY9dOZ3oWhibEft8qQVtcfxAwu04KvZlg=;
 b=ju6PAR1LCJX3jk+7Rmjuok2iD9Lyp1wDE+3kevUjL0f1B0zHJYAjyPVX2uxBy5ZTt0omWkMh3JIsjmhLJEQhNVKmvHOZM5fXWUcfTHBgZdt7HxWOmNiv+ogan8GVew1N3ORZbLwNfHh+YFelLkeERKTxiW4I2wtXd4O9LZXe5FovvtzhVRXdY/NfaSz7n2Oto7Jt2IB+KYjgE/OvT/XTPJu0RRYj8ojDzaHJgg5gk6ZBTh43lgadeoZkFUMScCXb1klqwiUWmpLTRczPJjCV+G0BqqC4T7V7DVTrMv2QyO0pNPsBm8FzT0PYUBKpg1pCfzJb+2Fk7tZqxUjoL06ryw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zGng2fEH9yTY9dOZ3oWhibEft8qQVtcfxAwu04KvZlg=;
 b=AuCr4VSH97b7g3YogxAdNQGNSar9Ix+dVSbwZ329SsUJj+5Nli3R7nE58tqtOEhNUqGmTx9qJv6hr/Kb1AR3AsLdmc4TX4mqrKskbWrhjh1U8ehgDb1E8Yg4aBSH9ZipLjVNx7uxdpI6TSQmafo6AriLEHhWjoeu8id3RxomqJBYb90iGk0x6wXY8q+o9fgmPqtaW3ZZ1ea9siKMLTDT8z3e6IJax/yiZCesnnv1Ec8u0cDHgMXTOAtEZiRGXpAt1pEXzyirt6j6K7kpqKCtPdPQcNwFz+g4pUW6w5RLHh+HXSg0N6NNNkS37k7hpAj9zPe3WGjXeO5yNSBPqxygFQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com (2603:1096:101:78::6)
 by KL1PR06MB6578.apcprd06.prod.outlook.com (2603:1096:820:fa::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6500.35; Mon, 19 Jun
 2023 08:20:38 +0000
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::fa0e:6c06:7474:285c]) by SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::fa0e:6c06:7474:285c%4]) with mapi id 15.20.6500.036; Mon, 19 Jun 2023
 08:20:37 +0000
From:   Yangtao Li <frank.li@vivo.com>
To:     Jaegeuk Kim <jaegeuk@kernel.org>, Chao Yu <chao@kernel.org>
Cc:     Yangtao Li <frank.li@vivo.com>,
        linux-f2fs-devel@lists.sourceforge.net,
        linux-kernel@vger.kernel.org
Subject: [PATCH] f2fs: call fsnotify_sb_error() when f2fs have errors
Date:   Mon, 19 Jun 2023 16:20:25 +0800
Message-Id: <20230619082025.10832-1-frank.li@vivo.com>
X-Mailer: git-send-email 2.39.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR06CA0203.apcprd06.prod.outlook.com (2603:1096:4:1::35)
 To SEZPR06MB5269.apcprd06.prod.outlook.com (2603:1096:101:78::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SEZPR06MB5269:EE_|KL1PR06MB6578:EE_
X-MS-Office365-Filtering-Correlation-Id: 75d11a36-47c0-4532-ed00-08db709e0f9c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: q03sNCgUm8str3PYYYxty1HeJzkfnwjcIIzSoL70aZoH4VKjT/7dRcJcyb+jZSwxUYrzTzWpPwkoY3RcCVsf2BIa19AaD7cgJAyLrqwrqPEDLla4a+CawN6gGutYTZ0F14ZZPgZnwaNy58I9Sghp1cypznLJOWOHmx2GiDPNq0RUX6ATBkw29lkYYEul8TlxeLgnH7GoDxi/XBzugaXG5a/4gvoaVmF6oHmfKA5nmn4jW4pJACO9H6lhtCKYX8nCNsBNSbBpbATVV6c3iHx8czbbN9cNiAhJ7TEtfLrhmfegHz0ZAvKUVozslfogizBFnjma4CwYbnjbgUvBVLKulvx+0oXGBxGYAi4XEV0KVVaY+69v7+VXCZHaHqAv72MlS6rTMzBpjVVRqil1vOhabRfC6Z+WVPTMbgwTevt3yKHGLmh14lJpA9grG7ZSg2rWrCzx2BzmusXA/JmWY4+WsEssGES+paFyoeGEcmijuBNJkdfOHg0WKPGQszOjMeVOwUQjMBuqTQBdOrlyvdsqJul5t7AzFmh96Zs7F0VUOgsAga+5GswC/vZiHq6VhdJNbimVSzeII+8rIO0G4V+rkO/zP7DkJuvOK1SFl/obHbZ+75mf/5OG5dc8nmyHk/ul
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEZPR06MB5269.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(136003)(346002)(39860400002)(396003)(366004)(376002)(451199021)(110136005)(478600001)(41300700001)(8936002)(8676002)(5660300002)(38100700002)(38350700002)(66946007)(66476007)(66556008)(4326008)(316002)(2616005)(186003)(26005)(6512007)(83380400001)(6486002)(6666004)(52116002)(6506007)(1076003)(86362001)(2906002)(36756003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?iwQtwtxpfUJBfzjyQDVHEMPiKBajTHaOJ5fyDyBNBtF8Cp3USW73agaYzGel?=
 =?us-ascii?Q?iyME+tDh7vsQ5Pmfmap71yKHW3MD1E9ohsdIZKCALzdMwh2UNHEIYVRBy9dG?=
 =?us-ascii?Q?UxLBdzs3tOYTJsQA33srLqXYBr+f7JCVr8nLRF1Hn86Uv58zi5OU/XBNHzSr?=
 =?us-ascii?Q?iAls/kDYWmHgcSLbABi4TrAwOp99VZRplCWY57VtdD+nOkGzFZiQpbdRwhxS?=
 =?us-ascii?Q?BgbMU+MMpkDIvjuzPYfMYtTNLu5Ah5WKyBPCu7RRkc5Jo4kmrU6AgArESMXm?=
 =?us-ascii?Q?qOoUBGv+K8KReIdLyMP+NxG8AaIVLwpLoqkygD4nyUGjgPuO6iODmXsQrMJR?=
 =?us-ascii?Q?q1/I1VMmOIIjoCmx6UCyptTZQuz4fmUyI4CbZJwXsqCr0b2gkTofNl319kmN?=
 =?us-ascii?Q?K0o0XSYpcAeZ/EZGzX4O8H+PLp04t4YtjjHgzOpldLIzzmjRFfzYZSJAzpzI?=
 =?us-ascii?Q?qyUoWY1T3ubpB97pBec8ZkbY+8RO7nHUMnX31dwt7k8ZhFD2OtRRk6MywPYi?=
 =?us-ascii?Q?dxSZYEPaS1Ap5ak9p3yd8+0uZIGzVklAsJG0UXRFeCzn/TfOkwCGY6yi9VTC?=
 =?us-ascii?Q?dpSHppVFXl4bLkYksFwqvysn9n1/fDTXGQhslfbyHllVA+L9I/GKf4i9VKLU?=
 =?us-ascii?Q?r3eUEbPsvAI8CJk8Qy9wtBBDcPrpUjFQZqAandlWXmR8FVCZXQbFwL6S/gYi?=
 =?us-ascii?Q?q3ioYBnkLZXjI2pyKTgqUSvXXAsjPJsinVMYHgrQtSDRsqz1dwGO6xSgiVoZ?=
 =?us-ascii?Q?8HaGQK8Q0WJfEwPpsGhQEZb/d2taaaMG8amUT4hC5ovkDnYA2o4jMriwDIZo?=
 =?us-ascii?Q?EK2yYQjS9sExjvafA8HCgj5th8ZPzeuGahoKTKzpVqAuL+3w89DrzAW+XFop?=
 =?us-ascii?Q?ExN61EnTWYoKAys5ExpJkzJh/QIIk4m9Q5jB3dLE94iAJS+UE5P9A12uTiGP?=
 =?us-ascii?Q?fr4TzdYqTIVzLdf7sFa5LYT6LEjSlkE9yWgyJheRF2ZUgoCLu6iddbb7jlaZ?=
 =?us-ascii?Q?ivDPQEUqFmaRJ3NU30t30tD5Rn5nyh+1baNhmbnwv/CJtWP60niIa4nbE2B5?=
 =?us-ascii?Q?TSQbd/mcZeP7fup+yAKeGdwC7sGEf1Vn7tL51ZGE63AZLle3aJsoIF6UfkbM?=
 =?us-ascii?Q?JmaJI4yqIEZZjWT2nsRGj/FGGhsFgxnXuAi2a0gRqBxAsV8bVNk+5nkRhw+b?=
 =?us-ascii?Q?u+Q2LKnnZKv0lLl2PUj9NTSTvxxMqOGWeKVY8zi6R/0EGbXdjkzXbsVWpU3T?=
 =?us-ascii?Q?vjOQITl8d0RqaNa2seLmUtcj8B3G03c32p+NvUAjBOvdelttPzEKTMTNAfmC?=
 =?us-ascii?Q?Z10J5w/2ARO5kI8bHxCB9HYGI8SRxYcQ8clzBFy4lpdeJ0whbOlN+jwG6DGp?=
 =?us-ascii?Q?RSzmeiOAMXsVQTPs/hhZ2JfF9sQ5nvWzMEkEGIisjC26tNt3pdrDrLOANGsK?=
 =?us-ascii?Q?caSzxjozvc4n8G9tzfe3n2DDKm1V2R3LUdyIXZXX8vZ3S4uI9tJMQMuIKhoB?=
 =?us-ascii?Q?Y+tD17t8jVyY1qpy7D0IaRjy1cLakr5zOaHIBSrgg96JS9Kz84iumOm78g2f?=
 =?us-ascii?Q?o2bKCb7fJYbjohjN02G8Ornnnus5jngyMnBkad/S?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 75d11a36-47c0-4532-ed00-08db709e0f9c
X-MS-Exchange-CrossTenant-AuthSource: SEZPR06MB5269.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jun 2023 08:20:37.5525
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: MBzW7q6JaGfeYPV6QTi839EnmCqCQ05pJiN/3qba+CZCH0SkxKJShqITvW8YCsLLGiQMYxljg+nF7oOyZ4hdBA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KL1PR06MB6578
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When an EFSCORRUPTED error occurs in f2fs, report the error to
userspace monitoring tools.

Signed-off-by: Yangtao Li <frank.li@vivo.com>
---
 fs/f2fs/super.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/fs/f2fs/super.c b/fs/f2fs/super.c
index 375a178540d6..69c747c4d4f4 100644
--- a/fs/f2fs/super.c
+++ b/fs/f2fs/super.c
@@ -28,6 +28,7 @@
 #include <linux/part_stat.h>
 #include <linux/zstd.h>
 #include <linux/lz4.h>
+#include <linux/fsnotify.h>
 
 #include "f2fs.h"
 #include "node.h"
@@ -4035,6 +4036,8 @@ static void f2fs_record_stop_reason(struct f2fs_sb_info *sbi)
 	f2fs_up_write(&sbi->sb_lock);
 	if (err)
 		f2fs_err(sbi, "f2fs_commit_super fails to record err:%d", err);
+
+	fsnotify_sb_error(sbi->sb, NULL, EFSCORRUPTED);
 }
 
 void f2fs_save_errors(struct f2fs_sb_info *sbi, unsigned char flag)
@@ -4081,6 +4084,8 @@ static void f2fs_record_errors(struct f2fs_sb_info *sbi, unsigned char error)
 								error, err);
 out_unlock:
 	f2fs_up_write(&sbi->sb_lock);
+
+	fsnotify_sb_error(sbi->sb, NULL, EFSCORRUPTED);
 }
 
 void f2fs_handle_error(struct f2fs_sb_info *sbi, unsigned char error)
-- 
2.39.0

