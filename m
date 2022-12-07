Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 513D4645A27
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Dec 2022 13:50:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229586AbiLGMug (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Dec 2022 07:50:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33132 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229743AbiLGMua (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Dec 2022 07:50:30 -0500
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F48F537EC
        for <linux-kernel@vger.kernel.org>; Wed,  7 Dec 2022 04:50:28 -0800 (PST)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id 38C9721CA8;
        Wed,  7 Dec 2022 12:50:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1670417427; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=P3xdqSUuU4VVyyvS795ilcqadJJ5uRogYNNY+GVvt8Q=;
        b=MrPM/1MWsUgwfoFcEa6z+oywreTHpV17P0hUIoNO6NrlxTlz5QY/W4G/VLFp3gI6CJ3VRi
        fFOeglWG5yZKeDZxtD6bLbZ/eBaVUu4n6GYPjF9ItwgUsxiCql8VxAmoq0yOjXZHpSPun4
        J/9fWyDLMh5M8tLy7I/LDmEuO/K8teM=
Received: from suse.cz (unknown [10.100.201.202])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id DFE142C141;
        Wed,  7 Dec 2022 12:50:26 +0000 (UTC)
Date:   Wed, 7 Dec 2022 13:50:23 +0100
From:   Petr Mladek <pmladek@suse.com>
To:     John Ogness <john.ogness@linutronix.de>
Cc:     Sergey Senozhatsky <senozhatsky@chromium.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH printk v2 7/7] printk: Handle dropped message smarter
Message-ID: <Y5CMD8iZND3rgugG@alley>
References: <20221123231400.614679-1-john.ogness@linutronix.de>
 <20221123231400.614679-8-john.ogness@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221123231400.614679-8-john.ogness@linutronix.de>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu 2022-11-24 00:20:00, John Ogness wrote:
> From: Thomas Gleixner <tglx@linutronix.de>
> 
> If a 'dropped message' is to be printed, move the record text to be
> directly appended to the 'dropped message' and let console->write()
> output it in one go.
>
> --- a/kernel/printk/printk.c
> +++ b/kernel/printk/printk.c
> @@ -2741,6 +2712,60 @@ static void __console_unlock(void)
>  	up_console_sem();
>  }
>  
> +/*
> + * A maximum dropped message together with a maximum regular message
> + * must be able to fit within console_buffers->ext_text.
> + */
> +#if DROPPED_TEXT_MAX > (CONSOLE_EXT_LOG_MAX - CONSOLE_LOG_MAX)
> +#error "DROPPED_TEXT_MAX too large for console_buffers->ext_text"
> +#endif
> +
> +/**
> + * msg_print_dropped - Prepend a "dropped message" if required
> + * @desc:	Pointer to the output descriptor
> + * @dropped:	The number of dropped messages to report
> + *
> + * Inserts the "dropped message" into the output buffer if @dropped is
> + * not 0 and the regular format is requested. Extended format does not
> + * need this message because it prints the sequence numbers.
> + *
> + * In regular format, the extended message buffer is not in use. So
> + * string-print the dropped message there and move the record text to be
> + * appended to the dropped message. The extended message buffer is much
> + * larger and can accommodate both messages.
> + *
> + * In case a dropped message is needed, this returns with @desc->outbuf
> + * and @desc->len updated. The caller is responsible for tracking and
> + * resetting the dropped count. If no dropped message is required then
> + * @desc is not modified.
> + */
> +static void msg_print_dropped(struct console_message *cmsg, unsigned long dropped)
> +{
> +	struct console_buffers *cbufs = cmsg->cbufs;
> +	char *ext_text = &cbufs->ext_text[0];
> +	size_t len;
> +
> +	if (!dropped || cmsg->is_extmsg)
> +		return;
> +
> +	if (WARN_ON_ONCE(cmsg->outbuf != &cbufs->text[0]))
> +		return;
> +
> +	/* Print it into ext_text, which is unused. */
> +	len = snprintf(ext_text, DROPPED_TEXT_MAX,
> +		       "** %lu printk messages dropped **\n", dropped);
> +

I would feel better if we check here that the text fits into the rest
of the buffer.

	if (WARN_ON_ONCE(len + cmsg->outbuf_len < sizeof(cbufs->ext_text)))
		return;

I know that it is kind-of guaranteed by the above compilation check
of the *_MAX values. But there might be a bug and cmsg->outbuf_len
might contains a garbage.


> +	/*
> +	 * Append the record text to the dropped message so that it
> +	 * goes out with one write.
> +	 */
> +	memcpy(ext_text + len, &cbufs->text[0], cmsg->outbuf_len);
> +
> +	/* Update the output buffer descriptor. */
> +	cmsg->outbuf = ext_text;
> +	cmsg->outbuf_len += len;

I still think that it would be better to rename the buffers in
struct console_message and avoid the switches of the purpose
of the two buffers.

We could print the message about dropped text into a local buffer
on stack. IMHO, 64 bytes are acceptable. And we could insert it
into the outbuf by shuffling the existing text. Something like:

static void msg_print_dropped(struct console_message *cmsg,
			      unsinged long dropped)
{
	char dropped_msg[DROPPED_TEXT_MAX];
	int dropped_len;

	if (!con->dropped)
		return 0;

	/* Print it into ext_text, which is unused. */
	dropped_len = snprintf(dropped_msg, sizeof(dropped_msg),
		       "** %lu printk messages dropped **\n", con->dropped);

	/*
	 * The buffer might already be full only where the message consist
	 * of many very short lines. It is not much realistic.
	 */
	if (cmsg->outbuf_len + dropped_len + 1 > sizeof(cmsg->outbuf)) {
		/* Should never happen. */
		if (WARN_ON_ONCE(dropped_len + 1 > sizeof(cmsg->outbuf)))
			return;

		/* Trunk the message like in record_print_text() */
		cmsg->outbuf_len = sizeof(cmsg->outbuf) - dropped_len;
		cmsg->outbuf[cmsg->outbuf_len] = '\0';
	}

	memmove(cmsg->outbuf + dropped_len, cmsg->outbuf, cmsg->outbuf_len + 1);
	memcpy(cmsg->outbuf, dropped_msg, dropped_len);
}

The handling of the full buffer is a bit ugly. I though about other
alternatives. For example, returning -ENOMEM, so that the caller
could print the line later. Or just using WARN_ON_ONCE() and return.

Any solution has its pros and cons. But is a corner case. It need
not be perfect. I solved it the same way as we already do in
record_print_text().

Otherwise, the move of the code makes sense.

Best Regards,
Petr
