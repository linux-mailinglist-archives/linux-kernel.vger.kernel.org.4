Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7E7FB65E7BF
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Jan 2023 10:27:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232016AbjAEJ1B (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Jan 2023 04:27:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40274 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230010AbjAEJ05 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Jan 2023 04:26:57 -0500
Received: from sin.source.kernel.org (sin.source.kernel.org [IPv6:2604:1380:40e1:4800::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 534DE551D9;
        Thu,  5 Jan 2023 01:26:56 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 9D324CE1A94;
        Thu,  5 Jan 2023 09:26:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CB41DC433D2;
        Thu,  5 Jan 2023 09:26:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1672910812;
        bh=+9ZE907Vc15LG3lF8cRKY8fbnn1srd+G9nbjuyEJj7c=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=SzxWY8o/Ow6igtlBqtBVZ48LGX3SCWt2nFL8BiNecCEbEj1E2FO7HX4CkuVKPDeSF
         cKsOn1EtL/07os90O5ghwk5omq3ZKp8Pdt+3eD6JOeNCUV8IWOvYnMnKCDw6XFUClD
         Zeo1eCKqGXQWssc//BnXkHrFymrbblbqDDXN13Xi359H2z60RpaDV2em4lndI+Hddm
         FwttT6P71u8Cf8rkggtod1givStsMcVKvx3dXdpXYDneZdzglnNXkVxvw6IS+CDjkK
         ebXaUPEwCkA4i6OKstfsEFYZmuRiZlh9Aa8mc6J7rcOV+KDV7ZfvhE0itqzLhk3l4M
         59Wvzq6O/OmCg==
Received: from johan by xi.lan with local (Exim 4.94.2)
        (envelope-from <johan@kernel.org>)
        id 1pDMWr-00053M-Ts; Thu, 05 Jan 2023 10:27:17 +0100
Date:   Thu, 5 Jan 2023 10:27:17 +0100
From:   Johan Hovold <johan@kernel.org>
To:     Ilpo =?utf-8?B?SsOkcnZpbmVu?= <ilpo.jarvinen@linux.intel.com>
Cc:     linux-serial@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 10/10] tty: Return bool from tty_termios_hw_change()
Message-ID: <Y7aX9XmjlwBcdZE5@hovoldconsulting.com>
References: <20230104151531.73994-1-ilpo.jarvinen@linux.intel.com>
 <20230104151531.73994-11-ilpo.jarvinen@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230104151531.73994-11-ilpo.jarvinen@linux.intel.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 04, 2023 at 05:15:31PM +0200, Ilpo Järvinen wrote:
> Change tty_termios_hw_change() return to bool and convert it to
> a or-chained return statement.
> 
> Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
> ---
>  drivers/tty/tty_ioctl.c | 10 ++++------
>  include/linux/tty.h     |  2 +-
>  2 files changed, 5 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/tty/tty_ioctl.c b/drivers/tty/tty_ioctl.c
> index ce511557b98b..4a80fabf6d5e 100644
> --- a/drivers/tty/tty_ioctl.c
> +++ b/drivers/tty/tty_ioctl.c
> @@ -270,13 +270,11 @@ EXPORT_SYMBOL(tty_termios_copy_hw);
>   *	between the two termios structures, or a speed change is needed.
>   */
>  
> -int tty_termios_hw_change(const struct ktermios *a, const struct ktermios *b)
> +bool tty_termios_hw_change(const struct ktermios *a, const struct ktermios *b)
>  {
> -	if (a->c_ispeed != b->c_ispeed || a->c_ospeed != b->c_ospeed)
> -		return 1;
> -	if ((a->c_cflag ^ b->c_cflag) & ~(HUPCL | CREAD | CLOCAL))
> -		return 1;
> -	return 0;
> +	return a->c_ispeed != b->c_ispeed ||
> +	       a->c_ospeed != b->c_ospeed ||
> +	       (a->c_cflag ^ b->c_cflag) & ~(HUPCL | CREAD | CLOCAL);

Please keep the current structure which is more readable rather than
merge everything into one long expression.

Johan
