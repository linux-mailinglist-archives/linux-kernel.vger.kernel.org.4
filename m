Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5759160CDB7
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Oct 2022 15:39:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232155AbiJYNjv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Oct 2022 09:39:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41730 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231544AbiJYNjr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Oct 2022 09:39:47 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DAC4736BE9;
        Tue, 25 Oct 2022 06:39:44 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id 928FB1F74A;
        Tue, 25 Oct 2022 13:39:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1666705183; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=jV+/V964f5a6YsdV9cIZOOLPnxJd1yg28bVzYXvdSNE=;
        b=XfWRH0X5l35RDq60Md4xj6mjphfPfdcDgAokBsoxJCwBD/D13j9+KFxlyb4FKt5iSZItym
        WXjU+SIf+EzrhXI/XgAOV3iJLTMLmTJ6FyEP7t+XkQMZVG9vPQfuK76P7B6rA86a9c2chI
        maR6uSFaDrSC1lZJQUYwHiA3mygb6rs=
Received: from suse.cz (unknown [10.100.208.146])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id 729402C141;
        Tue, 25 Oct 2022 13:39:43 +0000 (UTC)
Date:   Tue, 25 Oct 2022 15:39:40 +0200
From:   Petr Mladek <pmladek@suse.com>
To:     John Ogness <john.ogness@linutronix.de>
Cc:     Sergey Senozhatsky <senozhatsky@chromium.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org, Helge Deller <deller@gmx.de>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Javier Martinez Canillas <javierm@redhat.com>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        Juergen Gross <jgross@suse.com>, Tom Rix <trix@redhat.com>,
        linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org
Subject: Re: [PATCH printk v2 24/38] xen: fbfront: use srcu console list
 iterator
Message-ID: <Y1fnHH2J4bIS59ER@alley>
References: <20221019145600.1282823-1-john.ogness@linutronix.de>
 <20221019145600.1282823-25-john.ogness@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221019145600.1282823-25-john.ogness@linutronix.de>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed 2022-10-19 17:01:46, John Ogness wrote:
> Since the console_lock is not being used for anything other than
> safe console list traversal, use srcu console list iteration instead.
> 
> Signed-off-by: John Ogness <john.ogness@linutronix.de>

Reviewed-by: Petr Mladek <pmladek@suse.com>

> ---
>  drivers/video/fbdev/xen-fbfront.c | 8 +++++---
>  1 file changed, 5 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/video/fbdev/xen-fbfront.c b/drivers/video/fbdev/xen-fbfront.c
> index 4d2694d904aa..2552c853c6c2 100644
> --- a/drivers/video/fbdev/xen-fbfront.c
> +++ b/drivers/video/fbdev/xen-fbfront.c
> @@ -500,16 +500,18 @@ static int xenfb_probe(struct xenbus_device *dev,
>  static void xenfb_make_preferred_console(void)

Just for record. This function is a dirty hack how to associate "ttyX"
console with /dev/console.

A clean solution would be to just reshuffle console_drivers list. I
have a patch for this in my bottom drawer. It is part of a bigger
clean up that it not ready for upstreaming yet.

Best Regards,
Petr

>  {
>  	struct console *c;
> +	int cookie;
>  
>  	if (console_set_on_cmdline)
>  		return;
>  
> -	console_lock();
> -	for_each_console(c) {
> +	cookie = console_srcu_read_lock();
> +	for_each_console_srcu(c) {
>  		if (!strcmp(c->name, "tty") && c->index == 0)
>  			break;
>  	}
> -	console_unlock();
> +	console_srcu_read_unlock(cookie);
> +
>  	if (c) {
>  		unregister_console(c);
>  		c->flags |= CON_CONSDEV;
> -- 
> 2.30.2
