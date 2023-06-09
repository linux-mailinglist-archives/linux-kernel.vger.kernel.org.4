Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EBE267295AE
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Jun 2023 11:41:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241788AbjFIJlo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Jun 2023 05:41:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33486 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241768AbjFIJlM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Jun 2023 05:41:12 -0400
Received: from mail-vs1-xe34.google.com (mail-vs1-xe34.google.com [IPv6:2607:f8b0:4864:20::e34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A44EA76B9
        for <linux-kernel@vger.kernel.org>; Fri,  9 Jun 2023 02:36:01 -0700 (PDT)
Received: by mail-vs1-xe34.google.com with SMTP id ada2fe7eead31-43dda815756so431699137.1
        for <linux-kernel@vger.kernel.org>; Fri, 09 Jun 2023 02:36:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20221208.gappssmtp.com; s=20221208; t=1686303319; x=1688895319;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BCpRb29xMOM2bj+qPeKvmQpR3/xtDM8QuNcGAMZDaaY=;
        b=Pkti6YwqDLfoJpFIVlerXDC+U84vpHQM3lkT4pe+MjBD8QQfl6wB75fwn1Qc+WdthU
         bypd4dLPJbG50/RYDkgJYLW4Nmb+DzinpXJqgQmcGymqgQRA2cVdJj5oCb5ojISdZEBf
         Q05kwZvRnpsIIp+QkNycJjtE22mG8Sk7POi5EzehCZASnwlT8nJlhpcSTqlCBiVkC7KD
         Dbv7rFvf4CgPp4WcLj0CrEC0Q6MJ/7BzqTKatiYkVkE3ULTv69Fprsj5YZRCdT60dP1c
         jfS0wVFWiYZfaeBYO+YbMUDipxoplS73YOHfutZxlPrULJLJ+cV9XSh4HYzlmZOxqT8V
         tpog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686303319; x=1688895319;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BCpRb29xMOM2bj+qPeKvmQpR3/xtDM8QuNcGAMZDaaY=;
        b=FHKkVyK4pE9QSF0yYfmRiA+cXBORTZpxmQ9XDB1lq37W8Y+eKN8vkAqndNe9d0BdFO
         Sco+g0HJ9ZGwPZ+D9ai9S5SjOdnQM8turFnJ8msWIdfIeGG/SBgcCBPz3v7brUMkUpJv
         W5PXRYDGjAhE2icE3Q8tMVsnlHlKlqAX+Zr7sFUwgBRwoHpoSXsg+0P7Ki7PDVl/oAOw
         10V2qrLIiyH1Ou8AN/oDMDkWWcPnFuDhNQ5n7WhMTQS5jVpV9MJ2LUGHyqD+ohLX8tYf
         /NLfcMyGS987xazJuhMfr2qHtP3LkC+1VxSbLsWfKPCpfcu9RCuj4Piy6EZQ1LSJXONt
         jSvg==
X-Gm-Message-State: AC+VfDwiPkYeXvoM77CQae4knfuLQsERgEyabNWsjS2bbywzko/xCvhG
        xia4psgxBS/Lonc+5P7JC/WnaLdFn1A1jcW+QzvUuA==
X-Google-Smtp-Source: ACHHUZ6fu8TDDKP6NXhhZQjrCjmrYStKT5Zc/FgtjPaOY5yBLbtC+7RtfJ/RRRYN10zzevSLNqFD06V95bPOJymfsU0=
X-Received: by 2002:a05:6102:408:b0:430:e0:ac2e with SMTP id
 d8-20020a056102040800b0043000e0ac2emr494897vsq.15.1686303318992; Fri, 09 Jun
 2023 02:35:18 -0700 (PDT)
MIME-Version: 1.0
References: <20230602162258.63853-1-andriy.shevchenko@linux.intel.com>
 <ZHoYzFPNrwwNpm93@smile.fi.intel.com> <ZHoaCGTHvAJAWro8@smile.fi.intel.com>
In-Reply-To: <ZHoaCGTHvAJAWro8@smile.fi.intel.com>
From:   Bartosz Golaszewski <brgl@bgdev.pl>
Date:   Fri, 9 Jun 2023 11:35:08 +0200
Message-ID: <CAMRc=Me+GnmrJH10sc9wCdsVpLnW-ksd4VjgHKPr8+v3K6jjPA@mail.gmail.com>
Subject: Re: [PATCH v1 1/1] gpiolib: Do not unexport GPIO on freeing
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
        linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        Linus Walleij <linus.walleij@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 2, 2023 at 6:34=E2=80=AFPM Andy Shevchenko
<andriy.shevchenko@linux.intel.com> wrote:
>
> On Fri, Jun 02, 2023 at 07:29:00PM +0300, Andy Shevchenko wrote:
> > On Fri, Jun 02, 2023 at 07:22:58PM +0300, Andy Shevchenko wrote:
> > > Since the legacy exporting is gone with 2f804aca4832 ("gpiolib:
> > > Kill unused GPIOF_EXPORT and Co") there is no need to unexport
> > > GPIO on freeing. Remove that call.
>
> > > Note, the other users of this functionality do that explicitly,
> > > except one SH boardfile which doesn't free GPIO anyways, so it
>
> Actually OMAP3 as well with the same idea, once requested those never fre=
ed.
> Bart, should I update the commit message?
>
> > > is safe to drop the call.
> >
> > Note, that this might be squashed with the above mentioned commit, beca=
use
> > I haven't checked current users I didn't do the removal in that patch.
> >
> > But this will probably needs rebase which is not good thing process wis=
e.
> > So, just my 2 cents in case.
>
> --
> With Best Regards,
> Andy Shevchenko
>
>

I did it myself when applying, thanks!

Bart
