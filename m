Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4E4945E753B
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Sep 2022 09:53:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230409AbiIWHxJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Sep 2022 03:53:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43736 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230469AbiIWHxF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Sep 2022 03:53:05 -0400
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8AFB912CCB9
        for <linux-kernel@vger.kernel.org>; Fri, 23 Sep 2022 00:53:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1663919584; x=1695455584;
  h=from:to:cc:subject:references:date:in-reply-to:
   message-id:mime-version;
  bh=RRq3GIYX0K2ybEJZ1gFU38FbFEL6Oayfi9B31K5s1kU=;
  b=mY0E8AoaOc77d/EDCORXBsT2t1wWQ+8GVjdNVMi9wUYRF2bXx/oEkjlP
   1Txp0akOVrEbxuoAldl9rEBive4tmcBryA6dvnplPk56OokVfElwEqpU4
   Y5zv1ogSMpwXwPflrhWTugutm1U4EfKMRtS/GlKVgokyXR1zkxYqt/vth
   hg+cLsZOK/9YI+YSg7Us9aPG5/+Hf09Qtp9q6u0jGLz5KbbENij0yzhZW
   Q6oshVzCOPwnz5D2+/Hmf+GQKa/zlgzqVFN3sM4svkfPNF/YUVygbZSqU
   Nmx5gHjkygmVb8oPMbRxBOHqoQPFccYuXjwYdXutsCHu/si3BbEWsMiTe
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10478"; a="283633256"
X-IronPort-AV: E=Sophos;i="5.93,337,1654585200"; 
   d="scan'208";a="283633256"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Sep 2022 00:53:04 -0700
X-IronPort-AV: E=Sophos;i="5.93,337,1654585200"; 
   d="scan'208";a="762530091"
Received: from yhuang6-desk2.sh.intel.com (HELO yhuang6-desk2.ccr.corp.intel.com) ([10.238.208.55])
  by fmsmga001-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Sep 2022 00:53:01 -0700
From:   "Huang, Ying" <ying.huang@intel.com>
To:     Bharata B Rao <bharata@amd.com>
Cc:     <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Zi Yan <ziy@nvidia.com>, Yang Shi <shy828301@gmail.com>,
        Baolin Wang <baolin.wang@linux.alibaba.com>,
        Oscar Salvador <osalvador@suse.de>,
        "Matthew Wilcox" <willy@infradead.org>
Subject: Re: [RFC 0/6] migrate_pages(): batch TLB flushing
References: <20220921060616.73086-1-ying.huang@intel.com>
        <477e50ab-9045-0ca2-6979-e2dca71be263@amd.com>
Date:   Fri, 23 Sep 2022 15:52:52 +0800
In-Reply-To: <477e50ab-9045-0ca2-6979-e2dca71be263@amd.com> (Bharata B. Rao's
        message of "Thu, 22 Sep 2022 18:20:28 +0530")
Message-ID: <87bkr6jzmz.fsf@yhuang6-desk2.ccr.corp.intel.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=ascii
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Bharata B Rao <bharata@amd.com> writes:

