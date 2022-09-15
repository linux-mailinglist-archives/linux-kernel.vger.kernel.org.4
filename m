Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A94A05B99E7
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Sep 2022 13:42:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230171AbiIOLma (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Sep 2022 07:42:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39346 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229931AbiIOLkj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Sep 2022 07:40:39 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B8565F994
        for <linux-kernel@vger.kernel.org>; Thu, 15 Sep 2022 04:40:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Subject:Cc:To:From:Date:Message-ID:
        Sender:Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding:
        Content-ID:Content-Description:In-Reply-To:References;
        bh=3wmkStmzHKmhbVvPhv89QeauiTa+ooofqbKyYfqC03Y=; b=Yh8XRCTiUnb86dmf52eHQj66wV
        sEQQAnY97nS5VG+UfepmfYnfjIn0HjbkMLOZ9s2xyg9VNyjMi3D5EN8/2hodi15wdwIbeBAbI3lrJ
        O9+n8k/JxYXWKNlKf2iLc0X0fO1aJDp8vG807NHrqIP3AI/DliTcJBq9rfivhhytMOJEYmBg+DKg7
        wBvLos3LledslVrRC0WozyIv4mBgsvW+LkmVgkhsni+JEzfvyXYc418UoZemxtaCFwF/zxCH4HofH
        GmcB9gSFM3MpqF4helLETc1KQbLRmX3wkIAV9joPDc/LKkqnk5TPzSX0RiP2675fH8bHshwpSCtnK
        dq6b1t7g==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1oYnDa-0012Mn-I4; Thu, 15 Sep 2022 11:39:42 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id E293030029C;
        Thu, 15 Sep 2022 13:39:38 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 0)
        id C82BA29A24305; Thu, 15 Sep 2022 13:39:38 +0200 (CEST)
Message-ID: <20220915111039.092790446@infradead.org>
User-Agent: quilt/0.66
Date:   Thu, 15 Sep 2022 13:10:39 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     linux-kernel@vger.kernel.org, peterz@infradead.org, x86@kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Tim Chen <tim.c.chen@linux.intel.com>,
        Josh Poimboeuf <jpoimboe@kernel.org>,
        Andrew Cooper <Andrew.Cooper3@citrix.com>,
        Pawan Gupta <pawan.kumar.gupta@linux.intel.com>,
        Johannes Wikner <kwikner@ethz.ch>,
        Alyssa Milburn <alyssa.milburn@linux.intel.com>,
        Jann Horn <jannh@google.com>, "H.J. Lu" <hjl.tools@gmail.com>,
        Joao Moreira <joao.moreira@intel.com>,
        Joseph Nuzman <joseph.nuzman@intel.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Juergen Gross <jgross@suse.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        K Prateek Nayak <kprateek.nayak@amd.com>,
        Eric Dumazet <edumazet@google.com>
Subject: [PATCH v3 00/59] x86/retbleed: Call depth tracking mitigation
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

Previous postings:

  v2: https://lkml.kernel.org/r/20220902130625.217071627@infradead.org
  v1: https://lkml.kernel.org/r/20220716230344.239749011@linutronix.de

