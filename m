Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8B1D668EEC1
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Feb 2023 13:19:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231218AbjBHMTN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Feb 2023 07:19:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56710 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231158AbjBHMTL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Feb 2023 07:19:11 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 875448A5C;
        Wed,  8 Feb 2023 04:19:09 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 14BCEB81DA6;
        Wed,  8 Feb 2023 12:19:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 22864C433D2;
        Wed,  8 Feb 2023 12:19:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1675858746;
        bh=5Jfj3/PD6+JR/ftglPqInMs523CbwoZ9vblwGE7RVXs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=E16wSLn239HQdDUltIS6AyNxIGtnp8K9kb7ZGw9K/dI/FKJE469QnrEkDweib3Ico
         3q4uf2ywFpUY1nXWlpxj5/5plYEVnVt3Xne+UWyXrYo5kOvzoO/j/VLWiXqNMpYFJo
         2WdFpgLqpagANXBaJrOdOT+KEpycHYv9pdZf7NRc=
Date:   Wed, 8 Feb 2023 13:19:03 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     "D. Starke" <daniel.starke@siemens.com>
Cc:     linux-serial@vger.kernel.org, jirislaby@kernel.org,
        ilpo.jarvinen@linux.intel.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 2/4] tty: n_gsm: add keep alive support
Message-ID: <Y+OTN4E6W5h4oztW@kroah.com>
References: <20230206114606.2133-1-daniel.starke@siemens.com>
 <20230206114606.2133-2-daniel.starke@siemens.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230206114606.2133-2-daniel.starke@siemens.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 06, 2023 at 12:46:04PM +0100, D. Starke wrote:
> From: Daniel Starke <daniel.starke@siemens.com>
> 
> n_gsm is based on the 3GPP 07.010 and its newer version is the 3GPP 27.010.
> See https://portal.3gpp.org/desktopmodules/Specifications/SpecificationDetails.aspx?specificationId=1516
> The changes from 07.010 to 27.010 are non-functional. Therefore, I refer to
> the newer 27.010 here. Chapters 5.4.6.3.4 and 5.1.8.1.3 describe the test
> command which can be used to test the mux connection between both sides.
> 
> Currently, no algorithm is implemented to make use of this command. This
> requires that each multiplexed upper layer protocol supervises the
> underlying muxer connection to handle possible connection losses.
> 
> Introduce an ioctl commands and functions to optionally enable keep alive
> handling via the test command as described in chapter 5.4.6.3.4. A single
> incrementing octet is being used to distinguish between multiple retries.
> Retry count and interval are taken from the general parameters N2 and T2.
> 
> Note that support for the test command is mandatory and already present in
> the muxer implementation since the very first version.
> Also note that the previous ioctl structure gsm_config cannot be extended
> due to missing checks against zero of the field "unused".
> 
> Signed-off-by: Daniel Starke <daniel.starke@siemens.com>
> ---
>  drivers/tty/n_gsm.c         | 107 +++++++++++++++++++++++++++++++++++-
>  include/uapi/linux/gsmmux.h |  10 ++++
>  2 files changed, 115 insertions(+), 2 deletions(-)
> 
> v3 -> v4:
> Changed gsm_config_ext() to perform the reserved fields check before taking
> the keep-alive parameter as recommended in the review.
> 
> Link: https://lore.kernel.org/all/Y+DVqtfBRytURnov@kroah.com/
> 
> diff --git a/drivers/tty/n_gsm.c b/drivers/tty/n_gsm.c
> index 5783801d6524..c94df9cd282f 100644
> --- a/drivers/tty/n_gsm.c
> +++ b/drivers/tty/n_gsm.c
> @@ -318,6 +318,11 @@ struct gsm_mux {
>  	struct gsm_control *pending_cmd;/* Our current pending command */
>  	spinlock_t control_lock;	/* Protects the pending command */
>  
> +	/* Keep-alive */
> +	struct timer_list ka_timer;	/* Keep-alive response timer */
> +	u8 ka_num;			/* Keep-alive match pattern */

What do you mean by "pattern"?

> +	int ka_retries;			/* Keep-alive retry counter */

I know padding doesn't really matter much here, but you are adding holes
here to this structure, is that intentional?

And why "int"?  What is the range here?  And shouldn't this be "signed
int" to be explicit you set this to -1 in places (and what does -1
mean?)

