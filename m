Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A7D41640AE9
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Dec 2022 17:36:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233823AbiLBQgV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Dec 2022 11:36:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58816 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231470AbiLBQgT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Dec 2022 11:36:19 -0500
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 788427B56D;
        Fri,  2 Dec 2022 08:36:17 -0800 (PST)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id 27C1921C77;
        Fri,  2 Dec 2022 16:36:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1669998976; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ER07KSeOjV8c9G+o1H2/HW39nNMcUx2yYbE1xS7TLBM=;
        b=sV1WbxVxKfaeKbOIJ/aKwFRR4ecDFcePrzqWZKX3rHrdmcSl6Bw9QUqazsDKLPnTO/Aob4
        r5TEk30l5JHCWNeA9AutFztQz+MvMgZxiO7gyL5LN6JlEfFZNrzqbf2Cmn6hgUB+yhVerB
        uIgPqVVaGezJZeI+MLdYutvea3hEonE=
Received: from suse.cz (unknown [10.100.201.202])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id 046D92C141;
        Fri,  2 Dec 2022 16:36:15 +0000 (UTC)
Date:   Fri, 2 Dec 2022 17:36:12 +0100
From:   Petr Mladek <pmladek@suse.com>
To:     Petr Pavlu <petr.pavlu@suse.com>
Cc:     Prarit Bhargava <prarit@redhat.com>,
        David Hildenbrand <david@redhat.com>,
        Luis Chamberlain <mcgrof@kernel.org>,
        linux-modules@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/2] module: Merge same-name module load requests
Message-ID: <Y4opfN6MTsFhrYfu@alley>
References: <YzdR0gRNQI2BGnJ9@bombadil.infradead.org>
 <aa8d9456-b260-d999-0296-8e6ab876af7a@suse.com>
 <Y07xX2ejlg0oFoEy@bombadil.infradead.org>
 <d0bc50e3-0e42-311b-20ed-7538bb918c5b@suse.com>
 <Y277Jb9i2VeXQoTL@bombadil.infradead.org>
 <e070839f-c224-047b-9411-91143c1d8394@redhat.com>
 <Y3Jg8X7qv2AKPU1J@bombadil.infradead.org>
 <5467e66d-55de-ca8f-c1ae-ffe6efe7290d@redhat.com>
 <94cd5565-1058-2c97-57bb-0ddf12416cd6@redhat.com>
 <2ac0b871-60d0-c535-3fe0-bfaa0d9f7685@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <2ac0b871-60d0-c535-3fe0-bfaa0d9f7685@suse.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue 2022-11-29 14:13:37, Petr Pavlu wrote:
