Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 10A4160D0E0
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Oct 2022 17:41:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232683AbiJYPlh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Oct 2022 11:41:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42640 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231374AbiJYPld (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Oct 2022 11:41:33 -0400
Received: from mail-vk1-xa32.google.com (mail-vk1-xa32.google.com [IPv6:2607:f8b0:4864:20::a32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4506F303D6
        for <linux-kernel@vger.kernel.org>; Tue, 25 Oct 2022 08:41:31 -0700 (PDT)
Received: by mail-vk1-xa32.google.com with SMTP id h16so3618575vkn.4
        for <linux-kernel@vger.kernel.org>; Tue, 25 Oct 2022 08:41:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20210112.gappssmtp.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=o2pOMA/SurU2JJjiuSZcW9YRE04P1aTpEG8F6C20YQ0=;
        b=ZzQdGWos0adIaWCOACSx6Jt+Rmu6WWsPokyUGobba/RdilQ5CpzoWIgX2cUnkeyi04
         my4Tv9o3t9JQ8JtguQShKYAE7udGZxyJ28UH7nyxZznVD3yae3urnRfYTiOfRMLZ8Gmd
         AcvKThmE+uAAoxvRNtL0gkZ7hf68/2tcTm/O6103smwsdqDYNLmkwyzSqaa97ytjmerd
         p+yzRD9z4gBfRV9DyTf22o2fhoQloz2bm51r1lr3D6Z6oWKqLjD4EYusra08IWqC78T9
         qF+ofd6VRHXB/7o3E1zDK3rGSbO5bGj+UoKGEHegilaIjIvdPEhEvTC4U5p3NO1MI5H0
         jnpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=o2pOMA/SurU2JJjiuSZcW9YRE04P1aTpEG8F6C20YQ0=;
        b=Qq7zpoyV4c/V6fdt94T1gp9hwjdq0OMM+1tcLeUMeZfJ73h3ppQbLmr/MXW4U+1pWK
         p5XT7yTug27p6tsgH2EqdT1OD3W5y2D56IOZ6X2dZtu2fzOk1sxGvAUIoY1H4KWSlBaj
         xcxJyneydkkspoKByL3ZzBO92PXLp6yd9QUNjqtOfu4XVtQDPBp1M1qc5NSDXa7hm0R4
         DI/tBgjvJT8wHYHJGu7QK+U68vTTdexhz5jNCn+r0tKCeLYL7mSSFh1uiqonQZp+f95/
         Rb1NkMnI+CjKyylEIPfPpXE9E5KEgLXqt9CWFTBnd7VJKKJ63XCefxBer+6+LTIat8PE
         SzRQ==
X-Gm-Message-State: ACrzQf1hfLtNfkikvvJki1XyRO5uFi9TC7fs6nM/0ABSV7DjgtWi2OMC
        BRF0JkxhVVJp4PXoJR541TOqy2Yx8yQVS0J+EumqiA==
X-Google-Smtp-Source: AMsMyM6OSNmdK116cgiqamT2HPTH9aWb6vEoyFq2agbqFxvj0olwj+j7hmmRO7rmqj8ZuEgSgsdGhXf5ClCkaeGZmUA=
X-Received: by 2002:a1f:d583:0:b0:3aa:9112:570f with SMTP id
 m125-20020a1fd583000000b003aa9112570fmr21071662vkg.3.1666712490282; Tue, 25
 Oct 2022 08:41:30 -0700 (PDT)
MIME-Version: 1.0
References: <20221017170600.88480-1-andriy.shevchenko@linux.intel.com>
In-Reply-To: <20221017170600.88480-1-andriy.shevchenko@linux.intel.com>
From:   Bartosz Golaszewski <brgl@bgdev.pl>
Date:   Tue, 25 Oct 2022 17:41:19 +0200
Message-ID: <CAMRc=MctArjkzcLY23wKUhUBc9kqy5k1ZWuY61OykofRHGQq5g@mail.gmail.com>
Subject: Re: [PATCH v1 1/1] gpio: exar: Allow IO port access
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Qingtao Cao <qingtao.cao.au@gmail.com>, linux-gpio@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Linus Walleij <linus.walleij@linaro.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 17, 2022 at 7:05 PM Andy Shevchenko
<andriy.shevchenko@linux.intel.com> wrote:
>
> It's possible that PCI device can provide an IO port resource for
> the device. regmap MMIO currently uses MMIO by default. With an
> additional flag we enable support for IO port accesses.
>
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> ---
>  drivers/gpio/gpio-exar.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/drivers/gpio/gpio-exar.c b/drivers/gpio/gpio-exar.c
> index 482f678c893e..df1bdaae441c 100644
> --- a/drivers/gpio/gpio-exar.c
> +++ b/drivers/gpio/gpio-exar.c
> @@ -141,6 +141,7 @@ static const struct regmap_config exar_regmap_config = {
>         .name           = "exar-gpio",
>         .reg_bits       = 16,
>         .val_bits       = 8,
> +       .io_port        = true,
>  };
>
>  static int gpio_exar_probe(struct platform_device *pdev)
> --
> 2.35.1
>

Applied, thanks!

Bartosz
