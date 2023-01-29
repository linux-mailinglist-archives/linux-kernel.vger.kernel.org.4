Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B4C0C67FC8D
	for <lists+linux-kernel@lfdr.de>; Sun, 29 Jan 2023 04:02:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230106AbjA2DCo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 28 Jan 2023 22:02:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37794 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229600AbjA2DCm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 28 Jan 2023 22:02:42 -0500
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 84855206BC
        for <linux-kernel@vger.kernel.org>; Sat, 28 Jan 2023 19:02:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1674961361; x=1706497361;
  h=from:to:cc:subject:references:date:in-reply-to:
   message-id:mime-version;
  bh=98lkgC1vWJoVJMl83+1D4wn5NUIPCKs6/A96bim2eJM=;
  b=Z7D2kv8ZunG03+O97gYJ0eT+Gz4+s5NMSJmtp1T/nNKKWfObUFkjuBzR
   1HSTshDE9G3MNnBsJ5S2G1wgX9CGnil1xNdwmopNAeNKvA3vLtIufegFR
   2ZsOv+ZmLu+ToYHBynOZ83c6kfhFvGSrw8cEIHAvlQDtvqmv42tQfsYCd
   nM7+7te8Gm/7gQOoi3iRNSfScFEklZBImapuOj1E/Rj4v1CfF9/GSgXXe
   uMcASaLGaUaJMM0k6W2RpA0Djws+esfKZKlxa4wFbUphYF8iBHzFymU5k
   UmFfrq+XglPjlTjoUHVOKdikU9wzN6q0cchd6Bk4MpaKpktsk6fGgw2yT
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10604"; a="325051337"
X-IronPort-AV: E=Sophos;i="5.97,254,1669104000"; 
   d="scan'208";a="325051337"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Jan 2023 19:02:41 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10604"; a="752408748"
X-IronPort-AV: E=Sophos;i="5.97,254,1669104000"; 
   d="scan'208";a="752408748"
Received: from yhuang6-desk2.sh.intel.com (HELO yhuang6-desk2.ccr.corp.intel.com) ([10.238.208.55])
  by fmsmga003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Jan 2023 19:02:39 -0800
From:   "Huang, Ying" <ying.huang@intel.com>
To:     Chen Wandun <chenwandun@huawei.com>
Cc:     <akpm@linux-foundation.org>, <linux-mm@kvack.org>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] mm/migrate: Continue to migrate for small pages
References: <20230129025404.1262745-1-chenwandun@huawei.com>
Date:   Sun, 29 Jan 2023 11:01:31 +0800
In-Reply-To: <20230129025404.1262745-1-chenwandun@huawei.com> (Chen Wandun's
        message of "Sun, 29 Jan 2023 10:54:04 +0800")
Message-ID: <875ycqcad0.fsf@yhuang6-desk2.ccr.corp.intel.com>
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

Chen Wandun <chenwandun@huawei.com> writes:

> migrate_hugetlbs returns -ENOMEM when no enough huge page,
> however maybe there are still free small pages, so continue
> to migrate for small pages.

Better to replace "page" with "folio", and "small" with "non-hugetlb".

> Signed-off-by: Chen Wandun <chenwandun@huawei.com>
> ---
>  mm/migrate.c | 7 ++++++-
>  1 file changed, 6 insertions(+), 1 deletion(-)
>
> diff --git a/mm/migrate.c b/mm/migrate.c
> index b971edbf32fc..c9d0d2058036 100644
> --- a/mm/migrate.c
> +++ b/mm/migrate.c
> @@ -1939,7 +1939,12 @@ int migrate_pages(struct list_head *from, new_page_t get_new_page,
>  
>  	rc_gather = migrate_hugetlbs(from, get_new_page, put_new_page, private,
>  				     mode, reason, &stats, &ret_folios);
> -	if (rc_gather < 0)
> +	/* Maybe there are free small pages, continue to migrate.

There may be free non-hugetlb folios available, continue to migrate.

> +	 * Nowdays the only negtive return value of migrate_hugetlbs
> +	 * is -ENOMEM, keep compatible for coming negtive return
> +	 * value instead of ignore return value.

This can be moved to patch description.

> +	 */
> +	if (rc_gather < 0 && rc_gather != -ENOMEM)
>  		goto out;
>  again:
>  	nr_pages = 0;

Best Regards,
Huang, Ying
