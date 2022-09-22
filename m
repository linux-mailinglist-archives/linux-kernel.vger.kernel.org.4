Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9C3DD5E6BF5
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Sep 2022 21:46:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231879AbiIVTq1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Sep 2022 15:46:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41986 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230070AbiIVTqY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Sep 2022 15:46:24 -0400
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com [IPv6:2a00:1450:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 446FAAE236
        for <linux-kernel@vger.kernel.org>; Thu, 22 Sep 2022 12:46:23 -0700 (PDT)
Received: by mail-ed1-x52d.google.com with SMTP id e17so15098873edc.5
        for <linux-kernel@vger.kernel.org>; Thu, 22 Sep 2022 12:46:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=S/aQFIprMwOPTZ98QXTAGe3OrWBJeoAbdeTJ2dIQ9XM=;
        b=Rxk4zRd0J/PCW77JtuQHXHqyqup9EnBemXl3cWIA5l7VqVq2dvJw5VQogX2o1iQFp4
         XrFEZbgoQw+dXwnTXvGbSHBlTcm52w/Jgg6fh5x0VTIGasZ+iAJh6d+MHmwojRlGmU2e
         jGSyomSpTN4+/WsgSlXiUvH2zMtSf4FBzzhVg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=S/aQFIprMwOPTZ98QXTAGe3OrWBJeoAbdeTJ2dIQ9XM=;
        b=V6hJ+DvHvAg/ORRY8+FaNqwcNy+imTprfpEITsWJApu7rOhO0viqH+duq+QV79xbc9
         2JuoMeHYAJ+OTy8yJtHgPr1+nm5KMPiqPuEE+gSNTofKhJ/0dQk+ekVJiALyx4CkAbbU
         cslYq6upecfOgw45A3kEsnGSGJ2sgA2EG5QXIu33jnw5Kt8NwdO4YSQC/JPQyEF9FGxq
         CP8m9x2t7SBC25sheKNwjpO8Pj2m6JCyHwJKJjFnAbb1qtHV+iq7gbwBWrGRcaAzMKpc
         dTCgvm3g1XfjrlGcMG2oczFSQtlrcv8vLMX9RkKdzVyDvyQuA0y50ELe3pbjb+Qspb8k
         piFw==
X-Gm-Message-State: ACrzQf0DIcJ5nsN7io84da23sfj6Ntqmg66ZPX+QRYjzMmMvrKAv444+
        bZQD9mOauc+6FaqPzoE1w8Ot9uivVD/fC5hy
X-Google-Smtp-Source: AMsMyM5XkRYxjMAVqhcs6ZuaYwZ8KJdg3/BewAiA6/4xN7O6IpeAzTDiayhQqzJhKJH+XWjQ0j9lGQ==
X-Received: by 2002:a05:6402:909:b0:435:a8b:5232 with SMTP id g9-20020a056402090900b004350a8b5232mr5034224edz.240.1663875981509;
        Thu, 22 Sep 2022 12:46:21 -0700 (PDT)
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com. [209.85.128.50])
        by smtp.gmail.com with ESMTPSA id kv6-20020a17090778c600b0076f0ab594e9sm3023758ejc.73.2022.09.22.12.46.20
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 22 Sep 2022 12:46:20 -0700 (PDT)
Received: by mail-wm1-f50.google.com with SMTP id n40-20020a05600c3ba800b003b49aefc35fso2002970wms.5
        for <linux-kernel@vger.kernel.org>; Thu, 22 Sep 2022 12:46:20 -0700 (PDT)
X-Received: by 2002:a05:600c:500d:b0:3b5:234:d7e9 with SMTP id
 n13-20020a05600c500d00b003b50234d7e9mr3338993wmr.57.1663875980646; Thu, 22
 Sep 2022 12:46:20 -0700 (PDT)
MIME-Version: 1.0
References: <20220922154354.2486595-1-dianders@chromium.org>
 <20220922084322.RFC.1.Iaa18b24fef0c8e88f0b82502f7fa0a70565b64d2@changeid> <CAJZ5v0j+5ZJ3Za5pTiPe9NCRa3CV_KpaBX833vL=WH0tsTBF1g@mail.gmail.com>
