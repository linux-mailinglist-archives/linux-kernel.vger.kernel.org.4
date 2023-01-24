Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2E06667947E
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Jan 2023 10:47:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233634AbjAXJrP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Jan 2023 04:47:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39314 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233097AbjAXJrM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Jan 2023 04:47:12 -0500
Received: from mail-qk1-x735.google.com (mail-qk1-x735.google.com [IPv6:2607:f8b0:4864:20::735])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DDD5D298DE;
        Tue, 24 Jan 2023 01:47:11 -0800 (PST)
Received: by mail-qk1-x735.google.com with SMTP id f23so5457877qkg.1;
        Tue, 24 Jan 2023 01:47:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=GBWXb8Qu133qoYYF1PqkNFWZ6siJCHp1ub01xgs3xcc=;
        b=PWHFiaKKRa0MKA9n2tn92Vj7RSj/T505GaIWy1hjJ1lQZY+U8ZCA29oZnQXBhzE8Yf
         mDk8tTazWk5WxuZnl4MOdlT1J95DZuAsVynlEJ4vAFrNTpgqVC3/9qf/cR4Lb37UtqSl
         gbA64OEZ9Tkol54ToNhbUCTIHArKEFgCUIywA2pBNuqEQImw04KVMg1sbLrfHvXjsCM1
         Y1zDshUIDll+r2uqYWDAi9IwGy9C4jRRGcT4bKdM6USjYStdUgqGqRIhtGQATFdgw2pi
         VWrJp6L0DVktiGAC+InCUVrKvxt4ucq7ZG8Dq0jIcModvH63Xi9hJ+I7Mky2OL+4jUtu
         GeJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=GBWXb8Qu133qoYYF1PqkNFWZ6siJCHp1ub01xgs3xcc=;
        b=dwUGmQR1xS8qINQ54ZPkeig7+ZYhyf9tKWM1KXR/xZvGx2QGB4gUlzNBsULWs9XcSD
         i2jucmppImsniFtnUA712Qrw53sSsVOve6S8lFBhbM5vGh7NWG4qy5JKF6ROjuAEdqEO
         B5zmprfBeCKwPSCnUbWIKsNHhBRBcSLUIK4qkCCNKAgJjWcHhA9J/AoOJ/ftu1CsLN2H
         7crJZvPcCkF2J5qv25fq44AWvgZ0qSjBNWM0upOcRKWLYDxPj18La9V9TKayvTYXjA3W
         ffz1WlaxeimtOet2973RZvEufX+j/pmt58jnl71NFgm+3rlWRbDLBAAHiyTvuAGRISNa
         EFnQ==
X-Gm-Message-State: AFqh2kr1/kXFhLcCYSPSM7RDrbjL91yPJLNrUukibAGCx19hFmrgWIhS
        sthyzLGEkHv4M0gCI36++S5BuFEsWR+SWj8JegIxIkM2MqU=
X-Google-Smtp-Source: AMrXdXuv9aInX+jRdl99IwDJbzxZ2OyQqq3lu1Jih8JW9aFVLHmHk14oalsuXXLvUBcztV/Cr+I8OqNHtqsYLUb4guM=
X-Received: by 2002:a05:620a:e:b0:705:c63f:1fa8 with SMTP id
 j14-20020a05620a000e00b00705c63f1fa8mr1671527qki.504.1674553630860; Tue, 24
 Jan 2023 01:47:10 -0800 (PST)
MIME-Version: 1.0
References: <20221007153323.1326-1-henning.schild@siemens.com>
 <Y8mv8PzL1UsP9gNh@google.com> <20230123214859.725cd1c3@md1za8fc.ad001.siemens.net>
In-Reply-To: <20230123214859.725cd1c3@md1za8fc.ad001.siemens.net>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Tue, 24 Jan 2023 11:46:34 +0200
Message-ID: <CAHp75VfSHgdikX5=Qba62BwWofVf7gHhS2hq2OuBwHFz9riCWQ@mail.gmail.com>
Subject: Re: [PATCH v4] leds: simatic-ipc-leds-gpio: make sure we have the
 GPIO providing driver
To:     Henning Schild <henning.schild@siemens.com>
Cc:     Lee Jones <lee@kernel.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Pavel Machek <pavel@ucw.cz>, linux-leds@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 23, 2023 at 10:49 PM Henning Schild
<henning.schild@siemens.com> wrote:
> Am Thu, 19 Jan 2023 21:02:40 +0000
> schrieb Lee Jones <lee@kernel.org>:
> > On Fri, 07 Oct 2022, Henning Schild wrote:

> > > If we register a "leds-gpio" platform device for GPIO pins that do
> > > not exist we get a -EPROBE_DEFER and the probe will be tried again
> > > later. If there is no driver to provide that pin we will poll
> > > forever and also create a lot of log messages.
> > >
> > > So check if that GPIO driver is configured, if so it will come up
> > > eventually. If not, we exit our probe function early and do not even
> > > bother registering the "leds-gpio". This method was chosen over
> > > "Kconfig depends" since this way we can add support for more
> > > devices and GPIO backends more easily without "depends":ing on all
> > > GPIO backends.
> > >
> > > Fixes: a6c80bec3c93 ("leds: simatic-ipc-leds-gpio: Add GPIO version
> > > of Siemens driver") Reviewed-by: Andy Shevchenko
> > > <andy.shevchenko@gmail.com> Signed-off-by: Henning Schild
> > > <henning.schild@siemens.com> ---
> > >  drivers/leds/simple/simatic-ipc-leds-gpio.c | 2 ++
> > >  1 file changed, 2 insertions(+)
> >
> > FYI: I'm going to try my best not to take another one like this.
>
> understood!
>
> > Please try to improve the whole situation for you next submission.
>
> When i have to touch this again, which i will, i will propose either
> "depend on all possible GPIO drivers" or introduce "#ifdef CONFIG"s.
> Caring most about big configs as seen in distros like debian, even for
> embedded systems ... i think i would prefer the first option, as it
> will also be easier to maintain.
>
> I do not see the whole infinite loop story on my plate, but if that got
> fixed i would follow up taking the fix into account.

AFAICS another possible (not sure if it's preferable) solution is to
split this driver to subdrivers and each of them will be dependent on
the corresponding pin control in Kconfig. It will satisfy both of your
requirements, right? Something like

simatic-leds-core.c
simatic-leds-127e.c (config ..._127E depends on PINCTRL_BROXTON)
...

-- 
With Best Regards,
Andy Shevchenko
