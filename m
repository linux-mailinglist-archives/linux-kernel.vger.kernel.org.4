Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5B935661B25
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Jan 2023 00:34:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230175AbjAHXey (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 8 Jan 2023 18:34:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46746 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230445AbjAHXew (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 8 Jan 2023 18:34:52 -0500
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E716F03A
        for <linux-kernel@vger.kernel.org>; Sun,  8 Jan 2023 15:34:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1673220891; x=1704756891;
  h=from:to:cc:subject:references:date:in-reply-to:
   message-id:mime-version;
  bh=oBpAHHXmTGDsYovXPRtYJAb4yr2fncmWitZMe1N0bmE=;
  b=cVCuViEyzHjo55oBCQo8lpXF/x7xes0zi+DYHyyN1pK0PIMWCctrcjZR
   k0EaUZVBbSbh3azFg7bkZzO4/0HnZt7h2fcijwGAsj8uBMuPD8IctN4kq
   TtiObKRFjtIkcQgwD4rshVLW3/ryILUrW+YMvI1zs0/eDDQqvPnT6gv5v
   ODVzNzsuDl7I/kbrY4r07/ynQ8wRdcVTg7u80/IIzLygPYm/3o2S2H1ia
   SvK1lV+uIXC6lg2KKA7GTCA9/I3AVBiCMYqPkL1Tjn6B6Q/0teKK8Bsfw
   j3/kyubjFH9Fl6Ws3lwCj+Caw6h6UpkulM5uixkbIRwQ1Dbjggti1pQDL
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10584"; a="321468316"
X-IronPort-AV: E=Sophos;i="5.96,311,1665471600"; 
   d="scan'208";a="321468316"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Jan 2023 15:34:50 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10584"; a="634026795"
X-IronPort-AV: E=Sophos;i="5.96,311,1665471600"; 
   d="scan'208";a="634026795"
Received: from yhuang6-desk2.sh.intel.com (HELO yhuang6-desk2.ccr.corp.intel.com) ([10.238.208.55])
  by orsmga006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Jan 2023 15:34:46 -0800
From:   "Huang, Ying" <ying.huang@intel.com>
To:     Kees Cook <keescook@chromium.org>
Cc:     Nathan Chancellor <nathan@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Zi Yan <ziy@nvidia.com>,
        Yang Shi <shy828301@gmail.com>,
        Baolin Wang <baolin.wang@linux.alibaba.com>,
        Oscar Salvador <osalvador@suse.de>,
        Matthew Wilcox <willy@infradead.org>,
        Bharata B Rao <bharata@amd.com>,
        Alistair Popple <apopple@nvidia.com>,
        haoxin <xhao@linux.alibaba.com>
Subject: Re: [PATCH 4/8] migrate_pages: split unmap_and_move() to _unmap()
 and _move()
References: <20221227002859.27740-1-ying.huang@intel.com>
        <20221227002859.27740-5-ying.huang@intel.com>
        <Y7cWb2aP1+wAWR8N@dev-arch.thelio-3990X>
        <202301051056.9D8CB1C24@keescook>
Date:   Mon, 09 Jan 2023 07:33:45 +0800
In-Reply-To: <202301051056.9D8CB1C24@keescook> (Kees Cook's message of "Thu, 5
        Jan 2023 10:57:16 -0800")
Message-ID: <87pmbo7g9y.fsf@yhuang6-desk2.ccr.corp.intel.com>
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

Kees Cook <keescook@chromium.org> writes:

> On Thu, Jan 05, 2023 at 11:26:55AM -0700, Nathan Chancellor wrote:
>> Hi Ying,
>> 
>> On Tue, Dec 27, 2022 at 08:28:55AM +0800, Huang Ying wrote:
>> > This is a preparation patch to batch the folio unmapping and moving.
>> > 
>> > In this patch, unmap_and_move() is split to migrate_folio_unmap() and
>> > migrate_folio_move().  So, we can batch _unmap() and _move() in
>> > different loops later.  To pass some information between unmap and
>> > move, the original unused dst->mapping and dst->private are used.
>> > 
>> > Signed-off-by: "Huang, Ying" <ying.huang@intel.com>
>> > Cc: Zi Yan <ziy@nvidia.com>
>> > Cc: Yang Shi <shy828301@gmail.com>
>> > Cc: Baolin Wang <baolin.wang@linux.alibaba.com>
>> > Cc: Oscar Salvador <osalvador@suse.de>
>> > Cc: Matthew Wilcox <willy@infradead.org>
>> > Cc: Bharata B Rao <bharata@amd.com>
>> > Cc: Alistair Popple <apopple@nvidia.com>
>> > Cc: haoxin <xhao@linux.alibaba.com>
>> > ---
>> >  include/linux/migrate.h |   1 +
>> >  mm/migrate.c            | 162 +++++++++++++++++++++++++++++-----------
>> >  2 files changed, 121 insertions(+), 42 deletions(-)
>> > 
>> > diff --git a/include/linux/migrate.h b/include/linux/migrate.h
>> > index 3ef77f52a4f0..7376074f2e1e 100644
>> > --- a/include/linux/migrate.h
>> > +++ b/include/linux/migrate.h
>> > @@ -18,6 +18,7 @@ struct migration_target_control;
>> >   * - zero on page migration success;
>> >   */
>> >  #define MIGRATEPAGE_SUCCESS		0
>> > +#define MIGRATEPAGE_UNMAP		1
>> >  
>> >  /**
>> >   * struct movable_operations - Driver page migration
>> > diff --git a/mm/migrate.c b/mm/migrate.c
>> > index 97ea0737ab2b..e2383b430932 100644
>> > --- a/mm/migrate.c
>> > +++ b/mm/migrate.c
>> > @@ -1009,11 +1009,29 @@ static int move_to_new_folio(struct folio *dst, struct folio *src,
>> >  	return rc;
>> >  }
>> >  
>> > -static int __unmap_and_move(struct folio *src, struct folio *dst,
>> > +static void __migrate_folio_record(struct folio *dst,
>> > +				   unsigned long page_was_mapped,
>> > +				   struct anon_vma *anon_vma)
>> > +{
>> > +	dst->mapping = (struct address_space *)anon_vma;
>> > +	dst->private = (void *)page_was_mapped;
>> > +}
>> > +
>> > +static void __migrate_folio_extract(struct folio *dst,
>> > +				   int *page_was_mappedp,
>> > +				   struct anon_vma **anon_vmap)
>> > +{
>> > +	*anon_vmap = (struct anon_vma *)dst->mapping;
>> > +	*page_was_mappedp = (unsigned long)dst->private;
>> > +	dst->mapping = NULL;
>> > +	dst->private = NULL;
>> > +}
>> 
>> This patch as commit 42871c600cad ("migrate_pages: split
>> unmap_and_move() to _unmap() and _move()") in next-20230105 causes the
>> following error with clang when CONFIG_RANDSTRUCT is enabled, which is
>> the case with allmodconfig:
>> 
>>   ../mm/migrate.c:1041:15: error: casting from randomized structure pointer type 'struct address_space *' to 'struct anon_vma *'
>>           *anon_vmap = (struct anon_vma *)dst->mapping;
>>                        ^
>>   1 error generated.
>> 
>> With GCC, there is only a note:
>> 
>>   ../mm/migrate.c: In function '__migrate_folio_extract':
>>   ../mm/migrate.c:1041:20: note: randstruct: casting between randomized structure pointer types (ssa): 'struct anon_vma' and 'struct address_space'
>> 
>>    1041 |         *anon_vmap = (struct anon_vma *)dst->mapping;
>>         |         ~~~~~~~~~~~^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>> 
>> Kees has done fixes for warnings and errors like this in the past (I
>> just ran
>> 
>>   $ git log -p --grep='randomized structure pointer type'
>> 
>> to find them) but I did not see any that would seem appropriate here
>> hence just the report :)
>
> If this struct is literally just a scratch space and the original struct
> layout doesn't matter, it may be possible to silence this cast by using
> "(void *)" instead of the explicit struct type pointer.

It works!  Thank you very much!

Best Regards,
Huang, Ying
