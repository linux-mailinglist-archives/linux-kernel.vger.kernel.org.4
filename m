Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 195DA729CEB
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Jun 2023 16:31:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238484AbjFIOb2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Jun 2023 10:31:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53006 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231752AbjFIOb0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Jun 2023 10:31:26 -0400
Received: from mail-lf1-x12f.google.com (mail-lf1-x12f.google.com [IPv6:2a00:1450:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F2E5F30D7
        for <linux-kernel@vger.kernel.org>; Fri,  9 Jun 2023 07:31:24 -0700 (PDT)
Received: by mail-lf1-x12f.google.com with SMTP id 2adb3069b0e04-4f654d713c0so1965822e87.3
        for <linux-kernel@vger.kernel.org>; Fri, 09 Jun 2023 07:31:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20221208.gappssmtp.com; s=20221208; t=1686321083; x=1688913083;
        h=mime-version:message-id:in-reply-to:date:subject:cc:to:from
         :user-agent:references:from:to:cc:subject:date:message-id:reply-to;
        bh=rvKldkKyOEzMjaVgJzIrDpQYw9hrf0Xh92le1NSdGEw=;
        b=UktX5DCkzRF28DwzEH27lkzst5pNZ/sWkOflvK2OSTWWAk5rI1HApzsZN11Z1LMGre
         faXb25K0qOHjWhPiTgjp7rSz+gv8fzdWbIvf4ho8ORPJZte7Hae4IQ2+JpChTfyMmoCy
         mWV6VURFYsjJ9BbBX+kGktXOxS7BrUhaUWdykIlNe+h5mKEj2GLFNU8eqazymqSB2Tjs
         XcxakgN8hetMGTNtwtKNdI6y7dEBblnTFIgok0/QLo6Ktz69zr/mPpxQJ77z+AR/alY+
         f5fmxF7tRWhCnbluS9UWpjx8Q+wzKh/I+Pqj5Y/nCZP1F3VwOGWeiGYAEGu6K6msfJf0
         ohYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686321083; x=1688913083;
        h=mime-version:message-id:in-reply-to:date:subject:cc:to:from
         :user-agent:references:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rvKldkKyOEzMjaVgJzIrDpQYw9hrf0Xh92le1NSdGEw=;
        b=RrVk215ZHN8zMs5B3AQC3pgYIu45Y9B58ysE4zf+BQWEvR6nIQGPtBFPC5EsXp5gSe
         +YBMO3fRPkNy3sH6eZJPe8LWib6yu8ejGDDU+KOpGC+7EAKz5TXlMKJ1RcPxfKuxZQi0
         l1P3upaLqESopnRVCp9/2kRQfSkd+jQDVQdp1nD+5a7mk+00upmhLZ0gjTYyQX6AB9Dt
         fQ5CDLQN9pG8O/TRH2i2R0WSjH8WMz6qiyq+EataGGdE478knik8YDIbKItWgq7PPFrO
         RKoXovlVVLg/zviO3BYIWQvG2P1u6FpoJ3xOf+ZUyMeTHpchZH/dOSCF1vvnvIf5O3e+
         3yBA==
X-Gm-Message-State: AC+VfDwHQA53ptazNs0pCrlDhISJ6HArTX9IvNB4MYBDoM2FQjlWzuZZ
        //9fa6hTpbUayvNSke9hlyA9VQ==
X-Google-Smtp-Source: ACHHUZ65m5AMFmjxrMwWxpXLbpcZF2OPgnMHH0ovUIGyqONAblCOSsCEtrKUzsNS0WEh/UkxuTsNcg==
X-Received: by 2002:ac2:5b11:0:b0:4f1:30cc:3dae with SMTP id v17-20020ac25b11000000b004f130cc3daemr1352875lfn.10.1686321083183;
        Fri, 09 Jun 2023 07:31:23 -0700 (PDT)
Received: from localhost (laubervilliers-658-1-213-31.w90-63.abo.wanadoo.fr. [90.63.244.31])
        by smtp.gmail.com with ESMTPSA id e40-20020a5d5968000000b002fda1b12a0bsm4653096wri.2.2023.06.09.07.31.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Jun 2023 07:31:22 -0700 (PDT)
References: <20230607-topic-amlogic-upstream-clkid-public-migration-v1-0-9676afa6b22c@linaro.org>
 <20230607-topic-amlogic-upstream-clkid-public-migration-v1-3-9676afa6b22c@linaro.org>
 <1jlegu9l5d.fsf@starbuckisacylon.baylibre.com>
 <638206ba-e2da-bb8e-a2e4-138af84648b4@linaro.org>
User-agent: mu4e 1.8.13; emacs 28.2
From:   Jerome Brunet <jbrunet@baylibre.com>
To:     Neil Armstrong <neil.armstrong@linaro.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Kevin Hilman <khilman@baylibre.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>
Cc:     linux-amlogic@lists.infradead.org, linux-clk@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
Subject: Re: [PATCH 03/18] clk: meson: migrate a1 clock drivers out of
 hw_onecell_data to drop NR_CLKS
Date:   Fri, 09 Jun 2023 16:30:45 +0200
In-reply-to: <638206ba-e2da-bb8e-a2e4-138af84648b4@linaro.org>
Message-ID: <1jwn0c672d.fsf@starbuckisacylon.baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Thu 08 Jun 2023 at 14:53, Neil Armstrong <neil.armstrong@linaro.org> wrote:

> On 08/06/2023 14:45, Jerome Brunet wrote:
>>>   +struct meson_a1_pll_clks {
>>> +	struct clk_hw **hw_clks;
>>> +	unsigned int hw_clk_num;
>>> +};
>>> +
>>> +static struct meson_a1_pll_clks a1_pll_clks = {
>>> +	.hw_clks = a1_pll_hw_clks,
>>> +	.hw_clk_num = ARRAY_SIZE(a1_pll_hw_clks),
>>> +};
>>> +
>>> +static struct clk_hw *meson_a1_pll_hw_get(struct of_phandle_args *clkspec, void *clk_data)
>>> +{
>>> +	const struct meson_a1_pll_clks *data = clk_data;
>>> +	unsigned int idx = clkspec->args[0];
>>> +
>>> +	if (idx >= data->hw_clk_num) {
>>> +		pr_err("%s: invalid index %u\n", __func__, idx);
>>> +		return ERR_PTR(-EINVAL);
>>> +	}
>>> +
>>> +	return data->hw_clks[idx];
>>> +}
>> I'd prefer to have a single struct type and and single custom
>> callback for the different SoC please.
>
> Sure, I've written a common code for that, but I have a hard time finding
> a proper naming for it... so I choosed meson-clkc since it could have
> more common helper code for duplicated code over the clk driver:

Agreed. meson-clkc-utils maybe ?

>
> ===================================><============================================================================
> diff --git a/drivers/clk/meson/Kconfig b/drivers/clk/meson/Kconfig
> index 8ce846fdbe43..9070dcfd9e71 100644
> --- a/drivers/clk/meson/Kconfig
> +++ b/drivers/clk/meson/Kconfig
> @@ -30,6 +30,9 @@ config COMMON_CLK_MESON_VID_PLL_DIV
>  	tristate
>  	select COMMON_CLK_MESON_REGMAP
>
> +config COMMON_CLK_MESON_CLKC
> +	tristate
> +
>  config COMMON_CLK_MESON_AO_CLKC
>  	tristate
>  	select COMMON_CLK_MESON_REGMAP
> diff --git a/drivers/clk/meson/Makefile b/drivers/clk/meson/Makefile
> index d5288662881d..13c6db466986 100644
> --- a/drivers/clk/meson/Makefile
> +++ b/drivers/clk/meson/Makefile
> @@ -1,6 +1,7 @@
>  # SPDX-License-Identifier: GPL-2.0-only
>  # Amlogic clock drivers
>
> +obj-$(CONFIG_COMMON_CLK_MESON_CLKC) += meson-clkc.o
>  obj-$(CONFIG_COMMON_CLK_MESON_AO_CLKC) += meson-aoclk.o
>  obj-$(CONFIG_COMMON_CLK_MESON_CPU_DYNDIV) += clk-cpu-dyndiv.o
>  obj-$(CONFIG_COMMON_CLK_MESON_DUALDIV) += clk-dualdiv.o
> diff --git a/drivers/clk/meson/meson-clkc.c b/drivers/clk/meson/meson-clkc.c
> new file mode 100644
> index 000000000000..fa98b9d09011
> --- /dev/null
> +++ b/drivers/clk/meson/meson-clkc.c
> @@ -0,0 +1,25 @@
> +// SPDX-License-Identifier: GPL-2.0+
> +/*
> + * Copyright (c) 2023 Neil Armstrong <neil.armstrong@linaro.org>
> + */
> +
> +#include <linux/of_device.h>
> +#include <linux/clk-provider.h>
> +#include <linux/module.h>
> +#include "meson-clkc.h"
> +
> +struct clk_hw *meson_clk_hw_get(struct of_phandle_args *clkspec, void *clk_hw_data)
> +{
> +	const struct meson_clk_hw_data *data = clk_hw_data;
> +	unsigned int idx = clkspec->args[0];
> +
> +	if (idx >= data->num) {
> +		pr_err("%s: invalid index %u\n", __func__, idx);
> +		return ERR_PTR(-EINVAL);
> +	}
> +
> +	return data->hws[idx];
> +}
> +EXPORT_SYMBOL_GPL(meson_clk_hw_get);
> +
> +MODULE_LICENSE("GPL v2");
> diff --git a/drivers/clk/meson/meson-clkc.h b/drivers/clk/meson/meson-clkc.h
> new file mode 100644
> index 000000000000..e3bad2aa17eb
> --- /dev/null
> +++ b/drivers/clk/meson/meson-clkc.h
> @@ -0,0 +1,19 @@
> +/* SPDX-License-Identifier: (GPL-2.0+ OR MIT) */
> +/*
> + * Copyright (c) 2023 Neil Armstrong <neil.armstrong@linaro.org>
> + */
> +
> +#ifndef __MESON_HW_CLKC_H__
> +#define __MESON_HW_CLKC_H__
> +
> +#include <linux/of_device.h>
> +#include <linux/clk-provider.h>
> +
> +struct meson_clk_hw_data {
> +	struct clk_hw	**hws;
> +	unsigned int	num;
> +};
> +
> +struct clk_hw *meson_clk_hw_get(struct of_phandle_args *clkspec, void *clk_hw_data);
> +
> +#endif
> ===================================><============================================================================
>
> If it's ok I'll send a v2 using this.
>
> Thanks,
> Neil

