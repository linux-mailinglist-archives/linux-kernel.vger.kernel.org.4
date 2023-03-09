Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E46E26B27DB
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Mar 2023 15:53:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231795AbjCIOxF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Mar 2023 09:53:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36402 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232098AbjCIOw1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Mar 2023 09:52:27 -0500
Received: from mail-vs1-xe2f.google.com (mail-vs1-xe2f.google.com [IPv6:2607:f8b0:4864:20::e2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D31CBE5E0
        for <linux-kernel@vger.kernel.org>; Thu,  9 Mar 2023 06:50:34 -0800 (PST)
Received: by mail-vs1-xe2f.google.com with SMTP id f23so1810183vsa.13
        for <linux-kernel@vger.kernel.org>; Thu, 09 Mar 2023 06:50:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20210112.gappssmtp.com; s=20210112; t=1678373433;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=va4kHwm1yumJqucCqfg3NWgJfevI9xFn3g90MmoOXUE=;
        b=jN+LS77GkISgg0bT2TDfcuZufLtquRZZ6E0heLUyapVFP8zWM0By9MLTlROG5UKS9S
         9JZGoZSSsbNWBbucYAHJpmzb0y+Z7x1dKBhYrXDzpc0RvbsuOHkr+OpLOj5FRZOREZRQ
         zRZ4M3OqCPpLyBkrYjhwiMdPvbGQgUwvP1w6RkUx/RkaKmFn9TAMPSqKT1iYYSfXAbGg
         V06qEsV1nSQNtXuwwPowICB1C1DJ9Bbl6TMkmWJFTWJydumaZ0D1NyqmzgQrq0hw/aVl
         j/dxHXBtdFRc5N04h9g4oG9kbMHM4agWSnf4PXiHkIPbY6E+w5Ob3oIg1hO/aR7mF0HU
         BbIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678373433;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=va4kHwm1yumJqucCqfg3NWgJfevI9xFn3g90MmoOXUE=;
        b=lbQWpNyioTCJ2qltTbDcPyIyxbCOxLnklBjUr+cb34OT0XRkJ4QdRUx39KGC0LqNXm
         uLMkDLjhljpzeXHXOIVremTsdnyrnhA/091vjs1iKSCa0S2qvZGE9X4dWv2CDu7Tm37t
         x72jvI8ZlyF0Bap+bGRSPsvyk7m7INgimdk8XqmjrbuAEHTS25EWqmdJjpZfAFUm5aFm
         UXH3rRn8JXQw0ZT584BL5m3jKpvu+p/omhHYe/IUr/EjlChAYwqzYKCoqlPDeeGDZTwZ
         nbSpjttUCg+5COKkssaPP97LVGyP0TDsM7IvxcJE1R2XgE2lBFtUt5/pL8sDASC74WD+
         KkJg==
X-Gm-Message-State: AO0yUKWXqcrRHlV4DYKBo+2FpzgRuvna20+piq+y8ugwg7sSD811+RDr
        uOS/2EuSkiXOi+qT9CgFSLku0zvLFQjoKWBHVxWkLQ==
X-Google-Smtp-Source: AK7set/7qqcBeEpI34yOk+TcYT8hxytCgmorpWM+HhkEhl9D5airjCoK6u7AUA1qtePnSUt7BGPi+WpXIeESx53ct7I=
X-Received: by 2002:a67:ff1a:0:b0:422:1687:f239 with SMTP id
 v26-20020a67ff1a000000b004221687f239mr4217040vsp.2.1678373433453; Thu, 09 Mar
 2023 06:50:33 -0800 (PST)
MIME-Version: 1.0
References: <20230309111407.3398-1-zhuyinbo@loongson.cn>
In-Reply-To: <20230309111407.3398-1-zhuyinbo@loongson.cn>
From:   Bartosz Golaszewski <brgl@bgdev.pl>
Date:   Thu, 9 Mar 2023 15:50:22 +0100
Message-ID: <CAMRc=MeqLyPpqg9bO-EntdxWzUJ5aP5wzqna2bj_1F2aE8uDgw@mail.gmail.com>
Subject: Re: [PATCH v1] gpio: loongson: fixup the warning about OF_GPIO direct dependencies
To:     Yinbo Zhu <zhuyinbo@loongson.cn>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jianmin Lv <lvjianmin@loongson.cn>, wanghongliang@loongson.cn,
        Liu Peibao <liupeibao@loongson.cn>,
        loongson-kernel@lists.loongnix.cn,
        kernel test robot <lkp@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 9, 2023 at 12:14=E2=80=AFPM Yinbo Zhu <zhuyinbo@loongson.cn> wr=
ote:
>
> WARNING: unmet direct dependencies detected for OF_GPIO
>   Depends on [n]: GPIOLIB [=3Dy] && OF [=3Dn] && HAS_IOMEM [=3Dy]
>   Selected by [y]:
>   - GPIO_LOONGSON_64BIT [=3Dy] && GPIOLIB [=3Dy] && HAS_IOMEM [=3Dy] && (=
LOONGARCH || COMPILE_TEST [=3Dy])
>
> Signed-off-by: Yinbo Zhu <zhuyinbo@loongson.cn>
> Reported-by: kernel test robot <lkp@intel.com>
> Link: https://lore.kernel.org/oe-kbuild-all/202303091728.UUe6LWye-lkp@int=
el.com
> ---
>  drivers/gpio/Kconfig | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/gpio/Kconfig b/drivers/gpio/Kconfig
> index 94051fb59043d..c0d6254797800 100644
> --- a/drivers/gpio/Kconfig
> +++ b/drivers/gpio/Kconfig
> @@ -384,7 +384,7 @@ config GPIO_LOONGSON
>  config GPIO_LOONGSON_64BIT
>         tristate "Loongson 64 bit GPIO support"
>         depends on LOONGARCH || COMPILE_TEST
> -       select OF_GPIO
> +       depends on OF_GPIO
>         select GPIO_GENERIC
>         help
>           Say yes here to support the GPIO functionality of a number of
> --
> 2.31.1
>

Thanks for the quick fix, applied.

Bart
