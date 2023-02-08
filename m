Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AC7D968EDE5
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Feb 2023 12:26:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230388AbjBHL0Z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Feb 2023 06:26:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55784 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230040AbjBHL0X (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Feb 2023 06:26:23 -0500
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B19CEF9
        for <linux-kernel@vger.kernel.org>; Wed,  8 Feb 2023 03:26:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1675855581; x=1707391581;
  h=from:to:cc:subject:references:date:in-reply-to:
   message-id:mime-version:content-transfer-encoding;
  bh=FTe/GG29MPPR23/33mg82vShTieQSngtw32ZKh9+Ky8=;
  b=XDafRfjlg3FxuCj8/z7u3/373jtDZ9DwCrASpUntdotILrjajmUFg22y
   ZOrickaprxJhnKleSwWG0o6Tf8ZJc01Ro9KeewW99GPPbDAdds2fXd9rc
   i/gEhsX2m2fuFpuighJi/ntGBXaEc3HkWC2SwaPWh7yuQ+pEVE7oUNvIy
   WjZP1Fso4L0s0HuvazmgA45NCTm6WaV6bX+P5byOdC/ZGBDLZIDGPFUTQ
   HBXhMvseWw4tPSz778lWBc//vVsE54ys0jnuoUfX/k8Wepb/cdKj+6Vxy
   tMoLfTT0AqFHhAY9UcXUoGGh9YQzg7aXwhqMta+pMtSP+JeWT8X/BROWu
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10614"; a="415993673"
X-IronPort-AV: E=Sophos;i="5.97,280,1669104000"; 
   d="scan'208";a="415993673"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Feb 2023 03:26:05 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10614"; a="667209521"
X-IronPort-AV: E=Sophos;i="5.97,280,1669104000"; 
   d="scan'208";a="667209521"
Received: from yhuang6-desk2.sh.intel.com (HELO yhuang6-desk2.ccr.corp.intel.com) ([10.238.208.55])
  by orsmga002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Feb 2023 03:26:02 -0800
From:   "Huang, Ying" <ying.huang@intel.com>
To:     haoxin <xhao@linux.alibaba.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>, <linux-mm@kvack.org>,
        <linux-kernel@vger.kernel.org>, Zi Yan <ziy@nvidia.com>,
        Yang Shi <shy828301@gmail.com>,
        Baolin Wang <baolin.wang@linux.alibaba.com>,
        Oscar Salvador <osalvador@suse.de>,
        "Matthew Wilcox" <willy@infradead.org>,
        Bharata B Rao <bharata@amd.com>,
        "Alistair Popple" <apopple@nvidia.com>,
        Minchan Kim <minchan@kernel.org>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Hyeonggon Yoo <42.hyeyoo@gmail.com>
Subject: Re: [PATCH -v4 0/9] migrate_pages(): batch TLB flushing
References: <20230206063313.635011-1-ying.huang@intel.com>
        <b01e8657-76bd-71e6-929a-4b1131d1aebd@linux.alibaba.com>
Date:   Wed, 08 Feb 2023 19:25:02 +0800
In-Reply-To: <b01e8657-76bd-71e6-929a-4b1131d1aebd@linux.alibaba.com>
        (haoxin's message of "Wed, 8 Feb 2023 14:21:48 +0800")
Message-ID: <87cz6kh01d.fsf@yhuang6-desk2.ccr.corp.intel.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=ascii
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

haoxin <xhao@linux.alibaba.com> writes:

> On my arm64 server with 128 cores, 2 numa nodes.
>
> I used memhog as benchmark :
>
>   numactl -m -C 5 memhog -r100000 1G
>
> The test result as below:
>
> With this patch:
>
>   #time migratepages 8490 0 1
>
>   real 0m1.161s
>
>   user 0m0.000s
>
>   sys 0m1.161s
>
> without this patch:
>
>   #time migratepages 8460 0 1
>
>   real 0m2.068s
>
>   user 0m0.001s
>
>   sys 0m2.068s
>
> So you can see the migration performance improvement about *+78%*
>
> This is the perf record info.
>
> w/o
> +  51.07%   0.09% migratepages
> [kernel.kallsyms] [k] migrate_folio_extra
> +  42.43%   0.04% migratepages [kernel.kallsyms] [k] folio_copy
> +  42.34%  42.34% migratepages [kernel.kallsyms] [k] __pi_copy_page
> +  33.99%   0.09% migratepages [kernel.kallsyms] [k] rmap_walk_anon
> +  32.35%   0.04% migratepages [kernel.kallsyms] [k] try_to_migrate
> *+  27.78%  27.78% migratepages
>  [kernel.kallsyms] [k] ptep_clear_flush *
> +  8.19%   6.64% migratepages
> [kernel.kallsyms] [k] folio_migrate_flagsmigrati_tlb_flush
>
> w/ this patch
> +  18.57%   0.13%
> migratepages   [kernel.kallsyms]  [k]
> migrate_pages
> +  18.23%   0.07%
> migratepages   [kernel.kallsyms]  [k]
> migrate_pages_batch
> +  16.29%   0.13%
> migratepages   [kernel.kallsyms]  [k]
> migrate_folio_move
> +  12.73%   0.10%
> migratepages   [kernel.kallsyms]  [k]
> move_to_new_folio
> +  12.52%   0.06%
> migratepages   [kernel.kallsyms]  [k]
> migrate_folio_extra
>
> Therefore, this patch helps improve performance in page migration
>
>
> So, you can add Tested-by: Xin Hao <xhao@linux.alibaba.com>

Thank you very much!

Best Regards,
Huang, Ying

>
> ( 2023/2/6 H2:33, Huang Ying S:
>> From: "Huang, Ying"<ying.huang@intel.com>
>>
>> Now, migrate_pages() migrate folios one by one, like the fake code as
>> follows,
>>
>>    for each folio
>>      unmap
>>      flush TLB
>>      copy
>>      restore map
>>
>> If multiple folios are passed to migrate_pages(), there are
>> opportunities to batch the TLB flushing and copying.  That is, we can
>> change the code to something as follows,
>>
>>    for each folio
>>      unmap
>>    for each folio
>>      flush TLB
>>    for each folio
>>      copy
>>    for each folio
>>      restore map
>>
>> The total number of TLB flushing IPI can be reduced considerably.  And
>> we may use some hardware accelerator such as DSA to accelerate the
>> folio copying.
>>
>> So in this patch, we refactor the migrate_pages() implementation and
>> implement the TLB flushing batching.  Base on this, hardware
>> accelerated folio copying can be implemented.
>>
>> If too many folios are passed to migrate_pages(), in the naive batched
>> implementation, we may unmap too many folios at the same time.  The
>> possibility for a task to wait for the migrated folios to be mapped
>> again increases.  So the latency may be hurt.  To deal with this
>> issue, the max number of folios be unmapped in batch is restricted to
>> no more than HPAGE_PMD_NR in the unit of page.  That is, the influence
>> is at the same level of THP migration.
>>
>> We use the following test to measure the performance impact of the
>> patchset,
>>
>> On a 2-socket Intel server,
>>
>>   - Run pmbench memory accessing benchmark
>>
>>   - Run `migratepages` to migrate pages of pmbench between node 0 and
>>     node 1 back and forth.
>>
>> With the patch, the TLB flushing IPI reduces 99.1% during the test and
>> the number of pages migrated successfully per second increases 291.7%.
>>
>> This patchset is based on v6.2-rc4.
>>
>> Changes:
>>
>> v4:
>>
>> - Fixed another bug about non-LRU folio migration.  Thanks Hyeonggon!
>>
>> v3:
>>
>> - Rebased on v6.2-rc4
>>
>> - Fixed a bug about non-LRU folio migration.  Thanks Mike!
>>
>> - Fixed some comments.  Thanks Baolin!
>>
>> - Collected reviewed-by.
>>
>> v2:
>>
>> - Rebased on v6.2-rc3
>>
>> - Fixed type force cast warning.  Thanks Kees!
>>
>> - Added more comments and cleaned up the code.  Thanks Andrew, Zi, Alistair, Dan!
>>
>> - Collected reviewed-by.
>>
>> from rfc to v1:
>>
>> - Rebased on v6.2-rc1
>>
>> - Fix the deadlock issue caused by locking multiple pages synchronously
>>    per Alistair's comments.  Thanks!
>>
>> - Fix the autonumabench panic per Rao's comments and fix.  Thanks!
>>
>> - Other minor fixes per comments. Thanks!
>>
>> Best Regards,
>> Huang, Ying
