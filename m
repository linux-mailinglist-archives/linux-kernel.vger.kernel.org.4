Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7945B715DAC
	for <lists+linux-kernel@lfdr.de>; Tue, 30 May 2023 13:45:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231363AbjE3Lod (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 May 2023 07:44:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47062 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231558AbjE3Lnx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 May 2023 07:43:53 -0400
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 44206D9
        for <linux-kernel@vger.kernel.org>; Tue, 30 May 2023 04:43:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1685447025; x=1716983025;
  h=from:to:subject:date:message-id:in-reply-to:references:
   mime-version:content-transfer-encoding;
  bh=gvJTTiJQPueT57YJhcau7miaCzoaYCvVoo9At4Pni/s=;
  b=BSphozwyPcGocoBFxHvJo5aOWSmGBQ6ZzVQ1uMeUEKp1cRd2X19aJkfl
   Wf4YAhXsx8TBRNDzMccqvO7/cRNtexYmlynV5qNWt6PkCcXHbacsPXuSk
   6FnPccwVKpI3UAr51P/ROkiUKFbWZ2i0cm3GrGasd4/sz8AXzDVqnxJcb
   cQySVcqvFKr9qxgqMGUAXq2nANL27SiCCtLQekZhAHcz2I84XujggiBjk
   I9yYLMLoIq6QymzjSjo5X+8sDNUpMRqPKD3e4UGqyOpp8a8vpSR+tQ4cf
   FxwaK9oQ20KYxvgct2b3WGz6S8LKsZnFSix3LfNrT1iALOlddSKxBBaaE
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10725"; a="383145391"
X-IronPort-AV: E=Sophos;i="6.00,204,1681196400"; 
   d="scan'208";a="383145391"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 May 2023 04:43:20 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10725"; a="700588756"
X-IronPort-AV: E=Sophos;i="6.00,204,1681196400"; 
   d="scan'208";a="700588756"
Received: from black.fi.intel.com (HELO black.fi.intel.com.) ([10.237.72.28])
  by orsmga007.jf.intel.com with ESMTP; 30 May 2023 04:43:17 -0700
From:   Alexander Shishkin <alexander.shishkin@linux.intel.com>
To:     linux-kernel@vger.kernel.org, x86@kernel.org,
        Andy Lutomirski <luto@kernel.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Ravi Shankar <ravi.v.shankar@intel.com>,
        Tony Luck <tony.luck@intel.com>,
        Sohil Mehta <sohil.mehta@intel.com>,
        Paul Lai <paul.c.lai@intel.com>
Subject: [PATCH v2 09/12] x86/vsyscall: Disable LASS if vsyscall mode is set to EMULATE
Date:   Tue, 30 May 2023 14:42:44 +0300
Message-Id: <20230530114247.21821-10-alexander.shishkin@linux.intel.com>
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

The EMULATE mode of vsyscall maps the vsyscall page into user address
space which can be read directly by the user application. This mode has
been deprecated recently and can only be enabled from a special command
line parameter vsyscall=emulate. See commit bf00745e7791 ("x86/vsyscall:
Remove CONFIG_LEGACY_VSYSCALL_EMULATE")

Fixing the LASS violations during the EMULATE mode would need complex
instruction decoding since the resulting #GP fault does not include any
useful error information and the vsyscall address is not readily
available in the RIP.

At this point, no one is expected to be using the insecure and
deprecated EMULATE mode. The rare usages that need support probably
don't care much about security anyway. Disable LASS when EMULATE mode is
requested during command line parsing to avoid breaking user software.
LASS will be supported if vsyscall mode is set to XONLY or NONE.

Signed-off-by: Sohil Mehta <sohil.mehta@intel.com>
---
 arch/x86/entry/vsyscall/vsyscall_64.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/arch/x86/entry/vsyscall/vsyscall_64.c b/arch/x86/entry/vsyscall/vsyscall_64.c
index 76e1344997d2..edd58eda8f50 100644
--- a/arch/x86/entry/vsyscall/vsyscall_64.c
+++ b/arch/x86/entry/vsyscall/vsyscall_64.c
@@ -36,6 +36,7 @@
 #include <asm/vsyscall.h>
 #include <asm/unistd.h>
 #include <asm/fixmap.h>
+#include <asm/tlbflush.h>
 #include <asm/traps.h>
 #include <asm/paravirt.h>
 
@@ -63,6 +64,13 @@ static int __init vsyscall_setup(char *str)
 		else
 			return -EINVAL;
 
+		if (cpu_feature_enabled(X86_FEATURE_LASS) &&
+		    vsyscall_mode == EMULATE) {
+			cr4_clear_bits(X86_CR4_LASS);
+			setup_clear_cpu_cap(X86_FEATURE_LASS);
+			pr_info_once("x86/cpu: Disabling LASS support due to vsyscall=emulate\n");
+		}
+
 		return 0;
 	}
 
-- 
2.39.2

