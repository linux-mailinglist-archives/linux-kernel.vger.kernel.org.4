Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 921AD74FEEC
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jul 2023 08:01:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231893AbjGLGBs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Jul 2023 02:01:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47908 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231855AbjGLGBo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jul 2023 02:01:44 -0400
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A90BC0
        for <linux-kernel@vger.kernel.org>; Tue, 11 Jul 2023 23:01:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1689141703; x=1720677703;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=NLp00fEtLzfAThjLKM31DTKLIpo3OIAVoOoRd7xeCPc=;
  b=c95HR/XKp8oU7FciF8FWYKEoXkFccaQ/jrABs0pZZPZ+erUKZ+8Cg0Wi
   OJXIQ/TRwUBYNtOuqRmfIsZggGf0qtJAWhMfShJhAyeS7yfw8efvucOaZ
   tNFdtCLRXF2XMYl6dqgapmtazIoQ8afTJrhN1tPbXRRE8vVKydb8L6FJu
   CZpPxvzHV1KAzKupwSX1dZZV55VGDzN49ajME8RViPCB7qTbfJFDMSGty
   SlaZpNFfbaWemvdLg/j9/wdzAZskKSdzrgvJWeudwdUUvBeQuzHankIIL
   2KkGCK3OqepfXwRTG65MFxLC1aa7LBpnPAFRc9WC/UlewA7Gdmw6QpQCk
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10768"; a="349662698"
X-IronPort-AV: E=Sophos;i="6.01,198,1684825200"; 
   d="scan'208";a="349662698"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jul 2023 23:01:42 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10768"; a="751039738"
X-IronPort-AV: E=Sophos;i="6.01,198,1684825200"; 
   d="scan'208";a="751039738"
Received: from fyin-dev.sh.intel.com ([10.239.159.32])
  by orsmga008.jf.intel.com with ESMTP; 11 Jul 2023 23:01:39 -0700
From:   Yin Fengwei <fengwei.yin@intel.com>
To:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        akpm@linux-foundation.org, yuzhao@google.com, willy@infradead.org,
        david@redhat.com, ryan.roberts@arm.com, shy828301@gmail.com
Cc:     fengwei.yin@intel.com
Subject: [RFC PATCH v2 0/3] support large folio for mlock
Date:   Wed, 12 Jul 2023 14:01:41 +0800
Message-Id: <20230712060144.3006358-1-fengwei.yin@intel.com>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Yu mentioned at [1] about the mlock() can't be applied to large folio.

I leant the related code and here is my understanding:
- For RLIMIT_MEMLOCK related, there is no problem. Becuase the
  RLIMIT_MEMLOCK statistics is not related underneath page. That means
  underneath page mlock or munlock doesn't impact the RLIMIT_MEMLOCK
  statistics collection which is always correct.

- For keeping the page in RAM, there is no problem either. At least,
  during try_to_unmap_one(), once detect the VMA has VM_LOCKED bit
  set in vm_flags, the folio will be kept whatever the folio is
  mlocked or not.

So the function of mlock for large folio works. But it's not optimized
because the page reclaim needs scan these large folio and may split
them.

This series identified the large folio for mlock to two types:
  - The large folio is in VM_LOCKED VMA range
  - The large folio cross VM_LOCKED VMA boundary

For the first type, we mlock large folio so page relcaim will skip it.
For the second type, we don't mlock large folio. It's allowed to be
picked by page reclaim and be split. So the pages not in VM_LOCKED VMA
range are allowed to be reclaimed/released.

patch1 introduce API to check whether large folio is in VMA range.
patch2 make page reclaim/mlock_vma_folio/munlock_vma_folio support
large folio mlock/munlock.
patch3 make mlock/munlock syscall support large folio.

testing done:
  - kernel selftest. No extra failure introduced

Matthew commented on v1 that the large folio should be split if it
crosses the VMA boundaries. But there is no obvious correct method
to handle split failure and it's a common issue for mprotect,
mlock, mremap, munmap....

So I keep v1 behaivor (not split folio if it crosses VMA boundaries)
in v2.

[1] https://lore.kernel.org/linux-mm/CAOUHufbtNPkdktjt_5qM45GegVO-rCFOMkSh0HQminQ12zsV8Q@mail.gmail.com/

Changes from v1:
  patch1:
    - Add new function folio_within_vma() based on folio_in_range()
      per Yu's suggestion

  patch2:
    - Update folio_referenced_one() to skip the entries which are
      out of VM_LOCKED VMA range if the large folio cross VMA
      boundaries per Yu's suggestion

  patch3:
    - Simplify the changes in mlock_pte_range() by introduing two
      helper functions should_mlock_folio() and get_folio_mlock_step()
      per Yu's suggestion


Yin Fengwei (3):
  mm: add functions folio_in_range() and folio_within_vma()
  mm: handle large folio when large folio in VM_LOCKED VMA range
  mm: mlock: update mlock_pte_range to handle large folio

 mm/internal.h |  43 +++++++++++++++++++--
 mm/mlock.c    | 104 +++++++++++++++++++++++++++++++++++++++++++++++---
 mm/rmap.c     |  34 +++++++++++++----
 3 files changed, 166 insertions(+), 15 deletions(-)

-- 
2.39.2

