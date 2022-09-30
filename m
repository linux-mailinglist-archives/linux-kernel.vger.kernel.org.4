Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A66F55F0769
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Sep 2022 11:18:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231160AbiI3JSN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Sep 2022 05:18:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46374 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229955AbiI3JSL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Sep 2022 05:18:11 -0400
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com [IPv6:2a00:1450:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A40BC4591
        for <linux-kernel@vger.kernel.org>; Fri, 30 Sep 2022 02:18:09 -0700 (PDT)
Received: by mail-wm1-x333.google.com with SMTP id iv17so2502841wmb.4
        for <linux-kernel@vger.kernel.org>; Fri, 30 Sep 2022 02:18:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20210112.gappssmtp.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=9WRmE4in3u5pyi8z579i3uor5RQvXVZ10ZhoptEyF5c=;
        b=qqy4TKeesl9A9pjmjB/Y5SSgqMsFgPGsXwN05GdHJdwrQ1QSXirMbRB71N6i8Dxq31
         /F5zY4j1xZe2sLLhhOSZPPRZ4abEjVqpQI3x+RReRPAPnELUAeRUKUEwJYn6ZXKC8qQC
         syi0CdCOJy/IaFo6WJIKxTbz9bJnm+/fSXSp1CPwuudmZNTs0Ls3uzjziObMtIO1EeH2
         QPTWx+iihEgkqSEhDPdNKCou4oIB5ErpfUCj9DpztcM1Hy6L1u4NtLxg/b9u+dDFj3Wd
         9xr1zbwDDOqYAY1IWK2HmDrxx/QtF5fsGzPvAt2V3kmVgixfyccKGrQWOIV1CvaXcA1O
         qK+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=9WRmE4in3u5pyi8z579i3uor5RQvXVZ10ZhoptEyF5c=;
        b=uLrDQ/5ZoYJFcw3KR7aygzujrJiQv8jxV+qoetmaLFbhd5/SOh7/Uk28s5KsjhWh3B
         KGFWHtqTVEK0ymIu4CmLmrnmHa9HYFPo/828VHmn5rPNRYzi7pCRc0o0kHNG+q9gc9QM
         kgDgktJMpuNv+ZTNrcMhVcb4BQ9d+zlaqEhQqMM1C2pAqkgC15x73HqRk2Ms8Xh8DHX0
         NjGMPCEIUKUQEmwd/z2S6/5Ju82ZemZWIBld2fpYlaQH2TkFI/3CrnF2os4lKwfUhvQj
         I3K2rhdyx2IROso5sspmjEY68Fb1teJun74r3pxHaJ2nLziPL0RZ5Gb+t0iF1zEL/K/a
         iyDw==
X-Gm-Message-State: ACrzQf3cR/AXJBfdc/+c7lE3+5ryBOU87TQ4kUjy4I43RevDq35Idx+m
        ELcxFxSC8GrBtqp8ZLRsNbCx1so9TQG94ivvU+WGxA==
X-Google-Smtp-Source: AMsMyM7QTnAQI2J2Un6+5Mdkw5g+w2atjOOxZGlyfDOBACiqBnYBg5F0I6da0T2OyrweBxdPlsBfrPUd2stnSBIxmoY=
X-Received: by 2002:a05:600c:4f8d:b0:3b4:9f2f:4311 with SMTP id
 n13-20020a05600c4f8d00b003b49f2f4311mr5008014wmq.17.1664529488130; Fri, 30
 Sep 2022 02:18:08 -0700 (PDT)
MIME-Version: 1.0
References: <20220920103108.23074-1-jay.xu@rock-chips.com> <20220920103108.23074-13-jay.xu@rock-chips.com>
In-Reply-To: <20220920103108.23074-13-jay.xu@rock-chips.com>
From:   Bartosz Golaszewski <brgl@bgdev.pl>
Date:   Fri, 30 Sep 2022 11:17:57 +0200
Message-ID: <CAMRc=MdjFbzjiLg==ppX_e7cWVw7s1B+Dd=OvrYsnL4ZC_daMg@mail.gmail.com>
Subject: Re: [PATCH 12/20] gpio/rockchip: add return check for clock rate set
To:     Jianqun Xu <jay.xu@rock-chips.com>
Cc:     linus.walleij@linaro.org, heiko@sntech.de,
        andriy.shevchenko@linux.intel.com, robert.moore@intel.com,
        robh@kernel.org, linux-rockchip@lists.infradead.org,
        linux-kernel@vger.kernel.org, lenb@kernel.org, rafael@kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 20, 2022 at 12:31 PM Jianqun Xu <jay.xu@rock-chips.com> wrote:
>
> Check if the clock rate set for the apb clock is successful or not.
>
> Signed-off-by: Jianqun Xu <jay.xu@rock-chips.com>
> ---
>  drivers/gpio/gpio-rockchip.c | 3 +++
>  1 file changed, 3 insertions(+)
>
> diff --git a/drivers/gpio/gpio-rockchip.c b/drivers/gpio/gpio-rockchip.c
> index e36cdbd4bbef..511e93a6a429 100644
> --- a/drivers/gpio/gpio-rockchip.c
> +++ b/drivers/gpio/gpio-rockchip.c
> @@ -199,6 +199,9 @@ static int rockchip_gpio_set_debounce(struct gpio_chip *gc,
>         if (bank->gpio_type == GPIO_TYPE_V2 && !IS_ERR(bank->db_clk)) {
>                 div_debounce_support = true;
>                 freq = clk_get_rate(bank->db_clk);
> +               if (!freq)
> +                       return -EINVAL;
> +
>                 max_debounce = (GENMASK(23, 0) + 1) * 2 * 1000000 / freq;
>                 if (debounce > max_debounce)
>                         return -EINVAL;
> --
> 2.25.1
>

This cannot happen, clk_get_rate() can only return 0 for clk == NULL.
We're not using an optional clock.

Bart
