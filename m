Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E622A63AA94
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Nov 2022 15:12:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232338AbiK1OL5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Nov 2022 09:11:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39354 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230433AbiK1OLz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Nov 2022 09:11:55 -0500
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E7611084
        for <linux-kernel@vger.kernel.org>; Mon, 28 Nov 2022 06:11:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1669644715; x=1701180715;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=Ly7xH76aXxISzs1AQ7XpI4XIrI96mfoziBP0GQJejRY=;
  b=ajWdWipPWEDcEmwphNHZV6t15a/RhmoSP7vWK8j9HRVdZe/61DeXD9ag
   Ik4qJDcERm6fbcrFNn1nL/EA0YKJBGaMFxCMt8PU0QwsajwNHC8bWMRBI
   ifD6WMAgDiWtMk8dZXMpqx1YT58svwXwlaG96p7EAY0mTU9CONyoT/Hko
   G1YLrxXpJmjKTZMQ0uuL9Suw9R0yIh+P4QZm+K4irdYeaKE7N/vFb341m
   uLvDKgevTm5cwqVR4dS+Z21gQwviFSMjP06MLFu7oTDz4+ivnuJoo3mrz
   3fraUtMwQjFpif9oP4b0iy34Yv9D96/U16LMdjpndeK46pcL4oFydZ0Bh
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10545"; a="302419498"
X-IronPort-AV: E=Sophos;i="5.96,200,1665471600"; 
   d="scan'208";a="302419498"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Nov 2022 06:09:39 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10545"; a="817834872"
X-IronPort-AV: E=Sophos;i="5.96,200,1665471600"; 
   d="scan'208";a="817834872"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga005.jf.intel.com with ESMTP; 28 Nov 2022 06:09:38 -0800
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 8A64E179; Mon, 28 Nov 2022 16:10:04 +0200 (EET)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-kernel@vger.kernel.org
Cc:     Andy Lutomirski <luto@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCH v1 1/1] vdso/bits.h: Add BIT_ULL() for the sake of consistency
Date:   Mon, 28 Nov 2022 16:10:03 +0200
Message-Id: <20221128141003.77929-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

While the minimization is a good thing, the split added some
inconsistency since BIT() and BIT_ULL() defined in the different
files and confuses unprepared reader. Let's move BIT_ULL()
to vdso/bits.h, so they will go together (as UL(), ULL() and
so on).

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 include/linux/bits.h | 1 -
 include/vdso/bits.h  | 1 +
 2 files changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/bits.h b/include/linux/bits.h
index 87d112650dfb..7c0cf5031abe 100644
--- a/include/linux/bits.h
+++ b/include/linux/bits.h
@@ -6,7 +6,6 @@
 #include <vdso/bits.h>
 #include <asm/bitsperlong.h>
 
-#define BIT_ULL(nr)		(ULL(1) << (nr))
 #define BIT_MASK(nr)		(UL(1) << ((nr) % BITS_PER_LONG))
 #define BIT_WORD(nr)		((nr) / BITS_PER_LONG)
 #define BIT_ULL_MASK(nr)	(ULL(1) << ((nr) % BITS_PER_LONG_LONG))
diff --git a/include/vdso/bits.h b/include/vdso/bits.h
index 6d005a1f5d94..388b212088ea 100644
--- a/include/vdso/bits.h
+++ b/include/vdso/bits.h
@@ -5,5 +5,6 @@
 #include <vdso/const.h>
 
 #define BIT(nr)			(UL(1) << (nr))
+#define BIT_ULL(nr)		(ULL(1) << (nr))
 
 #endif	/* __VDSO_BITS_H */
-- 
2.35.1

