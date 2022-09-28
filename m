Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BD4D05ED2BE
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Sep 2022 03:46:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232606AbiI1Bqm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Sep 2022 21:46:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59334 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232554AbiI1Bqj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Sep 2022 21:46:39 -0400
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD6B1110EC9
        for <linux-kernel@vger.kernel.org>; Tue, 27 Sep 2022 18:46:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1664329598; x=1695865598;
  h=from:to:cc:subject:references:date:in-reply-to:
   message-id:mime-version;
  bh=wKxma6gGKHcNExPVyGZahd3ehBcvdZoLL+UplMnLgpo=;
  b=lrMmT+2SECxx0Fxus4rJdLfC234NTM9a+ko6adY22p7QUQKJQqO7g7tM
   G6pHdkCE8fA2sntIttW3b552EmAbrXBuXTtEFr6zfEIl2csvrA+/sTbUW
   NXX7isT5wvpQXD08rf0JG3ZAmJzyaaFPzyTXNUF9f2R7cXZwh0T3d8yTp
   7xySI8DjdrP0LSpIVrQKMypKBNvdjTZKGuwh3JPqtiHfzLu3TCsoMQIHL
   88YH8vY/DytYlgdOLTuRxQ7E6XM30BMt/WB+X11eDhnSFGVE7yN5ys9Hc
   Q5kKkr8uHwh573GC0Li7NCaUnVJyHUYsX0t1H0m7akAPZ2bdnrykyYBnp
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10483"; a="302389794"
X-IronPort-AV: E=Sophos;i="5.93,350,1654585200"; 
   d="scan'208";a="302389794"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Sep 2022 18:46:38 -0700
X-IronPort-AV: E=McAfee;i="6500,9779,10483"; a="747253258"
X-IronPort-AV: E=Sophos;i="5.93,350,1654585200"; 
   d="scan'208";a="747253258"
Received: from yhuang6-desk2.sh.intel.com (HELO yhuang6-desk2.ccr.corp.intel.com) ([10.238.208.55])
  by orsmga004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Sep 2022 18:46:34 -0700
From:   "Huang, Ying" <ying.huang@intel.com>
To:     Bharata B Rao <bharata@amd.com>
Cc:     <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Zi Yan <ziy@nvidia.com>, Yang Shi <shy828301@gmail.com>,
        Baolin Wang <baolin.wang@linux.alibaba.com>,
        "Oscar Salvador" <osalvador@suse.de>,
        Matthew Wilcox <willy@infradead.org>
Subject: Re: [RFC 0/6] migrate_pages(): batch TLB flushing
References: <20220921060616.73086-1-ying.huang@intel.com>
        <477e50ab-9045-0ca2-6979-e2dca71be263@amd.com>
        <87bkr6jzmz.fsf@yhuang6-desk2.ccr.corp.intel.com>
        <b9fc8a52-74b5-2f78-fbf6-8b473c6a8a36@amd.com>
Date:   Wed, 28 Sep 2022 09:46:01 +0800
In-Reply-To: <b9fc8a52-74b5-2f78-fbf6-8b473c6a8a36@amd.com> (Bharata B. Rao's
        message of "Tue, 27 Sep 2022 16:16:42 +0530")
Message-ID: <878rm42rvq.fsf@yhuang6-desk2.ccr.corp.intel.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=ascii
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Bharata B Rao <bharata@amd.com> writes:

> On 9/23/2022 1:22 PM, Huang, Ying wrote:
>> Bharata B Rao <bharata@amd.com> writes:
>>>
>>> Thanks for the patchset. I find it hitting the following BUG() when
>>> running mmtests/autonumabench:
>>>
>>> kernel BUG at mm/migrate.c:2432!
>>>
>>> This is BUG_ON(!list_empty(&migratepages)) in migrate_misplaced_page().
>> 
>> Thank you very much for reporting!  I haven't reproduced this yet.  But
>> I will pay special attention to this when develop the next version, even
>> if I cannot reproduce this finally.
>
> The following change fixes the above reported BUG_ON().
>
> diff --git a/mm/migrate.c b/mm/migrate.c
> index a0de0d9b4d41..c11dd82245e5 100644
> --- a/mm/migrate.c
> +++ b/mm/migrate.c
> @@ -1197,7 +1197,7 @@ static int migrate_page_unmap(new_page_t get_new_page, free_page_t put_new_page,
>          * references and be restored.
>          */
>         /* restore the page to right list. */
> -       if (rc != -EAGAIN)
> +       if (rc == -EAGAIN)
>                  ret = NULL;
>  
>         migrate_page_undo_page(page, page_was_mapped, anon_vma, locked, ret);
>
> The pages that returned from unmapping stage with -EAGAIN used to
> end up on "ret" list rather than continuing on the "from" list.

Yes.  You are right.  Thank you very much!

Digging some history, it is found that the code was correct in previous
versions, but became wrong for mistake during code rebasing.  Will be
more careful in the future and try to organize the patchset better to
make it easier to review the changes.

Best Regards,
Huang, Ying