> On 11/28/22 17:29, Prarit Bhargava wrote:
> > On 11/14/22 10:45, David Hildenbrand wrote:
> >> On 14.11.22 16:38, Luis Chamberlain wrote:
> >>> On Mon, Nov 14, 2022 at 09:57:56AM +0100, David Hildenbrand wrote:
> >>>> On 12.11.22 02:47, Luis Chamberlain wrote:
> >>>>> On Wed, Oct 19, 2022 at 02:00:55PM +0200, Petr Pavlu wrote:
> >>>>>> On 10/18/22 20:33, Luis Chamberlain wrote:
> >>>>>>> On Sat, Oct 15, 2022 at 11:27:10AM +0200, Petr Pavlu wrote:
> >>>>>>>> The patch does address a regression observed after commit 
> >>>>>>>> 6e6de3dee51a
> >>>>>>>> ("kernel/module.c: Only return -EEXIST for modules that have 
> >>>>>>>> finished
> >>>>>>>> loading"). I guess it can have a Fixes tag added to the patch.
> >>>>>>>>
> >>>>>>>> I think it is hard to split this patch into parts because the 
> >>>>>>>> implemented
> >>>>>>>> "optimization" is the fix.
> >>>>>>>
> >>>>>>> git describe --contains 6e6de3dee51a
> >>>>>>> v5.3-rc1~38^2~6
> >>>>>>>
> >>>>>>> I'm a bit torn about this situation. Reverting 6e6de3dee51a would 
> >>>>>>> be the
> >>>>>>> right thing to do, but without it, it still leaves the issue reported
> >>>>>>> by Prarit Bhargava. We need a way to resolve the issue on stable and
> >>>>>>> then your optimizations can be applied on top.
> >>>>>>
> >>>>>> Simpler could be to do the following:
> >>>>>>
> >>>>>> diff --git a/kernel/module/main.c b/kernel/module/main.c
> >>>>>> index d02d39c7174e..0302ac387e93 100644
> >>>>>> --- a/kernel/module/main.c
> >>>>>> +++ b/kernel/module/main.c
> >>>>>> @@ -2386,7 +2386,8 @@ static bool finished_loading(const char *name)
> >>>>>>        sched_annotate_sleep();
> >>>>>>        mutex_lock(&module_mutex);
> >>>>>>        mod = find_module_all(name, strlen(name), true);
> >>>>>> -    ret = !mod || mod->state == MODULE_STATE_LIVE;
> >>>>>> +    ret = !mod || mod->state == MODULE_STATE_LIVE
> >>>>>> +        || mod->state == MODULE_STATE_GOING;
> >>>>>>        mutex_unlock(&module_mutex);
> >>>>>>        return ret;
> >>>>>> @@ -2566,7 +2567,8 @@ static int add_unformed_module(struct module 
> >>>>>> *mod)
> >>>>>>        mutex_lock(&module_mutex);
> >>>>>>        old = find_module_all(mod->name, strlen(mod->name), true);
> >>>>>>        if (old != NULL) {
> >>>>>> -        if (old->state != MODULE_STATE_LIVE) {
> >>>>>> +        if (old->state == MODULE_STATE_COMING
> >>>>>> +            || old->state == MODULE_STATE_UNFORMED) {
> >>>>>>                /* Wait in case it fails to load. */
> >>>>>>                mutex_unlock(&module_mutex);
> >>>>>>                err = wait_event_interruptible(module_wq,
> >>>>>> @@ -2575,7 +2577,7 @@ static int add_unformed_module(struct module 
> >>>>>> *mod)
> >>>>>>                    goto out_unlocked;
> >>>>>>                goto again;
> >>>>>>            }
> >>>>>> -        err = -EEXIST;
> >>>>>> +        err = old->state != MODULE_STATE_LIVE ? -EBUSY : -EEXIST;
> >>>>>>            goto out;
> >>>>>>        }
> >>>>>>        mod_update_bounds(mod);
> >>>>>
> >>>>>
> >>>>> Prarit, can you verify this still does not break the issue you 
> >>>>> reported?
> >>>>> David, does this also fix your issue?
> >>>>
> >>>> I didn't try, but from a quick glimpse I assume no. Allocating module 
> >>>> space
> >>>> happens before handling eventual duplicates right now, before a 
> >>>> module even
> >>>> is "alive" and in the MODULE_STATE_UNFORMED state.
> >>>
> >>> The first two hunks are a revert of commit 6e6de3dee51a and I'm under
> >>> the impression that cauased your issues as *more* modules states are
> >>> allowed through.
> >>>
> >>> The last hunk tries to fix what 6e6de3dee51a wanted to do.
> >>>
> >>
> >> Note that I don't think the issue I raised is due to 6e6de3dee51a.
> >>
> >>>> But maybe I am missing something important.
> >>>
> >>> Please do test if you can.
> >>
> >> I don't have the machine at hand right now. But, again, I doubt this 
> >> will fix it.
> >>
> >>
> >> The flow is in load_module():
> >>
> >>      mod = layout_and_allocate(info, flags);
> >>      if (IS_ERR(mod)) {
> >>          ...
> >>      }
> >>
> >>      audit_log_kern_module(mod->name);
> >>
> >>      /* Reserve our place in the list. */
> >>      err = add_unformed_module(mod);
> >>      if (err)
> >>          goto free_module;
> >>
> >>
> >> You can have 400 threads in layout_and_allocate() loading the same 
> >> module at the same time and running out of module space. Any changes to 
> >> add_unformed_module() and finished_loading() won't change that, because 
> >> they are not involved before the module space allocations happened.
> >>
> > 
> > I'd like to see a refreshed patch but I tested the latest version and 
> > see that the boot time is LONGER with the change
> > 
> > Before:
> > 
> > [11:17 AM root@intel-eaglestream-spr-15 kernel-ark]# systemd-analyze
> > Startup finished in 55.418s (firmware) + 22.766s (loader) + 35.856s 
> > (kernel) + 5.830s (initrd) + 15.671s (userspace) = 2min 15.542s
> > multi-user.target reached after 15.606s in userspace.
> > 
> > After:
> > 
> > Startup finished in 55.314s (firmware) + 23.033s (loader) + 35.331s 
> > (kernel) + 5.176s (initrd) + 23.465s (userspace) = 2min 22.320s
> > multi-user.target reached after 23.093s in userspace.
> > 
> > Subsequent reboots also indicate that userspace boot time is longer 
> > after the change.
> 
> Thanks for testing this patch, that is an interesting result.
> 
> I see the following dependency chain on my system (openSUSE Tumbleweed):
> multi-user.target -> basic.target -> sysinit.target -> systemd-udev-trigger.service.
> 
> My understanding is that the udev trigger service only performs the trigger
> operation but does not actually wait on all devices to be processed by udevd.
> In other words, handling of the forced udev events can still be in progress
> after multi-user.target is reached.
> 
> The current serialization of same-name module loads can result in many udev
> workers sleeping in add_unformed_module() and hence creating at that point
> less pressure on the CPU time from udevd. I wonder if this then maybe allows
> other work needed to reach multi-user.target to proceed faster.

Interesting theory.

Another idea. The module loader newly returns -EBUSY. I could imagine
that userspace might handle this return value a special way and try
to load the module once again.

It might make sense to test it with the updated version of the patch.
This one is racy. It returns -EBUSY only when the waiting module loader
sees the failed module loader in GOING state.

> Could you please boot the machine with 'udev.log_level=debug' and provide me
> logs ('journalctl -b -o short-monotonic') from a run with the vanilla kernel
> and with the discussed patch?

I am curious what happens here.

Best Regards,
Petr
