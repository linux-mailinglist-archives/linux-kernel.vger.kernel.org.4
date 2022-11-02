Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D5E16615D46
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Nov 2022 09:03:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230394AbiKBID4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Nov 2022 04:03:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39272 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230342AbiKBIDv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Nov 2022 04:03:51 -0400
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9CD572714E
        for <linux-kernel@vger.kernel.org>; Wed,  2 Nov 2022 01:03:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1667376230; x=1698912230;
  h=from:to:cc:subject:in-reply-to:references:date:
   message-id:mime-version;
  bh=zUefAtldfFyX3o9cPUjfIV+mhHKwUmckyuph/rt9rAA=;
  b=ilJ1HYNiRiUWHBNH+IKNz14bpOhwj7l+0hB4WTH0Jpx31hf1QDsGztzx
   wRfNEa6PD35pz7eVxGhyBy4jxkY4IszsPQ0BY5APIN9HDg/cRioceDwoh
   ht4j/g7nDraVNVFyKXxKNE0Mz7DhxOXwa1CeYe5CBChvHIpvBHQhHUW9J
   uumCh69lfvqNAfOYtcNPS/mSvdBs90tT76Ws4myTWtWpEzhobFlESFXYV
   tAKBPdsyjXHkHu3p1WxIgxiMMN3vw0IYQw9nsMZFkIASuZq35DvRCzYja
   te04CeXRQJtBCIpN4KLEEAdUvI7EPcfaDiqMcPwJKReAJcN3wqAJPP+kY
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10518"; a="336018499"
X-IronPort-AV: E=Sophos;i="5.95,232,1661842800"; 
   d="scan'208";a="336018499"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Nov 2022 01:03:45 -0700
X-IronPort-AV: E=McAfee;i="6500,9779,10518"; a="634167933"
X-IronPort-AV: E=Sophos;i="5.95,232,1661842800"; 
   d="scan'208";a="634167933"
Received: from yhuang6-desk2.sh.intel.com (HELO yhuang6-desk2.ccr.corp.intel.com) ([10.238.208.55])
  by orsmga002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Nov 2022 01:03:40 -0700
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
In-Reply-To: <Y2IhiSnpQsmY7khx@dhcp22.suse.cz> (Michal Hocko's message of
        "Wed, 2 Nov 2022 08:51:37 +0100")
References: <578c9b89-10eb-1e23-8868-cdd6685d8d4e@linux.ibm.com>
        <877d0kk5uf.fsf@yhuang6-desk2.ccr.corp.intel.com>
        <59291b98-6907-0acf-df11-6d87681027cc@linux.ibm.com>
        <8735b8jy9k.fsf@yhuang6-desk2.ccr.corp.intel.com>
        <0d938c9f-c810-b10a-e489-c2b312475c52@amd.com>
        <87tu3oibyr.fsf@yhuang6-desk2.ccr.corp.intel.com>
        <07912a0d-eb91-a6ef-2b9d-74593805f29e@amd.com>
        <87leowepz6.fsf@yhuang6-desk2.ccr.corp.intel.com>
        <Y2Eui+kKvwj8ip+T@dhcp22.suse.cz>
        <878rkuchpm.fsf@yhuang6-desk2.ccr.corp.intel.com>
        <Y2IhiSnpQsmY7khx@dhcp22.suse.cz>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
Date:   Wed, 02 Nov 2022 16:02:54 +0800
Message-ID: <87bkppbx75.fsf@yhuang6-desk2.ccr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ascii
X-Spam-Status: No, score=-8.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Michal Hocko <mhocko@suse.com> writes:

> On Wed 02-11-22 08:39:49, Huang, Ying wrote:
>> Michal Hocko <mhocko@suse.com> writes:
>> 
>> > On Mon 31-10-22 09:33:49, Huang, Ying wrote:
>> > [...]
>> >> In the upstream implementation, 4 tiers are possible below DRAM.  That's
>> >> enough for now.  But in the long run, it may be better to define more.
>> >> 100 possible tiers below DRAM may be too extreme.
>> >
>> > I am just curious. Is any configurations with more than couple of tiers
>> > even manageable? I mean applications have been struggling even with
>> > regular NUMA systems for years and vast majority of them is largerly
>> > NUMA unaware. How are they going to configure for a more complex system
>> > when a) there is no resource access control so whatever you aim for
>> > might not be available and b) in which situations there is going to be a
>> > demand only for subset of tears (GPU memory?) ?
>> 
>> Sorry for confusing.  I think that there are only several (less than 10)
>> tiers in a system in practice.  Yes, here, I suggested to define 100 (10
>> in the later text) POSSIBLE tiers below DRAM.  My intention isn't to
>> manage a system with tens memory tiers.  Instead, my intention is to
>> avoid to put 2 memory types into one memory tier by accident via make
>> the abstract distance range of each memory tier as small as possible.
>> More possible memory tiers, smaller abstract distance range of each
>> memory tier.
>
> TBH I do not really understand how tweaking ranges helps anything.
> IIUC drivers are free to assign any abstract distance so they will clash
> without any higher level coordination.

Yes.  That's possible.  Each memory tier corresponds to one abstract
distance range.  The larger the range is, the higher the possibility of
clashing is.  So I suggest to make the abstract distance range smaller
to reduce the possibility of clashing.

Best Regards,
Huang, Ying
