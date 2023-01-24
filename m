Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0E237679679
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Jan 2023 12:20:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233459AbjAXLUF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Jan 2023 06:20:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48636 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233488AbjAXLUC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Jan 2023 06:20:02 -0500
Received: from mail-qt1-f181.google.com (mail-qt1-f181.google.com [209.85.160.181])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F71113DC0;
        Tue, 24 Jan 2023 03:20:01 -0800 (PST)
Received: by mail-qt1-f181.google.com with SMTP id h24so8797253qta.12;
        Tue, 24 Jan 2023 03:20:01 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=mcS4Z2L0QM2nzxWhHiDqpfIkuii5KPQKeERri9Le/+U=;
        b=d0RzeqLeaNaHmsFGl+ZOa84hBxs9rY2SJMVcu6sbAZGIxyX0jYzngK1R563zwajkdb
         XdFC2op5EWMoZrYqwqQPOllCS9FkhZDrsgqDe0rUTbEFgBlhw0WK2nPrZSNJc01AIq7f
         VHFhPN6qIxaORLeYg/ZlXIebVrqIpq1Fy3R4ojt24qSDeyJOlVJpYMtZrSknHjgTzcO9
         /ypEKTfXTDjvJChElODabDERgvzuXCxCScFCSnc+IJ2tfvO8fpKdiTe0wZRluqFVX9AE
         f+NK/+wGAzofeBDMCmmpndYkExsp6lPUVK6tZuGIEfIQBdlk0iDm8E9P4RnKilCUplAz
         SnXQ==
X-Gm-Message-State: AFqh2ko8O0FLccDIwF1B6nJnlZObbTcEVzXwf/kwBPjWpXsXbPqng6LQ
        gvgHoKSxZnvWYBFK+puvnltn4alAWmkUNg==
X-Google-Smtp-Source: AMrXdXv9tUyJ9RkQhbWGMVtAVss+FAukRQemDyxmYy2IOsxStGL8scBEoBSg3+h9t5dH/GWy+wUFlQ==
X-Received: by 2002:ac8:4c84:0:b0:3b4:d5be:a2e0 with SMTP id j4-20020ac84c84000000b003b4d5bea2e0mr37558150qtv.20.1674559200247;
        Tue, 24 Jan 2023 03:20:00 -0800 (PST)
Received: from mail-yb1-f178.google.com (mail-yb1-f178.google.com. [209.85.219.178])
        by smtp.gmail.com with ESMTPSA id 18-20020ac856f2000000b0039cd4d87aacsm1057227qtu.15.2023.01.24.03.19.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 24 Jan 2023 03:19:59 -0800 (PST)
Received: by mail-yb1-f178.google.com with SMTP id m199so2628677ybm.4;
        Tue, 24 Jan 2023 03:19:59 -0800 (PST)
X-Received: by 2002:a25:d88c:0:b0:77a:b5f3:d0ac with SMTP id
 p134-20020a25d88c000000b0077ab5f3d0acmr2609830ybg.202.1674559199422; Tue, 24
 Jan 2023 03:19:59 -0800 (PST)
MIME-Version: 1.0
References: <20221215181848.129326-1-helgaas@kernel.org>
In-Reply-To: <20221215181848.129326-1-helgaas@kernel.org>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Tue, 24 Jan 2023 12:19:48 +0100
X-Gmail-Original-Message-ID: <CAMuHMdUuPKyMDwAHvUxC_s-Cqv_aui=1+eHCMypkpQSmvz=uuQ@mail.gmail.com>
Message-ID: <CAMuHMdUuPKyMDwAHvUxC_s-Cqv_aui=1+eHCMypkpQSmvz=uuQ@mail.gmail.com>
Subject: Re: [PATCH] PM: runtime: Simplify __rpm_get_callback()
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     "Rafael J . Wysocki" <rafael@kernel.org>,
        Len Brown <len.brown@intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Bjorn Helgaas <bhelgaas@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Bjorn,

On Thu, Dec 15, 2022 at 7:23 PM Bjorn Helgaas <helgaas@kernel.org> wrote:
> From: Bjorn Helgaas <bhelgaas@google.com>
>
> Simplify __rpm_get_callback() slightly by returning as soon as the return
> value is known.  No functional change intended.
>
> Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>

Thanks for your patch, which is now commit 650bdddb6b311705 ("PM:
runtime: Simplify __rpm_get_callback()") in pm/linux-next.

> --- a/drivers/base/power/runtime.c
> +++ b/drivers/base/power/runtime.c
> @@ -20,8 +20,7 @@ typedef int (*pm_callback_t)(struct device *);
>
>  static pm_callback_t __rpm_get_callback(struct device *dev, size_t cb_offset)
>  {
> -       pm_callback_t cb;
> -       const struct dev_pm_ops *ops;
> +       const struct dev_pm_ops *ops = NULL;
>
>         if (dev->pm_domain)
>                 ops = &dev->pm_domain->ops;
> @@ -31,18 +30,14 @@ static pm_callback_t __rpm_get_callback(struct device *dev, size_t cb_offset)
>                 ops = dev->class->pm;
>         else if (dev->bus && dev->bus->pm)
>                 ops = dev->bus->pm;
> -       else
> -               ops = NULL;
>
>         if (ops)
> -               cb = *(pm_callback_t *)((void *)ops + cb_offset);
> -       else
> -               cb = NULL;
> +               return *(pm_callback_t *)((void *)ops + cb_offset);

This is a change in behavior in case the callback turns out to be NULL:
  - before, it would fall back to the driver-specific callback below,
  - after, it always returns NULL.

>
> -       if (!cb && dev->driver && dev->driver->pm)
> -               cb = *(pm_callback_t *)((void *)dev->driver->pm + cb_offset);
> +       if (dev->driver && dev->driver->pm)
> +               return *(pm_callback_t *)((void *)dev->driver->pm + cb_offset);
>
> -       return cb;
> +       return NULL;
>  }

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
