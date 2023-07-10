Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A955374D160
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jul 2023 11:27:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231209AbjGJJ1I (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Jul 2023 05:27:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48572 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230420AbjGJJ1B (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jul 2023 05:27:01 -0400
Received: from mail-vk1-xa30.google.com (mail-vk1-xa30.google.com [IPv6:2607:f8b0:4864:20::a30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F932114
        for <linux-kernel@vger.kernel.org>; Mon, 10 Jul 2023 02:27:00 -0700 (PDT)
Received: by mail-vk1-xa30.google.com with SMTP id 71dfb90a1353d-47e793ccdc7so1175974e0c.1
        for <linux-kernel@vger.kernel.org>; Mon, 10 Jul 2023 02:27:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20221208.gappssmtp.com; s=20221208; t=1688981219; x=1691573219;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xSgqmrfhrfLHk+Rtln7FX4R9GhlwgoSFZ/Hmf3Xuu8o=;
        b=5Aqch1oXfro/XYSLV9jNT5X2Md/AdjdklKt9b+qVnXw+0OXhzbYe0yes7eN+SanfRh
         DnkJCbVERhWZIEF5xMWXyyHM4D8SGrZBYprpH9a7T/HzgQ1F+eMUCXeD6yJd/0hCAsTp
         qaRjq0ByLDAcdjDr6IpSzo9fHon29LLYDP8CE0fGAlqDxfJOPNSs5WRlxl7g9yHiWIfg
         yPoaLjyV69qp3TJMyE6AcKo4lAV66QjLYiodPmQoPo+XPj19FFSZvD9qaFPs/LgCB/mG
         rrRyh4rcRfWCdzDxKd9EglwDUrOvd2rtuO0GCZg6PrQhKyAB5tbQPh9M48v6wRtV2mB8
         qvJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688981219; x=1691573219;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xSgqmrfhrfLHk+Rtln7FX4R9GhlwgoSFZ/Hmf3Xuu8o=;
        b=BirgfYiJb2J8jWNle3JY/evsvj9ErsKnzID2v4hNIc+zXjEDwCX5cfUjbsE52kNFx5
         eIJVuHVgCcPuS5wk6MIQUpVHNxlj0vO1UYsfppLszMl/Q4lLtul8xkT+YwTjllrSFLvu
         YzeYO2xmz/jOxrPyzFCrsypgGaFdrwejSh14Kyd3HytsPosS752+5E5mX5nBHMVp3FRq
         q1BxsQdl+6ktjoTRKBdy4i9TedhQ8dqa7HQYNuOItkAZYZdWZTvxYhP1Hu1NtsmNxmGP
         7CSTZGT04+SunoW6E+crylDhWkZrOPnE8428SCS45BouPJPgPVgswfwKFTlhrwZu6w7h
         XMYA==
X-Gm-Message-State: ABy/qLYM5NGQpWQ61liErRofWRd+1FijL6usCvisu+6Q+PYGajTaBBTC
        WvhYQBnseve26LguOMVXMZbQVGp1Bo6pAd5hL+ZbnA==
X-Google-Smtp-Source: APBJJlEQT2Oqz6H+43YCqXvSmQo50UIhAp6Rg+TqGxyYtSEr3m7p/Iq97NPCskDoJwzSskOCFQDYnJMPaXNVPyN0WgE=
X-Received: by 2002:a1f:4544:0:b0:47e:a218:86b2 with SMTP id
 s65-20020a1f4544000000b0047ea21886b2mr2684352vka.15.1688981219330; Mon, 10
 Jul 2023 02:26:59 -0700 (PDT)
MIME-Version: 1.0
References: <20230703142308.5772-1-andriy.shevchenko@linux.intel.com>
In-Reply-To: <20230703142308.5772-1-andriy.shevchenko@linux.intel.com>
From:   Bartosz Golaszewski <brgl@bgdev.pl>
Date:   Mon, 10 Jul 2023 11:26:48 +0200
Message-ID: <CAMRc=MfBnz7bg7Qxoh3t0aQoSPMTgAuz6+JLSgUQA5zyS3r=mQ@mail.gmail.com>
Subject: Re: [PATCH v2 0/3] gpiolib: Avoid modifying GPIO chip fwnode
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
        linux-gpio@vger.kernel.org, linux-acpi@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Linus Walleij <linus.walleij@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 3, 2023 at 4:23=E2=80=AFPM Andy Shevchenko
<andriy.shevchenko@linux.intel.com> wrote:
>
> Ideally the GPIO chip data structure has to be constant.
> In real life it's not true, but we can make it closer to
> that. Hence the series.
>
> Bart, the idea is that this series has to land immediately after
> v6.5-rc1 is out so we will have longer time to fix downsides and
> regressions found, if any.
>
> Benjamin, thank you for testing!
>
> Changelog v2:
> - replaced open coded device_match_acpi_handle()
> - corrected commit message due to above change
> - added tag (Benjamin)
>
> Andy Shevchenko (3):
>   gpiolib: of: Don't use GPIO chip fwnode in of_gpiochip_*()
>   gpiolib: acpi: Don't use GPIO chip fwnode in acpi_gpiochip_find()
>   gpiolib: Do not alter GPIO chip fwnode member
>
>  drivers/gpio/gpiolib-acpi.c |  2 +-
>  drivers/gpio/gpiolib-of.c   |  6 +++---
>  drivers/gpio/gpiolib.c      | 16 ++++++++--------
>  3 files changed, 12 insertions(+), 12 deletions(-)
>
> --
> 2.40.0.1.gaa8946217a0b
>

Applied, thanks!

Bart
