Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 981C26097FB
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Oct 2022 03:57:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229491AbiJXB5G (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 23 Oct 2022 21:57:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47862 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229455AbiJXB5E (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 Oct 2022 21:57:04 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2ADDA6610E
        for <linux-kernel@vger.kernel.org>; Sun, 23 Oct 2022 18:57:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1666576624; x=1698112624;
  h=from:to:cc:subject:references:date:in-reply-to:
   message-id:mime-version;
  bh=gpg1bc4kGtPIDhO6eUFSZuZY+nqE2oI4ubjdCw5mQqw=;
  b=FKjukddk83baOAuaAQx/kOCL2PyjNFwfWjg3WYZdwGyKyWB9mOF4Qc5w
   P67/tSQ/UhQzOYHSJRR8YOYxNF7YZrAlhm7xY2PgltMbtLxdMXaqWE65j
   0fhWVzPwi/gFvRd1HShjlze3kvlaE7B6PT6kutzfBmKzeIPtCoacqJLZh
   kd7E7d2ncPGutJb3Pu8hGMHjkwvotohMDiwvOGHlO++GIUjWq4ZMMM4pO
   0shT9OB7yzbtIltZlIHQvb4huXSVGa1xhU2fI4pd2a70viGWc9wj1dOtv
   HWQp2zF1eG+5CfWyT8vQNhgGTzVYF0iQLB66kPc55ivHYOJ6zUe/X1VuC
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10509"; a="393633516"
X-IronPort-AV: E=Sophos;i="5.95,207,1661842800"; 
   d="scan'208";a="393633516"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Oct 2022 18:57:04 -0700
X-IronPort-AV: E=McAfee;i="6500,9779,10509"; a="876292155"
X-IronPort-AV: E=Sophos;i="5.95,207,1661842800"; 
   d="scan'208";a="876292155"
Received: from yhuang6-desk2.sh.intel.com (HELO yhuang6-desk2.ccr.corp.intel.com) ([10.238.208.55])
  by fmsmga006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Oct 2022 18:57:01 -0700
From:   "Huang, Ying" <ying.huang@intel.com>
To:     Yang Shi <shy828301@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     Baolin Wang <baolin.wang@linux.alibaba.com>, david@redhat.com,
        ziy@nvidia.com, apopple@nvidia.com, jingshan@linux.alibaba.com,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/2] mm: migrate: Fix return value if all subpages of
 THPs are migrated successfully
References: <fca6bb0bd48a0292a0ace2fadd0f44579a060cbb.1666335603.git.baolin.wang@linux.alibaba.com>
        <20221021114149.eadf6fafdd0b2c2409a46389@linux-foundation.org>
        <CAHbLzkpv3TkUag9+0mdBE5PbNuN4o3xbDT-Z4p-CjB6Fq775Hw@mail.gmail.com>
Date:   Mon, 24 Oct 2022 09:56:22 +0800
In-Reply-To: <CAHbLzkpv3TkUag9+0mdBE5PbNuN4o3xbDT-Z4p-CjB6Fq775Hw@mail.gmail.com>
        (Yang Shi's message of "Fri, 21 Oct 2022 13:55:07 -0700")
Message-ID: <871qqym1bt.fsf@yhuang6-desk2.ccr.corp.intel.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=ascii
X-Spam-Status: No, score=-4.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Yang Shi <shy828301@gmail.com> writes:

> On Fri, Oct 21, 2022 at 11:41 AM Andrew Morton
> <akpm@linux-foundation.org> wrote:
>>
>> On Fri, 21 Oct 2022 18:16:23 +0800 Baolin Wang <baolin.wang@linux.alibaba.com> wrote:
>>
>> > When THP migration, if THPs are split and all subpages are migrated successfully
>> > , the migrate_pages() will still return the number of THP that were not migrated.
>> > That will confuse the callers of migrate_pages(), for example, which will make
>> > the longterm pinning failed though all pages are migrated successfully.
>> >
>> > Thus we should return 0 to indicate all pages are migrated in this case.
>> >
>>
>> This had me puzzled for a while.  I think this wording is clearer?
>>
>> : During THP migration, if THPs are not migrated but they are split and all
>> : subpages are migrated successfully, migrate_pages() will still return the
>> : number of THP pages that were not migrated.  This will confuse the callers
>> : of migrate_pages().  For example, the longterm pinning will failed though
>> : all pages are migrated successfully.
>> :
>> : Thus we should return 0 to indicate that all pages are migrated in this
>> : case.
>>
>> This is a fairly longstanding problem?  No Fixes: we can identify?
>
> It doesn't seem like a long standing issue. It seems like commit
> b5bade978e9b ("mm: migrate: fix the return value of migrate_pages()")
> fixed one problem, but introduced this new one IIUC.
>
> Before this commit, the code did:
>
> nr_failed += retry + thp_retry;
> rc = nr_failed;
>
> But retry and thp_retry were actually reset for each retry until the
> last one. So as long as there is no permanent migration failure and
> THP split failure, nr_failed should be 0 IIUC. TBH the code is a
> little bit hard to follow, please correct me if I'm wrong.

I think that you are correct.  We can added

Fixes: b5bade978e9b ("mm: migrate: fix the return value of migrate_pages()")

>> Did you consider the desirability of a -stable backport?

I think this can be backport to -stable.

Best Regards,
Huang, Ying

