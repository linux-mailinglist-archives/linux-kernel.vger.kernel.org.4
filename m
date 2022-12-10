Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B0EB4649103
	for <lists+linux-kernel@lfdr.de>; Sat, 10 Dec 2022 23:32:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229798AbiLJWcf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 10 Dec 2022 17:32:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45612 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229538AbiLJWcd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 10 Dec 2022 17:32:33 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E081913F16
        for <linux-kernel@vger.kernel.org>; Sat, 10 Dec 2022 14:32:32 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 771AF60C98
        for <linux-kernel@vger.kernel.org>; Sat, 10 Dec 2022 22:32:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8D772C433D2;
        Sat, 10 Dec 2022 22:32:30 +0000 (UTC)
Date:   Sat, 10 Dec 2022 17:32:27 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     linux-kernel@vger.kernel.org,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Karol Herbst <karolherbst@gmail.com>,
        Pekka Paalanen <ppaalanen@gmail.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Andy Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@kernel.org>, Borislav Petkov <bp@alien8.de>
Subject: Re: [for-next][PATCH 13/25] x86/mm/kmmio: Use
 rcu_read_lock_sched_notrace()
Message-ID: <20221210173227.7063269d@gandalf.local.home>
In-Reply-To: <20221210213412.GF4001@paulmck-ThinkPad-P17-Gen-1>
References: <20221210135750.425719934@goodmis.org>
        <20221210135825.241167123@goodmis.org>
        <20221210174753.GD4001@paulmck-ThinkPad-P17-Gen-1>
        <20221210133425.4657985e@gandalf.local.home>
        <20221210213412.GF4001@paulmck-ThinkPad-P17-Gen-1>
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

On Sat, 10 Dec 2022 13:34:12 -0800
"Paul E. McKenney" <paulmck@kernel.org> wrote:

> > I was going to remove it, but then I realized that it would be a functional
> > change, as from the comment above, it uses "preempt_enable_no_resched(),
> > which there is not a rcu_read_unlock_sched() variant.  
> 
> If this happens often enough, it might be worth adding something like
> rcu_read_unlock_sched_no_resched(), but we clearly are not there yet.
> Especially not with a name like that!  ;-)

Please don't ;-)

This is only to handle the bizarre case that mmio tracing does. Remember,
this tracer is only for those that want to reverse engineer a binary
driver. It's not even SMP safe! When you enable it, it shuts down all but
one CPU. This is actually the reason I worked so hard to keep it working
with lockdep. The shutting down of CPUs has caught so many bugs in other
parts of the kernel! ;-)

Thus, anything that mmio tracer does, is considered niche, and not
something to much care about.

-- Steve
