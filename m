Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 72B3B5B3157
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Sep 2022 10:09:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230441AbiIIIJH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Sep 2022 04:09:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41360 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229862AbiIIIJF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Sep 2022 04:09:05 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 158F3D6B9D;
        Fri,  9 Sep 2022 01:09:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1662710944; x=1694246944;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=pHcMr/HNr8GqXxikW+gg67wqAAdhnAbWd7qTUYLTQA0=;
  b=hWI+SDRipT9KS06Qz5SReoxHfX8cAJlpA1rMYfrqdvCERDAh59yeaZDJ
   wJ42lWr/AAP+1qvesv2Z58PewJWin6rHS8SUYYUHqR6vghhbDrtBqnICP
   eSTkLYhkCnCSjNAK7gLfB3kE6CLymI+jKW/502WCdKVBATY5luSVrYWQ4
   cOvn+H9y3A0AWlO8nZCi0m2IYwmfv0U90m35qPu1nYLTDr4BT01yRid85
   R1/lhm5E4Cb0MeWUO9UHq8cH43z0EgvSeXdNblPPp6JoMhfwahIlKJodi
   PGPPqSGrDr3CyJUjWhr07EWXj7mz4lGIBF2zcJtY+T3y0l90hI/ErTy5g
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10464"; a="298762966"
X-IronPort-AV: E=Sophos;i="5.93,302,1654585200"; 
   d="scan'208";a="298762966"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Sep 2022 01:09:03 -0700
X-IronPort-AV: E=Sophos;i="5.93,302,1654585200"; 
   d="scan'208";a="740976284"
Received: from lmongeax-mobl.amr.corp.intel.com (HELO khuang2-desk.gar.corp.intel.com) ([10.212.106.181])
  by orsmga004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Sep 2022 01:09:02 -0700
From:   Kai Huang <kai.huang@intel.com>
To:     linux-sgx@vger.kernel.org
Cc:     dave.hansen@linux.intel.com, seanjc@google.com, jarkko@kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] x86/intel: Clear SGX bit if both SGX driver and KVM SGX are not enabled
Date:   Fri,  9 Sep 2022 20:08:53 +1200
Message-Id: <20220909080853.547058-1-kai.huang@intel.com>
X-Mailer: git-send-email 2.37.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently on platform which has SGX enabled, if CONFIG_X86_SGX is not
enabled, the X86_FEATURE_SGX is not cleared, resulting in /proc/cpuinfo
shows "sgx" feature.  This is not desired.

Clear SGX feature bit if both SGX driver and KVM SGX are not enabled in
init_ia32_feat_ctl().

Signed-off-by: Kai Huang <kai.huang@intel.com>
---

Hi Dave, Sean, Jarkko,

Could you help to review?  Tested on SGX (BIOS) enabled machine with
CONFIG_X86_SGX unset.

This patch is generated on latest tip/master, but it applies to
tip/x86/sgx cleanly as well.

---
 arch/x86/kernel/cpu/feat_ctl.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/arch/x86/kernel/cpu/feat_ctl.c b/arch/x86/kernel/cpu/feat_ctl.c
index 993697e71854..2f67409f5f00 100644
--- a/arch/x86/kernel/cpu/feat_ctl.c
+++ b/arch/x86/kernel/cpu/feat_ctl.c
@@ -191,6 +191,19 @@ void init_ia32_feat_ctl(struct cpuinfo_x86 *c)
 		return;
 	}
 
+	/*
+	 * By reaching here, it is certain that:
+	 *  - CPU supports SGX.
+	 *  - SGX is enabled by BIOS.
+	 *
+	 * However if both SGX driver and KVM SGX are not enabled, just
+	 * need to clear SGX feature bit.
+	 */
+	if (!enable_sgx_driver && !enable_sgx_kvm) {
+		clear_cpu_cap(c, X86_FEATURE_SGX);
+		return;
+	}
+
 	/*
 	 * VMX feature bit may be cleared due to being disabled in BIOS,
 	 * in which case SGX virtualization cannot be supported either.

base-commit: b8b09110cf290fdab4006b717da7a776ffb0cb73
-- 
2.37.1

