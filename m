Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7307A67F65F
	for <lists+linux-kernel@lfdr.de>; Sat, 28 Jan 2023 09:35:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233991AbjA1IfI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 28 Jan 2023 03:35:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33708 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233967AbjA1IfG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 28 Jan 2023 03:35:06 -0500
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F8604B748
        for <linux-kernel@vger.kernel.org>; Sat, 28 Jan 2023 00:35:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1674894905; x=1706430905;
  h=from:to:cc:subject:references:date:in-reply-to:
   message-id:mime-version;
  bh=VdA3Hh2E7oteCgqPOIvSr/N4y9mxxAmQ3MiRrw9AAeE=;
  b=Vffdwi5hLIHkUVjKHrcyR38twqw3AzBiO0xRHjswsE3TK9cTQcgH8GFE
   SOB2QUpOY1QRD8KYzAIybuYPxA+kQShw6ObtDpihKZe/kYAuREvzFaEEJ
   kvajnBXnl+YxvyaP3WyFrGvhjVO5aUyTxZlkdFKDAxQi2q8xf4lsChRsr
   qBmVVVifxc57qP1SRtWmHzgOsWH+Wro+Ul2FGZ3E2+t9VhllTgEuKLwMT
   0Tun0tOivaeR1HSpO/cxnhLPM6COUXuV+0+LSgS5j13rSXj06MrQyvino
   EaOCq7x/BicPnBr4VG8cJedZRLbt7KdZ65VQ+xURU7DybTWCa2sJg1Gos
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10603"; a="391829562"
X-IronPort-AV: E=Sophos;i="5.97,253,1669104000"; 
   d="scan'208";a="391829562"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Jan 2023 00:33:47 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10603"; a="787460332"
X-IronPort-AV: E=Sophos;i="5.97,253,1669104000"; 
   d="scan'208";a="787460332"
Received: from yhuang6-desk2.sh.intel.com (HELO yhuang6-desk2.ccr.corp.intel.com) ([10.238.208.55])
  by orsmga004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Jan 2023 00:33:45 -0800
From:   "Huang, Ying" <ying.huang@intel.com>
To:     Longlong Xia <xialonglong1@huawei.com>
Cc:     <akpm@linux-foundation.org>, <linux-mm@kvack.org>,
        <linux-kernel@vger.kernel.org>, <chenwandun@huawei.com>,
        <wangkefeng.wang@huawei.com>, <sunnanyong@huawei.com>
Subject: Re: [RFC PATCH] mm/swapfile: add cond_resched() in get_swap_pages()
References: <20230128072014.1030445-1-xialonglong1@huawei.com>
Date:   Sat, 28 Jan 2023 16:29:02 +0800
In-Reply-To: <20230128072014.1030445-1-xialonglong1@huawei.com> (Longlong
        Xia's message of "Sat, 28 Jan 2023 07:20:14 +0000")
Message-ID: <87ilgrcbap.fsf@yhuang6-desk2.ccr.corp.intel.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
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

Hi, Longlong,

Longlong Xia <xialonglong1@huawei.com> writes:

> We found that the plist_for_each_entry_safe() loop in get_swap_pages()
> could reach tens of thousands of times to find available space (extreme
> case: cond_resched() is not called in the loop). The test scenario is like
> commit de1ccfb64824 ("swapfile: fix soft lockup in scan_swap_map_slots")
> does. On the other hand, scan_swap_map_slots() needs to reach LATENCY_LIMIT
> before calling cond_resched(), so cond_resched() is needed when failed to
> find available space to avoid softlockup.

Thanks for the patch.  The patch itself looks good to me.

I think that it's better to describe the test case in the patch
description directly instead of referring the previous commit.

Best Regards,
Huang, Ying

> Signed-off-by: Longlong Xia <xialonglong1@huawei.com>
> ---
>  mm/swapfile.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/mm/swapfile.c b/mm/swapfile.c
> index 908a529bca12..4fa440e87cd6 100644
> --- a/mm/swapfile.c
> +++ b/mm/swapfile.c
> @@ -1100,6 +1100,7 @@ int get_swap_pages(int n_goal, swp_entry_t swp_entries[], int entry_size)
>  			goto check_out;
>  		pr_debug("scan_swap_map of si %d failed to find offset\n",
>  			si->type);
> +		cond_resched();
>  
>  		spin_lock(&swap_avail_lock);
>  nextsi:
