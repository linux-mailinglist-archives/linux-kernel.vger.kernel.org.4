Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 71E2A691168
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Feb 2023 20:34:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229649AbjBITet (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Feb 2023 14:34:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57650 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229953AbjBITep (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Feb 2023 14:34:45 -0500
Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D65A410259;
        Thu,  9 Feb 2023 11:34:44 -0800 (PST)
Received: by mail-ej1-f45.google.com with SMTP id lu11so9650660ejb.3;
        Thu, 09 Feb 2023 11:34:44 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=FQyPKHsnpkMtHTu8wIUgMn7V8u4D4+AVOfDvP1szK50=;
        b=zr5hyeBKdUpmenmZsXcn9FmLkaOIms+DVYEr63SGk1Nbwb8ZSkrqq3J9rNmSaX7hyJ
         pAR581h2YRNVG6AA93UdFH2Gkr+SRQI//VXEzfsH8hhohRwVP+7Q5BFEJcyUCKUxZtT1
         tGyghz6S2QD/9iALq9+pUZBhZMTtcpXgUuOZz2zME8q4bx4oFdv9Y/0/tbo3ktpCfwU4
         SYbMOC1xS33vFmz5zS4qbWcSSmZfRpF9YZWQjxPY8AHNrXwaEa1vzg+wwb8c8ULyjEkp
         lRKdXJDjsGKlkMIBPuKGSKCjdib/VPQhnG3WT9rTD+TatYsx4sf+kgCDO9Vjhv5zCd0m
         PSaQ==
X-Gm-Message-State: AO0yUKV7rIdmVdL+jnY5iAwCH+kHU/A73OreTXztVR0f83td2in6qNd/
        9iacKCFkK/jQzmcX/ISWo7799bVr3njBAoj4al0=
X-Google-Smtp-Source: AK7set+wluxzNyhZvd4jbRFYLJUQ9ghyXw8Cm0oCBDn53ajufkx4Ht18b90WGecWYVh9M9ucqrzSMPx7hO/eypNm2XA=
X-Received: by 2002:a17:906:ce2e:b0:87f:575a:9b67 with SMTP id
 sd14-20020a170906ce2e00b0087f575a9b67mr2944602ejb.274.1675971283500; Thu, 09
 Feb 2023 11:34:43 -0800 (PST)
MIME-Version: 1.0
References: <20230202141545.2295679-1-gregkh@linuxfoundation.org>
 <CAJZ5v0gMpORi=kB4-PFswmhY2HJggJO+Qh2SMjCuHyn3z+zmTw@mail.gmail.com> <Y9vSQhnCdnInKu/b@kroah.com>
In-Reply-To: <Y9vSQhnCdnInKu/b@kroah.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Thu, 9 Feb 2023 20:34:32 +0100
Message-ID: <CAJZ5v0hhCAUVb7RgaKkO9j6g0mKUdOcDNy=7vM9kFkm3NyNp-g@mail.gmail.com>
Subject: Re: [PATCH] drivers: base: power: fix memory leak with using debugfs_lookup()
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Kevin Hilman <khilman@kernel.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Pavel Machek <pavel@ucw.cz>, Len Brown <len.brown@intel.com>,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
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

On Thu, Feb 2, 2023 at 4:09 PM Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> On Thu, Feb 02, 2023 at 03:23:46PM +0100, Rafael J. Wysocki wrote:
> > On Thu, Feb 2, 2023 at 3:15 PM Greg Kroah-Hartman
> > <gregkh@linuxfoundation.org> wrote:
> > >
> > > When calling debugfs_lookup() the result must have dput() called on it,
> > > otherwise the memory will leak over time.  To make things simpler, just
> > > call debugfs_lookup_and_remove() instead which handles all of the logic
> > > at
> > > once.
> > >
> > > Cc: "Rafael J. Wysocki" <rafael@kernel.org>
> > > Cc: Kevin Hilman <khilman@kernel.org>
> > > Cc: Ulf Hansson <ulf.hansson@linaro.org>
> > > Cc: Pavel Machek <pavel@ucw.cz>
> > > Cc: Len Brown <len.brown@intel.com>
> > > Cc: linux-pm@vger.kernel.org
> > > Cc: linux-kernel@vger.kernel.org
> > > Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> > > ---
> > >  drivers/base/power/domain.c | 5 +----
> > >  1 file changed, 1 insertion(+), 4 deletions(-)
> > >
> > > diff --git a/drivers/base/power/domain.c b/drivers/base/power/domain.c
> > > index 967bcf9d415e..6097644ebdc5 100644
> > > --- a/drivers/base/power/domain.c
> > > +++ b/drivers/base/power/domain.c
> > > @@ -220,13 +220,10 @@ static void genpd_debug_add(struct generic_pm_domain *genpd);
> > >
> > >  static void genpd_debug_remove(struct generic_pm_domain *genpd)
> > >  {
> > > -       struct dentry *d;
> > > -
> > >         if (!genpd_debugfs_dir)
> > >                 return;
> > >
> > > -       d = debugfs_lookup(genpd->name, genpd_debugfs_dir);
> > > -       debugfs_remove(d);
> > > +       debugfs_lookup_and_remove(genpd->name, genpd_debugfs_dir);
> > >  }
> > >
> > >  static void genpd_update_accounting(struct generic_pm_domain *genpd)
> > > --
> >
> > Does this depend on anything in your tree, or can I apply it?
>
> It does not depend on anything in any of my trees, it's made against
> Linus's tree right now so please take it through yours.

Applied for 6.3 now, thanks!
