Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 44ED2668BA0
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Jan 2023 06:41:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238296AbjAMFlf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Jan 2023 00:41:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41462 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236408AbjAMFk7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Jan 2023 00:40:59 -0500
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5FD242616
        for <linux-kernel@vger.kernel.org>; Thu, 12 Jan 2023 21:40:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1673588457; x=1705124457;
  h=from:to:cc:subject:references:date:in-reply-to:
   message-id:mime-version;
  bh=vrAvHnOnXccx7yFGQ8ydXsgitzXgUkHpBIX5UAmmqEo=;
  b=ZPDgXoUZITnOS88iBaLQbIkHPmJw+bR/DVK74jfkz5FTDK84oFeSYaMi
   eWua2sNkmvdOR7TPntkZoUbJ0nuFPGacDTGDdp4Pg+RLEZaKr6AofsgRi
   mrht/q4IBA8IWOStoryoiSHqnK4tpJHK3fi7BTmmshnLTpWLpScr+vx4z
   rSIdqu1uOpga4pFuR1cm3NvKdkinJbUXXfqC5CvkoBhesj0IvnYLJDAJf
   mzjdkR9AKj8EpJtDoW+qvlBq7oMA6H98kShKuWXDFxMKptO/oAGpWRgjh
   5YPZ1dE8rNm2T1zpTCupPZMLEc95Ev5YrrPXo9RpUX46DK+pWWGO60sdN
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10588"; a="323979210"
X-IronPort-AV: E=Sophos;i="5.97,213,1669104000"; 
   d="scan'208";a="323979210"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Jan 2023 21:40:45 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10588"; a="688627342"
X-IronPort-AV: E=Sophos;i="5.97,213,1669104000"; 
   d="scan'208";a="688627342"
Received: from yhuang6-desk2.sh.intel.com (HELO yhuang6-desk2.ccr.corp.intel.com) ([10.238.208.55])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Jan 2023 21:40:42 -0800
From:   "Huang, Ying" <ying.huang@intel.com>
To:     Mike Kravetz <mike.kravetz@oracle.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Zi Yan <ziy@nvidia.com>,
        Yang Shi <shy828301@gmail.com>,
        Baolin Wang <baolin.wang@linux.alibaba.com>,
        Oscar Salvador <osalvador@suse.de>,
        Matthew Wilcox <willy@infradead.org>,
        Bharata B Rao <bharata@amd.com>,
        Alistair Popple <apopple@nvidia.com>,
        haoxin <xhao@linux.alibaba.com>
Subject: Re: [PATCH -v2 0/9] migrate_pages(): batch TLB flushing
References: <20230110075327.590514-1-ying.huang@intel.com>
        <Y74WsWCFGh2wFGji@monkey> <Y782h7t10uRVW0RC@monkey>
        <87a62oy5o9.fsf@yhuang6-desk2.ccr.corp.intel.com>
        <Y79tTXgEeuzzqFho@monkey>
        <87ilhcrzkr.fsf@yhuang6-desk2.ccr.corp.intel.com>
        <Y8ChvzGVG5Tm9tQQ@monkey>
        <87bkn3rw8v.fsf@yhuang6-desk2.ccr.corp.intel.com>
        <Y8DizzvFXBSEPzI4@monkey>
Date:   Fri, 13 Jan 2023 13:39:39 +0800
In-Reply-To: <Y8DizzvFXBSEPzI4@monkey> (Mike Kravetz's message of "Thu, 12 Jan
        2023 20:49:19 -0800")
Message-ID: <877cxrro10.fsf@yhuang6-desk2.ccr.corp.intel.com>
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

Mike Kravetz <mike.kravetz@oracle.com> writes:

> On 01/13/23 10:42, Huang, Ying wrote:
>> Mike Kravetz <mike.kravetz@oracle.com> writes:
>> > On 01/12/23 15:17, Huang, Ying wrote:
>> >> Mike Kravetz <mike.kravetz@oracle.com> writes:
>> >> > On 01/12/23 08:09, Huang, Ying wrote:
>> >
>> > Isolated to patch,
>> > [PATCH -v2 4/9] migrate_pages: split unmap_and_move() to _unmap() and _move()
>> >
>> > Actually, recreated/isolated by just applying this series to v6.2-rc3 in an
>> > effort to eliminate any possible noise in linux-next.
>> >
>> > Spent a little time looking at modifications made there, but nothing stood out.
>> > Will investigate more as time allows.
>> 
>> Thank you very much!  That's really helpful.
>> 
>> Checked that patch again, found that there's an issue about non-lru
>> pages.  Do you enable zram in your test system?  Can you try the
>> below debug patch on top of
>
> CONFIG_ZRAM=y
>
>> 
>> [PATCH -v2 4/9] migrate_pages: split unmap_and_move() to _unmap() and _move()
>> 
>> The following patches in series need to be rebased for the below
>> change.  I will test with zram enabled too.
>
> A quick test with below patch on top of [PATCH -v2 4/9] (without the rest of
> the series applied) makes the issue go away.  Thanks!

Thanks you very much!  Now I can reproduce the issue with zram
configured.  Will send out a new version to fix the issue.

Best Regards,
Huang, Ying
