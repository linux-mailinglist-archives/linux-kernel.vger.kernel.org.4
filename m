Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3817D6DDA86
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Apr 2023 14:14:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229807AbjDKMOi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Apr 2023 08:14:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34376 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229506AbjDKMOh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Apr 2023 08:14:37 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C9EE35B5
        for <linux-kernel@vger.kernel.org>; Tue, 11 Apr 2023 05:14:36 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id C17C4219E9;
        Tue, 11 Apr 2023 12:14:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1681215274; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=t1nP4EzniW9Q3Zbh8SEd5898h+uhhJFoE4DHix8m1Bs=;
        b=RISNdkROeS7J4u4o97t2BsnpcyHDX5ayRD3kJM2qe113LlOyi49w2tLIj6+kvtED2qM6MT
        gfaEBn1dN8n1qDmEGewhsBv7Dh7pLyum0wH7wZ5OkvqhVOgzM2j6ppdk5YIP+40MUmVPh0
        EbT5yaEItPqhQ8oBdQZxnBI/qFF/HWA=
Received: from suse.cz (pmladek.udp.ovpn2.prg.suse.de [10.100.201.202])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id 5F84A2C141;
        Tue, 11 Apr 2023 12:14:34 +0000 (UTC)
Date:   Tue, 11 Apr 2023 14:14:30 +0200
From:   Petr Mladek <pmladek@suse.com>
To:     Sergey Senozhatsky <senozhatsky@chromium.org>
Cc:     Steven Rostedt <rostedt@goodmis.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Yosry Ahmed <yosryahmed@google.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] seq_buf: add seq_buf_printk() helper
Message-ID: <ZDVPJnx9tjetdm9K@alley>
References: <20230411025556.751349-1-senozhatsky@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230411025556.751349-1-senozhatsky@chromium.org>
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue 2023-04-11 11:55:56, Sergey Senozhatsky wrote:
> Sometimes we use seq_buf to format a string buffer, which
> we then pass to printk(). However, in certain situations
> the seq_buf string buffer can get too big, exceeding the
> PRINTKRB_RECORD_MAX bytes limit, and causing printk() to
> truncate the string.
> 
> Add a new seq_buf helper. This helper prints the seq_buf
> string buffer line by line, using \n as a delimiter,
> rather than passing the whole string buffer to printk()
> at once.
> 
> Signed-off-by: Sergey Senozhatsky <senozhatsky@chromium.org>
> ---
>  include/linux/seq_buf.h |  2 ++
>  lib/seq_buf.c           | 30 ++++++++++++++++++++++++++++++
>  2 files changed, 32 insertions(+)
> 
> diff --git a/include/linux/seq_buf.h b/include/linux/seq_buf.h
> index 5b31c5147969..80b78df89809 100644
> --- a/include/linux/seq_buf.h
> +++ b/include/linux/seq_buf.h
> @@ -159,4 +159,6 @@ extern int
>  seq_buf_bprintf(struct seq_buf *s, const char *fmt, const u32 *binary);
>  #endif
>  
> +void seq_buf_printk(struct seq_buf *s, const char *lvl);
> +
>  #endif /* _LINUX_SEQ_BUF_H */
> diff --git a/lib/seq_buf.c b/lib/seq_buf.c
> index 0a68f7aa85d6..9d13004c2324 100644
> --- a/lib/seq_buf.c
> +++ b/lib/seq_buf.c
> @@ -93,6 +93,36 @@ int seq_buf_printf(struct seq_buf *s, const char *fmt, ...)
>  }
>  EXPORT_SYMBOL_GPL(seq_buf_printf);
>  
> +/**
> + * seq_buf_printk - printk seq_buf line by line
> + * @s: seq_buf descriptor
> + * @lvl: printk level
> + *
> + * printk()-s a multi-line sequential buffer line by line
> + */
> +void seq_buf_printk(struct seq_buf *s, const char *lvl)

We might want to somehow distinguish that this is actually
printing (reading) the context of the buffer.

The name is similar to seq_buf_printf() and seq_buf_vprintf()
whose are wrinting into the buffer.

What about the following?

     + seq_buf_printf_seq() like the existing seq_buf_print_seq()
     + seq_buf_to_printk() like the existing seq_buf_to_user()

I personally prefer seq_buf_to_printk() because it looks more
selfexplaining to me.

Or maybe: seq_buf_to_printk_lvl() to allow later add
seq_buf_to_printk() that would us the default loglevel.


> +{
> +	const char *start, *lf;
> +	int len;
> +
> +	if (s->size == 0)
> +		return;
> +
> +	start = s->buffer;
> +	while ((lf = strchr(start, '\n'))) {

We should rather use strnchr(). It seems that the trailing '\0' is
not guaranteed. For example, seq_buf_putc() just adds the given
character at the end.

> +		len = lf - start + 1;
> +		printk("%s%.*s", lvl, len, start);
> +		start = ++lf;
> +	}
> +
> +	/* No trailing LF */
> +	if (start < s->buffer + s->len) {
> +		len = s->buffer + s->len - start;
> +		printk("%s%.*s\n", lvl, len, start);
> +	}
> +}
> +EXPORT_SYMBOL_GPL(seq_buf_printk);

Otherwise, it looks good to me.

Best Regards,
Petr
