Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B28CB5F3662
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Oct 2022 21:35:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229826AbiJCTfj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Oct 2022 15:35:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47660 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229934AbiJCTf0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Oct 2022 15:35:26 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E6D9DFAED
        for <linux-kernel@vger.kernel.org>; Mon,  3 Oct 2022 12:35:25 -0700 (PDT)
From:   John Ogness <john.ogness@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1664825722;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=vH1bRlNlt4Tw6mif6Nwjb+aJreUS4CF9rty//8uLA3U=;
        b=wevujbBshGkiBkMMID2lz+ppLj/tbyfBMRm0Mt0BvGikHT0UEuXp7xMbcuUnzOxUdEraFO
        5fnKF2GVeYy9PL4sRoXBhQbnWcWkWBA1AQUo99CVlo8Ssvcf490c3LT8cEmSHXiyr6OMqN
        deySq+Io4YSSmVcyU+gI/x/pugNKAzJAo7UUJD0+H7oU9SojvwYFviu3iASRxr7iBU38+O
        RKOyMXonXDEtMRMGTob1HlF/GSi2CtG5CzNLVi0D/ikvtqZOt70FHC97tK3JSdzbLcHw59
        Gnx2L1V6MxqkY6e231cwq82R0AgQ83lRXdK/CY4AejDWgT83d4IN4W/+68SGHg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1664825722;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=vH1bRlNlt4Tw6mif6Nwjb+aJreUS4CF9rty//8uLA3U=;
        b=uULqQ0bxjPYQW78dimlbXHSh8SM9Kj/rhwvsuJBHNVhU1yWFLc3OQlkxTUFxOobpGCCHr4
        AWOLK70m8OsceoDg==
To:     Petr Mladek <pmladek@suse.com>
Cc:     Sergey Senozhatsky <senozhatsky@chromium.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCH printk 06/18] printk: Protect [un]register_console()
 with a mutex
In-Reply-To: <YzrzmHZYxp8iKEDT@alley>
References: <20220924000454.3319186-1-john.ogness@linutronix.de>
 <20220924000454.3319186-7-john.ogness@linutronix.de>
 <YzMT27FVllY3u05k@alley> <87mtajkqvu.fsf@jogness.linutronix.de>
 <YzW9ExRVjv6PzvWR@alley> <Yza1wxVcH2bsITcs@alley>
 <87leq1uev5.fsf@jogness.linutronix.de> <YzcvvPargLYDHhgq@alley>
 <87zgeg7gnb.fsf@jogness.linutronix.de> <YzrzmHZYxp8iKEDT@alley>
Date:   Mon, 03 Oct 2022 21:41:22 +0206
Message-ID: <87a66c66px.fsf@jogness.linutronix.de>
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

On 2022-10-03, Petr Mladek <pmladek@suse.com> wrote:
> What is exactly wrong with console_lock, please?

It is ambiguously performing multiple tasks:

- protecting the console list
- protecting individual console fields
- serializing console printing
- stopping all console printing

That last item is actually quite complex because nobody really knows
_why_ all consoles need to be stopped. It is mostly because fbdev is
using the console_lock to protect itself from its own write()
callback. But (as has been mentioned in this thread) there are other
code sites where we are not sure which part of the above tasks it is
used for and why.

> Is the main problem that it is a semaphore?

A semaphore has been needed because we are performing global locking for
ambiguous reasons in all possible contexts. We should be using
fine-grained lock and synchronization mechanisms that are appropriate
for their used contexts to precisely lock/synchronize exactly what needs
to be locked/synchronized.

Your first question is literally, "what is wrong with a BKL".

And the answer to that is: A BKL is preventing us from optimizing the
kernel by decoupling unrelated activities.

> The above proposal suggests that it might be something like:
>
> register_console()
> {
> 	console_list_lock();
>
> 	if (!need_console())
> 		goto out;
>
> 	if (!try_enable_console())
> 		goto out;
>
> 	if (!(con->flags & CON_NOBLK))
> 		console_lock()

Why are you taking the console_lock here? The console_list_lock needs to
replace this responsibility. I realize the RFC and this v1 series does
not do this. For v2, it will be clear.

> 	add_console_into_the_list();
>
> 	if (!(con->flags & CON_NOBLK))
> 		console_unlock()

I would request that you continue reviewing the later patches in the
series. Particularly 13-18. My v2 will involve a significantly reworked
version of patches 6-12, not only changing the order of presentation,
but also explicitly removing console list update protection by the
console_lock. I think having actual code to discuss will greatly help us
continue this discussion.

Patches 13-18 will not change much for v2, unless I get some feedback
otherwise.

John
