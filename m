Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 57135614611
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Nov 2022 09:57:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229935AbiKAI5h (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Nov 2022 04:57:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40038 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229875AbiKAI5e (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Nov 2022 04:57:34 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3DA9717E26
        for <linux-kernel@vger.kernel.org>; Tue,  1 Nov 2022 01:57:32 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id 474A12019D;
        Tue,  1 Nov 2022 08:57:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1667293050; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=wtNsnDDmw/y8+B/JJiPR8TmQN8BlInC5LCvuB8Rzxio=;
        b=ZfhEAdbVkUYECm7HqlvS+W+TMbqg33CxB1gslIx1LxMSZOON6U+ZgBn12gplDJ9WLKIbZm
        bL2TfcGdiJBeW1+4VYJd7QmxgJuFGj9QVEVSzHMQz+6t/7TI+L88vpgm4o3juyq3HCEkUd
        OkB78aXku/9tMra4SY2aRo5vuSHEO2U=
Received: from suse.cz (unknown [10.100.208.146])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id 09DF62C141;
        Tue,  1 Nov 2022 08:57:29 +0000 (UTC)
Date:   Tue, 1 Nov 2022 09:57:26 +0100
From:   Petr Mladek <pmladek@suse.com>
To:     John Ogness <john.ogness@linutronix.de>
Cc:     Sergey Senozhatsky <senozhatsky@chromium.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        linux-m68k@lists.linux-m68k.org
Subject: Re: [PATCH printk v2 06/38] tty: nfcon: use console_is_enabled()
Message-ID: <Y2Dfdje2x34VvWMb@alley>
References: <20221019145600.1282823-1-john.ogness@linutronix.de>
 <20221019145600.1282823-7-john.ogness@linutronix.de>
 <Y1Jspm1n3t0bgIym@alley>
 <87fsf49e6d.fsf@jogness.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87fsf49e6d.fsf@jogness.linutronix.de>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon 2022-10-31 17:05:54, John Ogness wrote:
> On 2022-10-21, Petr Mladek <pmladek@suse.com> wrote:
> >> diff --git a/arch/m68k/emu/nfcon.c b/arch/m68k/emu/nfcon.c
> >> index 557d60867f98..c542fc2b121f 100644
> >> --- a/arch/m68k/emu/nfcon.c
> >> +++ b/arch/m68k/emu/nfcon.c
> >> @@ -151,7 +151,7 @@ static int __init nfcon_init(void)
> >>  
> >>  	nfcon_tty_driver = driver;
> >>  
> >> -	if (!(nf_console.flags & CON_ENABLED))
> >> +	if (!console_is_enabled(&nf_console))
> >
> > Heh, the check of CON_ENABLED does not make much sense. IMHO, the
> > important thing is whether the console is in console_list or not.
> >
> > I would personally add a check at the beginning of register_console()
> > whether the console is already registered and enabled() and do
> > nothing when already done.
> 
> Actually, register_console() already has this check, but it does a
> WARN(). If the debug setup is used for nfcon, this situation is
> normal.

I see.

> So probably to avoid the WARN, the CON_ENABLED code was added.

I though more about it. I would keep the warning for the case
when the 2nd registration is not intentional.

This driver has two ways how the console can be registered.
It can happen either in nfcon_init() or in nf_debug_setup().
It is better to have an explicit check to show that it is intentional.


> > I would be nice to fix this. But it might be done later.
> 
> I could add a console_is_registered() function that checks if the
> console is in the console list and use that instead. If we are going to
> touch this code, we might as well touch it correctly, right?

It would be great. It is actually much easier after switching
to the hlist.

Best Regards,
Petr
