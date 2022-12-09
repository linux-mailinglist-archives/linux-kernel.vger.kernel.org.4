Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B310A648832
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Dec 2022 19:10:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229674AbiLISKF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Dec 2022 13:10:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40846 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229482AbiLISKC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Dec 2022 13:10:02 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 20D609B2B1;
        Fri,  9 Dec 2022 10:10:02 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B390F622EB;
        Fri,  9 Dec 2022 18:10:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A1D17C433EF;
        Fri,  9 Dec 2022 18:09:59 +0000 (UTC)
Date:   Fri, 9 Dec 2022 13:09:58 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Karol Herbst <karolherbst@gmail.com>,
        Pekka Paalanen <ppaalanen@gmail.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Andy Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        x86@kernel.org
Subject: Re: [PATCH 2/2] x86/mm/kmmio: Remove rcu_read_lock()
Message-ID: <20221209130958.4f1d3057@gandalf.local.home>
In-Reply-To: <20221209130334.487b63aa@gandalf.local.home>
References: <20221206191201.217838841@goodmis.org>
        <20221206191229.813199661@goodmis.org>
        <20221207173621.GF4001@paulmck-ThinkPad-P17-Gen-1>
        <20221209130334.487b63aa@gandalf.local.home>
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

On Fri, 9 Dec 2022 13:03:34 -0500
Steven Rostedt <rostedt@goodmis.org> wrote:

> On Wed, 7 Dec 2022 09:36:21 -0800
> "Paul E. McKenney" <paulmck@kernel.org> wrote:
> 
> > > Cc: "Paul E. McKenney" <paulmck@kernel.org>
> > > Signed-off-by: Steven Rostedt <rostedt@goodmis.org>    
> > 
> > Might be worth adding a comment saying that others are using this
> > preempt_disable() to block an RCU grace period, but that is up to
> > you guys.  I will let you and your future selves be the judges.  
> 
> Good point. I'll add a comment in v2.

Actually, rcu_read_lock_sched_notrace() may work instead. Let me test it.

-- Steve
