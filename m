Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AFCE9642959
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Dec 2022 14:27:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232248AbiLEN1t (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Dec 2022 08:27:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51664 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231599AbiLEN1q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Dec 2022 08:27:46 -0500
Received: from mail-vs1-xe2c.google.com (mail-vs1-xe2c.google.com [IPv6:2607:f8b0:4864:20::e2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D2652263C
        for <linux-kernel@vger.kernel.org>; Mon,  5 Dec 2022 05:27:43 -0800 (PST)
Received: by mail-vs1-xe2c.google.com with SMTP id h26so1979011vsr.5
        for <linux-kernel@vger.kernel.org>; Mon, 05 Dec 2022 05:27:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20210112.gappssmtp.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=BWHrd3aLhgiG+UaB7zepCdXrcCvVH/+UbuBW6Y4vPms=;
        b=oQaqYktN4GfhVf6d4AhOUfJBWdgUz4tAneBabWPCmF5z2H9n3CKigTPgxfAgMzJsIc
         U7gdvKqweprQ//B0jNc21O0y0vfKA7F1YXPOnDYCwdl92RRDTYjVtEgfdjxmg3j7c7YV
         /RBZ2xO4hHr6btntRxN6YDaQVAMeV2yYqe7tSuhpeCD0gsLbs6v0gHdenT867wxHgcHd
         tu3Q4758DeSfblHE/0w6pIsavo0AVmO8P0Np5u/vL+Wvfc/ciCys22PjV8ndvKvWR/3m
         M1JYrJri5xu1WTYXcR9nWWJwOOlD7qQF33G4BKjf6etIEuntKVgD7WU8g9Est1M5dwRO
         zd7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=BWHrd3aLhgiG+UaB7zepCdXrcCvVH/+UbuBW6Y4vPms=;
        b=Z5RcrXq14R+gijHQ4aOpGx3L7ZJ6XxwPjCodErKdMVN37TnFpkYxvEIFmvBu5sGaTX
         uw0irbp256j+JtiG2gk92HIYe0klAavQmqG/EeGw9cRUGguVrkzalRfSPVpJT65rnWt8
         LeDDJJ55upEV/TEkQR85qbQ7xyeqRcY5zM1BtSYD3aLIugcJhiDn8gDbP2tFUDC2iYOc
         XJRC9Wv4wzsWYy0HJ9gIPRU4X1mHhZQOAEAsVuLQGNowoUD62b77/d717e1FYuz5kRdI
         WyUIfpuucGv2gzRhzNU/+daMi3SkPkP6BmKV8vYWCLi0FynR0lUO0M94z0wI6IHODEL+
         ipFA==
X-Gm-Message-State: ANoB5pmpCXHb76AyP70cZRoCF5eJdLhR12E9gqQrJoV12zik38QzI3NZ
        IB6EOQ8hDQJjpKJcWIAIGr+iJ3k3D0MdXQT9AfOl3XKuR4eErg==
X-Google-Smtp-Source: AA0mqf5A4j7MgpGLkC3roqQQoGqGMJqzd2JWHpfvBJdQpbm0KVMQ3bcwRnlZNug9SoQuKy3j9YKfb7jMFBNmx8VPeH8=
X-Received: by 2002:a67:ca86:0:b0:3b1:33bd:7fc7 with SMTP id
 a6-20020a67ca86000000b003b133bd7fc7mr3453591vsl.13.1670246862914; Mon, 05 Dec
 2022 05:27:42 -0800 (PST)
MIME-Version: 1.0
References: <20221205123903.159838-1-brgl@bgdev.pl> <Y43rPdus/9INC390@smile.fi.intel.com>
 <Y43rmRW1S8PvMJW4@smile.fi.intel.com> <Y43vgFY+qnqH8+0P@sol>
In-Reply-To: <Y43vgFY+qnqH8+0P@sol>
From:   Bartosz Golaszewski <brgl@bgdev.pl>
Date:   Mon, 5 Dec 2022 14:27:32 +0100
Message-ID: <CAMRc=MeMA+11Gdb2kaCrS5G+05PONT7i9Nw0VH+B7bJA3apydw@mail.gmail.com>
Subject: Re: [PATCH v8 0/2] gpiolib: don't allow user-space to crash the
 kernel with hot-unplugs
To:     Kent Gibson <warthog618@gmail.com>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Nick Hainke <vincent@systemli.org>, linux-gpio@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 5, 2022 at 2:17 PM Kent Gibson <warthog618@gmail.com> wrote:
>
> On Mon, Dec 05, 2022 at 03:01:13PM +0200, Andy Shevchenko wrote:
> > On Mon, Dec 05, 2022 at 02:59:42PM +0200, Andy Shevchenko wrote:
> > > On Mon, Dec 05, 2022 at 01:39:01PM +0100, Bartosz Golaszewski wrote:
> > > > From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> > > >
> > > > Linus Torvalds pointed out that using trylock here is wrong. This iteration
> > > > drops it in favor of unconditional locks but keeps all the fixes that came
> > > > later.
> > > >
> > > > I will also not send it for this release but make it part of the updates PR
> > > > for v6.2 to give it some time in next.
> > > >
> > > > v7 -> v8:
> > > > - don't use down_read_trylock(), just go straight for a full lock
> > >
> > > Yep, it was a good wrap-up explanation.
> >
> > But he also suggested to fold NULL check into call_*_locked(). Any points why
> > you decided not to go that way?
> >
>
> He also mentioned making it more back-portable.
> Does that mean splitting out the patches for uAPI v1 and v2, if not for
> each of the Fixes? Or does he mean back-porting it to 6.1?

I think he mentioned not sending it for v6.1 that late in the cycle
and instead sending it for v6.2 and backporting it to v6.1. I'm afraid
that backporting of this fix will require some manual labor anyway.
We'll want to backport it to branches that don't have v2 yet after
all, where that code resided elsewhere.

Bartosz
