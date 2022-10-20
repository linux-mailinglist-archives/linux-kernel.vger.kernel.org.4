Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C7DEF605977
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Oct 2022 10:16:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231249AbiJTIQC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Oct 2022 04:16:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42800 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229959AbiJTIQA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Oct 2022 04:16:00 -0400
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7204C2496B
        for <linux-kernel@vger.kernel.org>; Thu, 20 Oct 2022 01:15:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1666253759; x=1697789759;
  h=from:to:cc:subject:references:date:in-reply-to:
   message-id:mime-version;
  bh=RKaKnazpa+pjHWVnMNe0+2wGDtva+lQgFSovg78wKSU=;
  b=WgbO0CEenHto/dZqf/BayXpIkp5S0WMhDVwrGBxTu4r5QKPWNb2YJNQZ
   UmPKFD92T1UndavvSiIA+AUz00ze8KIK7eLTuZ4gneIitzBsXxk28yLT9
   2nef0Y4JoB8NXQKjAG4N0TSdXASzPK7CypIto7rOBMjTUyWAUYsk/eTjs
   4hKftXBrCLOlBzoAQ2S//B6nxRvVVGuo44hl8P2RA5f2f/flU4OckSYU/
   a9B/VbATjJWQLnmpieDCpgWxsCNDKxhbLf/3832joVXF4/vqXMA3h/i9f
   UVOsuY5zwE4j1Hs6bMLKs3c5rAbqc9qChHkXzjGLRrxRqQAox69GQ4ymz
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10505"; a="333211845"
X-IronPort-AV: E=Sophos;i="5.95,198,1661842800"; 
   d="scan'208";a="333211845"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Oct 2022 01:15:59 -0700
X-IronPort-AV: E=McAfee;i="6500,9779,10505"; a="624548834"
X-IronPort-AV: E=Sophos;i="5.95,198,1661842800"; 
   d="scan'208";a="624548834"
Received: from yhuang6-desk2.sh.intel.com (HELO yhuang6-desk2.ccr.corp.intel.com) ([10.238.208.55])
  by orsmga007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Oct 2022 01:15:56 -0700
From:   "Huang, Ying" <ying.huang@intel.com>
To:     Baolin Wang <baolin.wang@linux.alibaba.com>
Cc:     <akpm@linux-foundation.org>, <david@redhat.com>, <ziy@nvidia.com>,
        <shy828301@gmail.com>, <jingshan@linux.alibaba.com>,
        <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/2] mm: gup: Re-pin pages in case of trying several
 times to migrate
References: <cc48dc1e4db8c33289f168cf380ab3641f45f8ad.1666251624.git.baolin.wang@linux.alibaba.com>
Date:   Thu, 20 Oct 2022 16:15:16 +0800
In-Reply-To: <cc48dc1e4db8c33289f168cf380ab3641f45f8ad.1666251624.git.baolin.wang@linux.alibaba.com>
        (Baolin Wang's message of "Thu, 20 Oct 2022 15:49:00 +0800")
Message-ID: <87r0z2nc6j.fsf@yhuang6-desk2.ccr.corp.intel.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=ascii
X-Spam-Status: No, score=-7.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Baolin Wang <baolin.wang@linux.alibaba.com> writes:

> The migrate_pages() will return the number of {normal page, THP, hugetlb}
> that were not migrated, or an error code. That means it can still return
> the number of failure count, though the pages have been migrated
> successfully with several times re-try.

If my understanding were correct, if pages are migrated successfully
after several times re-tries, the return value will be 0.  There's one
possibility for migrate_pages() to return non-zero but all pages are
migrated.  That is, when THP is split and all subpages are migrated
successfully.

> So we should not use the return value of migrate_pages() to determin
> if there are pages are failed to migrate. Instead we can validate the
> 'movable_page_list' to see if there are pages remained in the list,
> which are failed to migrate. That can mitigate the failure of longterm
> pinning.

Another choice is to use a special return value for split THP + success
migration.  But I'm fine to use list_empty(return_pages).

> Signed-off-by: Baolin Wang <baolin.wang@linux.alibaba.com>
> ---
>  mm/gup.c | 7 ++++---
>  1 file changed, 4 insertions(+), 3 deletions(-)
>
> diff --git a/mm/gup.c b/mm/gup.c
> index 5182aba..bd8cfcd 100644
> --- a/mm/gup.c
> +++ b/mm/gup.c
> @@ -1914,9 +1914,10 @@ static int migrate_longterm_unpinnable_pages(
>  			.gfp_mask = GFP_USER | __GFP_NOWARN,
>  		};
>  
> -		if (migrate_pages(movable_page_list, alloc_migration_target,
> -				  NULL, (unsigned long)&mtc, MIGRATE_SYNC,
> -				  MR_LONGTERM_PIN, NULL)) {
> +		ret = migrate_pages(movable_page_list, alloc_migration_target,
> +				    NULL, (unsigned long)&mtc, MIGRATE_SYNC,
> +				    MR_LONGTERM_PIN, NULL);
> +		if (ret < 0 || !list_empty(movable_page_list)) {

It seems that !list_empty() is sufficient here.

>  			ret = -ENOMEM;

Why change the error code?  I don't think it's a good idea to do that.

>  			goto err;
>  		}

Best Regards,
Huang, Ying
