Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4441060D0B6
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Oct 2022 17:35:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232183AbiJYPfP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Oct 2022 11:35:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43074 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233356AbiJYPfL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Oct 2022 11:35:11 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB6B197ED6
        for <linux-kernel@vger.kernel.org>; Tue, 25 Oct 2022 08:35:10 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id 6AB3B1F9BF;
        Tue, 25 Oct 2022 15:35:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1666712109; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=qqhEb2ihSVOs7s1JGMME0ep/AP7oc92gwbxiPCWRjTY=;
        b=U7zcq2sPhU5K0Yox+0kOows7P2/C/KUj5Dc5alM6awf6lt4GIO8GgijtBDKSZTCdxjCse6
        /VEQ7UFc6Uo9etMeTXX600NSB6BKVE2iLugKFs/dTy9/c3xqXMfxONkjKnJLumTylhkeS/
        Cd3iJuaOvQQRt29p5eiFbAiggkiqays=
Received: from suse.cz (unknown [10.100.208.146])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id 3AB4C2C141;
        Tue, 25 Oct 2022 15:35:09 +0000 (UTC)
Date:   Tue, 25 Oct 2022 17:35:08 +0200
From:   Petr Mladek <pmladek@suse.com>
To:     John Ogness <john.ogness@linutronix.de>
Cc:     Sergey Senozhatsky <senozhatsky@chromium.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH printk v2 30/38] printk: console_device: use srcu console
 list iterator
Message-ID: <Y1gCLDQP+6rYYRP5@alley>
References: <20221019145600.1282823-1-john.ogness@linutronix.de>
 <20221019145600.1282823-31-john.ogness@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221019145600.1282823-31-john.ogness@linutronix.de>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed 2022-10-19 17:01:52, John Ogness wrote:
> Use srcu console list iteration for console list traversal.
> 
> Document why the console_lock is still necessary.
> 
> Signed-off-by: John Ogness <john.ogness@linutronix.de>
> ---
>  kernel/printk/printk.c | 11 ++++++++++-
>  1 file changed, 10 insertions(+), 1 deletion(-)
> 
> diff --git a/kernel/printk/printk.c b/kernel/printk/printk.c
> index e478cb92e7ba..410ad9d5649c 100644
> --- a/kernel/printk/printk.c
> +++ b/kernel/printk/printk.c
> @@ -3025,15 +3025,24 @@ struct tty_driver *console_device(int *index)
>  {
>  	struct console *c;
>  	struct tty_driver *driver = NULL;
> +	int cookie;
>  
> +	/*
> +	 * Stop console printing because the device() callback may
> +	 * assume the console is not within its write() callback.

Again, I would like to know more details about the possible races
with the write() callback. It is not that obvious.

> +	 */
>  	console_lock();
> -	for_each_console(c) {
> +
> +	cookie = console_srcu_read_lock();
> +	for_each_console_srcu(c) {
>  		if (!c->device)
>  			continue;
>  		driver = c->device(c, index);
>  		if (driver)
>  			break;
>  	}
> +	console_srcu_read_unlock(cookie);
> +
>  	console_unlock();
>  	return driver;

Otherwise, the change looks good.

Best Regards,
Petr
