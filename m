Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0EF27715DA4
	for <lists+linux-kernel@lfdr.de>; Tue, 30 May 2023 13:44:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231534AbjE3LoC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 May 2023 07:44:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46792 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232014AbjE3Lng (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 May 2023 07:43:36 -0400
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F79C133
        for <linux-kernel@vger.kernel.org>; Tue, 30 May 2023 04:43:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1685446999; x=1716982999;
  h=from:to:subject:date:message-id:in-reply-to:references:
   mime-version:content-transfer-encoding;
  bh=xQZb8SAxwU6SoQGhaHHq0FWbUrqK8Nv6ppaW+XnUfoU=;
  b=RoKyKhEhFjmbIvKvb7wraknEbKwCLyQbbXQyMBMXoXsCWDZFTeQFr7Dv
   w8NXlZYpXX9lgAr2eRZtIdDwT+QfsVjI3g3+bEp/l/UVVqgq439SgKlNG
   ejJC/aGp8EU2Gt8yHiNAZNqHthD1tvmQrZyQL6V5TVCv8iezb89NL3FsJ
   pr9lPhfq+2NqicO3sPjrJRxZSdx4mZt3hHvj9RNDEn6TYTVREbFARj5G1
   UnBV9VH/RCijorXwGAroWpSgud/DTWW5n/rFuYt8KTqG/VrAG2qnNC1qR
   RjoTSK8O9uAErxw2e5ug+u3q6qfjwTZCSbQNnnLMztks5zLnFbBMSyrlV
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10725"; a="383145349"
X-IronPort-AV: E=Sophos;i="6.00,204,1681196400"; 
   d="scan'208";a="383145349"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 May 2023 04:43:05 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10725"; a="700588692"
X-IronPort-AV: E=Sophos;i="6.00,204,1681196400"; 
   d="scan'208";a="700588692"
Received: from black.fi.intel.com (HELO black.fi.intel.com.) ([10.237.72.28])
  by orsmga007.jf.intel.com with ESMTP; 30 May 2023 04:43:02 -0700
From:   Alexander Shishkin <alexander.shishkin@linux.intel.com>
To:     linux-kernel@vger.kernel.org, x86@kernel.org,
        Andy Lutomirski <luto@kernel.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Ravi Shankar <ravi.v.shankar@intel.com>,
        Tony Luck <tony.luck@intel.com>,
        Sohil Mehta <sohil.mehta@intel.com>,
        Paul Lai <paul.c.lai@intel.com>
Subject: [PATCH v2 03/12] x86/alternatives: Disable LASS when patching kernel alternatives
Date:   Tue, 30 May 2023 14:42:38 +0300
Message-Id: <20230530114247.21821-4-alexander.shishkin@linux.intel.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230530114247.21821-1-alexander.shishkin@linux.intel.com>
References: <20230530114247.21821-1-alexander.shishkin@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Sohil Mehta <sohil.mehta@intel.com>

For patching, the kernel initializes a temporary mm area in the lower
half of the address range. See commit 4fc19708b165 ("x86/alternatives:
Initialize temporary mm for patching").

Disable LASS enforcement during patching using the stac()/clac()
instructions to avoid triggering a #GP fault.

The objtool warns due to a call to a non-allowed function that exists
outside of the stac/clac guard, or references to any function with a
dynamic function pointer inside the guard. See the Objtool warnings
section #9 in the document tools/objtool/Documentation/objtool.txt.

Considering that patching is usually small, replace the memcpy and
memset functions in the text poking functions with their inline versions
respectively.

Signed-off-by: Sohil Mehta <sohil.mehta@intel.com>
---
 arch/x86/kernel/alternative.c | 12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

diff --git a/arch/x86/kernel/alternative.c b/arch/x86/kernel/alternative.c
index f615e0cb6d93..eac6a5406d39 100644
--- a/arch/x86/kernel/alternative.c
+++ b/arch/x86/kernel/alternative.c
@@ -1526,16 +1526,24 @@ static inline void unuse_temporary_mm(temp_mm_state_t prev_state)
 __ro_after_init struct mm_struct *poking_mm;
 __ro_after_init unsigned long poking_addr;
 
+/*
+ * poking_init() initializes the text poking address from the lower half of the
+ * address space. Relax LASS enforcement when accessing the poking address.
+ */
 static void text_poke_memcpy(void *dst, const void *src, size_t len)
 {
-	memcpy(dst, src, len);
+	stac();
+	__inline_memcpy(dst, src, len);
+	clac();
 }
 
 static void text_poke_memset(void *dst, const void *src, size_t len)
 {
 	int c = *(const int *)src;
 
-	memset(dst, c, len);
+	stac();
+	__inline_memset(dst, c, len);
+	clac();
 }
 
 typedef void text_poke_f(void *dst, const void *src, size_t len);
-- 
2.39.2

