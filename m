Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3A85B5F9C74
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Oct 2022 12:11:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231582AbiJJKLi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Oct 2022 06:11:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52390 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230198AbiJJKLg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Oct 2022 06:11:36 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B0CC3D5B8
        for <linux-kernel@vger.kernel.org>; Mon, 10 Oct 2022 03:11:35 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id 1D84D1F74D;
        Mon, 10 Oct 2022 10:11:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1665396694; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=sbH2RUMOoOwHcj2wF2XCAK9RzyeAAy8Sdt9/OUJoo44=;
        b=HVjQWOzzK++VmbnbAlZf+MganpGbrlOGEAy68OzvaW+2RBg0C2jOnrXVksPkiKCVwI8Inb
        kV/UTiDTnDq6L36Pa2CUWbBJrr0zwOL3M5MLU1bG/P9smxGM9Z/66QHpexYuhi1QjgBZF7
        1gGJxG/z094rsRRgP+SycNiMUhbtVPM=
Received: from suse.cz (unknown [10.100.208.146])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id BECCC2C141;
        Mon, 10 Oct 2022 10:11:33 +0000 (UTC)
Date:   Mon, 10 Oct 2022 12:11:33 +0200
From:   Petr Mladek <pmladek@suse.com>
To:     John Ogness <john.ogness@linutronix.de>
Cc:     Sergey Senozhatsky <senozhatsky@chromium.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH printk 16/18] printk: Use struct cons_text_buf
Message-ID: <Y0Pv1Uwm6POpKEIY@alley>
References: <20220924000454.3319186-1-john.ogness@linutronix.de>
 <20220924000454.3319186-17-john.ogness@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220924000454.3319186-17-john.ogness@linutronix.de>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat 2022-09-24 02:10:52, John Ogness wrote:
> From: Thomas Gleixner <tglx@linutronix.de>
> 
> Replace the separately allocated output buffers with a single instance of
> struct cons_text_buf.
> 
> Note that the buffer size of devkmsg_user.text_buf, when replaced with
> cons_text_buf.text, reduces from CONSOLE_EXT_LOG_MAX to CONSOLE_LOG_MAX.
> However, the buffer is only used to read ringbuffer records, which have
> a maximum size of LOG_LINE_MAX (CONSOLE_LOG_MAX - PREFIX_MAX).
> 
> Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
> Signed-off-by: John Ogness <john.ogness@linutronix.de>
> ---
>  kernel/printk/printk.c | 50 ++++++++++++++++++------------------------
>  1 file changed, 21 insertions(+), 29 deletions(-)
> 
> diff --git a/kernel/printk/printk.c b/kernel/printk/printk.c
> index 65e9903d066f..9cbd44e9fc45 100644
> --- a/kernel/printk/printk.c
> +++ b/kernel/printk/printk.c
> @@ -671,11 +671,9 @@ struct devkmsg_user {
>  	atomic64_t seq;
>  	struct ratelimit_state rs;
>  	struct mutex lock;
> -	char buf[CONSOLE_EXT_LOG_MAX];
> -
>  	struct printk_info info;
> -	char text_buf[CONSOLE_EXT_LOG_MAX];
>  	struct printk_record record;
> +	struct cons_text_buf txtbuf;

I think about how to make it more clear that @txtbuf is not a simple
text buffer. It would help to better follow the code.

What about renaming "struct cons_text_buf", for example:

	struct con_text_bufs;
	struct con_bufs;
	struct console_text_buffers;
	struct console_buffers;

and use the variables, for example:

	ctbufs, cbufs, ct_bufs, c_bufs, con_bufs

>  };
>  
>  static __printf(3, 4) __cold
> @@ -758,6 +756,8 @@ static ssize_t devkmsg_read(struct file *file, char __user *buf,
>  {
>  	struct devkmsg_user *user = file->private_data;
>  	struct printk_record *r = &user->record;
> +	char *outbuf = user->txtbuf.ext_text;

Please, use either "ext_text" or "ext_text_buf". 

> +	const int maxlen = sizeof(user->txtbuf.ext_text);

and "ext_text_size" or "ext_text_buf_size"

to follow the existing style, for example:

	info_print_ext_header(buf, size, info).
	prb_rec_init_rd(r, info, text_buf, text_buf_size).

>  	size_t len;
>  	ssize_t ret;
>  
> @@ -2741,13 +2742,13 @@ static bool console_emit_next_record(struct console *con, char *text, char *ext_
>  		goto skip;
>  	}
>  
> -	if (ext_text) {
> -		write_text = ext_text;
> -		len = info_print_ext_header(ext_text, CONSOLE_EXT_LOG_MAX, r.info);
> -		len += msg_print_ext_body(ext_text + len, CONSOLE_EXT_LOG_MAX - len,
> +	if (extmsg) {

We could get this from the console flags:

	if (con->flags & CON_EXTENDED) {

> +		write_text = txtbuf->ext_text;
> +		len = info_print_ext_header(write_text, CONSOLE_EXT_LOG_MAX, r.info);
> +		len += msg_print_ext_body(write_text + len, CONSOLE_EXT_LOG_MAX - len,
>  					  &r.text_buf[0], r.info->text_len, &r.info->dev_info);

I would use this opportunity and get rid of the hardcoded *_LOG_MAX
lengts and something like:

		write_text = txtbuf->ext_text;
		write_text_size = sizeof(txtbuf->ext_text);
		len = info_print_ext_header(write_text, write_text_size, r.info);
		len += msg_print_ext_body(write_text + len, write_text_size - len,
					  &r.text_buf[0], r.info->text_len, &r.info->dev_info);


Using the hard coded size is error prone. It makes the review
complicated especially when we are going to pass the buffers
via some structures or generic pointers. I always have to check
if it is still the same buffer.

The only sane way is to use either sizeof(buf) or pass/store
@buf_size.


In addition, I would set here:

		dropped_text = txtbuf->ext_text;
		dropped_text_size = sizeof(txtbuf->ext_text);

As a result, we could define as:

struct con_text_bufs {
	char	ext_text[CONSOLE_EXT_LOG_MAX];
	char	text[CONSOLE_LOG_MAX];
} __no_randomize_layout;

and remove DROPPED_TEXT_MAX. I see that it is actually done later
anyway. Adding the union is just a temporary twist that complicates
the review.

>  	} else {
> -		write_text = text;
> +		write_text = txtbuf->text;
>  		len = record_print_text(&r, console_msg_format & MSG_FORMAT_SYSLOG, printk_time);

		write_text = txtbuf->text;
		write_text_size = sizeof(txtbuf->text);
		len = record_print_text(&r, console_msg_format & MSG_FORMAT_SYSLOG, printk_time);

		dropped_text = NULL;
		dropped_text_size = 0;

>  	}
>  
> @@ -2765,7 +2766,7 @@ static bool console_emit_next_record(struct console *con, char *text, char *ext_
>  	console_lock_spinning_enable();
>  
>  	stop_critical_timings();	/* don't trace print latency */
> -	call_console_driver(con, write_text, len, dropped_text);
> +	call_console_driver(con, write_text, len, extmsg ? NULL : txtbuf->dropped_text);

	call_console_driver(con, write_text, len, dropped_text, dropped_text_size);

>  	start_critical_timings();
>  
>  	con->seq++;

Best Regards,
Petr
