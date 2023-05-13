Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5B149701629
	for <lists+linux-kernel@lfdr.de>; Sat, 13 May 2023 12:31:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237636AbjEMKbW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 13 May 2023 06:31:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34448 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229653AbjEMKbR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 13 May 2023 06:31:17 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A553C2707;
        Sat, 13 May 2023 03:31:16 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3C79860DC1;
        Sat, 13 May 2023 10:31:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7F78EC433EF;
        Sat, 13 May 2023 10:31:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1683973875;
        bh=5NN3vTvtA3k7NEEN2qxhzaq6KiSZLMr+MGh82yJ/Gh8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=v0jjWKo1+3GZCdJ3KjIyvX16eX9tVdbZfjAF4e3JGaJej2iSZ6hPfFrqapXPTDKQN
         tLzrMP/rRv9YFpF3x/Qqdw55ah9nsdlZuK2l9oxgNxmibyVXvfiVMkljwMMBRbKf95
         W8hmsYoeRfZoi1OE5gCCshO5y07cnwVrF8BG9fPI=
Date:   Sat, 13 May 2023 19:22:26 +0900
From:   Greg KH <gregkh@linuxfoundation.org>
To:     "D. Starke" <daniel.starke@siemens.com>
Cc:     linux-serial@vger.kernel.org, jirislaby@kernel.org,
        ilpo.jarvinen@linux.intel.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 1/8] tty: n_gsm: add restart flag to DLC specific
 ioctl config
Message-ID: <2023051316-flatly-spookily-5a0a@gregkh>
References: <20230426080315.7595-1-daniel.starke@siemens.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230426080315.7595-1-daniel.starke@siemens.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 26, 2023 at 10:03:08AM +0200, D. Starke wrote:
> From: Daniel Starke <daniel.starke@siemens.com>
> 
> Currently, changing the parameters of a DLCI gives no direct control to the
> user whether this should trigger a channel reset or not. The decision is
> solely made by the driver based on the assumption which parameter changes
> are compatible or not. Therefore, the user has no means to perform an
> automatic channel reset after parameter configuration for non-conflicting
> changes.
> 
> Add the parameter 'flags' to 'gsm_dlci_config' to force a channel reset
> after ioctl setting regardless of whether the changes made require this or
> not by setting this to 'GSM_FL_RESTART'.
> 
> Note that 'GSM_FL_RESTART' is currently the only allow flag to allow
> additions here.
> 
> Signed-off-by: Daniel Starke <daniel.starke@siemens.com>
> ---
>  drivers/tty/n_gsm.c         |  4 ++++
>  include/uapi/linux/gsmmux.h | 13 ++++++++++++-
>  2 files changed, 16 insertions(+), 1 deletion(-)
> 
> v3 -> v4:
> Changed gsm_dlci_config field name from 'restart' to 'flags' and introduced
> 'GSM_FL_RESTART' to set the restart flag. The patch description was changed
> accordingly. This was done as suggested during the review.
> The remarked kernel doc compatible field comment is done in patch 2/8.
> 
> Link: https://lore.kernel.org/all/2023042453-dubbed-botany-2ed9@gregkh/
> 
> diff --git a/drivers/tty/n_gsm.c b/drivers/tty/n_gsm.c
> index b411a26cc092..66edcf65a4dd 100644
> --- a/drivers/tty/n_gsm.c
> +++ b/drivers/tty/n_gsm.c
> @@ -2532,6 +2532,8 @@ static int gsm_dlci_config(struct gsm_dlci *dlci, struct gsm_dlci_config *dc, in
>  		return -EINVAL;
>  	if (dc->k > 7)
>  		return -EINVAL;
> +	if (dc->flags & ~GSM_FL_RESTART)   /* allow future extensions */
> +		return -EINVAL;
>  
>  	/*
>  	 * See what is needed for reconfiguration
> @@ -2546,6 +2548,8 @@ static int gsm_dlci_config(struct gsm_dlci *dlci, struct gsm_dlci_config *dc, in
>  	/* Requires care */
>  	if (dc->priority != dlci->prio)
>  		need_restart = true;
> +	if (dc->flags & GSM_FL_RESTART)
> +		need_restart = true;
>  
>  	if ((open && gsm->wait_config) || need_restart)
>  		need_open = true;
> diff --git a/include/uapi/linux/gsmmux.h b/include/uapi/linux/gsmmux.h
> index eb67884e5f38..958257af05ab 100644
> --- a/include/uapi/linux/gsmmux.h
> +++ b/include/uapi/linux/gsmmux.h
> @@ -2,10 +2,20 @@
>  #ifndef _LINUX_GSMMUX_H
>  #define _LINUX_GSMMUX_H
>  
> +#include <linux/const.h>
>  #include <linux/if.h>
>  #include <linux/ioctl.h>
>  #include <linux/types.h>
>  
> +/*
> + * flags definition for n_gsm
> + *
> + * Used by:
> + * struct gsm_dlci_config.flags
> + */
> +/* Force DLCI channel reset? Always cleared on retrieval. */

I do not understand this comment, sorry.  What question are you asking?
What happens if it is set?  What happens if it is not set?  More
documentation is always good, especially for new user/kernel apis that
are not documented anywhere else.

thanks,

greg k-h
