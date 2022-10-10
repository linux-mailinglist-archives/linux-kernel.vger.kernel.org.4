Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A7C125FA13D
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Oct 2022 17:40:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229599AbiJJPkY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Oct 2022 11:40:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60714 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229511AbiJJPkU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Oct 2022 11:40:20 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C004040E29
        for <linux-kernel@vger.kernel.org>; Mon, 10 Oct 2022 08:40:18 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id 165D722300;
        Mon, 10 Oct 2022 15:40:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1665416417; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=a0EXuz87ayCNYLxfqLFzQ+nL8I+4PdhmxNw3qkfSm/4=;
        b=jhu+c6weveRJzlNsOonxeIXudXKRpe9WBr4ygUcBi94yFA+bCw4BkrhIVTmXrMVfN6hymr
        zNdbq6zk16+8MVqRGw8nXxCSGqNcX2U34gCEN+hAijflG2Y9sQtmU5XDungiinSj5YPZdB
        /KIVpOmuIchfYFJ8YK00o0HHKUAeSek=
Received: from suse.cz (unknown [10.100.208.146])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id B6B452C141;
        Mon, 10 Oct 2022 15:40:16 +0000 (UTC)
Date:   Mon, 10 Oct 2022 17:40:13 +0200
From:   Petr Mladek <pmladek@suse.com>
To:     John Ogness <john.ogness@linutronix.de>
Cc:     Sergey Senozhatsky <senozhatsky@chromium.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCH printk 17/18] printk: Use an output descriptor struct for
 emit
Message-ID: <Y0Q83TZnQcCF/mDi@alley>
References: <20220924000454.3319186-1-john.ogness@linutronix.de>
 <20220924000454.3319186-18-john.ogness@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220924000454.3319186-18-john.ogness@linutronix.de>
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat 2022-09-24 02:10:53, John Ogness wrote:
> From: Thomas Gleixner <tglx@linutronix.de>
> 
> To prepare for a new console infrastructure that is independent of the
> console BKL, wrap the output mode into a descriptor struct so the new
> infrastrucure can share the emit code that dumps the ringbuffer record
> into the output text buffers.
> 
> Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
> Signed-off-by: John Ogness <john.ogness@linutronix.de>
> ---
>  include/linux/console.h | 15 +++++++
>  kernel/printk/printk.c  | 88 ++++++++++++++++++++++++++++++-----------
>  2 files changed, 79 insertions(+), 24 deletions(-)
> 
> diff --git a/include/linux/console.h b/include/linux/console.h
> index 05c7325e98f9..590ab62c01d9 100644
> --- a/include/linux/console.h
> +++ b/include/linux/console.h
> @@ -187,6 +187,21 @@ struct cons_text_buf {
>  	char		text[CONSOLE_LOG_MAX];
>  };
>  
> +/**
> + * struct cons_outbuf_desc - console output buffer descriptor
> + * @txtbuf:		Pointer to buffer for storing the text
> + * @outbuf:		Pointer to the position in @buffer for
> + *			writing it out to the device

This sounds like this pointer might point into the middle of
some buffer. It sounds scarry without providing the remaining
size of the buffer.

It seems that the pointer is actually used to point to
one of the buffers in txtbuf struct. Then it is again
a bit scarry without the size. I know that it is defined
by @len. But it is not obvious that it is related.

> + * @len:		Message length

It is not clear that it is length of the outbuf.

> + * @extmsg:		Select extended format printing

It would be nice to make it obvious (variable name)
that it is bool and not another buffer.

This actually defines which buffer will be used
in txtbuf.

> + */
> +struct cons_outbuf_desc {
> +	struct cons_text_buf	*txtbuf;
> +	char			*outbuf;
> +	unsigned int		len;
> +	bool			extmsg;
> +};

Sigh, I somehow do not like this structure. I think that the main
problem is that it combines both input and output values.

Also there is too much assignments here and there.

What about?

1. Storing "struct cons_text_buf *txtbuf" into struct console.
   Normal consoles might point to a global txtbuf.
   Atomic consoles might point to the allocated ones.

2. Create structure for writing the next record
   on the console, for example:

   struct console_record {	/* like struct printk_record */
	char *buf;
	int size;
	int len;
   }

Then we could implement:

bool console_get_record(struct console *con,
			struct console_record *cr)
{
	struct cons_text_buf *txtbuf = con->txtbuf;
	struct printk_info info;
	struct printk_record r;
	char *write_text;
	size_t len;

	cr->buf = NULL;
	cr->size = 0;
	cr->len = 0;

	prb_rec_init_rd(&r, &info, txtbuf->text, sizeof(txtbuf->text);

	if (!prb_read_valid(prb, desc->seq, &r))
		return false;

	/* Skip record that has level above the console loglevel. */
	if (suppress_message_printing(r.info->level)) {
		return true;
	}

	if (con->flags & CON_EXTENDED) {
		cr->buf = txtbuf->ext_text;
		cr->size = sizeof(txtbuf->ext_text);
		info_print_ext_header(cr, r.info);
		msg_print_ext_body(cr, &r);
	} else {
		cr->buf = txtbuf->text;
		cr->size = sizeof(txtbuf->text);
		record_print_text(cr, &r, console_msg_format & MSG_FORMAT_SYSLOG, printk_time);

		cons_print_dropped(cr, con);
	}

	return true;
}

and

static bool console_emit_next_record(struct console *con,
				     bool *handover)
{
	struct console_record cr;
	unsigned long flags;

	*handover = false;

	if (!console_get_next_record(con, cr))
		return false;

	/* supressed? */
	if (!cr->buf) {
		con->seq++;
		return true;
	}

	/*
	 * While actively printing out messages, if another printk()
	 * were to occur on another CPU, it may wait for this one to
	 * finish. This task can not be preempted if there is a
	 * waiter waiting to take over.
	 *
	 * Interrupts are disabled because the hand over to a waiter
	 * must not be interrupted until the hand over is completed
	 * (@console_waiter is cleared).
	 */
	printk_safe_enter_irqsave(flags);
	console_lock_spinning_enable();

	/* don't trace print latency */
	stop_critical_timings();
	/* Write everything out to the hardware */
	con->write(con, cr->buf, cr->len);
	start_critical_timings();

	con->seq++;

	*handover = console_lock_spinning_disable_and_check();
	printk_safe_exit_irqrestore(flags);

	return true;
}

Advantages:

	+ even less parameters
	+ less assignments (read/write directly in struct console)
	+ struct console_record has just output buffer =>
	  no confusion about the names

How does that sound, please?

Best Regards,
Petr
