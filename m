Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 088996006C2
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Oct 2022 08:31:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230179AbiJQGbg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Oct 2022 02:31:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43918 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230080AbiJQGbV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Oct 2022 02:31:21 -0400
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3BA935724C;
        Sun, 16 Oct 2022 23:31:19 -0700 (PDT)
Received: from canpemm500010.china.huawei.com (unknown [172.30.72.56])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4MrRrK3l3lzpWGt;
        Mon, 17 Oct 2022 14:28:01 +0800 (CST)
Received: from huawei.com (10.175.127.227) by canpemm500010.china.huawei.com
 (7.192.105.118) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.31; Mon, 17 Oct
 2022 14:31:17 +0800
From:   Ye Bin <yebin10@huawei.com>
To:     <axboe@kernel.dk>, <rostedt@goodmis.org>, <mhiramat@kernel.org>,
        <linux-block@vger.kernel.org>
CC:     <linux-kernel@vger.kernel.org>, Ye Bin <yebin10@huawei.com>
Subject: [PATCH -next 2/3] blktrace: fix possible memleak in '__blk_trace_remove'
Date:   Mon, 17 Oct 2022 14:53:20 +0800
Message-ID: <20221017065321.2846017-3-yebin10@huawei.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20221017065321.2846017-1-yebin10@huawei.com>
References: <20221017065321.2846017-1-yebin10@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.127.227]
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 canpemm500010.china.huawei.com (7.192.105.118)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
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

To solve above issues, reference commit '5afedf670caf', first stop block trace
when block trace state is 'Blktrace_running' in '__blk_trace_remove'.

Signed-off-by: Ye Bin <yebin10@huawei.com>
---
 kernel/trace/blktrace.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/kernel/trace/blktrace.c b/kernel/trace/blktrace.c
index edd83e213580..0d93a0110ab5 100644
--- a/kernel/trace/blktrace.c
+++ b/kernel/trace/blktrace.c
@@ -395,8 +395,10 @@ static int __blk_trace_remove(struct request_queue *q)
 	if (!bt)
 		return -EINVAL;
 
-	if (bt->trace_state != Blktrace_running)
-		blk_trace_cleanup(q, bt);
+	if (bt->trace_state == Blktrace_running)
+		blk_trace_switch_state(bt, 0);
+
+	blk_trace_cleanup(q, bt);
 
 	return 0;
 }
-- 
2.31.1

