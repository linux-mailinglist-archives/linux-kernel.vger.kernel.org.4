Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0DAC06385CA
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Nov 2022 10:01:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229769AbiKYJBq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Nov 2022 04:01:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47130 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229739AbiKYJBm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Nov 2022 04:01:42 -0500
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BADA531FAC
        for <linux-kernel@vger.kernel.org>; Fri, 25 Nov 2022 01:01:40 -0800 (PST)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id 6098721AAD;
        Fri, 25 Nov 2022 09:01:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1669366899; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=8KBBxMgrMdqbWWjnCjbmhEDCO2E0mxKk+X1L9Pdof78=;
        b=dDZkK6MFpqk1iBum5NBrbZ8A+c/Y8y0RFsUbfTWAdOe7B6e5/JBlEwck7nch1LSNtVKYAb
        pOhfamKHZIbCRL6ZReq88DII4qRDFFfKCLwmb1bf9qohbvWiCDJfLTBJTSn5ltMFVd0tfw
        Pzqh/KaIguLNwVaoYgHWEB6E2T2Oql4=
Received: from suse.cz (unknown [10.100.201.202])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id 2C4302C141;
        Fri, 25 Nov 2022 09:01:39 +0000 (UTC)
Date:   Fri, 25 Nov 2022 10:01:35 +0100
From:   Petr Mladek <pmladek@suse.com>
To:     John Ogness <john.ogness@linutronix.de>
Cc:     Sergey Senozhatsky <senozhatsky@chromium.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCH printk v2 6/7] printk: Use an output buffer descriptor
 struct for emit
Message-ID: <Y4CEb7a57PpFpDni@alley>
References: <20221123231400.614679-1-john.ogness@linutronix.de>
 <20221123231400.614679-7-john.ogness@linutronix.de>
 <Y3+xK7hHmUIlzq9w@alley>
 <87o7swkqar.fsf@jogness.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87o7swkqar.fsf@jogness.linutronix.de>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu 2022-11-24 22:21:08, John Ogness wrote:
> On 2022-11-24, Petr Mladek <pmladek@suse.com> wrote:
> > I wish, this change was done in two patches. 1st introducing and
> > using struct console_message. 2nd moving the code into separate
> > console_get_next_message().
> 
> OK.
> 
> >> +	if (cmsg->is_extmsg) {
> >> +		write_text = &cbufs->ext_text[0];
> >> +		write_text_size = sizeof(cbufs->ext_text);
> >> +		len = info_print_ext_header(write_text, write_text_size, r.info);
> >> +		len += msg_print_ext_body(write_text + len, write_text_size - len,
> >> +					  &r.text_buf[0], r.info->text_len, &r.info->dev_info);
> >> +	} else {
> >> +		write_text = &cbufs->text[0];
> >> +		len = record_print_text(&r, console_msg_format & MSG_FORMAT_SYSLOG, printk_time);
> >> +	}
> >> +
> >> +	cmsg->outbuf = write_text;
> >> +	cmsg->outbuf_len = len;
> >
> > Please, remove "write_text" variable and use cmsg->outbuf directly.
> > It would safe one mental transition of buffer names:
> >
> >    cbufs->text -> write_text -> cmsg->outbuf
> >
> > vs.
> >
> >    cbufs->text -> cmsg->outbuf
> 
> I originally had the non-extended case without @write_text. I felt like
> it was harder to follow what actually got set. Really the main objective
> of the function is to set @outbuf and @outbuf_len. I felt like moving
> that outside of the if/else block made it clearer what is going on. But
> I can go back to having each if/else branch set those fields in their
> own way.

I am not sure if we are talking about the same thing. My idea was to do:

	if (cmsg->is_extmsg) {
		cmsg->outbuf = &cbufs->ext_text[0];
		outbuf_size = sizeof(cbufs->ext_text);
		len = info_print_ext_header(cmsg->outbuf, outbuf_size, r.info);
		len += msg_print_ext_body(cmsg->outbuf + len, outbuf_size - len,
				  &r.text_buf[0], r.info->text_len, &r.info->dev_info);
	} else {
		cmsg->outbuf = &cbufs->text[0];
		/* &r points to &cbufs->text[0], changes are done inline */
		len = record_print_text(&r, console_msg_format & MSG_FORMAT_SYSLOG, printk_time);
	}

> > PS: Please, wait a bit with updating the patches. I have got yet
> >     another idea when seeing the code around dropped messages.
> >     But I have to sleep over it.
> 
> Don't worry. I always wait until you finish the full review before
> touching anything. ;-)
> 
> >     My concern is that the message about dropped messages need not
> >     fit into the smaller "cbufs->text" buffer. It might be better
> >     to put it into the bigger one.
> 
> This series _does_ put the dropped messages in the bigger one.

Ah, I have overlooked this. It might actually be a motivation to avoid
all these shuffles and really use:

	struct console_buffers {
		char	outbuf[CONSOLE_EXT_LOG_MAX];
		char	readbuf[CONSOLE_LOG_MAX];
	};
> >
> >      Normal consoles would use only @outbuf. Only the extended console
> >      would need the @readbuf to read the messages before they are
> >      formatted.
> 
> The "problem" with this idea is that record_print_text() creates the
> normal output in-place within the readbuf. So for normal messages with
> no dropped messages, we still end up writing out the readbuf.

We handle this this in console_get_next_message() by reading the
messages into the right buffer:

	boot is_extcon = console_srcu_read_flags(con) & CON_EXTENDED;

	/*
	 * Normal consoles might read the message into the outbuf directly.
	 * Console headers are added inplace.
	 */
	if (is_extcon)
		prb_rec_init_rd(&r, &info, &cbufs->readbuf[0], sizeof(cbufs->readbuf));
	else
		prb_rec_init_rd(&r, &info, &cbufs->outbuf[0], sizeof(cbufs->outbuf));

	if (!prb_read_valid(prb, con->seq, &r))
		return false;

	...


	if (is_extcon) {
		len = info_print_ext_header(cbufs->outbuf, sizeof(cbufs->outbuf, r.info);
		len += msg_print_ext_body(cbufs->outbuf + len, sizeof(cbufs->outbuf) - len,
				  &r.text_buf[0], r.info->text_len, &r.info->dev_info);
	} else {
		len = record_print_text(&r, console_msg_format & MSG_FORMAT_SYSLOG, printk_time);
	}



> >      I guess that struct console_message won't be needed then at all.
> 
> Since we sometimes output the in-place readbuf and sometimes a newly
> written buffer, it is nice that console_message can abstract that out.
> 
> Also, right now @is_extmsg is the only input variable. For thread/atomic
> consoles, the input variables @seq and @dropped will be added.
> console_message will then have its own copy of all the information
> needed to let itself get filled and console_get_next_message() will no
> longer require the console as an argument.
> 
> This is important for the thread/atomic consoles because it removes all
> locking constraints from console_get_next_message(). For _this_ series,
> console_get_next_message() still requires holding the console_lock
> because it is accessing con->seq and con->dropped.
> 
> I could have added @seq and @dropped to console_message for this series,
> but for the legacy consoles it looks like a lot of unnecessary
> copying. Only with the thread/atomic consoles does the benefit become
> obvious.

I could imagine adding these metadata into the struct console_buffers.
Or we could call it struct console_messages from the beginning.

We could even completely move con->seq, con->dropped into this new
structure. It would safe even more copies.

IMHO, the less structures and the less copying the better.
Especially when the values have different name in each structure
that makes it even more complicated.

Best Regards,
Petr
