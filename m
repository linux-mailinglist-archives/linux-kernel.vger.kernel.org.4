Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D176E74ACCF
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jul 2023 10:23:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232903AbjGGIXN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Jul 2023 04:23:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54358 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233048AbjGGIW7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Jul 2023 04:22:59 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 785E92114
        for <linux-kernel@vger.kernel.org>; Fri,  7 Jul 2023 01:22:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1688718176; x=1720254176;
  h=from:to:cc:subject:references:date:in-reply-to:
   message-id:mime-version;
  bh=Nu9Hvt9dzp4O1nBEKyWjQyfRiBg2fIMT7nFSl2HIFlc=;
  b=klWa894zqiVMT4PhxO0Qpgx59wJlCD09km+TNL80BWtbiKvlXQJvVn+x
   v5F7qOsXOZLVUYster+d/SGY3jxEwp2eFkHeKffRmqgNcHUMKUE/QKkJY
   s/GLhe0U8cE5qzY68rG7ZB0w1SAQUZVkTCILg6G936fuRgtXDmzXVPS/X
   JzMcFXeW3NiuLcqVfxMxWyrY3LZk0WyMQVXCY/Sfgitb+0YudoHbE0hkW
   gt86TacF3U+GQ3yi/rb1BekzfIZf81dCCNbWXNwc83+SRBguWjDQGPn2c
   CZ9a5JTnwHL+4qJdlML9q24aVPUJi93ZbWnywAA02fTJ/JslgyducO4UW
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10763"; a="363873228"
X-IronPort-AV: E=Sophos;i="6.01,187,1684825200"; 
   d="scan'208";a="363873228"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Jul 2023 01:22:46 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10763"; a="833297331"
X-IronPort-AV: E=Sophos;i="6.01,187,1684825200"; 
   d="scan'208";a="833297331"
Received: from yhuang6-desk2.sh.intel.com (HELO yhuang6-desk2.ccr.corp.intel.com) ([10.238.208.55])
  by fmsmga002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Jul 2023 01:22:43 -0700
From:   "Huang, Ying" <ying.huang@intel.com>
To:     Ryan Roberts <ryan.roberts@arm.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Matthew Wilcox <willy@infradead.org>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Yin Fengwei <fengwei.yin@intel.com>,
        David Hildenbrand <david@redhat.com>,
        Yu Zhao <yuzhao@google.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        Yang Shi <shy828301@gmail.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org
Subject: Re: [PATCH v2 2/5] mm: Allow deferred splitting of arbitrary large
 anon folios
References: <20230703135330.1865927-1-ryan.roberts@arm.com>
        <20230703135330.1865927-3-ryan.roberts@arm.com>
Date:   Fri, 07 Jul 2023 16:21:06 +0800
In-Reply-To: <20230703135330.1865927-3-ryan.roberts@arm.com> (Ryan Roberts's
        message of "Mon, 3 Jul 2023 14:53:27 +0100")
Message-ID: <877crcgmj1.fsf@yhuang6-desk2.ccr.corp.intel.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=ascii
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Ryan Roberts <ryan.roberts@arm.com> writes:

> With the introduction of large folios for anonymous memory, we would
> like to be able to split them when they have unmapped subpages, in order
> to free those unused pages under memory pressure. So remove the
> artificial requirement that the large folio needed to be at least
> PMD-sized.
>
> Signed-off-by: Ryan Roberts <ryan.roberts@arm.com>
> Reviewed-by: Yu Zhao <yuzhao@google.com>
> Reviewed-by: Yin Fengwei <fengwei.yin@intel.com>
> ---
>  mm/rmap.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/mm/rmap.c b/mm/rmap.c
> index 82ef5ba363d1..bbcb2308a1c5 100644
> --- a/mm/rmap.c
> +++ b/mm/rmap.c
> @@ -1474,7 +1474,7 @@ void page_remove_rmap(struct page *page, struct vm_area_struct *vma,
>  		 * page of the folio is unmapped and at least one page
>  		 * is still mapped.
>  		 */
> -		if (folio_test_pmd_mappable(folio) && folio_test_anon(folio))
> +		if (folio_test_large(folio) && folio_test_anon(folio))
>  			if (!compound || nr < nr_pmdmapped)
>  				deferred_split_folio(folio);
>  	}

One possible issue is that even for large folios mapped only in one
process, in zap_pte_range(), we will always call deferred_split_folio()
unnecessarily before freeing a large folio.

Best Regards,
Huang, Ying
