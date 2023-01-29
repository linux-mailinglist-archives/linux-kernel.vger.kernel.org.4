Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6172F67FBF8
	for <lists+linux-kernel@lfdr.de>; Sun, 29 Jan 2023 01:40:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232009AbjA2Ak0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 28 Jan 2023 19:40:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37080 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229513AbjA2AkY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 28 Jan 2023 19:40:24 -0500
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 570D212F0F
        for <linux-kernel@vger.kernel.org>; Sat, 28 Jan 2023 16:40:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1674952823; x=1706488823;
  h=from:to:cc:subject:references:date:in-reply-to:
   message-id:mime-version;
  bh=RD6sUDC0uXraoOmZp5HP/USbwngyuhpB++DTAen3npQ=;
  b=WsK93h6eS5GFeTU7BE4T1M3RZJ5CRVAHsdL8U8svKxxpJj1Ccmsbfrwu
   vEP+CW7z5xRcadgdvE0asFl85+yJuXW0Xqu5uI+Dh11pNu0fO5u9VNfTY
   WyxOe/ghku/215XBOPPS8CfuyMhSp+feXcVklfAi51AkJHdRT2EpDCt2c
   ZSjKR1d/1pMFI9ET0kf7nvmjjN7Isxt/oD2prn66YIuDlcPtTtmADihip
   qqNG9J8va0xD6B/tg7pZv+hWmAl5pca3jFrsd9I4sRMh7UzsqjX/zvjA3
   d1A4LQCltKiyOIEt+NMOOx4/6KJot6gFkgnwCly3qbg7hVdtmPrnNw4kt
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10604"; a="325043348"
X-IronPort-AV: E=Sophos;i="5.97,254,1669104000"; 
   d="scan'208";a="325043348"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Jan 2023 16:40:22 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10604"; a="727085675"
X-IronPort-AV: E=Sophos;i="5.97,254,1669104000"; 
   d="scan'208";a="727085675"
Received: from yhuang6-desk2.sh.intel.com (HELO yhuang6-desk2.ccr.corp.intel.com) ([10.238.208.55])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Jan 2023 16:40:12 -0800
From:   "Huang, Ying" <ying.huang@intel.com>
To:     Longlong Xia <xialonglong1@huawei.com>
Cc:     <akpm@linux-foundation.org>, <linux-mm@kvack.org>,
        <linux-kernel@vger.kernel.org>, <chenwandun@huawei.com>,
        <wangkefeng.wang@huawei.com>, <sunnanyong@huawei.com>
Subject: Re: [PATCH] mm/swapfile: add cond_resched() in get_swap_pages()
References: <20230128094757.1060525-1-xialonglong1@huawei.com>
Date:   Sun, 29 Jan 2023 08:39:21 +0800
In-Reply-To: <20230128094757.1060525-1-xialonglong1@huawei.com> (Longlong
        Xia's message of "Sat, 28 Jan 2023 09:47:57 +0000")
Message-ID: <87a622cgxy.fsf@yhuang6-desk2.ccr.corp.intel.com>
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

Longlong Xia <xialonglong1@huawei.com> writes:

> The softlockup still occurs in get_swap_pages() under memory pressure.
> 64 CPU cores, 64GB memory, and 28 zram devices, the disksize of each
> zram device is 50MB with same priority as si. Use the stress-ng tool
> to increase memory pressure, causing the system to oom frequently.
>
> The plist_for_each_entry_safe() loops in get_swap_pages() could reach
> tens of thousands of times to find available space (extreme case:
> cond_resched() is not called in scan_swap_map_slots()). Let's add
> cond_resched() into get_swap_pages() when failed to find available
> space to avoid softlockup.
>
> Signed-off-by: Longlong Xia <xialonglong1@huawei.com>

Looks good to me. Thanks!

Reviewed-by: "Huang, Ying" <ying.huang@intel.com>

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
