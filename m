Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C78AE6B6D71
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Mar 2023 03:27:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229810AbjCMC1D (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 12 Mar 2023 22:27:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43540 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229437AbjCMC1C (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 Mar 2023 22:27:02 -0400
Received: from mail-ua1-x92b.google.com (mail-ua1-x92b.google.com [IPv6:2607:f8b0:4864:20::92b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D599232E46;
        Sun, 12 Mar 2023 19:27:00 -0700 (PDT)
Received: by mail-ua1-x92b.google.com with SMTP id ay14so755097uab.13;
        Sun, 12 Mar 2023 19:27:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678674420;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=oBN7MZjLeJOLen+baWvRMMf/qMAR/rC8mwjBChYkR4I=;
        b=eV8ZHzyZHTa/moPPLfA9eEi65+z1w0eojcco0IYeBzCnw+HyW7EjdqpZEdlBxfFVHh
         H1WRsP3EvWm/dFbLjvIbXKD+qzQXZWnHfNuS0jB3hTMQBY3WiVD5Ns8+A7X2kvIi4UGe
         zkNyyPkRruFfJIG2F4gwOKWglKUz+vm5O/EwYTe9qN8OrHugBHVEYPsEAneCwb++HFLQ
         L3tBk73dtpWenSKrC2YvkIwawuRwSYIl05zmDikZUKEuPvG8GRiW1pKHn/c+OE/FEn3i
         hrLiwxF+5a0yEa1qQsAkHNkZZfjDjPNJk8CvdSXhiEgaK2o0X1rlrmoxHz5D2ePGBytK
         7V5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678674420;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=oBN7MZjLeJOLen+baWvRMMf/qMAR/rC8mwjBChYkR4I=;
        b=a2wgBvKfPQXfkAxTxuSbMXsDJ83u5XwsU4zrinA9MXCGw1Qg8I6W35+xRNCoq/+Aqx
         4Aoiu9r9iqefNV63YzxVQe92m+H1cnU7c9qFB07L/mbANMyP4MWkQ+/JdrZ4dgPa25Ay
         JT4yrzc+A13s5sGcvtVDYXJ3CB4HatNGIAg26LGBPdEQHaEh2ZDFE3bEZED2LWtQBBFy
         VSbbv6kAgRNnTTjAaXij/RTZm/7/woLFQ1Arv5x7Hq9BycED6bM+WfCz1th/DDacNDHD
         RXztCVBezcjFyIKD5tkFIjj9y8cBbc5gsVjOoSlQIGeX2wgWNFpeyBOCAubL8oJRxaHv
         OlAw==
X-Gm-Message-State: AO0yUKXgGgnqkpcWtyeXEHl7EtLN6aBwyohnmYIPbQfe2KhepjnvSC2x
        OPsir9Aep7rlshuhOJ0/Ux0/2Uc+Pa8chTCQ0Rs=
X-Google-Smtp-Source: AK7set93JB0itlbEWaERpD6ndiS4qFu3fUXiBbk6eDBsJ6NtK7ZfGg1BvqVkC6SYgsy9XdmxJqQGXGNMjW6YMrvIY5g=
X-Received: by 2002:a1f:46c6:0:b0:42d:7181:7c63 with SMTP id
 t189-20020a1f46c6000000b0042d71817c63mr9777947vka.1.1678674419884; Sun, 12
 Mar 2023 19:26:59 -0700 (PDT)
MIME-Version: 1.0
References: <20230310144701.1541504-1-robh@kernel.org>
In-Reply-To: <20230310144701.1541504-1-robh@kernel.org>
From:   Chunyan Zhang <zhang.lyra@gmail.com>
Date:   Mon, 13 Mar 2023 10:26:23 +0800
Message-ID: <CAAfSe-tE44w7gZSsXAMkJYEiKWbVXqsuX+gXQs9BDs-FRBLeBw@mail.gmail.com>
Subject: Re: [PATCH] clk: Use of_property_present() for testing DT property presence
To:     Rob Herring <robh@kernel.org>
Cc:     Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Orson Zhai <orsonzhai@gmail.com>,
        Baolin Wang <baolin.wang@linux.alibaba.com>,
        devicetree@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 10 Mar 2023 at 22:47, Rob Herring <robh@kernel.org> wrote:
>
> It is preferred to use typed property access functions (i.e.
> of_property_read_<type> functions) rather than low-level
> of_get_property/of_find_property functions for reading properties. As
> part of this, convert of_get_property/of_find_property calls to the
> recently added of_property_present() helper when we just want to test
> for presence of a property and nothing more.
>
> Signed-off-by: Rob Herring <robh@kernel.org>
> ---
>  drivers/clk/clk.c         | 4 ++--
>  drivers/clk/sprd/common.c | 2 +-

For sprd clk:
Acked-by: Chunyan Zhang <zhang.lyra@gmail.com>

Thanks,
Chunyan

>  2 files changed, 3 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/clk/clk.c b/drivers/clk/clk.c
> index ae07685c7588..f7528d7f8256 100644
> --- a/drivers/clk/clk.c
> +++ b/drivers/clk/clk.c
> @@ -4880,8 +4880,8 @@ static struct device_node *get_clk_provider_node(struct device *dev)
>         np = dev->of_node;
>         parent_np = dev->parent ? dev->parent->of_node : NULL;
>
> -       if (!of_find_property(np, "#clock-cells", NULL))
> -               if (of_find_property(parent_np, "#clock-cells", NULL))
> +       if (!of_property_present(np, "#clock-cells"))
> +               if (of_property_present(parent_np, "#clock-cells"))
>                         np = parent_np;
>
>         return np;
> diff --git a/drivers/clk/sprd/common.c b/drivers/clk/sprd/common.c
> index ce81e4087a8f..1a3795a61f81 100644
> --- a/drivers/clk/sprd/common.c
> +++ b/drivers/clk/sprd/common.c
> @@ -44,7 +44,7 @@ int sprd_clk_regmap_init(struct platform_device *pdev,
>         struct device_node *node = dev->of_node, *np;
>         struct regmap *regmap;
>
> -       if (of_find_property(node, "sprd,syscon", NULL)) {
> +       if (of_property_present(node, "sprd,syscon")) {
>                 regmap = syscon_regmap_lookup_by_phandle(node, "sprd,syscon");
>                 if (IS_ERR(regmap)) {
>                         pr_err("%s: failed to get syscon regmap\n", __func__);
> --
> 2.39.2
>
