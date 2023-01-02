Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5F5C365B475
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Jan 2023 16:52:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236157AbjABPwK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Jan 2023 10:52:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46164 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232107AbjABPwJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Jan 2023 10:52:09 -0500
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F528301
        for <linux-kernel@vger.kernel.org>; Mon,  2 Jan 2023 07:52:07 -0800 (PST)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id D7E6533E13;
        Mon,  2 Jan 2023 15:52:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1672674725; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=YAD33tOGlUa6qCv95llelcBUG45g4lo4mhx8WvWvNlU=;
        b=HkUHeD/s5NlxoMHSIqdkKzZQFreITRj4RovDcDlnNlWUJRoGwCaNQUwBsJb9T9ePsMQaK4
        Av3OK7bjHrR5nBTaPRAX7dWrD74PZ0vVPBVJOs7RIlzjkMLyAnWm1FJP6dDFf6aBm08hd7
        n52p6UDnNS/BzDnUOD0hh5Km/bEGR9U=
Received: from suse.cz (unknown [10.100.201.202])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id 8CA082C141;
        Mon,  2 Jan 2023 15:52:05 +0000 (UTC)
Date:   Mon, 2 Jan 2023 16:52:05 +0100
From:   Petr Mladek <pmladek@suse.com>
To:     John Ogness <john.ogness@linutronix.de>
Cc:     Sergey Senozhatsky <senozhatsky@chromium.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH printk v3 5/6] printk: introduce
 console_get_next_message() and console_message
Message-ID: <Y7L9pdSo9fSmx/F5@alley>
References: <20221221202704.857925-1-john.ogness@linutronix.de>
 <20221221202704.857925-6-john.ogness@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221221202704.857925-6-john.ogness@linutronix.de>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed 2022-12-21 21:33:03, John Ogness wrote:
> Code for performing the console output is intermixed with code
> that is formatting the output for that console. Introduce a new
> helper function console_get_next_message() to handle the reading
> and formatting of the console text. The helper does not require
> any locking so that in the future it can be used for other console
> printing contexts as well.
> 
> This also introduces a new struct console_message to wrap the
> struct console_buffers adding meta-data about its contents. This
> allows users of console_get_next_message() to receive all relevant
> information about the message that was read and formatted.
> 
> The reason a wrapper struct is introduced instead of adding the
> meta-data to struct console_buffers is because the upcoming atomic
> consoles will need per-cpu and per-context console_buffers. It
> would not make sense to make the meta-data also per-cpu and
> per-context as that data can be easily stored on the stack of the
> console printing context.
> 
> diff --git a/kernel/printk/printk.c b/kernel/printk/printk.c
> index 2e5e2eda1fa1..7cac636600f8 100644
> --- a/kernel/printk/printk.c
> +++ b/kernel/printk/printk.c
> @@ -2725,34 +2725,34 @@ static void __console_unlock(void)
>  }
>  
>  /*
> - * Print one record for the given console. The record printed is whatever
> - * record is the next available record for the given console.
> + * Read and format the specified record (or a later record if the specified
> + * record is not available).
>   *
> - * @handover will be set to true if a printk waiter has taken over the
> - * console_lock, in which case the caller is no longer holding both the
> - * console_lock and the SRCU read lock. Otherwise it is set to false.
> + * @cmsg will contain the formatted result. @cmsg->cbufs must point to a
> + * struct console_buffers.
>   *
> - * @cookie is the cookie from the SRCU read lock.
> + * @seq is the record to read and format. If it is not available, the next
> + * valid record is read.
>   *
> - * Returns false if the given console has no next record to print, otherwise
> - * true.
> + * @is_extended specifies the message should be formatted for extended
> + * console output.
>   *
> - * Requires the console_lock and the SRCU read lock.
> + * Returns false if no record is available. Otherwise true and all fields
> + * of @cmsg are valid. (See the documentation of struct console_message
> + * for information about the @cmsg fields.)
>   */
> -static bool console_emit_next_record(struct console *con, bool *handover, int cookie)
> -{
> -	bool is_extended = console_srcu_read_flags(con) & CON_EXTENDED;
> -	static char dropped_text[DROPPED_TEXT_MAX];
> -	static struct console_buffers cbufs;
> -	const size_t scratchbuf_sz = sizeof(cbufs.scratchbuf);
> -	const size_t outbuf_sz = sizeof(cbufs.outbuf);
> -	char *scratchbuf = &cbufs.scratchbuf[0];
> -	char *outbuf = &cbufs.outbuf[0];
> +static bool console_get_next_message(struct console_message *cmsg, u64 seq,
> +				     bool is_extended)
> +{
> +	struct console_buffers *cbufs = cmsg->cbufs;
> +	const size_t scratchbuf_sz = sizeof(cbufs->scratchbuf);
> +	const size_t outbuf_sz = sizeof(cbufs->outbuf);
> +	char *scratchbuf = &cbufs->scratchbuf[0];
> +	char *outbuf = &cbufs->outbuf[0];
>  	static int panic_console_dropped;
>  	struct printk_info info;
>  	struct printk_record r;
> -	unsigned long flags;
> -	size_t len;
> +	size_t len = 0;
>  
>  	/*
>  	 * Formatting extended messages requires a separate buffer, so use the
> @@ -2766,33 +2766,77 @@ static bool console_emit_next_record(struct console *con, bool *handover, int co
>  	else
>  		prb_rec_init_rd(&r, &info, outbuf, outbuf_sz);
>  
> -	*handover = false;
> -
> -	if (!prb_read_valid(prb, con->seq, &r))
> +	if (!prb_read_valid(prb, seq, &r))
>  		return false;
>  
> -	if (con->seq != r.info->seq) {
> -		con->dropped += r.info->seq - con->seq;
> -		con->seq = r.info->seq;
> -		if (panic_in_progress() && panic_console_dropped++ > 10) {
> -			suppress_panic_printk = 1;
> -			pr_warn_once("Too many dropped messages. Suppress messages on non-panic CPUs to prevent livelock.\n");
> -		}
> +	cmsg->outbuf_seq = r.info->seq;
> +	cmsg->dropped = r.info->seq - seq;
> +
> +	/*
> +	 * Check for dropped messages in panic here so that printk
> +	 * suppression can occur as early as possible if necessary.
> +	 */
> +	if (cmsg->dropped &&
> +	    panic_in_progress() &&
> +	    panic_console_dropped++ > 10) {
> +		suppress_panic_printk = 1;
> +		pr_warn_once("Too many dropped messages. Suppress messages on non-panic CPUs to prevent livelock.\n");
>  	}
>  
>  	/* Skip record that has level above the console loglevel. */
> -	if (suppress_message_printing(r.info->level)) {
> -		con->seq++;
> -		goto skip;
> -	}
> +	if (suppress_message_printing(r.info->level))
> +		goto out;
>  
>  	if (is_extended) {
>  		len = info_print_ext_header(outbuf, outbuf_sz, r.info);
>  		len += msg_print_ext_body(outbuf + len, outbuf_sz - len,
> -					  &r.text_buf[0], r.info->text_len, &r.info->dev_info);
> +					  r.text_buf, r.info->text_len, &r.info->dev_info);

This probably was not intended.

If you agree then I could revert this change when pushing.
Or feel free to send respin of this patch.


>  	} else {
>  		len = record_print_text(&r, console_msg_format & MSG_FORMAT_SYSLOG, printk_time);
>  	}
> +out:
> +	cmsg->outbuf_len = len;
> +	return true;
> +}

Otherwise, it looks good:

Reviewed-by: Petr Mladek <pmladek@suse.com>

Best Regards,
Petr
