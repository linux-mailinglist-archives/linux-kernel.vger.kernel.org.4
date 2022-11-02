Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D2576615DAB
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Nov 2022 09:28:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230315AbiKBI24 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Nov 2022 04:28:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34496 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229561AbiKBI2w (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Nov 2022 04:28:52 -0400
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7DB9313E31
        for <linux-kernel@vger.kernel.org>; Wed,  2 Nov 2022 01:28:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1667377731; x=1698913731;
  h=from:to:cc:subject:references:date:in-reply-to:
   message-id:mime-version;
  bh=QOcqKq3LeDc4b3+vhsnKQIF0ZdWtllvhnZ+gxttaUdg=;
  b=GE9IM4LpPCY2Yt1pz+PO35nY3/FiAOY/g6SEYv0JgmwFjPFBZUMDiGfk
   /Fn1xoqZWunidyYks2zbEpdyPlOA1VRi21a4zrW/6rzVItrN9xho8sG7F
   byD2fvYNMJTUgI4TnXHm70utvoOBu00pnMmXnrdlgWJvZ2xVm9utDd2Y5
   AaxZDx+2dEsgmdSMrKueEf9KcFla1lh7Y57T2aosovxLbFYL3HyHQPM6y
   0j0qkscKnIa/HMV2vhcUBTBp+fee9X8FgiwOUHEpGSXNNrvV1fQycOX9y
   pnRdJiHxsfbm83z7bEt3d6WVM7VvT3Wv+48JrqQqf/WR1oj/uSSTvHSTr
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10518"; a="310451582"
X-IronPort-AV: E=Sophos;i="5.95,232,1661842800"; 
   d="scan'208";a="310451582"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Nov 2022 01:28:51 -0700
X-IronPort-AV: E=McAfee;i="6500,9779,10518"; a="809194684"
X-IronPort-AV: E=Sophos;i="5.95,232,1661842800"; 
   d="scan'208";a="809194684"
Received: from yhuang6-desk2.sh.intel.com (HELO yhuang6-desk2.ccr.corp.intel.com) ([10.238.208.55])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Nov 2022 01:28:47 -0700
From:   "Huang, Ying" <ying.huang@intel.com>
To:     Michal Hocko <mhocko@suse.com>
Cc:     Bharata B Rao <bharata@amd.com>,
        Aneesh Kumar K V <aneesh.kumar@linux.ibm.com>,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Alistair Popple <apopple@nvidia.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Dave Hansen <dave.hansen@intel.com>,
        Davidlohr Bueso <dave@stgolabs.net>,
        Hesham Almatary <hesham.almatary@huawei.com>,
        Jagdish Gediya <jvgediya.oss@gmail.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Tim Chen <tim.c.chen@intel.com>, Wei Xu <weixugc@google.com>,
        Yang Shi <shy828301@gmail.com>
Subject: Re: [RFC] memory tiering: use small chunk size and more tiers
References: <59291b98-6907-0acf-df11-6d87681027cc@linux.ibm.com>
        <8735b8jy9k.fsf@yhuang6-desk2.ccr.corp.intel.com>
        <0d938c9f-c810-b10a-e489-c2b312475c52@amd.com>
        <87tu3oibyr.fsf@yhuang6-desk2.ccr.corp.intel.com>
        <07912a0d-eb91-a6ef-2b9d-74593805f29e@amd.com>
        <87leowepz6.fsf@yhuang6-desk2.ccr.corp.intel.com>
        <Y2Eui+kKvwj8ip+T@dhcp22.suse.cz>
        <878rkuchpm.fsf@yhuang6-desk2.ccr.corp.intel.com>
        <Y2IhiSnpQsmY7khx@dhcp22.suse.cz>
        <87bkppbx75.fsf@yhuang6-desk2.ccr.corp.intel.com>
        <Y2Inot4i4xUGH60O@dhcp22.suse.cz>
Date:   Wed, 02 Nov 2022 16:28:08 +0800
In-Reply-To: <Y2Inot4i4xUGH60O@dhcp22.suse.cz> (Michal Hocko's message of
        "Wed, 2 Nov 2022 09:17:38 +0100")
Message-ID: <877d0dbw13.fsf@yhuang6-desk2.ccr.corp.intel.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=ascii
X-Spam-Status: No, score=-5.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Michal Hocko <mhocko@suse.com> writes:

> On Wed 02-11-22 16:02:54, Huang, Ying wrote:
>> Michal Hocko <mhocko@suse.com> writes:
>> 
>> > On Wed 02-11-22 08:39:49, Huang, Ying wrote:
>> >> Michal Hocko <mhocko@suse.com> writes:
>> >> 
>> >> > On Mon 31-10-22 09:33:49, Huang, Ying wrote:
>> >> > [...]
>> >> >> In the upstream implementation, 4 tiers are possible below DRAM.  That's
>> >> >> enough for now.  But in the long run, it may be better to define more.
>> >> >> 100 possible tiers below DRAM may be too extreme.
>> >> >
>> >> > I am just curious. Is any configurations with more than couple of tiers
>> >> > even manageable? I mean applications have been struggling even with
>> >> > regular NUMA systems for years and vast majority of them is largerly
>> >> > NUMA unaware. How are they going to configure for a more complex system
>> >> > when a) there is no resource access control so whatever you aim for
>> >> > might not be available and b) in which situations there is going to be a
>> >> > demand only for subset of tears (GPU memory?) ?
>> >> 
>> >> Sorry for confusing.  I think that there are only several (less than 10)
>> >> tiers in a system in practice.  Yes, here, I suggested to define 100 (10
>> >> in the later text) POSSIBLE tiers below DRAM.  My intention isn't to
>> >> manage a system with tens memory tiers.  Instead, my intention is to
>> >> avoid to put 2 memory types into one memory tier by accident via make
>> >> the abstract distance range of each memory tier as small as possible.
>> >> More possible memory tiers, smaller abstract distance range of each
>> >> memory tier.
>> >
>> > TBH I do not really understand how tweaking ranges helps anything.
>> > IIUC drivers are free to assign any abstract distance so they will clash
>> > without any higher level coordination.
>> 
>> Yes.  That's possible.  Each memory tier corresponds to one abstract
>> distance range.  The larger the range is, the higher the possibility of
>> clashing is.  So I suggest to make the abstract distance range smaller
>> to reduce the possibility of clashing.
>
> I am sorry but I really do not understand how the size of the range
> actually addresses a fundamental issue that each driver simply picks
> what it wants. Is there any enumeration defining basic characteristic of
> each tier? How does a driver developer knows which tear to assign its
> driver to?

The smaller range size will not guarantee anything.  It just tries to
help the default behavior.

The drivers are expected to assign the abstract distance based on the
memory latency/bandwidth, etc.  And the abstract distance range of a
memory tier corresponds to a memory latency/bandwidth range too.  So, if
the size of the abstract distance range is smaller, the possibility for
two types of memory with different latency/bandwidth to clash on
the abstract distance range is lower.

Clashing isn't a totally disaster.  We plan to provide a per-memory-type
knob to offset the abstract distance provided by driver.  Then, we can
move clashing memory types away if necessary.

Best Regards,
Huang, Ying
