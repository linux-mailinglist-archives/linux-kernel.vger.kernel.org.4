Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4A6106819AF
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Jan 2023 19:51:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237952AbjA3Svy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Jan 2023 13:51:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59152 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237541AbjA3Svx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Jan 2023 13:51:53 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A4355196A0;
        Mon, 30 Jan 2023 10:51:51 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3F1256122D;
        Mon, 30 Jan 2023 18:51:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0B3DDC433D2;
        Mon, 30 Jan 2023 18:51:49 +0000 (UTC)
Date:   Mon, 30 Jan 2023 13:51:48 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     Masami Hiramatsu <mhiramat@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: Re: linux-next: build warnings after merge of the ftrace tree
Message-ID: <20230130135148.5fc7431b@gandalf.local.home>
In-Reply-To: <20230130165149.7933efb1@canb.auug.org.au>
References: <20230130165149.7933efb1@canb.auug.org.au>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 30 Jan 2023 16:51:49 +1100
Stephen Rothwell <sfr@canb.auug.org.au> wrote:

> Hi all,
> 
> After merging the ftrace tree, today's linux-next build (htmldocs)
> produced these warnings:
> 
> Documentation/trace/histogram.rst:1969: ERROR: Unexpected indentation.
> Documentation/trace/histogram.rst:1970: WARNING: Block quote ends without a blank line; unexpected unindent.
> Documentation/trace/histogram.rst:1982: WARNING: Block quote ends without a blank line; unexpected unindent.
> Documentation/trace/histogram.rst:2014: WARNING: Definition list ends without a blank line; unexpected unindent.
> Documentation/trace/histogram.rst:2016: ERROR: Unexpected indentation.
> Documentation/trace/histogram.rst:2028: WARNING: Block quote ends without a blank line; unexpected unindent.
> Documentation/trace/histogram.rst:2030: ERROR: Unexpected indentation.
> Documentation/trace/histogram.rst:2040: WARNING: Block quote ends without a blank line; unexpected unindent.
> Documentation/trace/histogram.rst:2042: ERROR: Unexpected indentation.
> Documentation/trace/histogram.rst:2052: WARNING: Block quote ends without a blank line; unexpected unindent.
> Documentation/trace/histogram.rst:2055: ERROR: Unexpected indentation.
> Documentation/trace/histogram.rst:2065: WARNING: Block quote ends without a blank line; unexpected unindent.
> 
> Introduced by commit
> 
>   88238513bb26 ("tracing/histogram: Document variable stacktrace")
> 

krobot saw this too. I'm thinking this can fix it:

-- Steve

diff --git a/Documentation/trace/histogram.rst b/Documentation/trace/histogram.rst
index 5c391328b9bb..026eef03afe0 100644
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
@@ -1990,7 +1990,7 @@ uninterruptible state:
   => kthread+0xe9/0x110
   => ret_from_fork+0x2c/0x50
 
-A synthetic event that has a stacktrace field may use it as a key in histogram:
+A synthetic event that has a stacktrace field may use it as a key in histogram::
 
   # echo 'hist:delta.buckets=100,stack.stacktrace:sort=delta' > events/synthetic/block_lat/trigger
   # cat events/synthetic/block_lat/hist
@@ -2183,7 +2183,7 @@ The following commonly-used handler.action pairs are available:
               wakeup_new_test($testpid) if comm=="cyclictest"' >> \
               /sys/kernel/debug/tracing/events/sched/sched_wakeup_new/trigger
 
-    Or, equivalently, using the 'trace' keyword syntax:
+    Or, equivalently, using the 'trace' keyword syntax::
 
     # echo 'hist:keys=$testpid:testpid=pid:onmatch(sched.sched_wakeup_new).\
             trace(wakeup_new_test,$testpid) if comm=="cyclictest"' >> \
@@ -2320,7 +2320,7 @@ The following commonly-used handler.action pairs are available:
     resulting latency, stored in wakeup_lat, exceeds the current
     maximum latency, a snapshot is taken.  As part of the setup, all
     the scheduler events are also enabled, which are the events that
-    will show up in the snapshot when it is taken at some point:
+    will show up in the snapshot when it is taken at some point::
 
     # echo 1 > /sys/kernel/debug/tracing/events/sched/enable
 
@@ -2339,7 +2339,7 @@ The following commonly-used handler.action pairs are available:
     following the rest of the fields.
 
     If a snapshot was taken, there is also a message indicating that,
-    along with the value and event that triggered the global maximum:
+    along with the value and event that triggered the global maximum::
 
     # cat /sys/kernel/debug/tracing/events/sched/sched_switch/hist
       { next_pid:       2101 } hitcount:        200
@@ -2439,7 +2439,7 @@ The following commonly-used handler.action pairs are available:
     $cwnd variable.  If the value has changed, a snapshot is taken.
     As part of the setup, all the scheduler and tcp events are also
     enabled, which are the events that will show up in the snapshot
-    when it is taken at some point:
+    when it is taken at some point::
 
     # echo 1 > /sys/kernel/debug/tracing/events/sched/enable
     # echo 1 > /sys/kernel/debug/tracing/events/tcp/enable
