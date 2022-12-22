Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C8730653F9A
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Dec 2022 12:49:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235559AbiLVLtK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Dec 2022 06:49:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47962 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235523AbiLVLsB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Dec 2022 06:48:01 -0500
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A110928E25;
        Thu, 22 Dec 2022 03:47:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1671709673; x=1703245673;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=+VGlWrUtqaEIUqy2OBJn82lI4eJE+r4QbaGV3gKpeCE=;
  b=VO/78JB9/yNQwWe+VaSRKu1uUXp2V4Gh3K1pAeIvfbclWGrQqGHLtlYR
   dF/1jp/xDpKOJhhA4AWlguZTA7TToSdUlYjNClaLx2++Z8E3MOeN5dChl
   Ub2evcY16CLcthTlrmloP1nTRuqz5nygeKlmeXJU10NlqmwHk5NATiu3Q
   GifTiEOHQ7oBy9R8IaWpVMRbJHj0wOQZrUifT9haRrrceoz6gF4aYfK/Q
   7XMQGOx8/EdmRlQJmrl4rSL45c9qU4qIObISrQ15asAWsZifkUtIkl54d
   VKq2tydp4Sm3UbvJ4gEiVN8VEAOdxTqdXK8oPWfrKBCuJw5hZacPcS5t8
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10568"; a="318804536"
X-IronPort-AV: E=Sophos;i="5.96,265,1665471600"; 
   d="scan'208";a="318804536"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Dec 2022 03:47:48 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10568"; a="629504464"
X-IronPort-AV: E=Sophos;i="5.96,265,1665471600"; 
   d="scan'208";a="629504464"
Received: from lab-ah.igk.intel.com ([10.91.215.196])
  by orsmga006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Dec 2022 03:47:42 -0800
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
Subject: [PATCH 04/19] arch/arm64: rename internal name __xchg to __arch_xchg
Date:   Thu, 22 Dec 2022 12:46:20 +0100
Message-Id: <20221222114635.1251934-5-andrzej.hajda@intel.com>
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
 arch/arm64/include/asm/cmpxchg.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/include/asm/cmpxchg.h b/arch/arm64/include/asm/cmpxchg.h
index 497acf134d9923..3a36ba58e8c2ef 100644
--- a/arch/arm64/include/asm/cmpxchg.h
+++ b/arch/arm64/include/asm/cmpxchg.h
@@ -62,7 +62,7 @@ __XCHG_CASE( ,  ,  mb_, 64, dmb ish, nop,  , a, l, "memory")
 #undef __XCHG_CASE
 
 #define __XCHG_GEN(sfx)							\
-static __always_inline  unsigned long __xchg##sfx(unsigned long x,	\
+static __always_inline  unsigned long __arch_xchg##sfx(unsigned long x,	\
 					volatile void *ptr,		\
 					int size)			\
 {									\
@@ -93,7 +93,7 @@ __XCHG_GEN(_mb)
 ({									\
 	__typeof__(*(ptr)) __ret;					\
 	__ret = (__typeof__(*(ptr)))					\
-		__xchg##sfx((unsigned long)(x), (ptr), sizeof(*(ptr))); \
+		__arch_xchg##sfx((unsigned long)(x), (ptr), sizeof(*(ptr))); \
 	__ret;								\
 })
 
-- 
2.34.1