In-Reply-To: <CAJZ5v0j+5ZJ3Za5pTiPe9NCRa3CV_KpaBX833vL=WH0tsTBF1g@mail.gmail.com>
From:   Doug Anderson <dianders@chromium.org>
Date:   Thu, 22 Sep 2022 12:46:08 -0700
X-Gmail-Original-Message-ID: <CAD=FV=UfuPu8nz5=DciusvGGko6we5s2VFf30BbEbONQNgwQoA@mail.gmail.com>
Message-ID: <CAD=FV=UfuPu8nz5=DciusvGGko6we5s2VFf30BbEbONQNgwQoA@mail.gmail.com>
Subject: Re: [RFC PATCH 1/2] PM: runtime: Add pm_runtime_try_put_sync() and pm_runtime_try_get_sync()
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Stephen Boyd <sboyd@kernel.org>, Pavel Machek <pavel@ucw.cz>,
        Linux PM <linux-pm@vger.kernel.org>,
        Len Brown <len.brown@intel.com>,
        linux-clk <linux-clk@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Thu, Sep 22, 2022 at 10:38 AM Rafael J. Wysocki <rafael@kernel.org> wrote:
>
> On Thu, Sep 22, 2022 at 5:44 PM Douglas Anderson <dianders@chromium.org> wrote:
> >
> > In some cases, a caller may wish to synchronously get or put the PM
> > Runtime state of a device but the caller may also be holding a
> > resource that the runtime suspend or runtime resume of the device
> > needs. Obviously this can lead to deadlock.
> >
> > A case in point is the clock framework. While running
> > clk_disable_unused() the clock framework holds the global clock
> > "prepare" lock. The clock framework then goes through and does PM
> > Runtime actions. It should be no surprise to anyone that some devices
> > need to prepare or unprepare clocks are part of their PM Runtime
> > actions. Things generally work OK because of the "recursive" nature of
> > the global clock "prepare" lock, but if we get unlucky and the PM
> > Runtime action is happening in another task then we can end up
> > deadlocking.
> >
> > Let's add a "try" version of the synchronous PM Runtime routines.
> > This version will return -EINPROGRESS rather than waiting. To
> > implement this we'll add a new flag: RPM_TRY.
> >
> > Signed-off-by: Douglas Anderson <dianders@chromium.org>
> > ---
> >
> >  drivers/base/power/runtime.c |  7 +++++--
> >  include/linux/pm_runtime.h   | 28 ++++++++++++++++++++++++++++
> >  2 files changed, 33 insertions(+), 2 deletions(-)
> >
> > diff --git a/drivers/base/power/runtime.c b/drivers/base/power/runtime.c
> > index 997be3ac20a7..67cc6a620b12 100644
> > --- a/drivers/base/power/runtime.c
> > +++ b/drivers/base/power/runtime.c
> > @@ -609,7 +609,7 @@ static int rpm_suspend(struct device *dev, int rpmflags)
> >         if (dev->power.runtime_status == RPM_SUSPENDING) {
> >                 DEFINE_WAIT(wait);
> >
> > -               if (rpmflags & (RPM_ASYNC | RPM_NOWAIT)) {
> > +               if (rpmflags & (RPM_ASYNC | RPM_NOWAIT | RPM_TRY)) {
> >                         retval = -EINPROGRESS;
> >                         goto out;
> >                 }
> > @@ -791,7 +791,10 @@ static int rpm_resume(struct device *dev, int rpmflags)
> >             || dev->power.runtime_status == RPM_SUSPENDING) {
> >                 DEFINE_WAIT(wait);
> >
> > -               if (rpmflags & (RPM_ASYNC | RPM_NOWAIT)) {
> > +               if (rpmflags & RPM_TRY) {
> > +                       retval = -EINPROGRESS;
>
> Returning -EINPROGRESS from here may be misleading, because the device
> may not be resuming.
>
> Besides, I'm not sure why a new flag is needed.  What about using
> RPM_NOWAIT instead?

Yeah, we can use RPM_NOWAIT if we land your patch [1]. I'll spin with
that if folks agree that the overall approach taken in this series
makes sense.

[1] https://lore.kernel.org/r/12079576.O9o76ZdvQC@kreacher

-Doug
