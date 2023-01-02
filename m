Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7591F65AF73
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Jan 2023 11:19:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232027AbjABKTU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Jan 2023 05:19:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40506 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232032AbjABKTR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Jan 2023 05:19:17 -0500
Received: from zju.edu.cn (spam.zju.edu.cn [61.164.42.155])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id CE458FE0
        for <linux-kernel@vger.kernel.org>; Mon,  2 Jan 2023 02:19:15 -0800 (PST)
Received: from localhost.localdomain (unknown [10.12.77.33])
        by mail-app2 (Coremail) with SMTP id by_KCgD3_fWfr7Jj3v2PCQ--.15715S4;
        Mon, 02 Jan 2023 18:19:11 +0800 (CST)
From:   Lin Ma <linma@zju.edu.cn>
To:     jan.kiszka@siemens.com, kbingham@kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Lin Ma <linma@zju.edu.cn>
Subject: [PATCH v3] scripts/gdb: fix 'lx-timerlist' on newer kernel
Date:   Mon,  2 Jan 2023 18:19:11 +0800
Message-Id: <20230102101911.12765-1-linma@zju.edu.cn>
X-Mailer: git-send-email 2.17.1
X-CM-TRANSID: by_KCgD3_fWfr7Jj3v2PCQ--.15715S4
X-Coremail-Antispam: 1UD129KBjvJXoW7ZFW5JFW3KF48XF4rur4rKrg_yoW5JrW7pr
        W5CFWakFs7tr4Fg39Fq3WIgr13Ga1vyrWfXFWDKFs8Ar9rG3y8Way2kFy5tFy7uFnIv39x
        G39Yvwn8JF4UArJanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUkI1xkIjI8I6I8E6xAIw20EY4v20xvaj40_Wr0E3s1l1IIY67AE
        w4v_Jr0_Jr4l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0rcxSw2x7M28EF7xvwVC0I7IYx2
        IY67AKxVWDJVCq3wA2z4x0Y4vE2Ix0cI8IcVCY1x0267AKxVWxJVW8Jr1l84ACjcxK6I8E
        87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_GcCE3s1le2I262IYc4CY6c
        8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E2Ix0cI8IcVAFwI0_Jr0_
        Jr4lYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE7xkEbVWUJVW8JwACjcxG0xvY0x0EwI
        xGrwACjI8F5VA0II8E6IAqYI8I648v4I1l42xK82IYc2Ij64vIr41l42xK82IY6x8ErcxF
        aVAv8VW8uw4UJr1UMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr
        4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUAVWUtwCIc40Y0x0EwIxG
        rwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxVWUJVW8Jw
        CI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2
        z280aVCY1x0267AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa7VUbXdbUUUUUU==
X-CM-SenderInfo: qtrwiiyqvtljo62m3hxhgxhubq/
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

After commit 511885d7061e ("lib/timerqueue: Rely on rbtree semantics for
next timer"), the struct timerqueue_head changes the internal field hence
causes the old lx-timerlist command keeps reporting errors.

This fix adds a simple version comparison and necessary code for
traversing timerqueue on a newer kernel. Moreover, it fixes some
python 3.X compatibility bugs.

Test with python 2.7 and python 3.6
Test with gdb 10.2

Signed-off-by: Lin Ma <linma@zju.edu.cn>
---
V1->V2: remove the support of old versions, fix typo and adjust the
        commit message
V2->V3: remove redundant re package
 scripts/gdb/linux/timerlist.py | 13 +++++++------
 1 file changed, 7 insertions(+), 6 deletions(-)

diff --git a/scripts/gdb/linux/timerlist.py b/scripts/gdb/linux/timerlist.py
index 071d0dd5a634..85072be2a196 100644
--- a/scripts/gdb/linux/timerlist.py
+++ b/scripts/gdb/linux/timerlist.py
@@ -43,8 +43,10 @@ def print_timer(rb_node, idx):
 
 
 def print_active_timers(base):
-    curr = base['active']['next']['node']
-    curr = curr.address.cast(rbtree.rb_node_type.get_type().pointer())
+    # 511885d7061e ("lib/timerqueue: Rely on rbtree semantics for next timer")
+    leftmost = base['active']['rb_root']['rb_leftmost']
+    curr = leftmost.cast(rbtree.rb_node_type.get_type().pointer())
+
     idx = 0
     while curr:
         yield print_timer(curr, idx)
@@ -73,10 +75,9 @@ def print_cpu(hrtimer_bases, cpu, max_clock_bases):
     ts = cpus.per_cpu(tick_sched_ptr, cpu)
 
     text = "cpu: {}\n".format(cpu)
-    for i in xrange(max_clock_bases):
+    for i in range(max_clock_bases):
         text += " clock {}:\n".format(i)
         text += print_base(cpu_base['clock_base'][i])
-
         if constants.LX_CONFIG_HIGH_RES_TIMERS:
             fmts = [("  .{}   : {} nsecs", 'expires_next'),
                     ("  .{}    : {}", 'hres_active'),
@@ -165,7 +166,7 @@ def pr_cpumask(mask):
         i -= 1
         start = i * 2
         end = start + 2
-        chunks.append(buf[start:end])
+        chunks.append(str(buf[start:end]))
         if i != 0 and i % 4 == 0:
             chunks.append(',')
 
@@ -184,7 +185,7 @@ class LxTimerList(gdb.Command):
 
     def invoke(self, arg, from_tty):
         hrtimer_bases = gdb.parse_and_eval("&hrtimer_bases")
-        max_clock_bases = gdb.parse_and_eval("HRTIMER_MAX_CLOCK_BASES")
+        max_clock_bases = gdb.parse_and_eval("(int)HRTIMER_MAX_CLOCK_BASES")
 
         text = "Timer List Version: gdb scripts\n"
         text += "HRTIMER_MAX_CLOCK_BASES: {}\n".format(max_clock_bases)
-- 
2.17.1

