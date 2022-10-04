Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 11D935F3D18
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Oct 2022 09:16:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229707AbiJDHQf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Oct 2022 03:16:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60994 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229609AbiJDHQd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Oct 2022 03:16:33 -0400
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com [IPv6:2a00:1450:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 183453FD48
        for <linux-kernel@vger.kernel.org>; Tue,  4 Oct 2022 00:16:32 -0700 (PDT)
Received: by mail-ej1-x629.google.com with SMTP id nb11so26896744ejc.5
        for <linux-kernel@vger.kernel.org>; Tue, 04 Oct 2022 00:16:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=V3DMfLQaLfL8Bqw6ozy6bYrMLBwe4yrz27viyroXSjk=;
        b=b0mYLHTP/gaKyz3UXXes2kHSrr0DO8YIDkGkj6ddQo9FfFOaoQWvwpTeCozVGvShEH
         +WGef4R3hL24U/jCTelJiqvvfXsxKtS3b6LqwXm94lT5gHf8ETCpPtc0qX3q9byu4fzu
         qaKwL+qNINzYN2RtADdKA6sTRs6eUyJb79s2pWIAFc3VwvN2KWPP/U51hhbaJ5Cd9Bmw
         q8gx7hi4k7jSqYe2uNs71nm+iYpYRhJ9/yymLGf+Y9mocTFM0zGx2N6LdOmMaVWynv4F
         T/Nn9M1e9PeU5kl4UPG7u1S5RMqhxF72dZmzh1KeCyL2y5I63sbbW2XEaQp8kFS9T6N+
         kqJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=V3DMfLQaLfL8Bqw6ozy6bYrMLBwe4yrz27viyroXSjk=;
        b=KBBl6ij1GNBDSwPLWptJ1L62NsWWXUR4tEyVkHhRPBuBEI5yjmIQ97i2Iw9kz24ocY
         fORo7fRNtxrfEnWuSwAF9Mvil5fOCpO5mMdqHoMIgmBRoheS2XWmdkXd1UQy5/PXGE3n
         mjYjXKYCyUO0bNRqj58lSLLIUHNjCzrNQfYXEDRPh8YGi4vB+2+AiUvebvFK+ICaCwGC
         t45xhsgV1fuZrpSqXgZHBTRJBeJ04EkIArfYyO8MHn9U6LJBktXNHes8AaQmHMEd7/Q1
         Y1BuF56BCtYeoUj8AkQKRVjwbD4FBgD2LyFhC+ZjsNJ9J9vMkDpNDWVQyvAC52hoCw+W
         OJfQ==
X-Gm-Message-State: ACrzQf2WE4R95G8xnf4CbTWHFx9JkPXIUAWFNGascZJEd+ANpyLH3B6M
        VJI/V+rQxXhOw288UVSCqztSEiLp0FtoIikXm4fajfWHwxg=
X-Google-Smtp-Source: AMsMyM6DprBB1sMCJOHPvsvTaUOvQ+QNHqgTNKN+zAt7YlsZje3tU/opTJDoE6kWzGMxmFIlxqVyEXC+kdSaZg7vR34=
X-Received: by 2002:a17:906:8a46:b0:781:71fc:d23f with SMTP id
 gx6-20020a1709068a4600b0078171fcd23fmr18377783ejc.500.1664867790698; Tue, 04
 Oct 2022 00:16:30 -0700 (PDT)
MIME-Version: 1.0
References: <20220920103108.23074-1-jay.xu@rock-chips.com> <20220920103108.23074-16-jay.xu@rock-chips.com>
In-Reply-To: <20220920103108.23074-16-jay.xu@rock-chips.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Tue, 4 Oct 2022 09:16:19 +0200
Message-ID: <CACRpkdb0wysqkSST7Qv+yy8g53oTpYWvbSqxLk6EVMEABQW4iA@mail.gmail.com>
Subject: Re: [PATCH 15/20] gpio/rockchip: disable and put clocks when gpiolib
 register failed
To:     Jianqun Xu <jay.xu@rock-chips.com>
Cc:     heiko@sntech.de, brgl@bgdev.pl, andriy.shevchenko@linux.intel.com,
        robert.moore@intel.com, robh@kernel.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org,
        lenb@kernel.org, rafael@kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 20, 2022 at 12:31 PM Jianqun Xu <jay.xu@rock-chips.com> wrote:

> When gpiolib register failed, the clocks should be disabled and put.
>
> Signed-off-by: Jianqun Xu <jay.xu@rock-chips.com>
(...)
> +err_put_clk:
> +       clk_put(bank->clk);
> +       clk_put(bank->db_clk);
> +       clk_disable_unprepare(bank->clk);
> +       clk_disable_unprepare(bank->db_clk);

Always clk_disable_unprepare() before clk_put().

I think you can drop clk_put() if you switch to devres dev_clk_get()
instead.

Yours,
Linus Walleij
