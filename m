Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 774CD65ADC4
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Jan 2023 08:43:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229764AbjABHnv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Jan 2023 02:43:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37370 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229447AbjABHnt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Jan 2023 02:43:49 -0500
Received: from zju.edu.cn (spam.zju.edu.cn [61.164.42.155])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 253C91121
        for <linux-kernel@vger.kernel.org>; Sun,  1 Jan 2023 23:43:46 -0800 (PST)
Received: from localhost.localdomain (unknown [10.12.77.33])
        by mail-app3 (Coremail) with SMTP id cC_KCgB3Xagsi7Jj6Xt5Cw--.5552S4;
        Mon, 02 Jan 2023 15:43:40 +0800 (CST)
From:   Lin Ma <linma@zju.edu.cn>
To:     jan.kiszka@siemens.com, kbingham@kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Lin Ma <linma@zju.edu.cn>
Subject: [PATCH] scripts/gdb: fix 'lx-timerlist' on newer kernel
Date:   Mon,  2 Jan 2023 15:43:40 +0800
Message-Id: <20230102074340.17459-1-linma@zju.edu.cn>
X-Mailer: git-send-email 2.17.1
X-CM-TRANSID: cC_KCgB3Xagsi7Jj6Xt5Cw--.5552S4
X-Coremail-Antispam: 1UD129KBjvJXoWxur45CFW3WFW7trWkJry5Jwb_yoWrCr4Up3
        y5CFW3KrZ7tr1fKayfJ3Wvgry5JanYyr4aqF90krs0yr17W3y09a17KFy5tFy7G3W2vay3
        K3s5Z3W5CF4jyrJanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUkI1xkIjI8I6I8E6xAIw20EY4v20xvaj40_Wr0E3s1l1IIY67AE
        w4v_Jr0_Jr4l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0rcxSw2x7M28EF7xvwVC0I7IYx2
        IY67AKxVWDJVCq3wA2z4x0Y4vE2Ix0cI8IcVCY1x0267AKxVW8Jr0_Cr1UM28EF7xvwVC2
        z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I0E14v26rxl6s0DM2AIxVAIcxkEcV
        Aq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r1j
        6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IYc2Ij64
        vIr41lF7I21c0EjII2zVCS5cI20VAGYxC7MxAIw28IcxkI7VAKI48JMxAIw28IcVCjz48v
        1sIEY20_GFWkJr1UJwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14v26r1j6r
        18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_JF0_Jw1lIxkGc2Ij64vI
        r41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Jr0_Gr
        1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvE
        x4A2jsIEc7CjxVAFwI0_Jr0_GrUvcSsGvfC2KfnxnUUI43ZEXa7VUbXdbUUUUUU==
X-CM-SenderInfo: qtrwiiyqvtljo62m3hxhgxhubq/
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

