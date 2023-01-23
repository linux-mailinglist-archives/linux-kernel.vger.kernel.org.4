Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 96D0B67875D
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Jan 2023 21:16:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233056AbjAWUQt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Jan 2023 15:16:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46504 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229842AbjAWUQs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Jan 2023 15:16:48 -0500
Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com [209.85.218.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB4AD303FD;
        Mon, 23 Jan 2023 12:16:46 -0800 (PST)
Received: by mail-ej1-f43.google.com with SMTP id az20so33705902ejc.1;
        Mon, 23 Jan 2023 12:16:46 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=VgXOOVmQ0mWj2jI7gP5fKcESDlGdSkE3bOPP/KvcYAg=;
        b=750iBC8PYhL/5Y6TT+MOMq5//yp0+mkaX8oE8Dmpfv0BTw0EVtEYvj5p5PDER0aH8A
         ijqlvTfPJyCaJ9h/ve9JLzEEn464rV+g4H0QfTVFF40Ksao3esBOaw4R3NLXUKS4R4Qh
         AtOP7EcaeKG/hTBBKhW5AYDP9bXWRgg+9oiF0w0npXoEApB2FVBwKx0mLBo7hljEloO7
         xN2WvqyBlhwfXwnsNDd7FLRhMNvBOtDJ65eEMmVQIwnokdsyvbROqGlRZJlQ3hgbYu+N
         wwOcstdqXnJ72NaDsal/kydqJFP2j15cAicCODcDX/2sPjuWrf0uj0xANPbTcJxCP7Am
         GZmQ==
X-Gm-Message-State: AFqh2kqdVDWUa6eyr/zNvPIx3yXPz/MXG28oVQu65r8a6XBNNfrblvq0
        YUgCenkPJcOZ85J8pCAVpXJWhKqEOr9CHLHNXWM=
X-Google-Smtp-Source: AMrXdXu8FR0yC5DPTJs2YNWImlgCh6X+nCEHpOyzsDa+iiTgsEopwacq2dMQ3rUaCVQEfPzaLFyE2ljv2IrAQq5KMMw=
X-Received: by 2002:a17:906:92c8:b0:877:8b1c:fd7c with SMTP id
 d8-20020a17090692c800b008778b1cfd7cmr2058015ejx.67.1674505005289; Mon, 23 Jan
 2023 12:16:45 -0800 (PST)
MIME-Version: 1.0
References: <5905717.lOV4Wx5bFT@kreacher> <4780418.GXAFRqVoOG@kreacher> <Y8uW374CM37m0/wI@kroah.com>
In-Reply-To: <Y8uW374CM37m0/wI@kroah.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Mon, 23 Jan 2023 21:16:33 +0100
Message-ID: <CAJZ5v0heCTm+1sv9taAoMe8PGgLPEzsTxh9ZdOGjdhDLuvc-Zw@mail.gmail.com>
Subject: Re: [PATCH v1 2/2] thermal: Fail object registration if thermal class
 is not registered
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Linux PM <linux-pm@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        Zhang Rui <rui.zhang@intel.com>
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

On Sat, Jan 21, 2023 at 8:40 AM Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> On Fri, Jan 20, 2023 at 08:48:07PM +0100, Rafael J. Wysocki wrote:
> > From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> >
> > If thermal_class is not registered with the driver core, there is no way
> > to expose the interfaces used by the thermal control framework, so
> > prevent thermal zones and cooling devices from being registered in
> > that case by returning an error from object registration functions.
> >
> > For this purpose, introduce class_is_registered() that checks the
> > private pointer of the given class and returns 'false' if it is NULL,
> > which means that the class has not been registered, and use it in the
> > thermal framework.
> >
> > Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> > ---
> >  drivers/thermal/thermal_core.c |    6 ++++++
> >  include/linux/device/class.h   |    5 +++++
> >  2 files changed, 11 insertions(+)
> >
> > Index: linux-pm/include/linux/device/class.h
> > ===================================================================
> > --- linux-pm.orig/include/linux/device/class.h
> > +++ linux-pm/include/linux/device/class.h
> > @@ -82,6 +82,11 @@ struct class_dev_iter {
> >       const struct device_type        *type;
> >  };
> >
> > +static inline bool class_is_registered(struct class *class)
> > +{
> > +     return !!class->p;
>
> I really do not like this as it is exposing internals to drivers and
> whenever we do that, it gets abused and we have to unwind the mess in a
> few years.
>
> Overall, I'm trying to remove the ->p usage, but that's a longterm goal
> of mine (to allow class and bus structures to be in read-only memory),
> which isn't your issue here, but it's good to think about why you want
> to know this information (more below.)
>
> > +}
> > +
> >  extern struct kobject *sysfs_dev_block_kobj;
> >  extern struct kobject *sysfs_dev_char_kobj;
> >  extern int __must_check __class_register(struct class *class,
> > Index: linux-pm/drivers/thermal/thermal_core.c
> > ===================================================================
> > --- linux-pm.orig/drivers/thermal/thermal_core.c
> > +++ linux-pm/drivers/thermal/thermal_core.c
> > @@ -880,6 +880,9 @@ __thermal_cooling_device_register(struct
> >           !ops->set_cur_state)
> >               return ERR_PTR(-EINVAL);
> >
> > +     if (!class_is_registered(&thermal_class))
> > +             return ERR_PTR(-ENODEV);
>
> If the class isn't registered, then sommething went wrong with the
> thermal core code, right?  So why isn't the thermal core keeping a local
> variable of "class was registered" and relying on the driver core to
> know this?
>
> The number of individual users that should be doing one thing or another
> if a class is not registered feels very very slim.  How come this code
> is being called at all if the thermal class was not registered in the
> first place?  What would have prevented that from happening?  Is it an
> ordering issue, or a kernel configuration issue?

It's basically a matter of class_register() returning an error.

Yes, we could use an extra variable for this purpose, but that would
be a bit wasteful, because thermal_class will then sit unused and
occupy memory in vain.

Oh well, we may as well just allocate it dynamically.
