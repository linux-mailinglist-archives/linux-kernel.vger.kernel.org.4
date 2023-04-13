Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 349AE6E09A7
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Apr 2023 11:04:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229977AbjDMJEh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Apr 2023 05:04:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57184 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229951AbjDMJEO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Apr 2023 05:04:14 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4217D9029
        for <linux-kernel@vger.kernel.org>; Thu, 13 Apr 2023 02:03:41 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id D718E218D6;
        Thu, 13 Apr 2023 09:03:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1681376619; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=KV4d3BUt4ERuBIA1e4+EsOIH3BKf/5YsgbB/jlNy8ew=;
        b=nOivJRhIStBIT0lS3VzI5Q/5ohaFxhYLxlQiuXzlzZLNP2ywGXX5iWbgwl1gjmPlK0WsQD
        a+gtFeT1g8CqfQDKVinJWRAq74THut0cMlqcYBH4SJaceoxKX4Nd+YNQiEQl/hwyUZQoe8
        ul1PEgl/Kk14QsD4DwjSFZ9mm43bpfM=
Received: from suse.cz (unknown [10.100.201.202])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id 7B8D92C143;
        Thu, 13 Apr 2023 09:03:39 +0000 (UTC)
Date:   Thu, 13 Apr 2023 11:03:33 +0200
From:   Petr Mladek <pmladek@suse.com>
To:     John Ogness <john.ogness@linutronix.de>
Cc:     Sergey Senozhatsky <senozhatsky@chromium.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH printk v1 15/18] printk: nobkl: Stop threads on
 shutdown/reboot
Message-ID: <ZDfFZckqBwchfib5@alley>
References: <20230302195618.156940-1-john.ogness@linutronix.de>
 <20230302195618.156940-16-john.ogness@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230302195618.156940-16-john.ogness@linutronix.de>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu 2023-03-02 21:02:15, John Ogness wrote:
> Register a syscore_ops shutdown function to stop all threaded
> printers on shutdown/reboot. This allows printk to transition back
> to atomic printing in order to provide a robust mechanism for
> outputting the final messages.
>
> --- a/kernel/printk/printk_nobkl.c
> +++ b/kernel/printk/printk_nobkl.c
> @@ -1763,3 +1764,33 @@ void cons_nobkl_cleanup(struct console *con)
>  	cons_state_set(con, CON_STATE_REQ, &state);
>  	cons_free_percpu_data(con);
>  }
> +
> +/**
> + * printk_kthread_shutdown - shutdown all threaded printers
> + *
> + * On system shutdown all threaded printers are stopped. This allows printk
> + * to transition back to atomic printing, thus providing a robust mechanism
> + * for the final shutdown/reboot messages to be output.
> + */
> +static void printk_kthread_shutdown(void)
> +{
> +	struct console *con;
> +
> +	console_list_lock();
> +	for_each_console(con) {
> +		if (con->flags & CON_NO_BKL)
> +			cons_kthread_stop(con);
> +	}
> +	console_list_unlock();

It would make sense to explicitly flush the consoles after stopping
the kthreads. There might be pending messages...

> +}
> +
> +static struct syscore_ops printk_syscore_ops = {
> +	.shutdown = printk_kthread_shutdown,
> +};
> +
> +static int __init printk_init_ops(void)
> +{
> +	register_syscore_ops(&printk_syscore_ops);
> +	return 0;
> +}
> +device_initcall(printk_init_ops);

Otherwise it looks good.

Best Regards,
Petr
