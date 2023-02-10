Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 476056918FD
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Feb 2023 08:10:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230510AbjBJHKT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Feb 2023 02:10:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47760 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230285AbjBJHKR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Feb 2023 02:10:17 -0500
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 14D635AB30
        for <linux-kernel@vger.kernel.org>; Thu,  9 Feb 2023 23:10:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1676013017; x=1707549017;
  h=from:to:cc:subject:references:date:in-reply-to:
   message-id:mime-version;
  bh=+lZLQTS9Us4z3CYUyRjyBFPbXioEEGu3KfyKGS5oIJs=;
  b=Leon7hoQtMvjmsa3u0W/fjYeGbrVYyMqpyBfB8AgUP3iLvIg2GzUq0bP
   EG8c5sYHDLiSk726sTjTBIKv4aOeZBTkzW7tnY5W8XUKZqC3QmmA0qrVO
   QE5aqwLzdlWaZGYgPi03q3RfMVRLJd+zS1RCLg07QHFyZStB7exyybma/
   Xe63+krco8Stmg/ISj0K2iDA0bsYr8+xmR66VNT5cB9WRd5NphUsWyFpf
   u50Dr1UWlS+CezEKH1EAvLvWc5E0fVUXLhragy1W6YTJnEFEgj581zSv0
   x8vttY/PNnDdfTXWU6ZyFLXRHbeGyjwQAtTDOdbHTmnoRha5nCcsamvsc
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10616"; a="328984540"
X-IronPort-AV: E=Sophos;i="5.97,286,1669104000"; 
   d="scan'208";a="328984540"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Feb 2023 23:10:10 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10616"; a="698331180"
X-IronPort-AV: E=Sophos;i="5.97,286,1669104000"; 
   d="scan'208";a="698331180"
Received: from yhuang6-desk2.sh.intel.com (HELO yhuang6-desk2.ccr.corp.intel.com) ([10.238.208.55])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Feb 2023 23:10:07 -0800
From:   "Huang, Ying" <ying.huang@intel.com>
To:     Zi Yan <ziy@nvidia.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>, <linux-mm@kvack.org>,
        <linux-kernel@vger.kernel.org>, Yang Shi <shy828301@gmail.com>,
        Baolin Wang <baolin.wang@linux.alibaba.com>,
        Oscar Salvador <osalvador@suse.de>,
        "Matthew Wilcox" <willy@infradead.org>,
        Bharata B Rao <bharata@amd.com>,
        "Alistair Popple" <apopple@nvidia.com>,
        haoxin <xhao@linux.alibaba.com>,
        Minchan Kim <minchan@kernel.org>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Hyeonggon Yoo <42.hyeyoo@gmail.com>
Subject: Re: [PATCH -v4 7/9] migrate_pages: share more code between _unmap
 and _move
References: <20230206063313.635011-1-ying.huang@intel.com>
        <20230206063313.635011-8-ying.huang@intel.com>
        <C4525F0D-C4DB-4584-A290-DFFC8F1BAE3C@nvidia.com>
        <87zg9ofjr9.fsf@yhuang6-desk2.ccr.corp.intel.com>
        <475B26C7-8BA8-4647-BDB0-25C805FD5ACC@nvidia.com>
Date:   Fri, 10 Feb 2023 15:09:18 +0800
In-Reply-To: <475B26C7-8BA8-4647-BDB0-25C805FD5ACC@nvidia.com> (Zi Yan's
        message of "Wed, 08 Feb 2023 14:47:35 -0500")
Message-ID: <87pmaif141.fsf@yhuang6-desk2.ccr.corp.intel.com>
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

> On 8 Feb 2023, at 7:02, Huang, Ying wrote:
>
>> Zi Yan <ziy@nvidia.com> writes:
>>
>>> On 6 Feb 2023, at 1:33, Huang Ying wrote:
>>>
>>>> This is a code cleanup patch to reduce the duplicated code between the
>>>> _unmap and _move stages of migrate_pages().  No functionality change
>>>> is expected.
>>>>
>>>> Signed-off-by: "Huang, Ying" <ying.huang@intel.com>
>>>> Cc: Zi Yan <ziy@nvidia.com>
>>>> Cc: Yang Shi <shy828301@gmail.com>
>>>> Cc: Baolin Wang <baolin.wang@linux.alibaba.com>
>>>> Cc: Oscar Salvador <osalvador@suse.de>
>>>> Cc: Matthew Wilcox <willy@infradead.org>
>>>> Cc: Bharata B Rao <bharata@amd.com>
>>>> Cc: Alistair Popple <apopple@nvidia.com>
>>>> Cc: haoxin <xhao@linux.alibaba.com>
>>>> Cc: Minchan Kim <minchan@kernel.org>
>>>> Cc: Mike Kravetz <mike.kravetz@oracle.com>
>>>> Cc: Hyeonggon Yoo <42.hyeyoo@gmail.com>
>>>> ---
>>>>  mm/migrate.c | 203 ++++++++++++++++++++-------------------------------
>>>>  1 file changed, 81 insertions(+), 122 deletions(-)
>>>>
>>>> diff --git a/mm/migrate.c b/mm/migrate.c
>>>> index 23eb01cfae4c..9378fa2ad4a5 100644
>>>> --- a/mm/migrate.c
>>>> +++ b/mm/migrate.c
>>>> @@ -1037,6 +1037,7 @@ static void __migrate_folio_extract(struct folio *dst,
>>>>  static void migrate_folio_undo_src(struct folio *src,
>>>>  				   int page_was_mapped,
>>>>  				   struct anon_vma *anon_vma,
>>>> +				   bool locked,
>>>>  				   struct list_head *ret)
>>>>  {
>>>>  	if (page_was_mapped)
>>>> @@ -1044,16 +1045,20 @@ static void migrate_folio_undo_src(struct folio *src,
>>>>  	/* Drop an anon_vma reference if we took one */
>>>>  	if (anon_vma)
>>>>  		put_anon_vma(anon_vma);
>>>> -	folio_unlock(src);
>>>> -	list_move_tail(&src->lru, ret);
>>>> +	if (locked)
>>>> +		folio_unlock(src);
>>>
>>> Having a comment would be better.
>>> /* A page that has not been migrated, move it to a list for later restoration */
>>
>> Emm... the page state has been restored in the previous operations of
>> the function.  This is the last step and the page will be moved to
>> "return" list, then the caller of migrate_pages() will call
>> putback_movable_pages().
>
> But if (rc == -EAGAIN || rc == -EDEADLOCK) then ret will be NULL, thus the page
> will not be put back, right?

Yes.  That is a special case.

> And for both cases, the src page state is not
> changed at all.

Their state should be restored to the original state too for being
processed again.  That is done in the previous operations too.  For
example, if the folio has been locked, before return with -EAGAIN, we
need to unlock the folio, otherwise, we will run into double lock.

> So probably only call migrate_folio_undo_src() when
> (rc != -EAGAIN && rc != -EDEADLOCK)? And still require ret to be non NULL.
>
>>
>> We have some comments for the function (migrate_folio_undo_src()) as
>> follows,
>>
>> /* Restore the source folio to the original state upon failure */
>>
>>>> +	if (ret)
>>>> +		list_move_tail(&src->lru, ret);
>>>>  }
>>>>

[snip]

Best Regards,
Huang, Ying
