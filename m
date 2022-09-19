Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 754E95BC2A8
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Sep 2022 08:02:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229602AbiISGCL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Sep 2022 02:02:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42780 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229497AbiISGCG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Sep 2022 02:02:06 -0400
Received: from SHSQR01.spreadtrum.com (unknown [222.66.158.135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E01714D0F
        for <linux-kernel@vger.kernel.org>; Sun, 18 Sep 2022 23:02:03 -0700 (PDT)
Received: from SHSend.spreadtrum.com (bjmbx02.spreadtrum.com [10.0.64.8])
        by SHSQR01.spreadtrum.com with ESMTPS id 28J611ob064546
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NO);
        Mon, 19 Sep 2022 14:01:01 +0800 (CST)
        (envelope-from Zhiguo.Niu@unisoc.com)
Received: from bj08434pcu.spreadtrum.com (10.0.74.109) by
 BJMBX02.spreadtrum.com (10.0.64.8) with Microsoft SMTP Server (TLS) id
 15.0.1497.23; Mon, 19 Sep 2022 14:01:00 +0800
From:   "zhiguo.niu" <zhiguo.niu@unisoc.com>
To:     <jaegeuk@kernel.org>, <chao@kernel.org>,
        <linux-f2fs-devel@lists.sourceforge.net>,
        <linux-kernel@vger.kernel.org>
CC:     <niuzhiguo84@gmail.com>, <xiuhong.wang@unisoc.com>,
        <zhiguo.niu@unisoc.com>
Subject: [PATCH V2] f2fs: fix some error handling case in gc
Date:   Mon, 19 Sep 2022 14:00:54 +0800
Message-ID: <1663567254-12338-1-git-send-email-zhiguo.niu@unisoc.com>
X-Mailer: git-send-email 1.9.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.0.74.109]
X-ClientProxiedBy: SHCAS03.spreadtrum.com (10.0.1.207) To
 BJMBX02.spreadtrum.com (10.0.64.8)
X-MAIL: SHSQR01.spreadtrum.com 28J611ob064546
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

During GC, if segment type stored in SSA and SIT is inconsistent,
we set SBI_NEED_FSCK first and then stop checkpoint, this will
cause the following issues:
1. SBI_NEED_FSCK can not be set to flash truly because of checkpoint
has been stopped.
2. Will cause more EIO error if user use f2fs because of CP_ERROR_FLAG
has been set in f2fs_stop_checkpoint, this is not reasonable.

So we fix this error handling case by recording current victim segment
as invalid for gc and do not stop checkpoint.
1. SBI_NEED_FSCK will still be set but not do f2fs_stop_checkpoint for
f2fs.fsck to have opportunity to fix the inconsistent segment type
in SSA and SIT.
2. Let user can still use fs, avoid EIO error for some operations such
as read and write,etc
3. If current segment has inconsistent segment type in SSA and SIT,
we add this segment segno in SIT_I(sbi)->invalid_segmap to skip this
segment to avoid deadloop in gc,similar as commit bbf9f7d90f21 ("f2fs:
Fix indefinite loop in f2fs_gc()")

Fixes: 793ab1c8a792 ("f2fs: fix to avoid deadloop in foreground GC")
Signed-off-by: zhiguo.niu <zhiguo.niu@unisoc.com>
---
 fs/f2fs/gc.c | 11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

diff --git a/fs/f2fs/gc.c b/fs/f2fs/gc.c
index d5fb426e0747..66bdf2678b5e 100644
--- a/fs/f2fs/gc.c
+++ b/fs/f2fs/gc.c
@@ -1700,10 +1700,13 @@ static int do_garbage_collect(struct f2fs_sb_info *sbi,
 
 		sum = page_address(sum_page);
 		if (type != GET_SUM_TYPE((&sum->footer))) {
-			f2fs_err(sbi, "Inconsistent segment (%u) type [%d, %d] in SSA and SIT",
-				 segno, type, GET_SUM_TYPE((&sum->footer)));
-			set_sbi_flag(sbi, SBI_NEED_FSCK);
-			f2fs_stop_checkpoint(sbi, false);
+#ifdef CONFIG_F2FS_CHECK_FS
+			if (!test_and_set_bit(segno, SIT_I(sbi)->invalid_segmap)) {
+				f2fs_err(sbi, "Inconsistent segment (%u) type [%d, %d] in SSA and SIT",
+					segno, type, GET_SUM_TYPE((&sum->footer)));
+				set_sbi_flag(sbi, SBI_NEED_FSCK);
+			}
+#endif
 			goto skip;
 		}
 
-- 
2.17.1

