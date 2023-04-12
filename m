Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A40616DE923
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Apr 2023 03:51:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229649AbjDLBvz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Apr 2023 21:51:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54510 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229498AbjDLBvy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Apr 2023 21:51:54 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 693452683
        for <linux-kernel@vger.kernel.org>; Tue, 11 Apr 2023 18:51:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1681264313; x=1712800313;
  h=from:to:cc:subject:references:date:in-reply-to:
   message-id:mime-version:content-transfer-encoding;
  bh=rqbkeDCMb89vXWak2cABIF08s7WZo7Pke8PlSss02wA=;
  b=a1GyoF5HKo9vG3oLTV7WJoeF6nTYHHbAfvrl3DbYws4ninNxBWvAfZuf
   oe/DvTlOy7MJk9wVG5i5MDAcRuk/otxrmNxKLVa6ALpFPnvP0UPeFaRpg
   +WNv9q5wnnZryKORRckJvf2lRr8Sx7uJEIMGMIFYkSS1v3hpSxAS7xIY/
   fRYXj75oA1XN7WfCdYEtb/NzBH1TQIsCr3I4zixAG8GS679UJROzKEE58
   iW7ib++fe4wlXEWMkSI8ja03PuFWgVUwKKhOIcp+tb5p1LlaS9/Ws8Aq9
   cBHbm9R75qIDxrmsxurUTcd1f2aq4KTCPrtonTGDEw2q87oMB+3Sv7n+U
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10677"; a="332471100"
X-IronPort-AV: E=Sophos;i="5.98,336,1673942400"; 
   d="scan'208";a="332471100"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Apr 2023 18:51:52 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10677"; a="812802717"
X-IronPort-AV: E=Sophos;i="5.98,336,1673942400"; 
   d="scan'208";a="812802717"
Received: from yhuang6-desk2.sh.intel.com (HELO yhuang6-desk2.ccr.corp.intel.com) ([10.238.208.55])
  by orsmga004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Apr 2023 18:51:50 -0700
From:   "Huang, Ying" <ying.huang@intel.com>
To:     Nadav Amit <namit@vmware.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        kernel test robot <yujie.liu@intel.com>,
        "Mel Gorman" <mgorman@techsingularity.net>,
        Hugh Dickins <hughd@google.com>,
        Matthew Wilcox <willy@infradead.org>,
        David Hildenbrand <david@redhat.com>
Subject: Re: [PATCH] mm,unmap: avoid flushing TLB in batch if PTE is
 inaccessible
References: <20230410075224.827740-1-ying.huang@intel.com>
        <402A3E9D-5136-4747-91FF-C3AA2D557784@vmware.com>
        <87zg7f19xu.fsf@yhuang6-desk2.ccr.corp.intel.com>
        <D432368D-7E3F-47C8-8BE3-A0D11BC6EA2D@vmware.com>
Date:   Wed, 12 Apr 2023 09:50:40 +0800
In-Reply-To: <D432368D-7E3F-47C8-8BE3-A0D11BC6EA2D@vmware.com> (Nadav Amit's
        message of "Tue, 11 Apr 2023 17:52:02 +0000")
Message-ID: <87sfd5zx5b.fsf@yhuang6-desk2.ccr.corp.intel.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Nadav Amit <namit@vmware.com> writes:

>> On Apr 10, 2023, at 6:31 PM, Huang, Ying <ying.huang@intel.com> wrote:
>>=20
>> !! External Email
>>=20
>> Hi, Amit,
>>=20
>> Thank you very much for review!
>>=20
>> Nadav Amit <namit@vmware.com> writes:
>>=20
>>>> On Apr 10, 2023, at 12:52 AM, Huang Ying <ying.huang@intel.com> wrote:
>>>>=20
>>>> 0Day/LKP reported a performance regression for commit
>>>> 7e12beb8ca2a ("migrate_pages: batch flushing TLB"). In the commit, the
>>>> TLB flushing during page migration is batched.  So, in
>>>> try_to_migrate_one(), ptep_clear_flush() is replaced with
>>>> set_tlb_ubc_flush_pending().  In further investigation, it is found
>>>> that the TLB flushing can be avoided in ptep_clear_flush() if the PTE
>>>> is inaccessible.  In fact, we can optimize in similar way for the
>>>> batched TLB flushing too to improve the performance.
>>>>=20
>>>> So in this patch, we check pte_accessible() before
>>>> set_tlb_ubc_flush_pending() in try_to_unmap/migrate_one().  Tests show
>>>> that the benchmark score of the anon-cow-rand-mt test case of
>>>> vm-scalability test suite can improve up to 2.1% with the patch on a
>>>> Intel server machine.  The TLB flushing IPI can reduce up to 44.3%.
>>>=20
>>> LGTM.
>>=20
>> Thanks!
>>=20
>>> I know it=E2=80=99s meaningless for x86 (but perhaps ARM would use this=
 infra
>>> too): do we need smp_mb__after_atomic() after ptep_get_and_clear() and
>>> before pte_accessible()?
>>=20
>> Why do we need the memory barrier?  IIUC, the PTL is locked, so PTE
>> value will not be changed under us.  Anything else?
>
> I was thinking about the ordering with respect to
> atomic_read(&mm->tlb_flush_pending), which is not protected by the PTL.
> I guess you can correctly argue that because of other control-flow
> dependencies, the barrier is not necessary.

For ordering between ptep_get_and_clear() and
atomic_read(&mm->tlb_flush_pending), I think PTL has provided the
necessary protection already.  The code path to write
mm->tlb_flush_pending is,

  tlb_gather_mmu
    inc_tlb_flush_pending       a)
  lock PTL
  change PTE                    b)
  unlock PTL
  tlb_finish_mmu
    dec_tlb_flush_pending       c)

While code path of try_to_unmap/migrate_one is,

  lock PTL
  read and change PTE           d)
  read mm->tlb_flush_pending    e)
  unlock PTL

Even if e) occurs before d), they cannot occur at the same time of b).
Do I miss anything?

Best Regards,
Huang, Ying

[snip]
