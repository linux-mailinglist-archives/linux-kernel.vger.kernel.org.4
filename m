Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5E823653F74
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Dec 2022 12:48:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235640AbiLVLsf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Dec 2022 06:48:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47916 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235557AbiLVLr6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Dec 2022 06:47:58 -0500
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E6A182936D;
        Thu, 22 Dec 2022 03:47:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1671709672; x=1703245672;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=/UDTi8Vls0g/+nnPnB+HCzMyNgpTxrVUoGQF5kbhC34=;
  b=L/UNgQOY1hkOhED9qCOJYCMyjFWmp8LXn3SHYDDiDxAyy/mGRWM9hf3l
   2ct3OUk8mIovo1OslQRnV7+8dK9u8A/jcHV2tqkDYrj0fg5FAeq4XTGwF
   +6cUDasfDV8mWxEmfvcMS0856EVHTMK3ePSNLin7/2aiLlbxVbapF17Tm
   QFjrNyxaTp3CYWX5Di+cCcR3LIWd4yJtW8NSKcqRd1dvRbDzAvwR3OgcU
   Zp+uemdcAnoghHGBrXqvDBgW47+E8DhrRi9PfIpgG1ls4NuWrgyyiyBv2
   mk9Zjk8tBFmKIF3/xSTg2RPnRbQ8sZGf65nFU7HsTNx3zpNhVyVmM9jFG
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10568"; a="318804473"
X-IronPort-AV: E=Sophos;i="5.96,265,1665471600"; 
   d="scan'208";a="318804473"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Dec 2022 03:47:36 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10568"; a="629504368"
X-IronPort-AV: E=Sophos;i="5.96,265,1665471600"; 
   d="scan'208";a="629504368"
Received: from lab-ah.igk.intel.com ([10.91.215.196])
  by orsmga006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Dec 2022 03:47:30 -0800
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
Subject: [PATCH 02/19] arch/arc: rename internal name __xchg to __arch_xchg
Date:   Thu, 22 Dec 2022 12:46:18 +0100
Message-Id: <20221222114635.1251934-3-andrzej.hajda@intel.com>
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
 arch/arc/include/asm/cmpxchg.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arc/include/asm/cmpxchg.h b/arch/arc/include/asm/cmpxchg.h
index c5b544a5fe8106..e138fde067dea5 100644
--- a/arch/arc/include/asm/cmpxchg.h
+++ b/arch/arc/include/asm/cmpxchg.h
@@ -85,7 +85,7 @@
  */
 #ifdef CONFIG_ARC_HAS_LLSC
 
-#define __xchg(ptr, val)						\
+#define __arch_xchg(ptr, val)						\
 ({									\
 	__asm__ __volatile__(						\
 	"	ex  %0, [%1]	\n"	/* set new value */	        \
@@ -102,7 +102,7 @@
 									\
 	switch(sizeof(*(_p_))) {					\
 	case 4:								\
-		_val_ = __xchg(_p_, _val_);				\
+		_val_ = __arch_xchg(_p_, _val_);			\
 		break;							\
 	default:							\
 		BUILD_BUG();						\
-- 
2.34.1

