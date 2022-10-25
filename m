Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EFC7860D0F7
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Oct 2022 17:48:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232463AbiJYPsQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Oct 2022 11:48:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59236 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231836AbiJYPsO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Oct 2022 11:48:14 -0400
Received: from mail-vs1-xe2d.google.com (mail-vs1-xe2d.google.com [IPv6:2607:f8b0:4864:20::e2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB04714BB51
        for <linux-kernel@vger.kernel.org>; Tue, 25 Oct 2022 08:48:13 -0700 (PDT)
Received: by mail-vs1-xe2d.google.com with SMTP id 1so11387214vsx.1
        for <linux-kernel@vger.kernel.org>; Tue, 25 Oct 2022 08:48:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20210112.gappssmtp.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=DRklvTSahTsKtUv05Ip6fTYXC/GiTk1gTx2Lpsmla4g=;
        b=et3zIUNtsRafG/x6jhertmWMocfgIbsDsG6SuZQVTS+0lhlV/dEk5ju0yz2311v3y1
         bmZ7KQJC3YJAR8XlimIvrthFbhbMojRQi7AbML3RsjoAp0YFtyyMwFezdGd7q6KV+S8W
         CpH7GmHRHFtWO93cznf8+PigdrXNDehDYEEAZW4P1jXHLW0lkKrwkdzRQEA9xqbYSJUu
         mnYa39ce/5RC9Nj76FpJBOfQuL9QXpIgtjEAUQIehxThxEilqiqvU4CsSuFOwhoCU4ce
         nzM2XnwceHXWO3/NgOT8d+paexguBqwHWk1RASH/3j2eGgXTmt716TquLKJaWjMwo9uY
         0J0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=DRklvTSahTsKtUv05Ip6fTYXC/GiTk1gTx2Lpsmla4g=;
        b=onQ9rbJrHDkchxULKinM7AkoUlQde6IfgYY1gR080lfq3f1ThoICEp2AtVcqyxtDGA
         7yrHa300X6RCNeJurGsvjUtz6k5sJCCaQykIhNqvmVKcPIdiz8e4WljzQlK77m8medtY
         ixBSopG60p9MbU5si36dGWy52lxu1hnaXuxLjBClghpzV+48bqd3kesiWlJDQC4whyoG
         CxSKMaf5HW1Qug8ebx3Z1HC/k4OtS1/R78xk/2ZGnLSimIkiA7Aeegbu19DBqsp7nHbT
         qzoXKJpxXhGSHnuNjXiv5+kpBQLp/0pVbxfIOsqA8yBGsnTDVgz5ibp+FruppNVlsJRK
         Ps9g==
X-Gm-Message-State: ACrzQf1UyLqNfKWqLP4M5+qizlnA9SMx+pHFTTEHmpCb4TcAi8cmhsoH
        VIdlf4dcF2UNusB4zl3BN+kBFhaQ7//2hRS45FDH/Q==
X-Google-Smtp-Source: AMsMyM6BXcmeI5Sp/cpJEziPSJp66D3AaV6wCyDtZq/noXvDUWVjfO9d4hV13GHO3gCutl/S7eeBIMtMWepWhj4tduA=
X-Received: by 2002:a67:ac0c:0:b0:3a9:e899:3b9b with SMTP id
 v12-20020a67ac0c000000b003a9e8993b9bmr16130296vse.9.1666712892973; Tue, 25
 Oct 2022 08:48:12 -0700 (PDT)
MIME-Version: 1.0
References: <20220902-get_gpiod_from_child-remove-v1-0-1e47125df20f@gmail.com>
 <YyzYKmsjKflqT1xZ@google.com> <Y1aCgJihNIqExUR2@google.com>
In-Reply-To: <Y1aCgJihNIqExUR2@google.com>
From:   Bartosz Golaszewski <brgl@bgdev.pl>
Date:   Tue, 25 Oct 2022 17:48:02 +0200
Message-ID: <CAMRc=McvJ7AvhKdP7cv8K1+rzMf8-ptg2SnU+XOAwERhRx1Eyw@mail.gmail.com>
Subject: Re: [PATCH v1 0/3] Get rid of devm_fwnode_get_[index_]gpiod_from_child()
To:     Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Pavel Machek <pavel@ucw.cz>,
        =?UTF-8?B?TWFyZWsgQmVow7pu?= <kabel@kernel.org>,
        linux-leds@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-gpio@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 24, 2022 at 2:18 PM Dmitry Torokhov
<dmitry.torokhov@gmail.com> wrote:
>
> On Thu, Sep 22, 2022 at 02:48:26PM -0700, Dmitry Torokhov wrote:
> > Hi Pavel, Marek,
> >
> > On Fri, Sep 02, 2022 at 05:55:24PM -0700, Dmitry Torokhov wrote:
> > > This drops the last uses of devm_fwnode_get_[index_]gpiod_from_child()
> > > from the tree and drops the stubs implementing this API on top of
> > > devm_fwnode_gpiod_get_index().
> > >
> > > Note that the bulk of users were converted in 2019, the couple of LED
> > > drivers are all that have remained.
> > >
> > > Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
> > >
> > > ---
> > > Dmitry Torokhov (3):
> > >       leds: gpio: switch to using devm_fwnode_gpiod_get()
> > >       leds: lgm-sso: switch to using devm_fwnode_gpiod_get()
> > >       gpiolib: remove devm_fwnode_get_[index_]gpiod_from_child()
> > >
> > >  drivers/leds/blink/leds-lgm-sso.c |  5 ++---
> > >  drivers/leds/leds-gpio.c          |  5 ++---
> > >  include/linux/gpio/consumer.h     | 21 ---------------------
> > >  3 files changed, 4 insertions(+), 27 deletions(-)
> > > ---
> > > base-commit: 7fd22855300e693668c3397771b3a2b3948f827a
> > > change-id: 20220902-get_gpiod_from_child-remove-a62638849e91
> > >
> >
> > Could you please consider picking this up for 6.1? Or would you be OK
> > with this going through other tree (GPIO maybe)?
>
> *ping* Could this go through GPIO tree? Dropping this API helps with
> some outstanding work that I have...
>

Sure! I'll let it wait for another week - it would be great to get an
ack from Pavel - but in case of no response I'll take it through my
tree.

Bart
