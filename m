Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 93D826058E6
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Oct 2022 09:44:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230038AbiJTHoS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Oct 2022 03:44:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55566 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230418AbiJTHnf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Oct 2022 03:43:35 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 60264275F4
        for <linux-kernel@vger.kernel.org>; Thu, 20 Oct 2022 00:43:22 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id EACB261A2A
        for <linux-kernel@vger.kernel.org>; Thu, 20 Oct 2022 07:43:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0A511C433D6;
        Thu, 20 Oct 2022 07:43:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1666251801;
        bh=vHswNvB7lMLwEtAr2CrmuXqrTo1SRwafh/lwljKLsUg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=apJhTEP9JsbvN/rKVv9GRqwfTEor/dy9lppTOnPJkossa10elAt/84vEvlOZX3+cD
         oTW/UYq2oMMx2nfMc+S21g11PpKCWwsBJ53H5T7Q/P8U9wpnEUz7hZ63kWaXN4DD/x
         fyvSGOU2LIJNygVHrub81YA3P0UJE0nw8d2Y8D4E=
Date:   Thu, 20 Oct 2022 09:43:18 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     John Ogness <john.ogness@linutronix.de>
Cc:     Petr Mladek <pmladek@suse.com>,
        Sergey Senozhatsky <senozhatsky@chromium.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org, Jiri Slaby <jirislaby@kernel.org>
Subject: Re: [PATCH printk v2 23/38] tty: tty_io: document console_lock usage
Message-ID: <Y1D8FtH9HeM2aXSz@kroah.com>
References: <20221019145600.1282823-1-john.ogness@linutronix.de>
 <20221019145600.1282823-24-john.ogness@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221019145600.1282823-24-john.ogness@linutronix.de>
X-Spam-Status: No, score=-7.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 19, 2022 at 05:01:45PM +0206, John Ogness wrote:
> show_cons_active() uses the console_lock to gather information
> on registered consoles. Since the console_lock is being used for
> multiple reasons, explicitly document these reasons. This will
> be useful when the console_lock is split into fine-grained
> locking.
> 
> Signed-off-by: John Ogness <john.ogness@linutronix.de>
> ---
>  drivers/tty/tty_io.c | 8 ++++++++
>  1 file changed, 8 insertions(+)
> 
> diff --git a/drivers/tty/tty_io.c b/drivers/tty/tty_io.c
> index 2050e63963bb..333579bfa335 100644
> --- a/drivers/tty/tty_io.c
> +++ b/drivers/tty/tty_io.c
> @@ -3526,6 +3526,14 @@ static ssize_t show_cons_active(struct device *dev,
>  	struct console *c;
>  	ssize_t count = 0;
>  
> +	/*
> +	 * Hold the console_lock to guarantee that no consoles are
> +	 * unregistered until all console processing is complete.
> +	 * This also allows safe traversal of the console list.
> +	 *
> +	 * Stop console printing because the device() callback may
> +	 * assume the console is not within its write() callback.
> +	 */
>  	console_lock();
>  	for_each_console(c) {
>  		if (!c->device)
> -- 
> 2.30.2
> 

Reviewed-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
