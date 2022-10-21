Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D39D9607452
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Oct 2022 11:41:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230260AbiJUJlX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Oct 2022 05:41:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57292 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230221AbiJUJka (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Oct 2022 05:40:30 -0400
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9AF441AFAB3;
        Fri, 21 Oct 2022 02:40:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1666345222; x=1697881222;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=znuGfTgdRUioBnYzZ3bDM+BvNiBpmBJVN6eGc6l1et8=;
  b=NmYb60/FcoQCUlftynAxCSQkkPy8yY1stcn/wmYv3mYYv/GbhTW9+W2U
   EQ/T0g5nRNcjmvTjPdQcruLq5GXsCAFjOiLHH6jQnitDJqCqI9rePmamZ
   itgsD3VmLrQGG+hkRJLleR/nqU4uCHNYqFC3LPwCrh0LvMpsn5cbsjcxD
   8g5+g1jVyGw0eXPW6YVHBZpJSNkr3QC2rQ0do2mhdadGEYnu66s/dLaik
   n4WrluDKAa5mHqi8CbkJk36tzD8oYuUdCRWlLtiYAc1bFDvGI8nuOxvTk
   Vgmn8dpRkS8rz/1vEo6dpaOnkmjrURTaPpOx1iRhiFQYrnUoimOrNvKrW
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10506"; a="305697098"
X-IronPort-AV: E=Sophos;i="5.95,200,1661842800"; 
   d="scan'208";a="305697098"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Oct 2022 02:40:21 -0700
X-IronPort-AV: E=McAfee;i="6500,9779,10506"; a="805474071"
X-IronPort-AV: E=Sophos;i="5.95,200,1661842800"; 
   d="scan'208";a="805474071"
Received: from lramir2-mobl1.ger.corp.intel.com ([10.252.44.179])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Oct 2022 02:40:19 -0700
Date:   Fri, 21 Oct 2022 12:40:17 +0300 (EEST)
From:   =?ISO-8859-15?Q?Ilpo_J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>
To:     "D. Starke" <daniel.starke@siemens.com>
cc:     linux-serial <linux-serial@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/3] tty: n_gsm: introduce macro for minimal unit size
In-Reply-To: <20221021084315.2306-1-daniel.starke@siemens.com>
Message-ID: <fe537e8-7b2-61e2-767d-787b923c7456@linux.intel.com>
References: <20221021084315.2306-1-daniel.starke@siemens.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 21 Oct 2022, D. Starke wrote:

> From: Daniel Starke <daniel.starke@siemens.com>
> 
> n_gsm has a minimal protocol overhead of 7 bytes. The current code already
> checks whether the configured MRU/MTU size is at least one byte more than
> this.
> 
> Introduce the macro MIN_UNIT_SIZE to make this value more obvious.
> 
> Signed-off-by: Daniel Starke <daniel.starke@siemens.com>
> ---
>  drivers/tty/n_gsm.c | 7 +++++--
>  1 file changed, 5 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/tty/n_gsm.c b/drivers/tty/n_gsm.c
> index 5e516f5cac5a..8e039f2a0427 100644
> --- a/drivers/tty/n_gsm.c
> +++ b/drivers/tty/n_gsm.c
> @@ -89,6 +89,7 @@ module_param(debug, int, 0600);
>   */
>  #define MAX_MRU 1500
>  #define MAX_MTU 1500
> +#define MIN_UNIT_SIZE 8
>  /* SOF, ADDR, CTRL, LEN1, LEN2, ..., FCS, EOF */
>  #define PROT_OVERHEAD 7

Why not call it just MIN_MTU?

I know you check it also against MRU but that seems so minor problem to me 
it's not worth even noting because of course MRU is related MTU, it's just 
the other end of the pipe. To be honest, I don't understand why MAX_MRU is 
even defined there when is just the same as MAX_MTU :-).

You could do this btw:

#define MIN_MTU	(PROT_OVERHEAD + 1)

To make it even more obvious where it comes from (matching to what you 
describe in your commit message).

The change looks otherwise ok.

-- 
 i.


>  #define	GSM_NET_TX_TIMEOUT (HZ*10)
> @@ -2712,7 +2713,9 @@ static int gsm_config(struct gsm_mux *gsm, struct gsm_config *c)
>  	if ((c->adaption != 1 && c->adaption != 2) || c->k)
>  		return -EOPNOTSUPP;
>  	/* Check the MRU/MTU range looks sane */
> -	if (c->mru > MAX_MRU || c->mtu > MAX_MTU || c->mru < 8 || c->mtu < 8)
> +	if (c->mru < MIN_UNIT_SIZE || c->mtu < MIN_UNIT_SIZE)
> +		return -EINVAL;
> +	if (c->mru > MAX_MRU || c->mtu > MAX_MTU)
>  		return -EINVAL;
>  	if (c->n2 > 255)
>  		return -EINVAL;
> @@ -3296,7 +3299,7 @@ static int gsm_create_network(struct gsm_dlci *dlci, struct gsm_netconfig *nc)
>  		return -ENOMEM;
>  	}
>  	net->mtu = dlci->gsm->mtu;
> -	net->min_mtu = 8;
> +	net->min_mtu = MIN_UNIT_SIZE;
>  	net->max_mtu = dlci->gsm->mtu;
>  	mux_net = netdev_priv(net);
>  	mux_net->dlci = dlci;
> 

