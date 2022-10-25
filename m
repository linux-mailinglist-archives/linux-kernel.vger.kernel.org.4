Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6894660D08E
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Oct 2022 17:28:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233231AbiJYP21 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Oct 2022 11:28:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47974 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233228AbiJYP2X (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Oct 2022 11:28:23 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D153410F884
        for <linux-kernel@vger.kernel.org>; Tue, 25 Oct 2022 08:28:20 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id 7E2171F8A8;
        Tue, 25 Oct 2022 15:28:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1666711699; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=/o9zDdOplWoFe1gHONmvf+OT1OCX1C3rPWeCJRA+vow=;
        b=m/UDYWeRmAsgd5J6xxh9UQbdgDthjZcFr035rIKrnUTvna/6Li0J/KF/Vi6xmxd74eVBg7
        yxfKiAZ7JC3UAkGpER+u1Y+moRfUNHIPJt7uVTnBRMVBY4HLLoRF5lnRijtIOlwhEntHI4
        g+xHtiwsctK9jYjJ8862iUUqinJ3YfM=
Received: from suse.cz (unknown [10.100.208.146])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id 5E3DC2C141;
        Tue, 25 Oct 2022 15:28:19 +0000 (UTC)
Date:   Tue, 25 Oct 2022 17:28:18 +0200
From:   Petr Mladek <pmladek@suse.com>
To:     John Ogness <john.ogness@linutronix.de>
Cc:     Sergey Senozhatsky <senozhatsky@chromium.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH printk v2 28/38] printk: console_unblank: use srcu
 console list iterator
Message-ID: <Y1gAkjvSS3XXUJly@alley>
References: <20221019145600.1282823-1-john.ogness@linutronix.de>
 <20221019145600.1282823-29-john.ogness@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221019145600.1282823-29-john.ogness@linutronix.de>
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed 2022-10-19 17:01:50, John Ogness wrote:
> Use srcu console list iteration for console list traversal.
> 
> Document why the console_lock is still necessary.
> 
> Signed-off-by: John Ogness <john.ogness@linutronix.de>

Reviewed-by: Petr Mladek <pmladek@suse.com>

See a note below.

> --- a/kernel/printk/printk.c
> +++ b/kernel/printk/printk.c
> @@ -2948,10 +2948,14 @@ EXPORT_SYMBOL(console_conditional_schedule);
>  void console_unblank(void)
>  {
>  	struct console *c;
> +	int cookie;
>  
>  	/*
> -	 * console_unblank can no longer be called in interrupt context unless
> -	 * oops_in_progress is set to 1..
> +	 * Stop console printing because the unblank() callback may
> +	 * assume the console is not within its write() callback.

From some reason, I believe this even without more details. I expect
that unbank() would need to refresh the screen and use similar
code as the write() callback.

It is different than the device() callback where the dependency is
less obvious.

Best Regards,
Petr

> +	 *
> +	 * If @oops_in_progress is set, this may be an atomic context.
> +	 * In that case, attempt a trylock as best-effort.
>  	 */
>  	if (oops_in_progress) {
>  		if (down_trylock_console_sem() != 0)
> @@ -2961,9 +2965,14 @@ void console_unblank(void)
>  
>  	console_locked = 1;
>  	console_may_schedule = 0;
> -	for_each_console(c)
> +
> +	cookie = console_srcu_read_lock();
> +	for_each_console_srcu(c) {
>  		if (console_is_enabled(c) && c->unblank)
>  			c->unblank();
> +	}
> +	console_srcu_read_unlock(cookie);
> +
>  	console_unlock();
>  
>  	if (!oops_in_progress)
