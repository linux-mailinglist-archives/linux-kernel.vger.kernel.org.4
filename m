Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5F77C5B7E14
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Sep 2022 03:01:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229738AbiINBBD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Sep 2022 21:01:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33346 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229487AbiINBBB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Sep 2022 21:01:01 -0400
Received: from mail-pf1-x433.google.com (mail-pf1-x433.google.com [IPv6:2607:f8b0:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E4B7C5789D;
        Tue, 13 Sep 2022 18:00:59 -0700 (PDT)
Received: by mail-pf1-x433.google.com with SMTP id y136so13358066pfb.3;
        Tue, 13 Sep 2022 18:00:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date;
        bh=pDWBwLNj3E614UwmbNJhUGAaW1RykjI2VArpUIowBvY=;
        b=fmOEtvrzwKZUBg/mi3MwcNaaU/EIbfckVjptNm+k29Y91shLw+v2EhUpEmE/3wjKK0
         g6TI0Co2TRmoOyWv2kZPYhMIz6A75PtomVGtAs0b89FjA6Qt4lNWX19yhR8AImPiVkaj
         QBx8dqfiQ/xskLo58u9cPppPbyyinpBo5LZ4QnJYpIrFIpWySzf3nhcNfYXUgedxMiRO
         WR9pIiIAQX8ZcKPryAoG+2e5mKCQdk0zV4B0tBdiQUKKaDgbFbV1qdc+r7mWejqiDoNr
         uWZ7pbgo5EfEy22s1mT+P2bGANxPI3hk6EOQ0iVkXegGBPN3ZagjXSyaZCphw7KF7Hr4
         me/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date;
        bh=pDWBwLNj3E614UwmbNJhUGAaW1RykjI2VArpUIowBvY=;
        b=Yj+ygC1n7fuse5hwplqahi1KJbkykqnBFHxMQqx6tEZ9rfdozXpdINVyjSwaO1VTy0
         zPv2yo6Bf4nOTVBhUYaIPA0Fku+XYqJo/FqHoX0NIMADDOrslSVZnszpOO8aHqGM4S5X
         geBfxgsUxI5I8dAjGqhrVcS43du2/NFJd5aeU6kd7ssnQtm0jKnf5iwqhHIvxpZ8C57J
         8fS5rIMGDcPFe4ZCakTRgYnDPNibYFX0UEjRZ3qngV8/nT+tKvJeN5MZg183BWgiSY/Y
         S9CHOV36NBt2/VUDnRXjlEtIKckRxKYCgOmOQ8YZln4736qesT2vAKjhhwPAGuC/DbH6
         8/8Q==
X-Gm-Message-State: ACgBeo1nckvKdplFkhPHO7euGWkaxaxVpPqZhGK0SdubDVzE3eIioT3+
        3QCUjKqzAUVQqbc30v79vJVQSRnm+xQ=
X-Google-Smtp-Source: AA6agR5qmXyyvxfORlgMqOEM7bdzD6wvyP+/SlS63tEh4McFsmfHezX+1ou7N1MoPRy1EOEoYnB1CA==
X-Received: by 2002:a63:5c62:0:b0:438:a981:1b27 with SMTP id n34-20020a635c62000000b00438a9811b27mr17582873pgm.443.1663117259354;
        Tue, 13 Sep 2022 18:00:59 -0700 (PDT)
Received: from sol (110-174-58-111.static.tpgi.com.au. [110.174.58.111])
        by smtp.gmail.com with ESMTPSA id x8-20020a170902a38800b00176c891c893sm9153424pla.131.2022.09.13.18.00.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Sep 2022 18:00:58 -0700 (PDT)
Date:   Wed, 14 Sep 2022 09:00:53 +0800
From:   Kent Gibson <warthog618@gmail.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Bartosz Golaszewski <brgl@bgdev.pl>,
        Linus Walleij <linus.walleij@linaro.org>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] gpiolib: cdev: export the consumer's PID
Message-ID: <YyEnxeWxv2qV7JKI@sol>
References: <Yx8Bj0+4STpklMc2@sol>
 <CAMRc=Me=QxXRgZKyirj23r4hEN9bzcPSM6N4z=0yGgAZheh=Qg@mail.gmail.com>
 <Yx/nG5YsyCa+VXoj@sol>
 <CAMRc=MfoZQV-aHKSkAw6d_jPPbjn==oR0LA=irjuWLGzQiRP-w@mail.gmail.com>
 <YyCTmZocN/CY4Pg6@sol>
 <CAMRc=MdBRGW0skXOgPbZy=w4EiWcyKmKwKSZuAj+k4EtbPmvdg@mail.gmail.com>
 <YyCZ7TN8fyVyuWXY@sol>
 <CAMRc=MfyD5iyfB5f5hx_Kq4p7NZv+0o8HVOysiy6DaKANpGNKQ@mail.gmail.com>
 <YyCtI/WPngP9InsD@sol>
 <YyC4zq2YEmzQMkBL@smile.fi.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YyC4zq2YEmzQMkBL@smile.fi.intel.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 13, 2022 at 08:07:26PM +0300, Andy Shevchenko wrote:
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

I considered that - as Bart noted and as I stated earlier, each request fd
is limited to one gpiochip and one set of offsets. And those are fixed
for the lifetime of the request.
Different requests will be different fds.

But on the subject of repeats in fdinfo, I get the impression that
multi-field fdinfo rows, e.g. the tfd rows here:

pos:	0
flags:	02000002
mnt_id:	14
ino:	7661
tfd:       12 events:       19 data:                c  pos:0 ino:1ded sdev:d
tfd:       14 events:       19 data:                e  pos:0 ino:1ded sdev:d

are formatted that way as they may be repeated, so they are getting all
their ducks in a row, as it were.

So perhaps the gpio-lines could be exploded into repeated gpio-line rows?
That may be going overboard as we are only encoding one field per line
at the moment, not a struct as in the tfd case, but might we ever want
to add more details?

Again, just speculating based on the few examples I have on hand.

Cheers,
Kent.
