Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A276960AF16
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Oct 2022 17:31:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231864AbiJXPbL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Oct 2022 11:31:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36774 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232048AbiJXPav (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Oct 2022 11:30:51 -0400
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AED021A9900
        for <linux-kernel@vger.kernel.org>; Mon, 24 Oct 2022 07:17:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1666621040; x=1698157040;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=vjLUo0d5GXV0ni6+ddEs2sp+kzKyXOmoq/0N6AX5ATg=;
  b=HuS5pPx7lawsgqVWX0EmMJmwj5RnSAuQi5qglEzALD7oEIAMK4sjoglc
   dJm3Hd5shrnpn+w7PbIiE84JDi5LZ4AyzbPEzN9xER1Kch8lqPyl7WU61
   jaQGrMeCKw00EXJIRerEgLDDxJVEniapW0Jm+ZzgVm5sy1b/rAJeVpsw8
   GD1TxNpkJdviLZf/3MgtjxttB13k7YhSYH/kDxZsqXYakfVwaMTSpR7pT
   nvxHmErwtflZk0peXVCDxxkw5qOKsdzYdBoo1qsuJVtzovIK/KhgE8TI2
   3ZxqEIS3bKpAGF4owov0K6qq8mkXGSbm3aVqRxnag+e++mQs/C8mzVi2W
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10510"; a="369482023"
X-IronPort-AV: E=Sophos;i="5.95,209,1661842800"; 
   d="scan'208";a="369482023"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Oct 2022 06:24:18 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10510"; a="960426203"
X-IronPort-AV: E=Sophos;i="5.95,209,1661842800"; 
   d="scan'208";a="960426203"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga005.fm.intel.com with ESMTP; 24 Oct 2022 06:24:17 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 272AB291; Mon, 24 Oct 2022 16:24:39 +0300 (EEST)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Ingo Molnar <mingo@kernel.org>, linux-kernel@vger.kernel.org
Cc:     Andrew Morton <akpm@linux-foundation.org>
Subject: [rft, PATCH v1 1/4] kernel.h: Move READ/WRITE definitions to <linux/types.h>
Date:   Mon, 24 Oct 2022 16:24:31 +0300
Message-Id: <20221024132434.47057-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ingo Molnar <mingo@kernel.org>

Headers shouldn't be forced to include <linux/kernel.h> just to
gain these simple constants.

Signed-off-by: Ingo Molnar <mingo@kernel.org>
Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 include/linux/kernel.h | 4 ----
 include/linux/types.h  | 4 ++++
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/include/linux/kernel.h b/include/linux/kernel.h
index fe6efb24d151..bc3e0364970a 100644
--- a/include/linux/kernel.h
+++ b/include/linux/kernel.h
@@ -44,10 +44,6 @@
  */
 #define REPEAT_BYTE(x)	((~0ul / 0xff) * (x))
 
-/* generic data direction definitions */
-#define READ			0
-#define WRITE			1
-
 /**
  * ARRAY_SIZE - get the number of elements in array @arr
  * @arr: array to be sized
diff --git a/include/linux/types.h b/include/linux/types.h
index ea8cf60a8a79..67846bc43d53 100644
--- a/include/linux/types.h
+++ b/include/linux/types.h
@@ -125,6 +125,10 @@ typedef s64			int64_t;
 typedef u64 sector_t;
 typedef u64 blkcnt_t;
 
+/* generic data direction definitions */
+#define READ			0
+#define WRITE			1
+
 /*
  * The type of an index into the pagecache.
  */
-- 
2.35.1

