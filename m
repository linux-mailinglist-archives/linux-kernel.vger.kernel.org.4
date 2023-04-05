Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C92C96D7724
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Apr 2023 10:41:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237334AbjDEIlr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Apr 2023 04:41:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36036 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237109AbjDEIlq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Apr 2023 04:41:46 -0400
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 24441273D;
        Wed,  5 Apr 2023 01:41:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1680684106; x=1712220106;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=aSEnaur7VF25s/BeoCbYIGmSK0flElXeOMmnrUL78c0=;
  b=CbZPt7N+QTR6IaZ8N0RnDcoRZ3jFFjpoLSbjBxddR9HEcYWCcICbA6vE
   1m5fXLQCvabv48vGpnLZyQjqz/t2AjkG6PUkV1jAmExCl5My+jluKOVd6
   JUQh9TKqw4pvlvFHwLjBA6rKeIDRM/RZotGDreoHbJkXr4IvdqhjCFp+p
   pVkd6iJbpte5PQjwJ0Nf2yf7wiNPa7tgTaQUNHZMeCFt13L2V6C+WYlrU
   rSaN5NoMiZYlrhgMnVKTUrxNDmdQESzmPQEsOxHgvCsmnZFJp3CnIuAea
   L083NhkD/rJvVeW633cioq3PxcKJumNl7EQG1J+SpZ5MGWKV/+fVOnbUc
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10670"; a="326434969"
X-IronPort-AV: E=Sophos;i="5.98,319,1673942400"; 
   d="scan'208";a="326434969"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Apr 2023 01:41:46 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10670"; a="751193590"
X-IronPort-AV: E=Sophos;i="5.98,319,1673942400"; 
   d="scan'208";a="751193590"
Received: from wtedesch-mobl1.ger.corp.intel.com ([10.252.53.134])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Apr 2023 01:41:42 -0700
Date:   Wed, 5 Apr 2023 11:41:40 +0300 (EEST)
From:   =?ISO-8859-15?Q?Ilpo_J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>
To:     "D. Starke" <daniel.starke@siemens.com>
cc:     linux-serial <linux-serial@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 5/9] tty: n_gsm: add open_error counter to gsm_mux
In-Reply-To: <20230405054730.3850-5-daniel.starke@siemens.com>
Message-ID: <ffacb4a7-7875-445d-a2ab-38c4e595e3bc@linux.intel.com>
References: <20230405054730.3850-1-daniel.starke@siemens.com> <20230405054730.3850-5-daniel.starke@siemens.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Spam-Status: No, score=-0.1 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 5 Apr 2023, D. Starke wrote:

