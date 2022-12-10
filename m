Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CB995649026
	for <lists+linux-kernel@lfdr.de>; Sat, 10 Dec 2022 19:34:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229674AbiLJSei (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 10 Dec 2022 13:34:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49834 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229475AbiLJSef (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 10 Dec 2022 13:34:35 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E65621114C
        for <linux-kernel@vger.kernel.org>; Sat, 10 Dec 2022 10:34:33 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id EC6D2B808C3
        for <linux-kernel@vger.kernel.org>; Sat, 10 Dec 2022 18:34:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 65341C433D2;
        Sat, 10 Dec 2022 18:34:29 +0000 (UTC)
Date:   Sat, 10 Dec 2022 13:34:25 -0500
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
Message-ID: <20221210133425.4657985e@gandalf.local.home>
In-Reply-To: <20221210174753.GD4001@paulmck-ThinkPad-P17-Gen-1>
References: <20221210135750.425719934@goodmis.org>
        <20221210135825.241167123@goodmis.org>
        <20221210174753.GD4001@paulmck-ThinkPad-P17-Gen-1>
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

On Sat, 10 Dec 2022 09:47:53 -0800
"Paul E. McKenney" <paulmck@kernel.org> wrote:

> > Note, the preempt_disable() is still needed as it uses preempt_enable_no_resched().
> > 

 ...

> Executable code can be the best form of comment.  ;-)
> 
> This does mess with preempt_count() redundantly, but the overhead from
> that should be way down in the noise.

I was going to remove it, but then I realized that it would be a functional
change, as from the comment above, it uses "preempt_enable_no_resched(),
which there is not a rcu_read_unlock_sched() variant.

> 
> Acked-by: Paul E. McKenney <paulmck@kernel.org>

Thanks! I'll add this to the commit.

-- Steve
