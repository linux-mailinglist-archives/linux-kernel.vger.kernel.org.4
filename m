Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 68C5C607479
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Oct 2022 11:53:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230187AbiJUJxm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Oct 2022 05:53:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55460 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229872AbiJUJxj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Oct 2022 05:53:39 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 581C624FED5;
        Fri, 21 Oct 2022 02:53:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1666346018; x=1697882018;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=U4mbZiwP/EmCJl67BpwTpSg/m50Q93lEoYcsG/Xy3Vg=;
  b=Jq3gyviPbhdm75p0wj6FWVSU4+ZL9vwMqPRqqbBoyBTkdPtXn0arWdML
   fdpVEjX6/YSTvvkSxaqz7TMPOf2TeX7a6pl5xD1zZ3UXWtsR3478pSGpc
   DCC2LHKhVq6uZprIdyb23VRDMfo117IdHVtuehY+24QR14xtZKKyheeXK
   SvgZ1w9N6A5Xc7dF9v2XRnan42YtHhAQIYmgGPBD7o0gJN/0OXwgrBDuR
   Qg3+CObeXLyV7sudILa9eVOtY/2dTMy/3NUbBoJ+5nq0rhtukLqREgjpa
   QLzRmLc37SX9H0OGul5J2DQVciutrikponvnJCqXA4quvb68b4scU2XvC
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10506"; a="306954872"
X-IronPort-AV: E=Sophos;i="5.95,200,1661842800"; 
   d="scan'208";a="306954872"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Oct 2022 02:53:37 -0700
X-IronPort-AV: E=McAfee;i="6500,9779,10506"; a="663657343"
X-IronPort-AV: E=Sophos;i="5.95,200,1661842800"; 
   d="scan'208";a="663657343"
Received: from lramir2-mobl1.ger.corp.intel.com ([10.252.44.179])
  by orsmga001-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Oct 2022 02:53:34 -0700
Date:   Fri, 21 Oct 2022 12:53:32 +0300 (EEST)
From:   =?ISO-8859-15?Q?Ilpo_J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>
To:     "D. Starke" <daniel.starke@siemens.com>
cc:     linux-serial@vger.kernel.org, gregkh@linuxfoundation.org,
        jirislaby@kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/3] tty: n_gsm: add parameters used with parameter
 negotiation
In-Reply-To: <20221021084315.2306-2-daniel.starke@siemens.com>
Message-ID: <4519259-1e70-351c-756c-57c1e665e94@linux.intel.com>
References: <20221021084315.2306-1-daniel.starke@siemens.com> <20221021084315.2306-2-daniel.starke@siemens.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Spam-Status: No, score=-7.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,
        SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 21 Oct 2022, D. Starke wrote:

> From: Daniel Starke <daniel.starke@siemens.com>
> 
> n_gsm is based on the 3GPP 07.010 and its newer version is the 3GPP 27.010.
> See https://portal.3gpp.org/desktopmodules/Specifications/SpecificationDetails.aspx?specificationId=1516
> The changes from 07.010 to 27.010 are non-functional. Therefore, I refer to
> the newer 27.010 here. Chapter 5.4.6.3.1 describes the encoding of the
> parameter negotiation messages.
> 
> Add the parameters used there to 'gsm_mux' and 'gsm_dlci' and initialize both
> according to the value ranges and recommended defaults defined in chapter 5.7.
> 
> Replace the use of the DLC default values from the 'gsm_mux' fields with the DLC
> specific values from the 'gsm_dlci' fields where applicable.
> 
> Signed-off-by: Daniel Starke <daniel.starke@siemens.com>
> ---

> @@ -2075,6 +2085,13 @@ static struct gsm_dlci *gsm_dlci_alloc(struct gsm_mux *gsm, int addr)
>  	dlci->gsm = gsm;
>  	dlci->addr = addr;
>  	dlci->adaption = gsm->adaption;
> +	dlci->mtu = gsm->mtu;
> +	if (addr == 0)
> +		dlci->prio = 0;
> +	else
> +		dlci->prio = ((((addr / 8) + 1) * 8) - 1);

Is this doing roundup(addr, 8) - 1 (in linux/math.h)?

> +	dlci->ftype = gsm->ftype;
> +	dlci->k = gsm->k;
>  	dlci->state = DLCI_CLOSED;
>  	if (addr) {
>  		dlci->data = gsm_dlci_data;
> @@ -2650,7 +2667,9 @@ static struct gsm_mux *gsm_alloc_mux(void)
>  
>  	gsm->t1 = T1;
>  	gsm->t2 = T2;
> +	gsm->t3 = T3;
>  	gsm->n2 = N2;
> +	gsm->k = K;
>  	gsm->ftype = UIH;
>  	gsm->adaption = 1;
>  	gsm->encoding = GSM_ADV_OPT;
> @@ -2691,7 +2710,7 @@ static void gsm_copy_config_values(struct gsm_mux *gsm,
>  	c->initiator = gsm->initiator;
>  	c->t1 = gsm->t1;
>  	c->t2 = gsm->t2;
> -	c->t3 = 0;	/* Not supported */
> +	c->t3 = gsm->t3;
>  	c->n2 = gsm->n2;
>  	if (gsm->ftype == UIH)
>  		c->i = 1;
> @@ -2700,7 +2719,7 @@ static void gsm_copy_config_values(struct gsm_mux *gsm,
>  	pr_debug("Ftype %d i %d\n", gsm->ftype, c->i);
>  	c->mru = gsm->mru;
>  	c->mtu = gsm->mtu;
> -	c->k = 0;
> +	c->k = gsm->k;
>  }
>  
>  static int gsm_config(struct gsm_mux *gsm, struct gsm_config *c)
> @@ -2717,12 +2736,16 @@ static int gsm_config(struct gsm_mux *gsm, struct gsm_config *c)
>  		return -EINVAL;
>  	if (c->mru > MAX_MRU || c->mtu > MAX_MTU)
>  		return -EINVAL;
> +	if (c->t3 > 255)
> +		return -EINVAL;
>  	if (c->n2 > 255)
>  		return -EINVAL;
>  	if (c->encapsulation > 1)	/* Basic, advanced, no I */
>  		return -EINVAL;
>  	if (c->initiator > 1)
>  		return -EINVAL;
> +	if (c->k > 7)

Please don't add non-obvious literal such as this. Is this xx_MAX_WINDOW 
or something along those lines?

-- 
 i.

