Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 583E26A0649
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Feb 2023 11:31:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233132AbjBWKbC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Feb 2023 05:31:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37816 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232867AbjBWKbA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Feb 2023 05:31:00 -0500
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B435E51F9E
        for <linux-kernel@vger.kernel.org>; Thu, 23 Feb 2023 02:30:29 -0800 (PST)
Received: by mail-wr1-x436.google.com with SMTP id l1so10001043wry.10
        for <linux-kernel@vger.kernel.org>; Thu, 23 Feb 2023 02:30:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:message-id:in-reply-to:date:subject:cc:to:from
         :user-agent:references:from:to:cc:subject:date:message-id:reply-to;
        bh=3/d1V97xfn1urp1yFSAFHB4bA8otMHdcMdq0yddMNFI=;
        b=hcoIV/z8lyL+ysVNVs6Y6+yJCu00ToOB1RctbNGmzn6TVnVvxY7XobmvDx0cUkA2xQ
         xfM4zr3AWE+b2Gtowo9aLR8xr2kvlYJfKxP9Itoq39971OTw4jDjtvXuJIaW6qUeofV5
         EQWm9Hn8VbRrY4wbZjRT+ENuVYy9Veq5SwjN8cFj2tCHTSpNKWogtut2gHDMrwDsU5cZ
         ZKqDIGyOhckxOd0wsydnj2kidFvup2vNd5mqGZHNZgcLygtgv2+azbCyRnBMohLbAGHA
         LQxmw22JVxiWV5822JzZZs1rVzyf1J1uIGehZSU3KFmWDRLsvMPcd89e+agLiMmUJ+0h
         ah3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:message-id:in-reply-to:date:subject:cc:to:from
         :user-agent:references:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3/d1V97xfn1urp1yFSAFHB4bA8otMHdcMdq0yddMNFI=;
        b=wklDvJSiTndaRq9IauUM3Sp6sHk6rU+1cW3q8o5eqxJHROxbEVcVxMUdKfQo5hTc7v
         5biIRTtMrn7uU5XHfE5HIRTVPHMyq79jWAs3zKVGvG/4HLYTZ/vjG4LNsqD+JQC+pODM
         UwKY2QU8SWE+IlshVspkdAHxa5JN63ap+Bc/30LF5r2hl3pTWqXyoTHoDrEw7/MISLft
         g7q2R+3Wq7OreDA/rcsDwZwpjDP4j5cIbvpeKf4oGfu+Vd7qT7MWSD3UoR4x/vZcRsLY
         rzXPgAT1Uj6+GMV5iJGpOCf/sK6gKXcqZ7khTMo3s+i30vWQUio6CJJnvNBf0zaLzjc/
         s4Xg==
X-Gm-Message-State: AO0yUKVr4LIvQFCNKnesfFH/QS+pNxDWyDBPp66oyma7YXk7tjQ4Cj4V
        sptQpWhpyJl8XA+5yMdLPn3ERw==
X-Google-Smtp-Source: AK7set/AJ/sQ293L1C/QDJKZNG/kThSW0HregqvGRPQyAGhtGjSWliE7pQlcCpSYC0riIpZo4sB8jQ==
X-Received: by 2002:a5d:6190:0:b0:2c7:a0b:e8d2 with SMTP id j16-20020a5d6190000000b002c70a0be8d2mr5185559wru.19.1677148226407;
        Thu, 23 Feb 2023 02:30:26 -0800 (PST)
Received: from localhost (laubervilliers-658-1-213-31.w90-63.abo.wanadoo.fr. [90.63.244.31])
        by smtp.gmail.com with ESMTPSA id t6-20020a5d4606000000b002c55306f6edsm13119455wrq.54.2023.02.23.02.30.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Feb 2023 02:30:25 -0800 (PST)
References: <20230223062723.4770-1-yu.tu@amlogic.com>
User-agent: mu4e 1.8.13; emacs 28.2
From:   Jerome Brunet <jbrunet@baylibre.com>
To:     Yu Tu <yu.tu@amlogic.com>, linux-clk@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Kevin Hilman <khilman@baylibre.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Cc:     kelvin.zhang@amlogic.com, qi.duan@amlogic.com
Subject: Re: [PATCH] clk: meson: vid-pll-div: added meson_vid_pll_div_ops
 support to enable vid_pll_div to meet clock setting requirements,
 especially for late chip
Date:   Thu, 23 Feb 2023 11:11:29 +0100
In-reply-to: <20230223062723.4770-1-yu.tu@amlogic.com>
Message-ID: <1jv8jsoerm.fsf@starbuckisacylon.baylibre.com>
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


On Thu 23 Feb 2023 at 14:27, Yu Tu <yu.tu@amlogic.com> wrote:

Title is way too long, 75 char max

> The previous chip only provides "ro_ops" for the vid_pll_div clock,

The driver does. Other chip could use RW ops I suppose.

> which is not satisfied with the operation requirements of the later
> chip for this clock, so the ops that can be set for the clock is added.
>

