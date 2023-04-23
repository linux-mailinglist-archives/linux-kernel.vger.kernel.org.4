Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 10D0A6EBC35
	for <lists+linux-kernel@lfdr.de>; Sun, 23 Apr 2023 03:14:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229949AbjDWBO0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 22 Apr 2023 21:14:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57654 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229740AbjDWBOZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 22 Apr 2023 21:14:25 -0400
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2FBA82680
        for <linux-kernel@vger.kernel.org>; Sat, 22 Apr 2023 18:14:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1682212464; x=1713748464;
  h=from:to:cc:subject:references:date:in-reply-to:
   message-id:mime-version;
  bh=DKv+N5SRkC9Ahg97gWrAhHCh0HArqXpav95JmbNuJzc=;
  b=B3k9IK3hRKxr9rmW3BwuoLY3KjfvF7U05g/kdeT3jPyMbtpKCGGHJxCQ
   1RpPOsgStdkFfrYl5U2G91QUP9YEaPPT+JXm4Et+mD3NGk+ZlNQjXzaCw
   upWiqPLM/SD1K9JipDfkKsqrI1gxpwg2Xf0+TrBs+D2P+HY6Wjuw5zytJ
   XpBHCRwMz0IsQU5tQ1CsLpabostTkgrsCrN+K/QP5SQxjhfpgeAFnLFNN
   bzKmLXdfy7iueS/UkjrZJ8Aq8530olDy7Kb/ZjAiWwwN8KEpJCyAEvjgB
   41UnpRl+9LdwjgVhlWn8wGYX35pTH8IubnvgyNSLC0gokpvB50ndRCRnx
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10688"; a="343707637"
X-IronPort-AV: E=Sophos;i="5.99,219,1677571200"; 
   d="scan'208";a="343707637"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Apr 2023 18:14:23 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10688"; a="836534930"
X-IronPort-AV: E=Sophos;i="5.99,219,1677571200"; 
   d="scan'208";a="836534930"
Received: from yhuang6-desk2.sh.intel.com (HELO yhuang6-desk2.ccr.corp.intel.com) ([10.238.208.55])
  by fmsmga001-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Apr 2023 18:14:21 -0700
From:   "Huang, Ying" <ying.huang@intel.com>
To:     Baolin Wang <baolin.wang@linux.alibaba.com>
Cc:     <akpm@linux-foundation.org>, <mgorman@techsingularity.net>,
        <vbabka@suse.cz>, <mhocko@suse.com>, <david@redhat.com>,
        <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 2/2] mm/page_alloc: add some comments to explain the
 possible hole in __pageblock_pfn_to_page()
References: <c2eee65ecd15779721af85c9ff109a35345b52d4.1682158312.git.baolin.wang@linux.alibaba.com>
        <02defcbe9d7a797a2257e5f6a28ff7ea78e394e5.1682158312.git.baolin.wang@linux.alibaba.com>
Date:   Sun, 23 Apr 2023 09:13:16 +0800
In-Reply-To: <02defcbe9d7a797a2257e5f6a28ff7ea78e394e5.1682158312.git.baolin.wang@linux.alibaba.com>
        (Baolin Wang's message of "Sat, 22 Apr 2023 18:15:18 +0800")
Message-ID: <87cz3vs8nn.fsf@yhuang6-desk2.ccr.corp.intel.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=ascii
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
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
> However, though the start pfn of a pageblock is valid, it can not always
> guarantee the end pfn of the pageblock is also valid (may be holes) in some
> cases. For example, if the pageblock order is MAX_ORDER - 1, which will fall
> into 2 sub-sections, and the end pfn of the pageblock may be hole even though
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
> ---
>  mm/page_alloc.c | 8 ++++++++
>  1 file changed, 8 insertions(+)
>
> diff --git a/mm/page_alloc.c b/mm/page_alloc.c
> index 6457b64fe562..dc4005b32ae0 100644
> --- a/mm/page_alloc.c
> +++ b/mm/page_alloc.c
> @@ -1502,6 +1502,14 @@ void __free_pages_core(struct page *page, unsigned int order)
>   * interleaving within a single pageblock. It is therefore sufficient to check
>   * the first and last page of a pageblock and avoid checking each individual
>   * page in a pageblock.
> + *
> + * Note: if the start pfn of a pageblock is valid, but it can not always guarantee
> + * the end pfn of the pageblock is also valid (may be holes) in some cases. For

"valid" sounds confusing here.  pfn_valid() is true, but the pfn is
considered invalid at some degree.  How about the following?

Note: the function may return non-NULL even if the end pfn of a
pageblock is in a memory hole in some situations.  For

> + * example, if the pageblock order is MAX_ORDER - 1, which will fall into 2
> + * sub-sections, and the end pfn of the pageblock may be hole even though the
> + * start pfn is online and valid. This did not break anything until now, but be
> + * careful this possible issue when checking if the whole pfns are valid of a
                                                ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

whether all pfns of a pageblock are valid. ?

> + * pageblock.
>   */
>  struct page *__pageblock_pfn_to_page(unsigned long start_pfn,
>  				     unsigned long end_pfn, struct zone *zone)

My English is poor.  So, feel free to ignore the comments.

Best Regards,
Huang, Ying
