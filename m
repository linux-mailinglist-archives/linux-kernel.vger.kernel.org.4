Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 51FD973EFDF
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Jun 2023 02:49:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229471AbjF0At1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Jun 2023 20:49:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53376 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229456AbjF0AtZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Jun 2023 20:49:25 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B4DDE172A;
        Mon, 26 Jun 2023 17:49:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1687826964; x=1719362964;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=NIvD168ivu638YoBw6zU4zgstOCr5dCsNkfps809nx0=;
  b=Yp6DPLesMY5Rez9THF7eStDuOuhOCHJz5iQ4VlifpAvA0UwZpOkwFZa3
   XxwU/+5mV+bgxlQ30776NOTNv2nz0Pwz0ztCB5Y9a91h+zQFqUazhz/Yx
   l8XCpPA4FeoUwBSaF299/zzCAhfEkvP91YfEpB2Bum51OGonOCTiwyjgd
   wZPQEc+pIvD19BnYQ8/yBpDNLnktha3lh92XEEj2MevzvnfyvGbWjCtuG
   lkJwDFoOyyxc97ceabCKwvxlAJ198WmLIQPLQd9QDWaH+zlmMdYktzUDy
   xIS1drlKcmSxIv31Ne29QyTy+VeVuHEsxx9SI6MQt8eOpS2YFqst3yfTS
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10753"; a="364883703"
X-IronPort-AV: E=Sophos;i="6.01,161,1684825200"; 
   d="scan'208";a="364883703"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Jun 2023 17:49:24 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10753"; a="666492554"
X-IronPort-AV: E=Sophos;i="6.01,161,1684825200"; 
   d="scan'208";a="666492554"
Received: from aschofie-mobl2.amr.corp.intel.com (HELO aschofie-mobl2) ([10.212.171.4])
  by orsmga003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Jun 2023 17:49:23 -0700
Date:   Mon, 26 Jun 2023 17:49:22 -0700
From:   Alison Schofield <alison.schofield@intel.com>
To:     Dan Williams <dan.j.williams@intel.com>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Len Brown <lenb@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Andy Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Dave Jiang <dave.jiang@intel.com>,
        Mike Rapoport <rppt@kernel.org>, x86@kernel.org,
        linux-cxl@vger.kernel.org, linux-acpi@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Derick Marks <derick.w.marks@intel.com>
Subject: Re: [PATCH v3 1/2] x86/numa: Introduce numa_fill_memblks()
Message-ID: <ZJoyEsCooH/66lFO@aschofie-mobl2>
References: <cover.1687645837.git.alison.schofield@intel.com>
 <2fd3778271d4fd3c4278c75c582daf6df4dcc503.1687645837.git.alison.schofield@intel.com>
 <6497d8421945c_2ed72941@dwillia2-xfh.jf.intel.com.notmuch>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6497d8421945c_2ed72941@dwillia2-xfh.jf.intel.com.notmuch>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jun 24, 2023 at 11:01:38PM -0700, Dan Williams wrote:
> alison.schofield@ wrote:
> > From: Alison Schofield <alison.schofield@intel.com>
> > 
> > numa_fill_memblks() fills in the gaps in numa_meminfo memblks
> > over an physical address range.
> [..]
> > diff --git a/arch/x86/mm/numa.c b/arch/x86/mm/numa.c
> > index 2aadb2019b4f..152398bdecc4 100644
> > --- a/arch/x86/mm/numa.c
> > +++ b/arch/x86/mm/numa.c
> [..]
> > +int __init numa_fill_memblks(u64 start, u64 end)
> > +{
> > +	struct numa_memblk **blk = &numa_memblk_list[0];
> > +	struct numa_meminfo *mi = &numa_meminfo;
> > +	int count = 0;
> > +	u64 prev_end;
> > +
> > +	/*
> > +	 * Create a list of pointers to numa_meminfo memblks that
> > +	 * overlap start, end. Exclude (start == bi->end) since
> > +	 * end addresses in both a CFMWS range and a memblk range
> > +	 * are exclusive.
> > +	 *
> > +	 * This list of pointers is used to make in-place changes
> > +	 * that fill out the numa_meminfo memblks.
> > +	 */
> > +	for (int i = 0; i < mi->nr_blks; i++) {
> > +		struct numa_memblk *bi = &mi->blk[i];
> > +
> > +		if (start < bi->end && end >= bi->start) {
> > +			blk[count] = &mi->blk[i];
> > +			count++;
> > +		}
> > +	}
> > +	if (!count)
> > +		return NUMA_NO_MEMBLK;
> > +
> > +	/* Sort the list of pointers in memblk->start order */
> > +	sort(&blk[0], count, sizeof(blk[0]), cmp_memblk, NULL);
> > +
> > +	/* Make sure the first/last memblks include start/end */
> > +	blk[0]->start = min(blk[0]->start, start);
> > +	blk[count - 1]->end = max(blk[count - 1]->end, end);
> > +
> > +	/*
> > +	 * Fill any gaps by tracking the previous memblks
> > +	 * end address and backfilling to it if needed.
> > +	 */
> > +	prev_end = blk[0]->end;
> > +	for (int i = 1; i < count; i++) {
> > +		struct numa_memblk *curr = blk[i];
> > +
> > +		if (prev_end >= curr->start) {
> > +			if (prev_end < curr->end)
> > +				prev_end = curr->end;
> > +		} else {
> > +			curr->start = prev_end;
> > +			prev_end = curr->end;
> > +		}
> > +	}
> > +	return 0;
> > +}
> > +EXPORT_SYMBOL_GPL(numa_fill_memblks);
> 
> After deleting this export you can add:

Drats! Sorry for missing that.
> 
> Reviewed-by: Dan Williams <dan.j.williams@intel.com>
