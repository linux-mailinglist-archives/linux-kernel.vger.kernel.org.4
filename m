Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7422965C0D1
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Jan 2023 14:30:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233378AbjACN3f (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Jan 2023 08:29:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35340 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233232AbjACN3d (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Jan 2023 08:29:33 -0500
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A0A1D10FFF
        for <linux-kernel@vger.kernel.org>; Tue,  3 Jan 2023 05:29:32 -0800 (PST)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id 53BBF3EA8E;
        Tue,  3 Jan 2023 13:29:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1672752571; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=MvNUKmd/+qxHXxT/ahmWS+4YBdwWe8ucOnQ6cM6C2XI=;
        b=NO7NxCuIdfqyNsl3gUDWScn2H0+9b+BpQDp5Goxtti5CwQ0qQhHPs8hlWlIXc44AqBE8Ak
        kzs7SX2pYEAHgK13K9gqLVvUtLQXKBhvriMNo9RXUX6zoRkFnMZVCYCxTGTLh1kHhxrV7y
        fMtM+Fo4PGcY7+vD0zk1Yjja6WutMtU=
Received: from suse.cz (unknown [10.100.201.202])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id 11B102C141;
        Tue,  3 Jan 2023 13:29:31 +0000 (UTC)
Date:   Tue, 3 Jan 2023 14:29:30 +0100
From:   Petr Mladek <pmladek@suse.com>
To:     John Ogness <john.ogness@linutronix.de>
Cc:     Sergey Senozhatsky <senozhatsky@chromium.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH printk v3 6/6] printk: introduce
 console_prepend_dropped() for dropped messages
Message-ID: <Y7QtusGlIX3AU+TN@alley>
References: <20221221202704.857925-1-john.ogness@linutronix.de>
 <20221221202704.857925-7-john.ogness@linutronix.de>
 <Y7MEDmP1zqWblj0N@alley>
 <87y1qjdimw.fsf@jogness.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87y1qjdimw.fsf@jogness.linutronix.de>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue 2023-01-03 11:26:23, John Ogness wrote:
> On 2023-01-02, Petr Mladek <pmladek@suse.com> wrote:
> >> +static void console_prepend_dropped(struct console_message *cmsg, unsigned long dropped)
> >> +{
> >> +	struct console_buffers *cbufs = cmsg->cbufs;
> >> +	const size_t scratchbuf_sz = sizeof(cbufs->scratchbuf);
> >> +	const size_t outbuf_sz = sizeof(cbufs->outbuf);
> >> +	char *scratchbuf = &cbufs->scratchbuf[0];
> >> +	char *outbuf = &cbufs->outbuf[0];
> >> +	size_t len;
> >> +
> >> +	len = snprintf(scratchbuf, scratchbuf_sz,
> >> +		       "** %lu printk messages dropped **\n", dropped);
> >> +
> >> +	/*
> >> +	 * Make sure outbuf is sufficiently large before prepending. Space
> >> +	 * for a terminator is also counted in case truncation occurs.
> >> +	 */
> >> +	if (WARN_ON_ONCE(len + 1 >= outbuf_sz))
> >> +		return;
> >
> > Strictly speaking, this should be:
> >
> > 	if (WARN_ON_ONCE(len >= outbuf_sz))
> > 		return;
> >
> > The trailing '\0' will fit into the buffer when len < outbuf_sz.
> 
> You are correct.
> 
> My concern was that if "@len = @outbuf_sz - 1", the entire message will
> be truncated and you will only see the dropped messages text. I wanted
> at least 1 character from the message to survive. ;-)

I see.

> How about the commments:
> 
> 	/*
> 	 * Make sure outbuf is sufficiently large before prepending. Space
> 	 * for a terminator and at least 1 byte of the message is also
> 	 * checked in case truncation is needed.
> 	 */

It is better than the original.

Well, what about making sure that something more useful is always
printed. For example:

	/*
	 * Make sure outbuf is sufficiently large before prepending.
	 * Keep at least the prefix when the message has to be truncated.
	 * It is a rather theoretical problem when someone tries to
	 * use a minimalist buffer.
	 */
	if (WARN_ON_ONCE(len + PREFIX_MAX + 1 >= outbuf_sz))
		return;

If we want to use this way. It would probably make sense to
rename PREFIX_MAX to CONSOLE_PREFIX_MAX.

Best Regards,
Petr