> +
>  	/* Configuration */
>  	int adaption;		/* 1 or 2 supported */
>  	u8 ftype;		/* UI or UIH */
> @@ -325,6 +330,7 @@ struct gsm_mux {
>  	unsigned int t3;	/* Power wake-up timer in seconds. */
>  	int n2;			/* Retry count */
>  	u8 k;			/* Window size */
> +	u32 keep_alive;		/* Control channel keep-alive in ms */
>  
>  	/* Statistics (not currently exposed) */
>  	unsigned long bad_fcs;
> @@ -1897,11 +1903,13 @@ static void gsm_control_response(struct gsm_mux *gsm, unsigned int command,
>  						const u8 *data, int clen)
>  {
>  	struct gsm_control *ctrl;
> +	struct gsm_dlci *dlci;
>  	unsigned long flags;
>  
>  	spin_lock_irqsave(&gsm->control_lock, flags);
>  
>  	ctrl = gsm->pending_cmd;
> +	dlci = gsm->dlci[0];
>  	command |= 1;
>  	/* Does the reply match our command */
>  	if (ctrl != NULL && (command == ctrl->cmd || command == CMD_NSC)) {
> @@ -1916,6 +1924,54 @@ static void gsm_control_response(struct gsm_mux *gsm, unsigned int command,
>  	/* Or did we receive the PN response to our PN command */
>  	} else if (command == CMD_PN) {
>  		gsm_control_negotiation(gsm, 0, data, clen);
> +	/* Or did we receive the TEST response to our TEST command */
> +	} else if (command == CMD_TEST && clen == 1 && *data == gsm->ka_num) {
> +		gsm->ka_retries = -1; /* trigger new keep-alive message */
> +		if (dlci && !dlci->dead)
> +			mod_timer(&gsm->ka_timer,
> +				  jiffies + gsm->keep_alive * HZ / 100);

We can use 100 columns now if you want to.

> +	}
> +	spin_unlock_irqrestore(&gsm->control_lock, flags);
> +}
> +
> +/**
> + * gsm_control_keep_alive	-	check timeout or start keep-alive
> + * @t: timer contained in our gsm object
> + *
> + * Called off the keep-alive timer expiry signaling that our link
> + * partner is not responding anymore. Link will be closed.
> + * This is also called to startup our timer.
> + */
> +
> +static void gsm_control_keep_alive(struct timer_list *t)
> +{
> +	struct gsm_mux *gsm = from_timer(gsm, t, ka_timer);
> +	unsigned long flags;
> +
> +	spin_lock_irqsave(&gsm->control_lock, flags);
> +	if (gsm->ka_num && gsm->ka_retries == 0) {
> +		/* Keep-alive expired -> close the link */
> +		if (debug & DBG_ERRORS)
> +			pr_info("%s keep-alive timed out\n", __func__);

info for a debugging error?  no, please don't do that.  Please fix up
the debugging mess in this driver, don't add to it.

> +		spin_unlock_irqrestore(&gsm->control_lock, flags);
> +		if (gsm->dlci[0])
> +			gsm_dlci_begin_close(gsm->dlci[0]);
> +		return;
> +	} else if (gsm->keep_alive && gsm->dlci[0] && !gsm->dlci[0]->dead) {
> +		if (gsm->ka_retries > 0) {
> +			/* T2 expired for keep-alive -> resend */
> +			gsm->ka_retries--;
> +		} else {
> +			/* Start keep-alive timer */
> +			gsm->ka_num++;
> +			if (!gsm->ka_num)
> +				gsm->ka_num++;
> +			gsm->ka_retries = gsm->n2;
> +		}
> +		gsm_control_command(gsm, CMD_TEST, &gsm->ka_num,
> +				    sizeof(gsm->ka_num));
> +		mod_timer(&gsm->ka_timer,
> +			  jiffies + gsm->t2 * HZ / 100);
>  	}
>  	spin_unlock_irqrestore(&gsm->control_lock, flags);
>  }
> @@ -2061,8 +2117,10 @@ static void gsm_dlci_close(struct gsm_dlci *dlci)
>  		/* Ensure that gsmtty_open() can return. */
>  		tty_port_set_initialized(&dlci->port, false);
>  		wake_up_interruptible(&dlci->port.open_wait);
> -	} else
> +	} else {
> +		del_timer(&dlci->gsm->ka_timer);
>  		dlci->gsm->dead = true;
> +	}
>  	/* A DLCI 0 close is a MUX termination so we need to kick that
>  	   back to userspace somehow */
>  	gsm_dlci_data_kick(dlci);
> @@ -2078,6 +2136,8 @@ static void gsm_dlci_close(struct gsm_dlci *dlci)
>  
>  static void gsm_dlci_open(struct gsm_dlci *dlci)
>  {
> +	struct gsm_mux *gsm = dlci->gsm;
> +
>  	/* Note that SABM UA .. SABM UA first UA lost can mean that we go
>  	   open -> open */
>  	del_timer(&dlci->t1);
> @@ -2087,8 +2147,15 @@ static void gsm_dlci_open(struct gsm_dlci *dlci)
>  	if (debug & DBG_ERRORS)
>  		pr_debug("DLCI %d goes open.\n", dlci->addr);
>  	/* Send current modem state */
> -	if (dlci->addr)
> +	if (dlci->addr) {
>  		gsm_modem_update(dlci, 0);
> +	} else {
> +		/* Start keep-alive control */
> +		gsm->ka_num = 0;
> +		gsm->ka_retries = -1;
> +		mod_timer(&gsm->ka_timer,
> +			  jiffies + gsm->keep_alive * HZ / 100);
> +	}
>  	gsm_dlci_data_kick(dlci);
>  	wake_up(&dlci->gsm->event);
>  }
> @@ -2840,6 +2907,7 @@ static void gsm_cleanup_mux(struct gsm_mux *gsm, bool disc)
>  	/* Finish outstanding timers, making sure they are done */
>  	del_timer_sync(&gsm->kick_timer);
>  	del_timer_sync(&gsm->t2_timer);
> +	del_timer_sync(&gsm->ka_timer);
>  
>  	/* Finish writing to ldisc */
>  	flush_work(&gsm->tx_work);
> @@ -2987,6 +3055,7 @@ static struct gsm_mux *gsm_alloc_mux(void)
>  	INIT_LIST_HEAD(&gsm->tx_data_list);
>  	timer_setup(&gsm->kick_timer, gsm_kick_timer, 0);
>  	timer_setup(&gsm->t2_timer, gsm_control_retransmit, 0);
> +	timer_setup(&gsm->ka_timer, gsm_control_keep_alive, 0);
>  	INIT_WORK(&gsm->tx_work, gsmld_write_task);
>  	init_waitqueue_head(&gsm->event);
>  	spin_lock_init(&gsm->control_lock);
> @@ -3003,6 +3072,7 @@ static struct gsm_mux *gsm_alloc_mux(void)
>  	gsm->mru = 64;	/* Default to encoding 1 so these should be 64 */
>  	gsm->mtu = 64;
>  	gsm->dead = true;	/* Avoid early tty opens */
> +	gsm->keep_alive = 0;	/* Disabled */
>  
>  	/* Store the instance to the mux array or abort if no space is
>  	 * available.
> @@ -3138,6 +3208,29 @@ static int gsm_config(struct gsm_mux *gsm, struct gsm_config *c)
>  	return 0;
>  }
>  
> +static void gsm_copy_config_ext_values(struct gsm_mux *gsm,
> +				       struct gsm_config_ext *ce)
> +{
> +	memset(ce, 0, sizeof(*ce));
> +	ce->keep_alive = gsm->keep_alive;
> +}
> +
> +static int gsm_config_ext(struct gsm_mux *gsm, struct gsm_config_ext *ce)
> +{
> +	unsigned int i;
> +
> +	/*
> +	 * Check that userspace doesn't put stuff in here to prevent breakages
> +	 * in the future.
> +	 */
> +	for (i = 0; i < ARRAY_SIZE(ce->reserved); i++)
> +		if (ce->reserved[i])
> +			return -EINVAL;
> +
> +	gsm->keep_alive = ce->keep_alive;
> +	return 0;
> +}
> +
>  /**
>   *	gsmld_output		-	write to link
>   *	@gsm: our mux
> @@ -3456,6 +3549,7 @@ static int gsmld_ioctl(struct tty_struct *tty, unsigned int cmd,
>  		       unsigned long arg)
>  {
>  	struct gsm_config c;
> +	struct gsm_config_ext ce;
>  	struct gsm_mux *gsm = tty->disc_data;
>  	unsigned int base;
>  
> @@ -3472,6 +3566,15 @@ static int gsmld_ioctl(struct tty_struct *tty, unsigned int cmd,
>  	case GSMIOC_GETFIRST:
>  		base = mux_num_to_base(gsm);
>  		return put_user(base + 1, (__u32 __user *)arg);
> +	case GSMIOC_GETCONF_EXT:
> +		gsm_copy_config_ext_values(gsm, &ce);
> +		if (copy_to_user((void __user *)arg, &ce, sizeof(ce)))
> +			return -EFAULT;
> +		return 0;
> +	case GSMIOC_SETCONF_EXT:
> +		if (copy_from_user(&ce, (void __user *)arg, sizeof(ce)))
> +			return -EFAULT;
> +		return gsm_config_ext(gsm, &ce);
>  	default:
>  		return n_tty_ioctl_helper(tty, cmd, arg);
>  	}
> diff --git a/include/uapi/linux/gsmmux.h b/include/uapi/linux/gsmmux.h
> index 785d6b253f6d..98de2570d79b 100644
> --- a/include/uapi/linux/gsmmux.h
> +++ b/include/uapi/linux/gsmmux.h
> @@ -39,4 +39,14 @@ struct gsm_netconfig {
>  /* get the base tty number for a configured gsmmux tty */
>  #define GSMIOC_GETFIRST		_IOR('G', 4, __u32)
>  
> +struct gsm_config_ext {
> +	__u32 keep_alive;	/* Control channel keep-alive in 1/100th of a
> +				 * second (0 to disable)
> +				 */
> +	__u32 reserved[7];	/* For future use */

say "must be set to 0"?

Where are you documenting this ioctl so userspace knows how to use it?
Where is the userspace tool that uses it?

thanks,

greg k-h
