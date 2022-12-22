Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CA240653FE4
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Dec 2022 12:51:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235682AbiLVLvV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Dec 2022 06:51:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47892 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235197AbiLVLtt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Dec 2022 06:49:49 -0500
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E95D29369;
        Thu, 22 Dec 2022 03:48:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1671709717; x=1703245717;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=XiqeX8OeZdoKUwrXM421vQgERq+9V4kGiGuMnC/Jf7o=;
  b=nqWG5QnFL5OQGFYBvWW0sTdS2KeWDm9be9l3a9unZXEVrGGSM7TV5vLA
   bRhKqXUWaib63O2/ly8KB+rQy608WYLfA8y4JOSlXuVUyWJ+BNt2CoBOB
   k9WJGhto4OVbBLIqS4Vm8OGW1kXbSN9xTQVZszuvdNww5wNJBbhCrnEeM
   WHGs2SuZ0obRcoPuhB/sxCbtYhH3i5qVeWC2cugdG+b7tD8q8rNxf29Qa
   ZVBw48F+NyZISNeaEOm3v/Cv+k32akMxSwihEjMmmGaLNWIUfGSY/8KGR
   lzJ06GmM9iXdo9J5VD/EdRF8cSSdf957ID60ghlgF8ZdS/+hnNS5Jk8nd
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10568"; a="318804788"
X-IronPort-AV: E=Sophos;i="5.96,265,1665471600"; 
   d="scan'208";a="318804788"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Dec 2022 03:48:36 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10568"; a="629504799"
X-IronPort-AV: E=Sophos;i="5.96,265,1665471600"; 
   d="scan'208";a="629504799"
Received: from lab-ah.igk.intel.com ([10.91.215.196])
  by orsmga006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Dec 2022 03:48:30 -0800
From:   Andrzej Hajda <andrzej.hajda@intel.com>
To:     linux-alpha@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-snps-arc@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org,
        linux-hexagon@vger.kernel.org, linux-ia64@vger.kernel.org,
        loongarch@lists.linux.dev, linux-m68k@lists.linux-m68k.org,
        linux-mips@vger.kernel.org, openrisc@lists.librecores.org,
        linux-parisc@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        linux-riscv@lists.infradead.org, linux-s390@vger.kernel.org,
        linux-sh@vger.kernel.org, sparclinux@vger.kernel.org,
        linux-xtensa@linux-xtensa.org, intel-gfx@lists.freedesktop.org,
        dri-devel@lists.freedesktop.org
Cc:     Andrzej Hajda <andrzej.hajda@intel.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Boqun Feng <boqun.feng@gmail.com>,
        Mark Rutland <mark.rutland@arm.com>
Subject: [PATCH 12/19] arch/powerpc: correct logged function names in xchg helpers
Date:   Thu, 22 Dec 2022 12:46:28 +0100
Message-Id: <20221222114635.1251934-13-andrzej.hajda@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20221222114635.1251934-1-andrzej.hajda@intel.com>
References: <20221222114635.1251934-1-andrzej.hajda@intel.com>
MIME-Version: 1.0
Organization: Intel Technology Poland sp. z o.o. - ul. Slowackiego 173, 80-298 Gdansk - KRS 101882 - NIP 957-07-52-316
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

__xchg will be used for non-atomic xchg macro.

Signed-off-by: Andrzej Hajda <andrzej.hajda@intel.com>
---
 arch/powerpc/include/asm/cmpxchg.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/powerpc/include/asm/cmpxchg.h b/arch/powerpc/include/asm/cmpxchg.h
index 05f246c0e36eb3..b5624c9fe09bf7 100644
--- a/arch/powerpc/include/asm/cmpxchg.h
+++ b/arch/powerpc/include/asm/cmpxchg.h
@@ -163,7 +163,7 @@ __xchg_local(void *ptr, unsigned long x, unsigned int size)
 		return __xchg_u64_local(ptr, x);
 #endif
 	}
-	BUILD_BUG_ON_MSG(1, "Unsupported size for __xchg");
+	BUILD_BUG_ON_MSG(1, "Unsupported size for __xchg_local");
 	return x;
 }
 
@@ -182,7 +182,7 @@ __xchg_relaxed(void *ptr, unsigned long x, unsigned int size)
 		return __xchg_u64_relaxed(ptr, x);
 #endif
 	}
-	BUILD_BUG_ON_MSG(1, "Unsupported size for __xchg_local");
+	BUILD_BUG_ON_MSG(1, "Unsupported size for __xchg_relaxed");
 	return x;
 }
 #define arch_xchg_local(ptr,x)						     \
-- 
2.34.1