> From: Daniel Starke <daniel.starke@siemens.com>
> 
> Extend the n_gsm link statistics by a failed link open counter in
> preparation for an upcoming patch which will expose these.
> This counter is increased whenever an attempt to open the control channel
> failed.
> 
> Signed-off-by: Daniel Starke <daniel.starke@siemens.com>
> ---
>  drivers/tty/n_gsm.c | 33 ++++++++++++++++++++++++++-------
>  1 file changed, 26 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/tty/n_gsm.c b/drivers/tty/n_gsm.c
> index d42b92cbae88..9f6669686c59 100644
> --- a/drivers/tty/n_gsm.c
> +++ b/drivers/tty/n_gsm.c
> @@ -338,6 +338,7 @@ struct gsm_mux {
>  	unsigned long bad_fcs;
>  	unsigned long malformed;
>  	unsigned long io_error;
> +	unsigned long open_error;
>  	unsigned long bad_size;
>  	unsigned long unsupported;
>  };
> @@ -1729,25 +1730,32 @@ static void gsm_control_negotiation(struct gsm_mux *gsm, unsigned int cr,
>  	struct gsm_dlci *dlci;
>  	struct gsm_dlci_param_bits *params;
>  
> -	if (dlen < sizeof(struct gsm_dlci_param_bits))
> +	if (dlen < sizeof(struct gsm_dlci_param_bits)) {
> +		gsm->open_error++;
>  		return;
> +	}
>  
>  	/* Invalid DLCI? */
>  	params = (struct gsm_dlci_param_bits *)data;
>  	addr = FIELD_GET(PN_D_FIELD_DLCI, params->d_bits);
> -	if (addr == 0 || addr >= NUM_DLCI || !gsm->dlci[addr])
> +	if (addr == 0 || addr >= NUM_DLCI || !gsm->dlci[addr]) {
> +		gsm->open_error++;
>  		return;
> +	}
>  	dlci = gsm->dlci[addr];
>  
>  	/* Too late for parameter negotiation? */
> -	if ((!cr && dlci->state == DLCI_OPENING) || dlci->state == DLCI_OPEN)
> +	if ((!cr && dlci->state == DLCI_OPENING) || dlci->state == DLCI_OPEN) {
> +		gsm->open_error++;
>  		return;
> +	}
>  
>  	/* Process the received parameters */
>  	if (gsm_process_negotiation(gsm, addr, cr, params) != 0) {
>  		/* Negotiation failed. Close the link. */
>  		if (debug & DBG_ERRORS)
>  			pr_info("%s PN failed\n", __func__);
> +		gsm->open_error++;
>  		gsm_dlci_close(dlci);
>  		return;
>  	}
> @@ -1767,6 +1775,7 @@ static void gsm_control_negotiation(struct gsm_mux *gsm, unsigned int cr,
>  	} else {
>  		if (debug & DBG_ERRORS)
>  			pr_info("%s PN in invalid state\n", __func__);
> +		gsm->open_error++;
>  	}

I'd use the "rollback" pattern here for all these and goto open_failed;
+ do the open_error increment there only once.

>  }
>  
> @@ -2220,6 +2229,7 @@ static void gsm_dlci_t1(struct timer_list *t)
>  			dlci->retries--;
>  			mod_timer(&dlci->t1, jiffies + gsm->t1 * HZ / 100);
>  		} else {
> +			gsm->open_error++;
>  			gsm_dlci_begin_close(dlci); /* prevent half open link */
>  		}
>  		break;
> @@ -2235,6 +2245,7 @@ static void gsm_dlci_t1(struct timer_list *t)
>  			dlci->mode = DLCI_MODE_ADM;
>  			gsm_dlci_open(dlci);
>  		} else {
> +			gsm->open_error++;
>  			gsm_dlci_begin_close(dlci); /* prevent half open link */
>  		}
>  
> @@ -2756,12 +2767,16 @@ static void gsm_queue(struct gsm_mux *gsm)
>  
>  	switch (gsm->control) {
>  	case SABM|PF:
> -		if (cr == 1)
> +		if (cr == 1) {
> +			gsm->open_error++;
>  			goto invalid;
> +		}
>  		if (dlci == NULL)
>  			dlci = gsm_dlci_alloc(gsm, address);
> -		if (dlci == NULL)
> +		if (dlci == NULL) {
> +			gsm->open_error++;
>  			return;
> +		}
>  		if (dlci->dead)
>  			gsm_response(gsm, address, DM|PF);
>  		else {
> @@ -3754,8 +3769,10 @@ static int gsmld_ioctl(struct tty_struct *tty, unsigned int cmd,
>  		dlci = gsm->dlci[dc.channel];
>  		if (!dlci) {
>  			dlci = gsm_dlci_alloc(gsm, dc.channel);
> -			if (!dlci)
> +			if (!dlci) {
> +				gsm->open_error++;
>  				return -ENOMEM;
> +			}
>  		}
>  		gsm_dlci_copy_config_values(dlci, &dc);
>  		if (copy_to_user((void __user *)arg, &dc, sizeof(dc)))
> @@ -3769,8 +3786,10 @@ static int gsmld_ioctl(struct tty_struct *tty, unsigned int cmd,
>  		dlci = gsm->dlci[dc.channel];
>  		if (!dlci) {
>  			dlci = gsm_dlci_alloc(gsm, dc.channel);
> -			if (!dlci)
> +			if (!dlci) {
> +				gsm->open_error++;
>  				return -ENOMEM;
> +			}
>  		}
>  		return gsm_dlci_config(dlci, &dc, 0);
>  	default:
> 

In general, the changelog could be more verbose about state machine 
states, message names which imply that the error is happening during 
"opening" phase/state.


-- 
 i.

