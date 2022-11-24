Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CCF29637EBC
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Nov 2022 19:00:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229542AbiKXSA0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Nov 2022 13:00:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57456 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229832AbiKXSAU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Nov 2022 13:00:20 -0500
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 755216CA3E
        for <linux-kernel@vger.kernel.org>; Thu, 24 Nov 2022 10:00:15 -0800 (PST)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id 953721F8A4;
        Thu, 24 Nov 2022 18:00:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1669312814; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=PBGtiOjF7/rW+pK3caQ9Y3sl76cT3s0S40LymP7KrKo=;
        b=W4UHep6VTyffJZxgqIuEl4dvSYXUk0e214WZ5pPGvO51Q+BR53rYGyDjGwcWVIbYHCPF6G
        eTuEV/bXBFCAoCfref3oZkBNn02lR3x0o50vtzo7ORjMfCXiN6DxoEQ0HsOe3N1UNOgL9Z
        nEH7J0bYFU5fcwQH48E4Qm/Ko9/zTdg=
Received: from suse.cz (unknown [10.100.201.202])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id 5AAD72C15F;
        Thu, 24 Nov 2022 18:00:14 +0000 (UTC)
Date:   Thu, 24 Nov 2022 19:00:11 +0100
From:   Petr Mladek <pmladek@suse.com>
To:     John Ogness <john.ogness@linutronix.de>
Cc:     Sergey Senozhatsky <senozhatsky@chromium.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCH printk v2 6/7] printk: Use an output buffer descriptor
 struct for emit
Message-ID: <Y3+xK7hHmUIlzq9w@alley>
References: <20221123231400.614679-1-john.ogness@linutronix.de>
 <20221123231400.614679-7-john.ogness@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221123231400.614679-7-john.ogness@linutronix.de>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu 2022-11-24 00:19:59, John Ogness wrote:
> From: Thomas Gleixner <tglx@linutronix.de>
> 
> To prepare for a new console infrastructure that is independent of
> the console BKL, wrap the output mode into a descriptor struct so
> the new infrastructure can share the emit code that dumps the
> ringbuffer record into the output text buffers.
> 
> --- a/kernel/printk/printk.c
> +++ b/kernel/printk/printk.c
> @@ -2741,11 +2741,76 @@ static void __console_unlock(void)
>  	up_console_sem();
>  }
>  
> +/**
> + * console_get_next_message - Fill the output buffer with the next record
> + * @con:	The console to print on
> + * @cmsg:	Pointer to the output buffer descriptor
> + *
> + * Return: False if there is no pending record in the ringbuffer.
> + *	   True if there is a pending record in the ringbuffer.
> + *
> + * When the return value is true, then the caller must check
> + * @cmsg->outbuf. If not NULL it points to the first character to write
> + * to the device and @cmsg->outbuf_len contains the length of the message.
> + * If it is NULL then the record will be skipped.
> + */
> +static bool console_get_next_message(struct console *con, struct console_message *cmsg)
> +{

I wish, this change was done in two patches. 1st introducing and
using struct console_message. 2nd moving the code into separate
console_get_next_message().

I do not resist on it but it might help to see what exactly has changed.

> +	struct console_buffers *cbufs = cmsg->cbufs;
> +	static int panic_console_dropped;
> +	struct printk_info info;
> +	struct printk_record r;
> +	size_t write_text_size;
> +	char *write_text;
> +	size_t len;
> +
> +	cmsg->outbuf = NULL;
> +	cmsg->outbuf_len = 0;
> +
> +	prb_rec_init_rd(&r, &info, &cbufs->text[0], sizeof(cbufs->text));
> +
> +	if (!prb_read_valid(prb, con->seq, &r))
> +		return false;
> +
> +	if (con->seq != r.info->seq) {
> +		con->dropped += r.info->seq - con->seq;
> +		con->seq = r.info->seq;
> +		if (panic_in_progress() && panic_console_dropped++ > 10) {
> +			suppress_panic_printk = 1;
> +			pr_warn_once("Too many dropped messages. Suppress messages on non-panic CPUs to prevent livelock.\n");
> +		}
> +	}
> +
> +	/*
> +	 * Skip record that has level above the console loglevel.
> +	 * Return true so the caller knows a record exists and
> +	 * leave cmsg->outbuf NULL so the caller knows the record
> +	 * is being skipped.
> +	 */
> +	if (suppress_message_printing(r.info->level))
> +		return true;
> +
> +	if (cmsg->is_extmsg) {
> +		write_text = &cbufs->ext_text[0];
> +		write_text_size = sizeof(cbufs->ext_text);
> +		len = info_print_ext_header(write_text, write_text_size, r.info);
> +		len += msg_print_ext_body(write_text + len, write_text_size - len,
> +					  &r.text_buf[0], r.info->text_len, &r.info->dev_info);
> +	} else {
> +		write_text = &cbufs->text[0];
> +		len = record_print_text(&r, console_msg_format & MSG_FORMAT_SYSLOG, printk_time);
> +	}
> +
> +	cmsg->outbuf = write_text;
> +	cmsg->outbuf_len = len;

Please, remove "write_text" variable and use cmsg->outbuf directly.
It would safe one mental transition of buffer names:

   cbufs->text -> write_text -> cmsg->outbuf

vs.

   cbufs->text -> cmsg->outbuf

Best Regards,
Petr

PS: Please, wait a bit with updating the patches. I have got yet
    another idea when seeing the code around dropped messages.
    But I have to sleep over it.

    My concern is that the message about dropped messages need not
    fit into the smaller "cbufs->text" buffer. It might be better
    to put it into the bigger one.

    We might actually always use the bigger buffer as the output
    buffer. The smaller buffer might be only temporary when formatting
    the extended messages.

     We could replace

	struct console_buffers {
		char	ext_text[CONSOLE_EXT_LOG_MAX];
		char	text[CONSOLE_LOG_MAX];
	};

    with

	struct console_buffers {
		char	outbuf[CONSOLE_EXT_LOG_MAX];
		char	readbuf[CONSOLE_LOG_MAX];
	};

     Normal consoles would use only @outbuf. Only the extended console
     would need the @readbuf to read the messages before they are formatted.

     I guess that struct console_message won't be needed then at all.

     It might help to remove several twists in the code.

     I am sorry that I have not got this idea when reviewing v1.
     Well, the code was even more complicated at that time.
