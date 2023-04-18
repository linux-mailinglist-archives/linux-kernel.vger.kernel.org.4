Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7C62F6E57CD
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Apr 2023 05:19:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230045AbjDRDTk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Apr 2023 23:19:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49342 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230330AbjDRDTI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Apr 2023 23:19:08 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 868CF558D
        for <linux-kernel@vger.kernel.org>; Mon, 17 Apr 2023 20:18:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1681787939; x=1713323939;
  h=from:to:cc:subject:references:date:in-reply-to:
   message-id:mime-version:content-transfer-encoding;
  bh=gT+D5YtuQoJ6bOdWxtXhnLJmmnVqK24v1D+Tt8JeRnY=;
  b=Hz13J3lKYa7NVwDWS0m1mZnaUAyoMCC5MZsUhhB+E4dlV+XdWYhqMOo3
   T/T7Re2Mu1aZF4C8LvCwQet5BWFMccN5un1v/PrVKiFPNlLstlFGt9H5K
   /1H2IrgNt4i+rIEvcaDD7gIRNCVZABIonmXF9razW2QJc7phL313g4IQk
   UpFpmMOjsqA9NpAqvJPxoe0VZAPrUfp1Jnh7yJB1JqZxARwUG1Krnw1jc
   Azh3+ubG4xwjU1b7119/y31xBR4DmHcT4G2vtzyc4L/NWgrXmVCYWh6ix
   onurRLDSH58/rxKbEdeumrltXi40mjMSdv8o+xWl8hC1XQZ6fV6IIWiH9
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10683"; a="345061344"
X-IronPort-AV: E=Sophos;i="5.99,206,1677571200"; 
   d="scan'208";a="345061344"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Apr 2023 20:18:59 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10683"; a="780352365"
X-IronPort-AV: E=Sophos;i="5.99,206,1677571200"; 
   d="scan'208";a="780352365"
Received: from yhuang6-desk2.sh.intel.com (HELO yhuang6-desk2.ccr.corp.intel.com) ([10.238.208.55])
  by fmsmga003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Apr 2023 20:18:56 -0700
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
        <87sfd5zx5b.fsf@yhuang6-desk2.ccr.corp.intel.com>
        <03BCE979-33B1-486F-A969-0475A35DEBB5@vmware.com>
Date:   Tue, 18 Apr 2023 11:17:52 +0800
In-Reply-To: <03BCE979-33B1-486F-A969-0475A35DEBB5@vmware.com> (Nadav Amit's
        message of "Wed, 12 Apr 2023 17:00:49 +0000")
Message-ID: <87a5z5vpy7.fsf@yhuang6-desk2.ccr.corp.intel.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Nadav Amit <namit@vmware.com> writes:

>> On Apr 11, 2023, at 6:50 PM, Huang, Ying <ying.huang@intel.com> wrote:
>>=20
>> !! External Email
>>=20
>> Nadav Amit <namit@vmware.com> writes:
>>=20
>>>> On Apr 10, 2023, at 6:31 PM, Huang, Ying <ying.huang@intel.com> wrote:
>>>>=20
>>>> !! External Email
>>>>=20
>>>> Hi, Amit,
>>>>=20
>>>> Thank you very much for review!
>>>>=20
>>>> Nadav Amit <namit@vmware.com> writes:
>>>>=20
>>>>>> On Apr 10, 2023, at 12:52 AM, Huang Ying <ying.huang@intel.com> wrot=
e:
>>>>>>=20
>>>>>> 0Day/LKP reported a performance regression for commit
>>>>>> 7e12beb8ca2a ("migrate_pages: batch flushing TLB"). In the commit, t=
he
>>>>>> TLB flushing during page migration is batched.  So, in
>>>>>> try_to_migrate_one(), ptep_clear_flush() is replaced with
>>>>>> set_tlb_ubc_flush_pending().  In further investigation, it is found
>>>>>> that the TLB flushing can be avoided in ptep_clear_flush() if the PTE
>>>>>> is inaccessible.  In fact, we can optimize in similar way for the
>>>>>> batched TLB flushing too to improve the performance.
>>>>>>=20
>>>>>> So in this patch, we check pte_accessible() before
>>>>>> set_tlb_ubc_flush_pending() in try_to_unmap/migrate_one().  Tests sh=
ow
>>>>>> that the benchmark score of the anon-cow-rand-mt test case of
>>>>>> vm-scalability test suite can improve up to 2.1% with the patch on a
>>>>>> Intel server machine.  The TLB flushing IPI can reduce up to 44.3%.
>>>>>=20
>>>>> LGTM.
>>>>=20
>>>> Thanks!
>>>>=20
>>>>> I know it=E2=80=99s meaningless for x86 (but perhaps ARM would use th=
is infra
>>>>> too): do we need smp_mb__after_atomic() after ptep_get_and_clear() and
>>>>> before pte_accessible()?
>>>>=20
>>>> Why do we need the memory barrier?  IIUC, the PTL is locked, so PTE
>>>> value will not be changed under us.  Anything else?
>>>=20
>>> I was thinking about the ordering with respect to
>>> atomic_read(&mm->tlb_flush_pending), which is not protected by the PTL.
>>> I guess you can correctly argue that because of other control-flow
>>> dependencies, the barrier is not necessary.
>>=20
>> For ordering between ptep_get_and_clear() and
>> atomic_read(&mm->tlb_flush_pending), I think PTL has provided the
>> necessary protection already.  The code path to write
>> mm->tlb_flush_pending is,
>>=20
>>  tlb_gather_mmu
>>    inc_tlb_flush_pending       a)
>>  lock PTL
>>  change PTE                    b)
>>  unlock PTL
>>  tlb_finish_mmu
>>    dec_tlb_flush_pending       c)
>>=20
>> While code path of try_to_unmap/migrate_one is,
>>=20
>>  lock PTL
>>  read and change PTE           d)
>>  read mm->tlb_flush_pending    e)
>>  unlock PTL
>>=20
>> Even if e) occurs before d), they cannot occur at the same time of b).
>> Do I miss anything?
>
> You didn=E2=80=99t miss anything. I went over the comment on
> inc_tlb_flush_pending() and you follow the scheme.

Thanks!  Can I get your acked-by or reviewed-by for this patch?

Best Regards,
Huang, Ying
