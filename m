Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5D95A5E6BC2
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Sep 2022 21:34:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231838AbiIVTeC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Sep 2022 15:34:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51824 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229847AbiIVTd7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Sep 2022 15:33:59 -0400
Received: from mail-qk1-f182.google.com (mail-qk1-f182.google.com [209.85.222.182])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D3F310808F;
        Thu, 22 Sep 2022 12:33:59 -0700 (PDT)
Received: by mail-qk1-f182.google.com with SMTP id i3so6952288qkl.3;
        Thu, 22 Sep 2022 12:33:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=78jrB9R8LhZta3Yc8UK1hR35xlhpQqfZTT/+lbOX8Yk=;
        b=4xN9XK3D0iGLkUuC+GeEVvf6C7Bi0ugAkKcGvPBKQaLxkc8EYQtLC4YvRkWwuPCL+b
         VhPulO860KPclkv/4tjk+R1hDSU9Foiar59G6BXjyj8gd+ZxQdp4p+8rEtjJiUDqz6eR
         gtln4y9Kukj0pWZZe/4vhvP2ynGgZ/Tbfi0Rrc2TbCmiialaNKyyEYImi+PaOMUQnhhX
         UO7D7psejIR2QZA5xYf2VV6z/lrofH7zXvJA7VVRLGw0EZCNcoDwiSznxiuHLtcP4ycM
         nqXtVE7ZcKCImdXzUGgNDcnOnrpPDnLkko7g4wvoZDHPzwGwBsNSVJw/clO2XhwQvxns
         qZUw==
X-Gm-Message-State: ACrzQf1ZEQe8VlGJxi+LvpphQLxZ0sR5h6cygErEdF+q2a8KGQODsKhy
        CUC7xem8ARzCJI9VmWXY012uAJ+vVYhUuCjtn2Q=
X-Google-Smtp-Source: AMsMyM7ngD1AJj+UvGF8kpbszbolKMB1I6oZLrvHGxZuXk/9cWTG7nRVuM3+y3nfmr9YT+JKtD4D8UKTgCejCfU22ZQ=
X-Received: by 2002:a05:620a:2988:b0:6ce:cc3f:73b9 with SMTP id
 r8-20020a05620a298800b006cecc3f73b9mr3329578qkp.9.1663875238228; Thu, 22 Sep
 2022 12:33:58 -0700 (PDT)
MIME-Version: 1.0
References: <12079576.O9o76ZdvQC@kreacher> <Yyy4O/NUMSRtCmhI@rowland.harvard.edu>
In-Reply-To: <Yyy4O/NUMSRtCmhI@rowland.harvard.edu>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Thu, 22 Sep 2022 21:33:47 +0200
Message-ID: <CAJZ5v0huvrHrk_8Jh3vWSEx-MEEZcZop_XCZeQ1FcNmD+7xZBQ@mail.gmail.com>
Subject: Re: [PATCH] PM: runtime: Return -EINPROGRESS from rpm_resume() in the
 RPM_NOWAIT case
To:     Alan Stern <stern@rowland.harvard.edu>
Cc:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Linux PM <linux-pm@vger.kernel.org>,
        Douglas Anderson <dianders@chromium.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Ulf Hansson <ulf.hansson@linaro.org>
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

On Thu, Sep 22, 2022 at 9:32 PM Alan Stern <stern@rowland.harvard.edu> wrote:
>
> On Thu, Sep 22, 2022 at 08:04:40PM +0200, Rafael J. Wysocki wrote:
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
> >
> > Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> > ---
> >  drivers/base/power/runtime.c |    7 +++++--
> >  1 file changed, 5 insertions(+), 2 deletions(-)
> >
> > Index: linux-pm/drivers/base/power/runtime.c
> > ===================================================================
> > --- linux-pm.orig/drivers/base/power/runtime.c
> > +++ linux-pm/drivers/base/power/runtime.c
> > @@ -792,10 +792,13 @@ static int rpm_resume(struct device *dev
> >               DEFINE_WAIT(wait);
> >
> >               if (rpmflags & (RPM_ASYNC | RPM_NOWAIT)) {
>
> Hmmm, and what if a caller sets both of these flags?  I guess in that
> case he gets what he deserves.

Exactly.

> > -                     if (dev->power.runtime_status == RPM_SUSPENDING)
> > +                     if (dev->power.runtime_status == RPM_SUSPENDING) {
> >                               dev->power.deferred_resume = true;
> > -                     else
> > +                             if (rpmflags & RPM_NOWAIT)
> > +                                     retval = -EINPROGRESS;
> > +                     } else {
> >                               retval = -EINPROGRESS;
> > +                     }
> >                       goto out;
> >               }
>
> Acked-by: Alan Stern <stern@rowland.harvard.edu>

Thanks!
