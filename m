Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9137D64282B
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Dec 2022 13:13:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231671AbiLEMNi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Dec 2022 07:13:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50112 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230306AbiLEMNg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Dec 2022 07:13:36 -0500
Received: from mail-qk1-f171.google.com (mail-qk1-f171.google.com [209.85.222.171])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A014EAA;
        Mon,  5 Dec 2022 04:13:35 -0800 (PST)
Received: by mail-qk1-f171.google.com with SMTP id z1so4733849qkl.9;
        Mon, 05 Dec 2022 04:13:35 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=eHdyoJWg5eG6rs658NAInWWGVgURCxiUmVnybR6Jh4s=;
        b=DfXGUaSp9nr4uv4pJ5yp+SzA506DocGivsPxiaudL0zaXs6MGBcJEV5gRJ8TNbzfOe
         ceEkurlxaKil6K4JRZNn6AJSLGM/7AFA745+dnVNv4Kx26IhYZsaDVQiFWpMlPE+YQ8O
         ncMlB0WGiLTBXvwpRGjqq+WjnLcnqU4cb93eRE7r90iJZvaZKraMl5I+1jj1qyGfQahU
         HvgXXG6uJ5+Ypgt2k4iopFLLDe0IcCUxDwy8OLHTc0+tyfydyBQ1WRlifH95E2fqnWQD
         Q5k7LkEPxu6y5RcIlBNx11mLPmq1Wn7giQ8TTsYH4ZUM5eh0bZZsuMTAb/0OiXU1tcdt
         5A/w==
X-Gm-Message-State: ANoB5plcpxkbbZNTLYZ7cM6sHplKesw9/ymo7eUc7r3epxudIax33lvZ
        i7HGgRYJeQa6pyCp8LfcY945rA1x9F9586qRlp4=
X-Google-Smtp-Source: AA0mqf5bhqXHGFp6uGZlvRF4UDs3tG353SxBZ3dcUhRUzMCx5wlbrPZ3IKslDTVbUvTdFKnddlzjeu0bcsui8wmA3SA=
X-Received: by 2002:a05:620a:51ca:b0:6ec:fa04:d97c with SMTP id
 cx10-20020a05620a51ca00b006ecfa04d97cmr55214682qkb.764.1670242414772; Mon, 05
 Dec 2022 04:13:34 -0800 (PST)
MIME-Version: 1.0
References: <5627469.DvuYhMxLoT@kreacher> <4789678.31r3eYUQgx@kreacher> <CAPDyKFqu9-=L9B-Vkzqom6akVpim0R2_DPj__3t3dp9Y_oUEEg@mail.gmail.com>
In-Reply-To: <CAPDyKFqu9-=L9B-Vkzqom6akVpim0R2_DPj__3t3dp9Y_oUEEg@mail.gmail.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Mon, 5 Dec 2022 13:13:20 +0100
Message-ID: <CAJZ5v0jWBREsP4UN98+d8f35zDNA3PwisAxZDq03mZ1JkAg1ww@mail.gmail.com>
Subject: Re: [PATCH v1 1/2] PM: runtime: Do not call __rpm_callback() from rpm_idle()
To:     Ulf Hansson <ulf.hansson@linaro.org>
Cc:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Linux PM <linux-pm@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Tushar Nimkar <quic_tnimkar@quicinc.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Nitin Rawat <quic_nitirawa@quicinc.com>,
        Peter Wang <peter.wang@mediatek.com>,
        Alan Stern <stern@rowland.harvard.edu>
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

On Mon, Dec 5, 2022 at 1:08 PM Ulf Hansson <ulf.hansson@linaro.org> wrote:
>
> On Fri, 2 Dec 2022 at 15:32, Rafael J. Wysocki <rjw@rjwysocki.net> wrote:
> >
> > From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> >
> > Calling __rpm_callback() from rpm_idle() after adding device links
> > support to the former is a clear mistake.
> >
> > Not only it causes rpm_idle() to carry out unnecessary actions, but it
> > is also against the assumption regarding the stability of PM-runtime
> > status accross __rpm_callback() invocations, because rpm_suspend() and
> > rpm_resume() may run in parallel with __rpm_callback() when it is called
> > by rpm_idle() and the device's PM-runtime status can be updated by any
> > of them.
>
> Urgh, that's a nasty bug you are fixing here. Is there perhaps some
> links to some error reports that can make sense to include here?

There is a bug report, but I have no confirmation that this fix is
sufficient to address it (even though I'm quite confident that it will
be).

> >
> > Fixes: 21d5c57b3726 ("PM / runtime: Use device links")
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
> >         dev->power.idle_notification = true;
> >
> > -       retval = __rpm_callback(callback, dev);
>
> Couldn't we just extend __rpm_callback() to take another in-parameter,
> rather than open-coding the below?

I'd rather not do that.

I'd prefer rpm_callback() to be used only in rpm_suspend() and
rpm_resume() where all of the assumptions hold and rpm_idle() really
is a special case.

And there is not much open-coding here, just the locking part.

> Note that, __rpm_callback() already uses a "bool use_links" internal
> variable, that indicates whether the device links should be used or
> not.

Yes, it does, but why does that matter?

> > +       if (dev->power.irq_safe)
> > +               spin_unlock(&dev->power.lock);
> > +       else
> > +               spin_unlock_irq(&dev->power.lock);
> > +
> > +       retval = callback(dev);
> > +
> > +       if (dev->power.irq_safe)
> > +               spin_lock(&dev->power.lock);
> > +       else
> > +               spin_lock_irq(&dev->power.lock);
> >
> >         dev->power.idle_notification = false;
> >         wake_up_all(&dev->power.wait_queue);
> >
> >
> >
