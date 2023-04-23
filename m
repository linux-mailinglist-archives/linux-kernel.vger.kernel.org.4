Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8BC386EBC31
	for <lists+linux-kernel@lfdr.de>; Sun, 23 Apr 2023 03:07:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229963AbjDWA4y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 22 Apr 2023 20:56:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55452 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229658AbjDWA4x (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 22 Apr 2023 20:56:53 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8DABE10F4
        for <linux-kernel@vger.kernel.org>; Sat, 22 Apr 2023 17:56:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1682211412; x=1713747412;
  h=from:to:cc:subject:in-reply-to:references:date:
   message-id:mime-version;
  bh=0X/4Q5twC3FRie9aoJ3rmcwKIX0qxnUdDpWJ83Ct1ss=;
  b=NuvF76eJMtjNjaG5rlx9Wz2XsJh1I6KOb46jeWvzJE3sjc5CpR9RaK+U
   5tWsG/2IlpA3COWMoETkTaCLND/MHUvWhK/aVnk33BbjGVSukXKf0IuN5
   IqPswa38HCdsU7n0J0olccv84yphuZ1jBsWbpZQNyy5149/ZJh7hsYllT
   PkjRBcV3bI4Zqs6WI2tzpafUd8Jq5QfTKKQnwpQ2C1ULb2nNogoQvB7AQ
   nyYfqIPamKo+MVWkj2x9fBGW4Bxv10/MgoMthD/RokZ5Amk2QEvhIMtPA
   3rVLmRlB08Gsv0i2Ng3EeqD+MjMhQjSJaIj1TlzdpMj4ak0kr1R5lFZ8K
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10688"; a="346239316"
X-IronPort-AV: E=Sophos;i="5.99,219,1677571200"; 
   d="scan'208";a="346239316"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Apr 2023 17:56:52 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10688"; a="686231335"
X-IronPort-AV: E=Sophos;i="5.99,219,1677571200"; 
   d="scan'208";a="686231335"
Received: from yhuang6-desk2.sh.intel.com (HELO yhuang6-desk2.ccr.corp.intel.com) ([10.238.208.55])
  by orsmga007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Apr 2023 17:56:49 -0700
From:   "Huang, Ying" <ying.huang@intel.com>
To:     Baolin Wang <baolin.wang@linux.alibaba.com>
Cc:     <akpm@linux-foundation.org>, <mgorman@techsingularity.net>,
        <vbabka@suse.cz>, <mhocko@suse.com>, <david@redhat.com>,
        <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/2] mm/page_alloc: drop the unnecessary pfn_valid() for
 start pfn
In-Reply-To: <c2eee65ecd15779721af85c9ff109a35345b52d4.1682158312.git.baolin.wang@linux.alibaba.com>
        (Baolin Wang's message of "Sat, 22 Apr 2023 18:15:17 +0800")
References: <c2eee65ecd15779721af85c9ff109a35345b52d4.1682158312.git.baolin.wang@linux.alibaba.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
Date:   Sun, 23 Apr 2023 08:55:45 +0800
Message-ID: <87h6t7s9gu.fsf@yhuang6-desk2.ccr.corp.intel.com>
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

> We've already used pfn_to_online_page() for start pfn to make sure
> it is online and valid, so the pfn_valid() for the start pfn is
> unnecessary, drop it.
>
> Signed-off-by: Baolin Wang <baolin.wang@linux.alibaba.com>

Thanks!

Reviewed-by: "Huang, Ying" <ying.huang@intel.com>

> ---
>  mm/page_alloc.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/mm/page_alloc.c b/mm/page_alloc.c
> index 9de2a18519a1..6457b64fe562 100644
> --- a/mm/page_alloc.c
> +++ b/mm/page_alloc.c
> @@ -1512,7 +1512,7 @@ struct page *__pageblock_pfn_to_page(unsigned long start_pfn,
>  	/* end_pfn is one past the range we are checking */
>  	end_pfn--;
>  
> -	if (!pfn_valid(start_pfn) || !pfn_valid(end_pfn))
> +	if (!pfn_valid(end_pfn))
>  		return NULL;
>  
>  	start_page = pfn_to_online_page(start_pfn);
