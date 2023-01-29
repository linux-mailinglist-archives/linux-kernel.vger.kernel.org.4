Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CEDB567FCD9
	for <lists+linux-kernel@lfdr.de>; Sun, 29 Jan 2023 06:28:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230241AbjA2FYw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 29 Jan 2023 00:24:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55850 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229436AbjA2FYu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 29 Jan 2023 00:24:50 -0500
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B8791C5AE
        for <linux-kernel@vger.kernel.org>; Sat, 28 Jan 2023 21:24:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1674969889; x=1706505889;
  h=from:to:cc:subject:references:date:in-reply-to:
   message-id:mime-version;
  bh=1/Nx5EbWk24yvzBVTOmdsvRqtT8ma3CKeSrmvR0r+JA=;
  b=c13JHSrLKuwaC4UmoFz9FesyiutvXYamcc0CbwwZSIFebOV6lkRBVq7L
   bO39BFfx5yCFQ/OWtYg+MAgSTJ+CZn3QMjDn8ROy1GYT4oC8j73s1Jq+R
   bVzN1SSve9dM4jfgQxrolfxQSA8VfbVAaNRi+gSLE2RpA4sR/I+pzESgn
   EgcRhIO0YSSQswuWC0YX9HxZF5IJvOLhNMBFcq22a7pVs1/iO6mLQn7fF
   SFK0ACFQY7fgNoLFTaGBF0ISdTBmxEgin26mOUaEsp3ym/ASbRQTfKa5w
   v49EW1B7O8O00n9NH0xb1mrdl197e9yShj28/5ofFxSntKlHkFH5c2zvp
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10604"; a="325058123"
X-IronPort-AV: E=Sophos;i="5.97,254,1669104000"; 
   d="scan'208";a="325058123"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Jan 2023 21:24:48 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10604"; a="787644921"
X-IronPort-AV: E=Sophos;i="5.97,254,1669104000"; 
   d="scan'208";a="787644921"
Received: from yhuang6-desk2.sh.intel.com (HELO yhuang6-desk2.ccr.corp.intel.com) ([10.238.208.55])
  by orsmga004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Jan 2023 21:24:46 -0800
From:   "Huang, Ying" <ying.huang@intel.com>
To:     Chen Wandun <chenwandun@huawei.com>
Cc:     <akpm@linux-foundation.org>, <linux-mm@kvack.org>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2] mm/migrate: Continue to migrate for non-hugetlb folios
References: <20230129033910.1327277-1-chenwandun@huawei.com>
Date:   Sun, 29 Jan 2023 13:23:38 +0800
In-Reply-To: <20230129033910.1327277-1-chenwandun@huawei.com> (Chen Wandun's
        message of "Sun, 29 Jan 2023 11:39:10 +0800")
Message-ID: <871qnddicl.fsf@yhuang6-desk2.ccr.corp.intel.com>
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

> migrate_hugetlbs returns -ENOMEM when no enough hugetlb,
> however there may be free non-hugetlb folios available,
> so continue to migrate for non-hugetlb folios.
>
> Nowdays the only negtive return value of migrate_hugetlbs
> is -ENOMEM, keep compatible for coming negtive return value
> instead of ignore return value.
>
> Signed-off-by: Chen Wandun <chenwandun@huawei.com>

LGTM, Thanks!

Reviewed-by: "Huang, Ying" <ying.huang@intel.com>

>
> ---
> v1 --> v2: modify changelog and comment. thanks Huang Ying.
> ---
>  mm/migrate.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/mm/migrate.c b/mm/migrate.c
> index b971edbf32fc..68927aa06f9b 100644
> --- a/mm/migrate.c
> +++ b/mm/migrate.c
> @@ -1939,7 +1939,8 @@ int migrate_pages(struct list_head *from, new_page_t get_new_page,
>  
>  	rc_gather = migrate_hugetlbs(from, get_new_page, put_new_page, private,
>  				     mode, reason, &stats, &ret_folios);
> -	if (rc_gather < 0)
> +	/* There may be free non-hugetlb folios available, continue to migrate. */
> +	if (rc_gather < 0 && rc_gather != -ENOMEM)
>  		goto out;
>  again:
>  	nr_pages = 0;
