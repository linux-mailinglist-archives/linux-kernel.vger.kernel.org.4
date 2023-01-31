Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 83F5468258A
	for <lists+linux-kernel@lfdr.de>; Tue, 31 Jan 2023 08:28:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230364AbjAaH2j (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 Jan 2023 02:28:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40726 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230135AbjAaH2i (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Jan 2023 02:28:38 -0500
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 53BBF303FF
        for <linux-kernel@vger.kernel.org>; Mon, 30 Jan 2023 23:28:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1675150117; x=1706686117;
  h=from:to:cc:subject:references:date:in-reply-to:
   message-id:mime-version;
  bh=/ZmJJuA60MRhmaDJdcoSBVZcQNooClU+3svm7Np3S0s=;
  b=M8JgX8F+2hT4gPUUBNrLaF9sr69s7mNrSMc1BRGvJ1OPM17sZximMoOp
   KnQkWzOy6LXBa3EglXm0I0DdS5Q0ZCy84M6rpz6yWccW7MYilxvIcDsy3
   pwfyxxx/f20M9eDdNI5BmJi6Ys8emY4l4Zv272W8kWchMDQ4Fiv4hriXZ
   78OloKFlrdX7jNbzmcm0taIESdtmmWESCoL42V2tLcFElZTaTo21Q4lSk
   OZQOVv1enPQxRxldtwcIOXw0oukT6z1f8vJ8ghrdnEe+BuxZp/OUPlxjv
   ld8W4oRNEdtDVCWVikXQ68EzPd1MTUIkxGIgzuXEF4VY9H89eUtkAJUHH
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10606"; a="326435022"
X-IronPort-AV: E=Sophos;i="5.97,259,1669104000"; 
   d="scan'208";a="326435022"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Jan 2023 23:28:36 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10606"; a="993169017"
X-IronPort-AV: E=Sophos;i="5.97,259,1669104000"; 
   d="scan'208";a="993169017"
Received: from yhuang6-desk2.sh.intel.com (HELO yhuang6-desk2.ccr.corp.intel.com) ([10.238.208.55])
  by fmsmga005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Jan 2023 23:28:34 -0800
From:   "Huang, Ying" <ying.huang@intel.com>
To:     Longlong Xia <xialonglong1@huawei.com>
Cc:     <akpm@linux-foundation.org>, <linux-mm@kvack.org>,
        <linux-kernel@vger.kernel.org>, <chenwandun@huawei.com>,
        <wangkefeng.wang@huawei.com>, <sunnanyong@huawei.com>
Subject: Re: [PATCH -next] mm/swapfile: remove pr_debug in get_swap_pages()
References: <87wn54c1fi.fsf@yhuang6-desk2.ccr.corp.intel.com>
        <20230131071035.1085968-1-xialonglong1@huawei.com>
Date:   Tue, 31 Jan 2023 15:27:44 +0800
In-Reply-To: <20230131071035.1085968-1-xialonglong1@huawei.com> (Longlong
        Xia's message of "Tue, 31 Jan 2023 07:10:35 +0000")
Message-ID: <87leljrwnj.fsf@yhuang6-desk2.ccr.corp.intel.com>
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

> It's known that get_swap_pages() may fail to find available space
> under some extreme case, but pr_debug() provides useless information.
> Let's remove it.
>
> Signed-off-by: Longlong Xia <xialonglong1@huawei.com>

Thanks!

Reviewed-by: "Huang, Ying" <ying.huang@intel.com>

> ---
>  mm/swapfile.c | 2 --
>  1 file changed, 2 deletions(-)
>
> diff --git a/mm/swapfile.c b/mm/swapfile.c
> index 6202a6668a63..99143875d6f0 100644
> --- a/mm/swapfile.c
> +++ b/mm/swapfile.c
> @@ -1098,8 +1098,6 @@ int get_swap_pages(int n_goal, swp_entry_t swp_entries[], int entry_size)
>  		spin_unlock(&si->lock);
>  		if (n_ret || size == SWAPFILE_CLUSTER)
>  			goto check_out;
> -		pr_debug("scan_swap_map of si %d failed to find offset\n",
> -			si->type);
>  		cond_resched();
>  
>  		spin_lock(&swap_avail_lock);