After commit 511885d7061e ("lib/timerqueue: Rely on rbtree semantics for
next timer"), the struct timerqueue_head changes internal field hence
causes the old lx-timerlist command keeps reporting errors.

This fix addes a simple version comparison and necessary code for
traversing timerqueue on a newer kernel. Moreover, it fixes some
python 3.X compatibility bugs.

Test with python 2.7 and python 3.6
Test with 
* commit 442284a89a65 ("scripts/gdb: add a timer list command") and 
* commit 88603b6dc419 ("Linux 6.2-rc2") kernel

Signed-off-by: Lin Ma <linma@zju.edu.cn>
---
 scripts/gdb/linux/timerlist.py | 41 ++++++++++++++++++++++------------
 1 file changed, 27 insertions(+), 14 deletions(-)

diff --git a/scripts/gdb/linux/timerlist.py b/scripts/gdb/linux/timerlist.py
index 071d0dd5a634..65d035df253d 100644
--- a/scripts/gdb/linux/timerlist.py
+++ b/scripts/gdb/linux/timerlist.py
@@ -4,6 +4,7 @@
 
 import binascii
 import gdb
+import re
 
 from linux import constants
 from linux import cpus
@@ -42,9 +43,15 @@ def print_timer(rb_node, idx):
     return text
 
 
-def print_active_timers(base):
-    curr = base['active']['next']['node']
-    curr = curr.address.cast(rbtree.rb_node_type.get_type().pointer())
+def print_active_timers(base, oldver):
+    # 511885d7061e ("lib/timerqueue: Rely on rbtree semantics for next timer")
+    if oldver:
+        curr = base['active']['next']['node']
+        curr = curr.address.cast(rbtree.rb_node_type.get_type().pointer())
+    else:
+        leftmost = base['active']['rb_root']['rb_leftmost']
+        curr = leftmost.cast(rbtree.rb_node_type.get_type().pointer())
+
     idx = 0
     while curr:
         yield print_timer(curr, idx)
@@ -52,7 +59,7 @@ def print_active_timers(base):
         idx += 1
 
 
-def print_base(base):
+def print_base(base, oldver):
     text = " .base:       {}\n".format(base.address)
     text += " .index:      {}\n".format(base['index'])
 
@@ -62,21 +69,20 @@ def print_base(base):
     if constants.LX_CONFIG_HIGH_RES_TIMERS:
         text += "  .offset:     {} nsecs\n".format(base['offset'])
     text += "active timers:\n"
-    text += "".join([x for x in print_active_timers(base)])
+    text += "".join([x for x in print_active_timers(base, oldver)])
     return text
 
 
-def print_cpu(hrtimer_bases, cpu, max_clock_bases):
+def print_cpu(hrtimer_bases, cpu, max_clock_bases, oldver):
     cpu_base = cpus.per_cpu(hrtimer_bases, cpu)
     jiffies = gdb.parse_and_eval("jiffies_64")
     tick_sched_ptr = gdb.parse_and_eval("&tick_cpu_sched")
     ts = cpus.per_cpu(tick_sched_ptr, cpu)
 
     text = "cpu: {}\n".format(cpu)
-    for i in xrange(max_clock_bases):
+    for i in range(max_clock_bases):
         text += " clock {}:\n".format(i)
-        text += print_base(cpu_base['clock_base'][i])
-
+        text += print_base(cpu_base['clock_base'][i], oldver)
         if constants.LX_CONFIG_HIGH_RES_TIMERS:
             fmts = [("  .{}   : {} nsecs", 'expires_next'),
                     ("  .{}    : {}", 'hres_active'),
@@ -165,7 +171,7 @@ def pr_cpumask(mask):
         i -= 1
         start = i * 2
         end = start + 2
-        chunks.append(buf[start:end])
+        chunks.append(str(buf[start:end]))
         if i != 0 and i % 4 == 0:
             chunks.append(',')
 
@@ -184,14 +190,21 @@ class LxTimerList(gdb.Command):
 
     def invoke(self, arg, from_tty):
         hrtimer_bases = gdb.parse_and_eval("&hrtimer_bases")
-        max_clock_bases = gdb.parse_and_eval("HRTIMER_MAX_CLOCK_BASES")
-
-        text = "Timer List Version: gdb scripts\n"
+        max_clock_bases = gdb.parse_and_eval("(int)HRTIMER_MAX_CLOCK_BASES")
+        banner = gdb.parse_and_eval("(char *)linux_banner").string()
+        r = re.match(r"^Linux version (.+) \(.*@.*$", banner)
+        if not r:
+            gdb.write("failed to load image version")
+            return
+        lver = r.group(1)
+        oldver = lver < '5.3.0-rc1'
+
+        text = "Timer List Version: gdb scripts, old version: {}\n".format(oldver)
         text += "HRTIMER_MAX_CLOCK_BASES: {}\n".format(max_clock_bases)
         text += "now at {} nsecs\n".format(ktime_get())
 
         for cpu in cpus.each_online_cpu():
-            text += print_cpu(hrtimer_bases, cpu, max_clock_bases)
+            text += print_cpu(hrtimer_bases, cpu, max_clock_bases, oldver)
 
         if constants.LX_CONFIG_GENERIC_CLOCKEVENTS:
             if constants.LX_CONFIG_GENERIC_CLOCKEVENTS_BROADCAST:
-- 
2.17.1

