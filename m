Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 36C415F139E
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Sep 2022 22:26:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231436AbiI3U0k (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Sep 2022 16:26:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44110 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232051AbiI3U0f (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Sep 2022 16:26:35 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A2EE01684EA
        for <linux-kernel@vger.kernel.org>; Fri, 30 Sep 2022 13:26:34 -0700 (PDT)
From:   John Ogness <john.ogness@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1664569593;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=eR5F8zh+gVOVUrjuiwLo4ZnAbF6Jcd5fH1eeYTZ35EE=;
        b=45y2uM0NwnAtCedH1yi7L5RfMKbuMDrJxTmYkjQXccB3XKC5jqC/difq+ZI+ygtMT4caqa
        uBklhhAnZiVF6KzuOJ2rhsYafflr7Ev6hATHGwzOwyA4iuisZ8A8fLkf0iDBcUoRwf67l0
        6w+YfgYzW28KWrHoCOIHth+j69+FoAACVm4w9n4eS5rPu8J4HGMFh5TvZlXsBHBR31FArA
        ltpLGf8c+HOlkiDczjdZTIYfmG/ep84BUPASe4/if9JaoDoDEfl5UZzVD4qN1VO1k25nBE
        4+4drTXRhKPgc+qKLf1/wIzpdUi+aYSapcURmHlZ/r5XfCgPLNzSDZzt98nQeA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1664569593;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=eR5F8zh+gVOVUrjuiwLo4ZnAbF6Jcd5fH1eeYTZ35EE=;
        b=AdOzpg09oBSeOR6YCZpI2qEWONXglNcp5N1FOpg9+GfNUAi8m+HR7XgKqyYByOP0ALve+w
        BBIk1oOKTR6eMiAw==
To:     Petr Mladek <pmladek@suse.com>
Cc:     Sergey Senozhatsky <senozhatsky@chromium.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCH printk 06/18] printk: Protect [un]register_console()
 with a mutex
In-Reply-To: <YzcvvPargLYDHhgq@alley>
References: <20220924000454.3319186-1-john.ogness@linutronix.de>
 <20220924000454.3319186-7-john.ogness@linutronix.de>
 <YzMT27FVllY3u05k@alley> <87mtajkqvu.fsf@jogness.linutronix.de>
 <YzW9ExRVjv6PzvWR@alley> <Yza1wxVcH2bsITcs@alley>
 <87leq1uev5.fsf@jogness.linutronix.de> <YzcvvPargLYDHhgq@alley>
Date:   Fri, 30 Sep 2022 22:32:32 +0206
Message-ID: <87zgeg7gnb.fsf@jogness.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-3.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,INVALID_DATE_TZ_ABSURD,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022-09-30, Petr Mladek <pmladek@suse.com> wrote:
> You want to get cosole_lock() out of the way of NOBKL consoles. What
> does it exactly mean, please?

It means that a system with only NOBKL consoles will never take the
console_lock.

> What code paths are important to achieve this?

Anything that iterates or queries the consoles is taking the
console_lock right now. We want that code to use something else for
those tasks (console_srcu, console_mutex, atomic_state).

> From my POV, the most important code path is the kthread. But
> it should use SRCU. I mean that the kthread will take neither
> cosnole_lock() nor console_list_lock().

All iterators and querying are important because they need a safe
interface that does not rely on console_lock.

> Is there any other code path where console_list_lock() will help
> you to get console_lock() out of the way?

The difficulty arises because we are trying to share as much code as
possible. So, for example, NOBKL consoles are sitting on the same list
as legacy consoles. And since currently the list is protected by the
console_lock, we need to change how that list is protected.

> From my POV, both locks serialize the same things
> (console_list manipulation).

My v2 will hopefully change your POV. I will make it clear (in comments
and implementation) that the console_lock does _not_ protect the console
list. All iteration and querying will have no choice but to use the new
mechanisms for list iteration and checking/setting CON_ENABLED.

Then the console_lock's only function is to block legacy consoles from
printing and making sure that multiple legacy consoles are not printing
in parallel. And, of course, it will still function as a general BKL
lock for fbdev, which may be relying on its locking function to
synchronize some fbdev data.

Note that the end result will be no change in behavior for legacy
consoles. But it allows legacy and NOBKL consoles to run simultaneously
while sharing significant amounts of code, and provides a clear path for
console drivers to begin converting. As a side-effect, the first step of
reducing the scope of the console_lock will have been taken.

John
