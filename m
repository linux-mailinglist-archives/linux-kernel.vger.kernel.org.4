Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3908465B4F9
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Jan 2023 17:19:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236613AbjABQTb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Jan 2023 11:19:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34862 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236407AbjABQT3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Jan 2023 11:19:29 -0500
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E239B1D7
        for <linux-kernel@vger.kernel.org>; Mon,  2 Jan 2023 08:19:28 -0800 (PST)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id BDA5A5C543;
        Mon,  2 Jan 2023 16:19:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1672676366; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=4qIPCoXXQO1R/q6GdjkJPLfVViHr04M+cPFPwgtcHJU=;
        b=S+Sqxy0oT8dvwolCNcAMyT9rvIEecVZOmOCAIPxNjNUf87M1hrP+xAyO2OHDGlgDsbgJwh
        NbmAUrufFVMMajcLk+rhm0npEV7QOmkOFnJuOKzjPwVHEOxZhS5MrFjHqO3UcSeg08li9p
        gwf3DUdhFwHV9kQbMoCjIDgbQ9AUqno=
Received: from suse.cz (unknown [10.100.201.202])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id 771AD2C141;
        Mon,  2 Jan 2023 16:19:26 +0000 (UTC)
Date:   Mon, 2 Jan 2023 17:19:26 +0100
From:   Petr Mladek <pmladek@suse.com>
To:     John Ogness <john.ogness@linutronix.de>
Cc:     Sergey Senozhatsky <senozhatsky@chromium.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH printk v3 6/6] printk: introduce
 console_prepend_dropped() for dropped messages
Message-ID: <Y7MEDmP1zqWblj0N@alley>
References: <20221221202704.857925-1-john.ogness@linutronix.de>
 <20221221202704.857925-7-john.ogness@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221221202704.857925-7-john.ogness@linutronix.de>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed 2022-12-21 21:33:04, John Ogness wrote:
> Currently "dropped messages" are separately printed immediately
> before printing the printk message. Since normal consoles are
> now using an output buffer that is much larger than previously,
> the "dropped message" could be prepended to the printk message
> and output in a single call.
> 
> Introduce a helper function console_prepend_dropped() to prepend
> an existing message with a "dropped message". This simplifies
> the code by allowing all message formatting to be handled
> together and then only requires a single write() call to output
> the full message. And since this helper does not require any
> locking, it can be used in the future for other console printing
> contexts as well.
> 
> Signed-off-by: John Ogness <john.ogness@linutronix.de>

> --- a/kernel/printk/printk.c
> +++ b/kernel/printk/printk.c
> @@ -2724,6 +2699,50 @@ static void __console_unlock(void)
>  	up_console_sem();
>  }
>  
> +/*
> + * Prepend the message in @cmsg->cbufs->outbuf with a "dropped message". This
> + * is achieved by shifting the existing message over and inserting the dropped
> + * message.
> + *
> + * @cmsg is the console message to prepend.
> + *
> + * @dropped is the dropped count to report in the dropped message.
> + *
> + * If the message text in @cmsg->cbufs->outbuf does not have enough space for
> + * the dropped message, the message text will be sufficiently truncated.
> + *
> + * If @cmsg->cbufs->outbuf is modified, @cmsg->outbuf_len is updated.
> + */
> +static void console_prepend_dropped(struct console_message *cmsg, unsigned long dropped)
> +{
> +	struct console_buffers *cbufs = cmsg->cbufs;
> +	const size_t scratchbuf_sz = sizeof(cbufs->scratchbuf);
> +	const size_t outbuf_sz = sizeof(cbufs->outbuf);
> +	char *scratchbuf = &cbufs->scratchbuf[0];
> +	char *outbuf = &cbufs->outbuf[0];
> +	size_t len;
> +
> +	len = snprintf(scratchbuf, scratchbuf_sz,
> +		       "** %lu printk messages dropped **\n", dropped);
> +
> +	/*
> +	 * Make sure outbuf is sufficiently large before prepending. Space
> +	 * for a terminator is also counted in case truncation occurs.
> +	 */
> +	if (WARN_ON_ONCE(len + 1 >= outbuf_sz))
> +		return;

Strictly speaking, this should be:

	if (WARN_ON_ONCE(len >= outbuf_sz))
		return;

The trailing '\0' will fit into the buffer when len < outbuf_sz.

That said, the consoles would be almost unusable when we are anywhere close this
limit. Most messages would be truncated.

> +
> +	if (cmsg->outbuf_len + len >= outbuf_sz) {
> +		/* Truncate the message, but keep it terminated. */
> +		cmsg->outbuf_len = outbuf_sz - (len + 1);
> +		outbuf[cmsg->outbuf_len] = 0;
> +	}
> +
> +	memmove(outbuf + len, outbuf, cmsg->outbuf_len + 1);
> +	memcxpy(outbuf, scratchbuf, len);
> +	cmsg->outbuf_len += len;
> +}
> +
>  /*
>   * Read and format the specified record (or a later record if the specified
>   * record is not available).

Otherwise, the change looks fine:

Reviewed-by: Petr Mladek <pmladek@suse.com>

Best Regards,
Petr
