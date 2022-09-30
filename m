Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B84A15F0775
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Sep 2022 11:21:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231330AbiI3JVy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Sep 2022 05:21:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57194 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230358AbiI3JVv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Sep 2022 05:21:51 -0400
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 212E11EC69
        for <linux-kernel@vger.kernel.org>; Fri, 30 Sep 2022 02:21:50 -0700 (PDT)
Received: by mail-wr1-x42a.google.com with SMTP id c11so5880121wrp.11
        for <linux-kernel@vger.kernel.org>; Fri, 30 Sep 2022 02:21:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20210112.gappssmtp.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=mhmaIVHO4ARHyotQ41EbCpRU4cv31jDVGkF//FBjacw=;
        b=0jYSLeDM1RiTMyT8C6fkEJOqd3UZa6OdbI4c3nZ9pQe/LnGX1mA47y1zQnZZN4gKhq
         o5aERGEZ3zTfhG183Wbllfk1usbP/twgCzggK58K+laxyEfxn7GWcLfvS8pwun30rRSj
         HetPXd3kLzqOWsrAPyJ7Ix6AE96hwJolrI//lVQCwSBqIslCuTOevK9308/9Jvol6x5t
         jIfilUaU0vp4fND1Ky1K+DiwIitgPEkTj9yw1kXU6T8Qw8bWKnh0BFZFLm/A1PFaiGrn
         tD1zD0IMpJSSPrN2RjHned1CvBHibTSSxh6D9TWq4jHHGntYcZP6RoE4FivmYVHd3hCu
         O0JQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=mhmaIVHO4ARHyotQ41EbCpRU4cv31jDVGkF//FBjacw=;
        b=tMppHq18zYZ87hX4qyDgWfzm5cksGpir+RNsIbKmz+fWFpzB2OpA2pyOjLPUlewxHJ
         aJGhmHk6PNGcFok2ypNoorxDeoa22lV+vyn6f5/1aZGegxi4t7m0gKMgY06OYOueyHFc
         Y1lpV9kF0jrv6RE78BBG/ix76oky4g+nmT0zQ75CO1v6bm0KSrnSVkE+0FgIz6CMegjD
         lFBceLHeRDzoKvuKuEefr+JOx1lonOabVaTTkUaCJzGAl/51DiuD8BkmZ6gkuU9M2nqm
         5usUn52mCLdRdxCOAqUI7eQ9fxYVmHkLMc1uiVJ28CWFokYcXdRvFj2t7K5ykauuqrpl
         2Xow==
X-Gm-Message-State: ACrzQf1QKAJ1M122afXZMdto0We+sZhW3A/GZdnyX6kYbIL2yASlQ6pu
        Uh3Nj0MK3XUX1Hq0n2oRGdcjGY6iqPiikv5s3x8e4Pccn6c=
X-Google-Smtp-Source: AMsMyM7ejpz6lZ636PE6cbFSw7cIyiskE6E7ENBCjmBlQVigayBLzUohuvRiObUu4zn8nLlyAfn0qHqE/lSzOzRfYsc=
X-Received: by 2002:adf:fb50:0:b0:22a:e4e9:a6b3 with SMTP id
 c16-20020adffb50000000b0022ae4e9a6b3mr5000514wrs.467.1664529708668; Fri, 30
 Sep 2022 02:21:48 -0700 (PDT)
MIME-Version: 1.0
References: <20220920103108.23074-1-jay.xu@rock-chips.com> <20220920103108.23074-18-jay.xu@rock-chips.com>
In-Reply-To: <20220920103108.23074-18-jay.xu@rock-chips.com>
From:   Bartosz Golaszewski <brgl@bgdev.pl>
Date:   Fri, 30 Sep 2022 11:21:37 +0200
Message-ID: <CAMRc=MdPz8=4a=e=pcsnvGMzs5J2TyZR=mOSKatD5BcOep3RFw@mail.gmail.com>
Subject: Re: [PATCH 17/20] gpio/rockchip: print device with fwnode name when
 probe successful
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
> Print the device probe message with the fwnode instead of of_node.
>
> Signed-off-by: Jianqun Xu <jay.xu@rock-chips.com>
> ---
>  drivers/gpio/gpio-rockchip.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/gpio/gpio-rockchip.c b/drivers/gpio/gpio-rockchip.c
> index 11586d93549b..d08435619f12 100644
> --- a/drivers/gpio/gpio-rockchip.c
> +++ b/drivers/gpio/gpio-rockchip.c
> @@ -772,7 +772,7 @@ static int rockchip_gpio_probe(struct platform_device *pdev)
>         }
>
>         platform_set_drvdata(pdev, bank);
> -       dev_info(dev, "probed %pOF\n", np);
> +       dev_info(dev, "probed %pfw\n", dev_fwnode(dev));
>
>         return 0;
>  err_put_clk:
> --
> 2.25.1
>

I would instead just drop this log message. If the user wants to, they
can obtain that information from the device core logs.

Bart
