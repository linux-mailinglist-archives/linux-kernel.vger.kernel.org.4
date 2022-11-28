Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2931863A577
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Nov 2022 10:54:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229961AbiK1Jyy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Nov 2022 04:54:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38666 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230062AbiK1Jyv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Nov 2022 04:54:51 -0500
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 91D5B193ED
        for <linux-kernel@vger.kernel.org>; Mon, 28 Nov 2022 01:54:50 -0800 (PST)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id 4AE651FD99;
        Mon, 28 Nov 2022 09:54:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1669629289; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=ISssLa18CUTwPBQRBeNxJEbCOcj8hIPBn1soCItpu3A=;
        b=f0waiqHqf9KoJfh8cp9iuzUINbfGYy46lfh7cQFB6DquHprxAJnyBSLbmTmj7ByUowpcSC
        w1prja7gLOIN0OtIgryp9fDvfTkPm8JcTa97WDcdOover4ub7RI0dpDKOG7lYEKrcH9YkB
        oH19VtrIhH2P3tgDH9XhFkqVwLoVrqw=
Received: from suse.cz (unknown [10.100.201.202])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id 06E402C141;
        Mon, 28 Nov 2022 09:54:49 +0000 (UTC)
Date:   Mon, 28 Nov 2022 10:54:48 +0100
From:   Petr Mladek <pmladek@suse.com>
To:     John Ogness <john.ogness@linutronix.de>
Cc:     Sergey Senozhatsky <senozhatsky@chromium.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCH printk v2 6/7] printk: Use an output buffer descriptor
 struct for emit
Message-ID: <Y4SFaB5O0JtfQ6MO@alley>
References: <20221123231400.614679-1-john.ogness@linutronix.de>
 <20221123231400.614679-7-john.ogness@linutronix.de>
 <Y3+xK7hHmUIlzq9w@alley>
 <87o7swkqar.fsf@jogness.linutronix.de>
 <Y4CEb7a57PpFpDni@alley>
 <87sfi7s407.fsf@jogness.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87sfi7s407.fsf@jogness.linutronix.de>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri 2022-11-25 11:55:28, John Ogness wrote:
> On 2022-11-25, Petr Mladek <pmladek@suse.com> wrote:
> >> The "problem" with this idea is that record_print_text() creates the
> >> normal output in-place within the readbuf. So for normal messages with
> >> no dropped messages, we still end up writing out the readbuf.
> >
> > We handle this this in console_get_next_message() by reading the
> > messages into the right buffer:
> >
> > 	struct console_buffers {
> > 		char	outbuf[CONSOLE_EXT_LOG_MAX];
> > 		char	readbuf[CONSOLE_LOG_MAX];
> > 	};
> >
> > 	boot is_extcon = console_srcu_read_flags(con) & CON_EXTENDED;
> >
> > 	/*
> > 	 * Normal consoles might read the message into the outbuf directly.
> > 	 * Console headers are added inplace.
> > 	 */
> > 	if (is_extcon)
> > 		prb_rec_init_rd(&r, &info, &cbufs->readbuf[0], sizeof(cbufs->readbuf));
> > 	else
> > 		prb_rec_init_rd(&r, &info, &cbufs->outbuf[0], sizeof(cbufs->outbuf));
> >
> > 	if (!prb_read_valid(prb, con->seq, &r))
> > 		return false;
> 
> We do not know if there will be dropped messages until _after_ we call
> prb_read_valid().

Yes.

> > 	if (is_extcon) {
> > 		len = info_print_ext_header(cbufs->outbuf, sizeof(cbufs->outbuf, r.info);
> > 		len += msg_print_ext_body(cbufs->outbuf + len, sizeof(cbufs->outbuf) - len,
> > 				  &r.text_buf[0], r.info->text_len, &r.info->dev_info);
> > 	} else {
> > 		len = record_print_text(&r, console_msg_format & MSG_FORMAT_SYSLOG, printk_time);
> > 	}
> 
> And the dropped messages should be inserted now somewhere too.
> 
> The fact is that we need two different sized buffers. Which one is used
> for output is not known in advance. I think it is misleading to name the
> variables based on their purpose because their purpose changes depending
> on the situation.

I still think that changing the purpose of the buffers complicates
the code[*] and is potential source of problems. It might be even
a sign of a bad design. IMHO, it would be a big win if the buffers
have a better defined meaning.

The message about dropped messages is rather short. What about
using a small buffer on stack. And adding it into outbuf
by shuffling the existing message. It is not that complicated.
IMHO, it would be worth it.

> > I could imagine adding these metadata into the struct console_buffers.
> > Or we could call it struct console_messages from the beginning.
> >
> > We could even completely move con->seq, con->dropped into this new
> > structure. It would safe even more copies.
> 
> Well, consoles still need to have their own copy of @seq and @dropped
> for proper per-console tracking. But the buffers are globally shared.

Right. I have missed this. OK, what about the following?

struct console_buffers {
	char	outbuf[CONSOLE_EXT_LOG_MAX];
	char	readbuf[CONSOLE_LOG_MAX];
};

struct console_message {
	struct console_buffers *bufs;
	u64 seq;
	unsigned long dropped;
	unsigned int len;  ???
};

struct console {
[...]
	struct console_message *msg;
[...]
};

It will cause that the buffers will be on the 3rd level of
nesting. But I think that we would use the following everywhere
anyway:

void console_func(struct console *con)
{
	char *outbuf = con->bufs->outbuf;

	do_something(outbuf);
}

We could actually even use in console_get_next_message():

	/*
	 * Normal console headers are added inplace. Extended console
	 * headers need to read the messages into a separate buffer.
	 */
	if (is_extcon) {
		readbuf = con->bufs->readbuf;
		redbuf_size = sizeof(con->bufs->readbuf);
	} else {
		readbuf = con->bufs->outbuf;
		redbuf_size = sizeof(con->bufs->outbuf);
	}

IMHO, this should be the only function where this "hack"
would be needed. All others would work just with outbuf.

IMHO, one big advantage is using the same names everywhere.
Another advantage is that it won't be necessary to copy
the values between different structures.

> For this series I will drop @is_extmsg from struct console_message and
> instead make it an argument of console_get_next_message() and
> msg_print_dropped(). That makes more sense at this point. (It needs to
> be a variable because it is not safe to re-read flags multiple times
> when constructing the message.)
> 
> For v3 I will move the two buffers (with whatever name we decide is
> best) into struct console_message and remove the struct console_buffers
> definition. That will also remove the use of @cbufs everywhere.

This looks like a bad idea after all. I forgot that we wanted to share
the buffers between non-atomic consoles. It would be ugly to share
also the metadata, like @seq.

That said, I do not want to get stuck on this. If you still
do not like my proposal feel free to keep the text/text_ext
buffers and struct console_message abstraction. I think that
I could live with it.

Best Regards,
Petr
