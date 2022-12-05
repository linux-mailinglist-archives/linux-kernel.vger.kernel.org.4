Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9E582642A93
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Dec 2022 15:46:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232016AbiLEOqM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Dec 2022 09:46:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49626 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231516AbiLEOqJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Dec 2022 09:46:09 -0500
Received: from mail-qt1-f172.google.com (mail-qt1-f172.google.com [209.85.160.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 891191B1EC;
        Mon,  5 Dec 2022 06:46:06 -0800 (PST)
Received: by mail-qt1-f172.google.com with SMTP id jr1so11514357qtb.7;
        Mon, 05 Dec 2022 06:46:06 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=mmxDQWz1OcZRQLIrCnyf8KKp2sa+/PYHinAmiEwEu/g=;
        b=FM99B8CouUiddxogTCWpQuQ94b0HLoazU4Kp7W8pEEJZicQYzgBYs1cVLlJU83NILW
         6mwhnnDFNWV0qk3qzQk0h9quqR99lVlByWUXSYuKYa5Ch8m1ShgHb+MVltQICFJ0zXGQ
         IfmYiyRVe7YUSeqF3zL7XavktRG6itll/9JGcf/ut7jHysJwfwCU9ovYFWvNT5+aNtlP
         0bUsFUmfWI4ZvHWKe7TpQYF73oGI+SUPyAIujcFUbBYUOFaRKdB4mYPBLU7e0VAjbcqJ
         H/KfTZPi2BnSnPwK4UydHFHdv39SqFv2bC0VwRkHc7ckMP95OkMwQXSlaZw4BGQsZXbE
         mw9Q==
X-Gm-Message-State: ANoB5pktNt07pTn5oru8uzdHnMviiCjimcT0M3VIw7n/RQAfahN/1PSN
        sEjwgWotNlkz6V0VG+vFpFy2NKAhpvCkxAC9MSs=
X-Google-Smtp-Source: AA0mqf7DDT4tYCBIU2TNsN3S/z4/mO02Nkn32IClzk+wQYzJ5Daq4v+49NfbxXpuawqkSFlin+aDhwiCk8lCFtWBOJU=
X-Received: by 2002:a05:622a:410a:b0:3a5:5987:42c6 with SMTP id
 cc10-20020a05622a410a00b003a5598742c6mr76491917qtb.147.1670251565666; Mon, 05
 Dec 2022 06:46:05 -0800 (PST)
MIME-Version: 1.0
References: <5627469.DvuYhMxLoT@kreacher> <4789678.31r3eYUQgx@kreacher> <cea65857-071f-e68e-9825-b88d64eeca81@intel.com>
In-Reply-To: <cea65857-071f-e68e-9825-b88d64eeca81@intel.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Mon, 5 Dec 2022 15:45:54 +0100
Message-ID: <CAJZ5v0hsT3j=DBcV6nwG1AMKDu7QiO=FoQhNOC6GFVAC46uMtw@mail.gmail.com>
Subject: Re: [PATCH v1 1/2] PM: runtime: Do not call __rpm_callback() from rpm_idle()
To:     Adrian Hunter <adrian.hunter@intel.com>
Cc:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Linux PM <linux-pm@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Tushar Nimkar <quic_tnimkar@quicinc.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Nitin Rawat <quic_nitirawa@quicinc.com>,
        Peter Wang <peter.wang@mediatek.com>,
        Alan Stern <stern@rowland.harvard.edu>,
        Ulf Hansson <ulf.hansson@linaro.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 5, 2022 at 8:45 AM Adrian Hunter <adrian.hunter@intel.com> wrote:
>
> On 2/12/22 16:30, Rafael J. Wysocki wrote:
> > From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> >
> > Calling __rpm_callback() from rpm_idle() after adding device links
> > support to the former is a clear mistake.
> >
> > Not only it causes rpm_idle() to carry out unnecessary actions, but it
> > is also against the assumption regarding the stability of PM-runtime
> > status accross __rpm_callback() invocations, because rpm_suspend() and
>
> accross -> across

Fixed whey applying the patch.

> > rpm_resume() may run in parallel with __rpm_callback() when it is called
> > by rpm_idle() and the device's PM-runtime status can be updated by any
> > of them.
> >
> > Fixes: 21d5c57b3726 ("PM / runtime: Use device links")
>
> Reviewed-by: Adrian Hunter <adrian.hunter@intel.com>

Thank you!

> > Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> > ---
> >  drivers/base/power/runtime.c |   12 +++++++++++-
> >  1 file changed, 11 insertions(+), 1 deletion(-)
> >
> > Index: linux-pm/drivers/base/power/runtime.c
> > ===================================================================
> > --- linux-pm.orig/drivers/base/power/runtime.c
> > +++ linux-pm/drivers/base/power/runtime.c
> > @@ -484,7 +484,17 @@ static int rpm_idle(struct device *dev,
> >
> >       dev->power.idle_notification = true;
> >
> > -     retval = __rpm_callback(callback, dev);
> > +     if (dev->power.irq_safe)
> > +             spin_unlock(&dev->power.lock);
> > +     else
> > +             spin_unlock_irq(&dev->power.lock);
> > +
> > +     retval = callback(dev);
> > +
> > +     if (dev->power.irq_safe)
> > +             spin_lock(&dev->power.lock);
> > +     else
> > +             spin_lock_irq(&dev->power.lock);
> >
> >       dev->power.idle_notification = false;
> >       wake_up_all(&dev->power.wait_queue);
> >
> >
> >
>
