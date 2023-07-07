Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 383CC74B563
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jul 2023 18:53:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232808AbjGGQxE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Jul 2023 12:53:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33348 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232467AbjGGQxA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Jul 2023 12:53:00 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9583C213F
        for <linux-kernel@vger.kernel.org>; Fri,  7 Jul 2023 09:52:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1688748751; x=1720284751;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=44TeDqOSGPdOaD7ZSx3H22uGfgMB+zSFFCjyv01ZsZU=;
  b=kiaAsdAVAevuvw6EoDUNk+RcnrgEJ2z84KFivzqdxq0VfNs4zQgxDaOx
   fTl8QsJ+wm9AzUwEA8k7XmSu2HcFxB2cvgKN3rHYhbgRKCyODsuT1yTGc
   /f59+3dHip33MxH8UD4Bifn4gnxwo7Upf21swhNt0QicObogcZrYZpmnN
   fFhNlR4FDj8YgXQ4kqxZ8g04dboL7VZSmVKzcw2CYXl7M/yPuxNzjEoLt
   4fRtuQzmvfFFtJ82M5v+nlVYTeTZTvxVGRnDNrpOm/VVjKn0UPfoNAMi+
   xyT9NwA3+ZMBYQcwJgrXXXmCA3himXMuSKimXwRJ7wgSIEYp8tpeLvXWE
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10764"; a="353776184"
X-IronPort-AV: E=Sophos;i="6.01,189,1684825200"; 
   d="scan'208";a="353776184"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Jul 2023 09:52:22 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10764"; a="697290400"
X-IronPort-AV: E=Sophos;i="6.01,189,1684825200"; 
   d="scan'208";a="697290400"
Received: from fyin-dev.sh.intel.com ([10.239.159.32])
  by orsmga006.jf.intel.com with ESMTP; 07 Jul 2023 09:52:19 -0700
From:   Yin Fengwei <fengwei.yin@intel.com>
To:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        yuzhao@google.com, ryan.roberts@arm.com, shy828301@gmail.com,
        akpm@linux-foundation.org, willy@infradead.org, david@redhat.com
Cc:     fengwei.yin@intel.com
Subject: [RFC PATCH 0/3] support large folio for mlock
Date:   Sat,  8 Jul 2023 00:52:18 +0800
Message-Id: <20230707165221.4076590-1-fengwei.yin@intel.com>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
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


[1] https://lore.kernel.org/linux-mm/CAOUHufbtNPkdktjt_5qM45GegVO-rCFOMkSh0HQminQ12zsV8Q@mail.gmail.com/

Yin Fengwei (3):
  mm: add function folio_in_range()
  mm: handle large folio when large folio in VM_LOCKED VMA range
  mm: mlock: update mlock_pte_range to handle large folio

 mm/internal.h |  37 ++++++++++++++++--
 mm/mlock.c    | 103 ++++++++++++++++++++++++++++++++++++++++++++++----
 mm/rmap.c     |   3 +-
 3 files changed, 131 insertions(+), 12 deletions(-)

-- 
2.39.2

