Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8628B69D173
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Feb 2023 17:40:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232216AbjBTQkp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Feb 2023 11:40:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50660 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231549AbjBTQko (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Feb 2023 11:40:44 -0500
Received: from sin.source.kernel.org (sin.source.kernel.org [145.40.73.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F27FE1A665;
        Mon, 20 Feb 2023 08:40:29 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 555E5CE0FF1;
        Mon, 20 Feb 2023 16:40:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 93B0EC433D2;
        Mon, 20 Feb 2023 16:40:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1676911226;
        bh=aUFNjkKFipMFqsWgdBLvu13lnzOJHrwAfbJcOgLdQZk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=P90f/xk1Q5qdO1uVsJ3tezWyw+y7lfydgWHG3TZ/gPsPOy47tdDrhmW4at5d3jpgS
         AUaTd218CH9miRCqoRXMu0tauN/HN9kndxW4fbUJSLSSZXzD95ccvOu5e25UkouEMc
         YOTtlIDbuftx9EHOudNIVLakgGSd1kyhfzm6or1pBrmpmNfe9Wpn82ZHC3WoerRmIr
         Ku6eCwf3h/0KkMk8HjNznE2roFpSFM3mmeV8fGCRne3HGJzYmnRzjaPFWRJAkl3aLc
         nUACXL5u9pNhFmYtj/OTy57n4CT3qGgyZiHkiu458Ll0nAyny5K0CIvI854twC6CIY
         Q2C8kaws+AmgA==
Date:   Mon, 20 Feb 2023 08:43:56 -0800
From:   Bjorn Andersson <andersson@kernel.org>
To:     Abel Vesa <abel.vesa@linaro.org>
Cc:     Ulf Hansson <ulf.hansson@linaro.org>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Kevin Hilman <khilman@kernel.org>,
        Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andy Gross <agross@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        linux-pm@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-arm-msm@vger.kernel.org,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Stephen Boyd <sboyd@kernel.org>
Subject: Re: [RFC PATCH v2 1/2] PM: domains: Skip disabling unused domains if
 provider has sync_state
Message-ID: <20230220164356.zafohov4mbkvmvjf@ripper>
References: <20230127104054.895129-1-abel.vesa@linaro.org>
 <CAPDyKFon35wcQ+5kx3QZb-awN_S_q8y1Sir-G+GoxkCvpN=iiA@mail.gmail.com>
 <Y+zOYfSI7Zq5sll1@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y+zOYfSI7Zq5sll1@linaro.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 15, 2023 at 02:21:53PM +0200, Abel Vesa wrote:
> On 23-02-15 12:57:54, Ulf Hansson wrote:
> > On Fri, 27 Jan 2023 at 11:40, Abel Vesa <abel.vesa@linaro.org> wrote:
> > >
> > > Currently, there are cases when a domain needs to remain enabled until
> > > the consumer driver probes. Sometimes such consumer drivers may be built
> > > as modules. Since the genpd_power_off_unused is called too early for
> > > such consumer driver modules to get a chance to probe, the domain, since
> > > it is unused, will get disabled. On the other hand, the best time for
> > > an unused domain to be disabled is on the provider's sync_state
> > > callback. So, if the provider has registered a sync_state callback,
> > > assume the unused domains for that provider will be disabled on its
> > > sync_state callback. Also provide a generic sync_state callback which
> > > disables all the domains unused for the provider that registers it.
> > >
> > > Signed-off-by: Abel Vesa <abel.vesa@linaro.org>
> > > ---
> > >
> > > This approach has been applied for unused clocks as well.
> > > With this patch merged in, all the providers that have sync_state
> > > callback registered will leave the domains enabled unless the provider's
> > > sync_state callback explicitly disables them. So those providers will
> > > need to add the disabling part to their sync_state callback. On the
> > > other hand, the platforms that have cases where domains need to remain
> > > enabled (even if unused) until the consumer driver probes, will be able,
> > > with this patch in, to run without the pd_ignore_unused kernel argument,
> > > which seems to be the case for most Qualcomm platforms, at this moment.
> > 
> > My apologies for the somewhat late reply. Please see my comments below.
> > 
> > >
> > > The v1 is here:
> > > https://lore.kernel.org/all/20230126234013.3638425-1-abel.vesa@linaro.org/
> > >
> > > Changes since v1:
> > >  * added a generic sync state callback to be registered by providers in
> > >    order to disable the unused domains on their sync state. Also
> > >    mentioned this in the commit message.
> > >
> > >  drivers/base/power/domain.c | 17 ++++++++++++++++-
> > >  include/linux/pm_domain.h   |  3 +++
> > >  2 files changed, 19 insertions(+), 1 deletion(-)
> > >
> > > diff --git a/drivers/base/power/domain.c b/drivers/base/power/domain.c
> > > index 84662d338188..c2a5f77c01f3 100644
> > > --- a/drivers/base/power/domain.c
> > > +++ b/drivers/base/power/domain.c
> > > @@ -1099,7 +1099,8 @@ static int __init genpd_power_off_unused(void)
> > >         mutex_lock(&gpd_list_lock);
> > >
> > >         list_for_each_entry(genpd, &gpd_list, gpd_list_node)
> > > -               genpd_queue_power_off_work(genpd);
> > > +               if (!dev_has_sync_state(genpd->provider->dev))
> > 
> > Unfortunately, this doesn't really help, due to the fact that a
> > genpd's ->power_off() callback may get called anyway. At power off,
> > the genpd core only cares about those consumers that are currently
> > attached, not those that might get attached at some point later in
> > time.
> > 
> > In other words, it's the responsibility for each specific genpd
> > provider to cope with the condition that its ->sync_state() callback
> > may *not* have been called, while its ->power_off() callback is being
> > called.
> > 
> > In these cases, the genpd provider should probably make the
> > ->power_off() callback to return -EBUSY. This is what we do in
> > psci_pd_power_off(), for example.
> > 
> 
> Hmm, this might actually be a better idea. Bjorn, do you agree?
> 

Yes, I agree.

Regards,
Bjorn
