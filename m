Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 44B0765C35D
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Jan 2023 16:55:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233380AbjACPzY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Jan 2023 10:55:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33182 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233158AbjACPzW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Jan 2023 10:55:22 -0500
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EFC9A11C10
        for <linux-kernel@vger.kernel.org>; Tue,  3 Jan 2023 07:55:20 -0800 (PST)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id AF78E34431;
        Tue,  3 Jan 2023 15:55:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1672761319; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=0DOInQfAlC9sXPHhOjtzrZxiECCDaUvA4gDS+HcGDDE=;
        b=Aemb67YmrlyYVarpKx3qttcf3Rd9VAYg0mWCAPM6RlbC9r/ZdMe0pTsoUvBqviRpM1K7bi
        G1ky0RqS9Jb9CfcWSSF0CejvKioHXC3QB70Buj8KgBbC200YmJ5cl5NysmHx3y4mitXb3o
        aAproWjZ7AflFXdJ+FGpPoO6kUsLmxo=
Received: from suse.cz (unknown [10.100.201.202])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id 6D08C2C141;
        Tue,  3 Jan 2023 15:55:19 +0000 (UTC)
Date:   Tue, 3 Jan 2023 16:55:19 +0100
From:   Petr Mladek <pmladek@suse.com>
To:     John Ogness <john.ogness@linutronix.de>
Cc:     Sergey Senozhatsky <senozhatsky@chromium.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH printk v3 5/6] printk: introduce
 console_get_next_message() and console_message
Message-ID: <Y7RP5zuALa552AHY@alley>
References: <20221221202704.857925-1-john.ogness@linutronix.de>
 <20221221202704.857925-6-john.ogness@linutronix.de>
 <87bknva1jg.fsf@jogness.linutronix.de>
 <Y7Q2B+p1gxJ1WCdj@alley>
 <87ilhnd5te.fsf@jogness.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87ilhnd5te.fsf@jogness.linutronix.de>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue 2023-01-03 16:03:17, John Ogness wrote:
> On 2023-01-03, Petr Mladek <pmladek@suse.com> wrote:
> > On Thu 2022-12-22 16:47:39, John Ogness wrote:
> >> On 2022-12-21, John Ogness <john.ogness@linutronix.de> wrote:
> >> > +static bool console_emit_next_record(struct console *con, bool *handover, int cookie)
> >> > +{
> >> > +	bool is_extended = console_srcu_read_flags(con) & CON_EXTENDED;
> >> > +	static char dropped_text[DROPPED_TEXT_MAX];
> >> > +	static struct console_buffers cbufs;
> >> > +	static struct console_message cmsg = {
> >> > +		.cbufs = &cbufs,
> >> > +	};
> >> 
> >> @cmsg should not be static. The whole point of the console_message
> >> wrapper struct is so that it can sit on the stack.
> >
> > Well, it might actually be better to keep it static for now.
> > It always points to static struct console_buffers cbufs anyway.
> >
> > It would make sense to have it on stack only when it uses
> > different buffers.
> 
> I think we should avoid making things static when it serves no purpose.

I agree. Well, I still feel that both structures are tightly
connected and there should be 1:1 relation. See below.

> > Which brings the question. Does it makes sense to use
> > the same buffers by different struct console_message?
> > Will it be safe in any situation?
> >
> > I did not want to complicate it yesterday. I think that
> > I have already proposed this. But this brings back
> > the question whether it makes sense to have two structures
> > at all.
> >
> > I still think that it would be easier and even more safe
> > to put everything into struct console_message.
> >
> > I mean to have:
> >
> > struct console_message {
> > 	char			buf[CONSOLE_EXT_LOG_MAX];
> > 	char			scratch_buf[LOG_LINE_MAX];
> > 	unsigned int		len;
> > 	u64			seq;
> > 	unsigned long		dropped;
> > };
> 
> The current atomic console proposal allocates 1x cbuf per-cpu and 4x
> meta-data per-cpu. Different contexts of a cpu will have different
> meta-data, but all the contexts of a cpu will share the same cbuf.
>
> If cbufs become embedded in cmsg, then we would allocate 1x cmsg
> per-cpu. But the atomic consoles would still need their own 4x per-cpu
> meta-data.

Do we really need 4x the meta data?

The metadata describe the state of the buffer. Using the buffer in one
context invalidates the metadata in the other context.

By other words, if one context reuses the buffer it might also
reuse the metadata. We just need to inform the original context
that it would need to break or re-start the operation.  But we would
need to do this anyway.

This is my intuitive view. It is possible that I miss some
important detail.

> When looking at the proposal code, it looks wrong to have meta-data
> fields in the cmsg struct that are not being used. But maybe that is
> acceptable during the "transition phase" until all legacy consoles are
> gone.

I am not sure what you mean by "not being used".

When I try to find "struct console_buffers" with cscope
than I see it in:

	+ struct console_message definition:
	    + part of the structure

	+ console_prepend_dropped()
	+ console_get_next_message()
	    + both read the pointer from the given struct message

	+ console_emit_next_record()
	    + static definition
	    + the pointer is stored into struct console_message

In all situations, struct console_message is needed when
struct console_buffers is manipulated. By other words,
the metadata are always needed when the buffers are used.

> For v4 I will drop the console_buffers struct. I will use your
> suggestion.

Please, do not do it just to make me happy. My intention
is to keep things simple. And keeping the two structures
synced needs an extra code.

If you are sure that the separation will really be needed
in the future then feel free to keep the two structures.

Best Regards,
Petr
