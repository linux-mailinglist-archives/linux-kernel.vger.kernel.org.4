Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CF9166AD4B7
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Mar 2023 03:34:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229973AbjCGCew (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Mar 2023 21:34:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35272 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229953AbjCGCeo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Mar 2023 21:34:44 -0500
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E479A2FCC7
        for <linux-kernel@vger.kernel.org>; Mon,  6 Mar 2023 18:34:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1678156483; x=1709692483;
  h=from:to:cc:subject:references:date:in-reply-to:
   message-id:mime-version;
  bh=o9/WmKr/fBaf6t6X9nBbxEQ4kX/UxKlMVGkwBLuJF7Y=;
  b=ZOL79kA/3g5eG/wS11kgJhQIPdkBTx/o0yDeYrjFSwk+dEUx1IFQL4k7
   z9yPvFMHlk2XO3MZ+AZwoilWHoPCLBRnLPZFHHwbNOZdR4YqGWxzUQzlr
   92MdcTzxMMzQTitTgvXP5M/eWyRF1e34l/VsoMTswN/+kf2t//jDBFQZp
   gNRgJg9ASWYL1N3tcdXB2LxWmextxR6vmWraGhBCGfsyoB/26QrAaL+JT
   zRrBYIE18Qtv4uyLXvGrbi7+3TjSQbKzaO9mVyS7pnCFmQRVBErZafwBq
   1pWA6xlnO5wRCf2M4O/aNUdM027Y9hgou+qsCkA01xMrNjjWhNcyF7rZ8
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10641"; a="333215815"
X-IronPort-AV: E=Sophos;i="5.98,238,1673942400"; 
   d="scan'208";a="333215815"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Mar 2023 18:34:05 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10641"; a="765465850"
X-IronPort-AV: E=Sophos;i="5.98,238,1673942400"; 
   d="scan'208";a="765465850"
Received: from yhuang6-desk2.sh.intel.com (HELO yhuang6-desk2.ccr.corp.intel.com) ([10.238.208.55])
  by fmsmga003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Mar 2023 18:34:01 -0800
From:   "Huang, Ying" <ying.huang@intel.com>
To:     Bharata B Rao <bharata@amd.com>
Cc:     <linux-kernel@vger.kernel.org>, <linux-mm@kvack.org>,
        <mgorman@suse.de>, <peterz@infradead.org>, <mingo@redhat.com>,
        <bp@alien8.de>, <dave.hansen@linux.intel.com>, <x86@kernel.org>,
        <akpm@linux-foundation.org>, <luto@kernel.org>,
        <tglx@linutronix.de>, <yue.li@memverge.com>,
        <Ravikumar.Bangoria@amd.com>
Subject: Re: [RFC PATCH 0/5] Memory access profiler(IBS) driven NUMA balancing
References: <20230208073533.715-1-bharata@amd.com>
        <878rh2b5zt.fsf@yhuang6-desk2.ccr.corp.intel.com>
        <72b6ec8b-f141-3807-d7f2-f853b0f0b76c@amd.com>
        <87zg9i9iw2.fsf@yhuang6-desk2.ccr.corp.intel.com>
        <1547d291-1512-faae-aba5-0f84c3502be4@amd.com>
        <c3e79d2e-97da-726e-bcaa-0258e3ddfafe@amd.com>
        <87zg9c7rrf.fsf@yhuang6-desk2.ccr.corp.intel.com>
        <8fea74ec-8feb-1709-14f2-cecb63fdc9ed@amd.com>
        <87v8jnbl22.fsf@yhuang6-desk2.ccr.corp.intel.com>
        <b19e0c22-c80b-7223-6ed7-472502948fa0@amd.com>
        <87jzzz8tgm.fsf@yhuang6-desk2.ccr.corp.intel.com>
        <41b47cd7-1ba9-3205-165e-02e8384e7064@amd.com>
        <87356m8jo1.fsf@yhuang6-desk2.ccr.corp.intel.com>
        <55a344fa-4325-e82d-eeaa-1a77611ff513@amd.com>
Date:   Tue, 07 Mar 2023 10:33:03 +0800
In-Reply-To: <55a344fa-4325-e82d-eeaa-1a77611ff513@amd.com> (Bharata B. Rao's
        message of "Mon, 6 Mar 2023 21:00:47 +0530")
Message-ID: <87ttyxb89s.fsf@yhuang6-desk2.ccr.corp.intel.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=ascii
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Bharata B Rao <bharata@amd.com> writes:

> On 03-Mar-23 11:23 AM, Huang, Ying wrote:
>> 
>> What is the memory accessing pattern of the workload?  Uniform random or
>> something like Gauss distribution?
>
> Multiple iterations of uniform access from beginning to end of the
> memory region.

I guess this is sequential accesses instead of random accesses with
uniform distribution.

>> 
>> Anyway, it may take some time for the original method to scan enough
>> memory space to trigger enough hint page fault.  We can check
>> numa_pte_updates to check whether enough virtual space has been scanned.
>
> I see that numa_hint_faults is way higher (sometimes close to 5 times)
> than numa_pte_updates. This doesn't make sense. Very rarely I do see
> saner numbers and when that happens the benchmark score is also much better.
>
> Looks like an issue with the default kernel itself. I will debug this
> further and get back.

Yes.  It appears that something is wrong.

Best Regards,
Huang, Ying
