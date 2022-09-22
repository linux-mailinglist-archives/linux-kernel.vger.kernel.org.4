Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9CDBA5E5836
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Sep 2022 03:45:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231150AbiIVBpV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Sep 2022 21:45:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43964 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229789AbiIVBpQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Sep 2022 21:45:16 -0400
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D4E93A0301
        for <linux-kernel@vger.kernel.org>; Wed, 21 Sep 2022 18:45:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1663811114; x=1695347114;
  h=from:to:cc:subject:references:date:in-reply-to:
   message-id:mime-version;
  bh=cP0K3eAQqdbj1b/k8WOSKUEnweFpdWclpBELpkHlMOs=;
  b=MijQxvtvN2gpoPY+Ddjo5mjGOTv8WsO4voag8Hjz8aNa8nIksp9BaIUL
   dETZWEAJMIWDB287xIfoCWOeURulAvpk2aNO4iI2G+Ua4yr57LzSjUF4c
   PlGY7XSTo17mV2liqOzUKiDLXt2/f6qEmwndF66ece80EpJr++GHu1mYY
   kwjSlfWpstwEtTGTnijr8lXTWPpESDgdNxAxfKZLVHYvHFxe6e2Fk3n0x
   PeI1NPWVPii+WGQ/n3zIhcgXTlwhCnislDrjGneEXkLPJ+d8zuyE3E8FO
   EcikUzukq6L9puu6t7D8NXF4po3o5ZjM+g9Y6b9xyZmBEBJczIjFVsPn0
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10477"; a="279893248"
X-IronPort-AV: E=Sophos;i="5.93,335,1654585200"; 
   d="scan'208";a="279893248"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Sep 2022 18:45:14 -0700
X-IronPort-AV: E=Sophos;i="5.93,335,1654585200"; 
   d="scan'208";a="570774254"
Received: from yhuang6-desk2.sh.intel.com (HELO yhuang6-desk2.ccr.corp.intel.com) ([10.238.208.55])
  by orsmga003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Sep 2022 18:45:12 -0700
From:   "Huang, Ying" <ying.huang@intel.com>
To:     Zi Yan <ziy@nvidia.com>
Cc:     <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Yang Shi <shy828301@gmail.com>,
        Baolin Wang <baolin.wang@linux.alibaba.com>,
        Oscar Salvador <osalvador@suse.de>,
        "Matthew Wilcox" <willy@infradead.org>
Subject: Re: [RFC 0/6] migrate_pages(): batch TLB flushing
References: <20220921060616.73086-1-ying.huang@intel.com>
        <FE41BDA8-F7EC-4FBC-9647-A5A835CDECB0@nvidia.com>
Date:   Thu, 22 Sep 2022 09:45:11 +0800
In-Reply-To: <FE41BDA8-F7EC-4FBC-9647-A5A835CDECB0@nvidia.com> (Zi Yan's
        message of "Wed, 21 Sep 2022 11:47:38 -0400")
Message-ID: <878rmckwrc.fsf@yhuang6-desk2.ccr.corp.intel.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=ascii
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Zi Yan <ziy@nvidia.com> writes:

> On 21 Sep 2022, at 2:06, Huang Ying wrote:
>
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
>>
>> We use the following test to measure the performance impact of the
>> patchset,
>>
>> On a 2-socket Intel server,
>>
>>  - Run pmbench memory accessing benchmark
>>
>>  - Run `migratepages` to migrate pages of pmbench between node 0 and
>>    node 1 back and forth.
>>
>> With the patch, the TLB flushing IPI reduces 99.1% during the test and
>> the number of pages migrated successfully per second increases 291.7%.
>
> Thank you for the patchset. Batching page migration will definitely
> improve its throughput from my past experiments[1] and starting with
> TLB flushing is a good first step.

Thanks for the pointer, the patch description provides valuable information
for me already!

> BTW, what is the rationality behind the increased page migration
> success rate per second?

From perf profiling data, in the base kernel,

  migrate_pages.migrate_to_node.do_migrate_pages.kernel_migrate_pages.__x64_sys_migrate_pages:	2.87
  ptep_clear_flush.try_to_migrate_one.rmap_walk_anon.try_to_migrate.__unmap_and_move:           2.39

Because pmbench run in the system too, the CPU cycles of migrate_pages()
is about 2.87%.  While the CPU cycles for TLB flushing is 2.39%.  That
is, 2.39/2.87 = 83.3% CPU cycles of migrate_pages() are used for TLB
flushing.

After batching the TLB flushing, the perf profiling data becomes,

  migrate_pages.migrate_to_node.do_migrate_pages.kernel_migrate_pages.__x64_sys_migrate_pages:	2.77
  move_to_new_folio.migrate_pages_batch.migrate_pages.migrate_to_node.do_migrate_pages:         1.68
  copy_page.folio_copy.migrate_folio.move_to_new_folio.migrate_pages_batch:                     1.21

1.21/2.77 = 43.7% CPU cycles of migrate_pages() are used for page
copying now.

  try_to_migrate_one:	0.23

The CPU cycles of unmapping and TLB flushing becomes 0.23/2.77 = 8.3% of
migrate_pages().

All in all, after the optimization, we do much less TLB flushing, which
consumes a lot of CPU cycles before the optimization.  So the throughput
of migrate_pages() increases greatly.

I will add these data in the next version of patch.

Best Regards,
Huang, Ying

>>
>> This patchset is based on v6.0-rc5 and the following patchset,
>>
>> [PATCH -V3 0/8] migrate_pages(): fix several bugs in error path
>> https://lore.kernel.org/lkml/20220817081408.513338-1-ying.huang@intel.com/
>>
>> The migrate_pages() related code is converting to folio now. So this
>> patchset cannot apply recent akpm/mm-unstable branch.  This patchset
>> is used to check the basic idea.  If it is OK, I will rebase the
>> patchset on top of folio changes.
>>
>> Best Regards,
>> Huang, Ying
>
>
> [1] https://lwn.net/Articles/784925/
>
> --
> Best Regards,
> Yan, Zi
