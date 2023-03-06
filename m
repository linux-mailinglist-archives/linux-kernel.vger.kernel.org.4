Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C6A506ABDF8
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Mar 2023 12:16:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230117AbjCFLQH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Mar 2023 06:16:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59558 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230146AbjCFLPi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Mar 2023 06:15:38 -0500
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC038126E5
        for <linux-kernel@vger.kernel.org>; Mon,  6 Mar 2023 03:15:22 -0800 (PST)
Received: by mail-wr1-x42d.google.com with SMTP id l25so8405049wrb.3
        for <linux-kernel@vger.kernel.org>; Mon, 06 Mar 2023 03:15:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112; t=1678101321;
        h=mime-version:message-id:in-reply-to:date:subject:cc:to:from
         :user-agent:references:from:to:cc:subject:date:message-id:reply-to;
        bh=PyTn9tJm20fW8pZYDIuyfcLC54XHP85ntZPqOJKtjIk=;
        b=4BUdLMw4Bzkp0FX7tdK0VT+WAV4PbmaJREU+/qlrti7Mm9ppJ4BNW4rhhx5ekAwLmK
         MlaafUzNslF3E0996vg4leNMf/vFLgEi1ZJKUffZzUWka5kYu5Svj7a+SCFFmrjH+T6z
         ID0Pa8KfL6GmK+N+j7j3GRTuZut+IOq2s9J7QgNILbuIWteZ7j26tWHoYTTzJLJkG9dN
         m/tWaqOrZHTOOfJZXU6pzK9AQBe03s/qgrbci/hB1wXnYD9im54wLGtg8yTewYU8f5WR
         G9avbdlB4QskIIns4vg5MU6e2tP+Sb9iSoEls2JXF4+jPDTPugLESC08gzn4Sbf2dIIZ
         K6iw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678101321;
        h=mime-version:message-id:in-reply-to:date:subject:cc:to:from
         :user-agent:references:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PyTn9tJm20fW8pZYDIuyfcLC54XHP85ntZPqOJKtjIk=;
        b=Jd6gI2fJwu8uJteO8lf9QKOVZng6l6/lO69cG32c4eYLyjjgOQUmkZf+iQ3Qm6+2sm
         h4UgcZBWAjfR/tBnEkXkcTkEzr3F4Zb9Z65iPY5zThXVUOG9jkzapPs5cOsbSuntoGei
         6gEmFKoNlnoRxURbIlkwAqmhS0hkAJqkNarHJWPwrIH1YiSozBq6bFJ+i5wcdwJz7Wcd
         IvQpUycbwhF9NVGdRMMaa6AN0E3cBvy5ueHU8XOp+6mpAdJrNtARSFkGXg2eCAkGRxwj
         3Z33G6MEIgtOXnMcbqk504UjYJS/E2tT5C1zhCV7nuUzDE0hO566CfsgkRalexuktsiM
         STVA==
X-Gm-Message-State: AO0yUKVco7wUcec6tF8II45ObQstZos1soCQ4kVTJRAPgV2ljKJ7MjF/
        gDFRxdUkP6sb09EugJv1UpOs5+UyPHe2HEwnklc=
X-Google-Smtp-Source: AK7set/9jsOhwv0D69Mil0vNvlkr+TK2jem1ThlpPjH+LdY5wwwBq/ex5iKyHi1KYshz4sZacWcocw==
X-Received: by 2002:a5d:4b41:0:b0:2c5:58fb:fa92 with SMTP id w1-20020a5d4b41000000b002c558fbfa92mr6235081wrs.7.1678101321400;
        Mon, 06 Mar 2023 03:15:21 -0800 (PST)
Received: from localhost (laubervilliers-658-1-213-31.w90-63.abo.wanadoo.fr. [90.63.244.31])
        by smtp.gmail.com with ESMTPSA id f2-20020adfdb42000000b002c54fb024b2sm9456658wrj.61.2023.03.06.03.15.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Mar 2023 03:15:20 -0800 (PST)
References: <20230301183759.16163-1-ddrokosov@sberdevices.ru>
 <20230301183759.16163-2-ddrokosov@sberdevices.ru>
User-agent: mu4e 1.8.13; emacs 28.2
From:   Jerome Brunet <jbrunet@baylibre.com>
To:     Dmitry Rokosov <ddrokosov@sberdevices.ru>,
        neil.armstrong@linaro.org, mturquette@baylibre.com,
        sboyd@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, khilman@baylibre.com,
        martin.blumenstingl@googlemail.com
Cc:     jian.hu@amlogic.com, kernel@sberdevices.ru, rockosov@gmail.com,
        linux-amlogic@lists.infradead.org, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v9 1/5] clk: meson: add support for A1 PLL clock ops
Date:   Mon, 06 Mar 2023 12:09:35 +0100
In-reply-to: <20230301183759.16163-2-ddrokosov@sberdevices.ru>
Message-ID: <1jy1oab06v.fsf@starbuckisacylon.baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Wed 01 Mar 2023 at 21:37, Dmitry Rokosov <ddrokosov@sberdevices.ru> wrote:

> From: Jian Hu <jian.hu@amlogic.com>
>
> Modern meson PLL IPs are a little bit different from early known PLLs.
> The main difference is located in the init/enable/disable sequences; the
> rate logic is the same.

For the record, I find very odd that PLLs used to have an 'rst' bit in
CTRL0:29 (see g12 for example), this bit goes un-documented in the a1
datasheet, and following SoCs like s4 still have a rst bit, still in
CTRL0:29

I would not be surpized if the rst is actually still there in the a1.
It is just my guess ...

> Compared with the previous SoCs, self-adaption current module
> is newly added for A1, and there is no reset parameter except the
> fixed pll. In A1 PLL, the PLL enable sequence is different, using
> the new power-on sequence to enable the PLL.

