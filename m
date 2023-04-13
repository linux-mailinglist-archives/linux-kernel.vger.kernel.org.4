Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8B8096E0D60
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Apr 2023 14:20:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229954AbjDMMUy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Apr 2023 08:20:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39626 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229708AbjDMMUu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Apr 2023 08:20:50 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E821459ED
        for <linux-kernel@vger.kernel.org>; Thu, 13 Apr 2023 05:20:48 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id A07ED21862;
        Thu, 13 Apr 2023 12:20:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1681388447; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=lqZVUfwmcACp3NfAD201FJPzDAQF/Baeqyz1OVnVtH0=;
        b=Dj71QoEUtL2c2eOlBVa3ZzJdbcN48SegwJNv7nY3KXrJ9dlJjmFJJmtRqO/EIu8c/fjHfF
        SEmdiFhS/Jh2WMA840KHjYnjDlRiIzd2ECPqa/Ri2HtJNEXjJwcb67hTmoIDYr1SXdNw6+
        0+WofV/Xf3m2kZIYKXiBcM7copRgKcQ=
Received: from suse.cz (unknown [10.100.201.202])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id 733992C143;
        Thu, 13 Apr 2023 12:20:47 +0000 (UTC)
Date:   Thu, 13 Apr 2023 14:20:47 +0200
From:   Petr Mladek <pmladek@suse.com>
To:     John Ogness <john.ogness@linutronix.de>
Cc:     Sergey Senozhatsky <senozhatsky@chromium.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH printk v1 18/18] printk: Perform atomic flush in
 console_flush_on_panic()
Message-ID: <ZDfzn4UgbWTfjWGA@alley>
References: <20230302195618.156940-1-john.ogness@linutronix.de>
 <20230302195618.156940-19-john.ogness@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230302195618.156940-19-john.ogness@linutronix.de>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu 2023-03-02 21:02:18, John Ogness wrote:
> Typically the panic() function will take care of atomic flushing the
> non-BKL consoles on panic. However, there are several users of
> console_flush_on_panic() outside of panic().
> 
> Also perform atomic flushing in console_flush_on_panic(). A new
> function cons_force_seq() is implemented to support the
> mode=CONSOLE_REPLAY_ALL feature.
> 
> --- a/kernel/printk/printk.c
> +++ b/kernel/printk/printk.c
> @@ -3160,6 +3160,28 @@ void console_unblank(void)
>   */
>  void console_flush_on_panic(enum con_flush_mode mode)
>  {
> +	struct console *c;
> +	short flags;
> +	int cookie;
> +	u64 seq;
> +
> +	seq = prb_first_valid_seq(prb);
> +
> +	/*
> +	 * Safely flush the atomic consoles before trying to flush any
> +	 * BKL/legacy consoles.
> +	 */
> +	if (mode == CONSOLE_REPLAY_ALL) {
> +		cookie = console_srcu_read_lock();
> +		for_each_console_srcu(c) {
> +			flags = console_srcu_read_flags(c);
> +			if (flags & CON_NO_BKL)
> +				cons_force_seq(c, seq);
> +		}
> +		console_srcu_read_unlock(cookie);
> +	}
> +	cons_atomic_flush(NULL, true);
> +
>  	if (!have_bkl_console)
>  		return;
>  
> @@ -3174,12 +3196,6 @@ void console_flush_on_panic(enum con_flush_mode mode)
>  	console_may_schedule = 0;
>  
>  	if (mode == CONSOLE_REPLAY_ALL) {
> -		struct console *c;
> -		int cookie;
> -		u64 seq;
> -
> -		seq = prb_first_valid_seq(prb);
> -
>  		cookie = console_srcu_read_lock();
>  		for_each_console_srcu(c) {
>  			/*

The code in this for_each_console_srcu(c) will reset r->seq
for all consoles, including NO_BLK ones. It should do it
only for the legacy consoles.

Best Regards,
Petr