What requirements ? What "late" chip ? all this is quite vague.

> Signed-off-by: Yu Tu <yu.tu@amlogic.com>
> ---
>  drivers/clk/meson/vid-pll-div.c | 59 +++++++++++++++++++++++++++++++++
>  drivers/clk/meson/vid-pll-div.h |  1 +
>  2 files changed, 60 insertions(+)
>
> diff --git a/drivers/clk/meson/vid-pll-div.c b/drivers/clk/meson/vid-pll-div.c
> index daff235bc763..e75fa6f75efe 100644
> --- a/drivers/clk/meson/vid-pll-div.c
> +++ b/drivers/clk/meson/vid-pll-div.c
> @@ -89,6 +89,65 @@ static unsigned long meson_vid_pll_div_recalc_rate(struct clk_hw *hw,
>  	return DIV_ROUND_UP_ULL(parent_rate * div->multiplier, div->divider);
>  }
>  
> +static int meson_vid_pll_div_determine_rate(struct clk_hw *hw,
> +					    struct clk_rate_request *req)
> +{
> +	unsigned long best = 0, now = 0;
> +	unsigned int i, best_i = 0;
> +
> +	for (i = 0 ; i < ARRAY_SIZE(vid_pll_div_table) ; ++i) {

It would be nice to actually describe how this vid pll work so we can
stop using precompute "magic" values and actually use the IP to its full
capacity.

> +		now = DIV_ROUND_CLOSEST_ULL(req->best_parent_rate *

This effectively stops rate propagation. That's not how determine_rate()
call back should work. Have a look a clk-divider.c and how it calls
clk_hw_round_rate().

> +					    vid_pll_div_table[i].multiplier,
> +					    vid_pll_div_table[i].divider);
> +		if (req->rate == now) {
> +			return 0;
> +		} else if (abs(now - req->rate) < abs(best - req->rate)) {
> +			best = now;
> +			best_i = i;
> +		}
> +	}
> +
> +	if (best_i < ARRAY_SIZE(vid_pll_div_table))
> +		req->rate = DIV_ROUND_CLOSEST_ULL(req->best_parent_rate *
> +						  vid_pll_div_table[best_i].multiplier,
> +						  vid_pll_div_table[best_i].divider);
> +	else

What is the point of this 'if' clause ?
It looks like the 'else' part is dead code. 

> +		req->rate = meson_vid_pll_div_recalc_rate(hw, req->best_parent_rate);
> +
> +	return 0;
> +}
> +
> +static int meson_vid_pll_div_set_rate(struct clk_hw *hw, unsigned long rate,
> +				      unsigned long parent_rate)
> +{
> +	struct clk_regmap *clk = to_clk_regmap(hw);
> +	struct meson_vid_pll_div_data *pll_div = meson_vid_pll_div_data(clk);
> +	int i;
> +
> +	for (i = 0 ; i < ARRAY_SIZE(vid_pll_div_table) ; ++i) {
> +		if (DIV_ROUND_CLOSEST_ULL(parent_rate * vid_pll_div_table[i].multiplier,
> +					  vid_pll_div_table[i].divider) == rate) {

This assumes the set_rate() is going to have a perfect match and
otherwise fail. You should not assume that. Have a look at clk-divider.c
for examples.

> +			meson_parm_write(clk->map, &pll_div->val, vid_pll_div_table[i].shift_val);
> +			meson_parm_write(clk->map, &pll_div->sel, vid_pll_div_table[i].shift_sel);
> +			break;
> +		}
> +	}
> +
> +	if (i >= ARRAY_SIZE(vid_pll_div_table)) {
> +		pr_debug("%s: Invalid rate value for vid_pll_div\n", __func__);
> +		return -EINVAL;
> +	}
> +
> +	return 0;
> +}
> +
> +const struct clk_ops meson_vid_pll_div_ops = {
> +	.recalc_rate	= meson_vid_pll_div_recalc_rate,
> +	.determine_rate	= meson_vid_pll_div_determine_rate,
> +	.set_rate	= meson_vid_pll_div_set_rate,
> +};
> +EXPORT_SYMBOL_GPL(meson_vid_pll_div_ops);
> +
>  const struct clk_ops meson_vid_pll_div_ro_ops = {
>  	.recalc_rate	= meson_vid_pll_div_recalc_rate,
>  };
> diff --git a/drivers/clk/meson/vid-pll-div.h b/drivers/clk/meson/vid-pll-div.h
> index c0128e33ccf9..3ab729b85fde 100644
> --- a/drivers/clk/meson/vid-pll-div.h
> +++ b/drivers/clk/meson/vid-pll-div.h
> @@ -16,5 +16,6 @@ struct meson_vid_pll_div_data {
>  };
>  
>  extern const struct clk_ops meson_vid_pll_div_ro_ops;
> +extern const struct clk_ops meson_vid_pll_div_ops;
>  
>  #endif /* __MESON_VID_PLL_DIV_H */
>
> base-commit: 8a9fbf00acfeeeaac8efab8091bb464bd71b70ea

