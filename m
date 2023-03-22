Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1963F6C4377
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Mar 2023 07:45:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230105AbjCVGpZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Mar 2023 02:45:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46150 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230026AbjCVGoz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Mar 2023 02:44:55 -0400
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7CE6C5BDBE
        for <linux-kernel@vger.kernel.org>; Tue, 21 Mar 2023 23:44:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1679467442; x=1711003442;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=filNSMPYZWlECjrivq6FRSVbw/cDhlvzd0VGwFLNwtE=;
  b=H+YT0WmkxVuMvxeD7mtpltvdg4+gqqzUVv3Jzf3I2DmbxEumPVte9uPu
   dxpgz1INjId4D/Zzv50AmzHr7JIeu3WTQ07mYwntLW9oq0sda96KINU1p
   w84HmqyCVWoyGgNPd9NfCzLKHJ0UQGtPK998NrnC3KB+SBi8BaUrX0g3M
   /9P0DKXvlkL9UlaCp5RTGZkkzBMM4X5MoLALEfoQqulSgB/eh32D93P3U
   03MHNskb8l8oLZ4tJNDzW9X6BdVpvF5eYrxkGJI07d/Eh3SD8wULh3mr6
   fVzl0XPyVRPMVy2VoE7a0HQGuCLC5Yyk1lf16WCx7F7HKabv/bz2BpkgU
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10656"; a="366877607"
X-IronPort-AV: E=Sophos;i="5.98,281,1673942400"; 
   d="scan'208";a="366877607"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Mar 2023 23:43:54 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10656"; a="746187349"
X-IronPort-AV: E=Sophos;i="5.98,281,1673942400"; 
   d="scan'208";a="746187349"
Received: from unknown (HELO fred..) ([172.25.112.68])
  by fmsmga008.fm.intel.com with ESMTP; 21 Mar 2023 23:43:53 -0700
From:   Xin Li <xin3.li@intel.com>
To:     linux-kernel@vger.kernel.org, x86@kernel.org
Cc:     tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
        dave.hansen@linux.intel.com, hpa@zytor.com, bigeasy@linutronix.de,
        yujie.liu@intel.com, shan.kang@intel.com
Subject: [PATCH v2 1/1] x86/vdso: choose the right GDT_ENTRY_CPUNODE for 32-bit getcpu() on 64-bit kernel
Date:   Tue, 21 Mar 2023 23:17:58 -0700
Message-Id: <20230322061758.10639-1-xin3.li@intel.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.6
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

When BUILD_VDSO32_64 is defined, choose the 64-bit Linux kernel GDT definitions
to compile the 32-bit getcpu().

Fixes: 877cff5296faa6e ("x86/vdso: Fake 32bit VDSO build on 64bit compile for vgetcpu")
Reported-by: kernel test robot <yujie.liu@intel.com>
https://lore.kernel.org/oe-lkp/202303020903.b01fd1de-yujie.liu@intel.com/
Reported-by: Shan Kang <shan.kang@intel.com>
Signed-off-by: Xin Li <xin3.li@intel.com>
---

Change since v1:
* Define all of the GDT_ENTRY_* macros in *one* place, then make that *one*
  place depend on BUILD_VDSO32_64 (Dave Hansen).
---
 arch/x86/include/asm/segment.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/include/asm/segment.h b/arch/x86/include/asm/segment.h
index 794f69625780..9d6411c65920 100644
--- a/arch/x86/include/asm/segment.h
+++ b/arch/x86/include/asm/segment.h
@@ -56,7 +56,7 @@
 
 #define GDT_ENTRY_INVALID_SEG	0
 
-#ifdef CONFIG_X86_32
+#if defined(CONFIG_X86_32) && !defined(BUILD_VDSO32_64)
 /*
  * The layout of the per-CPU GDT under Linux:
  *
-- 
2.34.1

