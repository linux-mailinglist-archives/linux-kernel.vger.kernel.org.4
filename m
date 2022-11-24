Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8DE0E637CD9
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Nov 2022 16:22:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230019AbiKXPWz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Nov 2022 10:22:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36696 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230043AbiKXPWi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Nov 2022 10:22:38 -0500
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 45AF065B6
        for <linux-kernel@vger.kernel.org>; Thu, 24 Nov 2022 07:22:31 -0800 (PST)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id B9EF41F889;
        Thu, 24 Nov 2022 15:22:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1669303349; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=gS76IAALQy+FQNDcUOeFvVits3ROZomZNjOflNybLy4=;
        b=b1FIFJOlMhFfC1gUTQ0+GOe8/iA375IgvFmrRncg9fJV66v2X0+n6qCdSom6+Y3bH+/cFf
        uGjoLW5GbFYNeiIoku506OnOZrPf+uPhs9m9EI1veZfeNwBOgAWuFuBwqyQIpHr/XKHz8e
        +OaXTssS7kwhYjghbOsPrQmd4Ad588Y=
Received: from suse.cz (unknown [10.100.201.202])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id 884832C141;
        Thu, 24 Nov 2022 15:22:29 +0000 (UTC)
Date:   Thu, 24 Nov 2022 16:22:29 +0100
From:   Petr Mladek <pmladek@suse.com>
To:     John Ogness <john.ogness@linutronix.de>
Cc:     Sergey Senozhatsky <senozhatsky@chromium.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH printk v2 5/7] printk: Use struct console_buffers
Message-ID: <Y3+MNS0yarwSgpR+@alley>
References: <20221123231400.614679-1-john.ogness@linutronix.de>
 <20221123231400.614679-6-john.ogness@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221123231400.614679-6-john.ogness@linutronix.de>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu 2022-11-24 00:19:58, John Ogness wrote:
> From: Thomas Gleixner <tglx@linutronix.de>
> 
> Replace the separately allocated output buffers with a single
> instance of struct console_buffers.
> 
> Note that the buffer size of devkmsg_user.text_buf, when replaced
> with console_buffers.text, reduces from CONSOLE_EXT_LOG_MAX to
> CONSOLE_LOG_MAX. However, the buffer is only used to read ringbuffer
> records. These records have a maximum size of LOG_LINE_MAX, which
> is defined as CONSOLE_LOG_MAX - PREFIX_MAX.
> 
> --- a/kernel/printk/printk.c
> +++ b/kernel/printk/printk.c
> @@ -2007,6 +2007,10 @@ static int console_trylock_spinning(void)
>  	return 1;
>  }
>  
> +#if DROPPED_TEXT_MAX > CONSOLE_EXT_LOG_MAX
> +#error "DROPPED_TEXT_MAX too large for console_buffers->ext_text"
> +#endif

A better solution would be to remove DROPPED_TEXT_MAX completely
and pass the buffer size to call_console_driver(). I mean to do:

static void call_console_driver(struct console *con, const char *text, size_t len,
-				char *dropped_text)
+				char *dropped_text, size_t dropped_text_size)
{
	size_t dropped_len;

-	if (con->dropped && dropped_text) {
-		dropped_len = snprintf(dropped_text, DROPPED_TEXT_MAX,
+	if (con->dropped && dropped_text && dropped_text_size) {
+		dropped_len = snprintf(dropped_text, dropped_text_size,
				       "** %lu printk messages dropped **\n",
				       con->dropped);
		con->dropped = 0;
		con->write(con, dropped_text, dropped_len);
	}

	con->write(con, text, len);
}

The rest looks good. And it is a nice clean up.

Best Regards,
Petr
