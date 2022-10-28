Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9414E610C49
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Oct 2022 10:34:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229908AbiJ1Ier (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Oct 2022 04:34:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33798 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229629AbiJ1Ien (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Oct 2022 04:34:43 -0400
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 861EB1C42D
        for <linux-kernel@vger.kernel.org>; Fri, 28 Oct 2022 01:34:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1666946082; x=1698482082;
  h=from:to:cc:subject:references:date:in-reply-to:
   message-id:mime-version;
  bh=I7+l1li97AG1W4nCdyskwIa37THe0xzjljy5/l3afeQ=;
  b=KQRhi/nIPXbyx53oWRDRqu2cA9MhLAeG0TQrztfQ6uyb6ItQ1zSs/lLC
   4YI/UkxHBHGuM2VXpxE1h7uqs6oPKNpCBYBDb24T3j6TejBUnsEAnAXR4
   2ZCGmOShB3ZZfcljjPTW/+hNPlRb7lBrn5s7FToQErET+iaO1S7H5ELe3
   OvMvgYtTmXwo3uOlXFErMDJYuHv6QerA76VOL7nj1KZP+3k/FAD15IPCD
   GG21PPh5yIiMiqO2YknRAzZMG1Hekl1bpS8AeVR+8RK7Azh1SB0sh0Pcl
   7erpAHPqcebpFmiCkvmYt5jrLOoeQGJCPv1QMsMejY2carzpYhe2U2lkH
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10513"; a="335083761"
X-IronPort-AV: E=Sophos;i="5.95,220,1661842800"; 
   d="scan'208";a="335083761"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Oct 2022 01:34:41 -0700
X-IronPort-AV: E=McAfee;i="6500,9779,10513"; a="632708139"
X-IronPort-AV: E=Sophos;i="5.95,220,1661842800"; 
   d="scan'208";a="632708139"
Received: from yhuang6-desk2.sh.intel.com (HELO yhuang6-desk2.ccr.corp.intel.com) ([10.238.208.55])
  by orsmga002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Oct 2022 01:34:37 -0700
From:   "Huang, Ying" <ying.huang@intel.com>
To:     Bharata B Rao <bharata@amd.com>
Cc:     Aneesh Kumar K V <aneesh.kumar@linux.ibm.com>,
        <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Alistair Popple <apopple@nvidia.com>,
        "Dan Williams" <dan.j.williams@intel.com>,
        Dave Hansen <dave.hansen@intel.com>,
        Davidlohr Bueso <dave@stgolabs.net>,
        Hesham Almatary <hesham.almatary@huawei.com>,
        Jagdish Gediya <jvgediya.oss@gmail.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Michal Hocko <mhocko@kernel.org>,
        Tim Chen <tim.c.chen@intel.com>, Wei Xu <weixugc@google.com>,
        Yang Shi <shy828301@gmail.com>
Subject: Re: [RFC] memory tiering: use small chunk size and more tiers
References: <20221027065925.476955-1-ying.huang@intel.com>
        <578c9b89-10eb-1e23-8868-cdd6685d8d4e@linux.ibm.com>
        <877d0kk5uf.fsf@yhuang6-desk2.ccr.corp.intel.com>
        <59291b98-6907-0acf-df11-6d87681027cc@linux.ibm.com>
        <8735b8jy9k.fsf@yhuang6-desk2.ccr.corp.intel.com>
        <0d938c9f-c810-b10a-e489-c2b312475c52@amd.com>
Date:   Fri, 28 Oct 2022 16:33:48 +0800
In-Reply-To: <0d938c9f-c810-b10a-e489-c2b312475c52@amd.com> (Bharata B. Rao's
        message of "Fri, 28 Oct 2022 13:34:46 +0530")
Message-ID: <87tu3oibyr.fsf@yhuang6-desk2.ccr.corp.intel.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=ascii
X-Spam-Status: No, score=-7.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Bharata B Rao <bharata@amd.com> writes:

> On 10/28/2022 11:16 AM, Huang, Ying wrote:
>> If my understanding were correct, you think the latency / bandwidth of
>> these NUMA nodes will near each other, but may be different.
>> 
>> Even if the latency / bandwidth of these NUMA nodes isn't exactly same,
>> we should deal with that in memory types instead of memory tiers.
>> There's only one abstract distance for each memory type.
>> 
>> So, I still believe we will not have many memory tiers with my proposal.
>> 
>> I don't care too much about the exact number, but want to discuss some
>> general design choice,
>> 
>> a) Avoid to group multiple memory types into one memory tier by default
>>    at most times.
>
> Do you expect the abstract distances of two different types to be
> close enough in real life (like you showed in your example with
> CXL - 5000 and PMEM - 5100) that they will get assigned into same tier
> most times?
>
> Are you foreseeing that abstract distance that get mapped by sources
> like HMAT would run into this issue?

Only if we set abstract distance chunk size large.  So, I think that
it's better to set chunk size as small as possible to avoid potential
issue.  What is the downside to set the chunk size small?

Best Regards,
Huang, Ying
