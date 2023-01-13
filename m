Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 18FE666899C
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Jan 2023 03:32:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234131AbjAMCcx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Jan 2023 21:32:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55558 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229887AbjAMCct (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Jan 2023 21:32:49 -0500
Received: from mail-pg1-x52a.google.com (mail-pg1-x52a.google.com [IPv6:2607:f8b0:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A3B075D6A5
        for <linux-kernel@vger.kernel.org>; Thu, 12 Jan 2023 18:32:47 -0800 (PST)
Received: by mail-pg1-x52a.google.com with SMTP id q9so14081066pgq.5
        for <linux-kernel@vger.kernel.org>; Thu, 12 Jan 2023 18:32:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=kOmM1boioYg8LFtWAWs33j4bBuyb4KtgIsQ+w3Q1Nec=;
        b=Ms+uSdJMIWu+6/rPfkBxkXAr7MPZBipnJfzVJqCmg773hVvxRx+OKl/7d0nRAxXsTX
         oJrqG0gxih/ylYXorRI2xrOT6BC9zp2wrZANpID7nHNl7KGadbiX7PDfPfrpxIEmncPH
         +KS+1pR7XE/gs4blQKXKoaKeorMh34AzE1BA8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kOmM1boioYg8LFtWAWs33j4bBuyb4KtgIsQ+w3Q1Nec=;
        b=ClmMO5dJqJqLHL1/2mXlyXR215Vw2bcBIuTomFib6FIY7lQ6J8QWBV3u/ICvUXskEQ
         qlDyjh56019+yf7uqiVbonXG2qMamwDIzm2bnmLTwYtreFXiZ5c9YnvNIgxOd2uX96u0
         1euNPV9K4TcW0K5sahfKmWVLNZ6hLASZp1M2mqp3VHdNTQCOc2LJ6hdabaLVLO8Ub//H
         wFk767n4F9BAqu7Qkm/5ZENKlZX1ofS411+iFHX1cO6my112bqGgw+Xcxwe1Dux1eqFl
         fQOuX8n2I6m6xP0WydEZrrHRJGlYz7Amk9B7OZCDmm5QNucSSPOps1na4mMknK0fmByI
         qNEA==
X-Gm-Message-State: AFqh2krNufV5S8EzDyOjmUv52iBmvXiP3xOtslr7qjx5QUD0l8R6RlfM
        ZZPORFhrG10tu+osPjbBvAuT3w==
X-Google-Smtp-Source: AMrXdXtDHCAjBbBXjeoIpHmcmPAFTDOvNbFwRTgswr8/FoRJEOP33+VktonH7fugm95/k2TxfeSk3A==
X-Received: by 2002:a62:e703:0:b0:577:7cfb:a896 with SMTP id s3-20020a62e703000000b005777cfba896mr8682396pfh.31.1673577167232;
        Thu, 12 Jan 2023 18:32:47 -0800 (PST)
Received: from google.com (KD124209188001.ppp-bb.dion.ne.jp. [124.209.188.1])
        by smtp.gmail.com with ESMTPSA id y22-20020aa78f36000000b00562677968aesm12568828pfr.72.2023.01.12.18.32.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Jan 2023 18:32:46 -0800 (PST)
Date:   Fri, 13 Jan 2023 11:32:41 +0900
From:   Sergey Senozhatsky <senozhatsky@chromium.org>
To:     Petr Mladek <pmladek@suse.com>
Cc:     John Ogness <john.ogness@linutronix.de>,
        Sergey Senozhatsky <senozhatsky@chromium.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org,
        Jason Wessel <jason.wessel@windriver.com>,
        Daniel Thompson <daniel.thompson@linaro.org>,
        Douglas Anderson <dianders@chromium.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        kgdb-bugreport@lists.sourceforge.net, linux-serial@vger.kernel.org
Subject: Re: [PATCH] tty: serial: kgdboc: fix mutex locking order for
 configure_kgdboc()
Message-ID: <Y8DCyU0v0OUqArab@google.com>
References: <20230111145110.1327831-1-john.ogness@linutronix.de>
 <Y77imoYMaZZZz28x@alley>
 <Y8Ap4B75PNy5/lHo@alley>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y8Ap4B75PNy5/lHo@alley>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On (23/01/12 16:40), Petr Mladek wrote:
> On Wed 2023-01-11 17:23:55, Petr Mladek wrote:
> > On Wed 2023-01-11 15:57:10, John Ogness wrote:
> > > Several mutexes are taken while setting up console serial ports. In
> > > particular, the tty_port->mutex and @console_mutex are taken:
> > > 
> > >   serial_pnp_probe
> > >     serial8250_register_8250_port
> > >       uart_add_one_port (locks tty_port->mutex)
> > >         uart_configure_port
> > >           register_console (locks @console_mutex)
> > > 
> > > In order to synchronize kgdb's tty_find_polling_driver() with
> > > register_console(), commit 6193bc90849a ("tty: serial: kgdboc:
> > > synchronize tty_find_polling_driver() and register_console()") takes
> > > the @console_mutex. However, this leads to the following call chain
> > > (with locking):
> > > 
> > >   platform_probe
> > >     kgdboc_probe
> > >       configure_kgdboc (locks @console_mutex)
> > >         tty_find_polling_driver
> > >           uart_poll_init (locks tty_port->mutex)
> > >             uart_set_options
> > > 
> > > This is clearly deadlock potential due to the reverse lock ordering.
[..]
> > > -	console_list_lock();
> > > -
> > >  	p = tty_find_polling_driver(cptr, &tty_line);
> > >  	if (!p) {
> > >  		console_list_unlock();
> > 
> > This console_list_unlock() should be removed here as well.
> 
> This seems to be the only problem. Otherwise, the patch looks good to
> me.

Good catch.

Reviewed-by: Sergey Senozhatsky <senozhatsky@chromium.org>
