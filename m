Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3291B612EA4
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Oct 2022 02:41:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229719AbiJaBk7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 30 Oct 2022 21:40:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58728 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229515AbiJaBk5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 30 Oct 2022 21:40:57 -0400
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ADD4395A9
        for <linux-kernel@vger.kernel.org>; Sun, 30 Oct 2022 18:40:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1667180456; x=1698716456;
  h=from:to:cc:subject:references:date:in-reply-to:
   message-id:mime-version;
  bh=0d6fpLM6CUu9xahsDVfbZewVAzPugiU00xgBhAaG790=;
  b=gKcO8RZ4DQPAIZoHf5F/Xxv1+AIsS0veT44QV3AQTQ26q/fQ/o/rlc/Q
   fyJVt5MUXgKwRJKUKFA4GbGpgWTpyRGfbEaZYLM+NTu/I60NXDO4YsTWA
   NYdTZhUuRk4ucT1G8+frtxS9tja2i5OfoWqLNhijhbohRJFvAvORQopNd
   gnVUk+kIAJrQlPTQTfJKNFK8l39BIFL1KSbXCl1A0iqhTlid8j2bA9Slt
   0cl1SEwuMuQQsuHDjbnBvb5xD7IsKxyBIideAn9FZKsnwVT7TdhJtyr0g
   wXPOUM6219D/+Rw3w6o2Pqy5VEhlEn5ZLGqiq02s++DVL4UbIuG5KVW/2
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10516"; a="306413745"
X-IronPort-AV: E=Sophos;i="5.95,227,1661842800"; 
   d="scan'208";a="306413745"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Oct 2022 18:40:56 -0700
X-IronPort-AV: E=McAfee;i="6500,9779,10516"; a="635883353"
X-IronPort-AV: E=Sophos;i="5.95,227,1661842800"; 
   d="scan'208";a="635883353"
Received: from yhuang6-desk2.sh.intel.com (HELO yhuang6-desk2.ccr.corp.intel.com) ([10.238.208.55])
  by fmsmga007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Oct 2022 18:40:54 -0700
From:   "Huang, Ying" <ying.huang@intel.com>
To:     Peter Xu <peterx@redhat.com>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Miaohe Lin <linmiaohe@huawei.com>,
        David Hildenbrand <david@redhat.com>,
        HORIGUCHI NAOYA <naoya.horiguchi@nec.com>,
        Andrea Arcangeli <aarcange@redhat.com>
Subject: Re: [PATCH 0/2] mm: Use pte marker for swapin errors
References: <20221030214151.402274-1-peterx@redhat.com>
Date:   Mon, 31 Oct 2022 09:40:15 +0800
In-Reply-To: <20221030214151.402274-1-peterx@redhat.com> (Peter Xu's message
        of "Sun, 30 Oct 2022 17:41:49 -0400")
Message-ID: <87h6zkepog.fsf@yhuang6-desk2.ccr.corp.intel.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=ascii
X-Spam-Status: No, score=-8.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Peter Xu <peterx@redhat.com> writes:

> rfc->v1:
> - Rename SWAP_ERROR -> SWAPIN_ERROR [David, Miaohe]
> - Added r-bs for Ying and Miaohe
>
> Hi,
>
> This series uses the pte marker to replace the swapin error swap entry,
> then we save one more swap entry slot for swap devices.  A new pte marker
> bit is defined.

Per my understanding, "swap entry" describes one swap page (4KB on x86)
in one swap device.  So, the original swapin error implementation uses
one swap file (or swap device) instead of one swap entry.  So your patch
saves one swap file (or swap device).

Best Regards,
Huang, Ying

> One thing worth mentioning: we need the pte marker to be always built to
> make sure it works like before, so I made an attempt in patch 1 to drop
> CONFIG_PTE_MARKER and always compile pte marker in.  Since pte markers are
> enabled in many distributions by default already, meanwhile the codeset is
> really small I assume it's fine.  But still I'm tagging with RFC for this
> initial version.
>
> Smoke tested on anonymous mem on a fake swap failure.  Please have a look,
> thanks.
>
> Peter Xu (2):
>   mm: Always compile in pte markers
>   mm: Use pte markers for swap errors
>
>  include/linux/swap.h    | 16 ++++----------
>  include/linux/swapops.h | 49 +++++++++--------------------------------
>  mm/Kconfig              |  7 ------
>  mm/memory.c             | 13 ++++++-----
>  mm/shmem.c              |  2 +-
>  mm/swapfile.c           |  2 +-
>  6 files changed, 23 insertions(+), 66 deletions(-)
