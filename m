Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 29342602E7D
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Oct 2022 16:29:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231500AbiJRO3z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Oct 2022 10:29:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42104 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231512AbiJRO3m (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Oct 2022 10:29:42 -0400
Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B0F218E3D;
        Tue, 18 Oct 2022 07:29:40 -0700 (PDT)
Received: from mail02.huawei.com (unknown [172.30.67.153])
        by dggsgout12.his.huawei.com (SkyGuard) with ESMTP id 4MsGQt0HWfz6Pmmb;
        Tue, 18 Oct 2022 22:27:18 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.127.227])
        by APP4 (Coremail) with SMTP id gCh0CgBHWTBRuE5jkSo6AA--.18765S5;
        Tue, 18 Oct 2022 22:29:38 +0800 (CST)
From:   Ye Bin <yebin@huaweicloud.com>
To:     axboe@kernel.dk, rostedt@goodmis.org, mhiramat@kernel.org,
        linux-block@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, yebin@huaweicloud.com
Subject: [PATCH v2 1/3] blktrace: introduce 'blk_trace_{start,stop}' helper
Date:   Tue, 18 Oct 2022 22:51:33 +0800
Message-Id: <20221018145135.932240-2-yebin@huaweicloud.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20221018145135.932240-1-yebin@huaweicloud.com>
References: <20221018145135.932240-1-yebin@huaweicloud.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: gCh0CgBHWTBRuE5jkSo6AA--.18765S5
X-Coremail-Antispam: 1UD129KBjvJXoWxuryUKw1UXFyfJrW8uFW7urg_yoW5uw13pF
        WagrZ0kr47Zr40qayv9rnxur15K3s0q3y2yr98Ca1fJF1Dt345Wr12vFyvvF4jy3yvyrW3
        Cw1jvF47Cr4Uu3DanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUU9m14x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
        rVWUJVWUGwAFIxvE14AKwVWUJVWUGwA2048vs2IY020E87I2jVAFwI0_Jr4l82xGYIkIc2
        x26xkF7I0E14v26r1I6r4UM28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8wA2z4x0
        Y4vE2Ix0cI8IcVAFwI0_tr0E3s1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Gr1j6F4UJw
        A2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x0267AKxVW0oVCq3wAS
        0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7IYx2
        IY67AKxVWUGVWUXwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0
        Y48IcxkI7VAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwCF04k20xvY0x0EwIxGrwCFx2
        IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v2
        6r106r1rMI8E67AF67kF1VAFwI0_JF0_Jw1lIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67
        AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Gr0_Cr1lIxAIcVCF04k26cxKx2IY
        s7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr
        0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x0JUlPfdUUUUU=
X-CM-SenderInfo: p1hex046kxt4xhlfz01xgou0bp/
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Introduce 'blk_trace_{start,stop}' helper. No functional changed.

Signed-off-by: Ye Bin <yebin@huaweicloud.com>
---
 kernel/trace/blktrace.c | 82 ++++++++++++++++++++++-------------------
 1 file changed, 44 insertions(+), 38 deletions(-)

diff --git a/kernel/trace/blktrace.c b/kernel/trace/blktrace.c
index 7f5eb295fe19..f07a03c1e052 100644
--- a/kernel/trace/blktrace.c
+++ b/kernel/trace/blktrace.c
@@ -346,6 +346,45 @@ static void put_probe_ref(void)
 	mutex_unlock(&blk_probe_mutex);
 }
 
+static int blk_trace_start(struct blk_trace *bt)
+{
+	/*
+	 * For starting a trace, we can transition from a setup or stopped
+	 * trace.
+	 */
+	if (bt->trace_state == Blktrace_setup ||
+	    bt->trace_state == Blktrace_stopped) {
+		blktrace_seq++;
+		smp_mb();
+		bt->trace_state = Blktrace_running;
+		raw_spin_lock_irq(&running_trace_lock);
+		list_add(&bt->running_list, &running_trace_list);
+		raw_spin_unlock_irq(&running_trace_lock);
+
+		trace_note_time(bt);
+		return 0;
+	}
+
+	return -EINVAL;
+}
+
+static int blk_trace_stop(struct blk_trace *bt)
+{
+	/*
+	 * For stopping a trace, the state must be running
+	 */
+	if (bt->trace_state == Blktrace_running) {
+		bt->trace_state = Blktrace_stopped;
+		raw_spin_lock_irq(&running_trace_lock);
+		list_del_init(&bt->running_list);
+		raw_spin_unlock_irq(&running_trace_lock);
+		relay_flush(bt->rchan);
+		return 0;
+	}
+
+	return -EINVAL;
+}
+
 static void blk_trace_cleanup(struct request_queue *q, struct blk_trace *bt)
 {
 	synchronize_rcu();
@@ -658,7 +697,6 @@ static int compat_blk_trace_setup(struct request_queue *q, char *name,
 
 static int __blk_trace_startstop(struct request_queue *q, int start)
 {
-	int ret;
 	struct blk_trace *bt;
 
 	bt = rcu_dereference_protected(q->blk_trace,
@@ -666,36 +704,10 @@ static int __blk_trace_startstop(struct request_queue *q, int start)
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
@@ -1614,13 +1626,7 @@ static int blk_trace_remove_queue(struct request_queue *q)
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

