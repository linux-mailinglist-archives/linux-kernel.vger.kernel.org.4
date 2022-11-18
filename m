Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 169C662FA56
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Nov 2022 17:34:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235346AbiKRQeN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Nov 2022 11:34:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52588 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235230AbiKRQeK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Nov 2022 11:34:10 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A2C2A5BD5B;
        Fri, 18 Nov 2022 08:34:08 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 5B376B822E5;
        Fri, 18 Nov 2022 16:34:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BAF05C433C1;
        Fri, 18 Nov 2022 16:34:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1668789246;
        bh=HvpYsDoM0kbv0dGnSZGFMkheMby5lV6hgcABr8z3P/0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=g1YihLXajpO15zRFFwgDKHehxVwKDcUZlZoVbt4gW+LjX36zPFhPQXDLHpXxhWt7E
         t/QKqAxSfp9v72vADi3eHUNSbt5/SC+0I2KasMpplWDN1460XHTVBq5ErDg0k9qaVY
         k8FDQ4fSbnBo4cdVgmSnyfo3g8n72WEKw4pOatkQPysRFDXisF/rxL3QLueYi1TXMX
         XVMnIYxINuoEj8paVwM6iG5BUhl2Pw9HccPdH9PncPkJ5B/lzhMF8J2oggLpS9qaIW
         LrP2/7GBCtrU8mLr3w1LJ0WNk8AuivXRzdsIIKPNeL1jAQWamJ3eF7DDp7jpe51lOb
         zhJtxlVuVdOfA==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 2E3524034E; Fri, 18 Nov 2022 13:34:03 -0300 (-03)
Date:   Fri, 18 Nov 2022 13:34:03 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ian Rogers <irogers@google.com>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        Steven Rostedt <rostedt@google.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Linux Trace Devel <linux-trace-devel@vger.kernel.org>,
        Stephane Eranian <eranian@google.com>
Subject: Re: [PATCH v1 1/2] perf build: Require libtraceevent from the system
Message-ID: <Y3ez+y/k1dIip5hH@kernel.org>
References: <20221117224952.358639-1-irogers@google.com>
 <20221117224952.358639-2-irogers@google.com>
 <Y3dQxVNwGmQMWPP0@hirez.programming.kicks-ass.net>
 <Y3eejjLjChlGC96I@kernel.org>
 <20221118103302.7ea12016@gandalf.local.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221118103302.7ea12016@gandalf.local.home>
X-Url:  http://acmel.wordpress.com
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Fri, Nov 18, 2022 at 10:33:02AM -0500, Steven Rostedt escreveu:
> On Fri, 18 Nov 2022 12:02:38 -0300 Arnaldo Carvalho de Melo <acme@kernel.org> wrote:
 
> > yeah, this probably should work like with other libraries, don't stop
> > the build, just don't build features that depend on libtraceevent,
> > warning the user that features foo, bar and baz won't be available.

> > For people working with just hardware, software, cache events, no
> > problem.
 
> How are software events parsed?

Not parsed, fixed:

root@roc-rk3399-pc:~# perf list sw

List of pre-defined events (to be used in -e or -M):

  alignment-faults                                   [Software event]
  bpf-output                                         [Software event]
  cgroup-switches                                    [Software event]
  context-switches OR cs                             [Software event]
  cpu-clock                                          [Software event]
  cpu-migrations OR migrations                       [Software event]
  dummy                                              [Software event]
  emulation-faults                                   [Software event]
  major-faults                                       [Software event]
  minor-faults                                       [Software event]
  page-faults OR faults                              [Software event]
  task-clock                                         [Software event]

  duration_time                                      [Tool event]
  user_time                                          [Tool event]
  system_time                                        [Tool event]

root@roc-rk3399-pc:~#


In addition to:

root@roc-rk3399-pc:~# perf list hw

List of pre-defined events (to be used in -e or -M):

  branch-instructions OR branches                    [Hardware event]
  branch-misses                                      [Hardware event]
  bus-cycles                                         [Hardware event]
  cache-misses                                       [Hardware event]
  cache-references                                   [Hardware event]
  cpu-cycles OR cycles                               [Hardware event]
  instructions                                       [Hardware event]

root@roc-rk3399-pc:~#

And:

root@roc-rk3399-pc:~# perf list cache

List of pre-defined events (to be used in -e or -M):

  L1-dcache-load-misses                              [Hardware cache event]
  L1-dcache-loads                                    [Hardware cache event]
  L1-dcache-prefetch-misses                          [Hardware cache event]
  L1-dcache-store-misses                             [Hardware cache event]
  L1-dcache-stores                                   [Hardware cache event]
  L1-icache-load-misses                              [Hardware cache event]
  L1-icache-loads                                    [Hardware cache event]
  branch-load-misses                                 [Hardware cache event]
  branch-loads                                       [Hardware cache event]
  dTLB-load-misses                                   [Hardware cache event]
  dTLB-store-misses                                  [Hardware cache event]
  iTLB-load-misses                                   [Hardware cache event]
  node-loads                                         [Hardware cache event]
  node-stores                                        [Hardware cache event]

root@roc-rk3399-pc:~#

Without something like libtraceevent 'perf probe', 'perf trace' wouldn't
work as of now, as it currently use libtraceevent to parse whats in
tracefs.

So for some people, just interested in profiling the above hw, sw and
cache events, libtraceevent isn't strictly required and may even be
desirable to reduce the number of library dependencies.

So its a valid feature to allow perf to be built without libtraceevent,
i.e. not something needed for the above scenarios.

With libbpf and BTF tracefs isn't also strictly needed, as we already
have to link with it and things like 'perf trace' want to use libbpf's
btf pretty printing stuff, we can use BTF to enumerate events, iterate
thru its fields, offsets, types, etc:

root@roc-rk3399-pc:~# pahole --sizes | grep trace_event_raw_sched
trace_event_raw_sched_kthread_stop	28	0
trace_event_raw_sched_kthread_stop_ret	12	0
trace_event_raw_sched_kthread_work_queue_work	32	0
trace_event_raw_sched_kthread_work_execute_start	24	0
trace_event_raw_sched_kthread_work_execute_end	24	0
trace_event_raw_sched_wakeup_template	36	0
trace_event_raw_sched_switch	64	0
trace_event_raw_sched_migrate_task	40	0
trace_event_raw_sched_process_template	32	0
trace_event_raw_sched_process_wait	32	0
trace_event_raw_sched_process_fork	48	0
trace_event_raw_sched_process_exec	20	0
trace_event_raw_sched_stat_runtime	48	1
trace_event_raw_sched_pi_setprio	36	0
trace_event_raw_sched_move_numa	36	0
trace_event_raw_sched_numa_pair_template	48	0
trace_event_raw_sched_wake_idle_without_ipi	12	0
root@roc-rk3399-pc:~#

root@roc-rk3399-pc:~# pahole trace_event_raw_sched_switch
struct trace_event_raw_sched_switch {
	struct trace_entry         ent;                  /*     0     8 */
	char                       prev_comm[16];        /*     8    16 */
	pid_t                      prev_pid;             /*    24     4 */
	int                        prev_prio;            /*    28     4 */
	long int                   prev_state;           /*    32     8 */
	char                       next_comm[16];        /*    40    16 */
	pid_t                      next_pid;             /*    56     4 */
	int                        next_prio;            /*    60     4 */
	/* --- cacheline 1 boundary (64 bytes) --- */
	char                       __data[];             /*    64     0 */

	/* size: 64, cachelines: 1, members: 9 */
};
root@roc-rk3399-pc:~#

- Arnaldo
