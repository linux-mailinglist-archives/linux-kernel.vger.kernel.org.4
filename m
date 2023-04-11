Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F055B6DDD55
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Apr 2023 16:11:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229638AbjDKOLL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Apr 2023 10:11:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41154 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229493AbjDKOKi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Apr 2023 10:10:38 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D975C10E
        for <linux-kernel@vger.kernel.org>; Tue, 11 Apr 2023 07:10:36 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 75B406117E
        for <linux-kernel@vger.kernel.org>; Tue, 11 Apr 2023 14:10:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3DAECC4339B;
        Tue, 11 Apr 2023 14:10:35 +0000 (UTC)
Date:   Tue, 11 Apr 2023 10:10:33 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Petr Mladek <pmladek@suse.com>
Cc:     Sergey Senozhatsky <senozhatsky@chromium.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Yosry Ahmed <yosryahmed@google.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] seq_buf: add seq_buf_printk() helper
Message-ID: <20230411101033.1868494e@gandalf.local.home>
In-Reply-To: <ZDVPJnx9tjetdm9K@alley>
References: <20230411025556.751349-1-senozhatsky@chromium.org>
        <ZDVPJnx9tjetdm9K@alley>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.0 required=5.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 11 Apr 2023 14:14:30 +0200
Petr Mladek <pmladek@suse.com> wrote:

> > diff --git a/include/linux/seq_buf.h b/include/linux/seq_buf.h
> > index 5b31c5147969..80b78df89809 100644
> > --- a/include/linux/seq_buf.h
> > +++ b/include/linux/seq_buf.h
> > @@ -159,4 +159,6 @@ extern int
> >  seq_buf_bprintf(struct seq_buf *s, const char *fmt, const u32 *binary);
> >  #endif
> >  
> > +void seq_buf_printk(struct seq_buf *s, const char *lvl);
> > +
> >  #endif /* _LINUX_SEQ_BUF_H */
> > diff --git a/lib/seq_buf.c b/lib/seq_buf.c
> > index 0a68f7aa85d6..9d13004c2324 100644
> > --- a/lib/seq_buf.c
> > +++ b/lib/seq_buf.c
> > @@ -93,6 +93,36 @@ int seq_buf_printf(struct seq_buf *s, const char *fmt, ...)
> >  }
> >  EXPORT_SYMBOL_GPL(seq_buf_printf);
> >  
> > +/**
> > + * seq_buf_printk - printk seq_buf line by line
> > + * @s: seq_buf descriptor
> > + * @lvl: printk level
> > + *
> > + * printk()-s a multi-line sequential buffer line by line
> > + */
> > +void seq_buf_printk(struct seq_buf *s, const char *lvl)  
> 
> We might want to somehow distinguish that this is actually
> printing (reading) the context of the buffer.
> 
> The name is similar to seq_buf_printf() and seq_buf_vprintf()
> whose are wrinting into the buffer.
> 
> What about the following?
> 
>      + seq_buf_printf_seq() like the existing seq_buf_print_seq()
>      + seq_buf_to_printk() like the existing seq_buf_to_user()
> 
> I personally prefer seq_buf_to_printk() because it looks more
> selfexplaining to me.
> 
> Or maybe: seq_buf_to_printk_lvl() to allow later add
> seq_buf_to_printk() that would us the default loglevel.
> 

seq_buf came from trace_seq to become more generic. trace_seq is also part
of the libtraceevent library, and there we have:

  trace_seq_do_printf()

 https://www.trace-cmd.org/Documentation/libtraceevent/libtraceevent-tseq.html

That is to differentiate the trace_seq_printf() function. And does what
this function is doing (dumping the buffer).

Perhaps we should use the precedence of that function and have:

  seq_buf_do_printk()

> 
> > +{
> > +	const char *start, *lf;
> > +	int len;
> > +
> > +	if (s->size == 0)
> > +		return;
> > +
> > +	start = s->buffer;
> > +	while ((lf = strchr(start, '\n'))) {  
> 
> We should rather use strnchr(). It seems that the trailing '\0' is
> not guaranteed. For example, seq_buf_putc() just adds the given
> character at the end.

I think we should add a seq_buf_terminate() that adds the '\0' to the
buffer. There's one for user space (trace_seq_terminate()).

It's a nop if it already has the '\0'.

I think we should add that first, and then we can use that when entering
this function.

-- Steve

> 
> > +		len = lf - start + 1;
> > +		printk("%s%.*s", lvl, len, start);
> > +		start = ++lf;
> > +	}
> > +
> > +	/* No trailing LF */
> > +	if (start < s->buffer + s->len) {
> > +		len = s->buffer + s->len - start;
> > +		printk("%s%.*s\n", lvl, len, start);
> > +	}
> > +}
> > +EXPORT_SYMBOL_GPL(seq_buf_printk);  
> 
> Otherwise, it looks good to me.
> 
> Best Regards,
> Petr

