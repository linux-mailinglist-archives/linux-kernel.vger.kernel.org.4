Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9AC7863807C
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Nov 2022 22:15:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229515AbiKXVPW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Nov 2022 16:15:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50588 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229448AbiKXVPV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Nov 2022 16:15:21 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC67492091
        for <linux-kernel@vger.kernel.org>; Thu, 24 Nov 2022 13:15:19 -0800 (PST)
From:   John Ogness <john.ogness@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1669324518;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=STjMXZbqhHt2AZsaB++TQDIVnU1zjXIbAYWgnK6f29A=;
        b=U5uUaZoyr+zoIr7ZFLM925jn9+16NoI+eic8QdQWa8rDmgtAedwsyi3kDxPob+Bzd0Lwiv
        j8tANCbtLXcYd7mZKrKe4CO2CoZ1fgvrceyaMSf9Tug6T+B9ruq2lYCdYyV9AIspk/2okh
        ecGEk3GuP5XXJnuoFO59CIDI0uOqHoVzd0tkiDWdmvVNj8onm0/QFwAXvIXmntnWaziePn
        Su796FGyr2VtY3650f97GLUDh1yXFjk0zuFJMyLrkdV97ti0ILSMaAysgyDyrlKLjBl5zc
        1iky8DoCPdXQuHkBto+t2kYjcqjqNdNUPU8O9NIGeGw8c+n0GpGkTxN/kqe4qQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1669324518;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=STjMXZbqhHt2AZsaB++TQDIVnU1zjXIbAYWgnK6f29A=;
        b=flApnUH7mrhia1zsMHaTWo7TBeO3TBJ8PJfpIbPMcTlZGSAeoPWUtDR63MnQEpSuiurTm2
        6B3osPTBsNMOPqDg==
To:     Petr Mladek <pmladek@suse.com>
Cc:     Sergey Senozhatsky <senozhatsky@chromium.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCH printk v2 6/7] printk: Use an output buffer descriptor
 struct for emit
In-Reply-To: <Y3+xK7hHmUIlzq9w@alley>
References: <20221123231400.614679-1-john.ogness@linutronix.de>
 <20221123231400.614679-7-john.ogness@linutronix.de>
 <Y3+xK7hHmUIlzq9w@alley>
Date:   Thu, 24 Nov 2022 22:21:08 +0106
Message-ID: <87o7swkqar.fsf@jogness.linutronix.de>
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

On 2022-11-24, Petr Mladek <pmladek@suse.com> wrote:
> I wish, this change was done in two patches. 1st introducing and
> using struct console_message. 2nd moving the code into separate
> console_get_next_message().

OK.

>> +	if (cmsg->is_extmsg) {
>> +		write_text = &cbufs->ext_text[0];
>> +		write_text_size = sizeof(cbufs->ext_text);
>> +		len = info_print_ext_header(write_text, write_text_size, r.info);
>> +		len += msg_print_ext_body(write_text + len, write_text_size - len,
>> +					  &r.text_buf[0], r.info->text_len, &r.info->dev_info);
>> +	} else {
>> +		write_text = &cbufs->text[0];
>> +		len = record_print_text(&r, console_msg_format & MSG_FORMAT_SYSLOG, printk_time);
>> +	}
>> +
>> +	cmsg->outbuf = write_text;
>> +	cmsg->outbuf_len = len;
>
> Please, remove "write_text" variable and use cmsg->outbuf directly.
> It would safe one mental transition of buffer names:
>
>    cbufs->text -> write_text -> cmsg->outbuf
>
> vs.
>
>    cbufs->text -> cmsg->outbuf

I originally had the non-extended case without @write_text. I felt like
it was harder to follow what actually got set. Really the main objective
of the function is to set @outbuf and @outbuf_len. I felt like moving
that outside of the if/else block made it clearer what is going on. But
I can go back to having each if/else branch set those fields in their
own way.

> PS: Please, wait a bit with updating the patches. I have got yet
>     another idea when seeing the code around dropped messages.
>     But I have to sleep over it.

Don't worry. I always wait until you finish the full review before
touching anything. ;-)

>     My concern is that the message about dropped messages need not
>     fit into the smaller "cbufs->text" buffer. It might be better
>     to put it into the bigger one.

This series _does_ put the dropped messages in the bigger one.

>     We might actually always use the bigger buffer as the output
>     buffer. The smaller buffer might be only temporary when formatting
>     the extended messages.
>
>      We could replace
>
> 	struct console_buffers {
> 		char	ext_text[CONSOLE_EXT_LOG_MAX];
> 		char	text[CONSOLE_LOG_MAX];
> 	};
>
>     with
>
> 	struct console_buffers {
> 		char	outbuf[CONSOLE_EXT_LOG_MAX];
> 		char	readbuf[CONSOLE_LOG_MAX];
> 	};
>
>      Normal consoles would use only @outbuf. Only the extended console
>      would need the @readbuf to read the messages before they are
>      formatted.

The "problem" with this idea is that record_print_text() creates the
normal output in-place within the readbuf. So for normal messages with
no dropped messages, we still end up writing out the readbuf.

>      I guess that struct console_message won't be needed then at all.

Since we sometimes output the in-place readbuf and sometimes a newly
written buffer, it is nice that console_message can abstract that out.

Also, right now @is_extmsg is the only input variable. For thread/atomic
consoles, the input variables @seq and @dropped will be added.
console_message will then have its own copy of all the information
needed to let itself get filled and console_get_next_message() will no
longer require the console as an argument.

This is important for the thread/atomic consoles because it removes all
locking constraints from console_get_next_message(). For _this_ series,
console_get_next_message() still requires holding the console_lock
because it is accessing con->seq and con->dropped.

I could have added @seq and @dropped to console_message for this series,
but for the legacy consoles it looks like a lot of unnecessary
copying. Only with the thread/atomic consoles does the benefit become
obvious.

>      It might help to remove several twists in the code.

A lot of this is preparation for the thread/atomic consoles. It is a
little bit twisty because it is primarily designed for the new
consoles. The trick is to get us from old to new without things getting
crazy in between.

I appreciate your comments. You see things from the perspective of the
"legacy consoles", which is helpful for us to keep things clean and
maintainable during the transition.

John
