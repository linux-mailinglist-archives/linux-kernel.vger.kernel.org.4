Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0BFD860C205
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Oct 2022 05:02:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230414AbiJYDCb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Oct 2022 23:02:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41270 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230046AbiJYDCY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Oct 2022 23:02:24 -0400
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A52C91211C9
        for <linux-kernel@vger.kernel.org>; Mon, 24 Oct 2022 20:02:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1666666942; x=1698202942;
  h=from:to:cc:subject:references:date:in-reply-to:
   message-id:mime-version;
  bh=yPVWbqvt8PmA0e6igOZGTVuQxkZttukiozMYejSHZqY=;
  b=bldZUYdg5gI16mnHwWxblyImI2Y/KqyW3hHTHNsRdLk77Tm40c89yRaM
   7Gp72qIYT1fOmPSyte+EBySmE4Wn8dbyWmdvxzi1qSZChGwt0OrzwbD2i
   8ZOqR6kn+Y7SiS6wduiTSYxeTToT6Rr7drNXGmEHsAk4lv8LD1eqYvCM2
   i+WNkpO38I8hFHyqHH1HMSrgFGB9H67Xf5aOGDx8VgCsX9KKKKBAutqcU
   YVLxilDWU7ris9NCs4a2/R3uboWwpF5dH6XCtzcEBLLZhjdVbC72Ny6xo
   26Irf511m3eZbxqNpsc2OAnVzYm6Kgevhi54za5OFAv/T99SMyW9RyL9i
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10510"; a="306305403"
X-IronPort-AV: E=Sophos;i="5.95,210,1661842800"; 
   d="scan'208";a="306305403"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Oct 2022 20:02:22 -0700
X-IronPort-AV: E=McAfee;i="6500,9779,10510"; a="664761478"
X-IronPort-AV: E=Sophos;i="5.95,210,1661842800"; 
   d="scan'208";a="664761478"
Received: from yhuang6-desk2.sh.intel.com (HELO yhuang6-desk2.ccr.corp.intel.com) ([10.238.208.55])
  by orsmga001-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Oct 2022 20:02:19 -0700
From:   "Huang, Ying" <ying.huang@intel.com>
To:     Peter Xu <peterx@redhat.com>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Andrew Morton <akpm@linux-foundation.org>,
        HORIGUCHI NAOYA <naoya.horiguchi@nec.com>,
        Miaohe Lin <linmiaohe@huawei.com>,
        David Hildenbrand <david@redhat.com>,
        Andrea Arcangeli <aarcange@redhat.com>
Subject: Re: [PATCH RFC 0/2] mm: Use pte marker for swapin errors
References: <20221024204830.1342169-1-peterx@redhat.com>
Date:   Tue, 25 Oct 2022 11:01:32 +0800
In-Reply-To: <20221024204830.1342169-1-peterx@redhat.com> (Peter Xu's message
        of "Mon, 24 Oct 2022 16:48:28 -0400")
Message-ID: <87r0ywli7n.fsf@yhuang6-desk2.ccr.corp.intel.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=ascii
X-Spam-Status: No, score=-4.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Peter Xu <peterx@redhat.com> writes:

> Hi,
>
> This series uses the pte marker to replace the swapin error swap entry,
> then we safe one more swap entry.  A new pte marker bit is defined.
          ~~~~               ~~~~~
          save?              file?

It's good to save one swap file.  Thanks for your patch!  Please feel
free to add my

Reviewed-by: "Huang, Ying" <ying.huang@intel.com>

for the whole series.

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
