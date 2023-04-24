Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2253E6ECABE
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Apr 2023 12:54:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231426AbjDXKyr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Apr 2023 06:54:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40988 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230185AbjDXKyq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Apr 2023 06:54:46 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 14B9FB0;
        Mon, 24 Apr 2023 03:54:45 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id ADA5F61272;
        Mon, 24 Apr 2023 10:54:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9D66AC433EF;
        Mon, 24 Apr 2023 10:54:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1682333684;
        bh=BXGM8fpfIzQRY5jCqRwKzG4f2BvNL62GtTIZ72FIrVs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=wPZKiM3nIDoEi68j5goIAqxAN2wtc18cFqYy1KmRpgptWEFSW/ga3iu+2rQLqa+8l
         k0FJuMqmf6i3HOP7T13dMZTMublMQ50iBAoSd9YuctsT4NiGu4DKUwtDxZsBokqBzL
         +AI5yu+rRHZuiPXyuXIAHd+Pz/+OWDnlZDKrtOMQ=
Date:   Mon, 24 Apr 2023 12:54:41 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     "D. Starke" <daniel.starke@siemens.com>
Cc:     linux-serial@vger.kernel.org, jirislaby@kernel.org,
        ilpo.jarvinen@linux.intel.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 1/8] tty: n_gsm: add restart parameter to DLC specific
 ioctl config
Message-ID: <2023042438-whole-cannot-1945@gregkh>
References: <20230424075251.5216-1-daniel.starke@siemens.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230424075251.5216-1-daniel.starke@siemens.com>
X-Spam-Status: No, score=-7.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 24, 2023 at 09:52:44AM +0200, D. Starke wrote:
> From: Daniel Starke <daniel.starke@siemens.com>
> 
> Currently, changing the parameters of a DLCI gives no direct control to the
> user whether this should trigger a channel reset or not. The decision is
> solely made by the driver based on the assumption which parameter changes
> are compatible or not. Therefore, the user has no means to perform an
> automatic channel reset after parameter configuration for non-conflicting
> changes.
> 
> Add the parameter 'restart' to 'gsm_dlci_config' to force a channel reset
> after ioctl setting regardless of whether the changes made require this or
> not.
> 
> Note that the parameter is limited to the values 0 and 1 to allow future
> additions here.
> 
> Signed-off-by: Daniel Starke <daniel.starke@siemens.com>
> ---
>  drivers/tty/n_gsm.c         | 4 ++++
>  include/uapi/linux/gsmmux.h | 3 ++-
>  2 files changed, 6 insertions(+), 1 deletion(-)
> 
> v2 -> v3:
> No changes.
> 
> Link: https://lore.kernel.org/all/20230420085017.7314-2-daniel.starke@siemens.com/
> 
> diff --git a/drivers/tty/n_gsm.c b/drivers/tty/n_gsm.c
> index b411a26cc092..00f692e2e810 100644
> --- a/drivers/tty/n_gsm.c
> +++ b/drivers/tty/n_gsm.c
> @@ -2532,6 +2532,8 @@ static int gsm_dlci_config(struct gsm_dlci *dlci, struct gsm_dlci_config *dc, in
>  		return -EINVAL;
>  	if (dc->k > 7)
>  		return -EINVAL;
> +	if (dc->restart > 1)   /* allow future extensions */
> +		return -EINVAL;
>  
>  	/*
>  	 * See what is needed for reconfiguration
> @@ -2546,6 +2548,8 @@ static int gsm_dlci_config(struct gsm_dlci *dlci, struct gsm_dlci_config *dc, in
>  	/* Requires care */
>  	if (dc->priority != dlci->prio)
>  		need_restart = true;
> +	if (dc->restart)
> +		need_restart = true;
>  
>  	if ((open && gsm->wait_config) || need_restart)
>  		need_open = true;
> diff --git a/include/uapi/linux/gsmmux.h b/include/uapi/linux/gsmmux.h
> index eb67884e5f38..33ee7b857c52 100644
> --- a/include/uapi/linux/gsmmux.h
> +++ b/include/uapi/linux/gsmmux.h
> @@ -58,7 +58,8 @@ struct gsm_dlci_config {
>  	__u32 priority;		/* Priority (0 for default value) */
>  	__u32 i;		/* Frame type (1 = UIH, 2 = UI) */
>  	__u32 k;		/* Window size (0 for default value) */
> -	__u32 reserved[8];	/* For future use, must be initialized to zero */
> +	__u32 restart;		/* Force DLCI channel reset? */

Why are you using a full 32 bits for just 1 bit of data here?  Why not
use a bitfield?

And what happened to the request to turn the documentation for this
structure into proper kerneldoc format?

thanks,

greg k-h
