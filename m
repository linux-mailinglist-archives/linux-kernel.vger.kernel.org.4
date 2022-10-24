Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7958A60B951
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Oct 2022 22:08:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232849AbiJXUIe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Oct 2022 16:08:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42450 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230281AbiJXUID (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Oct 2022 16:08:03 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC24213E2D;
        Mon, 24 Oct 2022 11:27:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=EF3dfbCXssSwWopFX4bO0gLJ97ZCziT/aN+xXzLRDMQ=; b=URvLDdyKS//D0ORqv6ydCJ7ZKZ
        Sn0lg1TnDa6oI31wT1QCThPPKyIW8uCLxXeau+b/a4CbdN1EuZA88hRsyqtmyEx79zzeSBl/o2da8
        y4OSBJX2vdKCmbMgPf/Dl7wHMK4ERC1Dmd7nbqiEaA4l//jCO+/+cCtwA4G38HHtOdLNgl+upyVvR
        rIFZe6pOYI3v0EJ/CPAMe/UhTsummtp1xS6N8OLugJqSwtzmuASODv7VMZV6xwiJORR9JAknt0cqX
        pxwnnsb/7ydKamK08R71SGseaxE0VdO40W6pE4oH8epVVLDVpssPiKTDYpuf1j0wguBAqaYvZuaNO
        Qute+SvA==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1on1e9-002Y9W-Ko; Mon, 24 Oct 2022 17:53:57 +0000
Date:   Mon, 24 Oct 2022 10:53:57 -0700
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     Petr Mladek <pmladek@suse.com>
Cc:     Petr Pavlu <petr.pavlu@suse.com>,
        Prarit Bhargava <prarit@redhat.com>,
        linux-modules@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/2] module: Merge same-name module load requests
Message-ID: <Y1bRNStBDrFqf/EH@bombadil.infradead.org>
References: <20220919123233.8538-1-petr.pavlu@suse.com>
 <20220919123233.8538-3-petr.pavlu@suse.com>
 <YzdR0gRNQI2BGnJ9@bombadil.infradead.org>
 <aa8d9456-b260-d999-0296-8e6ab876af7a@suse.com>
 <Y07xX2ejlg0oFoEy@bombadil.infradead.org>
 <d0bc50e3-0e42-311b-20ed-7538bb918c5b@suse.com>
 <Y1Dyy/SAP1U3tPve@alley>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y1Dyy/SAP1U3tPve@alley>
Sender: Luis Chamberlain <mcgrof@infradead.org>
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 20, 2022 at 09:03:39AM +0200, Petr Mladek wrote:
> On Wed 2022-10-19 14:00:55, Petr Pavlu wrote:
> > On 10/18/22 20:33, Luis Chamberlain wrote:
> > > On Sat, Oct 15, 2022 at 11:27:10AM +0200, Petr Pavlu wrote:
> > >> The patch does address a regression observed after commit 6e6de3dee51a
> > >> ("kernel/module.c: Only return -EEXIST for modules that have finished
> > >> loading"). I guess it can have a Fixes tag added to the patch.
> > >>
> > >> I think it is hard to split this patch into parts because the implemented
> > >> "optimization" is the fix.
> > > 
> > > git describe --contains 6e6de3dee51a
> > > v5.3-rc1~38^2~6
> > > 
> > > I'm a bit torn about this situation. Reverting 6e6de3dee51a would be the
> > > right thing to do, but without it, it still leaves the issue reported
> > > by Prarit Bhargava. We need a way to resolve the issue on stable and
> > > then your optimizations can be applied on top.
> > 
> > Simpler could be to do the following:
> > 
> > diff --git a/kernel/module/main.c b/kernel/module/main.c
> > index d02d39c7174e..0302ac387e93 100644
> > --- a/kernel/module/main.c
> > +++ b/kernel/module/main.c
> > @@ -2386,7 +2386,8 @@ static bool finished_loading(const char *name)
> >  	sched_annotate_sleep();
> >  	mutex_lock(&module_mutex);
> >  	mod = find_module_all(name, strlen(name), true);
> > -	ret = !mod || mod->state == MODULE_STATE_LIVE;
> > +	ret = !mod || mod->state == MODULE_STATE_LIVE
> > +		|| mod->state == MODULE_STATE_GOING;
> >  	mutex_unlock(&module_mutex);
> >  
> >  	return ret;
> > @@ -2566,7 +2567,8 @@ static int add_unformed_module(struct module *mod)
> >  	mutex_lock(&module_mutex);
> >  	old = find_module_all(mod->name, strlen(mod->name), true);
> >  	if (old != NULL) {
> > -		if (old->state != MODULE_STATE_LIVE) {
> > +		if (old->state == MODULE_STATE_COMING
> > +		    || old->state == MODULE_STATE_UNFORMED) {
> >  			/* Wait in case it fails to load. */
> >  			mutex_unlock(&module_mutex);
> >  			err = wait_event_interruptible(module_wq,
> > @@ -2575,7 +2577,7 @@ static int add_unformed_module(struct module *mod)
> >  				goto out_unlocked;
> >  			goto again;
> >  		}
> > -		err = -EEXIST;
> > +		err = old->state != MODULE_STATE_LIVE ? -EBUSY : -EEXIST;
> >
> >  		goto out;
> >  	}
> >  	mod_update_bounds(mod);
> > 
> > This is an alternative approach to fix the issue that 6e6de3dee51a addressed
> > and it preserves the previous handling of same-module parallel loads.
> > 
> > It works well in practice but a problem is that this previous handling is
> > somewhat fragile because it requires specific timings. A second load of a same
> > module returns EBUSY only if it observes the first load in the going state.
> > 
> > The following can then happen:
> > * A first load of module A is requested. It passes add_unformed_module() and
> >   proceeds with full initialization.
> > * A second load of module A arrives. It proceeds up to add_unformed_module()
> >   where it waits on the first module to complete its initialization.
> > * The first load fails because its init function happens to produce an error.
> >   The cleanup code in do_init_module() unlinks the module from the modules
> >   list, frees the module and finally calls wake_up_all(&module_wq).
> > * The second load gets woken up. It sees that there is no module with the same
> >   name in the modules list and continues with its full initialization, which
> >   likely again fails in the init function.
> 
> Another solution would be to add one more reference counter directly
> into struct module. The existing counter is about dependencies on the
> module. It forces the module to stay in MODULE_STATE_LIVE when there
> is some dependency. The new reference counter would be just about
> life time of struct module.
> 
> It should be easier than to add new structure for passing err code.
> 
> Also it would allow to remove the racy finished_loading().
> wait_event_interruptible() could just check mod->state.

Sounds good, but let us just keep in mind we *first* want a fix for
stable, which also fixes 6e6de3dee51a and addresses the fix it intended
to have.

So I welcome patches, let us first get a small fix in for 6e6de3dee51a
and we can optimize away after.

  Luis
