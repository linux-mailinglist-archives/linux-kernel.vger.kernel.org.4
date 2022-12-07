Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 14503645F83
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Dec 2022 18:00:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229456AbiLGRAD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Dec 2022 12:00:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44576 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229943AbiLGQ7m (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Dec 2022 11:59:42 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0EB2668C6F
        for <linux-kernel@vger.kernel.org>; Wed,  7 Dec 2022 08:59:17 -0800 (PST)
From:   John Ogness <john.ogness@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1670432355;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=dT+YUSRS3ZTmcs7B0I7KHpOjmW1fKXcjAdDru8unKlo=;
        b=3D1wKmsrHv8lkraWId+LY/jexAg94rjcG8kxRFml2Cuz2Q4RzxoNNSoJ568Bgaw8KR/Oyg
        rmxW4ggj7DSFrgw1V6wXPWMh+CzQ+CLUvQhN9rsaTA9hkk173niwraNiX9Y26P8OdKPfOi
        f3rDfQ27j1WS1BTGlSmeqKsgRWaXRy0KXTkeA4qgM0NPQQ0gC2uMRe5g5/KwiKn70V4pCW
        B8CbUMn5CmbZ8plr/ivj6PXd/oupaKEkKzac42L0SSwojd3p7MGpwd7xpYYILBT4yivGY0
        zV73Z9DkLxp9TJe3q0jP73Yo7d81N91AOWa9R53Lpnec0zh3qpahkxFlXk52eQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1670432355;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=dT+YUSRS3ZTmcs7B0I7KHpOjmW1fKXcjAdDru8unKlo=;
        b=ntK4phTaR4PCZN0fnTNi/XFc8XasXlugINJ5FE82nuoqzpN9PCrVNKjUI+gLStTuK6DJ7N
        F7mYPYveH4SsDKCw==
To:     Petr Mladek <pmladek@suse.com>
Cc:     Sergey Senozhatsky <senozhatsky@chromium.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH printk v2 7/7] printk: Handle dropped message smarter
In-Reply-To: <Y5CMD8iZND3rgugG@alley>
References: <20221123231400.614679-1-john.ogness@linutronix.de>
 <20221123231400.614679-8-john.ogness@linutronix.de>
 <Y5CMD8iZND3rgugG@alley>
Date:   Wed, 07 Dec 2022 18:04:56 +0106
Message-ID: <87h6y71773.fsf@jogness.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-3.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,INVALID_DATE_TZ_ABSURD,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022-12-07, Petr Mladek <pmladek@suse.com> wrote:
>> +	/* Print it into ext_text, which is unused. */
>> +	len = snprintf(ext_text, DROPPED_TEXT_MAX,
>> +		       "** %lu printk messages dropped **\n", dropped);
>> +
>
> I would feel better if we check here that the text fits into the rest
> of the buffer.
>
> 	if (WARN_ON_ONCE(len + cmsg->outbuf_len < sizeof(cbufs->ext_text)))
> 		return;
>
> I know that it is kind-of guaranteed by the above compilation check
> of the *_MAX values. But there might be a bug and cmsg->outbuf_len
> might contains a garbage.

OK.

>> +	/*
>> +	 * Append the record text to the dropped message so that it
>> +	 * goes out with one write.
>> +	 */
>> +	memcpy(ext_text + len, &cbufs->text[0], cmsg->outbuf_len);
>> +
>> +	/* Update the output buffer descriptor. */
>> +	cmsg->outbuf = ext_text;
>> +	cmsg->outbuf_len += len;
>
> I still think that it would be better to rename the buffers in
> struct console_message and avoid the switches of the purpose
> of the two buffers.
>
> We could print the message about dropped text into a local buffer
> on stack. IMHO, 64 bytes are acceptable. And we could insert it
> into the outbuf by shuffling the existing text. Something like:
>
> static void msg_print_dropped(struct console_message *cmsg,
> 			      unsinged long dropped)
> {
> 	char dropped_msg[DROPPED_TEXT_MAX];
> 	int dropped_len;
>
> 	if (!con->dropped)
> 		return 0;
>
> 	/* Print it into ext_text, which is unused. */
> 	dropped_len = snprintf(dropped_msg, sizeof(dropped_msg),
> 		       "** %lu printk messages dropped **\n", con->dropped);
>
> 	/*
> 	 * The buffer might already be full only where the message consist
> 	 * of many very short lines. It is not much realistic.
> 	 */
> 	if (cmsg->outbuf_len + dropped_len + 1 > sizeof(cmsg->outbuf)) {
> 		/* Should never happen. */

This certainly can happen. @text is size CONSOLE_LOG_MAX, which is
LOG_LINE_MAX+PREFIX_MAX. So a totally legal formatted message of length
LOG_LINE_MAX-1 and a prefix will suddenly become truncated.

> 		if (WARN_ON_ONCE(dropped_len + 1 > sizeof(cmsg->outbuf)))
> 			return;
>
> 		/* Trunk the message like in record_print_text() */
> 		cmsg->outbuf_len = sizeof(cmsg->outbuf) - dropped_len;
> 		cmsg->outbuf[cmsg->outbuf_len] = '\0';
> 	}
>
> 	memmove(cmsg->outbuf + dropped_len, cmsg->outbuf, cmsg->outbuf_len + 1);
> 	memcpy(cmsg->outbuf, dropped_msg, dropped_len);
> }

I do not like the idea of increasing stack usage, possibly cutting off
messages, and performing extra memory operations all because of some
variable naming. There is literally a larger unused buffer just sitting
there.

I want struct console_buffers to be a black box of working buffers used
to process the different types of messages. console_get_next_message()
is the only function that should go inside that black box because it is
responsible for creating the actual message.

The caller does not care what is in the black box or how those internal
working buffers are named. The caller just cares about cmsg->outbuf and
cmsg->outbuf_len, which will point to the data that needs to be written
out.

For v3 I would like to try my approach one more time. I will give the
internal buffers new names so as not to mislead their roles. I will
clearly document the black box nature of struct console_buffers.

John Ogness
