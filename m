Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 297C86EC390
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Apr 2023 04:25:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230211AbjDXCZd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 23 Apr 2023 22:25:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45260 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229548AbjDXCZb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 Apr 2023 22:25:31 -0400
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8930B1FCF
        for <linux-kernel@vger.kernel.org>; Sun, 23 Apr 2023 19:25:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1682303130; x=1713839130;
  h=from:to:cc:subject:references:date:in-reply-to:
   message-id:mime-version;
  bh=mFgWMHVptgTptbXo4KBicjciW2/3ffbL7luHMBnQ60k=;
  b=aYlCFLtxZIPzxsiEPml4V/THyrX9WluRcB34+7yNXt/uAFgF9dOGn1Dq
   MfulzR5BLD7svvEdom+htWVw1b8ohH+rAgC437apDQGGS1YMzNfVpygdR
   n96JY/g+TJcdqsbi9EkL4H3ia2VwV2I330v1BPdkDPg1vjZFJEasQwBBm
   IIUPRmkISq0c9L68/2qDLPSsyEeUUtq0Lz2B+RkCq/WSfM0c4aOL5axr5
   KXkuiuaaV6zhh8icqaBurWOdS38UBHoPtOpZyWYxU7C9yTOfs3eS/v7LV
   btxR7tSWqmeKwFiQsTj2hz1T0RNdOgxwxnb5SiLVViIeJw/j1mWvfV41N
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10689"; a="325944835"
X-IronPort-AV: E=Sophos;i="5.99,221,1677571200"; 
   d="scan'208";a="325944835"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Apr 2023 19:25:30 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10689"; a="670343291"
X-IronPort-AV: E=Sophos;i="5.99,221,1677571200"; 
   d="scan'208";a="670343291"
Received: from yhuang6-desk2.sh.intel.com (HELO yhuang6-desk2.ccr.corp.intel.com) ([10.238.208.55])
  by orsmga006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Apr 2023 19:25:27 -0700
From:   "Huang, Ying" <ying.huang@intel.com>
To:     Baolin Wang <baolin.wang@linux.alibaba.com>
Cc:     <akpm@linux-foundation.org>, <rppt@kernel.org>,
        <mgorman@techsingularity.net>, <vbabka@suse.cz>, <mhocko@suse.com>,
        <david@redhat.com>, <linux-mm@kvack.org>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 2/2] mm/page_alloc: add some comments to explain the
 possible hole in __pageblock_pfn_to_page()
References: <9fc85cce8908938f4fd75ff50bc981c073779aa5.1682229876.git.baolin.wang@linux.alibaba.com>
        <0733a4cf57109a4136de5ae46fac83fb15bdd528.1682229876.git.baolin.wang@linux.alibaba.com>
Date:   Mon, 24 Apr 2023 10:24:17 +0800
In-Reply-To: <0733a4cf57109a4136de5ae46fac83fb15bdd528.1682229876.git.baolin.wang@linux.alibaba.com>
        (Baolin Wang's message of "Sun, 23 Apr 2023 18:59:11 +0800")
Message-ID: <874jp6kofi.fsf@yhuang6-desk2.ccr.corp.intel.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=ascii
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Baolin Wang <baolin.wang@linux.alibaba.com> writes:

> Now the __pageblock_pfn_to_page() is used by set_zone_contiguous(), which
> checks whether the given zone contains holes, and uses pfn_to_online_page()
> to validate if the start pfn is online and valid, as well as using pfn_valid()
> to validate the end pfn.
>
> However, the __pageblock_pfn_to_page() function may return non-NULL even
> if the end pfn of a pageblock is in a memory hole in some situations. For
> example, if the pageblock order is MAX_ORDER, which will fall into 2
> sub-sections, and the end pfn of the pageblock may be hole even though
> the start pfn is online and valid.
>
> This did not break anything until now, but the zone continuous is fragile
> in this possible scenario. So as previous discussion[1], it is better to
> add some comments to explain this possible issue in case there are some
> future pfn walkers that rely on this.
>
> [1] https://lore.kernel.org/all/87r0sdsmr6.fsf@yhuang6-desk2.ccr.corp.intel.com/
>
> Signed-off-by: Baolin Wang <baolin.wang@linux.alibaba.com>

Looks good to me!  Thanks!

Reviewed-by: "Huang, Ying" <ying.huang@intel.com>

> ---
> Changes from v1:
>  - Update the comments per Ying and Mike, thanks.
> ---
>  mm/page_alloc.c | 7 +++++++
>  1 file changed, 7 insertions(+)
>
> diff --git a/mm/page_alloc.c b/mm/page_alloc.c
> index 6457b64fe562..9756d66f471c 100644
> --- a/mm/page_alloc.c
> +++ b/mm/page_alloc.c
> @@ -1502,6 +1502,13 @@ void __free_pages_core(struct page *page, unsigned int order)
>   * interleaving within a single pageblock. It is therefore sufficient to check
>   * the first and last page of a pageblock and avoid checking each individual
>   * page in a pageblock.
> + *
> + * Note: the function may return non-NULL even if the end pfn of a pageblock
> + * is in a memory hole in some situations. For example, if the pageblock
> + * order is MAX_ORDER, which will fall into 2 sub-sections, and the end pfn
> + * of the pageblock may be hole even though the start pfn is online and valid.
> + * This did not break anything until now, but be careful about this possible
> + * issue when checking whether all pfns of a pageblock are valid.
>   */
>  struct page *__pageblock_pfn_to_page(unsigned long start_pfn,
>  				     unsigned long end_pfn, struct zone *zone)
