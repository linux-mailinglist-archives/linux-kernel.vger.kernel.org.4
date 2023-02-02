Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 92EBA68814E
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Feb 2023 16:10:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232498AbjBBPKw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Feb 2023 10:10:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53408 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231474AbjBBPKu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Feb 2023 10:10:50 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 103D5921AE;
        Thu,  2 Feb 2023 07:10:14 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id BB31BB82693;
        Thu,  2 Feb 2023 15:09:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B6562C433D2;
        Thu,  2 Feb 2023 15:09:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1675350597;
        bh=+GRfAdhrRAvsh8bmpB//2zbWMDnHNB+UeoADl5fXjqo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=DwAztupMAfpl0EOR5hYBO5HZi1aXpxtrYoYBG/cYtm/D3nhOgOBVyslmGkZJQ9H3j
         ypji3sOzU8KIEDTt8pk3uG0im5F2vH1wGRL53QV1bM3BKxATLluIKCXOlvec/4b6fY
         8t5cKO3xuW0iAU/IdhPCUO9lu1xVnL5rfYcOSchw=
Date:   Thu, 2 Feb 2023 16:09:54 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Kevin Hilman <khilman@kernel.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Pavel Machek <pavel@ucw.cz>, Len Brown <len.brown@intel.com>,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] drivers: base: power: fix memory leak with using
 debugfs_lookup()
Message-ID: <Y9vSQhnCdnInKu/b@kroah.com>
References: <20230202141545.2295679-1-gregkh@linuxfoundation.org>
 <CAJZ5v0gMpORi=kB4-PFswmhY2HJggJO+Qh2SMjCuHyn3z+zmTw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJZ5v0gMpORi=kB4-PFswmhY2HJggJO+Qh2SMjCuHyn3z+zmTw@mail.gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 02, 2023 at 03:23:46PM +0100, Rafael J. Wysocki wrote:
> On Thu, Feb 2, 2023 at 3:15 PM Greg Kroah-Hartman
> <gregkh@linuxfoundation.org> wrote:
> >
> > When calling debugfs_lookup() the result must have dput() called on it,
> > otherwise the memory will leak over time.  To make things simpler, just
> > call debugfs_lookup_and_remove() instead which handles all of the logic
> > at
> > once.
> >
> > Cc: "Rafael J. Wysocki" <rafael@kernel.org>
> > Cc: Kevin Hilman <khilman@kernel.org>
> > Cc: Ulf Hansson <ulf.hansson@linaro.org>
> > Cc: Pavel Machek <pavel@ucw.cz>
> > Cc: Len Brown <len.brown@intel.com>
> > Cc: linux-pm@vger.kernel.org
> > Cc: linux-kernel@vger.kernel.org
> > Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> > ---
> >  drivers/base/power/domain.c | 5 +----
> >  1 file changed, 1 insertion(+), 4 deletions(-)
> >
> > diff --git a/drivers/base/power/domain.c b/drivers/base/power/domain.c
> > index 967bcf9d415e..6097644ebdc5 100644
> > --- a/drivers/base/power/domain.c
> > +++ b/drivers/base/power/domain.c
> > @@ -220,13 +220,10 @@ static void genpd_debug_add(struct generic_pm_domain *genpd);
> >
> >  static void genpd_debug_remove(struct generic_pm_domain *genpd)
> >  {
> > -       struct dentry *d;
> > -
> >         if (!genpd_debugfs_dir)
> >                 return;
> >
> > -       d = debugfs_lookup(genpd->name, genpd_debugfs_dir);
> > -       debugfs_remove(d);
> > +       debugfs_lookup_and_remove(genpd->name, genpd_debugfs_dir);
> >  }
> >
> >  static void genpd_update_accounting(struct generic_pm_domain *genpd)
> > --
> 
> Does this depend on anything in your tree, or can I apply it?

It does not depend on anything in any of my trees, it's made against
Linus's tree right now so please take it through yours.

thanks!

greg k-h
