Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BD39065C299
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Jan 2023 16:00:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237881AbjACO6k (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Jan 2023 09:58:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34514 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238208AbjACO57 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Jan 2023 09:57:59 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F2C1422E
        for <linux-kernel@vger.kernel.org>; Tue,  3 Jan 2023 06:57:57 -0800 (PST)
From:   John Ogness <john.ogness@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1672757875;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=e7z7CUNlsanp+SPsDxU+kUkk2ziXu09FTtaRiMc8sLk=;
        b=DlyQin0OsEKElx4hYsx/267klTWIelW3dGApenDzv6Xruj44R2wal0V8aZbzw7gFYRyeJf
        OUHqKpo0jSd1lzVjH8dD4qLR1oXTMlRuMzi13zxSmqdTqXVPaG4rEoHJBIf11cAxJXbfiY
        7h/oBFQ4K98b/CAos6YT1hDDDZUn8MLbP+PEqdaHpgXAh2bzAakODazlGb6+y3IwqWVJnt
        ELLso9dEcqd4xEKv+piTu2HStLcfmk3sf9exQC+JUIgnGU+brgDaHIQUdtvWkMna9vWpWv
        pinlMzhdzH0bgEllcpVb9wYtVT/sJGvmQX+isQyl4h8RkkPjyCVW1+b4Pe5uaw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1672757875;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=e7z7CUNlsanp+SPsDxU+kUkk2ziXu09FTtaRiMc8sLk=;
        b=0Cxs5uJ8Vio3XZoYVwkn68Y9s9X4SQK3Mgf8Z2S3g4oX9HY+wqGKFrHlph1+9z1jIlVYis
        d8diMOARWb4BRpBA==
To:     Petr Mladek <pmladek@suse.com>
Cc:     Sergey Senozhatsky <senozhatsky@chromium.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH printk v3 5/6] printk: introduce
 console_get_next_message() and console_message
In-Reply-To: <Y7Q2B+p1gxJ1WCdj@alley>
References: <20221221202704.857925-1-john.ogness@linutronix.de>
 <20221221202704.857925-6-john.ogness@linutronix.de>
 <87bknva1jg.fsf@jogness.linutronix.de> <Y7Q2B+p1gxJ1WCdj@alley>
Date:   Tue, 03 Jan 2023 16:03:17 +0106
Message-ID: <87ilhnd5te.fsf@jogness.linutronix.de>
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

On 2023-01-03, Petr Mladek <pmladek@suse.com> wrote:
> On Thu 2022-12-22 16:47:39, John Ogness wrote:
>> On 2022-12-21, John Ogness <john.ogness@linutronix.de> wrote:
>> > +static bool console_emit_next_record(struct console *con, bool *handover, int cookie)
>> > +{
>> > +	bool is_extended = console_srcu_read_flags(con) & CON_EXTENDED;
>> > +	static char dropped_text[DROPPED_TEXT_MAX];
>> > +	static struct console_buffers cbufs;
>> > +	static struct console_message cmsg = {
>> > +		.cbufs = &cbufs,
>> > +	};
>> 
>> @cmsg should not be static. The whole point of the console_message
>> wrapper struct is so that it can sit on the stack.
>
> Well, it might actually be better to keep it static for now.
> It always points to static struct console_buffers cbufs anyway.
>
> It would make sense to have it on stack only when it uses
> different buffers.

I think we should avoid making things static when it serves no purpose.

> Which brings the question. Does it makes sense to use
> the same buffers by different struct console_message?
> Will it be safe in any situation?
>
> I did not want to complicate it yesterday. I think that
> I have already proposed this. But this brings back
> the question whether it makes sense to have two structures
> at all.
>
> I still think that it would be easier and even more safe
> to put everything into struct console_message.
>
> I mean to have:
>
> struct console_message {
> 	char			buf[CONSOLE_EXT_LOG_MAX];
> 	char			scratch_buf[LOG_LINE_MAX];
> 	unsigned int		len;
> 	u64			seq;
> 	unsigned long		dropped;
> };

The current atomic console proposal allocates 1x cbuf per-cpu and 4x
meta-data per-cpu. Different contexts of a cpu will have different
meta-data, but all the contexts of a cpu will share the same cbuf.

If cbufs become embedded in cmsg, then we would allocate 1x cmsg
per-cpu. But the atomic consoles would still need their own 4x per-cpu
meta-data.

When looking at the proposal code, it looks wrong to have meta-data
fields in the cmsg struct that are not being used. But maybe that is
acceptable during the "transition phase" until all legacy consoles are
gone.

For v4 I will drop the console_buffers struct. I will use your
suggestion.

John
