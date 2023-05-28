Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 19BBC7139FB
	for <lists+linux-kernel@lfdr.de>; Sun, 28 May 2023 16:18:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229482AbjE1OSH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 28 May 2023 10:18:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33014 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229645AbjE1OSF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 28 May 2023 10:18:05 -0400
Received: from mout-p-201.mailbox.org (mout-p-201.mailbox.org [IPv6:2001:67c:2050:0:465::201])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2114FD9;
        Sun, 28 May 2023 07:18:01 -0700 (PDT)
Received: from smtp2.mailbox.org (smtp2.mailbox.org [10.196.197.2])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mout-p-201.mailbox.org (Postfix) with ESMTPS id 4QTgjX2vvjz9sZH;
        Sun, 28 May 2023 16:17:52 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oltmanns.dev;
        s=MBO0001; t=1685283472;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=xzUVdYeAH8jp/PzYak2ComKpKMAD3HgKKWTIJYkbXDM=;
        b=Odf9yP/6KGvoyEBrZCS1fYs+S+Lkf/N2ezZJ7KD876O6Bt2/WeihntpBl4/IW23QaRbPHl
        gwE0PCZfzDJYA4i38gCooedJyp4Mh2hzNB/+R7vzd+qtJTpTn1gw9xH44iX2e+H4oVwKeW
        4+r+gnVpzNPf/fK0MtgD3l2m+ubiGqpj+IRanaaLlZkaW/RahwZj3SFuusN7J38fhaiXQa
        s7ZZpzPFI/pMSCxo1EsH9PatVNo2szAUxsKAmtyJIviAFN8rjzG77iRLEzbYpMHsAC7NEb
        TYQUVrIWeQBHygdIXUNEK3uWHVFkaD/gcVGk8UlRPDAON6sXTaVjXOHlb+v1Sg==
References: <20230527132747.83196-1-frank@oltmanns.dev>
 <20230527132747.83196-3-frank@oltmanns.dev>
From:   Frank Oltmanns <frank@oltmanns.dev>
To:     Frank Oltmanns <frank@oltmanns.dev>
Cc:     linux-arm-kernel@lists.infradead.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-sunxi@lists.linux.dev,
        Andre Przywara <andre.przywara@arm.com>,
        Chen-Yu Tsai <wens@csie.org>, Icenowy Zheng <icenowy@aosc.io>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Maxime Ripard <mripard@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Rob Herring <robh@kernel.org>,
        Samuel Holland <samuel@sholland.org>,
        Stephen Boyd <sboyd@kernel.org>
Subject: Re: [RFC PATCH 2/3] clk: sunxi-ng: Implement precalculated NKM rate
 selection
Date:   Sun, 28 May 2023 16:11:02 +0200
In-reply-to: <20230527132747.83196-3-frank@oltmanns.dev>
Message-ID: <87o7m4wneg.fsf@oltmanns.dev>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 2023-05-27 at 15:27:46 +0200, Frank Oltmanns <frank@oltmanns.dev> wrote:
[...]
> diff --git a/drivers/clk/sunxi-ng/ccu_nkm.c b/drivers/clk/sunxi-ng/ccu_nkm.c
> index 94d2a83992b2..9652f6df17bd 100644
> --- a/drivers/clk/sunxi-ng/ccu_nkm.c
> +++ b/drivers/clk/sunxi-ng/ccu_nkm.c
[...]
> @@ -157,14 +205,18 @@ static int ccu_nkm_set_rate(struct clk_hw *hw, unsigned long rate,
>  	if (nkm->common.features & CCU_FEATURE_FIXED_POSTDIV)
>  		rate *= nkm->fixed_post_div;
>
> -	_nkm.min_n = nkm->n.min ?: 1;
> -	_nkm.max_n = nkm->n.max ?: 1 << nkm->n.width;
> -	_nkm.min_k = nkm->k.min ?: 1;
> -	_nkm.max_k = nkm->k.max ?: 1 << nkm->k.width;
> -	_nkm.min_m = 1;
> -	_nkm.max_m = nkm->m.max ?: 1 << nkm->m.width;
> -
> -	ccu_nkm_find_best(parent_rate, rate, &_nkm);
> +	if (nkm->table.num)
> +		rate = ccu_nkm_find_best_precalc(*parent_rate, rate, &_nkm,

Ugh! s/*parent_rate/parent_rate/
Sorry! Thanks to intel kernel test robot for pointing it out:
https://lore.kernel.org/oe-kbuild-all/202305280405.bUAMrEtn-lkp@intel.com/

Cheers,
  Frank

> +						 &nkm->table);
> +	else {
> +		_nkm.min_n = nkm->n.min ?: 1;
> +		_nkm.max_n = nkm->n.max ?: 1 << nkm->n.width;
> +		_nkm.min_k = nkm->k.min ?: 1;
> +		_nkm.max_k = nkm->k.max ?: 1 << nkm->k.width;
> +		_nkm.min_m = 1;
> +		_nkm.max_m = nkm->m.max ?: 1 << nkm->m.width;
> +		ccu_nkm_find_best(parent_rate, rate, &_nkm);
> +	}
>
>  	spin_lock_irqsave(nkm->common.lock, flags);
>
> diff --git a/drivers/clk/sunxi-ng/ccu_nkm.h b/drivers/clk/sunxi-ng/ccu_nkm.h
> index 6601defb3f38..fa5551724921 100644
> --- a/drivers/clk/sunxi-ng/ccu_nkm.h
> +++ b/drivers/clk/sunxi-ng/ccu_nkm.h
> @@ -12,6 +12,30 @@
>  #include "ccu_div.h"
>  #include "ccu_mult.h"
>
> +struct clk_nkm_combo {
> +	u8	n;
> +	u8	k;
> +	u8	m;
> +};
> +
> +/**
> + * struct clk_nkm_table - Table of all meaningful combinations for n, k, and m
> + *
> + * @num: Number of entries in the table
> + * @combos: Array of combos (of size num) that are supported by this clock.
> + *
> + * This table shall contain all meaningful combinations of n, k, and m. That
> + * means that combinations that result in the same clock rate shall only be
> + * listed once. For example, if both
> + * { .n = 1, .k = 2, .m = 2} and  { .n = 2, .k = 2, .m = 4}
> + * are valid values for n, k, and m, only one of them would be allowed because
> + * both result in a factor of 1.0.
> + */
> +struct clk_nkm_table {
> +	size_t			num;
> +	struct clk_nkm_combo	*combos;
> +};
> +
>  /*
>   * struct ccu_nkm - Definition of an N-K-M clock
>   *
> @@ -29,6 +53,8 @@ struct ccu_nkm {
>  	unsigned int		fixed_post_div;
>
>  	struct ccu_common	common;
> +
> +	struct clk_nkm_table	table;
>  };
>
>  #define SUNXI_CCU_NKM_WITH_MUX_GATE_LOCK(_struct, _name, _parents, _reg, \
