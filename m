Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BEEA060CD62
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Oct 2022 15:27:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232821AbiJYN1A (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Oct 2022 09:27:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35456 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232747AbiJYN06 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Oct 2022 09:26:58 -0400
Received: from APC01-PSA-obe.outbound.protection.outlook.com (mail-psaapc01on2119.outbound.protection.outlook.com [40.107.255.119])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 06A80766A
        for <linux-kernel@vger.kernel.org>; Tue, 25 Oct 2022 06:26:53 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=X4A+sggHdBpa6iapmofbGl8GUwm1Sy24OFz14po6pSHuGKzopMQO4HVrnbh0u3qyceCj4FGg2CRdVncicoUwQFzhaqDtidAtCKm/r/OnPXQLZ9mXTRK3jkZe8vKtyhnJM8GHrhwbWsmoYgd0Iun1VmkE0Lgwm2ldHg0MEBYe8KZ+LQNHPwNNQZZrGG2zk+Ss6xRKo+VV4UagxiYFoJtGtXhcOjVVr/mxvZn48lM1H6PHzAtMFH5/2yFyyZoBusJ8ICwrtTIyZIUbVmn1jsJZbvIpbrqGSlFUUumqeszik9mpFqlWr8dcAxwcD2pubFMJXoHzYJgJ9l17w3YCjk2PcQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=v5iQUOl0qSFHB5FESAdrtz1h0GCJFKrchifWQ9aB7Do=;
 b=Qryv3JEXukwolVU0ashQuubuGh63a0TCgmwJ87XRkRmEmyG2Rkg+sWKvg/n3oxaawIyFMS/7ziJlm+SimTAth3QAsNjH7f9xVf2wA2s1gRl7sSvoi21srR9jYG2pleLYcGIieSp0jfMCSJAHya/f6v4xSxj2I1L/7C63JxYHsc0/suMb5Nt95fWSFQQvrRlTrOAxh3tVc23iwv0yjrUu50cyTlP4YrGjSb3lKej/iBO6ymfAqUj39biWBpsn/x/FGbfiAUYAS/q8Iz5/2Q1BNve6Iux3HF3ki/dYi+uNT4fWYtNqD4Jah9tklqY4/X18PkEDt68mtUECgN44pFH8qw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=v5iQUOl0qSFHB5FESAdrtz1h0GCJFKrchifWQ9aB7Do=;
 b=qUurqRPoJ2V6ljvOI82kOfNmhXyut1iXB4slzj/MzTDXfGm6StB4K7b/X/XtLysP2zDqW0Ek/BzcUSW15G3NRV7+iLeE0I/HnVmmasSlHhqRSpUM0yUvFIAQkGjgEY5tRJ+AM1CKg3QMMxR7pR805W/J/00GDsMfPMUnAUK87ZWkgwOvRDgi7pC9emMPxJLyK3bMn5YGd7Jz+t7ga2RLt631+TKpF9tz1w8G/aVUsCtikGBeSisALbZH4BfCAiNarecb+J79Z+N8IroZwz6P+tfF8S+jmG00O+Gszl+262koFutnIdoo0NQc6+rCd3x2Dunb3y7B3S4i9no12mhczA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com (2603:1096:101:78::6)
 by PSAPR06MB4168.apcprd06.prod.outlook.com (2603:1096:301:35::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5746.28; Tue, 25 Oct
 2022 13:26:50 +0000
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::c84b:5a6c:d66f:c0fd]) by SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::c84b:5a6c:d66f:c0fd%3]) with mapi id 15.20.5746.023; Tue, 25 Oct 2022
 13:26:50 +0000
From:   Yangtao Li <frank.li@vivo.com>
To:     jaegeuk@kernel.org, chao@kernel.org
Cc:     linux-f2fs-devel@lists.sourceforge.net,
        linux-kernel@vger.kernel.org, Yangtao Li <frank.li@vivo.com>
