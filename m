Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5DCF1621201
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Nov 2022 14:09:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234298AbiKHNJX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Nov 2022 08:09:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51506 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233603AbiKHNJV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Nov 2022 08:09:21 -0500
Received: from mail-qk1-f180.google.com (mail-qk1-f180.google.com [209.85.222.180])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 90B291B9E3;
        Tue,  8 Nov 2022 05:09:20 -0800 (PST)
Received: by mail-qk1-f180.google.com with SMTP id p18so4452436qkg.2;
        Tue, 08 Nov 2022 05:09:20 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=tp5OMnbOjRDcClttdvcSBeqhMkw9nAZs4zoixrpu0Ao=;
        b=5JbFpnFsykVdYy1yIEdjFcPNjjbTPdP4tVr+X3hsZ0t3lEBfh3BDgoRcctT6ygnE3C
         GIvTKxuYO8ni/5ekA8Y5ytu1A/jZTH37LGDd1LQg3fGlPYwHX0/S2gmE3B8rZXg4KI3G
         qW4IKFBMkujpRNOyk7XS8PJTKLB9291oy+aFUF1nE9/ZWxyCgnUTGfDPPYY1L00bZ1am
         PQBTQhxB6lOextBrYP4Pv1gDOtX2GPGuD4557Fwat6SjtHxHXjyx9bZSTyIUXa7nl5cP
         VHNgcVMOCHf9htBPFpoQIWrF+g5qVLiWTvyezZQ/Q1dMCO7T7Khuw8LwHjN1QPyOyWkq
         pWFw==
X-Gm-Message-State: ACrzQf0QiSC0sWKCzracyMFLZSUZDKqwfPQgKnuK7CaxRmCIyGlbe04q
        VFawEYLEDookkaNkEKinsHnqkmhG9+iYdCeXH+k=
X-Google-Smtp-Source: AMsMyM7+IhXIk2o4MVZnaGbRer32KZO8HPffRRWa5txMjuW5kyjpco5GjzuVGiYEwwl98+vbuAF9Wuc/hiMSDY8JAAI=
X-Received: by 2002:a05:620a:d89:b0:6cf:c98b:744c with SMTP id
 q9-20020a05620a0d8900b006cfc98b744cmr38198402qkl.443.1667912959715; Tue, 08
 Nov 2022 05:09:19 -0800 (PST)
MIME-Version: 1.0
References: <2276401.ElGaqSPkdT@kreacher> <1850290.tdWV9SEqCh@kreacher> <b369e6d44b01e0ccc653e333bc2def556b17bbb3.camel@intel.com>
In-Reply-To: <b369e6d44b01e0ccc653e333bc2def556b17bbb3.camel@intel.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Tue, 8 Nov 2022 14:09:07 +0100
Message-ID: <CAJZ5v0gavPhs5wqhE0VOrhydbqVgC4BSRxN-aGPmAP2a2k_WhA@mail.gmail.com>
Subject: Re: [PATCH v1 1/5] rtc: rtc-cmos: Call cmos_wake_setup() from cmos_do_probe()
To:     Zhang Rui <rui.zhang@intel.com>
Cc:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        linux-rtc@vger.kernel.org, Linux ACPI <linux-acpi@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        Alessandro Zummo <a.zummo@towertech.it>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 8, 2022 at 3:31 AM Zhang Rui <rui.zhang@intel.com> wrote:
>
> On Mon, 2022-11-07 at 20:59 +0100, Rafael J. Wysocki wrote:
> > From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> >
> > Notice that cmos_wake_setup() is the only user of acpi_rtc_info and
> > it
> > can operate on the cmos_rtc variable directly, so it need not set the
> > platform_data pointer before cmos_do_probe() is called.  Instead, it
> > can be called by cmos_do_probe() in the case when the platform_data
> > pointer is not set to implement the default behavior (which is to use
> > the FADT information as long as ACPI support is enabled).
> >
>
> ...
>
> >
> > @@ -827,19 +829,27 @@ cmos_do_probe(struct device *dev, struct
> >               if (info->address_space)
> >                       address_space = info->address_space;
> >
> > -             if (info->rtc_day_alarm && info->rtc_day_alarm < 128)
> > -                     cmos_rtc.day_alrm = info->rtc_day_alarm;
> > -             if (info->rtc_mon_alarm && info->rtc_mon_alarm < 128)
> > -                     cmos_rtc.mon_alrm = info->rtc_mon_alarm;
> > -             if (info->rtc_century && info->rtc_century < 128)
> > -                     cmos_rtc.century = info->rtc_century;
> > +             cmos_rtc.day_alrm = info->rtc_day_alarm;
> > +             cmos_rtc.mon_alrm = info->rtc_mon_alarm;
> > +             cmos_rtc.century = info->rtc_century;
> >
> >               if (info->wake_on && info->wake_off) {
> >                       cmos_rtc.wake_on = info->wake_on;
> >                       cmos_rtc.wake_off = info->wake_off;
> >               }
> > +     } else {
> > +             cmos_wake_setup(dev);
> >       }
> >
> >
>
> Previously, before commit a474aaedac99 ("rtc-cmos: move wake setup from
> ACPI glue into RTC driver"), dev->platform_data is set in
> drivers/acpi/glue.c, and the above commit moves it to cmos_wake_setup()
> in this file.
>
> Now, with this patch, my understanding is that dev->platform_data is
> never set, thus we can remove the 'info' variable and the
>         if (info)
> check above.

There are other users of this driver which can be found by grepping
for cmos_rtc_board_info.

They create platform device objects with platform_data set which are
then bound to by this driver.
