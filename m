Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D2CD36A8B8C
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Mar 2023 23:13:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229897AbjCBWNl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Mar 2023 17:13:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57356 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229512AbjCBWNj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Mar 2023 17:13:39 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E01093
        for <linux-kernel@vger.kernel.org>; Thu,  2 Mar 2023 14:13:38 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id C32F1B815B1
        for <linux-kernel@vger.kernel.org>; Thu,  2 Mar 2023 21:36:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 39F6CC433D2;
        Thu,  2 Mar 2023 21:36:05 +0000 (UTC)
Date:   Thu, 2 Mar 2023 16:36:03 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     John Stultz <jstultz@google.com>
Cc:     LKML <linux-kernel@vger.kernel.org>, Wei Wang <wvw@google.com>,
        Midas Chien <midaschieh@google.com>,
        Kees Cook <keescook@chromium.org>,
        Anton Vorontsov <anton@enomsg.org>,
        "Guilherme G. Piccoli" <gpiccoli@igalia.com>,
        Tony Luck <tony.luck@intel.com>, kernel-team@android.com,
        Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: Re: [PATCH] pstore: Revert pmsg_lock back to a normal mutex
Message-ID: <20230302163603.223313ba@gandalf.local.home>
In-Reply-To: <20230302163253.541ac3a8@gandalf.local.home>
References: <20230302062741.483079-1-jstultz@google.com>
        <20230302082414.77613351@gandalf.local.home>
        <CANDhNCo4ruC4pP+iDe49b3e1nAcWtYQj4bx82+oZhyLFYkdFJQ@mail.gmail.com>
        <20230302152103.2618f1b7@gandalf.local.home>
        <20230302163253.541ac3a8@gandalf.local.home>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2 Mar 2023 16:32:53 -0500
Steven Rostedt <rostedt@goodmis.org> wrote:

>    CPU1					CPU2
>    ----					----
> rt_mutex_slowlock_block() {
>   raw_spin_lock_irq(wait_lock);
>   owner = rt_mutex_owner();
>   raw_spin_unlock_irq(wait_lock);
>
>   rtmutex_spin_on_owner(owner) {

I just noticed there's an rcu_read_lock() here around the loop.
I'm guessing that's to keep this race from happening.
Would have been nice to have a comment there stating such.

-- Steve

>     owner = rt_mutex_owner();
> 
>     [ task preempted! (could also be a long interrupt) ]
> 
> 				   owner releases lock and exits
> 				   owner is freed
> 
>     [ task resumes ]
> 
>     if (!owner_on_cpu(owner)
> 
>       READ_ONCE(owner->on_cpu)
>      *** BOOM invalid pointer dereference ***

