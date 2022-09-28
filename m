Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E12C55ED2B8
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Sep 2022 03:42:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231332AbiI1BmI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Sep 2022 21:42:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51694 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231684AbiI1BmG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Sep 2022 21:42:06 -0400
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 383B61DCC76
        for <linux-kernel@vger.kernel.org>; Tue, 27 Sep 2022 18:42:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1664329325; x=1695865325;
  h=from:to:cc:subject:in-reply-to:references:date:
   message-id:mime-version;
  bh=VdnIAay/pNa3J+uoxCjvYQR/wUDLr3pNkvZzDguZ7Fk=;
  b=YG9F2XXKZx+wmMvHKrFZJIXEYE/2X9Twcwrl7MVUDNvaCYB9aQhRG1zP
   HSh5Pq3/kfAwY56Lcj1egL0c1R3FYEbKMl7NOLRit+Oe1hxBSERpoSpLq
   qzZyG2FwqIPXCYZtfWBjVZs4S7rP0PyWEOvwSlWf702W6Fqdm897QgsDm
   34bdcaaazNJpiPhpGIi1/FBGj5eY4HRr6CPUACos6YCABCkY0fl6JQTDH
   /TUWQ5rAeZVQUek0ihAuxhHGaHLfNAenxhgslb4zviTIxBpEhz3mcu6GJ
   qtu0KveXtryomVOlKa/Uh/Anj+Y4BU/tTDTlQwyVLt570aCIqxNVnUK2r
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10483"; a="327841436"
X-IronPort-AV: E=Sophos;i="5.93,350,1654585200"; 
   d="scan'208";a="327841436"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Sep 2022 18:42:04 -0700
X-IronPort-AV: E=McAfee;i="6500,9779,10483"; a="654939615"
X-IronPort-AV: E=Sophos;i="5.93,350,1654585200"; 
   d="scan'208";a="654939615"
Received: from yhuang6-desk2.sh.intel.com (HELO yhuang6-desk2.ccr.corp.intel.com) ([10.238.208.55])
  by orsmga001-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Sep 2022 18:42:02 -0700
From:   "Huang, Ying" <ying.huang@intel.com>
To:     Alistair Popple <apopple@nvidia.com>
Cc:     Yang Shi <shy828301@gmail.com>, John Hubbard <jhubbard@nvidia.com>,
        <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Zi Yan <ziy@nvidia.com>,
        Baolin Wang <baolin.wang@linux.alibaba.com>,
        Oscar Salvador <osalvador@suse.de>,
        "Matthew Wilcox" <willy@infradead.org>
Subject: Re: [RFC 2/6] mm/migrate_pages: split unmap_and_move() to _unmap()
 and _move()
In-Reply-To: <87pmfgjnpj.fsf@nvdebian.thelocal> (Alistair Popple's message of
        "Wed, 28 Sep 2022 10:59:08 +1000")
References: <20220921060616.73086-1-ying.huang@intel.com>
        <20220921060616.73086-3-ying.huang@intel.com>
        <87o7v2lbn4.fsf@nvdebian.thelocal>
        <CAHbLzkpPNbggD+AaT7wFQXkKqCS2cXnq=Xv3m4WuHLMBWGTmpQ@mail.gmail.com>
        <87fsgdllmb.fsf@nvdebian.thelocal>
        <87ill937qe.fsf@yhuang6-desk2.ccr.corp.intel.com>
        <46807002-c42c-1232-0938-5b48050171ee@nvidia.com>
        <CAHbLzkqRyav0fZ5gzaKbkTfGBxkQXTpu0NJz-A9j7UaHhVBxEQ@mail.gmail.com>
        <87pmfgjnpj.fsf@nvdebian.thelocal>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
Date:   Wed, 28 Sep 2022 09:41:28 +0800
Message-ID: <87czbg2s3b.fsf@yhuang6-desk2.ccr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ascii
X-Spam-Status: No, score=-7.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Alistair Popple <apopple@nvidia.com> writes:

> Yang Shi <shy828301@gmail.com> writes:
>
>> On Tue, Sep 27, 2022 at 1:35 PM John Hubbard <jhubbard@nvidia.com> wrote:
>>>
>>> On 9/26/22 18:51, Huang, Ying wrote:
>>> >>> But there might be other cases which may incur deadlock, for example,
>>> >>> filesystem writeback IIUC. Some filesystems may lock a bunch of pages
>>> >>> then write them back in a batch. The same pages may be on the
>>> >>> migration list and they are also dirty and seen by writeback. I'm not
>>> >>> sure whether I miss something that could prevent such a deadlock from
>>> >>> happening.
>>> >>
>>> >> I'm not overly familiar with that area but I would assume any filesystem
>>> >> code doing this would already have to deal with deadlock potential.
>>> >
>>> > Thank you very much for pointing this out.  I think the deadlock is a
>>> > real issue.  Anyway, we shouldn't forbid other places in kernel to lock
>>> > 2 pages at the same time.
>>> >
>>>
>>> I also agree that we cannot make any rules such as "do not lock > 1 page
>>> at the same time, elsewhere in the kernel", because it is already
>>> happening, for example in page-writeback.c, which locks PAGEVEC_SIZE
>>> (15) pages per batch [1].
>
> That's not really the case though. The inner loop of write_cache_page()
> only ever locks one page at a time, either directly via the
> unlock_page() on L2338 (those goto's are amazing) or indirectly via
> (*writepage)() on L2359.
>
> So there's no deadlock potential there because unlocking any previously
> locked page(s) doesn't depend on obtaining the lock for another page.
> Unless I've missed something?

Yes.  This is my understanding too after checking ext4_writepage().

Best Regards,
Huang, Ying

>>> The only deadlock prevention convention that I see is the convention of
>>> locking the pages in order of ascending address. That only helps if
>>> everything does it that way, and migrate code definitely does not.
>>> However...I thought that up until now, at least, the migrate code relied
>>> on trylock (which can fail, and so migration can fail, too), to avoid
>>> deadlock. Is that changing somehow, I didn't see it?
>>
>> The trylock is used by async mode which does try to avoid blocking.
>> But sync mode does use lock. The current implementation of migration
>> does migrate one page at a time, so it is not a problem.
>>
>>>
>>>
>>> [1] https://elixir.bootlin.com/linux/latest/source/mm/page-writeback.c#L2296
>>>
>>> thanks,
>>>
>>> --
>>> John Hubbard
>>> NVIDIA
>>>
>>> > The simplest solution is to batch page migration only if mode ==
>>> > MIGRATE_ASYNC.  Then we may consider to fall back to non-batch mode if
>>> > mode != MIGRATE_ASYNC and trylock page fails.
>>> >
>>>
>>>
