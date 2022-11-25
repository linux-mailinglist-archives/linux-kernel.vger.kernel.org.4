Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2A69D6387D3
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Nov 2022 11:49:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230246AbiKYKtp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Nov 2022 05:49:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45052 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230243AbiKYKtn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Nov 2022 05:49:43 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 08A6748424
        for <linux-kernel@vger.kernel.org>; Fri, 25 Nov 2022 02:49:40 -0800 (PST)
From:   John Ogness <john.ogness@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1669373379;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=nwozR5nRSQcQOic3zPLWI/Ew+VMp0/ualSICVMwXUeg=;
        b=G+XsqUl9cz3x33oC4IKE1n8JkrPMykb6qYMDWPGS5kyWcgTS4QWGuLtDBrbBJMC6OqmAQ5
        S3GqoTR+a0wp6PLIiuoAz5zVBwoWvYzW4Z5BK0dl/qKdDWHJSAzz6rf4XO2Bhm+IkvJI8I
        uETrOqALcntF1mXV3Kp/LX6GTeTQmnllmI+EH49XgZQjwniAzE/YdSXwSwqmscmWn0ggyU
        ZC7m4+xaEiRqZY0pzOTVRFs5SQJXkJqUjBoeCh/QmmGoP5nEtyCPO2wjzAnkWAgfsxpwZQ
        Do6dH+1bug9togP2d8u1P/gpdoLDCe3Jqjl7p+goOISxL+HchNSSuN/AUMoHWQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1669373379;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=nwozR5nRSQcQOic3zPLWI/Ew+VMp0/ualSICVMwXUeg=;
        b=o2P2+51tJsmM4W4cZU5SsHj90rIMoZ8M3ruPFWQ4XPqFLe6T+yxshfrgo3NdWBGU8cmU0S
        UFnSmj8tW+UbSZAQ==
To:     Petr Mladek <pmladek@suse.com>
Cc:     Sergey Senozhatsky <senozhatsky@chromium.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCH printk v2 6/7] printk: Use an output buffer descriptor
 struct for emit
In-Reply-To: <Y4CEb7a57PpFpDni@alley>
References: <20221123231400.614679-1-john.ogness@linutronix.de>
 <20221123231400.614679-7-john.ogness@linutronix.de>
 <Y3+xK7hHmUIlzq9w@alley> <87o7swkqar.fsf@jogness.linutronix.de>
 <Y4CEb7a57PpFpDni@alley>
Date:   Fri, 25 Nov 2022 11:55:28 +0106
Message-ID: <87sfi7s407.fsf@jogness.linutronix.de>
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

On 2022-11-25, Petr Mladek <pmladek@suse.com> wrote:
> I am not sure if we are talking about the same thing. My idea was to
> do:

We are and your idea is fine.

>> The "problem" with this idea is that record_print_text() creates the
>> normal output in-place within the readbuf. So for normal messages with
>> no dropped messages, we still end up writing out the readbuf.
>
> We handle this this in console_get_next_message() by reading the
> messages into the right buffer:
>
> 	struct console_buffers {
> 		char	outbuf[CONSOLE_EXT_LOG_MAX];
> 		char	readbuf[CONSOLE_LOG_MAX];
> 	};
>
> 	boot is_extcon = console_srcu_read_flags(con) & CON_EXTENDED;
>
> 	/*
> 	 * Normal consoles might read the message into the outbuf directly.
> 	 * Console headers are added inplace.
> 	 */
> 	if (is_extcon)
> 		prb_rec_init_rd(&r, &info, &cbufs->readbuf[0], sizeof(cbufs->readbuf));
> 	else
> 		prb_rec_init_rd(&r, &info, &cbufs->outbuf[0], sizeof(cbufs->outbuf));
>
> 	if (!prb_read_valid(prb, con->seq, &r))
> 		return false;

We do not know if there will be dropped messages until _after_ we call
prb_read_valid().

> 	if (is_extcon) {
> 		len = info_print_ext_header(cbufs->outbuf, sizeof(cbufs->outbuf, r.info);
> 		len += msg_print_ext_body(cbufs->outbuf + len, sizeof(cbufs->outbuf) - len,
> 				  &r.text_buf[0], r.info->text_len, &r.info->dev_info);
> 	} else {
> 		len = record_print_text(&r, console_msg_format & MSG_FORMAT_SYSLOG, printk_time);
> 	}

And the dropped messages should be inserted now somewhere too.

The fact is that we need two different sized buffers. Which one is used
for output is not known in advance. I think it is misleading to name the
variables based on their purpose because their purpose changes depending
on the situation.

I think the only usefulness we can derive from the names is their
size. How about naming them:

@buffer_console_log_max
@buffer_console_ext_log_max

>> Since we sometimes output the in-place readbuf and sometimes a newly
>> written buffer, it is nice that console_message can abstract that
>> out.
>> 
>> Also, right now @is_extmsg is the only input variable. For
>> thread/atomic consoles, the input variables @seq and @dropped will be
>> added.  console_message will then have its own copy of all the
>> information needed to let itself get filled and
>> console_get_next_message() will no longer require the console as an
>> argument.
>> 
>> This is important for the thread/atomic consoles because it removes
>> all locking constraints from console_get_next_message(). For _this_
>> series, console_get_next_message() still requires holding the
>> console_lock because it is accessing con->seq and con->dropped.
>> 
>> I could have added @seq and @dropped to console_message for this
>> series, but for the legacy consoles it looks like a lot of
>> unnecessary copying. Only with the thread/atomic consoles does the
>> benefit become obvious.
>
> I could imagine adding these metadata into the struct console_buffers.
> Or we could call it struct console_messages from the beginning.
>
> We could even completely move con->seq, con->dropped into this new
> structure. It would safe even more copies.

Well, consoles still need to have their own copy of @seq and @dropped
for proper per-console tracking. But the buffers are globally shared.

For this series I will drop @is_extmsg from struct console_message and
instead make it an argument of console_get_next_message() and
msg_print_dropped(). That makes more sense at this point. (It needs to
be a variable because it is not safe to re-read flags multiple times
when constructing the message.)

For v3 I will move the two buffers (with whatever name we decide is
best) into struct console_message and remove the struct console_buffers
definition. That will also remove the use of @cbufs everywhere.

For devkmsg I can replace @cbufs with separate @readbuf and @outbuf
buffers since that is always their correct purpose for devkmsg.

John
