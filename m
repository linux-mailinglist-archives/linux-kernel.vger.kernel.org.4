Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 31E055B9439
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Sep 2022 08:20:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229562AbiIOGUB convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Thu, 15 Sep 2022 02:20:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48192 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229459AbiIOGT4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Sep 2022 02:19:56 -0400
Received: from SHSQR01.spreadtrum.com (mx1.unisoc.com [222.66.158.135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A57CD28720
        for <linux-kernel@vger.kernel.org>; Wed, 14 Sep 2022 23:19:52 -0700 (PDT)
Received: from SHSend.spreadtrum.com (bjmbx02.spreadtrum.com [10.0.64.8])
        by SHSQR01.spreadtrum.com with ESMTPS id 28F6J6tq022974
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NO);
        Thu, 15 Sep 2022 14:19:06 +0800 (CST)
        (envelope-from Zhiguo.Niu@unisoc.com)
Received: from bj08434pcu.spreadtrum.com (10.0.74.109) by
 BJMBX02.spreadtrum.com (10.0.64.8) with Microsoft SMTP Server (TLS) id
 15.0.1497.23; Thu, 15 Sep 2022 14:19:06 +0800
From:   "zhiguo.niu" <zhiguo.niu@unisoc.com>
To:     <jaegeuk@kernel.org>, <chao@kernel.org>,
        <linux-f2fs-devel@lists.sourceforge.net>,
        <linux-kernel@vger.kernel.org>
CC:     <lvqiang.huang@unisoc.com>
Subject: [PATCH Vx 1/1] f2fs: fix some error handling case in gc
Date:   Thu, 15 Sep 2022 14:18:49 +0800
Message-ID: <1663222729-27774-1-git-send-email-zhiguo.niu@unisoc.com>
X-Mailer: git-send-email 1.9.1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Originating-IP: [10.0.74.109]
X-ClientProxiedBy: SHCAS03.spreadtrum.com (10.0.1.207) To
 BJMBX02.spreadtrum.com (10.0.64.8)
Content-Transfer-Encoding: 8BIT
X-MAIL: SHSQR01.spreadtrum.com 28F6J6tq022974
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
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
2. Will cause more EIO error because of CP_ERROR_FLAG is set in
f2fs_stop_checkpoint, this is not reasonable.

So we fix this error handling case by recording current victim segment
as invalid for gc.

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
-                       f2fs_err(sbi, "Inconsistent segment (%u) type [%d, %d] in SSA and SIT",
-                                segno, type, GET_SUM_TYPE((&sum->footer)));
-                       set_sbi_flag(sbi, SBI_NEED_FSCK);
-                       f2fs_stop_checkpoint(sbi, false);
+#ifdef CONFIG_F2FS_CHECK_FS
+                       if (!test_and_set_bit(segno, SIT_I(sbi)->invalid_segmap)) {
+                               f2fs_err(sbi, "Inconsistent segment (%u) type [%d, %d] in SSA and SIT",
+                                       segno, type, GET_SUM_TYPE((&sum->footer)));
+                               set_sbi_flag(sbi, SBI_NEED_FSCK);
+                       }
+#endif
                        goto skip;
                }

--
2.17.1

________________________________
 This email (including its attachments) is intended only for the person or entity to which it is addressed and may contain information that is privileged, confidential or otherwise protected from disclosure. Unauthorized use, dissemination, distribution or copying of this email or the information herein or taking any action in reliance on the contents of this email or the information herein, by anyone other than the intended recipient, or an employee or agent responsible for delivering the message to the intended recipient, is strictly prohibited. If you are not the intended recipient, please do not read, copy, use or disclose any part of this e-mail to others. Please notify the sender immediately and permanently delete this e-mail and any attachments if you received it in error. Internet communications cannot be guaranteed to be timely, secure, error-free or virus-free. The sender does not accept liability for any errors or omissions.
本邮件及其附件具有保密性质，受法律保护不得泄露，仅发送给本邮件所指特定收件人。严禁非经授权使用、宣传、发布或复制本邮件或其内容。若非该特定收件人，请勿阅读、复制、 使用或披露本邮件的任何内容。若误收本邮件，请从系统中永久性删除本邮件及所有附件，并以回复邮件的方式即刻告知发件人。无法保证互联网通信及时、安全、无误或防毒。发件人对任何错漏均不承担责任。
