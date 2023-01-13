Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 78B956689B2
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Jan 2023 03:43:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233341AbjAMCnQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Jan 2023 21:43:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58878 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231186AbjAMCnL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Jan 2023 21:43:11 -0500
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E90595D8BC
        for <linux-kernel@vger.kernel.org>; Thu, 12 Jan 2023 18:43:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1673577790; x=1705113790;
  h=from:to:cc:subject:in-reply-to:references:date:
   message-id:mime-version;
  bh=82l/muiOQvveS879TIb4UaFpqF9ucXSfsqtshd/sFx0=;
  b=YLcgZFvFJ9Z9Qg7x8lRMGtxX8vlVgm2SrSQkiHiVA7nVGyzzpicKKREA
   NIGt56NPbn99CB3r0AD/5H6exRULfrVLkpVmikw9lMMC9D3T2kDODzelD
   DrV9zoJE9sK2YncNTGLD89+ghFQ+Rc7NgvHi/7UaW/m8I7NyXM4XITzNG
   45uywm8dGh86e55OnZV/kwxcTlnBU8zIYOAbd9BdOdIYRM3ZX1Ge0raqY
   2VU8/J477NKPiqhq/mV/+ere5Lw+8gEKbMUqaGZQuDx0izFJSX5OddWnd
   2b17CIgAzm4fCyY8n+I6jZNotjlZndUuPao2yCuX8xsom4IVbfCN5JtNP
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10588"; a="325955540"
X-IronPort-AV: E=Sophos;i="5.97,212,1669104000"; 
   d="scan'208";a="325955540"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Jan 2023 18:43:09 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10588"; a="903438148"
X-IronPort-AV: E=Sophos;i="5.97,212,1669104000"; 
   d="scan'208";a="903438148"
Received: from yhuang6-desk2.sh.intel.com (HELO yhuang6-desk2.ccr.corp.intel.com) ([10.238.208.55])
  by fmsmga006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Jan 2023 18:43:06 -0800
From:   "Huang, Ying" <ying.huang@intel.com>
To:     Mike Kravetz <mike.kravetz@oracle.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Zi Yan <ziy@nvidia.com>,
        Yang Shi <shy828301@gmail.com>,
        Baolin Wang <baolin.wang@linux.alibaba.com>,
        Oscar Salvador <osalvador@suse.de>,
        Matthew Wilcox <willy@infradead.org>,
        Bharata B Rao <bharata@amd.com>,
        Alistair Popple <apopple@nvidia.com>,
        haoxin <xhao@linux.alibaba.com>
Subject: Re: [PATCH -v2 0/9] migrate_pages(): batch TLB flushing
In-Reply-To: <Y8ChvzGVG5Tm9tQQ@monkey> (Mike Kravetz's message of "Thu, 12 Jan
        2023 16:11:43 -0800")
References: <20230110075327.590514-1-ying.huang@intel.com>
        <Y74WsWCFGh2wFGji@monkey> <Y782h7t10uRVW0RC@monkey>
        <87a62oy5o9.fsf@yhuang6-desk2.ccr.corp.intel.com>
        <Y79tTXgEeuzzqFho@monkey>
        <87ilhcrzkr.fsf@yhuang6-desk2.ccr.corp.intel.com>
        <Y8ChvzGVG5Tm9tQQ@monkey>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
Date:   Fri, 13 Jan 2023 10:42:08 +0800
Message-ID: <87bkn3rw8v.fsf@yhuang6-desk2.ccr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ascii
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Mike Kravetz <mike.kravetz@oracle.com> writes:

> On 01/12/23 15:17, Huang, Ying wrote:
>> Mike Kravetz <mike.kravetz@oracle.com> writes:
>> 
>> > On 01/12/23 08:09, Huang, Ying wrote:
>> >> Hi, Mike,
>> >> 
>> >> Mike Kravetz <mike.kravetz@oracle.com> writes:
>> >> 
>> >> > On 01/10/23 17:53, Mike Kravetz wrote:
>> >> >> Just saw the following easily reproducible issue on next-20230110.  Have not
>> >> >> verified it is related to/caused by this series, but it looks suspicious.
>> >> >
>> >> > Verified this is caused by the series,
>> >> >
>> >> > 734cbddcfe72 migrate_pages: organize stats with struct migrate_pages_stats
>> >> > to
>> >> > 323b933ba062 migrate_pages: batch flushing TLB
>> >> >
>> >> > in linux-next.
>> >> 
>> >> Thanks for reporting.
>> >> 
>> >> I tried this yesterday (next-20230111), but failed to reproduce it.  Can
>> >> you share your kernel config?  Is there any other setup needed?
>> >
>> > Config file is attached.
>> 
>> Thanks!
>> 
>> > Are you writing a REALLY big value to nr_hugepages?  By REALLY big I
>> > mean a value that is impossible to fulfill.  This will result in
>> > successful hugetlb allocations until __alloc_pages starts to fail.  At
>> > this point we will be stressing compaction/migration trying to find more
>> > contiguous pages.
>> >
>> > Not sure if it matters, but I am running on a 2 node VM.  The 2 nodes
>> > may be important as the hugetlb allocation code will try a little harder
>> > alternating between nodes that may perhaps stress compaction/migration
>> > more.
>> 
>> Tried again on a 2-node machine.  Still cannot reproduce it.
>> 
>> >> BTW: can you bisect to one specific commit which causes the bug in the
>> >> series?
>> >
>> > I should have some time to isolate in the next day or so.
>
> Isolated to patch,
> [PATCH -v2 4/9] migrate_pages: split unmap_and_move() to _unmap() and _move()
>
> Actually, recreated/isolated by just applying this series to v6.2-rc3 in an
> effort to eliminate any possible noise in linux-next.
>
> Spent a little time looking at modifications made there, but nothing stood out.
> Will investigate more as time allows.

Thank you very much!  That's really helpful.

Checked that patch again, found that there's an issue about non-lru
pages.  Do you enable zram in your test system?  Can you try the
below debug patch on top of

[PATCH -v2 4/9] migrate_pages: split unmap_and_move() to _unmap() and _move()

The following patches in series need to be rebased for the below
change.  I will test with zram enabled too.

Best Regards,
Huang, Ying

---------------------------8<------------------------------------------------------
diff --git a/mm/migrate.c b/mm/migrate.c
index 4c35c2a49574..7153d954b8a2 100644
--- a/mm/migrate.c
+++ b/mm/migrate.c
@@ -1187,10 +1187,13 @@ static int __migrate_folio_move(struct folio *src, struct folio *dst,
 	int rc;
 	int page_was_mapped = 0;
 	struct anon_vma *anon_vma = NULL;
+	bool is_lru = !__PageMovable(&src->page);
 
 	__migrate_folio_extract(dst, &page_was_mapped, &anon_vma);
 
 	rc = move_to_new_folio(dst, src, mode);
+	if (!unlikely(is_lru))
+		goto out_unlock_both;
 
 	/*
 	 * When successful, push dst to LRU immediately: so that if it
@@ -1211,6 +1214,7 @@ static int __migrate_folio_move(struct folio *src, struct folio *dst,
 		remove_migration_ptes(src,
 			rc == MIGRATEPAGE_SUCCESS ? dst : src, false);
 
+out_unlock_both:
 	folio_unlock(dst);
 	/* Drop an anon_vma reference if we took one */
 	if (anon_vma)
