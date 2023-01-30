Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 30A6B68074B
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Jan 2023 09:19:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235970AbjA3IS6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Jan 2023 03:18:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46708 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235409AbjA3ISy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Jan 2023 03:18:54 -0500
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C74F2180
        for <linux-kernel@vger.kernel.org>; Mon, 30 Jan 2023 00:18:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1675066733; x=1706602733;
  h=from:to:cc:subject:in-reply-to:references:date:
   message-id:mime-version;
  bh=+IYcHzTI7nRCOMHj/i2LpW/avtATij2NJKdYGvwOqcw=;
  b=TSpHoas0jvCLReSqCLZ+wGEKrgDwTc6gw4hWSfqSE3o8U7o8357VcF2X
   FU0gNMmoNZ4hlWNtKpp7blEPEVWmP0v9VkVVpda/8YBiumK4L6DIvC/te
   0LAQdlPAfAEJxnBkwd28aUktXabLmn5DtyE6eOsUoGnflAnUkBQZcbcJH
   jnS/k9XQMOsiboTPDmJLFz7oU3xKdbceUJQ+Be2nk0+UmNcZbshWDQEjN
   WW6xTAcwJWcDY90nLCQEGA1qARrAqCw8TYjczPQg2fn7L+2KRTqBe2A8M
   ctNLy+ZZjQUTJAqEb/XW2RYotzOHGFGhwQm7iPsNyYPlz9BC9/QzQ5XGb
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10605"; a="307847948"
X-IronPort-AV: E=Sophos;i="5.97,257,1669104000"; 
   d="scan'208";a="307847948"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Jan 2023 00:18:53 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10605"; a="806580987"
X-IronPort-AV: E=Sophos;i="5.97,257,1669104000"; 
   d="scan'208";a="806580987"
Received: from yhuang6-desk2.sh.intel.com (HELO yhuang6-desk2.ccr.corp.intel.com) ([10.238.208.55])
  by fmsmga001-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Jan 2023 00:18:51 -0800
From:   "Huang, Ying" <ying.huang@intel.com>
To:     Tong Tiangen <tongtiangen@huawei.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        "Aneesh Kumar K . V" <aneesh.kumar@linux.ibm.com>,
        <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>,
        <wangkefeng.wang@huawei.com>, Guohanjun <guohanjun@huawei.com>
Subject: Re: [PATCH -next] memory tier: release the new_memtier in
 find_create_memory_tier()
In-Reply-To: <20230129040651.1329208-1-tongtiangen@huawei.com> (Tong Tiangen's
        message of "Sun, 29 Jan 2023 04:06:51 +0000")
References: <20230129040651.1329208-1-tongtiangen@huawei.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
Date:   Mon, 30 Jan 2023 16:17:55 +0800
Message-ID: <87edrctozw.fsf@yhuang6-desk2.ccr.corp.intel.com>
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

Tong Tiangen <tongtiangen@huawei.com> writes:

> In find_create_memory_tier(),  if failed to register device, then we should
> release new_memtier from the tier list and put device instead of memtier.
>
> Fixes: 9832fb87834e ("mm/demotion: expose memory tier details via sysfs")
> Signed-off-by: Tong Tiangen <tongtiangen@huawei.com>
> ---
>  mm/memory-tiers.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/mm/memory-tiers.c b/mm/memory-tiers.c
> index c734658c6242..e593e56e530b 100644
> --- a/mm/memory-tiers.c
> +++ b/mm/memory-tiers.c
> @@ -211,8 +211,8 @@ static struct memory_tier *find_create_memory_tier(struct memory_dev_type *memty
>  
>  	ret = device_register(&new_memtier->dev);
>  	if (ret) {
> -		list_del(&memtier->list);
> -		put_device(&memtier->dev);
> +		list_del(&new_memtier->list);
> +		put_device(&new_memtier->dev);
>  		return ERR_PTR(ret);
>  	}
>  	memtier = new_memtier;

Good catch!  Thanks!

I think that this should be in stable since v6.1.

Best Regards,
Huang, Ying
