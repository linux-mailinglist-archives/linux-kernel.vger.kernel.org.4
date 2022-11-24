Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 05DF9637F4E
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Nov 2022 19:48:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229681AbiKXSsY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Nov 2022 13:48:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37978 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229580AbiKXSsW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Nov 2022 13:48:22 -0500
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B867D65A5
        for <linux-kernel@vger.kernel.org>; Thu, 24 Nov 2022 10:48:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1669315701; x=1700851701;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=qxZ51m9u691OKiCL/ysfXIXNDKj1rsv+8wIP0koy6OA=;
  b=FUyjQmbtWsolF2oBr0oPVOGBif+Fz/jGoudhlPKd96lRs2I3/SdIPfRR
   uZnPbSePfUYihsF3UTC+4cD4nQRwgE9jTChp8h4eUhnwX4SG2YA/4eSwx
   78ssq8QaSznKU7XpTr01xZfbfE+xVXmwXXJE1TRKGRmTFCucSAi7OphrW
   Q8dCqEDrXzKvl1LYkgO1iUdNP3bgx4kpaaDldqCZ7jKpNb9Ob+tUqk5v1
   a+TUgXf5gOkthUT5gUTSTsMLvPM5EWDzTopUqFiGMz7rE84YxbmPera8W
   gVayQL1lalnl7X7L/Nda30QToDcAXEZ7ZeRWNCPo3xrmBF7acb0ynm4YF
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10541"; a="313051827"
X-IronPort-AV: E=Sophos;i="5.96,190,1665471600"; 
   d="scan'208";a="313051827"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Nov 2022 10:48:21 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10541"; a="711044940"
X-IronPort-AV: E=Sophos;i="5.96,190,1665471600"; 
   d="scan'208";a="711044940"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga004.fm.intel.com with ESMTP; 24 Nov 2022 10:48:19 -0800
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 26F49128; Thu, 24 Nov 2022 20:48:45 +0200 (EET)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-kernel@vger.kernel.org
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        "H. Peter Anvin" <hpa@zytor.com>, Rob Herring <robh@kernel.org>
Subject: [PATCH v1 1/1] x86/of: Remove unused early_init_dt_add_memory_arch()
Date:   Thu, 24 Nov 2022 20:48:24 +0200
Message-Id: <20221124184824.9548-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Recently the objtool starts complaining on the dead code
in the object files, in particular

vmlinux.o: warning: objtool: early_init_dt_scan_memory+0x191: unreachable instruction

when CONFIG_OF=y.

Indeed, the entire early_init_dt_scan() is not used on x86 and making it
compile (with help of CONFIG_OF) will abrupt the code flow since in the
middle of it we have a BUG() instruction.

Remove the entire culprit function to make objtool happy.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 arch/x86/kernel/devicetree.c | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/arch/x86/kernel/devicetree.c b/arch/x86/kernel/devicetree.c
index 5cd51f25f446..59438d2b204c 100644
--- a/arch/x86/kernel/devicetree.c
+++ b/arch/x86/kernel/devicetree.c
@@ -31,11 +31,6 @@ char __initdata cmd_line[COMMAND_LINE_SIZE];
 
 int __initdata of_ioapic;
 
-void __init early_init_dt_add_memory_arch(u64 base, u64 size)
-{
-	BUG();
-}
-
 void __init add_dtb(u64 data)
 {
 	initial_dtb = data + offsetof(struct setup_data, data);
-- 
2.35.1

