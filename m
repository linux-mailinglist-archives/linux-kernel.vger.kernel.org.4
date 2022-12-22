Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DD490653BD4
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Dec 2022 06:49:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232553AbiLVFte (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Dec 2022 00:49:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41232 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229531AbiLVFtc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Dec 2022 00:49:32 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD1FA1903A;
        Wed, 21 Dec 2022 21:49:30 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 7DEDE619A9;
        Thu, 22 Dec 2022 05:49:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2516AC433EF;
        Thu, 22 Dec 2022 05:49:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1671688168;
        bh=nmkK+b6rO2+px289TNdsGXRo/I0rx3JEOKY+uOPK8+o=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=sxanfO0yJjrscX73PpAiSWzPJ63Y41V/jiTGYv2Z9axMIeVIS0D7Y+XrGfsssXVyB
         pOmyOKGq4hGmpnWkBip6Pc/rU3k9wARlISEY8rDm6va6ieqwQQ5SlKhQHbooONTLT3
         k/fw6veUUpU4CHQIT1qnW8PWnr2YHurhQw44HSy8=
Date:   Thu, 22 Dec 2022 06:49:25 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Viken Dadhaniya <quic_vdadhani@quicinc.com>
Cc:     jirislaby@kernel.org, linux-serial@vger.kernel.org,
        linux-kernel@vger.kernel.org, quic_msavaliy@quicinc.com,
        quic_vnivarth@quicinc.com, quic_vtanuku@quicinc.com,
        quic_arandive@quicinc.com
Subject: Re: [PATCH V1 1/1] Serial: core: Add compat ioctl support
Message-ID: <Y6Pv5WWtM63DwCAl@kroah.com>
References: <20221222044925.27846-1-quic_vdadhani@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221222044925.27846-1-quic_vdadhani@quicinc.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 22, 2022 at 10:19:25AM +0530, Viken Dadhaniya wrote:
> Current serial core driver doesn't support compat_ioctl
> due to which 32-bit application is not able to send
> ioctls to driver on a 64-bit platform.

Are you sure?

> Added compat_ioctl support in serial core to handle
> ioctls from 32-bit applications on a 64-bit platform.
> 
> Signed-off-by: Viken Dadhaniya <quic_vdadhani@quicinc.com>
> ---
>  drivers/tty/serial/serial_core.c | 17 +++++++++++++++++
>  1 file changed, 17 insertions(+)
> 
> diff --git a/drivers/tty/serial/serial_core.c b/drivers/tty/serial/serial_core.c
> index b9fbbee598b8..5ffa0798db3b 100644
> --- a/drivers/tty/serial/serial_core.c
> +++ b/drivers/tty/serial/serial_core.c
> @@ -1601,6 +1601,22 @@ uart_ioctl(struct tty_struct *tty, unsigned int cmd, unsigned long arg)
>  	return ret;
>  }
>  
> +/**
> + * uart_compat_ioctl: uart compat IOCTL function.
> + * @tty: pointer to tty structure.
> + * @cmd: command code passed by user-space.
> + * @arg: argument  passed by user-space.
> + *
> + * This function will call normal uart IOCTL.
> + *
> + * Return: 0 for success, Negative number for error condition.

Why create kernel doc for a static function?  uart_ioctl() does not have
this, right?

> + */
> +static long
> +uart_compat_ioctl(struct tty_struct *tty, unsigned int cmd, unsigned long arg)
> +{
> +	return (long)uart_ioctl(tty, cmd, arg);
> +};

Really?  Why has this never shown up before as an issue?

How was this tested?  What is currently broken that now works properly
(or the other way around?)

This patch implies that _every_ driver with an ioctl must create a
compat_ioctl() callback, are you sure that is the case?

thanks,

greg k-h
