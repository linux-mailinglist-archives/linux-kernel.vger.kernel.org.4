Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C3A196A3624
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Feb 2023 02:26:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229684AbjB0B0u (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 26 Feb 2023 20:26:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60286 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229470AbjB0B0s (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 Feb 2023 20:26:48 -0500
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A272F763
        for <linux-kernel@vger.kernel.org>; Sun, 26 Feb 2023 17:26:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1677461208; x=1708997208;
  h=from:to:cc:subject:references:date:in-reply-to:
   message-id:mime-version;
  bh=8ovyPttT18G5v63lM3i6UHd2Y+feRiQ7nfxrWnDWnng=;
  b=CkVhipCdGdW95rbQ5Nv7qpoflD+LlcQMjf6h0NvbxPgG1FQT4zf1iYOq
   z4xSH3eGctkKeuUxIb+N6t5STe80+aWg9xK3oWk/ZcmkXc+AA9TZckH0e
   cyad1zeUEM8VY/weEhVo5X3r2cw3q5YzbhAvk6DYjn5p6P53mMT7Qf3X9
   SO9T/Xm58uwbfhvcCPLlHYwHZ9nyBk01Qw9YUozYkNNOWwNv5fc17PWdV
   hy4BDvH1w8Dh65BPCHc876LkdGGf+NQSq/+yeFjCozus39poVT/CgfDBm
   ABkTAG4lZ1RZq3pL/jUgVb+bjqqeRazbvMiocxDxyIcR0kyPH2EhIXYVL
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10633"; a="398531897"
X-IronPort-AV: E=Sophos;i="5.97,330,1669104000"; 
   d="scan'208";a="398531897"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Feb 2023 17:26:47 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10633"; a="816435468"
X-IronPort-AV: E=Sophos;i="5.97,330,1669104000"; 
   d="scan'208";a="816435468"
Received: from yhuang6-desk2.sh.intel.com (HELO yhuang6-desk2.ccr.corp.intel.com) ([10.238.208.55])
  by fmsmga001-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Feb 2023 17:26:43 -0800
From:   "Huang, Ying" <ying.huang@intel.com>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Hugh Dickins <hughd@google.com>,
        "Xu, Pengfei" <pengfei.xu@intel.com>,
        Christoph Hellwig <hch@lst.de>,
        Stefan Roesch <shr@devkernel.io>, Tejun Heo <tj@kernel.org>,
        Xin Hao <xhao@linux.alibaba.com>, Zi Yan <ziy@nvidia.com>,
        Yang Shi <shy828301@gmail.com>,
        Baolin Wang <baolin.wang@linux.alibaba.com>,
        Matthew Wilcox <willy@infradead.org>,
        Mike Kravetz <mike.kravetz@oracle.com>
Subject: Re: [PATCH 0/3] migrate_pages: fix deadlock in batched synchronous
 migration
References: <20230224141145.96814-1-ying.huang@intel.com>
        <20230225205543.5d56714d2145ac45da25369e@linux-foundation.org>
Date:   Mon, 27 Feb 2023 09:25:35 +0800
In-Reply-To: <20230225205543.5d56714d2145ac45da25369e@linux-foundation.org>
        (Andrew Morton's message of "Sat, 25 Feb 2023 20:55:43 -0800")
Message-ID: <874jr7dhm8.fsf@yhuang6-desk2.ccr.corp.intel.com>
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

Andrew Morton <akpm@linux-foundation.org> writes:

> On Fri, 24 Feb 2023 22:11:42 +0800 Huang Ying <ying.huang@intel.com> wrote:
>
>> Two deadlock bugs were reported for the migrate_pages() batching
>> series.
>
> "migrate_pages(): batch TLB flushing"

Yes.  Should have written as that.

>>  Thanks Hugh and Pengfei.  Analysis shows that if we have
>> locked some other folios except the one we are migrating, it's not
>> safe in general to wait synchronously, for example, to wait the
>> writeback to complete or wait to lock the buffer head.
>> 
>> So 1/3 fixes the deadlock in a simple way, where the batching support
>> for the synchronous migration is disabled.  The change is
>> straightforward and easy to be understood.  While 3/3 re-introduce the
>> batching for synchronous migration via trying to migrate
>> asynchronously in batch optimistically, then fall back to migrate
>> synchronously one by one for fail-to-migrate folios.  Test shows that
>> this can restore the TLB flushing batching performance for synchronous
>> migration effectively.
>
> If anyone backports the "migrate_pages(): batch TLB flushing" series
> into their kernels, they will want to know about such fixes.  So we can
> help them by providing suitable Link: tags.
>
> Such a Link: may also be helpful to people who are performing git
> bisection searches for some issue but who keep stumbling over the
> issues which this series addresses.
>
> Being lazy, I slapped
>
> Fixes: 6f7d760e86fa ("migrate_pages: move THP/hugetlb migration support check to simplify code")
>
> on all three, as this was the final patch in that series.  Inaccurate,
> but it means that these fixes will land in a suitable place if anyone
> needs them.

Sorry.  I should have added the "Fixes:" tag.  I will be more careful
in the future.  And, I will add proper "Link:" tag too.

Best Regards,
Huang, Ying
