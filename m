Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5A1F96B59F7
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Mar 2023 10:18:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231140AbjCKJSB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 11 Mar 2023 04:18:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38698 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230380AbjCKJRc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Mar 2023 04:17:32 -0500
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8932111F2CC
        for <linux-kernel@vger.kernel.org>; Sat, 11 Mar 2023 01:15:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1678526107; x=1710062107;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=QYHrC8S+S28GyYZreVjvOCjkTbPe4ZnFhoCEntFwAjw=;
  b=Bg1P2NFqzMabTnUGM3Uc9eCNpCtJ+wExa5zZMM7uoky42ogpUaI6miHv
   gYls6nKd+mvsBTez6k7CyKPJQQzDgkeusEnzCcMvJvHKmFLhMNT74FRBV
   OLjeJ4Tp+du8R7QyIvqtJfyAD2lLcHr8d70/ldSEx1/Od2k0oSs6e9sW9
   uRIMhVTEzIOcaf7qZ7JhTyZtA0m3Cki6ifWfOIeXTlhdy0MyWNkgRKpWs
   nndr9CiVF+XffJFkQ5Q/QsBFpeYui03B5PS1ZIUjbA9gNYH5tAwdU9uTP
   yFArAIqptO3g3EtJfzHocx/eKDcHsBZu5l6mHcFS0ej+nnfFBO01IDhEW
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10645"; a="317279543"
X-IronPort-AV: E=Sophos;i="5.98,252,1673942400"; 
   d="scan'208";a="317279543"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Mar 2023 01:14:15 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10645"; a="742283372"
X-IronPort-AV: E=Sophos;i="5.98,252,1673942400"; 
   d="scan'208";a="742283372"
Received: from unknown (HELO fred..) ([172.25.112.68])
  by fmsmga008.fm.intel.com with ESMTP; 11 Mar 2023 01:14:14 -0800
From:   Xin Li <xin3.li@intel.com>
To:     linux-kernel@vger.kernel.org, x86@kernel.org
Cc:     tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
        dave.hansen@linux.intel.com, hpa@zytor.com, bigeasy@linutronix.de,
        yujie.liu@intel.com, shan.kang@intel.com
Subject: [PATCH 1/1] x86/vdso: use the right GDT_ENTRY_CPUNODE for 32-bit getcpu() on 64-bit kernel
Date:   Sat, 11 Mar 2023 00:48:24 -0800
Message-Id: <20230311084824.2340-1-xin3.li@intel.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The vDSO getcpu() reads CPU ID from the GDT_ENTRY_CPUNODE entry when the RDPID
instruction is not available. And GDT_ENTRY_CPUNODE is defined as 28 on 32-bit
Linux kernel and 15 on 64-bit. But the 32-bit getcpu() on 64-bit Linux kernel
is compiled with 32-bit Linux kernel GDT_ENTRY_CPUNODE, i.e., 28, beyond the
64-bit Linux kernel GDT limit. Thus, it just fails _silently_.

Compile the 32-bit getcpu() on 64-bit Linux kernel with the 64-bit Linux kernel
GDT_ENTRY_CPUNODE.

Fixes: 877cff5296faa6e ("x86/vdso: Fake 32bit VDSO build on 64bit compile for vgetcpu")
Reported-by: kernel test robot <yujie.liu@intel.com>
https://lore.kernel.org/oe-lkp/202303020903.b01fd1de-yujie.liu@intel.com/
Reported-by: Shan Kang <shan.kang@intel.com>
Signed-off-by: Xin Li <xin3.li@intel.com>
---
 arch/x86/include/asm/segment.h | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/x86/include/asm/segment.h b/arch/x86/include/asm/segment.h
index 794f69625780..d3b4f8797054 100644
--- a/arch/x86/include/asm/segment.h
+++ b/arch/x86/include/asm/segment.h
@@ -119,7 +119,11 @@
 
 #define GDT_ENTRY_ESPFIX_SS		26
 #define GDT_ENTRY_PERCPU		27
+#ifndef BUILD_VDSO32_64
 #define GDT_ENTRY_CPUNODE		28
+#else
+#define GDT_ENTRY_CPUNODE		15
+#endif
 
 #define GDT_ENTRY_DOUBLEFAULT_TSS	31
 
-- 
2.34.1

