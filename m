Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 12B0D60387D
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Oct 2022 05:14:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229850AbiJSDOL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Oct 2022 23:14:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44428 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229903AbiJSDOF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Oct 2022 23:14:05 -0400
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7677FA8340;
        Tue, 18 Oct 2022 20:14:02 -0700 (PDT)
Received: from mail02.huawei.com (unknown [172.30.67.153])
        by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4MsbNn5rq3zKFw9;
        Wed, 19 Oct 2022 11:11:37 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.127.227])
        by APP4 (Coremail) with SMTP id gCh0CgDnLS53a09jvmtUAA--.10775S5;
        Wed, 19 Oct 2022 11:14:00 +0800 (CST)
From:   Ye Bin <yebin@huaweicloud.com>
To:     axboe@kernel.dk, rostedt@goodmis.org, mhiramat@kernel.org,
        linux-block@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, yebin@huaweicloud.com,
        Ye Bin <yebin10@huawei.com>
Subject: [PATCH v3 1/3] blktrace: introduce 'blk_trace_{start,stop}' helper
Date:   Wed, 19 Oct 2022 11:36:00 +0800
Message-Id: <20221019033602.752383-2-yebin@huaweicloud.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20221019033602.752383-1-yebin@huaweicloud.com>
References: <20221019033602.752383-1-yebin@huaweicloud.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: gCh0CgDnLS53a09jvmtUAA--.10775S5
X-Coremail-Antispam: 1UD129KBjvJXoWxuryUKw1fGryfAFyrZry8Grg_yoW5Zw4rpF
        WagrZxKr47Zr40qay09rnxur15K34Yq3y2yr98CF4fJF1Dt345Wr12vryvvF4jyayvyrW3
        Cw1jvFsrCr4Uu3DanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUU9v14x267AKxVW5JVWrJwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
        rVWUJVWUGwAFIxvE14AKwVWUJVWUGwA2048vs2IY020E87I2jVAFwI0_Jr4l82xGYIkIc2
        x26xkF7I0E14v26r1I6r4UM28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8wA2z4x0
        Y4vE2Ix0cI8IcVAFwI0_tr0E3s1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Cr1j6rxdM2
        8EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I0E14v26rxl6s0DM2AI
        xVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjxv20x
        vE14v26r106r15McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xv
        r2IYc2Ij64vIr41lF7I21c0EjII2zVCS5cI20VAGYxC7MxAIw28IcxkI7VAKI48JMxC20s
        026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_
        JrI_JrWlx4CE17CEb7AF67AKxVWUAVWUtwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14
        v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxVW8JVWxJwCI42IY6xAIw20EY4v20xva
        j40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxVW8JV
        W8JrUvcSsGvfC2KfnxnUUI43ZEXa7VUbLFxUUUUUU==
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

Introduce 'blk_trace_{start,stop}' helper. No functional changed.

Signed-off-by: Ye Bin <yebin10@huawei.com>
---
 kernel/trace/blktrace.c | 74 ++++++++++++++++++++---------------------
 1 file changed, 36 insertions(+), 38 deletions(-)

diff --git a/kernel/trace/blktrace.c b/kernel/trace/blktrace.c
index 7f5eb295fe19..50b6f241b5f7 100644
--- a/kernel/trace/blktrace.c
+++ b/kernel/trace/blktrace.c
@@ -346,6 +346,37 @@ static void put_probe_ref(void)
 	mutex_unlock(&blk_probe_mutex);
 }
 
+static int blk_trace_start(struct blk_trace *bt)
+{
+	if (bt->trace_state != Blktrace_setup &&
+	    bt->trace_state != Blktrace_stopped)
+		return -EINVAL;
+
+	blktrace_seq++;
+	smp_mb();
+	bt->trace_state = Blktrace_running;
+	raw_spin_lock_irq(&running_trace_lock);
+	list_add(&bt->running_list, &running_trace_list);
+	raw_spin_unlock_irq(&running_trace_lock);
+	trace_note_time(bt);
+
+	return 0;
+}
+
+static int blk_trace_stop(struct blk_trace *bt)
+{
+	if (bt->trace_state != Blktrace_running)
+		return -EINVAL;
+
+	bt->trace_state = Blktrace_stopped;
+	raw_spin_lock_irq(&running_trace_lock);
+	list_del_init(&bt->running_list);
+	raw_spin_unlock_irq(&running_trace_lock);
+	relay_flush(bt->rchan);
+
+	return 0;
+}
+
 static void blk_trace_cleanup(struct request_queue *q, struct blk_trace *bt)
 {
 	synchronize_rcu();
@@ -658,7 +689,6 @@ static int compat_blk_trace_setup(struct request_queue *q, char *name,
 
 static int __blk_trace_startstop(struct request_queue *q, int start)
 {
-	int ret;
 	struct blk_trace *bt;
 
 	bt = rcu_dereference_protected(q->blk_trace,
@@ -666,36 +696,10 @@ static int __blk_trace_startstop(struct request_queue *q, int start)
 	if (bt == NULL)
 		return -EINVAL;
 
-	/*
-	 * For starting a trace, we can transition from a setup or stopped
-	 * trace. For stopping a trace, the state must be running
-	 */
-	ret = -EINVAL;
-	if (start) {
-		if (bt->trace_state == Blktrace_setup ||
-		    bt->trace_state == Blktrace_stopped) {
-			blktrace_seq++;
-			smp_mb();
-			bt->trace_state = Blktrace_running;
-			raw_spin_lock_irq(&running_trace_lock);
-			list_add(&bt->running_list, &running_trace_list);
-			raw_spin_unlock_irq(&running_trace_lock);
-
-			trace_note_time(bt);
-			ret = 0;
-		}
-	} else {
-		if (bt->trace_state == Blktrace_running) {
-			bt->trace_state = Blktrace_stopped;
-			raw_spin_lock_irq(&running_trace_lock);
-			list_del_init(&bt->running_list);
-			raw_spin_unlock_irq(&running_trace_lock);
-			relay_flush(bt->rchan);
-			ret = 0;
-		}
-	}
-
-	return ret;
+	if (start)
+		return blk_trace_start(bt);
+	else
+		return blk_trace_stop(bt);
 }
 
 int blk_trace_startstop(struct request_queue *q, int start)
@@ -1614,13 +1618,7 @@ static int blk_trace_remove_queue(struct request_queue *q)
 	if (bt == NULL)
 		return -EINVAL;
 
-	if (bt->trace_state == Blktrace_running) {
-		bt->trace_state = Blktrace_stopped;
-		raw_spin_lock_irq(&running_trace_lock);
-		list_del_init(&bt->running_list);
-		raw_spin_unlock_irq(&running_trace_lock);
-		relay_flush(bt->rchan);
-	}
+	blk_trace_stop(bt);
 
 	put_probe_ref();
 	synchronize_rcu();
-- 
2.31.1

