Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2136465C172
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Jan 2023 15:06:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233407AbjACOFJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Jan 2023 09:05:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54046 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237680AbjACOE7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Jan 2023 09:04:59 -0500
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B569C10B67
        for <linux-kernel@vger.kernel.org>; Tue,  3 Jan 2023 06:04:57 -0800 (PST)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id 6917867675;
        Tue,  3 Jan 2023 14:04:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1672754696; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=PaRbhhHoqreUbFey3ucxqIdyeoCz0oWvNnlSyJt1keE=;
        b=g2knTZ/XxipHkKpvZN4eEk2Ar0WdWmw6iP7ZiSwEIcgUK7YDcWAKJEse7janWxrGS/8AAx
        OEFUkjcHZIOvSeyImDq7iBMe046zG+eyB57tYf9qDKLoHaOJYqZv+OvdQ8PJxHCQ7bX+/i
        ZWbwWdUzMn/vx3ub+DtEPg6YKudKe84=
Received: from suse.cz (unknown [10.100.201.202])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id 286052C141;
        Tue,  3 Jan 2023 14:04:56 +0000 (UTC)
Date:   Tue, 3 Jan 2023 15:04:55 +0100
From:   Petr Mladek <pmladek@suse.com>
To:     John Ogness <john.ogness@linutronix.de>
Cc:     Sergey Senozhatsky <senozhatsky@chromium.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH printk v3 5/6] printk: introduce
 console_get_next_message() and console_message
Message-ID: <Y7Q2B+p1gxJ1WCdj@alley>
References: <20221221202704.857925-1-john.ogness@linutronix.de>
 <20221221202704.857925-6-john.ogness@linutronix.de>
 <87bknva1jg.fsf@jogness.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87bknva1jg.fsf@jogness.linutronix.de>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu 2022-12-22 16:47:39, John Ogness wrote:
> On 2022-12-21, John Ogness <john.ogness@linutronix.de> wrote:
> > +static bool console_emit_next_record(struct console *con, bool *handover, int cookie)
> > +{
> > +	bool is_extended = console_srcu_read_flags(con) & CON_EXTENDED;
> > +	static char dropped_text[DROPPED_TEXT_MAX];
> > +	static struct console_buffers cbufs;
> > +	static struct console_message cmsg = {
> > +		.cbufs = &cbufs,
> > +	};
> 
> @cmsg should not be static. The whole point of the console_message
> wrapper struct is so that it can sit on the stack.

Well, it might actually be better to keep it static for now.
It always points to static struct console_buffers cbufs anyway.

It would make sense to have it on stack only when it uses
different buffers.

Which brings the question. Does it makes sense to use
the same buffers by different struct console_message?
Will it be safe in any situation?

I did not want to complicate it yesterday. I think that
I have already proposed this. But this brings back
the question whether it makes sense to have two structures
at all.

I still think that it would be easier and even more safe
to put everything into struct console_message.

I mean to have:

struct console_message {
	char			buf[CONSOLE_EXT_LOG_MAX];
	char			scratch_buf[LOG_LINE_MAX];
	unsigned int		len;
	u64			seq;
	unsigned long		dropped;
};

Best Regards,
Petr
