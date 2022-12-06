Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5C714644C46
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Dec 2022 20:12:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229613AbiLFTMn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Dec 2022 14:12:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49312 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229623AbiLFTMf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Dec 2022 14:12:35 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0FAA8211;
        Tue,  6 Dec 2022 11:12:33 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 2587DB81AE1;
        Tue,  6 Dec 2022 19:12:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C0750C433C1;
        Tue,  6 Dec 2022 19:12:30 +0000 (UTC)
Received: from rostedt by gandalf.local.home with local (Exim 4.96)
        (envelope-from <rostedt@goodmis.org>)
        id 1p2dMj-0004QL-23;
        Tue, 06 Dec 2022 14:12:29 -0500
Message-ID: <20221206191201.217838841@goodmis.org>
User-Agent: quilt/0.66
Date:   Tue, 06 Dec 2022 14:12:01 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org
Cc:     Masami Hiramatsu <mhiramat@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Karol Herbst <karolherbst@gmail.com>,
        Pekka Paalanen <ppaalanen@gmail.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Andy Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        x86@kernel.org
Subject: [PATCH 0/2] x86/mm/kmmio: Have mmiotracer play nice with lockdep
X-Spam-Status: No, score=-6.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


The mmiotrace tracer is "special". The purpose is to help reverse engineer
binary drivers by removing the memory allocated by the driver and when the
driver goes to access it, a fault occurs, the mmiotracer will record what
the driver was doing and then do the work on its behalf by single stepping
through the process.

But to achieve this ability, it must do some special things. One is it
needs to grab a lock while in the breakpoint handler. This is considered
an NMI state, and then lockdep warns that the lock is being held in both
an NMI state (really a breakpoint handler) and also in normal context.

As the breakpoint/NMI state only happens when the driver is accessing
memory, there's no concern of a race condition against the setup and
tear-down of mmiotracer.

To make lockdep and mmiotrace work together, convert the locks used in the
breakpoint handler into arch_spin_lock().

It also takes the rcu_read_lock() at the fault, and releases it in
the single step breakpoint. This makes lockdep sad. Luckily, it also
disables preemption when taking the rcu_read_lock() and enables it when
releasing the rcu_read_lock(). As now the sched RCU variant is basically
the same as the "normal" RCU variant, there's no reason to take
the rcu_read_lock(), so just remove it.

Steven Rostedt (2):
      x86/mm/kmmio: Switch to arch_spin_lock()
      x86/mm/kmmio: Remove rcu_read_lock()

----
 arch/x86/mm/kmmio.c | 34 ++++++++++++++++++++++------------
 1 file changed, 22 insertions(+), 12 deletions(-)
