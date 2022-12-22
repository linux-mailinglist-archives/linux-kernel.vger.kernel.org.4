Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 76208653FC1
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Dec 2022 12:50:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235332AbiLVLuo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Dec 2022 06:50:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47970 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235645AbiLVLsf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Dec 2022 06:48:35 -0500
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 37EED2935C;
        Thu, 22 Dec 2022 03:48:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1671709699; x=1703245699;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=07z3AibggnCfLWienLDIJaBU50ZHlr966XQ+z1i7vJY=;
  b=TM5nSK7cwU2WF3E3/PLbW1e12JraOG19uqPozQo/rItcFUrgkXyJd49H
   qDc3Kzm2LLBqyzG7v/Bfg5CFM0hHlyeTpk1yHjzO7xBZ0GCdjBsdk3+L/
   K74ThwCnC+m62iQhl0NdKeJf/Ggg/yxOlAerb3wBUq2JBJTFB69uL2U+5
   vZYCYOhc0GEZu3sT3TCIeTzLo9/LGdBNxtrn6gnIQVDibjOOnGNykHWSb
   atZXD1FplAVbHjFk7ocEtUAd1+b1WOgD+Mlgo0kaHanXyco7wBZ4e+uNe
   NSfX13vJjtYueV7LGyBCaLzPFZT57PXBG+V3f/whP7vII9cZ4uVEOJLfx
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10568"; a="318804710"
X-IronPort-AV: E=Sophos;i="5.96,265,1665471600"; 
   d="scan'208";a="318804710"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Dec 2022 03:48:18 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10568"; a="629504737"
X-IronPort-AV: E=Sophos;i="5.96,265,1665471600"; 
   d="scan'208";a="629504737"
Received: from lab-ah.igk.intel.com ([10.91.215.196])
  by orsmga006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Dec 2022 03:48:12 -0800
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
Subject: [PATCH 09/19] arch/mips: rename internal name __xchg to __arch_xchg
Date:   Thu, 22 Dec 2022 12:46:25 +0100
Message-Id: <20221222114635.1251934-10-andrzej.hajda@intel.com>
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
 arch/mips/include/asm/cmpxchg.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/mips/include/asm/cmpxchg.h b/arch/mips/include/asm/cmpxchg.h
index 7ec9493b28614f..feed343ad483a9 100644
--- a/arch/mips/include/asm/cmpxchg.h
+++ b/arch/mips/include/asm/cmpxchg.h
@@ -68,7 +68,7 @@ extern unsigned long __xchg_small(volatile void *ptr, unsigned long val,
 				  unsigned int size);
 
 static __always_inline
-unsigned long __xchg(volatile void *ptr, unsigned long x, int size)
+unsigned long __arch_xchg(volatile void *ptr, unsigned long x, int size)
 {
 	switch (size) {
 	case 1:
@@ -102,7 +102,7 @@ unsigned long __xchg(volatile void *ptr, unsigned long x, int size)
 		smp_mb__before_llsc();					\
 									\
 	__res = (__typeof__(*(ptr)))					\
-		__xchg((ptr), (unsigned long)(x), sizeof(*(ptr)));	\
+		__arch_xchg((ptr), (unsigned long)(x), sizeof(*(ptr)));	\
 									\
 	smp_llsc_mb();							\
 									\
-- 
2.34.1

