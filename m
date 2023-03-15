Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 15CDB6BC0C3
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Mar 2023 00:21:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232963AbjCOXVI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Mar 2023 19:21:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58476 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232941AbjCOXVC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Mar 2023 19:21:02 -0400
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E694A54DA
        for <linux-kernel@vger.kernel.org>; Wed, 15 Mar 2023 16:21:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1678922461; x=1710458461;
  h=from:subject:date:message-id:mime-version:
   content-transfer-encoding:to:cc;
  bh=JtqPhoEKPXalriYhJjGElknB+PaqWOwwVH9zLKYLARE=;
  b=GRx26INRVb9w7L9d55xxWbNAWCi8pblyBiIAk3n2CbMIF5a1HeBt6hmh
   LkPo+DkSng6Xd4YS1wGa4nIw9mjUmR4apR0AxsxOUzDdm4/y1mVcsverT
   nr6XiHWvJgputAxY7u0+Mza34yqwCdmLgKD+UUxPK5FJG+jMJHc2RL8Uy
   0WV/prWwYaLxE3H0qGoYKGMTLi842lsMVOeVBrrAvfiSbndx0Zo90hm5L
   8T/FAQPcKNtCwrTKCVv7j+vSs67PwJchq+Uv9jGuLGoSkCa/0dSkrVPaK
   oC6EThplqZPolJ56lQhjPYmGgongVWog0gMgRNB3+leniMswhIF7XEPWM
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10650"; a="365527029"
X-IronPort-AV: E=Sophos;i="5.98,262,1673942400"; 
   d="scan'208";a="365527029"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Mar 2023 16:21:01 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10650"; a="672915084"
X-IronPort-AV: E=Sophos;i="5.98,262,1673942400"; 
   d="scan'208";a="672915084"
Received: from iweiny-desk3.amr.corp.intel.com (HELO localhost) ([10.212.196.133])
  by orsmga007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Mar 2023 16:21:00 -0700
From:   Ira Weiny <ira.weiny@intel.com>
Subject: [PATCH 0/3] COVER: Remove memcpy_page_flushcache()
Date:   Wed, 15 Mar 2023 16:20:53 -0700
Message-Id: <20221230-kmap-x86-v1-0-15f1ecccab50@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIANVSEmQC/x2N0QrCMBAEf6XcswdJBCv+ivhwaTf2kMZyJ1Io/
 XdTH4edZTZymMLp1m1k+KrruzaIp46GSeoTrGNjSiGlmM6BX7MsvF4vnMsoPWIJPUBNz+LgbFK
 H6TjM4h/YMSyGouu/cX/s+w9yRuQEcwAAAA==
To:     Dave Hansen <dave.hansen@linux.intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Nicholas Piggin <npiggin@gmail.com>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, Ingo Molnar <mingo@redhat.com>,
        Borislav Petkov <bp@alien8.de>, x86@kernel.org,
        "H. Peter Anvin" <hpa@zytor.com>
Cc:     Dan Williams <dan.j.williams@intel.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        linux-arm-kernel@lists.infradead.org,
        Ira Weiny <ira.weiny@intel.com>
X-Mailer: b4 0.13-dev-ada30
X-Developer-Signature: v=1; a=ed25519-sha256; t=1678922459; l=998;
 i=ira.weiny@intel.com; s=20221222; h=from:subject:message-id;
 bh=JtqPhoEKPXalriYhJjGElknB+PaqWOwwVH9zLKYLARE=;
 b=U9HC5ieE6mtI6yDhHzLskDipFcXfN5V+3f/6dtOP+vYtK4gh7RQ5RqWHvkM2/fof3yGgZa9rC
 TzxAczQSZNABEql6X/OHl+LQecFJp7Jop+9LSTx06n4/b9j5a3XT3GW
X-Developer-Key: i=ira.weiny@intel.com; a=ed25519;
 pk=brwqReAJklzu/xZ9FpSsMPSQ/qkSalbg6scP3w809Ec=
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit 21b56c847753 ("iov_iter: get rid of separate bvec and xarray 
callbacks") removed the calls to memcpy_page_flushcache().

kmap_atomic() is deprecated and used in the x86 version of
memcpy_page_flushcache().

Remove the unnecessary memcpy_page_flushcache() call from all arch's.

Signed-off-by: Ira Weiny <ira.weiny@intel.com>
---
Ira Weiny (3):
      x86, uaccess: Remove memcpy_page_flushcache()
      powerpc: Remove memcpy_page_flushcache()
      arm: uaccess: Remove memcpy_page_flushcache()

 arch/arm64/include/asm/uaccess.h    | 2 --
 arch/arm64/lib/uaccess_flushcache.c | 6 ------
 arch/powerpc/include/asm/uaccess.h  | 2 --
 arch/powerpc/lib/pmem.c             | 7 -------
 arch/x86/include/asm/uaccess_64.h   | 2 --
 arch/x86/lib/usercopy_64.c          | 9 ---------
 6 files changed, 28 deletions(-)
---
base-commit: 6015b1aca1a233379625385feb01dd014aca60b5
change-id: 20221230-kmap-x86-bfda7e1f07ee

Best regards,
-- 
Ira Weiny <ira.weiny@intel.com>

