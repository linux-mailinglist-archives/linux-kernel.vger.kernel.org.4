Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D705160387F
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Oct 2022 05:14:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229915AbiJSDOP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Oct 2022 23:14:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44430 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229732AbiJSDOG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Oct 2022 23:14:06 -0400
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 189DE165A8;
        Tue, 18 Oct 2022 20:14:04 -0700 (PDT)
Received: from mail02.huawei.com (unknown [172.30.67.153])
        by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4MsbPF2ZQTzl7wh;
        Wed, 19 Oct 2022 11:12:01 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.127.227])
        by APP4 (Coremail) with SMTP id gCh0CgDnLS53a09jvmtUAA--.10775S6;
        Wed, 19 Oct 2022 11:14:00 +0800 (CST)
From:   Ye Bin <yebin@huaweicloud.com>
To:     axboe@kernel.dk, rostedt@goodmis.org, mhiramat@kernel.org,
        linux-block@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, yebin@huaweicloud.com,
        Ye Bin <yebin10@huawei.com>
Subject: [PATCH v3 2/3] blktrace: fix possible memleak in '__blk_trace_remove'
Date:   Wed, 19 Oct 2022 11:36:01 +0800
Message-Id: <20221019033602.752383-3-yebin@huaweicloud.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20221019033602.752383-1-yebin@huaweicloud.com>
References: <20221019033602.752383-1-yebin@huaweicloud.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: gCh0CgDnLS53a09jvmtUAA--.10775S6
X-Coremail-Antispam: 1UD129KBjvJXoWxXw4ruFy7KF4rKrWxGry8Krg_yoW5WryxpF
        48Xrs0kw48ZF40g3yv9r1fXry8t34Yy3y5JF9xuw4rtr98tryYgFnF9ryqvFW5AFW8KFWf
        Ar1rZr1jyr4UWa7anT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUU9v14x267AKxVWrJVCq3wAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
        rVWUJVWUGwAFIxvE14AKwVWUJVWUGwA2048vs2IY020E87I2jVAFwI0_Jryl82xGYIkIc2
        x26xkF7I0E14v26r4j6ryUM28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8wA2z4x0
        Y4vE2Ix0cI8IcVAFwI0_tr0E3s1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Cr1j6rxdM2
        8EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I0E14v26rxl6s0DM2AI
        xVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjxv20x
        vE14v26r106r15McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xv
        r2IYc2Ij64vIr41lF7I21c0EjII2zVCS5cI20VAGYxC7MxAIw28IcxkI7VAKI48JMxC20s
        026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_
        JrI_JrWlx4CE17CEb7AF67AKxVWUAVWUtwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14
        v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxVW8JVWxJwCI42IY6xAIw20EY4v20xva
        j40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxVW8JV
        W8JrUvcSsGvfC2KfnxnUUI43ZEXa7VUjJKsUUUUUU==
X-CM-SenderInfo: p1hex046kxt4xhlfz01xgou0bp/
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ye Bin <yebin10@huawei.com>

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

Signed-off-by: Ye Bin <yebin10@huawei.com>
---
 kernel/trace/blktrace.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/kernel/trace/blktrace.c b/kernel/trace/blktrace.c
index 50b6f241b5f7..e17bba027a2c 100644
--- a/kernel/trace/blktrace.c
+++ b/kernel/trace/blktrace.c
@@ -379,6 +379,7 @@ static int blk_trace_stop(struct blk_trace *bt)
 
 static void blk_trace_cleanup(struct request_queue *q, struct blk_trace *bt)
 {
+	blk_trace_stop(bt);
 	synchronize_rcu();
 	blk_trace_free(q, bt);
 	put_probe_ref();
@@ -393,8 +394,7 @@ static int __blk_trace_remove(struct request_queue *q)
 	if (!bt)
 		return -EINVAL;
 
-	if (bt->trace_state != Blktrace_running)
-		blk_trace_cleanup(q, bt);
+	blk_trace_cleanup(q, bt);
 
 	return 0;
 }
-- 
2.31.1

