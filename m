Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 790905B7B81
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Sep 2022 21:37:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229691AbiIMTgq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Sep 2022 15:36:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43770 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229575AbiIMTgU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Sep 2022 15:36:20 -0400
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com [IPv6:2a00:1450:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 862061582F
        for <linux-kernel@vger.kernel.org>; Tue, 13 Sep 2022 12:35:52 -0700 (PDT)
Received: by mail-ej1-x62c.google.com with SMTP id lc7so29966552ejb.0
        for <linux-kernel@vger.kernel.org>; Tue, 13 Sep 2022 12:35:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20210112.gappssmtp.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=DikkaX1eMP9ZVtNQsOxKO485i0cWxHC9sJM9iBVieQg=;
        b=iebLfzpnAgVgDTeo4FkMpYs7e95HeKgoigV5IQSjBEYajBXi8rdPfOAOzj/MCubfqX
         kA+mCudL+GqF06Qy6vqzDITflKDDQiadaEfHHLKrmP+y8jF8Z3Mh0EfiQltpL3q6IpF2
         x/a1bGH6rLutemLQ7E/9JgAYSJFRKYNri0Dn+R+DT2qIW57Xi20s4AhSMs2CFlgExAuN
         KFpUa88Wstu7S2RSvfCEoR0PJC5PBwZ5sWiJ1K8PBvPqEUOZIu30Xv6o8APiYg0NKoMx
         DNDFZQRbXQvgDYLMrcoOZa8+cD0we4WBXtAH9MS3Ulo6vnBPC3aIrnNDig7XnbyJI8pe
         Imyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=DikkaX1eMP9ZVtNQsOxKO485i0cWxHC9sJM9iBVieQg=;
        b=6QJg2g+sbFY6uBkE+NwEVGlNhiPptuxjXk/uA6fQIrP0LSI4fmx3BnF+eaHujYmQVd
         0H/gi8uLs1YwjnHz59jwr6mW7r/Fjm163eWOM3Qd2Rre0jdqFzHmMki8+akrzvPe2n1E
         vaRZObdB0b8xFI1/c7Nt4LymADc26i+XKnqH6W+W5tmHyG1v0zLJ+Wle9dCmB9cQmK7B
         PZfplCfNaeerjG/Y06MrzMqHoHHVDzUmmng0o4lsBRMrFVfvBCE/wFQ/AZQID1uZX35h
         sXqU9vm7b2H+DtEV0Mp3w7vMzTo+zFhoAAEBhbw3M/WZTxt7+uXqVEnNrubr9NYvOfiv
         /MbA==
X-Gm-Message-State: ACgBeo064gnkWwV8cuAMDDvCkL0CR9PRyd1qn94zsAfiJhPBrkyGTroT
        Pxir1o2r5EcdbuqYOeo0XEYmdiQKzFN/NMuBUY6OkQ==
X-Google-Smtp-Source: AA6agR5Dx66JzXZShCx+13MMFBYDINkWlVg0Gc9OyUfkHEFDlSjd9IQpuCLgUR25O4gxCSx46xqJzlfhQkIUfhw/li4=
X-Received: by 2002:a17:907:a079:b0:77b:8d9:9d9 with SMTP id
 ia25-20020a170907a07900b0077b08d909d9mr11600925ejc.697.1663097751070; Tue, 13
 Sep 2022 12:35:51 -0700 (PDT)
MIME-Version: 1.0
References: <CAMRc=Me46b+Fjz_AAbZZVbaELjY6NGVfNE6mwueiKRTpYe98rA@mail.gmail.com>
 <Yx8Bj0+4STpklMc2@sol> <CAMRc=Me=QxXRgZKyirj23r4hEN9bzcPSM6N4z=0yGgAZheh=Qg@mail.gmail.com>
 <Yx/nG5YsyCa+VXoj@sol> <CAMRc=MfoZQV-aHKSkAw6d_jPPbjn==oR0LA=irjuWLGzQiRP-w@mail.gmail.com>
 <YyCTmZocN/CY4Pg6@sol> <CAMRc=MdBRGW0skXOgPbZy=w4EiWcyKmKwKSZuAj+k4EtbPmvdg@mail.gmail.com>
 <YyCZ7TN8fyVyuWXY@sol> <CAMRc=MfyD5iyfB5f5hx_Kq4p7NZv+0o8HVOysiy6DaKANpGNKQ@mail.gmail.com>
 <YyCtI/WPngP9InsD@sol> <YyC4zq2YEmzQMkBL@smile.fi.intel.com>
In-Reply-To: <YyC4zq2YEmzQMkBL@smile.fi.intel.com>
From:   Bartosz Golaszewski <brgl@bgdev.pl>
Date:   Tue, 13 Sep 2022 21:35:40 +0200
Message-ID: <CAMRc=MfAF8cypMjp_G0L6VmBqED1Dc+Q3C-Ma4vCukL2pDZKpw@mail.gmail.com>
Subject: Re: [PATCH 2/2] gpiolib: cdev: export the consumer's PID
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Kent Gibson <warthog618@gmail.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 13, 2022 at 7:09 PM Andy Shevchenko
<andriy.shevchenko@linux.intel.com> wrote:
>
> On Wed, Sep 14, 2022 at 12:17:39AM +0800, Kent Gibson wrote:
> > On Tue, Sep 13, 2022 at 05:58:32PM +0200, Bartosz Golaszewski wrote:
> > > On Tue, Sep 13, 2022 at 4:55 PM Kent Gibson <warthog618@gmail.com> wrote:
>
> ...
>
> > > We'd need of course first expose that info like:
> > >
> > > gpio chip:gpiochip2 lines:0,3,4,7
> > >
> > > Does that make sense?
> >
> > Makes sense to me, though I don't claim to know anything about fdinfo
> > field formatting.
> >
> > e.g. I also see fdinfo fields like this:
> >
> > eventfd-count:                0
> > eventfd-id: 1
> >
> > so
> >
> > gpio-chip:  gpiochip2
> > gpio-lines: 0,3,4,7
> >
> > might be ok too.
>
> Always think about two or more GPIO chips in the same process with 1 or more
> lines requested from each of them.
>

That is fine because every file descriptor has its own fdinfo entry
and so one entry can only contain information about a single request.

Bart
