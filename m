Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 159465E7F00
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Sep 2022 17:53:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232163AbiIWPxR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Sep 2022 11:53:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34336 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231235AbiIWPxL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Sep 2022 11:53:11 -0400
Received: from mail-qt1-f181.google.com (mail-qt1-f181.google.com [209.85.160.181])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F33D13E7F2;
        Fri, 23 Sep 2022 08:53:10 -0700 (PDT)
Received: by mail-qt1-f181.google.com with SMTP id b23so271201qtr.13;
        Fri, 23 Sep 2022 08:53:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=0dJpb5MWD5OFoxFjAN4WXBXMWt5frU6fa7KgoPfQt1I=;
        b=buOuEYXhTB4fIN/oM539S0Tg9+hJd9TzWQNViMD1KYsQrUM1JgXcc8olMG4tR4CSb2
         YzqG2cHC4fyE36gwF+hA+mWi4JYZLrHz2O0s6P6eG5v3mEpEXAxAa8PpWlSe5DfszlVW
         FWsq6H/WlprzfMA6KWtq5bYH2puhhh5tVd7HaTf4/4yPhdTGCS7fSu/CmDmIMgVmfgSg
         A40OUQKLDNdVG1aCaD1tiFB7koUYLIVueFBKyjl3/yEOFjqwM3gwFiohg4METlNAlZ5J
         0CFCROlu5uMKTxZydgSEntkRdhC2OuNFH7l+/Iv91Mz4kDygf1hSagOfNyeDrnvsJCrw
         D3CQ==
X-Gm-Message-State: ACrzQf36GT8RUQcjgJuiOTr3VEFmGAY1Fghnnq+CvwUZJBLgRJ3FbZng
        JLZyVoSH4JfjA3Emy3n1NkRWEGm5+8snKaJJcds=
X-Google-Smtp-Source: AMsMyM5HXEy/DfIFTw8F++3sSJPs9PyjUYoUrAq1mN7uQ5wf99vUksC1RaGhT0Dy8uwDYFrICj7zEoAA8wPQlt68fcA=
X-Received: by 2002:a05:622a:11c8:b0:35c:e912:a8ea with SMTP id
 n8-20020a05622a11c800b0035ce912a8eamr7790926qtk.17.1663948389073; Fri, 23 Sep
 2022 08:53:09 -0700 (PDT)
MIME-Version: 1.0
References: <12079576.O9o76ZdvQC@kreacher> <CAPDyKFpVMnxCd9bMg=Wd7_TpSsNM6699NG0QLz8q=KWXk9G9hw@mail.gmail.com>
In-Reply-To: <CAPDyKFpVMnxCd9bMg=Wd7_TpSsNM6699NG0QLz8q=KWXk9G9hw@mail.gmail.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Fri, 23 Sep 2022 17:52:58 +0200
Message-ID: <CAJZ5v0h5atuB5mdedfste5EiZKRFgz+7QGQUgWs+=sme4EKbig@mail.gmail.com>
Subject: Re: [PATCH] PM: runtime: Return -EINPROGRESS from rpm_resume() in the
 RPM_NOWAIT case
To:     Ulf Hansson <ulf.hansson@linaro.org>
Cc:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Linux PM <linux-pm@vger.kernel.org>,
        Douglas Anderson <dianders@chromium.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Alan Stern <stern@rowland.harvard.edu>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 23, 2022 at 3:26 PM Ulf Hansson <ulf.hansson@linaro.org> wrote:
>
> On Thu, 22 Sept 2022 at 20:04, Rafael J. Wysocki <rjw@rjwysocki.net> wrote:
> >
> > From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> >
> > The prospective callers of rpm_resume() passing RPM_NOWAIT to it may
> > be confused when it returns 0 without actually resuming the device
> > which may happen if the device is suspending at the given time and it
> > will only resume when the suspend in progress has completed.  To avoid
> > that confusion, return -EINPROGRESS from rpm_resume() in that case.
> >
> > Since none of the current callers passing RPM_NOWAIT to rpm_resume()
> > check its return value, this change has no functional impact.
>
> Sounds like there are additional improvements that can be made around
> this, right?

This allows RPM_NOWAIT to be used in places where the caller doesn't
want to wait, because it might deadlock or similar, but they still
need to know whether or not the device can be accessed safely.

Or do you mean something else?

> >
> > Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
>
> Looks good to me!
>
> Reviewed-by: Ulf Hansson <ulf.hansson@linaro.org>

Thanks!

> > ---
> >  drivers/base/power/runtime.c |    7 +++++--
> >  1 file changed, 5 insertions(+), 2 deletions(-)
> >
> > Index: linux-pm/drivers/base/power/runtime.c
> > ===================================================================
> > --- linux-pm.orig/drivers/base/power/runtime.c
> > +++ linux-pm/drivers/base/power/runtime.c
> > @@ -792,10 +792,13 @@ static int rpm_resume(struct device *dev
> >                 DEFINE_WAIT(wait);
> >
> >                 if (rpmflags & (RPM_ASYNC | RPM_NOWAIT)) {
> > -                       if (dev->power.runtime_status == RPM_SUSPENDING)
> > +                       if (dev->power.runtime_status == RPM_SUSPENDING) {
> >                                 dev->power.deferred_resume = true;
> > -                       else
> > +                               if (rpmflags & RPM_NOWAIT)
> > +                                       retval = -EINPROGRESS;
> > +                       } else {
> >                                 retval = -EINPROGRESS;
> > +                       }
> >                         goto out;
> >                 }
> >
> >
> >
> >