Subject: [PATCH v2] f2fs: add proc entry to show discard_plist info
Date:   Tue, 25 Oct 2022 21:26:38 +0800
Message-Id: <20221025132638.38260-1-frank.li@vivo.com>
X-Mailer: git-send-email 2.35.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2P153CA0013.APCP153.PROD.OUTLOOK.COM
 (2603:1096:4:140::12) To SEZPR06MB5269.apcprd06.prod.outlook.com
 (2603:1096:101:78::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SEZPR06MB5269:EE_|PSAPR06MB4168:EE_
X-MS-Office365-Filtering-Correlation-Id: 46a6b698-fbab-4d62-caf3-08dab68c9279
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ziG+Ye9rqfI4o4xUXVoGGxfs53wU72cdppwrlV+XDtXPBV4jT2owUWUtugQTwfmmfFcXFCQ4t8JkJ1HMW3pBQAEO7+4hssWYTu7xDk4xMBjSUdE5fLtaL/eW7lz4aegxRtNTxZqrkUjw1jxRppkAoWVV9ejsa6ER5Qjrtbb8X8EFmqw5eMxFArFn7bJ5pwxU7nED/lfqmySeqseb6pqCX+BelD0KHIelteAJ6hZyjHtvd7CvH8LhmkrUW1ZuAQKEIS92CWhW0WbvXJCT6az0JvwTThxRZtUrTjB5w84KVxAxHEqOCg5wgTRtnLE/4xEWKqRUCcmIgHT+IFGHp16J+0e23KEx7YboP12qYSeEPG8AAJD8SdAtGD8fBaSvNMgm71FOqu8hhGZCyfzrgxwc7lgqWYNWoQszJiIeVK3sbWV9RK381K7n7k5CS5/P4nd27K64febxeaEGpQ10+YCX0ufOhBkXIXQvxCO5eAMxcD3HizxbJuPBGyFQab8bcQlHm7jSDM5zBbie6LIPFDxR61dP1CAFI2CTiuZsz/++H/xl2RR1trB7z9mLlLhrK5Jw8ZE+2lChqvJSFwh7YXov7+hNfXXZpg6FVt2cTGh8NS89MyTI7OL9I3tgXo+igS8XdrhIPuI2yLk0BLpJ4AvL4VSxd+0eaKtnyw/PSIY/ZZQTw9O9hP6y54cyaWNfWWEeptloIa7zFKe5nhlyqHBRwK79o+Wmb1deMIh4yLx/e5YPuAavm+wr68z7f0np2uc1pDtS+p96Ek8GkKiXp4ACuw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEZPR06MB5269.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(136003)(39860400002)(376002)(396003)(366004)(346002)(451199015)(107886003)(6666004)(1076003)(8936002)(66946007)(2906002)(2616005)(5660300002)(6506007)(36756003)(26005)(66556008)(66476007)(4326008)(86362001)(8676002)(41300700001)(38350700002)(186003)(52116002)(83380400001)(316002)(6512007)(38100700002)(478600001)(6486002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?5eWQuif1G/vGa8SW4QmiuhdK/loxms8ef6XD/dXqkMsFLvxafMQa+aRBcczS?=
 =?us-ascii?Q?uZMOt2sGLrH8M//bQCBwgcG7X4Q15RTESzYKcxgpZSoTHajKFfxEMMqOLY3L?=
 =?us-ascii?Q?wH/VD7CaDbtpJX5gmJ/QvZiYx/9r6H2vLUfHnU6xN/haSAw+8GV7uMKRbZZr?=
 =?us-ascii?Q?HF62RQq5bulummQnYvqe/NoJy9YnjX8tP7OZLzL0WokvaduZ4TxUoYv8mDi/?=
 =?us-ascii?Q?eA2omffxHnls7MqZDBqWRNYOvCWdhHrHFcT1X45RFcl/tw8ylbWUn4luLKh5?=
 =?us-ascii?Q?fsNCNcwyIo5TpZgaUhIGdIWyNenhE1csJCy0V7EoDQ5kwGi+EBPA0sRyd3uJ?=
 =?us-ascii?Q?coh8yDQFactrq8vuJGpxsXzNL9Y8kfE1BhSdPz58zKG0jrz7BulK4PO0y6ux?=
 =?us-ascii?Q?AZakhCFtaQ2MMnWD+uwJL3fHsuQA0YZw2nIXp660bZnHpe2iSfeC5LA+eBI5?=
 =?us-ascii?Q?P2EZEinQcrRSzTHzudQYzcAunOMsDIgHwquRKX8e4VOniHqBcOjoYi8/xIZd?=
 =?us-ascii?Q?oTc10MFJz91i9wM1FUgR3urJXGVJNOyoVN+sZLuLQ/EMwdwbm83Bu76x7cRl?=
 =?us-ascii?Q?fuGvKmVx33IzAU+cb8mu3dWgiOshxx1UtHKummP8yCRoqFnCylJNKhKEoy+K?=
 =?us-ascii?Q?ZNVq2j3t/IoZF/woKqVVN6qcQloLFHW1fQkEE53VFizF7o3eV67kSkoFNaUp?=
 =?us-ascii?Q?gGF/vBHP8Sw/zigqcqVkUQoqHyR9kyS3TTmH1ooIc4o4V8OrISlfngWws4yo?=
 =?us-ascii?Q?bqJZW9RU9sdTsTBNzOrvfKmTdJaiDQOMOiVVWQsTe2NTbPFAKpYHF9843mSt?=
 =?us-ascii?Q?oRWcBqmoNSn9MicI88dNYgL3NyT44XtBFaBu7KLrRPdJb5jNgRew78WC5Moh?=
 =?us-ascii?Q?LRNc5PWMVPB75Cm0PgP+43y/6vd0lnWN8eIJjncD433Nqxpytq6l4YQinKX7?=
 =?us-ascii?Q?RqeItAv4w7BFA35GqAA6HsxNabwsuuJUVCcETNL3qfoRAaD7ZZize5ZC//Os?=
 =?us-ascii?Q?TTi852bNHjIFFvxRoBP/p3b0cp+q8oBglX90us5tUZDafr94g42w9zFsX6zK?=
 =?us-ascii?Q?Says2H/0lIaKAcP7UTbrpYYCjga0K1Vn6Uwr+gggFLUBHEc/vCsw5uwcBNnM?=
 =?us-ascii?Q?qGgcibOYmVjjZdkzpuiwvmD3t7kWIqkLeZd68WMOumjgzQZ/7CcvLGxbRHM4?=
 =?us-ascii?Q?VVxIP6gceiJ3TlpSwE4p/Ek2fRzfL5E39KKCrKDTErIx2lBHBYRpoXh2d2yv?=
 =?us-ascii?Q?IvC8YsQ4psIN/fVSFRlygOfAuTOQA/Z01Nh27ZplAVBf2tsSoeo6C6YYT0lG?=
 =?us-ascii?Q?J6TuBEA7b9yzIwPXNGV/PsWyOYTXIgS7T40VtCqQ+C5j5IdA18yZUTi5F7yz?=
 =?us-ascii?Q?nokESWspcfhCPgKxr/XPFfsXZ140buuH0qmd2e7RN6kh9ft6EbYT3UrIeG5L?=
 =?us-ascii?Q?IdSLemneq31sZZaIO4mLY0BUdOqNOhcxy1OwVk2DmRzf5+s++Jn+VG0MEEyj?=
 =?us-ascii?Q?6zSDKwsKTZANmY/QXo9UuW211nbWNF57Fe5IZ8uuwcRmZVHTIs0lTUKDzzGl?=
 =?us-ascii?Q?q5rsPn+NPY2H+5R/G3nhYuMqtmaDtrdDZKQVccBn?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 46a6b698-fbab-4d62-caf3-08dab68c9279
X-MS-Exchange-CrossTenant-AuthSource: SEZPR06MB5269.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Oct 2022 13:26:49.7040
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Yon9TeoF7CPUGxwwrRR6e68grFYjdhitlN8SyJi75zcT6nbc1fEXFcOcChsyGCmQBjR14y3ie4w8vuaSXKTyzw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PSAPR06MB4168
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch adds a new proc entry to show discard_plist
information in more detail, which is very helpful to
know the discard pend list count clearly.

Such as:

Discard pend list(Show diacrd_cmd count on each entry, .:not exist):
  0       390     156      85      67      46      37      26      14
  8        17      12       9       9       6      12      11      10
  16        5       9       2       4       8       3       4       1
  24        3       2       2       5       2       4       5       4
  32        3       3       2       3       .       3       3       1
  40        .       4       1       3       2       1       2       1
  48        1       .       1       1       .       1       1       .
  56        .       1       1       1       .       2       .       1
  64        1       2       .       .       .       .       .       .
  72        .       1       .       .       .       .       .       .
  80        3       1       .       .       1       1       .       .
  88        1       .       .       .       1       .       .       1
......

Signed-off-by: Yangtao Li <frank.li@vivo.com>
---
v2:
-move to procfs entry
 fs/f2fs/sysfs.c | 41 +++++++++++++++++++++++++++++++++++++++++
 1 file changed, 41 insertions(+)

diff --git a/fs/f2fs/sysfs.c b/fs/f2fs/sysfs.c
index df27afd71ef4..0fc17375e042 100644
--- a/fs/f2fs/sysfs.c
+++ b/fs/f2fs/sysfs.c
@@ -1243,6 +1243,44 @@ static int __maybe_unused victim_bits_seq_show(struct seq_file *seq,
 	return 0;
 }
 
+static int __maybe_unused discard_plist_seq_show(struct seq_file *seq,
+						void *offset)
+{
+	struct super_block *sb = seq->private;
+	struct f2fs_sb_info *sbi = F2FS_SB(sb);
+	struct discard_cmd_control *dcc = SM_I(sbi)->dcc_info;
+	int i, count;
+
+	seq_puts(seq, "Discard pend list(Show diacrd_cmd count on each entry, .:not exist):\n");
+	if (!f2fs_realtime_discard_enable(sbi))
+		return 0;
+
+	if (dcc) {
+		mutex_lock(&dcc->cmd_lock);
+		for (i = 0; i < MAX_PLIST_NUM; i++) {
+			struct list_head *pend_list;
+			struct discard_cmd *dc, *tmp;
+
+			if (i % 8 == 0)
+				seq_printf(seq, "  %-3d", i);
+			count = 0;
+			pend_list = &dcc->pend_list[i];
+			list_for_each_entry_safe(dc, tmp, pend_list, list)
+				count++;
+			if (count)
+				seq_printf(seq, " %7d", count);
+			else
+				seq_puts(seq, "       .");
+			if (i % 8 == 7)
+				seq_putc(seq, '\n');
+		}
+		seq_putc(seq, '\n');
+		mutex_unlock(&dcc->cmd_lock);
+	}
+
+	return 0;
+}
+
 int __init f2fs_init_sysfs(void)
 {
 	int ret;
@@ -1313,6 +1351,8 @@ int f2fs_register_sysfs(struct f2fs_sb_info *sbi)
 #endif
 		proc_create_single_data("victim_bits", 0444, sbi->s_proc,
 				victim_bits_seq_show, sb);
+		proc_create_single_data("discard_plist_info", 0444, sbi->s_proc,
+				discard_plist_seq_show, sb);
 	}
 	return 0;
 put_feature_list_kobj:
@@ -1336,6 +1376,7 @@ void f2fs_unregister_sysfs(struct f2fs_sb_info *sbi)
 		remove_proc_entry("segment_info", sbi->s_proc);
 		remove_proc_entry("segment_bits", sbi->s_proc);
 		remove_proc_entry("victim_bits", sbi->s_proc);
+		remove_proc_entry("discard_plist_info", sbi->s_proc);
 		remove_proc_entry(sbi->sb->s_id, f2fs_proc_root);
 	}
 
-- 
2.25.1

