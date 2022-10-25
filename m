Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DDB5D60CAA4
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Oct 2022 13:09:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231193AbiJYLJ2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Oct 2022 07:09:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52392 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229613AbiJYLJY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Oct 2022 07:09:24 -0400
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0066812B378;
        Tue, 25 Oct 2022 04:09:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1666696163; x=1698232163;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=Ubi1eFxYdCimpIGbyBjXOTx0mI8DZf1tDG1WVKY6sPc=;
  b=M6+tlCZYF/jaGeD62tqdWNKFKHyDQdkvNneBVVLCO9qJU3A+qYNwL8wF
   zp+HBO0NAtR9Tau4IkdVdv7Wfwm1tqOyAdqnOimXmFg5o7IMCeok+7O4t
   ucvVuRmlNUF+NGTQfAYdYfJ6/jPiKiNi2W7fSC9Hh0+F4MQdFjW5dmum0
   ymfILvBlSyT9sVZuwiAb1lhZaha6Gtps19DcHPv18LilpUWnCP5sdGwLS
   SWT1I4sw1v8kUentyxtgavEy2T7324fCww5KG2UDPL3F/FXPTzTaJJylz
   0ClRh5uGhW0Bicj3Jm2Wc1Oj4ZA/211THgfImz+keNck+LrpLrqUQ8Fbp
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10510"; a="305259405"
X-IronPort-AV: E=Sophos;i="5.95,211,1661842800"; 
   d="scan'208";a="305259405"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Oct 2022 04:09:22 -0700
X-IronPort-AV: E=McAfee;i="6500,9779,10510"; a="960776673"
X-IronPort-AV: E=Sophos;i="5.95,211,1661842800"; 
   d="scan'208";a="960776673"
Received: from pweidel-mobl.ger.corp.intel.com ([10.252.44.62])
  by fmsmga005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Oct 2022 04:09:21 -0700
Date:   Tue, 25 Oct 2022 14:09:19 +0300 (EEST)
From:   =?ISO-8859-15?Q?Ilpo_J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>
To:     "D. Starke" <daniel.starke@siemens.com>
cc:     linux-serial <linux-serial@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 3/3] tty: n_gsm: add parameter negotiation support
In-Reply-To: <20221024130114.2070-3-daniel.starke@siemens.com>
Message-ID: <403445fd-fc99-290-2a5d-cd7c18fb715c@linux.intel.com>
References: <20221024130114.2070-1-daniel.starke@siemens.com> <20221024130114.2070-3-daniel.starke@siemens.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Spam-Status: No, score=-7.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,
        SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 24 Oct 2022, D. Starke wrote:

