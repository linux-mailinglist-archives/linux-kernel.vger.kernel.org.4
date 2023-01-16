Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E3F0E66B9D6
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Jan 2023 10:06:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231506AbjAPJGc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Jan 2023 04:06:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37896 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232550AbjAPJF7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Jan 2023 04:05:59 -0500
Received: from mail-vs1-xe29.google.com (mail-vs1-xe29.google.com [IPv6:2607:f8b0:4864:20::e29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F420118AB0
        for <linux-kernel@vger.kernel.org>; Mon, 16 Jan 2023 01:03:30 -0800 (PST)
Received: by mail-vs1-xe29.google.com with SMTP id n190so24491925vsc.11
        for <linux-kernel@vger.kernel.org>; Mon, 16 Jan 2023 01:03:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20210112.gappssmtp.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=32WOcoXO5ldk2Em3aPyakA0jH+HICU+rv07Xae29T34=;
        b=UeKy7hV7fsyqRTX4F+f8YoVuVc8GCJKGrtdglTgVFNwp+8Zfjxmx1qn3D0BBla46ob
         Gh3br7pcEbiK1SlN//rVokX6zM2cA/VAEj0XOFOfvC2gOTriSeGdFeCuKHGoQfBTHQUV
         LCIHNsO7dnZ2++tNwHecVk7Qnn7K8MncHEfd4Lq2xh0mltR/jWtZeFT8uymZgge1o8h8
         nibai1IafatnXYQGi4kjpLB8bTdZLRCg+g/+7ZggDFjX4zQZu80Z7XBtI4UWbJwZol1M
         Dv5Xa4WswNdVNOsQqKuuk8qX6oje+dqCK8hg9Y8f7a4XQyo2WFYGWtINHH82S/zUDY2D
         nCeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=32WOcoXO5ldk2Em3aPyakA0jH+HICU+rv07Xae29T34=;
        b=i5w7rq2RipiKkWlmHp2JpwusRT4BxjtFV1uSR+hYbRE5ausUWt48hVX3Cdb2LQ/eWR
         e3FVWunKNYsSTCuCs1O1QJFTSwd63J2rH/dOsP6cr+xcUw6AHzP7Y6DbP2tIa6LcXi7b
         y9Ob5XBMDaGW4PpswiMyufoxSnaX9HfGsIWJbYMTfFTjuMtaHPfpXQ4E5UwfaOgUubT4
         cbHIfqHnuEfwwB70w609HFHr3TAm//oZTggHzag/mH0uColPXKzfkFmNf3+sk3nIZ3eD
         Wd8DqhRbSL1GjgpAkG4MOnQDsEshXkzjrBQ49uxFvMnmAmBnMycHuZjAN0Ky3G7+TbRQ
         xDcg==
X-Gm-Message-State: AFqh2krtkxesjPAzMZFN03pd3Jvt3HOltxaJdxuqz+/TTDz3gLTHyOtB
        VsgtaHPk8oKvJ+Yn6xBcizo6yUybV7AU1UAtE4yQMbrUCgqtFshd
X-Google-Smtp-Source: AMrXdXthmHPScO+QHMGTj79l65q9+ThrjSLYcDLQJ5STDs5sRva9j0NY+z+2mTr+aBOVsQ37f5IX8ldpO4CCkLZWUDE=
X-Received: by 2002:a05:6102:83b:b0:3d1:3753:9a3c with SMTP id
 k27-20020a056102083b00b003d137539a3cmr1433742vsb.73.1673859810089; Mon, 16
 Jan 2023 01:03:30 -0800 (PST)
MIME-Version: 1.0
References: <20230113182619.16800-1-andriy.shevchenko@linux.intel.com>
In-Reply-To: <20230113182619.16800-1-andriy.shevchenko@linux.intel.com>
From:   Bartosz Golaszewski <brgl@bgdev.pl>
Date:   Mon, 16 Jan 2023 10:03:19 +0100
Message-ID: <CAMRc=MetFa3v5fWzm0mhWGDoH1h_CfAOzktdKy+kTjp9BeefLQ@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] gpio: wcd934x: Remove duplicate assignment of of_gpio_n_cells
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
        linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        Linus Walleij <linus.walleij@linaro.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 13, 2023 at 7:25 PM Andy Shevchenko
<andriy.shevchenko@linux.intel.com> wrote:
>
> The of_gpio_n_cells default is 2 when ->of_xlate() callback is
> not defined. No need to assign it explicitly in the driver.
>
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> ---
> v2: no changes
>  drivers/gpio/gpio-wcd934x.c | 1 -
>  1 file changed, 1 deletion(-)
>
> diff --git a/drivers/gpio/gpio-wcd934x.c b/drivers/gpio/gpio-wcd934x.c
> index 97e6caedf1f3..817750e4e033 100644
> --- a/drivers/gpio/gpio-wcd934x.c
> +++ b/drivers/gpio/gpio-wcd934x.c
> @@ -98,7 +98,6 @@ static int wcd_gpio_probe(struct platform_device *pdev)
>         chip->base = -1;
>         chip->ngpio = WCD934X_NPINS;
>         chip->label = dev_name(dev);
> -       chip->of_gpio_n_cells = 2;
>         chip->can_sleep = false;
>
>         return devm_gpiochip_add_data(dev, chip, data);
> --
> 2.39.0
>

Applied, thanks!

Bart
