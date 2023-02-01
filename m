Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 984966861DC
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Feb 2023 09:41:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231750AbjBAIlh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Feb 2023 03:41:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47418 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230200AbjBAIle (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Feb 2023 03:41:34 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE5645C0EB;
        Wed,  1 Feb 2023 00:41:33 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 86D2FB8212D;
        Wed,  1 Feb 2023 08:41:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DC08CC433D2;
        Wed,  1 Feb 2023 08:41:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1675240891;
        bh=h6baFCsgm+aiCf/GL1i1K7HcEqSR8H51V6MXvVl0qYw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=L4oIpLMaGdwjJT8sCC3AWXmzBNj7HqZAGszoXkmoWF+z5yFMfTq1jSRg3BEuW7jEn
         Zqwv2zAOVXBF8PmTWA7wfzwOQOnbJcAnsr8QGFzTI0EDaYF1RJpEFacuZzdB3uTIrj
         OoSuBVlJ9dGEE9yGaPZQcCumM+K924AmmfFEFtvc=
Date:   Wed, 1 Feb 2023 09:41:28 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     "D. Starke" <daniel.starke@siemens.com>
Cc:     linux-serial@vger.kernel.org, jirislaby@kernel.org,
        ilpo.jarvinen@linux.intel.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/3] tty: n_gsm: add TIOCMIWAIT support
Message-ID: <Y9oluEimqDixw60I@kroah.com>
References: <20230201080151.2068-1-daniel.starke@siemens.com>
 <20230201080151.2068-3-daniel.starke@siemens.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230201080151.2068-3-daniel.starke@siemens.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 01, 2023 at 09:01:51AM +0100, D. Starke wrote:
> From: Daniel Starke <daniel.starke@siemens.com>
> 
> Add support for the TIOCMIWAIT ioctl on the virtual ttys. This enables the
> user to wait for virtual modem signals like RING.
> 
> Signed-off-by: Daniel Starke <daniel.starke@siemens.com>
> ---
>  drivers/tty/n_gsm.c | 32 ++++++++++++++++++++++++++++++++
>  1 file changed, 32 insertions(+)
> 
> diff --git a/drivers/tty/n_gsm.c b/drivers/tty/n_gsm.c
> index 118511c1fa37..48fb7dad44cd 100644
> --- a/drivers/tty/n_gsm.c
> +++ b/drivers/tty/n_gsm.c
> @@ -1542,6 +1542,7 @@ static void gsm_process_modem(struct tty_struct *tty, struct gsm_dlci *dlci,
>  	if (brk & 0x01)
>  		tty_insert_flip_char(&dlci->port, 0, TTY_BREAK);
>  	dlci->modem_rx = mlines;
> +	wake_up_interruptible(&dlci->gsm->event);
>  }
>  
>  /**
> @@ -3848,6 +3849,35 @@ static int gsm_modem_update(struct gsm_dlci *dlci, u8 brk)
>  	return -EPROTONOSUPPORT;
>  }
>  
> +/**
> + * gsm_wait_modem_change	-	wait for modem status line change

No need for tabs.

Or for kernel doc for static functions, but that's not a big deal.

> + * @dlci: channel
> + * @mask: modem status line bits
> + */
> +

No blank line please, didn't checkpatch warn about that?

> +static int gsm_wait_modem_change(struct gsm_dlci *dlci, u32 mask)
> +{
> +	struct gsm_mux *gsm = dlci->gsm;
> +	u32 old = dlci->modem_rx & mask;
> +	int ret;
> +
> +	if (gsm->dead)
> +		return -ENODEV;
> +
> +	do {
> +		ret = wait_event_interruptible(gsm->event, gsm->dead
> +					      || old ^ (dlci->modem_rx & mask));
> +		if (ret)
> +			return ret;
> +		if (dlci->state != DLCI_OPEN)
> +			return -EL2NSYNC;
> +		if (gsm->dead)
> +			return -ENODEV;
> +	} while ((old ^ (dlci->modem_rx & mask)) == 0);

No way to break out of the loop if it goes for forever?

thanks,

greg k-h
