Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A1BD0702CBB
	for <lists+linux-kernel@lfdr.de>; Mon, 15 May 2023 14:30:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241835AbjEOMap (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 May 2023 08:30:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54866 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240917AbjEOMam (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 May 2023 08:30:42 -0400
X-Greylist: delayed 642 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Mon, 15 May 2023 05:30:40 PDT
Received: from mail-m2836.qiye.163.com (mail-m2836.qiye.163.com [103.74.28.36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E8D0E19C
        for <linux-kernel@vger.kernel.org>; Mon, 15 May 2023 05:30:40 -0700 (PDT)
Received: from ubuntu.localdomain (unknown [36.170.45.137])
        by mail-m2836.qiye.163.com (Hmail) with ESMTPA id 796BFC0237;
        Mon, 15 May 2023 20:19:54 +0800 (CST)
From:   Yu Chen <chen.yu@easystack.cn>
To:     minyard@acm.org
Cc:     openipmi-developer@lists.sourceforge.net,
        linux-kernel@vger.kernel.org, chen.yu@easystack.cn
Subject: [PATCH] watchdog: Avoid 100% CPU usage during reading watchdog when a task get signal
Date:   Mon, 15 May 2023 05:19:41 -0700
Message-Id: <20230515121941.59859-1-chen.yu@easystack.cn>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
        tZV1koWUFJQjdXWS1ZQUlXWQ8JGhUIEh9ZQVkZHRkeVhpIQk0YS0xNTU5KSlUZERMWGhIXJBQOD1
        lXWRgSC1lBWUhNVUpMS1VPTlVKSExZV1kWGg8SFR0UWUFZT0tIVUpKS0hKQ1VKS0tVS1kG
X-HM-Tid: 0a881f5a58b1841ekuqw796bfc0237
X-HM-MType: 1
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6MC46EBw6SzJPNxxIDz0MARYR
        NRUaCi5VSlVKTUNPSk5ISkJOSU9LVTMWGhIXVRgTHhVVAg47HhoIAggPGhgQVRgVRVlXWRILWUFZ
        SE1VSkxLVU9OVUpITFlXWQgBWUFIS0pKNwY+
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

A simple reproducer demonstrating the problem: (use ipmi_watchdog.ko)

In one terminal:

$ cat /dev/watchdog
...

In another terminal:

$ ps -aux | grep cat
14755 pts/1    R+    43:00 cat /dev/watchdog
51943 pts/2    S+     0:00 grep --color=auto cat

$ kill -9 14755
$
$ cat /proc/14755/status | grep SigPnd
SigPnd: 0000000000000100
$
$ top

Tasks: 1049 total,   2 running, 1047 sleeping,   0 stopped,   0 zombie
%Cpu(s): 0.0 us, 1.0 sy, 0.0 ni, 98.9 id, 0.0 wa, 0.0 hi, 0.0 si, 0.0 st
MiB Mem : 522594.8 total, 517241.4 free,  2922.1 used,   2431.2 buff/cache
MiB Swap:      0.0 total,      0.0 free,     0.0 used. 516589.2 avail Mem

PID USER    PR  NI    VIRT    RES    SHR S  %CPU  %MEM  TIME+ COMMAND
14755 root  20   0  215552   1024    576 R 100.0  0.0  0:15.12 cat
53417 root  20   0  224960   7040   3648 R   0.7  0.0  0:00.10 top
11 root     20   0       0      0      0 I   0.3  0.0  0:02.85 rcu_sched
1772 root   20   0  512256 387776 380800 S   0.3  0.1  0:32.05 python

We can see that when the cat process gets the signal, the CPU usage
is 100%, Since signal_pending is true, the pick_next_task function
in schedule always returns itself, it retries schedule indefinitely.
ipmi_read() will busyloop.

Signed-off-by: Yu Chen <chen.yu@easystack.cn>
---
 drivers/char/ipmi/ipmi_watchdog.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/drivers/char/ipmi/ipmi_watchdog.c b/drivers/char/ipmi/ipmi_watchdog.c
index 0d4a8dcac..173ed4266 100644
--- a/drivers/char/ipmi/ipmi_watchdog.c
+++ b/drivers/char/ipmi/ipmi_watchdog.c
@@ -803,6 +803,11 @@ static ssize_t ipmi_read(struct file *file,
 		init_waitqueue_entry(&wait, current);
 		add_wait_queue(&read_q, &wait);
 		while (!data_to_read) {
+			if (signal_pending(current)) {
+				remove_wait_queue(&read_q, &wait);
+				rv = -ERESTARTSYS;
+				goto out;
+			}
 			set_current_state(TASK_INTERRUPTIBLE);
 			spin_unlock_irq(&ipmi_read_lock);
 			schedule();
@@ -810,10 +815,6 @@ static ssize_t ipmi_read(struct file *file,
 		}
 		remove_wait_queue(&read_q, &wait);
 
-		if (signal_pending(current)) {
-			rv = -ERESTARTSYS;
-			goto out;
-		}
 	}
 	data_to_read = 0;
 
-- 
2.27.0