Please split this patch:
#1 make the rst optional (if you must)
#2 add the self current adapt param.

Apart from this, it looks good

>
> Signed-off-by: Jian Hu <jian.hu@amlogic.com>
> Acked-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
> Signed-off-by: Dmitry Rokosov <ddrokosov@sberdevices.ru>
> ---
>  drivers/clk/meson/clk-pll.c | 47 +++++++++++++++++++++++++++++++------
>  drivers/clk/meson/clk-pll.h |  2 ++
>  2 files changed, 42 insertions(+), 7 deletions(-)
>
> diff --git a/drivers/clk/meson/clk-pll.c b/drivers/clk/meson/clk-pll.c
> index afefeba6e458..56ec2210f1ad 100644
> --- a/drivers/clk/meson/clk-pll.c
> +++ b/drivers/clk/meson/clk-pll.c
> @@ -295,10 +295,14 @@ static int meson_clk_pll_init(struct clk_hw *hw)
>  	struct meson_clk_pll_data *pll = meson_clk_pll_data(clk);
>  
>  	if (pll->init_count) {
> -		meson_parm_write(clk->map, &pll->rst, 1);
> +		if (MESON_PARM_APPLICABLE(&pll->rst))
> +			meson_parm_write(clk->map, &pll->rst, 1);
> +
>  		regmap_multi_reg_write(clk->map, pll->init_regs,
>  				       pll->init_count);
> -		meson_parm_write(clk->map, &pll->rst, 0);
> +
> +		if (MESON_PARM_APPLICABLE(&pll->rst))
> +			meson_parm_write(clk->map, &pll->rst, 0);
>  	}
>  
>  	return 0;
> @@ -309,8 +313,11 @@ static int meson_clk_pll_is_enabled(struct clk_hw *hw)
>  	struct clk_regmap *clk = to_clk_regmap(hw);
>  	struct meson_clk_pll_data *pll = meson_clk_pll_data(clk);
>  
> -	if (meson_parm_read(clk->map, &pll->rst) ||
> -	    !meson_parm_read(clk->map, &pll->en) ||
> +	if (MESON_PARM_APPLICABLE(&pll->rst) &&
> +	    meson_parm_read(clk->map, &pll->rst))
> +		return 0;
> +
> +	if (!meson_parm_read(clk->map, &pll->en) ||
>  	    !meson_parm_read(clk->map, &pll->l))
>  		return 0;
>  
> @@ -341,13 +348,34 @@ static int meson_clk_pll_enable(struct clk_hw *hw)
>  		return 0;
>  
>  	/* Make sure the pll is in reset */
> -	meson_parm_write(clk->map, &pll->rst, 1);
> +	if (MESON_PARM_APPLICABLE(&pll->rst))
> +		meson_parm_write(clk->map, &pll->rst, 1);
>  
>  	/* Enable the pll */
>  	meson_parm_write(clk->map, &pll->en, 1);
>  
>  	/* Take the pll out reset */
> -	meson_parm_write(clk->map, &pll->rst, 0);
> +	if (MESON_PARM_APPLICABLE(&pll->rst))
> +		meson_parm_write(clk->map, &pll->rst, 0);
> +
> +	/*
> +	 * Compared with the previous SoCs, self-adaption current module
> +	 * is newly added for A1, keep the new power-on sequence to enable the
> +	 * PLL. The sequence is:
> +	 * 1. enable the pll, delay for 10us
> +	 * 2. enable the pll self-adaption current module, delay for 40us
> +	 * 3. enable the lock detect module
> +	 */
> +	if (MESON_PARM_APPLICABLE(&pll->current_en)) {
> +		usleep_range(10, 20);
> +		meson_parm_write(clk->map, &pll->current_en, 1);
> +		usleep_range(40, 50);
> +	};
> +
> +	if (MESON_PARM_APPLICABLE(&pll->l_detect)) {
> +		meson_parm_write(clk->map, &pll->l_detect, 1);
> +		meson_parm_write(clk->map, &pll->l_detect, 0);
> +	}
>  
>  	if (meson_clk_pll_wait_lock(hw))
>  		return -EIO;
> @@ -361,10 +389,15 @@ static void meson_clk_pll_disable(struct clk_hw *hw)
>  	struct meson_clk_pll_data *pll = meson_clk_pll_data(clk);
>  
>  	/* Put the pll is in reset */
> -	meson_parm_write(clk->map, &pll->rst, 1);
> +	if (MESON_PARM_APPLICABLE(&pll->rst))
> +		meson_parm_write(clk->map, &pll->rst, 1);
>  
>  	/* Disable the pll */
>  	meson_parm_write(clk->map, &pll->en, 0);
> +
> +	/* Disable PLL internal self-adaption current module */
> +	if (MESON_PARM_APPLICABLE(&pll->current_en))
> +		meson_parm_write(clk->map, &pll->current_en, 0);
>  }
>  
>  static int meson_clk_pll_set_rate(struct clk_hw *hw, unsigned long rate,
> diff --git a/drivers/clk/meson/clk-pll.h b/drivers/clk/meson/clk-pll.h
> index 367efd0f6410..a2228c0fdce5 100644
> --- a/drivers/clk/meson/clk-pll.h
> +++ b/drivers/clk/meson/clk-pll.h
> @@ -36,6 +36,8 @@ struct meson_clk_pll_data {
>  	struct parm frac;
>  	struct parm l;
>  	struct parm rst;
> +	struct parm current_en;
> +	struct parm l_detect;
>  	const struct reg_sequence *init_regs;
>  	unsigned int init_count;
>  	const struct pll_params_table *table;

