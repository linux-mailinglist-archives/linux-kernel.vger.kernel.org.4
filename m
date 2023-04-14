Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 697576E1EE5
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Apr 2023 11:01:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230220AbjDNJA7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Apr 2023 05:00:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37204 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229493AbjDNJA6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Apr 2023 05:00:58 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 50597D7
        for <linux-kernel@vger.kernel.org>; Fri, 14 Apr 2023 02:00:57 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id 09DAA1FD95;
        Fri, 14 Apr 2023 09:00:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1681462856; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=tiDQAb8/AOZZx80+lfd0myTLpak+o+19++MUXZfGldM=;
        b=nm0ICNh1aULQByRomYrRtNidFSG/fDkVGaWydyLgrEvGgygZRC66YQVkvFowbmOZF4IDfF
        zle2letCw4IuWn4bwsNCr0pTMUlPrSz0ICQoTPD9UUPEbDlUSf7nzTHTD2Lp1fYm3pblAm
        cWIVhehx8lyBealcyk4l9PZ3HgqHBd4=
Received: from suse.cz (unknown [10.100.208.146])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id A28182C15F;
        Fri, 14 Apr 2023 09:00:55 +0000 (UTC)
Date:   Fri, 14 Apr 2023 11:00:55 +0200
From:   Petr Mladek <pmladek@suse.com>
To:     Sergey Senozhatsky <senozhatsky@chromium.org>
Cc:     Steven Rostedt <rostedt@goodmis.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Yosry Ahmed <yosryahmed@google.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCHv2] seq_buf: add seq_buf_do_printk() helper
Message-ID: <ZDkWR2lq2MZ4r1aG@alley>
References: <20230411143852.868524-1-senozhatsky@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230411143852.868524-1-senozhatsky@chromium.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue 2023-04-11 23:38:52, Sergey Senozhatsky wrote:
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
> --- a/lib/seq_buf.c
> +++ b/lib/seq_buf.c
> @@ -93,6 +93,40 @@ int seq_buf_printf(struct seq_buf *s, const char *fmt, ...)
>  }
>  EXPORT_SYMBOL_GPL(seq_buf_printf);
>  
> +/**
> + * seq_buf_do_printk - printk seq_buf line by line
> + * @s: seq_buf descriptor
> + * @lvl: printk level
> + *
> + * printk()-s a multi-line sequential buffer line by line. The function
> + * makes sure that the buffer in @s is nul terminated and safe to read
> + * as a string.
> + */
> +void seq_buf_do_printk(struct seq_buf *s, const char *lvl)
> +{
> +	const char *start, *lf;
> +	int len;
> +
> +	if (s->size == 0 || s->len == 0)
> +		return;
> +
> +	seq_buf_terminate(s);
> +
> +	start = s->buffer;
> +	while ((lf = strchr(start, '\n'))) {
> +		len = lf - start + 1;
> +		printk("%s%.*s", lvl, len, start);
> +		start = ++lf;
> +	}
> +
> +	/* No trailing LF */
> +	if (start < s->buffer + s->len) {
> +		len = s->buffer + s->len - start;
> +		printk("%s%.*s\n", lvl, len, start);

We know that the string is '\0' terminated, so the last print
might be easier:

	if (start < s->buffer + s->len)
		printk("%s%s\n", lvl, start);

Anyway, it looks good. With or without this change:

Reviewed-by: Petr Mladek <pmladek@suse.com>

Best Regards,
Petr
