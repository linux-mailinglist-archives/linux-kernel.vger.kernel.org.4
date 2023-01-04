Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3F39D65CAC9
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Jan 2023 01:26:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238513AbjADA0T (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Jan 2023 19:26:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36750 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238722AbjADAZy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Jan 2023 19:25:54 -0500
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9756817592
        for <linux-kernel@vger.kernel.org>; Tue,  3 Jan 2023 16:25:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1672791940; x=1704327940;
  h=from:to:cc:subject:references:date:in-reply-to:
   message-id:mime-version;
  bh=edKy2ReilvbH/TaDlMaXGjVC5v8DHE8hu3zYyHeDKrM=;
  b=dGOuXdYP4I+59Zb0otzZV52T4wy3MY4jCHkW2QMHwD3VmiGundwrEtgI
   6/ac+6vwfJY7mvRyUJTG+7qzPOR085LNCEt1LZ+iPw9bVIBwf0skkCAFj
   eYkpgqEHLyE7ToArE1ZKrmQd8vQSj5ag4vBIkqGW4Dj2j3Yb1KDlUJYfm
   8e4+uMMob9qbqzPDoN0MLCLx+uG1MClTRXBbR2OMbGygDCQ1I6uxwFI6S
   /yL3ORnnUae36tL52TdmgsFIPGzM2HXw3tn4Y03H5diIqmWxpTWe0lUOO
   sSAsp5rj+dY8wXvqCD1llHfY+2ThM56FSb/Ou6Mr2sRfeQgdwS8QoVjcC
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10579"; a="319501208"
X-IronPort-AV: E=Sophos;i="5.96,297,1665471600"; 
   d="scan'208";a="319501208"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Jan 2023 16:25:25 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10579"; a="605011640"
X-IronPort-AV: E=Sophos;i="5.96,297,1665471600"; 
   d="scan'208";a="605011640"
Received: from yhuang6-desk2.sh.intel.com (HELO yhuang6-desk2.ccr.corp.intel.com) ([10.238.208.55])
  by orsmga003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Jan 2023 16:25:21 -0800
From:   "Huang, Ying" <ying.huang@intel.com>
To:     Zi Yan <ziy@nvidia.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>, <linux-mm@kvack.org>,
        <linux-kernel@vger.kernel.org>, Yang Shi <shy828301@gmail.com>,
        Baolin Wang <baolin.wang@linux.alibaba.com>,
        Oscar Salvador <osalvador@suse.de>,
        "Matthew Wilcox" <willy@infradead.org>,
        Bharata B Rao <bharata@amd.com>,
        "Alistair Popple" <apopple@nvidia.com>,
        haoxin <xhao@linux.alibaba.com>
Subject: Re: [PATCH 3/8] migrate_pages: restrict number of pages to migrate
 in batch
References: <20221227002859.27740-1-ying.huang@intel.com>
        <20221227002859.27740-4-ying.huang@intel.com>
        <761F148B-555B-4C51-8A1E-F17ABA85D014@nvidia.com>
Date:   Wed, 04 Jan 2023 08:24:12 +0800
In-Reply-To: <761F148B-555B-4C51-8A1E-F17ABA85D014@nvidia.com> (Zi Yan's
        message of "Tue, 03 Jan 2023 13:40:00 -0500")
Message-ID: <87pmbvno43.fsf@yhuang6-desk2.ccr.corp.intel.com>
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

Zi Yan <ziy@nvidia.com> writes:

> On 26 Dec 2022, at 19:28, Huang Ying wrote:

[snip]

>> +/*
>> + * migrate_pages - migrate the folios specified in a list, to the free folios
>> + *		   supplied as the target for the page migration
>> + *
>> + * @from:		The list of folios to be migrated.
>> + * @get_new_page:	The function used to allocate free folios to be used
>> + *			as the target of the folio migration.
>> + * @put_new_page:	The function used to free target folios if migration
>> + *			fails, or NULL if no special handling is necessary.
>> + * @private:		Private data to be passed on to get_new_page()
>> + * @mode:		The migration mode that specifies the constraints for
>> + *			folio migration, if any.
>> + * @reason:		The reason for folio migration.
>> + * @ret_succeeded:	Set to the number of folios migrated successfully if
>> + *			the caller passes a non-NULL pointer.
>> + *
>> + * The function returns after 10 attempts or if no folios are movable any more
>> + * because the list has become empty or no retryable folios exist any more.
>> + * It is caller's responsibility to call putback_movable_pages() to return folios
>> + * to the LRU or free list only if ret != 0.
>> + *
>> + * Returns the number of {normal folio, large folio, hugetlb} that were not
>> + * migrated, or an error code. The number of large folio splits will be
>> + * considered as the number of non-migrated large folio, no matter how many
>> + * split folios of the large folio are migrated successfully.
>> + */
>> +int migrate_pages(struct list_head *from, new_page_t get_new_page,
>> +		free_page_t put_new_page, unsigned long private,
>> +		enum migrate_mode mode, int reason, unsigned int *ret_succeeded)
>> +{
>> +	int rc, rc_gether;
>
> rc_gether -> rc_gather?

Good catch!  Thanks!  Will change this in the next version.

Best Regards,
Huang, Ying

>> +	int nr_pages;
>> +	struct folio *folio, *folio2;
>> +	LIST_HEAD(folios);
>> +	LIST_HEAD(ret_folios);
>> +	struct migrate_pages_stats stats;
>> +

[snip]
