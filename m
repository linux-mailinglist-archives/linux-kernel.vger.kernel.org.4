Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D1B3165F148
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Jan 2023 17:36:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234158AbjAEQgn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Jan 2023 11:36:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36520 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232270AbjAEQgl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Jan 2023 11:36:41 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 021192F789
        for <linux-kernel@vger.kernel.org>; Thu,  5 Jan 2023 08:36:41 -0800 (PST)
From:   John Ogness <john.ogness@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1672936599;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=+ljOGUvE1bAy/pIVJBfhvpCdAhf1KnwfDWp0uh6zmN4=;
        b=aoi4o8/bAa74yIvTmLs+NDL+J0mq+0isM4bFr2ix30AGmX8DL1l6R+rlLbtqQp2pB9Alg/
        My1EPmRHG/o3hgx/FmLR/55Nq8GQh5bQxZW4p4t82CIfHJRHT3319XHB/mTpIY+toDJLMC
        oij1+d/qoMQ9tVe8yVaO28Vnnzqy3QNiOvwpnzX3sRI+VZMLNIKFZGPKPWlkob7LHfCkyH
        PI0EqaCrUhGk0/mHDgmCrp5/5japDncSQdv9xb9fusuu4NyJ+IWU2pflRyTl5ltF3lRftA
        ftqyhDTeFdNNetYUQEZQ7WZKyz5ASgwv+jddX3nA/7syeCFqoBf9CtX02bZefA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1672936599;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=+ljOGUvE1bAy/pIVJBfhvpCdAhf1KnwfDWp0uh6zmN4=;
        b=VlTwAqc2ZlYxSVX2MrRwmDVoROuI7X0WZWsnzxd3hDtuiE+OaBecZ0+6FS/OfCeGmrKyfb
        AhysShYLPuFnugAA==
To:     Petr Mladek <pmladek@suse.com>
Cc:     Sergey Senozhatsky <senozhatsky@chromium.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH printk v4 6/8] printk: introduce
 console_prepend_dropped() for dropped messages
In-Reply-To: <Y7b4AND0DRs7jPW9@alley>
References: <20230105103735.880956-1-john.ogness@linutronix.de>
 <20230105103735.880956-7-john.ogness@linutronix.de>
 <Y7b4AND0DRs7jPW9@alley>
Date:   Thu, 05 Jan 2023 17:41:59 +0106
Message-ID: <87y1qhaqhc.fsf@jogness.linutronix.de>
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

On 2023-01-05, Petr Mladek <pmladek@suse.com> wrote:
>> +	if (WARN_ON_ONCE(len + PREFIX_MAX >= outbuf_sz))
>> +		return;
>
> I guess that this will always trigger the compiler warning
> when CONFIG_PRINTK is disabled. See the report for v3 at
> https://lore.kernel.org/r/202301052114.vvN3wQoH-lkp@intel.com

That report is actually complaining about the check after this one. It
is the same "problem".

> Hmm, we might want to fix this warning so that it does not break
> build with -Werror.
>
> IMHO, the proper solution would be to define this function only when
> CONFIG_PRINTK is defined. But it might require bigger changes
> and define many more console functions only when CONFIG_PRINTK
> is defined. This is out-of-scope of this patchset.
>
> I wonder if the following would work as an "intermediate" workaround:
>
> 	if (!IS_ENABLED(CONFIG_PRINTK) ||
> 	    WARN_ON_ONCE(len + PREFIX_MAX >= outbuf_sz))
> 		return;

The whole CONFIG_PRINTK stuff is a total mess right now. We should
definitely get that cleaned up at some point. As an intermediate
workaround, it might make more sense to just put the whole function
inside an "#ifdef CONFIG_PRINTK". It doesn't return anything anyway.

#ifdef CONFIG_PRINTK
static void console_prepend_dropped(struct printk_message *pmsg, unsigned long dropped)
{
...
}
#else
#define console_prepend_dropped(pmsg, dropped)
#endif

There are already places in the code that look like this (for example,
print_caller()).

Otherwise, if you want to use IS_ENABLED(), you will need it for both
checks.

John
