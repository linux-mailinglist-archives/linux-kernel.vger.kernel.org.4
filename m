Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6FE326BE873
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Mar 2023 12:41:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230026AbjCQLkw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Mar 2023 07:40:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35398 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229911AbjCQLku (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Mar 2023 07:40:50 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 020C530B35
        for <linux-kernel@vger.kernel.org>; Fri, 17 Mar 2023 04:40:18 -0700 (PDT)
From:   John Ogness <john.ogness@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1679053169;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=viHUe0m9pAZugGnwSdcKI3v7VOxDcDms7fqm5rtW3kA=;
        b=TEFGUe0N8MlrE+10SsfUrnxH68IEPw1HPU6PgdwKhwtBseoTBtTE+W/7vF8vWPj1cHK518
        oLJ0gDzLp7hMrWBNRjwLGr+M7chfwe6LWQju5DiGmCXGhvHWbtslC/ECOoMn84J3wVB7LO
        EeuSptHO+5hy+r2f3wWkRGKUasjhfUpyVQv2/5fpU0xbZfPMg+0ivUhNCBzODPI+zeEdtN
        aY6qYjUUtus+p5c/gbxyK56eKeh8x5VAzHUjI39KDc6+vVs0xcDUs0DcHXOAIxIAk5Iyqh
        8PSP1zxP9lj+y8WbagzTPXsO+1SWIYp/KcKIASKkX16zmKh34vx9JhcfHeCSrg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1679053169;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=viHUe0m9pAZugGnwSdcKI3v7VOxDcDms7fqm5rtW3kA=;
        b=T90Jmz/+TOc/RmXSEgcdDZYVEwWf3ZWMmAwCwLLHtNL8Pw7IWNGD/CF02tBkOJy6hClxew
        BCY9bXZ1C4nCslCA==
To:     Petr Mladek <pmladek@suse.com>
Cc:     Sergey Senozhatsky <senozhatsky@chromium.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH printk v1 02/18] printk: Add NMI check to
 down_trylock_console_sem()
In-Reply-To: <ZAdgtcbPyQ/8dIDw@alley>
References: <20230302195618.156940-1-john.ogness@linutronix.de>
 <20230302195618.156940-3-john.ogness@linutronix.de>
 <ZAdgtcbPyQ/8dIDw@alley>
Date:   Fri, 17 Mar 2023 12:43:56 +0106
Message-ID: <874jqj7gmj.fsf@jogness.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-3.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,INVALID_DATE_TZ_ABSURD,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2023-03-07, Petr Mladek <pmladek@suse.com> wrote:
> So that this change would cause a non-paired console_unlock().
> And console_unlock might still deadlock on the console_sem->lock.

Yes, but at least it would have flushed beforehand.

> One solution would be to call console_flush_all() directly in
> console_flush_on_panic() without taking console_lock().
>
> It should not be worse than the current code which ignores
> the console_trylock() return value.

I think your suggestion is acceptable.

> Note that it mostly works because console_flush_on_panic() is called
> when other CPUs are supposed to be stopped.
>
> We only would need to prevent other CPUs from flushing messages
> as well if they were still running by chance. But we actually already
> do this, see abandon_console_lock_in_panic(). Well, we should
> make sure that the abandon_console_lock_in_panic() check is
> done before flushing the first message.
>
> All these changes together would prevent deadlock on
> console_sem->lock.  But the synchronization "guarantees" should stay
> the same.

We could also update console_trylock() and console_lock() to fail and
infinitely sleep, respectively, when abandon_console_lock_in_panic() is
true. That would prevent CPUs from newly acquiring the console lock and
interfering with the panic CPU.

John
