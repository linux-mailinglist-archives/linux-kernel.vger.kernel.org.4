Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 98AF7623A31
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Nov 2022 04:10:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232256AbiKJDKZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Nov 2022 22:10:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60246 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229556AbiKJDKW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Nov 2022 22:10:22 -0500
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 018A91EEE8
        for <linux-kernel@vger.kernel.org>; Wed,  9 Nov 2022 19:10:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1668049821; x=1699585821;
  h=from:to:cc:subject:references:date:in-reply-to:
   message-id:mime-version;
  bh=ShRX+hTWxgwzxN+xhIfLsN8tp5u8u7jmKdcv/JvaJv0=;
  b=jYth3+RO1JrAJbN6XpWMXp6UDS8ZClstV8gAo25kxrEKCXbVBmyqxGLn
   n3+lCjaWkDjKC3XSlZExqWgetojA3xgcxfB8VmIHqQDjbnnYnoMgopayn
   yElZ8NSPC4hPesH/FVz6Ia+ti6TBK598AS82AG9d7jfxoP2zwAjaIyiwV
   mGqn2oU2JPAkOGceoyH9m5SNdmo3h19H9Ktq93sfDydHF03zeylV/ALK0
   7p2r42Bk8Uv7VkKGp6KOBAh4hGuMFGP2YLPQ8VKgEPOcA9pUvgyBgaTi/
   Xk5zu6idS7792yde1K3V3/PWeWrF3dxLVYcgF+wGyp6uNaLBLGFoAYFNF
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10526"; a="312963960"
X-IronPort-AV: E=Sophos;i="5.96,152,1665471600"; 
   d="scan'208";a="312963960"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Nov 2022 19:10:20 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10526"; a="614931300"
X-IronPort-AV: E=Sophos;i="5.96,152,1665471600"; 
   d="scan'208";a="614931300"
Received: from yhuang6-desk2.sh.intel.com (HELO yhuang6-desk2.ccr.corp.intel.com) ([10.238.208.55])
  by orsmga006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Nov 2022 19:10:18 -0800
From:   "Huang, Ying" <ying.huang@intel.com>
To:     Miaoqian Lin <linmq006@gmail.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Wei Xu <weixugc@google.com>,
        "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mm/demotion: Fix NULL vs IS_ERR checking in
 memory_tier_init
References: <20221110030751.1627266-1-linmq006@gmail.com>
Date:   Thu, 10 Nov 2022 11:09:34 +0800
In-Reply-To: <20221110030751.1627266-1-linmq006@gmail.com> (Miaoqian Lin's
        message of "Thu, 10 Nov 2022 07:07:51 +0400")
Message-ID: <874jv7wln5.fsf@yhuang6-desk2.ccr.corp.intel.com>
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

Miaoqian Lin <linmq006@gmail.com> writes:

> The alloc_memory_type() function return error pointers on error
> instead of NULL.
> Use IS_ERR() to check the return value to fix this.
>
> Fixes: 7b88bda3761b ("mm/demotion/dax/kmem: set node's abstract distance to MEMTIER_DEFAULT_DAX_ADISTANCE")
> Signed-off-by: Miaoqian Lin <linmq006@gmail.com>

Thanks!

Reviewed-by: "Huang, Ying" <ying.huang@intel.com>

> ---
>  mm/memory-tiers.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/mm/memory-tiers.c b/mm/memory-tiers.c
> index fa8c9d07f9ce..ac0dae9e54bf 100644
> --- a/mm/memory-tiers.c
> +++ b/mm/memory-tiers.c
> @@ -645,7 +645,7 @@ static int __init memory_tier_init(void)
>  	 * than default DRAM tier.
>  	 */
>  	default_dram_type = alloc_memory_type(MEMTIER_ADISTANCE_DRAM);
> -	if (!default_dram_type)
> +	if (IS_ERR(default_dram_type))
>  		panic("%s() failed to allocate default DRAM tier\n", __func__);
>  
>  	/*
