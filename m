Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7B057646BEC
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Dec 2022 10:29:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229643AbiLHJ3M (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Dec 2022 04:29:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58430 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229470AbiLHJ3J (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Dec 2022 04:29:09 -0500
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B57A01A22E
        for <linux-kernel@vger.kernel.org>; Thu,  8 Dec 2022 01:29:08 -0800 (PST)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id F399220806;
        Thu,  8 Dec 2022 09:29:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1670491747; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=LhmyqWqeeq8ium6fraqzoGU/VqrdLX5bpmPbP9dUApA=;
        b=DUHa84UrL3XMkAQWdjcVSddi3poJC/fKJzZL2uPcArjLTiRuf3UF619y6iFtlMgJL8QROa
        6TIeRDozaF/m6oV2X3j1Qzxv7kjdDp9yOcRYhQHhc4J5Y0BZx6cgVj8nIqQWh/PKAwzWZV
        F3qlgbvjQR6i8gQDUBgnPdAyjkLmqgY=
Received: from suse.cz (unknown [10.100.201.202])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id ACCC32C916;
        Thu,  8 Dec 2022 09:29:06 +0000 (UTC)
Date:   Thu, 8 Dec 2022 10:29:06 +0100
From:   Petr Mladek <pmladek@suse.com>
To:     John Ogness <john.ogness@linutronix.de>
Cc:     Sergey Senozhatsky <senozhatsky@chromium.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH printk v2 7/7] printk: Handle dropped message smarter
Message-ID: <Y5GuYvj6VRnhN0+H@alley>
References: <20221123231400.614679-1-john.ogness@linutronix.de>
 <20221123231400.614679-8-john.ogness@linutronix.de>
 <Y5CMD8iZND3rgugG@alley>
 <87h6y71773.fsf@jogness.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87h6y71773.fsf@jogness.linutronix.de>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed 2022-12-07 18:04:56, John Ogness wrote:
> On 2022-12-07, Petr Mladek <pmladek@suse.com> wrote:
> >> +	/*
> >> +	 * Append the record text to the dropped message so that it
> >> +	 * goes out with one write.
> >> +	 */
> >> +	memcpy(ext_text + len, &cbufs->text[0], cmsg->outbuf_len);
> >> +
> >> +	/* Update the output buffer descriptor. */
> >> +	cmsg->outbuf = ext_text;
> >> +	cmsg->outbuf_len += len;
> >
> > I still think that it would be better to rename the buffers in
> > struct console_message and avoid the switches of the purpose
> > of the two buffers.
> >
> > We could print the message about dropped text into a local buffer
> > on stack. IMHO, 64 bytes are acceptable. And we could insert it
> > into the outbuf by shuffling the existing text. Something like:
> >
> > static void msg_print_dropped(struct console_message *cmsg,
> > 			      unsinged long dropped)
> > {
> > 	char dropped_msg[DROPPED_TEXT_MAX];
> > 	int dropped_len;
> >
> > 	if (!con->dropped)
> > 		return 0;
> >
> > 	/* Print it into ext_text, which is unused. */
> > 	dropped_len = snprintf(dropped_msg, sizeof(dropped_msg),
> > 		       "** %lu printk messages dropped **\n", con->dropped);
> >
> > 	/*
> > 	 * The buffer might already be full only where the message consist
> > 	 * of many very short lines. It is not much realistic.
> > 	 */
> > 	if (cmsg->outbuf_len + dropped_len + 1 > sizeof(cmsg->outbuf)) {
> > 		/* Should never happen. */
> 
> This certainly can happen. @text is size CONSOLE_LOG_MAX, which is
> LOG_LINE_MAX+PREFIX_MAX. So a totally legal formatted message of length
> LOG_LINE_MAX-1 and a prefix will suddenly become truncated.
> 
> > 		if (WARN_ON_ONCE(dropped_len + 1 > sizeof(cmsg->outbuf)))
> > 			return;
> >
> > 		/* Trunk the message like in record_print_text() */
> > 		cmsg->outbuf_len = sizeof(cmsg->outbuf) - dropped_len;
> > 		cmsg->outbuf[cmsg->outbuf_len] = '\0';
> > 	}
> >
> > 	memmove(cmsg->outbuf + dropped_len, cmsg->outbuf, cmsg->outbuf_len + 1);
> > 	memcpy(cmsg->outbuf, dropped_msg, dropped_len);
> > }
> 
> I do not like the idea of increasing stack usage, possibly cutting off
> messages, and performing extra memory operations all because of some
> variable naming. There is literally a larger unused buffer just sitting
> there.

Sigh. Your approach is copying buffers:

    DROPPED_LOG_MAX + CONSOLE_LOG_MAX -> CONSOLE_EXT_LOG_MAX

which means:

    64 + 1024 -> 8182

The important thing is that it will shrink the text in
record_print_text() to 1024.

With my approach, it would shrink the text here to 8182 - 64 = 8118.

> I want struct console_buffers to be a black box of working buffers used
> to process the different types of messages. console_get_next_message()
> is the only function that should go inside that black box because it is
> responsible for creating the actual message.
> 
> The caller does not care what is in the black box or how those internal
> working buffers are named. The caller just cares about cmsg->outbuf and
> cmsg->outbuf_len, which will point to the data that needs to be written
> out.
> 
> For v3 I would like to try my approach one more time. I will give the
> internal buffers new names so as not to mislead their roles. I will
> clearly document the black box nature of struct console_buffers.

This is probably my last mail on this matter[*]. I do not want to get
stuck here. But I really do not see any advantage in your approach:

    + The risk of shrinking the text is bigger.

    + The buffer is accessed via one more dereference that might
      eventually point to a wrong buffer if there is a bug.

    + The size of the buffer is not clear via the dereference
      and might be wrong if there is a bug.

    + The more layers, the more code complexity, like more names.


The only argument might be the 64B on stack. But it is nothing against
namebuf[KSYM_NAME_LEN] that is used in kallsyms code that might be
called via vsprintf.c. It is 512B on the stack. So I do not take it.

Another argument might be if you wanted to use the buffers yet another
way in the atomic consoles. But I guess (hope) that they will always
work only with the "outbuf".

[*] I think that I'll learn how to live with whatever you use in v3 :-)

Best Regards,
Petr
