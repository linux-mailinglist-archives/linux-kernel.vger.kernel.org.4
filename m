Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8F07569A893
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Feb 2023 10:49:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230158AbjBQJtQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Feb 2023 04:49:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45402 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229775AbjBQJtO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Feb 2023 04:49:14 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9882D2940C;
        Fri, 17 Feb 2023 01:49:13 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3360161797;
        Fri, 17 Feb 2023 09:49:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 21D9BC433D2;
        Fri, 17 Feb 2023 09:49:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1676627352;
        bh=GFix8wyHqONHgXdn5jnag796HFS07LWp5WIGA5E/2hc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ZgL6oWLJU4ZMK4Y+BUVWQ5EL0QjqqkqZCu98wz097TbKfGZ8/ZiUSOzbKvB8lDkJC
         Q/TZN0Ur5OvWj9aT26Asvx4TQCk/vJL4mWNnzaaEOH0Pl6XDbtXfkju9jvj6jfcdm1
         yVOaTUzDu3wkAhxfgs5qXl8066KxsJ/TMf/9GRHY=
Date:   Fri, 17 Feb 2023 10:49:09 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Florian Eckert <fe@dev.tdt.de>
Cc:     u.kleine-koenig@pengutronix.de, jirislaby@kernel.org, pavel@ucw.cz,
        lee@kernel.org, linux-kernel@vger.kernel.org,
        linux-leds@vger.kernel.org, Eckert.Florian@googlemail.com
Subject: Re: [PATCH v2 1/2] tty: new helper function tty_get_mget
Message-ID: <Y+9Nldv99/YoMK8Y@kroah.com>
References: <20230217094403.1574468-1-fe@dev.tdt.de>
 <20230217094403.1574468-2-fe@dev.tdt.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230217094403.1574468-2-fe@dev.tdt.de>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 17, 2023 at 10:44:02AM +0100, Florian Eckert wrote:
> For a given struct tty_struct, this provides the appropriate tty line
> state flags needed to add more modes to the ledtrig-tty trigger.
> 
> The new function is then used to get via tty_tiocmget() the different tty
> line states.
> 
> Signed-off-by: Florian Eckert <fe@dev.tdt.de>
> ---
>  drivers/tty/tty_io.c | 30 +++++++++++++++++++++++-------
>  include/linux/tty.h  |  1 +
>  2 files changed, 24 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/tty/tty_io.c b/drivers/tty/tty_io.c
> index 3149114bf130..f049ab8b3362 100644
> --- a/drivers/tty/tty_io.c
> +++ b/drivers/tty/tty_io.c
> @@ -2493,26 +2493,42 @@ static int send_break(struct tty_struct *tty, unsigned int duration)
>  	return retval;
>  }
>  
> +/*
> + * tty_get_mget		-	get modem status
> + * @tty: tty device
> + *
> + * Obtain the modem status bits from the tty driver if the feature
> + * is supported. Return -ENOTTY if it is not available.

Please make this proper kernel doc, the first comment line has to be /**

And you didn't mark -ENOTTY properly here either :(

> + */
> +int tty_get_mget(struct tty_struct *tty)
> +{
> +	int retval = -ENOTTY;
> +
> +	if (tty->ops->tiocmget)
> +		retval = tty->ops->tiocmget(tty);
> +
> +	return retval;
> +}
> +EXPORT_SYMBOL_GPL(tty_get_mget);
> +
>  /**
>   * tty_tiocmget		-	get modem status
>   * @tty: tty device
>   * @p: pointer to result
>   *
>   * Obtain the modem status bits from the tty driver if the feature is
> - * supported. Return -%ENOTTY if it is not available.
> + * supported.

Why did you remove the return value statement from the documentation
here?  It's still true, right?

thanks,

greg k-h
