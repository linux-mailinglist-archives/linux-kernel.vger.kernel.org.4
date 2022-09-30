Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 16FE75F0D37
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Sep 2022 16:16:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231765AbiI3OQj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Sep 2022 10:16:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34834 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231363AbiI3OQh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Sep 2022 10:16:37 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C40AE1A1096
        for <linux-kernel@vger.kernel.org>; Fri, 30 Sep 2022 07:16:33 -0700 (PDT)
From:   John Ogness <john.ogness@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1664547391;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Ry4QlFwo1gESGnrQg4gCqlx6qV7ctJvMWgIsvIMNe9k=;
        b=NudYvBiWcHUcfpPZSIVQAHEihzpl7U2L9iu7+lzpUd3ilO+/kLTwzbL4gVC2pbUsaH9ohh
        zyUc+KWxfzfAzT7aRTEB+IqV0gIMHFW6eKkwJQAmRXtbRW0Zwiq80ZvAcipvp/l31DlOox
        ETV4YnTAQlRUiuZMZwxJwFjWKDFGy8vyG/GsOT5afJ+AffMPAivR94rO9GMp0/8Xo0V/OQ
        nGKtysQQY3Y1HRfXdCW448w6ZgJv/cmFlHqX/e6SC2hL9LIwiuOjklseikw1yyxRcB4KmM
        Qd2Et+j6/7pDN6KGVn7jc9U2tKIZxn7bMTzBl1VyzueVE8Do2WgoAthvZHn7nw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1664547391;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Ry4QlFwo1gESGnrQg4gCqlx6qV7ctJvMWgIsvIMNe9k=;
        b=0Tpl8UFtilzXpwMZ71nVcBnNTw9ivYM+nfxh7+7+q/G7tP327w8gnE1K0Df71vdGQ0H648
        vd8UzodvVykoYSBg==
To:     Petr Mladek <pmladek@suse.com>
Cc:     Sergey Senozhatsky <senozhatsky@chromium.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCH printk 06/18] printk: Protect [un]register_console()
 with a mutex
In-Reply-To: <Yza1wxVcH2bsITcs@alley>
References: <20220924000454.3319186-1-john.ogness@linutronix.de>
 <20220924000454.3319186-7-john.ogness@linutronix.de>
 <YzMT27FVllY3u05k@alley> <87mtajkqvu.fsf@jogness.linutronix.de>
 <YzW9ExRVjv6PzvWR@alley> <Yza1wxVcH2bsITcs@alley>
Date:   Fri, 30 Sep 2022 16:22:30 +0206
Message-ID: <87leq1uev5.fsf@jogness.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
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
> We should actually make the the reading of console->flags safe under
> srcu_read_lock(). It would allow to use the SRCU walk by all the
> readers.

Agreed. I will do this for the next version.

> That said, I could imagine implementing console_lock() so that it
> would be implemented by mutex when the legacy mode is disabled and
> semaphore when it is allowed.

No, let's not imagine this. It is d=C3=A9j=C3=A0 vu for the code that was
reverted.

> You were talking about command-line option that would allow to
> disable the legacy mode on production RT systems. And I guess
> that you added mutex because it behaves better on RT.

We added mutex because list updates are always in may_sleep context and
we were moving to SRCU for list iteration. I think with v2, where SRCU
will be introduced earlier, things will be much clearer.

> Also I could imagine using console_list_lock() as a wrapper
> to console_lock(). It might help to distinguish locations where
> the list is traversed and where the console_lock() is used for
> another reason. I mean to remove the big-kernel-lock character
> of the console_lock().

No, locking the list should have nothing to do with console_lock(). We
want to remove the list synchronization responsibilities from
console_lock(). In this series, I did not make that clear in the commit
messages. (Perhaps it was not entirely clear to me then.) For v2 I will
make this point very clear.

> You know, the more locks we have, the bigger is the risk of
> deadlocks, and the more hacks would be needed in
> console_flush_on_panic(). And I am afraid
> that console_lock() will be with us for many years and
> maybe forever.

Sure. Removing console_lock() will be a long battle involving many
drivers. I am not trying to fight that battle right now. I just want
console_lock() out of the way of NOBKL consoles.

John