> On 9/21/2022 11:36 AM, Huang Ying wrote:
>> From: "Huang, Ying" <ying.huang@intel.com>
>> 
>> Now, migrate_pages() migrate pages one by one, like the fake code as
>> follows,
>> 
>>   for each page
>>     unmap
>>     flush TLB
>>     copy
>>     restore map
>> 
>> If multiple pages are passed to migrate_pages(), there are
>> opportunities to batch the TLB flushing and copying.  That is, we can
>> change the code to something as follows,
>> 
>>   for each page
>>     unmap
>>   for each page
>>     flush TLB
>>   for each page
>>     copy
>>   for each page
>>     restore map
>> 
>> The total number of TLB flushing IPI can be reduced considerably.  And
>> we may use some hardware accelerator such as DSA to accelerate the
>> page copying.
>> 
>> So in this patch, we refactor the migrate_pages() implementation and
>> implement the TLB flushing batching.  Base on this, hardware
>> accelerated page copying can be implemented.
>> 
>> If too many pages are passed to migrate_pages(), in the naive batched
>> implementation, we may unmap too many pages at the same time.  The
>> possibility for a task to wait for the migrated pages to be mapped
>> again increases.  So the latency may be hurt.  To deal with this
>> issue, the max number of pages be unmapped in batch is restricted to
>> no more than HPAGE_PMD_NR.  That is, the influence is at the same
>> level of THP migration.
>
> Thanks for the patchset. I find it hitting the following BUG() when
> running mmtests/autonumabench:
>
> kernel BUG at mm/migrate.c:2432!
> invalid opcode: 0000 [#1] PREEMPT SMP NOPTI
> CPU: 7 PID: 7150 Comm: numa01 Not tainted 6.0.0-rc5+ #171
> Hardware name: Dell Inc. PowerEdge R6525/024PW1, BIOS 2.5.6 10/06/2021
> RIP: 0010:migrate_misplaced_page+0x670/0x830 
> Code: 36 48 8b 3c c5 e0 7a 19 8d e8 dc 10 f7 ff 4c 89 e7 e8 f4 43 f5 ff 8b 55 bc 85 d2 75 6f 48 8b 45 c0 4c 39 e8 0f 84 b0 fb ff ff <0f> 0b 48 8b 7d 90 e9 ec fc ff ff 48 83 e8 01 e9 48 fa ff ff 48 83
> RSP: 0000:ffffb1b29ec3fd38 EFLAGS: 00010202
> RAX: ffffe946460f8248 RBX: 0000000000000001 RCX: ffffe946460f8248
> RDX: 0000000000000000 RSI: ffffe946460f8248 RDI: ffffb1b29ec3fce0
> RBP: ffffb1b29ec3fda8 R08: 0000000000000000 R09: 0000000000000005
> R10: 0000000000000001 R11: 0000000000000000 R12: ffffe946460f8240
> R13: ffffb1b29ec3fd68 R14: 0000000000000001 R15: ffff9698beed5000
> FS:  00007fcc31fee640(0000) GS:ffff9697b0000000(0000) knlGS:0000000000000000
> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> CR2: 00007fcc3a3a5000 CR3: 000000016e89c002 CR4: 0000000000770ee0
> PKRU: 55555554
> Call Trace:
>  <TASK>
>  __handle_mm_fault+0xb87/0xff0
>  handle_mm_fault+0x126/0x3c0
>  do_user_addr_fault+0x1ed/0x690
>  exc_page_fault+0x84/0x2c0
>  asm_exc_page_fault+0x27/0x30 
> RIP: 0033:0x7fccfa1a1180
> Code: 81 fa 80 00 00 00 76 d2 c5 fe 7f 40 40 c5 fe 7f 40 60 48 83 c7 80 48 81 fa 00 01 00 00 76 2b 48 8d 90 80 00 00 00 48 83 e2 c0 <c5> fd 7f 02 c5 fd 7f 42 20 c5 fd 7f 42 40 c5 fd 7f 42 60 48 83 ea
> RSP: 002b:00007fcc31fede38 EFLAGS: 00010283
> RAX: 00007fcc39fff010 RBX: 000000000000002c RCX: 00007fccfa11ea3d
> RDX: 00007fcc3a3a5000 RSI: 0000000000000000 RDI: 00007fccf9ffef90
> RBP: 00007fcc39fff010 R08: 00007fcc31fee640 R09: 00007fcc31fee640
> R10: 00007ffdecef614f R11: 0000000000000246 R12: 00000000c0000000
> R13: 0000000000000000 R14: 00007fccfa094850 R15: 00007ffdecef6190
>
> This is BUG_ON(!list_empty(&migratepages)) in migrate_misplaced_page().

Thank you very much for reporting!  I haven't reproduced this yet.  But
I will pay special attention to this when develop the next version, even
if I cannot reproduce this finally.

Best Regards,
Huang, Ying
