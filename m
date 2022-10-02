Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6A8185F20AC
	for <lists+linux-kernel@lfdr.de>; Sun,  2 Oct 2022 02:04:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229678AbiJBAEX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 1 Oct 2022 20:04:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44474 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229441AbiJBAEV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 1 Oct 2022 20:04:21 -0400
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 895CF42AD8
        for <linux-kernel@vger.kernel.org>; Sat,  1 Oct 2022 17:04:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1664669060; x=1696205060;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=GyMQ4fAFhFEPUtgkxoJLcx+5+nuagAWkZaTa8992K6Y=;
  b=adzpO3ytZCTxCxrRRcgOn6jF+GYfgm2P3+j8OvRSx3EY6ftxpgsOLG/Y
   hRVPlu/bbLz5QLyRYUMqoNzcPT4yFjvPiZ6t+gRt2FlSnCUp/GJIFyI88
   L/yEUKB/PW0RiGpESy5WWoBu6EEX8xOnRi48C96KWHbzQTAfprKDsWxhq
   CV9vc0uC8UINBdWCcN/EsdldXPcWVoYVUnfBPIdetGzg7Bl5PzowQrQDL
   5xqWFYAD4AvnbR9HvwEmh0wQRPzdUmkB7sQ2xeBeNSkM/se65Rv6mKcok
   fdsz2QWf1IpE5/f2Tdm3wM4ON9lVCtkoyStlA0eNDJLga8mWZ8zy9aIW4
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10487"; a="282140739"
X-IronPort-AV: E=Sophos;i="5.93,361,1654585200"; 
   d="scan'208";a="282140739"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Oct 2022 17:04:20 -0700
X-IronPort-AV: E=McAfee;i="6500,9779,10487"; a="600816512"
X-IronPort-AV: E=Sophos;i="5.93,361,1654585200"; 
   d="scan'208";a="600816512"
Received: from iweiny-desk3.amr.corp.intel.com (HELO localhost) ([10.213.181.73])
  by orsmga006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Oct 2022 17:04:19 -0700
From:   ira.weiny@intel.com
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Ira Weiny <ira.weiny@intel.com>,
        Bjorn Helgaas <helgaas@kernel.org>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] x86/fixmap: Decouple KMAP_LOCAL from PCI_MMCONFIG
Date:   Sat,  1 Oct 2022 17:04:15 -0700
Message-Id: <20221002000415.945080-1-ira.weiny@intel.com>
X-Mailer: git-send-email 2.37.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ira Weiny <ira.weiny@intel.com>

In commit 14df32670291 ("x86: Support kmap_local() forced debugging")
FIX_PCIE_MCFG became dependent on KMAP_LOCAL.  This works because
CONFIG_KMAP_LOCAL depends on CONFIG_X86_32 which the commit changed.

config X86_32
        def_bool y
        depends on !64BIT
...
        select KMAP_LOCAL
...

However, there is no direct relationship between the two.  Adjust the
conditionals to make them independent of each other.

Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Bjorn Helgaas <helgaas@kernel.org>
Signed-off-by: Ira Weiny <ira.weiny@intel.com>
---
 arch/x86/include/asm/fixmap.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/include/asm/fixmap.h b/arch/x86/include/asm/fixmap.h
index d0dcefb5cc59..1c79398babf3 100644
--- a/arch/x86/include/asm/fixmap.h
+++ b/arch/x86/include/asm/fixmap.h
@@ -101,10 +101,10 @@ enum fixed_addresses {
 #ifdef CONFIG_KMAP_LOCAL
 	FIX_KMAP_BEGIN,	/* reserved pte's for temporary kernel mappings */
 	FIX_KMAP_END = FIX_KMAP_BEGIN + (KM_MAX_IDX * NR_CPUS) - 1,
+#endif
 #ifdef CONFIG_PCI_MMCONFIG
 	FIX_PCIE_MCFG,
 #endif
-#endif
 #ifdef CONFIG_PARAVIRT_XXL
 	FIX_PARAVIRT_BOOTMAP,
 #endif

base-commit: 274d7803837da78dfc911bcda0d593412676fc20
-- 
2.37.2

