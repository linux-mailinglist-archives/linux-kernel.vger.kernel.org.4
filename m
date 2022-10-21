Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7654560742F
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Oct 2022 11:37:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230116AbiJUJhQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Oct 2022 05:37:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47800 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229587AbiJUJhO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Oct 2022 05:37:14 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E2141EB57E
        for <linux-kernel@vger.kernel.org>; Fri, 21 Oct 2022 02:37:13 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id D25A11F8E6;
        Fri, 21 Oct 2022 09:37:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1666345031; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=SP/xOFq5VWAiT02lFf7m/dkOT2AkY39WiNsp2spIQFY=;
        b=EOrUXXm8fy36SGxog6SS8Qy3YOQDu9TlhOSUN4uipD3n75CtwFW/iPoDgA+0XVZq37nAKT
        3AapXkDGNHIzNebGPp7n+YZDUkzq8d4QXFLm5cdNUQd7OXbWXg5/NqzR7aiPeCf90GQhTV
        aOVtFr+/HhT3Iy5PaHlmlJ4qb/sUoDc=
Received: from suse.cz (unknown [10.100.208.146])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id AD3012C141;
        Fri, 21 Oct 2022 09:37:11 +0000 (UTC)
Date:   Fri, 21 Oct 2022 11:37:11 +0200
From:   Petr Mladek <pmladek@suse.com>
To:     John Ogness <john.ogness@linutronix.de>
Cc:     Sergey Senozhatsky <senozhatsky@chromium.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCH printk v2 04/38] printk: introduce console_is_enabled()
 wrapper
Message-ID: <Y1JoR+kqMU9FRUBh@alley>
References: <20221019145600.1282823-1-john.ogness@linutronix.de>
 <20221019145600.1282823-5-john.ogness@linutronix.de>
 <Y1JfFTAIbcFOrPtD@alley>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y1JfFTAIbcFOrPtD@alley>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri 2022-10-21 10:57:58, Petr Mladek wrote:
> On Wed 2022-10-19 17:01:26, John Ogness wrote:
> > After switching to SRCU for console list iteration, some readers
> > will begin accessing console->flags as a data race. This is safe
> > because there is at most one CPU modifying console->flags and
> > using rmw operations.
> > 
> > The primary reason for readers to access console->flags is to
> > check if the console is enabled. Introduce console_is_enabled()
> > to mark such access as a data race.
> > 
> > Signed-off-by: John Ogness <john.ogness@linutronix.de>
> > ---
> >  include/linux/console.h | 20 ++++++++++++++++++++
> >  1 file changed, 20 insertions(+)
> > 
> > diff --git a/include/linux/console.h b/include/linux/console.h
> > index cff86cc615f8..60195cd086dc 100644
> > --- a/include/linux/console.h
> > +++ b/include/linux/console.h
> > @@ -172,6 +172,26 @@ extern void console_srcu_read_unlock(int cookie);
> >  
> >  extern struct hlist_head console_list;
> >  
> > +/**
> > + * console_is_enabled - Check if the console is enabled
> > + * @con:	struct console pointer of console to check
> > + *
> > + * This should be used instead of manually testing for the CON_ENABLED
> > + * bit in the console->flags.
> > + *
> > + * Context: Any context.
> > + */
> > +static inline bool console_is_enabled(const struct console *con)
> > +{
> > +	/*
> > +	 * If SRCU is used, reading of console->flags can be a data
> > +	 * race. However, this is safe because there is at most one
> > +	 * CPU modifying console->flags and it is using only
> > +	 * read-modify-write operations to do so.
> 
> Hmm, I somehow do not understand the explanation. How does
> read-modify-write operation make this safe, please?
> 
> We are interested into one bit. IMHO, it is not important
> if the flags variable is modified atomically or byte by byte.
> The important thing is if the reading is synchronized against
> modifications.
> 
> This function does not do any synchronization on its own.
> So, it depends on the caller.
> 
> 
> I would personally do two variants. for example:
> 
>     console_is_enabled()
>     console_is_enabled_safe()
> 
> The first variant would be called in situations where the race
> does not matter and the other when it matters.

Still thinking about it.

It is possible that console_is_enabled_safe() variant won't be
needed because all the callers will be either naturally serialized
or can be racy.

By other words, it makes sense to use data_race() because there are
used racy checks. And there probably is not any caller that would
strictly require explicit synchronization when reading this flag.

Anyway, if there is any caller that would require explicit
synchronization than we need a variant without data_race().

It would be great to somehow explain this in the commit message.

Best Regards,
Petr
