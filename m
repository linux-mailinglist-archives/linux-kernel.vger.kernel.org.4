Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 00FF7607314
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Oct 2022 10:58:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229862AbiJUI6F (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Oct 2022 04:58:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33550 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230372AbiJUI6A (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Oct 2022 04:58:00 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C5A59250EC6
        for <linux-kernel@vger.kernel.org>; Fri, 21 Oct 2022 01:57:59 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id 7DB562198C;
        Fri, 21 Oct 2022 08:57:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1666342678; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=B2Y0GlvXm/0Ll2IMTJGRuBmYerTkcFfinMHJqCDyPSM=;
        b=AKdTrbJWLII6m+rx/pP+d6gHEUjZutJ8rwfCaL4qFQeVYRpiKUOn0tFL54Ku4A3QyUUSz8
        VkY+BMxVUWQ1vuP1Bzw9HaRZeyfgJek7HKl32QTlWsK6KgrGN+QKH9UbIhRVCRFSNDegLU
        aIw5qJ1gooX68/p4HmBtezDDvIfHskM=
Received: from suse.cz (unknown [10.100.208.146])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id 4D7822C141;
        Fri, 21 Oct 2022 08:57:58 +0000 (UTC)
Date:   Fri, 21 Oct 2022 10:57:57 +0200
From:   Petr Mladek <pmladek@suse.com>
To:     John Ogness <john.ogness@linutronix.de>
Cc:     Sergey Senozhatsky <senozhatsky@chromium.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCH printk v2 04/38] printk: introduce console_is_enabled()
 wrapper
Message-ID: <Y1JfFTAIbcFOrPtD@alley>
References: <20221019145600.1282823-1-john.ogness@linutronix.de>
 <20221019145600.1282823-5-john.ogness@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221019145600.1282823-5-john.ogness@linutronix.de>
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed 2022-10-19 17:01:26, John Ogness wrote:
> After switching to SRCU for console list iteration, some readers
> will begin accessing console->flags as a data race. This is safe
> because there is at most one CPU modifying console->flags and
> using rmw operations.
> 
> The primary reason for readers to access console->flags is to
> check if the console is enabled. Introduce console_is_enabled()
> to mark such access as a data race.
> 
> Signed-off-by: John Ogness <john.ogness@linutronix.de>
> ---
>  include/linux/console.h | 20 ++++++++++++++++++++
>  1 file changed, 20 insertions(+)
> 
> diff --git a/include/linux/console.h b/include/linux/console.h
> index cff86cc615f8..60195cd086dc 100644
> --- a/include/linux/console.h
> +++ b/include/linux/console.h
> @@ -172,6 +172,26 @@ extern void console_srcu_read_unlock(int cookie);
>  
>  extern struct hlist_head console_list;
>  
> +/**
> + * console_is_enabled - Check if the console is enabled
> + * @con:	struct console pointer of console to check
> + *
> + * This should be used instead of manually testing for the CON_ENABLED
> + * bit in the console->flags.
> + *
> + * Context: Any context.
> + */
> +static inline bool console_is_enabled(const struct console *con)
> +{
> +	/*
> +	 * If SRCU is used, reading of console->flags can be a data
> +	 * race. However, this is safe because there is at most one
> +	 * CPU modifying console->flags and it is using only
> +	 * read-modify-write operations to do so.

Hmm, I somehow do not understand the explanation. How does
read-modify-write operation make this safe, please?

We are interested into one bit. IMHO, it is not important
if the flags variable is modified atomically or byte by byte.
The important thing is if the reading is synchronized against
modifications.

This function does not do any synchronization on its own.
So, it depends on the caller.


I would personally do two variants. for example:

    console_is_enabled()
    console_is_enabled_safe()

The first variant would be called in situations where the race
does not matter and the other when it matters.



> +	 */
> +	return (data_race(READ_ONCE(con->flags)) & CON_ENABLED);
> +}
> +
>  /**
>   * for_each_console_srcu() - Iterator over registered consoles
>   * @con:	struct console pointer used as loop cursor

Best Regards,
Petr