Changes since v2 are minimal; I reworked the alignment thing per Linus'
request (patch #8) and collected a few tags.

Barring great objections I'm hoping to merge this soon so we can all get on
with other things.

--- text from v2 ---

This version is significantly different from the last in that it no longer
makes use of external call thunks allocated from the module space. Instead
every function gets aligned to 16 bytes and gets 16 bytes of (pre-symbol)
padding. (This padding will also come in handy for other things, like the
kCFI/FineIBT work.)

Prior to these patches function alignment is basically non-existent, as such
any instruction fetch for the first instructions of a function will have (on
average) half the fetch window filled with whatever comes before. By pushing
the alignment up to 16 bytes this improves matters for chips that happen to
have a 16 byte i-fetch window size (Intel) while not making matters worse for
chips that have a larger 32 byte i-fetch window (AMD Zen). In fact, it improves
the worst case for Zen from 31 bytes of garbage to 16 bytes of garbage.

As such the first many patches of the series fix up lots of alignment quirks.


The second big difference is the introduction of struct pcpu_hot. Because the
compiler managed to place two adjacent (in code) DEFINE_PER_CPU() variables in
random cachelines (it is absolutely free to do so) the introduction of the
per-cpu x86_call_depth variable sometimes introduced significant additional
cache pressure, while other times it would sit nicely in the same line with
preempt_count and not show up at all.

In order to alleviate this problem; introduce struct pcpu_hot and collect a
number of hot per-cpu variables in a way the compiler can't mess up.


Since these changes are 'unconditional', Mel was gracious enough to help test
this on his test setup across all the relevant uarchs (very much including both
Intel and AMD machines) and found that while these changes cause some very
small wins and losses across the board it is mostly noise.


Aside from these changes; the core of the depth tracking is still the same.

 - objtool creates a list of functions and a list of function call sites.

 - for every function the padding is overwritten with the call accounting
   thunk; for every call site the call target is adjusted to point to this
   thunk.

 - the retbleed return thunk mechanism is used for a custom return thunk
   that includes return accounting and does RSB stuffing when required.

This ensures no new compiler is required and avoids almost all overhead for
non affected machines. This new option can still be selected using:

  "retbleed=stuff"

on the kernel command line.


As a refresher; the theory behind call depth tracking is:

The Return-Stack-Buffer (RSB) is a 16 deep stack that is filled on every call.
On the return path speculation will "pop" an entry and takes that as the return
target. Once the RSB is empty, the CPU falls back to other predictors, e.g. the
Branch History Buffer, which can be mistrained by user space and misguides the
(return) speculation path to a disclosure gadget of your choice -- as described
in the retbleed paper.

Call depth tracking is designed to break this speculation path by stuffing
speculation trap calls into the RSB whenver the RSB is running low. This way
the speculation stalls and never falls back to other predictors.

The assumption is that stuffing at the 12th return is sufficient to break the
speculation before it hits the underflow and the fallback to the other
predictors. Testing confirms that it works. Johannes, one of the retbleed
researchers, tried to attack this approach and confirmed that it brings the
signal to noise ratio down to the crystal ball level.


Excerpts from IBRS vs stuff from Mel's testing:

perfsyscall

		6.0.0-rc1		6.0.0-rc1
                tglx-mit-spectre-ibrs	tglx-mit-spectre-retpoline-retstuff
Duration User         136.16		   69.10
Duration System       100.50		   33.04
Duration Elapsed      237.20		  102.65

That's a massive improvement with a major reduction in system CPU usage.

Kernel compilation is variable. Skylake-X was modest with 2-18% gain depending
on degree of parallelisation.

Git checkouts are roughly 14% faster on Skylake-X

Network test were localhost only so are limited but even so, the gain is
large. Skylake-X again;

Netperf-TCP
                                  6.0.0-rc1              6.0.0-rc1
                      tglx-mit-spectre-ibrs  tglx-mit-spectre-retpoline-retstuff
Hmean     send-64         241.39 (   0.00%)      298.00 *  23.45%*
Hmean     send-128        489.55 (   0.00%)      610.46 *  24.70%*
Hmean     send-256        990.85 (   0.00%)     1201.73 *  21.28%*
Hmean     send-1024      4051.84 (   0.00%)     5006.19 *  23.55%*
Hmean     send-2048      7924.75 (   0.00%)     9777.14 *  23.37%*
Hmean     send-3312     12319.98 (   0.00%)    15210.07 *  23.46%*
Hmean     send-4096     14770.62 (   0.00%)    17941.32 *  21.47%*
Hmean     send-8192     26302.00 (   0.00%)    30170.04 *  14.71%*
Hmean     send-16384    42449.51 (   0.00%)    48036.45 *  13.16%*

While this is UDP_STREAM, TCP_STREAM is similarly impressive.

FIO measurements done by Tim Chen:

read (kIOPs)            Mean    stdev   mitigations=off retbleed=off    CPU util
================================================================================
mitigations=off         357.33  3.79    0.00%           6.14%           98.93%
retbleed=off            336.67  6.43    -5.78%          0.00%           99.01%
retbleed=ibrs           242.00  0.00    -32.28%         -28.12%         99.41%
retbleed=stuff (pad)    314.33  1.53    -12.03%         -6.63%          99.31%

read/write                              Baseline        Baseline
70/30 (kIOPs)           Mean    stdev   mitigations=off retbleed=off    CPU util
================================================================================
mitigations=off         349.00  5.29    0.00%           9.06%           96.66%
retbleed=off            320.00  5.05    -8.31%          0.00%           95.54%
retbleed=ibrs           238.60  0.17    -31.63%         -25.44%         98.18%
retbleed=stuff (pad)    293.37  0.81    -15.94%         -8.32%          97.71%

                                        Baseline        Baseline
write (kIOPs)           Mean    stdev   mitigations=off retbleed=off    CPU util
================================================================================
mitigations=off         296.33  8.08    0.00%           6.21%           93.96%
retbleed=off            279.00  2.65    -5.85%          0.00%           93.63%
retbleed=ibrs           230.33  0.58    -22.27%         -17.44%         95.92%
retbleed=stuff (pad)    266.67  1.53    -10.01%         -4.42%          94.75%

---

The patches can also be found in git here:

  git://git.kernel.org/pub/scm/linux/kernel/git/peterz/queue.git call-depth-tracking


