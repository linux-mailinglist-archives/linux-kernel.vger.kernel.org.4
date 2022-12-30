Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 25133659A41
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Dec 2022 17:00:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235341AbiL3QAA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Dec 2022 11:00:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33738 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235311AbiL3P7y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Dec 2022 10:59:54 -0500
Received: from mail-vs1-xe32.google.com (mail-vs1-xe32.google.com [IPv6:2607:f8b0:4864:20::e32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9DC451BEAF
        for <linux-kernel@vger.kernel.org>; Fri, 30 Dec 2022 07:59:51 -0800 (PST)
Received: by mail-vs1-xe32.google.com with SMTP id m129so15857129vsc.11
        for <linux-kernel@vger.kernel.org>; Fri, 30 Dec 2022 07:59:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20210112.gappssmtp.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=hD//RF4blNAzKMQHle6kDDLz8WA64xw1Lyfp9+dzdpI=;
        b=rJVz6Q9TZfsUfZEMrNibT7dNKb+3pE4AwoNbfkrU6skAfCw8eMzXouc3vSqaVb+vZP
         7QtFxrOEbIq3E8bzOgt+roB+bQOdA/rbez92xxmaHTfn2Al21EuQwUwCh8wBxu+CKrG0
         8iojxr2oHhIjOF6wxn+A7rWaWSypnHB7/sLb452tHljRbGO36zX6B9ak7ogdPS4ypO8G
         vqYTLMo5fgEisBiFZ0JqmWcfUzHijeqf8JnqQ2gXclomQ/FEjpCvC9IsLGOK//kPehwe
         go7BiiPpHuBrXJwOY7klNC1e2qbGY71IxOF3t8IO2TwJRof6IeFEb4xNtbfXSMofe65E
         vMXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=hD//RF4blNAzKMQHle6kDDLz8WA64xw1Lyfp9+dzdpI=;
        b=POcEYhJdGAXnI1OAEBbJwA5nQeX2QQ9Lhymf/0nlpQ/E+MFrgJikn/Ohg0kzgM8DZH
         bJT2kGFLm/sOOv1PdjTRBFJBt3jS7DYR+hSyRTYzxv4PdqElQ/CxiGXPnir3FLrjb/JG
         B5ddAyp5gctHfhZPlRCgnE9nOX3EdoItlCmSrXM9ttlukM/wdgstIpIoegD3qn5Qwbur
         kwBpxtT9EZdcd+TxMKHS0/fXIySfSMcTwtatDq4XR1EBZ2zsZa7RAZwbtjovW2xVMYQm
         +kI9E5lSypagk4aPeuawmomTpppsAOwvab5Oklto9aV9DtilO6/X5a7NbpzsyvJ2GtFM
         I4rw==
X-Gm-Message-State: AFqh2kqAqm/LwDHuwP4Rw7QcbY0fhTVOCkZiDGHl8H7yVIepPx0GdkI1
        Y6seJhY6Cu13e2fXlGkRs8BXtdCWD22xeIdnVyANfA==
X-Google-Smtp-Source: AMrXdXtfilpeqY0j9oUYEitFCGn7fOM3TRS2YPIKHdV/PTt+Mmuvb+rbJtq53UdKYAoFFdMIG5aVcCeDfKlCCAguVHo=
X-Received: by 2002:a67:df8c:0:b0:3c5:1ac1:bf38 with SMTP id
 x12-20020a67df8c000000b003c51ac1bf38mr3071643vsk.78.1672415990740; Fri, 30
 Dec 2022 07:59:50 -0800 (PST)
MIME-Version: 1.0
References: <20221229145545.14055-1-cixi.geng@linux.dev>
In-Reply-To: <20221229145545.14055-1-cixi.geng@linux.dev>
From:   Bartosz Golaszewski <brgl@bgdev.pl>
Date:   Fri, 30 Dec 2022 16:59:40 +0100
Message-ID: <CAMRc=MeCCT09umHQ+T6Z6OXMedBh3UXzmQ=1PCyo1zEMr34TCw@mail.gmail.com>
Subject: Re: [PATCH V4 0/3] Make the irqchip immutable
To:     Cixi Geng <cixi.geng@linux.dev>
Cc:     linus.walleij@linaro.org, orsonzhai@gmail.com,
        baolin.wang@linux.alibaba.com, zhang.lyra@gmail.com,
        linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        cixi.geng1@unisoc.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 29, 2022 at 3:56 PM Cixi Geng <cixi.geng@linux.dev> wrote:
>
> From: Cixi Geng <cixi.geng1@unisoc.com>
>
> Kernel warns about mutable irq_chips:
>     "not an immutable chip, please consider fixing!"
>
> Make the struct irq_chip const, flag it as IRQCHIP_IMMUTABLE, add the
> new helper functions, and call the appropriate gpiolib functions.
>
> v2 changes:
> Split the patch by each driver. and other comment by baolin in[1]
>
> v3 changes:
> Fix cocci warnings test by lkp[2].
>
> v4 changes:
> Change the irq name.
> Keep the same coding style by using offset for irqd_to_hwirq(data)
> Add Reviewed-by tag.
>
> [1]:https://lore.kernel.org/all/97e244d4-6b5c-31c9-7329-b8deef615645@linux.alibaba.com/
> [2]:https://lore.kernel.org/all/202212240406.9Nm190P8-lkp@intel.com/
>
> Cixi Geng (3):
>   gpio: eic-sprd: Make the irqchip immutable
>   gpio: gpio-pmic-eic-sprd: Make the irqchip immutable
>   gpio: gpio-sprd: Make the irqchip immutable
>
>  drivers/gpio/gpio-eic-sprd.c      | 23 ++++++++++++++---------
>  drivers/gpio/gpio-pmic-eic-sprd.c | 29 ++++++++++++++++++-----------
>  drivers/gpio/gpio-sprd.c          |  9 ++++++---
>  3 files changed, 38 insertions(+), 23 deletions(-)
>
>
> base-commit: 1b929c02afd37871d5afb9d498426f83432e71c2
> --
> 2.34.1
>

Series queued for fixes, thanks!

Bart
