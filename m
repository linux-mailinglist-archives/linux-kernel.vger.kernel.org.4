Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 77AD3653C50
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Dec 2022 07:49:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235011AbiLVGtq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Dec 2022 01:49:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34398 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231146AbiLVGtm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Dec 2022 01:49:42 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8AE796315;
        Wed, 21 Dec 2022 22:49:41 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 20945616FC;
        Thu, 22 Dec 2022 06:49:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 00E88C433EF;
        Thu, 22 Dec 2022 06:49:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1671691780;
        bh=PxB9B29t+wu7Ee/3qppFWwFT5pmBbW+2wNFQMS0ibvQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=0OYVet1si/wgwP3G9cWhvOx3z9yjW0yebdbqFrLiWWWxU3Iegt8Q9DEEAvoPyH3vm
         b3L7PQAu05WnavX0XoJFo9anpgNUAIoFterFgJBFxAzVw4EclZOdZMPHg+YMJeD5er
         kv6FljXqsD515QYBwOiRJHIkHKCoSECIbHNFSmfU=
Date:   Thu, 22 Dec 2022 07:49:37 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Joe Wu <joewu@msi.corp-partner.google.com>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Xiang wangx <wangxiang@cdjrlc.com>,
        Stephen Boyd <swboyd@chromium.org>,
        Prashant Malani <pmalani@chromium.org>,
        linux-input@vger.kernel.org,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        chrome-platform@lists.linux.dev,
        Benson Leung <bleung@chromium.org>,
        "Gustavo A . R . Silva" <gustavoars@kernel.org>,
        Guenter Roeck <groeck@chromium.org>,
        Douglas Anderson <dianders@chromium.org>,
        Daisuke Nojiri <dnojiri@chromium.org>,
        Derek Huang <derekhuang@google.com>,
        "Dustin L . Howett" <dustin@howett.net>, Joe Wu <joewu@msi.com>,
        Furquan Shaikh <furquan@chromium.org>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Lee Jones <lee.jones@linaro.org>,
        Tzung-Bi Shih <tzungbi@kernel.org>
Subject: Re: [PATCH] cros_ec_keyb: Add 3 buttons for monitor function
Message-ID: <Y6P+AWzD7/weYBOa@kroah.com>
References: <20221222063950.26018-1-joewu@msi.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221222063950.26018-1-joewu@msi.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 22, 2022 at 02:39:50PM +0800, Joe Wu wrote:
> Add 3 extra buttons: 'brightness up', 'brightness down'
> and 'screen lock' to support monitor manipulating function.
> 
> Signed-off-by: Joe Wu <joewu@msi.com>
> ---
> 
>  drivers/input/keyboard/cros_ec_keyb.c          | 15 +++++++++++++++
>  include/linux/platform_data/cros_ec_commands.h |  3 +++
>  2 files changed, 18 insertions(+)
> 
> diff --git a/drivers/input/keyboard/cros_ec_keyb.c b/drivers/input/keyboard/cros_ec_keyb.c
> index 6f435125ec03..e7ecfca838df 100644
> --- a/drivers/input/keyboard/cros_ec_keyb.c
> +++ b/drivers/input/keyboard/cros_ec_keyb.c
> @@ -100,6 +100,21 @@ static const struct cros_ec_bs_map cros_ec_keyb_bs[] = {
>  		.code		= KEY_VOLUMEDOWN,
>  		.bit		= EC_MKBP_VOL_DOWN,
>  	},
> +	{
> +		.ev_type        = EV_KEY,
> +		.code           = KEY_BRIGHTNESSUP,
> +		.bit            = EC_MKBP_BRI_UP,
> +	},
> +	{
> +		.ev_type        = EV_KEY,
> +		.code           = KEY_BRIGHTNESSDOWN,
> +		.bit            = EC_MKBP_BRI_DOWN,
> +	},
> +	{
> +		.ev_type        = EV_KEY,
> +		.code           = KEY_SCREENLOCK,
> +		.bit            = EC_MKBP_SCREEN_LOCK,
> +	},
>  
>  	/* Switches */
>  	{
> diff --git a/include/linux/platform_data/cros_ec_commands.h b/include/linux/platform_data/cros_ec_commands.h
> index 5744a2d746aa..a2073ed43972 100644
> --- a/include/linux/platform_data/cros_ec_commands.h
> +++ b/include/linux/platform_data/cros_ec_commands.h
> @@ -3471,6 +3471,9 @@ struct ec_response_get_next_event_v1 {
>  #define EC_MKBP_VOL_UP		1
>  #define EC_MKBP_VOL_DOWN	2
>  #define EC_MKBP_RECOVERY	3
> +#define EC_MKBP_BRI_UP		4
> +#define EC_MKBP_BRI_DOWN	5
> +#define EC_MKBP_SCREEN_LOCK	6
>  
>  /* Switches */
>  #define EC_MKBP_LID_OPEN	0
> -- 
> 2.17.1
> 

Hi,

This is the friendly patch-bot of Greg Kroah-Hartman.  You have sent him
a patch that has triggered this response.  He used to manually respond
to these common problems, but in order to save his sanity (he kept
writing the same thing over and over, yet to different people), I was
created.  Hopefully you will not take offence and will fix the problem
in your patch and resubmit it so that it can be accepted into the Linux
kernel tree.

You are receiving this message because of the following common error(s)
as indicated below:

- It looks like you did not use your "real" name for the patch on either
  the Signed-off-by: line, or the From: line (both of which have to
  match).  Please read the kernel file,
  Documentation/process/submitting-patches.rst for how to do this
  correctly.

- This looks like a new version of a previously submitted patch, but you
  did not list below the --- line any changes from the previous version.
  Please read the section entitled "The canonical patch format" in the
  kernel file, Documentation/process/submitting-patches.rst for what
  needs to be done here to properly describe this.

If you wish to discuss this problem further, or you have questions about
how to resolve this issue, please feel free to respond to this email and
Greg will reply once he has dug out from the pending patches received
from other developers.

thanks,

greg k-h's patch email bot
