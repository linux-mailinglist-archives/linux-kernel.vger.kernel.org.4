Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0537865BED5
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Jan 2023 12:21:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237405AbjACLUw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Jan 2023 06:20:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54098 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237361AbjACLUa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Jan 2023 06:20:30 -0500
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id E05B2F035;
        Tue,  3 Jan 2023 03:20:28 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 5395B1516;
        Tue,  3 Jan 2023 03:21:10 -0800 (PST)
Received: from donnerap.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 7156F3F663;
        Tue,  3 Jan 2023 03:20:27 -0800 (PST)
Date:   Tue, 3 Jan 2023 11:20:24 +0000
From:   Andre Przywara <andre.przywara@arm.com>
To:     Samuel Holland <samuel@sholland.org>
Cc:     Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-sunxi@lists.linux.dev
Subject: Re: [PATCH v2] clk: sunxi-ng: Avoid computing the rate twice
Message-ID: <20230103112024.293c95e2@donnerap.cambridge.arm.com>
In-Reply-To: <20221231173055.42384-1-samuel@sholland.org>
References: <20221231173055.42384-1-samuel@sholland.org>
Organization: ARM
X-Mailer: Claws Mail 3.18.0 (GTK+ 2.24.32; aarch64-unknown-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 31 Dec 2022 11:30:55 -0600
Samuel Holland <samuel@sholland.org> wrote:

Hi,

> The ccu_*_find_best() functions already compute a best_rate at the same
> time as the other factors. Return this value so the caller does not need
> to duplicate the computation.
>
> Signed-off-by: Samuel Holland <samuel@sholland.org>

Checked for all five files that the internal calculation in find_best()
matches the one it replaces here:

Reviewed-by: Andre Przywara <andre.przywara@arm.com>

Cheers,
Andre

> ---
> 
> Changes in v2:
>  - Apply the same change also to nk, nkm, nkmp, and nm
>  - Update the commit message
> 
>  drivers/clk/sunxi-ng/ccu_mp.c   | 11 ++++++-----
>  drivers/clk/sunxi-ng/ccu_nk.c   |  9 +++++----
>  drivers/clk/sunxi-ng/ccu_nkm.c  | 10 +++++-----
>  drivers/clk/sunxi-ng/ccu_nkmp.c | 10 +++++-----
>  drivers/clk/sunxi-ng/ccu_nm.c   |  9 +++++----
>  5 files changed, 26 insertions(+), 23 deletions(-)
> 
> diff --git a/drivers/clk/sunxi-ng/ccu_mp.c b/drivers/clk/sunxi-ng/ccu_mp.c
> index 57cf2d615148..cc94a694cb67 100644
> --- a/drivers/clk/sunxi-ng/ccu_mp.c
> +++ b/drivers/clk/sunxi-ng/ccu_mp.c
> @@ -10,9 +10,9 @@
>  #include "ccu_gate.h"
>  #include "ccu_mp.h"
>  
> -static void ccu_mp_find_best(unsigned long parent, unsigned long rate,
> -			     unsigned int max_m, unsigned int max_p,
> -			     unsigned int *m, unsigned int *p)
> +static unsigned long ccu_mp_find_best(unsigned long parent, unsigned long rate,
> +				      unsigned int max_m, unsigned int max_p,
> +				      unsigned int *m, unsigned int *p)
>  {
>  	unsigned long best_rate = 0;
>  	unsigned int best_m = 0, best_p = 0;
> @@ -35,6 +35,8 @@ static void ccu_mp_find_best(unsigned long parent, unsigned long rate,
>  
>  	*m = best_m;
>  	*p = best_p;
> +
> +	return best_rate;
>  }
>  
>  static unsigned long ccu_mp_find_best_with_parent_adj(struct clk_hw *hw,
> @@ -109,8 +111,7 @@ static unsigned long ccu_mp_round_rate(struct ccu_mux_internal *mux,
>  	max_p = cmp->p.max ?: 1 << ((1 << cmp->p.width) - 1);
>  
>  	if (!clk_hw_can_set_rate_parent(&cmp->common.hw)) {
> -		ccu_mp_find_best(*parent_rate, rate, max_m, max_p, &m, &p);
> -		rate = *parent_rate / p / m;
> +		rate = ccu_mp_find_best(*parent_rate, rate, max_m, max_p, &m, &p);
>  	} else {
>  		rate = ccu_mp_find_best_with_parent_adj(hw, parent_rate, rate,
>  							max_m, max_p);
> diff --git a/drivers/clk/sunxi-ng/ccu_nk.c b/drivers/clk/sunxi-ng/ccu_nk.c
> index c4fb82af97e8..8aa35d5804f3 100644
> --- a/drivers/clk/sunxi-ng/ccu_nk.c
> +++ b/drivers/clk/sunxi-ng/ccu_nk.c
> @@ -15,8 +15,8 @@ struct _ccu_nk {
>  	unsigned long	k, min_k, max_k;
>  };
>  
> -static void ccu_nk_find_best(unsigned long parent, unsigned long rate,
> -			     struct _ccu_nk *nk)
> +static unsigned long ccu_nk_find_best(unsigned long parent, unsigned long rate,
> +				      struct _ccu_nk *nk)
>  {
>  	unsigned long best_rate = 0;
>  	unsigned int best_k = 0, best_n = 0;
> @@ -39,6 +39,8 @@ static void ccu_nk_find_best(unsigned long parent, unsigned long rate,
>  
>  	nk->k = best_k;
>  	nk->n = best_n;
> +
> +	return best_rate;
>  }
>  
>  static void ccu_nk_disable(struct clk_hw *hw)
> @@ -104,8 +106,7 @@ static long ccu_nk_round_rate(struct clk_hw *hw, unsigned long rate,
>  	_nk.min_k = nk->k.min ?: 1;
>  	_nk.max_k = nk->k.max ?: 1 << nk->k.width;
>  
> -	ccu_nk_find_best(*parent_rate, rate, &_nk);
> -	rate = *parent_rate * _nk.n * _nk.k;
> +	rate = ccu_nk_find_best(*parent_rate, rate, &_nk);
>  
>  	if (nk->common.features & CCU_FEATURE_FIXED_POSTDIV)
>  		rate = rate / nk->fixed_post_div;
> diff --git a/drivers/clk/sunxi-ng/ccu_nkm.c b/drivers/clk/sunxi-ng/ccu_nkm.c
> index 67da2c189b53..a0978a50edae 100644
> --- a/drivers/clk/sunxi-ng/ccu_nkm.c
> +++ b/drivers/clk/sunxi-ng/ccu_nkm.c
> @@ -16,8 +16,8 @@ struct _ccu_nkm {
>  	unsigned long	m, min_m, max_m;
>  };
>  
> -static void ccu_nkm_find_best(unsigned long parent, unsigned long rate,
> -			      struct _ccu_nkm *nkm)
> +static unsigned long ccu_nkm_find_best(unsigned long parent, unsigned long rate,
> +				       struct _ccu_nkm *nkm)
>  {
>  	unsigned long best_rate = 0;
>  	unsigned long best_n = 0, best_k = 0, best_m = 0;
> @@ -45,6 +45,8 @@ static void ccu_nkm_find_best(unsigned long parent, unsigned long rate,
>  	nkm->n = best_n;
>  	nkm->k = best_k;
>  	nkm->m = best_m;
> +
> +	return best_rate;
>  }
>  
>  static void ccu_nkm_disable(struct clk_hw *hw)
> @@ -122,9 +124,7 @@ static unsigned long ccu_nkm_round_rate(struct ccu_mux_internal *mux,
>  	if (nkm->common.features & CCU_FEATURE_FIXED_POSTDIV)
>  		rate *= nkm->fixed_post_div;
>  
> -	ccu_nkm_find_best(*parent_rate, rate, &_nkm);
> -
> -	rate = *parent_rate * _nkm.n * _nkm.k / _nkm.m;
> +	rate = ccu_nkm_find_best(*parent_rate, rate, &_nkm);
>  
>  	if (nkm->common.features & CCU_FEATURE_FIXED_POSTDIV)
>  		rate /= nkm->fixed_post_div;
> diff --git a/drivers/clk/sunxi-ng/ccu_nkmp.c b/drivers/clk/sunxi-ng/ccu_nkmp.c
> index 39413cb0985c..99359a06892d 100644
> --- a/drivers/clk/sunxi-ng/ccu_nkmp.c
> +++ b/drivers/clk/sunxi-ng/ccu_nkmp.c
> @@ -29,8 +29,8 @@ static unsigned long ccu_nkmp_calc_rate(unsigned long parent,
>  	return rate;
>  }
>  
> -static void ccu_nkmp_find_best(unsigned long parent, unsigned long rate,
> -			       struct _ccu_nkmp *nkmp)
> +static unsigned long ccu_nkmp_find_best(unsigned long parent, unsigned long rate,
> +					struct _ccu_nkmp *nkmp)
>  {
>  	unsigned long best_rate = 0;
>  	unsigned long best_n = 0, best_k = 0, best_m = 0, best_p = 0;
> @@ -65,6 +65,8 @@ static void ccu_nkmp_find_best(unsigned long parent, unsigned long rate,
>  	nkmp->k = best_k;
>  	nkmp->m = best_m;
>  	nkmp->p = best_p;
> +
> +	return best_rate;
>  }
>  
>  static void ccu_nkmp_disable(struct clk_hw *hw)
> @@ -150,10 +152,8 @@ static long ccu_nkmp_round_rate(struct clk_hw *hw, unsigned long rate,
>  	_nkmp.min_p = 1;
>  	_nkmp.max_p = nkmp->p.max ?: 1 << ((1 << nkmp->p.width) - 1);
>  
> -	ccu_nkmp_find_best(*parent_rate, rate, &_nkmp);
> +	rate = ccu_nkmp_find_best(*parent_rate, rate, &_nkmp);
>  
> -	rate = ccu_nkmp_calc_rate(*parent_rate, _nkmp.n, _nkmp.k,
> -				  _nkmp.m, _nkmp.p);
>  	if (nkmp->common.features & CCU_FEATURE_FIXED_POSTDIV)
>  		rate = rate / nkmp->fixed_post_div;
>  
> diff --git a/drivers/clk/sunxi-ng/ccu_nm.c b/drivers/clk/sunxi-ng/ccu_nm.c
> index 9ca9257f4426..c1fd11542c45 100644
> --- a/drivers/clk/sunxi-ng/ccu_nm.c
> +++ b/drivers/clk/sunxi-ng/ccu_nm.c
> @@ -27,8 +27,8 @@ static unsigned long ccu_nm_calc_rate(unsigned long parent,
>  	return rate;
>  }
>  
> -static void ccu_nm_find_best(unsigned long parent, unsigned long rate,
> -			     struct _ccu_nm *nm)
> +static unsigned long ccu_nm_find_best(unsigned long parent, unsigned long rate,
> +				      struct _ccu_nm *nm)
>  {
>  	unsigned long best_rate = 0;
>  	unsigned long best_n = 0, best_m = 0;
> @@ -52,6 +52,8 @@ static void ccu_nm_find_best(unsigned long parent, unsigned long rate,
>  
>  	nm->n = best_n;
>  	nm->m = best_m;
> +
> +	return best_rate;
>  }
>  
>  static void ccu_nm_disable(struct clk_hw *hw)
> @@ -157,8 +159,7 @@ static long ccu_nm_round_rate(struct clk_hw *hw, unsigned long rate,
>  	_nm.min_m = 1;
>  	_nm.max_m = nm->m.max ?: 1 << nm->m.width;
>  
> -	ccu_nm_find_best(*parent_rate, rate, &_nm);
> -	rate = ccu_nm_calc_rate(*parent_rate, _nm.n, _nm.m);
> +	rate = ccu_nm_find_best(*parent_rate, rate, &_nm);
>  
>  	if (nm->common.features & CCU_FEATURE_FIXED_POSTDIV)
>  		rate /= nm->fixed_post_div;

