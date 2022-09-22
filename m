Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E803B5E63BA
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Sep 2022 15:36:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229563AbiIVNfs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Sep 2022 09:35:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34728 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231615AbiIVNfY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Sep 2022 09:35:24 -0400
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 92ACB98CAE;
        Thu, 22 Sep 2022 06:35:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1663853717; x=1695389717;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references;
  bh=kbVKhVENfs1ZKJPfvDDpV0tOaAWB+7OvnBODgaAPd6s=;
  b=jilbV74ft9wO06qlr+3GGgxm/15Ins4bLUBYt1mIQVK0Vt+MpFMZN0SF
   6Ncx7twLFn6KorC4EyC3/V5lpLBGld++4VBOK8gvh8LT+NsfAOKh+d+55
   kdtPxweazQ73Kn2jzD+CfXIfwD+9Cfxv744lStRpYE+s3fLvgEoi1tQr0
   tks90bEbevgJREhenyO/UJdxBoZwOyRJSSM+DIjeWxX2pZ7HWwrjrmYwn
   DwVKskqLKWvMHDv45tA7jHbu2HA8+coA/amAWOgka2r6yywrP19m2g93e
   LgrOSvSjoWUTfpSFF4husulSavtoDPQf7S8QYMrPygJGnt7ikuhx7Xi4J
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10478"; a="297894152"
X-IronPort-AV: E=Sophos;i="5.93,335,1654585200"; 
   d="scan'208";a="297894152"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Sep 2022 06:35:16 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,335,1654585200"; 
   d="scan'208";a="619793944"
Received: from power-sh.sh.intel.com ([10.239.183.122])
  by orsmga002.jf.intel.com with ESMTP; 22 Sep 2022 06:35:13 -0700
From:   Zhang Rui <rui.zhang@intel.com>
To:     linux-kernel@vger.kernel.org, x86@kernel.org,
        linux-hwmon@vger.kernel.org
Cc:     tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
        dave.hansen@linux.intel.com, hpa@zytor.com, peterz@infradead.org,
        corbet@lwn.net, fenghua.yu@intel.com, jdelvare@suse.com,
        linux@roeck-us.net, len.brown@intel.com, rui.zhang@intel.com
Subject: [PATCH V3 5/8] x86/topology: Fix duplicated core ID within a package
Date:   Thu, 22 Sep 2022 21:37:57 +0800
Message-Id: <20220922133800.12918-6-rui.zhang@intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220922133800.12918-1-rui.zhang@intel.com>
References: <20220922133800.12918-1-rui.zhang@intel.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Today, core ID is assumed to be unique within each package.

But an AlderLake-N platform adds a Module level between core and package,
Linux excludes the unknown modules bits from the core ID, resulting in
duplicate core ID's.

To keep core ID unique within a package, Linux must include all APIC-ID
bits for known or un-known levels above the core and below the package
in the core ID.

It is important to understand that core ID's have always come directly
from the APIC-ID encoding, which comes from the BIOS. Thus there is no
guarantee that they start at 0, or that they are contiguous.
As such, naively using them for array indexes can be problematic.

Suggested-by: Len Brown <len.brown@intel.com>
Reviewed-by: Len Brown <len.brown@intel.com>
Signed-off-by: Zhang Rui <rui.zhang@intel.com>
---
 arch/x86/kernel/cpu/topology.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/kernel/cpu/topology.c b/arch/x86/kernel/cpu/topology.c
index f7592814e5d5..5e868b62a7c4 100644
--- a/arch/x86/kernel/cpu/topology.c
+++ b/arch/x86/kernel/cpu/topology.c
@@ -141,7 +141,7 @@ int detect_extended_topology(struct cpuinfo_x86 *c)
 		sub_index++;
 	}
 
-	core_select_mask = (~(-1 << core_plus_mask_width)) >> ht_mask_width;
+	core_select_mask = (~(-1 << pkg_mask_width)) >> ht_mask_width;
 	die_select_mask = (~(-1 << die_plus_mask_width)) >>
 				core_plus_mask_width;
 
-- 
2.25.1

