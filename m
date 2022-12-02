Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 578BF63FE42
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Dec 2022 03:46:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232000AbiLBCp7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Dec 2022 21:45:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59592 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230126AbiLBCp6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Dec 2022 21:45:58 -0500
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6DC24D2D82
        for <linux-kernel@vger.kernel.org>; Thu,  1 Dec 2022 18:45:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1669949157; x=1701485157;
  h=from:to:cc:subject:references:date:in-reply-to:
   message-id:mime-version;
  bh=HUHDeiw3czRsSTcMfUqXaQCnJ9GN67fDujbWfUWTGbk=;
  b=SHnCoSG5rruSoRyIU9hcF6NdSzBeK4oCxTQs6Rr9yF4AI47JTJCDSuT8
   XIFebwrCDgubfiOd7WebJ0rZvFTIDnBcklKsQiZaEM5Ap47BZi97pzAqj
   tFw/D4XUGlG78aN3RZtZ/sfCAzlHjgla67dB35uY9h0o5ksVPBRJEbQeA
   FHBQpGsm7J/mQNUQ8TGmy5k2YqCwt1b6bzkxkQEKMWKnwsDHXba/SWzPW
   JrbiVlEsMhpF0a1Htr+zy+09F62tut3iok2dIU+EcemGQGy3RDcKl/tDY
   kYvL/dZHIuuNfCWgErFn32oQb4Dpf/h3PcbCbzDEGvXuhM2hCsOPA0Wv/
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10548"; a="342788417"
X-IronPort-AV: E=Sophos;i="5.96,210,1665471600"; 
   d="scan'208";a="342788417"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Dec 2022 18:45:45 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10548"; a="733653421"
X-IronPort-AV: E=Sophos;i="5.96,210,1665471600"; 
   d="scan'208";a="733653421"
Received: from yhuang6-desk2.sh.intel.com (HELO yhuang6-desk2.ccr.corp.intel.com) ([10.238.208.55])
  by fmsmga003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Dec 2022 18:45:43 -0800
From:   "Huang, Ying" <ying.huang@intel.com>
To:     Mina Almasry <almasrymina@google.com>
Cc:     Yang Shi <yang.shi@linux.alibaba.com>,
        Yosry Ahmed <yosryahmed@google.com>,
        Tim Chen <tim.c.chen@linux.intel.com>, weixugc@google.com,
        shakeelb@google.com, gthelen@google.com, fvdl@google.com,
        Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1] mm: disable top-tier fallback to reclaim on
 proactive reclaim
References: <20221201233317.1394958-1-almasrymina@google.com>
Date:   Fri, 02 Dec 2022 10:44:53 +0800
In-Reply-To: <20221201233317.1394958-1-almasrymina@google.com> (Mina Almasry's
        message of "Thu, 1 Dec 2022 15:33:17 -0800")
Message-ID: <87o7sm34nu.fsf@yhuang6-desk2.ccr.corp.intel.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=ascii
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Mina Almasry <almasrymina@google.com> writes:

> Reclaiming directly from top tier nodes breaks the aging pipeline of
> memory tiers.  If we have a RAM -> CXL -> storage hierarchy, we
> should demote from RAM to CXL and from CXL to storage. If we reclaim
> a page from RAM, it means we 'demote' it directly from RAM to storage,
> bypassing potentially a huge amount of pages colder than it in CXL.
>
> However disabling reclaim from top tier nodes entirely would cause ooms
> in edge scenarios where lower tier memory is unreclaimable for whatever
> reason, e.g. memory being mlocked() or too hot to reclaim.  In these
> cases we would rather the job run with a performance regression rather
> than it oom altogether.
>
> However, we can disable reclaim from top tier nodes for proactive reclaim.
> That reclaim is not real memory pressure, and we don't have any cause to
> be breaking the aging pipeline.
>
> Signed-off-by: Mina Almasry <almasrymina@google.com>
> ---
>  mm/vmscan.c | 27 ++++++++++++++++++++++++---
>  1 file changed, 24 insertions(+), 3 deletions(-)
>
> diff --git a/mm/vmscan.c b/mm/vmscan.c
> index 23fc5b523764..6eb130e57920 100644
> --- a/mm/vmscan.c
> +++ b/mm/vmscan.c
> @@ -2088,10 +2088,31 @@ static unsigned int shrink_folio_list(struct list_head *folio_list,
>  	nr_reclaimed += demote_folio_list(&demote_folios, pgdat);
>  	/* Folios that could not be demoted are still in @demote_folios */
>  	if (!list_empty(&demote_folios)) {
> -		/* Folios which weren't demoted go back on @folio_list for retry: */
> +		/*
> +		 * Folios which weren't demoted go back on @folio_list.
> +		 */

I don't we should change comments style here.  Why not just

+		/* Folios which weren't demoted go back on @folio_list. */

Other than this, the patch LGTM, Thanks!

Reviewed-by: "Huang, Ying" <ying.huang@intel.com>

>  		list_splice_init(&demote_folios, folio_list);
> -		do_demote_pass = false;
> -		goto retry;
> +
> +		/*
> +		 * goto retry to reclaim the undemoted folios in folio_list if
> +		 * desired.
> +		 *
> +		 * Reclaiming directly from top tier nodes is not often desired
> +		 * due to it breaking the LRU ordering: in general memory
> +		 * should be reclaimed from lower tier nodes and demoted from
> +		 * top tier nodes.
> +		 *
> +		 * However, disabling reclaim from top tier nodes entirely
> +		 * would cause ooms in edge scenarios where lower tier memory
> +		 * is unreclaimable for whatever reason, eg memory being
> +		 * mlocked or too hot to reclaim. We can disable reclaim
> +		 * from top tier nodes in proactive reclaim though as that is
> +		 * not real memory pressure.
> +		 */
> +		if (!sc->proactive) {
> +			do_demote_pass = false;
> +			goto retry;
> +		}
>  	}
>
>  	pgactivate = stat->nr_activate[0] + stat->nr_activate[1];
> --
> 2.39.0.rc0.267.gcb52ba06e7-goog