> From: Daniel Starke <daniel.starke@siemens.com>
> 
> n_gsm is based on the 3GPP 07.010 and its newer version is the 3GPP 27.010.
> See https://portal.3gpp.org/desktopmodules/Specifications/SpecificationDetails.aspx?specificationId=1516
> The changes from 07.010 to 27.010 are non-functional. Therefore, I refer to
> the newer 27.010 here. Chapter 5.1.8.1.1 describes the parameter negotiation
> messages and parameters. Chapter 5.4.1 states that the default parameters
> are to be used if no negotiation is performed. Chapter 5.4.6.3.1 describes
> the encoding of the parameter negotiation message. The meaning of the
> parameters and allowed value ranges can be found in chapter 5.7.
> 
> Add parameter negotiation support accordingly. DLCI specific parameter
> configuration by the user requires additional ioctls. This is subject to
> another patch.
> 
> Signed-off-by: Daniel Starke <daniel.starke@siemens.com>
> ---
>  drivers/tty/n_gsm.c | 335 ++++++++++++++++++++++++++++++++++++++++++--
>  1 file changed, 327 insertions(+), 8 deletions(-)
> 
> v1 -> v2:
> Incorporated review comments.
> Simplification of command retry handling remains subject to future patches.
> 
> Link: https://lore.kernel.org/all/8c2b9492-caf4-7a48-3a7b-da939a4ac8b6@linux.intel.com/
> 
> diff --git a/drivers/tty/n_gsm.c b/drivers/tty/n_gsm.c
> index c217013b3e16..11d3730bf436 100644
> --- a/drivers/tty/n_gsm.c
> +++ b/drivers/tty/n_gsm.c
> @@ -38,6 +38,7 @@
>  #include <linux/sched/signal.h>
>  #include <linux/interrupt.h>
>  #include <linux/tty.h>
> +#include <linux/bitfield.h>
>  #include <linux/ctype.h>
>  #include <linux/mm.h>
>  #include <linux/math.h>
> @@ -127,6 +128,7 @@ struct gsm_msg {
>  
>  enum gsm_dlci_state {
>  	DLCI_CLOSED,
> +	DLCI_CONFIGURE,		/* Sending PN (for adaption > 1) */
>  	DLCI_OPENING,		/* Sending SABM not seen UA */
>  	DLCI_OPEN,		/* SABM/UA complete */
>  	DLCI_CLOSING,		/* Sending DISC not seen UA/DM */
> @@ -184,6 +186,30 @@ struct gsm_dlci {
>  	struct net_device *net; /* network interface, if created */
>  };
>  
> +/*
> + * Parameter bits used for parameter negotiation according to 3GPP 27.010
> + * chapter 5.4.6.3.1.
> + */
> +
> +struct gsm_dlci_param_bits {
> +	u8 d_bits;
> +	u8 i_cl_bits;
> +	u8 p_bits;
> +	u8 t_bits;
> +	__le16 n_bits;
> +	u8 na_bits;
> +	u8 k_bits;
> +} __packed;
> +
> +#define PN_D_FIELD_DLCI		GENMASK(5, 0)
> +#define PN_I_CL_FIELD_FTYPE	GENMASK(3, 0)
> +#define PN_I_CL_FIELD_ADAPTION	GENMASK(7, 4)
> +#define PN_P_FIELD_PRIO		GENMASK(5, 0)

> +#define PN_T_FIELD_T1		GENMASK(7, 0)
> +#define PN_N_FIELD_N1		GENMASK(15, 0)
> +#define PN_NA_FIELD_N2		GENMASK(7, 0)

I guess there three would not be strictly necessary since they match to 
the full type size but then they're not harmful either.

> +#define PN_K_FIELD_K		GENMASK(2, 0)
> +
>  /* Total number of supported devices */
>  #define GSM_TTY_MINORS		256
>  
> @@ -411,6 +437,7 @@ static const u8 gsm_fcs8[256] = {
>  #define INIT_FCS	0xFF
>  #define GOOD_FCS	0xCF
>  
> +static void gsm_dlci_close(struct gsm_dlci *dlci);
>  static int gsmld_output(struct gsm_mux *gsm, u8 *data, int len);
>  static int gsm_modem_update(struct gsm_dlci *dlci, u8 brk);
>  static struct gsm_msg *gsm_data_alloc(struct gsm_mux *gsm, u8 addr, int len,
> @@ -533,6 +560,59 @@ static void gsm_hex_dump_bytes(const char *fname, const u8 *data,
>  	kfree(prefix);
>  }
>  
> +/**
> + * gsm_encode_params	-	encode DLCI parameters
> + * @dlci: DLCI to encode from
> + * @params: buffer to fill with the encoded parameters
> + *
> + * Encodes the parameters according to GSM 07.10 section 5.4.6.3.1
> + * table 3.
> + */
> +static int gsm_encode_params(const struct gsm_dlci *dlci,
> +			     struct gsm_dlci_param_bits *params)
> +{
> +	const struct gsm_mux *gsm = dlci->gsm;
> +	unsigned int i, cl;
> +
> +	switch (dlci->ftype) {
> +	case UIH:
> +		i = 0; /* UIH */
> +		break;
> +	case UI:
> +		i = 1; /* UI */
> +		break;
> +	default:
> +		pr_err("%s: unsupported frame type %d\n", __func__,
> +		       dlci->ftype);
> +		return -EINVAL;
> +	}
> +
> +	switch (dlci->adaption) {
> +	case 1: /* Unstructured */
> +		cl = 0; /* convergence layer type 1 */
> +		break;
> +	case 2: /* Unstructured with modem bits. */
> +		cl = 1; /* convergence layer type 2 */
> +		break;
> +	default:
> +		pr_err("%s: unsupported adaption %d\n", __func__,
> +		       dlci->adaption);
> +		return -EINVAL;
> +	}
> +
> +	params->d_bits = FIELD_PREP(PN_D_FIELD_DLCI, dlci->addr);
> +	/* UIH, convergence layer type 1 */
> +	params->i_cl_bits = FIELD_PREP(PN_I_CL_FIELD_FTYPE, i) |
> +			    FIELD_PREP(PN_I_CL_FIELD_ADAPTION, cl);
> +	params->p_bits = FIELD_PREP(PN_P_FIELD_PRIO, dlci->prio);
> +	params->t_bits = FIELD_PREP(PN_T_FIELD_T1, gsm->t1);
> +	params->n_bits = cpu_to_le16(FIELD_PREP(PN_N_FIELD_N1, dlci->mtu));
> +	params->na_bits = FIELD_PREP(PN_NA_FIELD_N2, gsm->n2);
> +	params->k_bits = FIELD_PREP(PN_K_FIELD_K, dlci->k);
> +
> +	return 0;
> +}
> +
>  /**
>   *	gsm_register_devices	-	register all tty devices for a given mux index
>   *
> @@ -1450,6 +1530,116 @@ static void gsm_process_modem(struct tty_struct *tty, struct gsm_dlci *dlci,
>  	dlci->modem_rx = mlines;
>  }
>  
> +/**
> + * gsm_process_negotiation	-	process received parameters
> + * @gsm: GSM channel
> + * @addr: DLCI address
> + * @cr: command/response
> + * @params: encoded parameters from the parameter negotiation message
> + *
> + * Used when the response for our parameter negotiation command was
> + * received.
> + */
> +static int gsm_process_negotiation(struct gsm_mux *gsm, unsigned int addr,
> +				   unsigned int cr,
> +				   const struct gsm_dlci_param_bits *params)
> +{
> +	struct gsm_dlci *dlci = gsm->dlci[addr];
> +	unsigned int ftype, i, adaption, prio, n1, k;
> +
> +	i = FIELD_GET(PN_I_CL_FIELD_FTYPE, params->i_cl_bits);
> +	adaption = FIELD_GET(PN_I_CL_FIELD_ADAPTION, params->i_cl_bits) + 1;
> +	prio = FIELD_GET(PN_P_FIELD_PRIO, params->p_bits);
> +	n1 = FIELD_GET(PN_N_FIELD_N1, le16_to_cpu(params->n_bits));

Should this be using get_unaligned...()?

-- 
 i.
