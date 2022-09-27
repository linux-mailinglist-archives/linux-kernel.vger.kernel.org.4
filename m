Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A2E615EB734
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Sep 2022 03:52:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229895AbiI0BwK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Sep 2022 21:52:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43650 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230006AbiI0BwE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Sep 2022 21:52:04 -0400
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4DFE671BC6
        for <linux-kernel@vger.kernel.org>; Mon, 26 Sep 2022 18:52:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1664243523; x=1695779523;
  h=from:to:cc:subject:references:date:in-reply-to:
   message-id:mime-version;
  bh=Dk6ndrlNBYI60TKR2ZwIH8QqY848CDVYdIWHSrUiXuI=;
  b=ZtZNksmJuZFFJexM6+SVAKKsCUF9YWyAq5inKbnn5DUn/gZSKSa9CWik
   XbRTUiNTy2wqkA7s3jd8QwvwTPX/ZRnJRa+/azLVTTlb2mXnfY5ArHjvP
   UI36ITqhraJIh+yy5dlP9SVk0VM1fy+heaBUu7owmGDfgJdinhrEryb4B
   jxLf6SbwC1mH61xbis2sLOBND8yCiURT2E3IqSE2fZcZkW+5rLQLYSIv4
   KzsfqGKKiEzINCJR0uG1jn49+lnGRLiUxPfuXHhJ97CiGqVh7AL06BCbO
   3ra1WInYVncw5j6LWQg5Aa9j4zDawLZkxBatAPpgRgIvbYN2AlGVdBlog
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10482"; a="363020809"
X-IronPort-AV: E=Sophos;i="5.93,347,1654585200"; 
   d="scan'208";a="363020809"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Sep 2022 18:52:02 -0700
X-IronPort-AV: E=McAfee;i="6500,9779,10482"; a="725309544"
X-IronPort-AV: E=Sophos;i="5.93,347,1654585200"; 
   d="scan'208";a="725309544"
Received: from yhuang6-desk2.sh.intel.com (HELO yhuang6-desk2.ccr.corp.intel.com) ([10.238.208.55])
  by fmsmga002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Sep 2022 18:52:00 -0700
From:   "Huang, Ying" <ying.huang@intel.com>
To:     Alistair Popple <apopple@nvidia.com>
Cc:     Yang Shi <shy828301@gmail.com>, <linux-mm@kvack.org>,
        <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Zi Yan <ziy@nvidia.com>,
        Baolin Wang <baolin.wang@linux.alibaba.com>,
        Oscar Salvador <osalvador@suse.de>,
        Matthew Wilcox <willy@infradead.org>
Subject: Re: [RFC 2/6] mm/migrate_pages: split unmap_and_move() to _unmap()
 and _move()
References: <20220921060616.73086-1-ying.huang@intel.com>
        <20220921060616.73086-3-ying.huang@intel.com>
        <87o7v2lbn4.fsf@nvdebian.thelocal>
        <CAHbLzkpPNbggD+AaT7wFQXkKqCS2cXnq=Xv3m4WuHLMBWGTmpQ@mail.gmail.com>
        <87fsgdllmb.fsf@nvdebian.thelocal>
Date:   Tue, 27 Sep 2022 09:51:21 +0800
In-Reply-To: <87fsgdllmb.fsf@nvdebian.thelocal> (Alistair Popple's message of
        "Tue, 27 Sep 2022 10:02:33 +1000")
Message-ID: <87ill937qe.fsf@yhuang6-desk2.ccr.corp.intel.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=ascii
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Alistair Popple <apopple@nvidia.com> writes:

> Yang Shi <shy828301@gmail.com> writes:
>
>> On Mon, Sep 26, 2022 at 2:37 AM Alistair Popple <apopple@nvidia.com> wrote:
>>>
>>>
>>> Huang Ying <ying.huang@intel.com> writes:
>>>
>>> > This is a preparation patch to batch the page unmapping and moving
>>> > for the normal pages and THP.
>>> >
>>> > In this patch, unmap_and_move() is split to migrate_page_unmap() and
>>> > migrate_page_move().  So, we can batch _unmap() and _move() in
>>> > different loops later.  To pass some information between unmap and
>>> > move, the original unused newpage->mapping and newpage->private are
>>> > used.
>>>
>>> This looks like it could cause a deadlock between two threads migrating
>>> the same pages if force == true && mode != MIGRATE_ASYNC as
>>> migrate_page_unmap() will call lock_page() while holding the lock on
>>> other pages in the list. Therefore the two threads could deadlock if the
>>> pages are in a different order.
>>
>> It seems unlikely to me since the page has to be isolated from lru
>> before migration. The isolating from lru is atomic, so the two threads
>> unlikely see the same pages on both lists.
>
> Oh thanks! That is a good point and I agree since lru isolation is
> atomic the two threads won't see the same pages. migrate_vma_setup()
> does LRU isolation after locking the page which is why the potential
> exists there. We could potentially switch that around but given
> ZONE_DEVICE pages aren't on an lru it wouldn't help much.
>
>> But there might be other cases which may incur deadlock, for example,
>> filesystem writeback IIUC. Some filesystems may lock a bunch of pages
>> then write them back in a batch. The same pages may be on the
>> migration list and they are also dirty and seen by writeback. I'm not
>> sure whether I miss something that could prevent such a deadlock from
>> happening.
>
> I'm not overly familiar with that area but I would assume any filesystem
> code doing this would already have to deal with deadlock potential.

Thank you very much for pointing this out.  I think the deadlock is a
real issue.  Anyway, we shouldn't forbid other places in kernel to lock
2 pages at the same time.

The simplest solution is to batch page migration only if mode ==
MIGRATE_ASYNC.  Then we may consider to fall back to non-batch mode if
mode != MIGRATE_ASYNC and trylock page fails.

Best Regards,
Huang, Ying

[snip]
