Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6453F5F7C3B
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Oct 2022 19:28:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229728AbiJGR2y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Oct 2022 13:28:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53346 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229744AbiJGR2q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Oct 2022 13:28:46 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A893F103250
        for <linux-kernel@vger.kernel.org>; Fri,  7 Oct 2022 10:28:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1665163725; x=1696699725;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=NHnB5i4RWyoKJ+nJhPauT1affyiIU+5a47xs9DHrY8Y=;
  b=LqNS7y+GPiBkEACbqZdo2ohh88e8TeHRp7c2whTxm/xsJKBjP334F/U3
   G7DjU8a3E5N47PkEbkvrp63O6p1GSXShdBtpQ8VMXxxq3bID8VB01pNDy
   XOfj1L+uTl9P2wr8Ti3iTj3ON2dyFFlfm7t6/FuDybMtzxbScbqZitYaX
   YO06XmkhzT3KwFC49CldtYV5V1FqAsHIEQ8Ydhase23o8dOQMDLiSLZlH
   2B8UBDS7OgLEGZb+JMqJHl+XQuCK5iMSOR4rMM1b2XwMH83kokqVH0e0J
   Ty9smXialTeABooCWvE1FZOx6oxlP19k1pNRjBT1I59Zum+vfDQ64ojMD
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10493"; a="303771065"
X-IronPort-AV: E=Sophos;i="5.95,167,1661842800"; 
   d="scan'208";a="303771065"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Oct 2022 10:28:45 -0700
X-IronPort-AV: E=McAfee;i="6500,9779,10493"; a="693869769"
X-IronPort-AV: E=Sophos;i="5.95,167,1661842800"; 
   d="scan'208";a="693869769"
Received: from agluck-desk3.sc.intel.com ([172.25.222.78])
  by fmsmga004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Oct 2022 10:28:45 -0700
Date:   Fri, 7 Oct 2022 10:28:44 -0700
From:   Tony Luck <tony.luck@intel.com>
To:     "Yu, Fenghua" <fenghua.yu@intel.com>
Cc:     "Chatre, Reinette" <reinette.chatre@intel.com>,
        Peter Newman <peternewman@google.com>,
        "Eranian, Stephane" <eranian@google.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        James Morse <james.morse@arm.com>,
        Babu Moger <Babu.Moger@amd.com>
Subject: Re: [RFD] resctrl: reassigning a running container's CTRL_MON group
Message-ID: <Y0BhzKkksSjSeE3W@agluck-desk3.sc.intel.com>
References: <CALPaoCj-zav4x6H3ffXo_O+RFan8Qb-uLy-DdtkaQTfuxY4a0w@mail.gmail.com>
 <b2e020b1-f6b2-e236-a042-4eb2fd27d8b0@intel.com>
 <IA1PR11MB6097236CFF891041DBA42ECB9B5F9@IA1PR11MB6097.namprd11.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <IA1PR11MB6097236CFF891041DBA42ECB9B5F9@IA1PR11MB6097.namprd11.prod.outlook.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 07, 2022 at 08:44:53AM -0700, Yu, Fenghua wrote:
> Hi, Peter,
> 
> > On 10/7/2022 3:39 AM, Peter Newman wrote:

> > > The CLOSID management rules would roughly be:
> > >
> > >  1. If an update would cause a CTRL_MON group's config to match that of
> > >     an existing group, the CTRL_MON group's CLOSID should change to that
> > >     of the existing group, where the definition of "match" is: all
> > >     control values match in all domains for all resources, as well as
> > >     the cpu masks matching.

So the micro steps are:

# mkdir newgroup
	# New groups are created with maximum resources. So this might
	# match the root/default group (if the root schemata had not
	# been edited) ... so you could re-use CLOSID=0 for this, or
	# perhaps allocate a new CLOSID
# edit newgroup/schemata
	# if this update makes this schemata match some other group,
	# then update the CLOSID for this group to be same as the other
	# group.
> > >
> > >  2. If an update to a CTRL_MON group sharing a CLOSID with another group
> > >     causes that group to no longer match any others, a new CLOSID must
> > >     be allocated.
	# So you have reference counts for CLOSIDs for how many groups
	# share it. In above example the change to the schemata and
	# alloction of a new CLOSID would decrement the reference count
	# and free the old CLOSID if it goes to zero
> > >
> > >  3. An update to a CTRL_MON group using a non-shared CLOSID which
> > >     continues to not match any others follows the current resctrl
> > >     behavior.
	# An update to a CTRL_MON group that has a CLOSID reference
	# count > 1 would try to allocate a new CLOSID if the new
	# schemata doesn't match any other group. If all CLOSIDs are
	# already in use, the write(2) to the schemata file must fail
	# ... maybe -ENOSPC is the right error code?

Note that if the root/default CTRL_MON had been editted you might not be
able to create a new group (even though you intend to make to match some
existing group and share a CLOSID). Perhaps we could change existing
semantics so that new groups copy the root group schemata instead of
being maximally permissibe with all resources?
> > >
> > > Before I prepare any patches for review, I'm interested in any
> > > comments or suggestions on the use case and solution.
> > >
> > > Are there simpler strategies for reassigning a running container's
> > > tasks to a different CTRL_MON group that we should be considering first?

Do tasks in a container share a "process group"? If they do, then a
simpler option would be some syntax to assign a group to a resctrl group
(perhaps as a negative task-id? or with a "G" prefix??).

Or is there some other simple way to enumerate all the tasks in a
container with some syntax that is convenient for both the user and the
kernel? If there is, then add code to allow something like:
	# echo C{containername} > tasks
and have the resctrl code move all tasks en masse.

Yet another option would be syntax to apply the move recursively to all
descendents of the given task id.

	# echo R{process-id} > tasks

I don't know how complex it would for the kernel to implement this. Or
whether it would meet Google's needs.

> > > Any concerns about the CLOSID-reusing behavior? The hope is existing
> > > users who aren't creating identically-configured CTRL_MON groups would
> > > be minimally impacted. Would it help if the proposed behavior were
> > > opt-in at mount-time?

I would suppose that few users are *deliberatley* creating groups with
identical schemata files (doesn't seem like there is a use case for
this). So I agree with your "minimal impact" assessment.

I think I'd prefer you explore modes for bulk moving tasks in a
container before going to the shared-CLOSID path.

-Tony
