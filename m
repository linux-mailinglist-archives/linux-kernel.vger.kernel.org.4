Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DAE4A67FC99
	for <lists+linux-kernel@lfdr.de>; Sun, 29 Jan 2023 04:14:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234675AbjA2DOO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 28 Jan 2023 22:14:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40516 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229513AbjA2DOL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 28 Jan 2023 22:14:11 -0500
Received: from mail-pg1-x536.google.com (mail-pg1-x536.google.com [IPv6:2607:f8b0:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E2841B6;
        Sat, 28 Jan 2023 19:14:10 -0800 (PST)
Received: by mail-pg1-x536.google.com with SMTP id g68so5534892pgc.11;
        Sat, 28 Jan 2023 19:14:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CZWIfOEaYPhJKU3uAxkJJryS3uLGTPx1f0G7P/O8xfA=;
        b=WNpfUUtjioQ7kbQwRs/e5HS06UBNyLnUU0Z2Dqk6FvQXeD+YPMQ0e/7WbavugqWBM7
         vV9QWqu3mzPmSWNoKc+1MB416Cf7pgoK79SLKEXJyKnrFBGr4T2gcL//iutBQRQHro3u
         3Z14uzkYY71/OxXqz14+KUhYBrSOIuELkL7Pj70hkSANuG9dxnAqyJeeenMc91n5XJ8d
         wtdFzTI/Dqs9Az60aiA4d3NVMZNOohY8ibEdbaZEbj9QeGnDvdCt7Gp5ASMNkm6pyRmd
         U/zmJcUwUxUgUlSSuKOBAPEotuVdwsI2mt3L0djcAuNumJ84jO22eVsf05WXkJGTT3vj
         4ukA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CZWIfOEaYPhJKU3uAxkJJryS3uLGTPx1f0G7P/O8xfA=;
        b=poYtGzNfocDn98jUqQFF0aB86E33q7ZHGlkL3q3kb8eFke+fqKjNnhMiz0+YRUHxde
         jxmztf7S8aZgAKuuMdduP/nQbmCK3TckcnTPB1feBdhgwZFWmBwjYiAouNijVQB+ztI2
         iKXBOg4FkcF8/ukG4wOhthpfYoB+rI3r/IDLzDNsSkQZWCVpYS5umWl8OeHrgT3VOQHq
         0K5ERW2EmlYQzunhuEwPUnFTuZLPm97722ReLCgFy52tFqvMaSGSH0h1rZk12S29SINE
         ynn1INvpaoG+2MecY1Ypvl3zly5HtZNfocqLyMfLC+jXBbxTne3RSTD3L5ySI0s3CEKn
         8LfQ==
X-Gm-Message-State: AO0yUKVc3t68IDByAlbzPQKQS45h+2rkVbZ5UnNDIWQuoDFkrNE0FjoR
        Hny80tPnwYsKANFYMIv+XlM=
X-Google-Smtp-Source: AK7set8It5HDkuU/IH+p/AnTbUXdQClIONT4vEI41tjUgkq31bcodnJSex2RmdNoFV0piIjoj0hEBQ==
X-Received: by 2002:a05:6a00:2301:b0:593:98cb:e6f6 with SMTP id h1-20020a056a00230100b0059398cbe6f6mr3557449pfh.9.1674962049726;
        Sat, 28 Jan 2023 19:14:09 -0800 (PST)
Received: from debian.me (subs03-180-214-233-76.three.co.id. [180.214.233.76])
        by smtp.gmail.com with ESMTPSA id s23-20020a056a00179700b0058a0e61136asm4932972pfg.66.2023.01.28.19.14.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 28 Jan 2023 19:14:09 -0800 (PST)
Received: by debian.me (Postfix, from userid 1000)
        id 2D27C1030A1; Sun, 29 Jan 2023 10:14:04 +0700 (WIB)
From:   Bagas Sanjaya <bagasdotme@gmail.com>
To:     linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
        linux-doc@vger.kernel.org, oe-kbuild-all@lists.linux.dev
Cc:     Steven Rostedt <rostedt@goodmis.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        kernel test robot <lkp@intel.com>
Subject: [PATCH] tracing/histogram: Wrap remaining shell snippets in code blocks
Date:   Sun, 29 Jan 2023 10:14:02 +0700
Message-Id: <20230129031402.47420-1-bagasdotme@gmail.com>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <202301290253.LU5yIxcJ-lkp@intel.com>
References: <202301290253.LU5yIxcJ-lkp@intel.com>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=9477; i=bagasdotme@gmail.com; h=from:subject; bh=eozoBhTf5UehsPlfrwO8Lxlu62cib0XpQG2AKe/JQHA=; b=owGbwMvMwCX2bWenZ2ig32LG02pJDMlXn5RkFWoGmWhlvHDZNeFA2Z/g3vrElVbxT2Sn5fXW5n8J DOPpKGVhEONikBVTZJmUyNd0epeRyIX2tY4wc1iZQIYwcHEKwESMBBgZXu+RKsv54vv1iXEtW3SjgH zI4hUz/zrdVDvnmf/w9O5rqgx/eBzihX/vNN58/kaiCsPp9G0mF5MPbLyrblDPEzad0f4RPwA=
X-Developer-Key: i=bagasdotme@gmail.com; a=openpgp; fpr=701B806FDCA5D3A58FFB8F7D7C276C64A5E44A1D
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,RCVD_IN_SORBS_WEB,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Most shell command snippets (echo/cat) and their output are already in
literal code blocks. However a few still isn't wrapped, in which the
htmldocs output is ugly.

Wrap the remaining unwrapped snippets, while also fix recent kernel test
robot warnings.

Link: https://lore.kernel.org/linux-doc/202301290253.LU5yIxcJ-lkp@intel.com/
Fixes: 88238513bb2671 ("tracing/histogram: Document variable stacktrace")
Reported-by: kernel test robot <lkp@intel.com>
Signed-off-by: Bagas Sanjaya <bagasdotme@gmail.com>
---
 Documentation/trace/histogram.rst | 93 ++++++++++++++++---------------
 1 file changed, 47 insertions(+), 46 deletions(-)

diff --git a/Documentation/trace/histogram.rst b/Documentation/trace/histogram.rst
index 5c391328b9bb41..8e95295e39b65c 100644
--- a/Documentation/trace/histogram.rst
+++ b/Documentation/trace/histogram.rst
@@ -1864,7 +1864,7 @@ A histogram can now be defined for the new synthetic event::
 The above shows the latency "lat" in a power of 2 grouping.
 
 Like any other event, once a histogram is enabled for the event, the
-output can be displayed by reading the event's 'hist' file.
+output can be displayed by reading the event's 'hist' file::
 
   # cat /sys/kernel/debug/tracing/events/synthetic/wakeup_latency/hist
 
@@ -1911,7 +1911,7 @@ output can be displayed by reading the event's 'hist' file.
 
 
 The latency values can also be grouped linearly by a given size with
-the ".buckets" modifier and specify a size (in this case groups of 10).
+the ".buckets" modifier and specify a size (in this case groups of 10)::
 
   # echo 'hist:keys=pid,prio,lat.buckets=10:sort=lat' >> \
         /sys/kernel/debug/tracing/events/synthetic/wakeup_latency/trigger
@@ -1945,7 +1945,7 @@ the ".buckets" modifier and specify a size (in this case groups of 10).
 
 To save stacktraces, create a synthetic event with a field of type "unsigned long[]"
 or even just "long[]". For example, to see how long a task is blocked in an
-uninterruptible state:
+uninterruptible state::
 
   # cd /sys/kernel/tracing
   # echo 's:block_lat pid_t pid; u64 delta; unsigned long[] stack;' > dynamic_events
@@ -1990,7 +1990,8 @@ uninterruptible state:
   => kthread+0xe9/0x110
   => ret_from_fork+0x2c/0x50
 
-A synthetic event that has a stacktrace field may use it as a key in histogram:
+A synthetic event that has a stacktrace field may use it as a key in
+histogram::
 
   # echo 'hist:delta.buckets=100,stack.stacktrace:sort=delta' > events/synthetic/block_lat/trigger
   # cat events/synthetic/block_lat/hist
@@ -2183,11 +2184,11 @@ The following commonly-used handler.action pairs are available:
               wakeup_new_test($testpid) if comm=="cyclictest"' >> \
               /sys/kernel/debug/tracing/events/sched/sched_wakeup_new/trigger
 
-    Or, equivalently, using the 'trace' keyword syntax:
+    Or, equivalently, using the 'trace' keyword syntax::
 
-    # echo 'hist:keys=$testpid:testpid=pid:onmatch(sched.sched_wakeup_new).\
-            trace(wakeup_new_test,$testpid) if comm=="cyclictest"' >> \
-            /sys/kernel/debug/tracing/events/sched/sched_wakeup_new/trigger
+      # echo 'hist:keys=$testpid:testpid=pid:onmatch(sched.sched_wakeup_new).\
+              trace(wakeup_new_test,$testpid) if comm=="cyclictest"' >> \
+              /sys/kernel/debug/tracing/events/sched/sched_wakeup_new/trigger
 
     Creating and displaying a histogram based on those events is now
     just a matter of using the fields and new synthetic event in the
@@ -2320,48 +2321,48 @@ The following commonly-used handler.action pairs are available:
     resulting latency, stored in wakeup_lat, exceeds the current
     maximum latency, a snapshot is taken.  As part of the setup, all
     the scheduler events are also enabled, which are the events that
-    will show up in the snapshot when it is taken at some point:
+    will show up in the snapshot when it is taken at some point::
 
-    # echo 1 > /sys/kernel/debug/tracing/events/sched/enable
+      # echo 1 > /sys/kernel/debug/tracing/events/sched/enable
 
-    # echo 'hist:keys=pid:ts0=common_timestamp.usecs \
-            if comm=="cyclictest"' >> \
-            /sys/kernel/debug/tracing/events/sched/sched_waking/trigger
+      # echo 'hist:keys=pid:ts0=common_timestamp.usecs \
+              if comm=="cyclictest"' >> \
+              /sys/kernel/debug/tracing/events/sched/sched_waking/trigger
 
-    # echo 'hist:keys=next_pid:wakeup_lat=common_timestamp.usecs-$ts0: \
-            onmax($wakeup_lat).save(next_prio,next_comm,prev_pid,prev_prio, \
-	    prev_comm):onmax($wakeup_lat).snapshot() \
-	    if next_comm=="cyclictest"' >> \
-	    /sys/kernel/debug/tracing/events/sched/sched_switch/trigger
+      # echo 'hist:keys=next_pid:wakeup_lat=common_timestamp.usecs-$ts0: \
+              onmax($wakeup_lat).save(next_prio,next_comm,prev_pid,prev_prio, \
+	      prev_comm):onmax($wakeup_lat).snapshot() \
+	      if next_comm=="cyclictest"' >> \
+	      /sys/kernel/debug/tracing/events/sched/sched_switch/trigger
 
     When the histogram is displayed, for each bucket the max value
     and the saved values corresponding to the max are displayed
     following the rest of the fields.
 
     If a snapshot was taken, there is also a message indicating that,
-    along with the value and event that triggered the global maximum:
+    along with the value and event that triggered the global maximum::
 
-    # cat /sys/kernel/debug/tracing/events/sched/sched_switch/hist
-      { next_pid:       2101 } hitcount:        200
-	max:         52  next_prio:        120  next_comm: cyclictest \
-        prev_pid:          0  prev_prio:        120  prev_comm: swapper/6
+      # cat /sys/kernel/debug/tracing/events/sched/sched_switch/hist
+        { next_pid:       2101 } hitcount:        200
+	  max:         52  next_prio:        120  next_comm: cyclictest \
+          prev_pid:          0  prev_prio:        120  prev_comm: swapper/6
 
-      { next_pid:       2103 } hitcount:       1326
-	max:        572  next_prio:         19  next_comm: cyclictest \
-        prev_pid:          0  prev_prio:        120  prev_comm: swapper/1
+        { next_pid:       2103 } hitcount:       1326
+	  max:        572  next_prio:         19  next_comm: cyclictest \
+          prev_pid:          0  prev_prio:        120  prev_comm: swapper/1
 
-      { next_pid:       2102 } hitcount:       1982 \
-	max:         74  next_prio:         19  next_comm: cyclictest \
-        prev_pid:          0  prev_prio:        120  prev_comm: swapper/5
+        { next_pid:       2102 } hitcount:       1982 \
+	  max:         74  next_prio:         19  next_comm: cyclictest \
+          prev_pid:          0  prev_prio:        120  prev_comm: swapper/5
 
-    Snapshot taken (see tracing/snapshot).  Details:
-	triggering value { onmax($wakeup_lat) }:        572	\
-	triggered by event with key: { next_pid:       2103 }
+      Snapshot taken (see tracing/snapshot).  Details:
+	  triggering value { onmax($wakeup_lat) }:        572	\
+	  triggered by event with key: { next_pid:       2103 }
 
-    Totals:
-        Hits: 3508
-        Entries: 3
-        Dropped: 0
+      Totals:
+          Hits: 3508
+          Entries: 3
+          Dropped: 0
 
     In the above case, the event that triggered the global maximum has
     the key with next_pid == 2103.  If you look at the bucket that has
@@ -2439,15 +2440,15 @@ The following commonly-used handler.action pairs are available:
     $cwnd variable.  If the value has changed, a snapshot is taken.
     As part of the setup, all the scheduler and tcp events are also
     enabled, which are the events that will show up in the snapshot
-    when it is taken at some point:
+    when it is taken at some point::
 
-    # echo 1 > /sys/kernel/debug/tracing/events/sched/enable
-    # echo 1 > /sys/kernel/debug/tracing/events/tcp/enable
+      # echo 1 > /sys/kernel/debug/tracing/events/sched/enable
+      # echo 1 > /sys/kernel/debug/tracing/events/tcp/enable
 
-    # echo 'hist:keys=dport:cwnd=snd_cwnd: \
-            onchange($cwnd).save(snd_wnd,srtt,rcv_wnd): \
-	    onchange($cwnd).snapshot()' >> \
-	    /sys/kernel/debug/tracing/events/tcp/tcp_probe/trigger
+      # echo 'hist:keys=dport:cwnd=snd_cwnd: \
+              onchange($cwnd).save(snd_wnd,srtt,rcv_wnd): \
+	      onchange($cwnd).snapshot()' >> \
+	      /sys/kernel/debug/tracing/events/tcp/tcp_probe/trigger
 
     When the histogram is displayed, for each bucket the tracked value
     and the saved values corresponding to that value are displayed
@@ -2470,10 +2471,10 @@ The following commonly-used handler.action pairs are available:
       { dport:        443 } hitcount:        211
 	changed:         10  snd_wnd:      26960  srtt:      17379  rcv_wnd:      28800
 
-    Snapshot taken (see tracing/snapshot).  Details::
+      Snapshot taken (see tracing/snapshot).  Details:
 
-        triggering value { onchange($cwnd) }:         10
-        triggered by event with key: { dport:         80 }
+          triggering value { onchange($cwnd) }:         10
+          triggered by event with key: { dport:         80 }
 
       Totals:
           Hits: 414

base-commit: 9f712417e1fc7d3db042941524e59573e02a55c7
-- 
An old man doll... just what I always wanted! - Clara

