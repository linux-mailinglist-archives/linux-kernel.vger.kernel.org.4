Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 42D0170CFE8
	for <lists+linux-kernel@lfdr.de>; Tue, 23 May 2023 03:00:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229632AbjEWBAM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 May 2023 21:00:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59542 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235016AbjEWA7u (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 May 2023 20:59:50 -0400
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C845BDB
        for <linux-kernel@vger.kernel.org>; Mon, 22 May 2023 17:57:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1684803437; x=1716339437;
  h=from:to:cc:subject:references:date:in-reply-to:
   message-id:mime-version;
  bh=PaQ+uFejefUKDhkjELmrTi97YlZDHlfjttd0/Isxric=;
  b=mmgExzJpRO1eg885plv+eqcW6YX/K/M+SS9sjmlFy6pzMym1ZfweQK7x
   akiD0kYhzVVhPmVlcbSjCYiBEez+CU4Sg04hzYwgh9I4YgeD53sCXf5X3
   0dr8x3wkh0ijEMajQrQMBYxhu9NxGA/bgvIK4zSlIRbEjY6QBAa9L3AvE
   PgZsuDi2vTJtmPNu6tyT5PqTGY7Yk2fGdAImRJVJOMStyqIpx24IZa+xC
   QfHKUdpiUFB/HPd4oNFSGtyeSd5rPIZfAMAjue9TyJ0YmyuTNP1nbfw3C
   tZAqowDgJ9AuJ/i5b3aQf4fartVnzMmPkW7OvwTsMBPKC9wcGfs+af/KU
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10718"; a="350596431"
X-IronPort-AV: E=Sophos;i="6.00,184,1681196400"; 
   d="scan'208";a="350596431"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 May 2023 17:57:17 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10718"; a="654154365"
X-IronPort-AV: E=Sophos;i="6.00,184,1681196400"; 
   d="scan'208";a="654154365"
Received: from yhuang6-desk2.sh.intel.com (HELO yhuang6-desk2.ccr.corp.intel.com) ([10.238.208.55])
  by orsmga003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 May 2023 17:57:14 -0700
From:   "Huang, Ying" <ying.huang@intel.com>
To:     David Hildenbrand <david@redhat.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Hugh Dickins <hughd@google.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Matthew Wilcox <willy@infradead.org>,
        Michal Hocko <mhocko@suse.com>,
        Minchan Kim <minchan@kernel.org>,
        Tim Chen <tim.c.chen@linux.intel.com>,
        Yang Shi <shy828301@gmail.com>, Yu Zhao <yuzhao@google.com>
Subject: Re: [PATCH -V2 4/5] swap: remove get/put_swap_device() in
 __swap_duplicate()
References: <20230522070905.16773-1-ying.huang@intel.com>
        <20230522070905.16773-5-ying.huang@intel.com>
        <9cbd93e0-721a-01c2-14dd-87f89363a830@redhat.com>
Date:   Tue, 23 May 2023 08:56:11 +0800
In-Reply-To: <9cbd93e0-721a-01c2-14dd-87f89363a830@redhat.com> (David
        Hildenbrand's message of "Mon, 22 May 2023 14:06:05 +0200")
Message-ID: <87o7mbyifo.fsf@yhuang6-desk2.ccr.corp.intel.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=ascii
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

David Hildenbrand <david@redhat.com> writes:

> On 22.05.23 09:09, Huang Ying wrote:
>> __swap_duplicate() is called by
>> - swap_shmem_alloc(): the page lock of the swap cache is held.
>
> page lock of the swap cache? Did you really mean to say that or am I
> confused?
>
> "Page lock of the page that is in the swap cache?"

Sorry for my poor English. Or make it shorter?

"the folio in the swap cache is locked"

Best Regards,
Huang, Ying

>> - copy_nonpresent_pte() -> swap_duplicate() and try_to_unmap_one()
>> ->
>>    swap_duplicate(): the page table lock is held.
>> - __read_swap_cache_async() -> swapcache_prepare(): enclosed with
>>    get/put_swap_device() in __read_swap_cache_async() already.
>> So, it's safe to remove get/put_swap_device() in __swap_duplicate().
