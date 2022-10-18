Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1134E602E7F
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Oct 2022 16:29:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231499AbiJRO35 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Oct 2022 10:29:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43078 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231513AbiJRO3m (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Oct 2022 10:29:42 -0400
Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB2B16471;
        Tue, 18 Oct 2022 07:29:40 -0700 (PDT)
Received: from mail02.huawei.com (unknown [172.30.67.153])
        by dggsgout12.his.huawei.com (SkyGuard) with ESMTP id 4MsGQt68kVz6Q4XK;
        Tue, 18 Oct 2022 22:27:18 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.127.227])
        by APP4 (Coremail) with SMTP id gCh0CgBHWTBRuE5jkSo6AA--.18765S6;
        Tue, 18 Oct 2022 22:29:38 +0800 (CST)
From:   Ye Bin <yebin@huaweicloud.com>
To:     axboe@kernel.dk, rostedt@goodmis.org, mhiramat@kernel.org,
        linux-block@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, yebin@huaweicloud.com
Subject: [PATCH v2 2/3] blktrace: fix possible memleak in '__blk_trace_remove'
Date:   Tue, 18 Oct 2022 22:51:34 +0800
Message-Id: <20221018145135.932240-3-yebin@huaweicloud.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20221018145135.932240-1-yebin@huaweicloud.com>
References: <20221018145135.932240-1-yebin@huaweicloud.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: gCh0CgBHWTBRuE5jkSo6AA--.18765S6
X-Coremail-Antispam: 1UD129KBjvJXoWxXw4ruFy7KF4rKrWxGry8Krg_yoW5Xw4DpF
        48Xrs0kw48ZF4Fgw4v9r1fXry8t34Yy3y5Jr9xuw4ftr98tryYqFnF9ryqvFW5Zay8KFWf
        AryrZr4jyr4UWa7anT9S1TB71UUUUjUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUml14x267AKxVW5JVWrJwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
        rVWUJVWUGwAFIxvE14AKwVWUJVWUGwA2048vs2IY020E87I2jVAFwI0_Jryl82xGYIkIc2
        x26xkF7I0E14v26r4j6ryUM28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8wA2z4x0
        Y4vE2Ix0cI8IcVAFwI0_tr0E3s1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Gr1j6F4UJw
        A2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x0267AKxVW0oVCq3wAa
        w2AFwI0_Jrv_JF1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrV
        C2j2WlYx0E2Ix0cI8IcVAFwI0_JrI_JrylYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE
        7xkEbVWUJVW8JwACjcxG0xvY0x0EwIxGrwACjI8F5VA0II8E6IAqYI8I648v4I1lc7CjxV
        Aaw2AFwI0_JF0_Jw1l42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1l4IxY
        O2xFxVAFwI0_Jrv_JF1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGV
        WUWwC2zVAF1VAY17CE14v26r126r1DMIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_
        Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r4j6F4UMIIF0xvE42xK8VAvwI8IcIk0rV
        WUJVWUCwCI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r4j6r4U
        JbIYCTnIWIevJa73UjIFyTuYvjfU1a0mUUUUU
X-CM-SenderInfo: p1hex046kxt4xhlfz01xgou0bp/
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When test as follows:
step1: ioctl(sda, BLKTRACESETUP, &arg)
step2: ioctl(sda, BLKTRACESTART, NULL)
step3: ioctl(sda, BLKTRACETEARDOWN, NULL)
step4: ioctl(sda, BLKTRACESETUP, &arg)
Got issue as follows:
debugfs: File 'dropped' in directory 'sda' already present!
debugfs: File 'msg' in directory 'sda' already present!
debugfs: File 'trace0' in directory 'sda' already present!

And also find syzkaller report issue like "KASAN: use-after-free Read in relay_switch_subbuf"
"https://syzkaller.appspot.com/bug?id=13849f0d9b1b818b087341691be6cc3ac6a6bfb7"

If remove block trace without stop(BLKTRACESTOP) block trace, '__blk_trace_remove'
will just set 'q->blk_trace' with NULL. However, debugfs file isn't removed, so
will report file already present when call BLKTRACESETUP.
static int __blk_trace_remove(struct request_queue *q)
{
        struct blk_trace *bt;

        bt = rcu_replace_pointer(q->blk_trace, NULL,
                                 lockdep_is_held(&q->debugfs_mutex));
        if (!bt)
                return -EINVAL;

	if (bt->trace_state != Blktrace_running)
        	blk_trace_cleanup(q, bt);

        return 0;
}

If do test as follows:
step1: ioctl(sda, BLKTRACESETUP, &arg)
step2: ioctl(sda, BLKTRACESTART, NULL)
step3: ioctl(sda, BLKTRACETEARDOWN, NULL)
step4: remove sda

There will remove debugfs directory which will remove recursively all file
under directory.
>> blk_release_queue
>>	debugfs_remove_recursive(q->debugfs_dir)
So all files which created in 'do_blk_trace_setup' are removed, and
'dentry->d_inode' is NULL. But 'q->blk_trace' is still in 'running_trace_lock',
'trace_note_tsk' will traverse 'running_trace_lock' all nodes.
>>trace_note_tsk
>>  trace_note
>>    relay_reserve
>>       relay_switch_subbuf
>>        d_inode(buf->dentry)->i_size

To solve above issues, reference commit '5afedf670caf', call 'blk_trace_cleanup'
unconditionally in '__blk_trace_remove' and first stop block trace in
'blk_trace_cleanup'.

Signed-off-by: Ye Bin <yebin@huaweicloud.com>
---
 kernel/trace/blktrace.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/kernel/trace/blktrace.c b/kernel/trace/blktrace.c
index f07a03c1e052..030e5716661e 100644
--- a/kernel/trace/blktrace.c
+++ b/kernel/trace/blktrace.c
@@ -387,6 +387,7 @@ static int blk_trace_stop(struct blk_trace *bt)
 
 static void blk_trace_cleanup(struct request_queue *q, struct blk_trace *bt)
 {
+	blk_trace_stop(bt);
 	synchronize_rcu();
 	blk_trace_free(q, bt);
 	put_probe_ref();
@@ -401,8 +402,7 @@ static int __blk_trace_remove(struct request_queue *q)
 	if (!bt)
 		return -EINVAL;
 
-	if (bt->trace_state != Blktrace_running)
-		blk_trace_cleanup(q, bt);
+	blk_trace_cleanup(q, bt);
 
 	return 0;
 }
-- 
2.31.1

