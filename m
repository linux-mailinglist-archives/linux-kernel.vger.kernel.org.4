Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4587E5B9B4A
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Sep 2022 14:50:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229459AbiIOMuW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Sep 2022 08:50:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52428 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229833AbiIOMuT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Sep 2022 08:50:19 -0400
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4DD1C3AE6A;
        Thu, 15 Sep 2022 05:50:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1663246218; x=1694782218;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=IIdOmEcdS83aIuUyuRuxgaNZb9Jk3USNPSc9UWh3dM4=;
  b=m4u9tLDXeBMzDyF9ME0fc5t4EWlWTb2Lpz7aA8tcrRmc/7fn26FwD/x1
   c6kN+Ktmel/PixfcRH8WTqsLSWb+1MJJQkPO95MTYiMzeOnOJZcPZdeEJ
   MT0Oa+4Vi7YXm+7TQQAWA/7kNlmk+eYwTjVr1U2qRKAeH+IRSuhgKmrEQ
   Fw+loAZkU4He1zWrfUOlLD8FKbBToUJnDUmhisKY7ed1Xdlf3CEca3O5U
   FJV1pgtI3xHllIK0yGRIX9AnUHIYk4fNBml8tiTTX5M2+FdKT3ejWSaCY
   D8h0jvMq1Zuz7SiRTGgdyWJkthpsWesPAXf8pDcneywF/xINt7yT73go2
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10470"; a="299513129"
X-IronPort-AV: E=Sophos;i="5.93,318,1654585200"; 
   d="scan'208";a="299513129"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Sep 2022 05:50:18 -0700
X-IronPort-AV: E=Sophos;i="5.93,318,1654585200"; 
   d="scan'208";a="647812068"
Received: from cvbock-mobl1.amr.corp.intel.com (HELO khuang2-desk.gar.corp.intel.com) ([10.213.165.77])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Sep 2022 05:50:16 -0700
From:   Kai Huang <kai.huang@intel.com>
To:     linux-sgx@vger.kernel.org
Cc:     dave.hansen@linux.intel.com, jarkko@kernel.org,
        tony.luck@intel.com, linux-kernel@vger.kernel.org
Subject: [PATCH] x86/sgx: Add xa_store_range() return value check in sgx_setup_epc_section()
Date:   Fri, 16 Sep 2022 00:50:06 +1200
Message-Id: <20220915125006.759592-1-kai.huang@intel.com>
X-Mailer: git-send-email 2.37.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In sgx_setup_epc_section(), xa_store_range() is called to store EPC
pages' owner section to an Xarray using physical addresses of those EPC
pages as index.  Currently, the return value of xa_store_range() is not
checked, but actually it can fail (i.e. due to -ENOMEM).

Not checking the return value of xa_store_range() would result in the
EPC section being used by SGX driver (and KVM SGX guests), but part or
all of its EPC pages not being handled by the memory failure handling of
EPC page.  Such inconsistency should be avoided, even at the cost that
this section won't be used by the kernel.

Add the missing check of the return value of xa_store_range(), and when
it fails, clean up and fail to initialize the EPC section.

Fixes: 40e0e7843e23 ("x86/sgx: Add infrastructure to identify SGX EPC pages")
Signed-off-by: Kai Huang <kai.huang@intel.com>
---
 arch/x86/kernel/cpu/sgx/main.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/arch/x86/kernel/cpu/sgx/main.c b/arch/x86/kernel/cpu/sgx/main.c
index 515e2a5f25bb..2ee23e60ef61 100644
--- a/arch/x86/kernel/cpu/sgx/main.c
+++ b/arch/x86/kernel/cpu/sgx/main.c
@@ -632,8 +632,12 @@ static bool __init sgx_setup_epc_section(u64 phys_addr, u64 size,
 	}
 
 	section->phys_addr = phys_addr;
-	xa_store_range(&sgx_epc_address_space, section->phys_addr,
-		       phys_addr + size - 1, section, GFP_KERNEL);
+	if (xa_err(xa_store_range(&sgx_epc_address_space, section->phys_addr,
+		       phys_addr + size - 1, section, GFP_KERNEL))) {
+		vfree(section->pages);
+		memunmap(section->virt_addr);
+		return false;
+	}
 
 	for (i = 0; i < nr_pages; i++) {
 		section->pages[i].section = index;

base-commit: ee56a283988d739c25d2d00ffb22707cb487ab47
-- 
2.37.1

