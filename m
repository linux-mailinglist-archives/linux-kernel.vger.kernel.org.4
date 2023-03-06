Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 582616AD2FF
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Mar 2023 00:48:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229720AbjCFXsM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Mar 2023 18:48:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58802 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229483AbjCFXsL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Mar 2023 18:48:11 -0500
Received: from mail-pg1-x52e.google.com (mail-pg1-x52e.google.com [IPv6:2607:f8b0:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 963252ED7F
        for <linux-kernel@vger.kernel.org>; Mon,  6 Mar 2023 15:48:08 -0800 (PST)
Received: by mail-pg1-x52e.google.com with SMTP id d6so6628200pgu.2
        for <linux-kernel@vger.kernel.org>; Mon, 06 Mar 2023 15:48:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1678146488;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=h3kkgg9fvW84t4TwLFt0X1S06pfPd/zAbyRMZdL/mL8=;
        b=aANztpaAr4HagG84ZHDlR9fWP07UAofgO/cRUUbIzExKpx5u2uLQJID6cHtCUpScjP
         Qq7WwEOVZsQzp/yUDYTCSrYIm102wDb8xU18xDo5KiZTb6GdVlIAfj0GUr1FEtg/JO2i
         HBx+zE78JUcenfWTVTY+BUAGXHR/YehXkQP24Br+US1apjvAD1HoTAWtdtfttxMCULmV
         RWHFGqIa2Y0GApYO/mPpgP/qxnI8Hp2oIicVp5DKlhuB/Q7cXlcOStws94DWhOC5Agd0
         UOw04TlA5PCE3WIbx5gDGgIcKadkD7XyDsmj2/j8orbQMWZIB6t0lTtIIM1gQgqg4wsr
         vVoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678146488;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=h3kkgg9fvW84t4TwLFt0X1S06pfPd/zAbyRMZdL/mL8=;
        b=t9ImwO7mLpZM+dPWzI/oNLzNU9onzPaIyqGdYFoa67uCZO1QYRgvk/23F2iBff6YDd
         QeR3e82BlWBdsccPpCm0VGEYBHjBGaMO85aa0GmH0oQWsK223+DyLdv/8l1fcGWvyuLJ
         ivbVU4/GoTLfSvdjOa0nJT5+nkBaRAk+5DLL6vheJhF12qssds/sEFaGHTjErMPeYiJ1
         vPL+kqww+Wo4u5K1Tkx4HBU7xBPNWaKn662XjZ5Ko0Rqhe9noB5z7PXNSddIWtJfQ0DI
         /8ByUq6mlBW7rgJrsdhiidPUspPdPXuvGQ26dMHgJmEhFtnDUPKiixU37dST4MOZVBmn
         FBxg==
X-Gm-Message-State: AO0yUKVy5kucAVoWWpMM9Iz9I/V60LfcN9ZXuZzIpJwXCSWVg8zTqHxJ
        uglmUId4b56/vo4BZ0+IUFz1tXgfDCZyLuqUs4isUg==
X-Google-Smtp-Source: AK7set+vAfWX9ZIid0tGfwy4xAfCKD4BGmpA0o9O7v4ol+4wj+rB16NMXMXewUOK31R/IlO+jqnFcWsHoaCcgk8QyHA=
X-Received: by 2002:a62:ce49:0:b0:5a8:ac30:80bf with SMTP id
 y70-20020a62ce49000000b005a8ac3080bfmr5501983pfg.6.1678146487961; Mon, 06 Mar
 2023 15:48:07 -0800 (PST)
MIME-Version: 1.0
References: <20230223041938.22732-1-semen.protsenko@linaro.org>
 <20230223041938.22732-6-semen.protsenko@linaro.org> <7cbc24bf-6920-c75f-effc-fd9d827ca324@linaro.org>
In-Reply-To: <7cbc24bf-6920-c75f-effc-fd9d827ca324@linaro.org>
From:   Sam Protsenko <semen.protsenko@linaro.org>
Date:   Mon, 6 Mar 2023 17:47:56 -0600
Message-ID: <CAPLW+4md2BTVecTfNx0ATG4LXy-Q+4Bgb7z8GGizv4aBJ8od_g@mail.gmail.com>
Subject: Re: [PATCH v3 5/6] clk: samsung: Extract parent clock enabling to
 common function
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Marek Szyprowski <m.szyprowski@samsung.com>,
        Sylwester Nawrocki <s.nawrocki@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Tomasz Figa <tomasz.figa@gmail.com>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        Chanho Park <chanho61.park@samsung.com>,
        David Virag <virag.david003@gmail.com>,
        Sumit Semwal <sumit.semwal@linaro.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        linux-samsung-soc@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 6 Mar 2023 at 08:35, Krzysztof Kozlowski
<krzysztof.kozlowski@linaro.org> wrote:
>
> On 23/02/2023 05:19, Sam Protsenko wrote:
> > Extract parent clock enabling from exynos_arm64_register_cmu() to
> > dedicated function.
> >
> > Acked-by: Marek Szyprowski <m.szyprowski@samsung.com>
> > Tested-by: Marek Szyprowski <m.szyprowski@samsung.com>
> > Signed-off-by: Sam Protsenko <semen.protsenko@linaro.org>
> > ---
> > Changes in v3:
> >   - Rebased on top of latest soc/for-next tree
> >   - Added Marek's Acked-by tag
> >
> > Changes in v2:
> >   - Rebased on top of latest soc/for-next tree
> >   - Improved English in kernel doc comment
> >   - Added clk_prepare_enable() return value check
> >   - Added exynos_arm64_enable_bus_clk() check in
> >     exynos_arm64_register_cmu()
> >   - Changed the commit message to reflect code changes
> >
> >  drivers/clk/samsung/clk-exynos-arm64.c | 51 ++++++++++++++++++--------
> >  1 file changed, 35 insertions(+), 16 deletions(-)
> >
> > diff --git a/drivers/clk/samsung/clk-exynos-arm64.c b/drivers/clk/samsung/clk-exynos-arm64.c
> > index b921b9a1134a..2aa3f0a5644e 100644
> > --- a/drivers/clk/samsung/clk-exynos-arm64.c
> > +++ b/drivers/clk/samsung/clk-exynos-arm64.c
> > @@ -56,6 +56,37 @@ static void __init exynos_arm64_init_clocks(struct device_node *np,
> >       iounmap(reg_base);
> >  }
> >
> > +/**
> > + * exynos_arm64_enable_bus_clk - Enable parent clock of specified CMU
> > + *
> > + * @dev:     Device object; may be NULL if this function is not being
> > + *           called from platform driver probe function
> > + * @np:              CMU device tree node
> > + * @cmu:     CMU data
> > + *
> > + * Keep CMU parent clock running (needed for CMU registers access).
> > + *
> > + * Return: 0 on success or a negative error code on failure.
> > + */
> > +static int __init exynos_arm64_enable_bus_clk(struct device *dev,
> > +             struct device_node *np, const struct samsung_cmu_info *cmu)
> > +{
> > +     struct clk *parent_clk;
> > +
> > +     if (!cmu->clk_name)
> > +             return 0;
> > +
> > +     if (dev)
> > +             parent_clk = clk_get(dev, cmu->clk_name);
> > +     else
> > +             parent_clk = of_clk_get_by_name(np, cmu->clk_name);
> > +
> > +     if (IS_ERR(parent_clk))
> > +             return PTR_ERR(parent_clk);
> > +
> > +     return clk_prepare_enable(parent_clk);
> > +}
> > +
> >  /**
> >   * exynos_arm64_register_cmu - Register specified Exynos CMU domain
> >   * @dev:     Device object; may be NULL if this function is not being
> > @@ -72,23 +103,11 @@ static void __init exynos_arm64_init_clocks(struct device_node *np,
> >  void __init exynos_arm64_register_cmu(struct device *dev,
> >               struct device_node *np, const struct samsung_cmu_info *cmu)
> >  {
> > -     /* Keep CMU parent clock running (needed for CMU registers access) */
> > -     if (cmu->clk_name) {
> > -             struct clk *parent_clk;
> > -
> > -             if (dev)
> > -                     parent_clk = clk_get(dev, cmu->clk_name);
> > -             else
> > -                     parent_clk = of_clk_get_by_name(np, cmu->clk_name);
> > -
> > -             if (IS_ERR(parent_clk)) {
> > -                     pr_err("%s: could not find bus clock %s; err = %ld\n",
> > -                            __func__, cmu->clk_name, PTR_ERR(parent_clk));
> > -             } else {
> > -                     clk_prepare_enable(parent_clk);
> > -             }
> > -     }
> > +     int err;
> >
> > +     err = exynos_arm64_enable_bus_clk(dev, np, cmu);
> > +     if (err)
> > +             panic("%s: could not enable bus clock\n", __func__);
>
> The error handling is changed and not equivalent. I would say that we
> could still try to boot even if this failed, so kernel should not panic.
> Maybe the parent clock is enabled by bootloader.
>

Agreed, I've probably overlooked that one when making all the
refactoring. The same stands for the patch #6. Will rework and send
out those two separately soon, as the rest of patches you already
applied.

Thanks!

> Best regards,
> Krzysztof
>
