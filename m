Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A495F62688B
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Nov 2022 10:34:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234809AbiKLJeX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 12 Nov 2022 04:34:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34244 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234683AbiKLJeV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 12 Nov 2022 04:34:21 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 31F6E140D8
        for <linux-kernel@vger.kernel.org>; Sat, 12 Nov 2022 01:34:20 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A85A4609EB
        for <linux-kernel@vger.kernel.org>; Sat, 12 Nov 2022 09:34:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 88390C433D6;
        Sat, 12 Nov 2022 09:34:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1668245659;
        bh=65exbud4oDHB8q1YGgMYLfLKD5iC+Ky9YXJn0Mhqr04=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=swyT4o2zFxp9yX7LQ6kGrOCZEhw690k8I8hvkpIUK94p8JaN0qKiAs5xlcBxOa0br
         ju4+bhRxTv4TabkqGzCA9mCCi22DUaG84JOq4l9tw9ElPfGE1qGKlS7OvyPI02jlgr
         2ygXrK24Zn2y4YFJnu8yWDbi8fVSwgm8fou1U9us=
Date:   Sat, 12 Nov 2022 10:34:16 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Liu Shixin <liushixin2@huawei.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] genirq/irqdesc: hide illegible sysfs warning of
 kobject_del()
Message-ID: <Y29omHEr4d/lvW5c@kroah.com>
References: <20221112093939.616270-1-liushixin2@huawei.com>
 <Y29gXLqK2wiu7/WK@kroah.com>
 <137bd5cc-0be9-6228-82e2-a75b53e5a2ae@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <137bd5cc-0be9-6228-82e2-a75b53e5a2ae@huawei.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Nov 12, 2022 at 05:19:50PM +0800, Liu Shixin wrote:
> 
> 
> On 2022/11/12 16:59, Greg Kroah-Hartman wrote:
> > On Sat, Nov 12, 2022 at 05:39:39PM +0800, Liu Shixin wrote:
> >> If irq_sysfs_add() failed, system will report a warning but don't call
> >> kobject_put() to release the descriptor.
> > I can not parse this sentance :(
> irq_sysfs_add() call kobject_add(). If kobject_add() failed, will print "Failed to add kobject for irq".
> But not call kobject_put().

Then fix that.

> >> Then in irq_sysfs_del(), we continue to call kobject_del(). In such
> >> situation, kobject_del() will complains about a object with no parent
> >> like this:
> > Then we should not be calling irq_sysfs_del() if the call failed.  That
> > is the real fix here.
> If so, should I add a variable to record whether kobject has alreadly added or not?

The code itself knows what just failed, handle the error case there
properly.

> >>  kernfs: can not remove 'actions', no directory
> >>  WARNING: CPU: 0 PID: 277 at fs/kernfs/dir.c:1615 kernfs_remove_by_name_ns+0xd5/0xe0
> >> [...]
> >>  Call Trace:
> >>   <TASK>
> >>   remove_files.isra.0+0x3f/0xb0
> >>   sysfs_remove_group+0x68/0xe0
> >>   sysfs_remove_groups+0x41/0x70
> >>   __kobject_del+0x45/0xc0
> >>   kobject_del+0x2a/0x40
> >>   free_desc+0x44/0x70
> >>   irq_free_descs+0x5d/0x90
> >> [...]
> >>
> >> Use kobj->state_in_sysfs to check whether kobject is added succeed. And
> >> if not, we should not call kobject_del().
> > That does not describe what you are doing here at all.
> Sorry, I forget to update...
> >
> >> Signed-off-by: Liu Shixin <liushixin2@huawei.com>
> >> ---
> >>  kernel/irq/irqdesc.c | 3 ++-
> >>  1 file changed, 2 insertions(+), 1 deletion(-)
> >>
> >> diff --git a/kernel/irq/irqdesc.c b/kernel/irq/irqdesc.c
> >> index a91f9001103c..a820d96210d4 100644
> >> --- a/kernel/irq/irqdesc.c
> >> +++ b/kernel/irq/irqdesc.c
> >> @@ -300,10 +300,11 @@ static void irq_sysfs_del(struct irq_desc *desc)
> >>  	/*
> >>  	 * If irq_sysfs_init() has not yet been invoked (early boot), then
> >>  	 * irq_kobj_base is NULL and the descriptor was never added.
> >> +	 * And the descriptor may be added failed.
> >>  	 * kobject_del() complains about a object with no parent, so make
> >>  	 * it conditional.
> >>  	 */
> >> -	if (irq_kobj_base)
> >> +	if (irq_kobj_base && desc->kobj.parent)
> > How would the parent be NULL?  Parent devices always stick around until
> > the child is removed, otherwise something is really wrong here.  You
> > should never have to look at the parent.
> irq_sysfs_add() call kobject_add(). If kobject_add() failed, the parent will be NULL.
> You can find the same check of kobj->parent in cpuid_cpu_offline().

And it is wrong there as well.  Do not copy bad patterns please.

thanks,

greg k-h
