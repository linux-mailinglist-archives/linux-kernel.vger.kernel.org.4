Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 06C106DCF5A
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Apr 2023 03:32:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230026AbjDKBcj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Apr 2023 21:32:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39862 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229712AbjDKBcf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Apr 2023 21:32:35 -0400
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 545601718
        for <linux-kernel@vger.kernel.org>; Mon, 10 Apr 2023 18:32:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1681176754; x=1712712754;
  h=from:to:cc:subject:references:date:in-reply-to:
   message-id:mime-version:content-transfer-encoding;
  bh=6uciC4UroIaZtzRZeYdo8iufB2WP1MTDBI57Zm/g/XA=;
  b=F1S2HHscI8OKegyzV+WvX/PwLnKhumU2bTJRMzi03tqa3euFZMbX63us
   qm+D+Fde04f6inpFNSxETSjQvsENReffHeXq46/UarxWQ0h7fQ9XDgvXB
   8163NMaxpw41c57zyA9cvmEgZDwit2o9sYKu7k5b0aBmwoGoTZCdYCUBZ
   1OrNIXIhtvlMd73/Xr46OSDtnKT79+A5nmcgRWaoBzCjKXtx2dfckkMD7
   E5gDkJ+/W3E2GnWfMfr9lOUI1otre+Kz7gvuZ9MpvlWRzSb1NodldxMN+
   Vu/8nbBZ5EAic2ykTq1GAPPDuj4QdYvc3K92DdI+3XctOT4HDdubYQLcV
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10676"; a="371343467"
X-IronPort-AV: E=Sophos;i="5.98,335,1673942400"; 
   d="scan'208";a="371343467"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Apr 2023 18:32:33 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10676"; a="688434314"
X-IronPort-AV: E=Sophos;i="5.98,335,1673942400"; 
   d="scan'208";a="688434314"
Received: from yhuang6-desk2.sh.intel.com (HELO yhuang6-desk2.ccr.corp.intel.com) ([10.238.208.55])
  by orsmga002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Apr 2023 18:32:31 -0700
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
Date:   Tue, 11 Apr 2023 09:31:25 +0800
In-Reply-To: <402A3E9D-5136-4747-91FF-C3AA2D557784@vmware.com> (Nadav Amit's
        message of "Mon, 10 Apr 2023 19:47:30 +0000")
Message-ID: <87zg7f19xu.fsf@yhuang6-desk2.ccr.corp.intel.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, Amit,

Thank you very much for review!

Nadav Amit <namit@vmware.com> writes:

>> On Apr 10, 2023, at 12:52 AM, Huang Ying <ying.huang@intel.com> wrote:
>>=20
>> 0Day/LKP reported a performance regression for commit
>> 7e12beb8ca2a ("migrate_pages: batch flushing TLB"). In the commit, the
>> TLB flushing during page migration is batched.  So, in
>> try_to_migrate_one(), ptep_clear_flush() is replaced with
>> set_tlb_ubc_flush_pending().  In further investigation, it is found
>> that the TLB flushing can be avoided in ptep_clear_flush() if the PTE
>> is inaccessible.  In fact, we can optimize in similar way for the
>> batched TLB flushing too to improve the performance.
>>=20
>> So in this patch, we check pte_accessible() before
>> set_tlb_ubc_flush_pending() in try_to_unmap/migrate_one().  Tests show
>> that the benchmark score of the anon-cow-rand-mt test case of
>> vm-scalability test suite can improve up to 2.1% with the patch on a
>> Intel server machine.  The TLB flushing IPI can reduce up to 44.3%.
>
> LGTM.

Thanks!

> I know it=E2=80=99s meaningless for x86 (but perhaps ARM would use this i=
nfra
> too): do we need smp_mb__after_atomic() after ptep_get_and_clear() and
> before pte_accessible()?

Why do we need the memory barrier?  IIUC, the PTL is locked, so PTE
value will not be changed under us.  Anything else?

> In addition, if this goes into stable (based on the Fixes tag), consider
> breaking it into 2 patches, when only one would be backported.

The fixed commit (7e12beb8ca2a ("migrate_pages: batch flushing TLB")) is
merged by v6.3-rc1.  So this patch will only be backported to v6.3 and
later.  Is it OK?

Best Regards,
Huang, Ying
