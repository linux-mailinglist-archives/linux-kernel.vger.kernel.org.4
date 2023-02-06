Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7F3EC68C089
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Feb 2023 15:52:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230478AbjBFOwL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Feb 2023 09:52:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37116 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229892AbjBFOwI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Feb 2023 09:52:08 -0500
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A87B81C7DD;
        Mon,  6 Feb 2023 06:52:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1675695127; x=1707231127;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=L+5LlR1un7mprtyQt90rzYhyMN85ej+w5cAPag3X0F8=;
  b=VinLM5Q/icnABxLnH5SxR95LPQvUEgbPfRMTI4GFhI/kGRQQbK/D6h6t
   HfQu3e6Jm6o3yXMejcMKpjeidC3eFOQhs37H/roOdXo4agbpZ2ceS5RrR
   FYBUZnYhR9GkydBM8EJVq49l4U26ONpTB+9iEze+kq69EVtfZc9ud+1+L
   r1QiSevR6khtoiRoVyOJvWUfkIwUGwUz0dRjONmTA+io0lSEGXpQ9BbSJ
   By2OKokJkJe/xK3vDvMiKhMCtbH858+PLqjaCC4B/gZSCjPblBw/fg4Im
   2pVyy5W8uggfxedqFYrckOKFnavX598nTA4SvaILLKNsG5JJok5MBsDq6
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10612"; a="329235388"
X-IronPort-AV: E=Sophos;i="5.97,276,1669104000"; 
   d="scan'208";a="329235388"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Feb 2023 06:52:07 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10612"; a="696884891"
X-IronPort-AV: E=Sophos;i="5.97,276,1669104000"; 
   d="scan'208";a="696884891"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga008.jf.intel.com with ESMTP; 06 Feb 2023 06:52:05 -0800
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 2BAB6241; Mon,  6 Feb 2023 16:52:44 +0200 (EET)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-kernel@vger.kernel.org
Cc:     Hans de Goede <hdegoede@redhat.com>,
        platform-driver-x86@vger.kernel.org
Subject: [PATCH v1 1/1] platform/x86: Fix header inclusion in linux/platform_data/x86/soc.h
Date:   Mon,  6 Feb 2023 16:52:38 +0200
Message-Id: <20230206145238.19460-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.39.1
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

First of all, we don't use intel-family.h directly. On the other hand
we actively use boolean type, that is defined in the types.h (we take
top-level header for that) and x86_cpu_id, that is provided in the
mod_devicetable.h.

Secondly, we don't need to spread SOC_INTEL_IS_CPU() macro to the users.
Hence, undefine it when it's appropriate.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 include/linux/platform_data/x86/soc.h | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/include/linux/platform_data/x86/soc.h b/include/linux/platform_data/x86/soc.h
index da05f425587a..a5705189e2ac 100644
--- a/include/linux/platform_data/x86/soc.h
+++ b/include/linux/platform_data/x86/soc.h
@@ -8,10 +8,13 @@
 #ifndef __PLATFORM_DATA_X86_SOC_H
 #define __PLATFORM_DATA_X86_SOC_H
 
+#include <linux/types.h>
+
 #if IS_ENABLED(CONFIG_X86)
 
+#include <linux/mod_devicetable.h>
+
 #include <asm/cpu_device_id.h>
-#include <asm/intel-family.h>
 
 #define SOC_INTEL_IS_CPU(soc, type)				\
 static inline bool soc_intel_is_##soc(void)			\
@@ -34,6 +37,8 @@ SOC_INTEL_IS_CPU(apl, ATOM_GOLDMONT);
 SOC_INTEL_IS_CPU(glk, ATOM_GOLDMONT_PLUS);
 SOC_INTEL_IS_CPU(cml, KABYLAKE_L);
 
+#undef SOC_INTEL_IS_CPU
+
 #else /* IS_ENABLED(CONFIG_X86) */
 
 static inline bool soc_intel_is_byt(void)
-- 
2.39.1

