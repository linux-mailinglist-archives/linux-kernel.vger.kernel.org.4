Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 719B272A279
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Jun 2023 20:39:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231708AbjFISir (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Jun 2023 14:38:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50746 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231938AbjFIShz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Jun 2023 14:37:55 -0400
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A4E583AB2
        for <linux-kernel@vger.kernel.org>; Fri,  9 Jun 2023 11:37:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1686335851; x=1717871851;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=cSHO1BH7WnTgrrvVGbc7GV85jY3NXc9iqn2mc1vIguw=;
  b=RRK7GH/x94E81wUK/rhlA+HweDkoCEaS8Eo5/mTas+aKSqcnuat1YC8D
   fqXRGsWKyNdrRbMJec4yMpeib+rtWRlr3GgJ1VU944dZlqgyhZt1S0dPm
   Egn/XhyUp/B+zuiXlFeyzIYdVtgUx/kNWtPKb6pvFkf7FZlsxDOjFrKab
   4Oe7B1MFQxuaF1L9m2MxQuj1jkbcmkl96lI7xUI5RK5o8+el2o0VY8fT5
   hfh+1+3jWskUiJXm4UoTGOMub6e95SZDPdPfxcZH7p/cyirRPZ7isDZFs
   wL+Ph8BUIAPujjkqKJOwvFKSP/1IMmVEWUl0e/q5guTginc5TVVfX6MTs
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10736"; a="338022230"
X-IronPort-AV: E=Sophos;i="6.00,230,1681196400"; 
   d="scan'208";a="338022230"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Jun 2023 11:37:25 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10736"; a="710444135"
X-IronPort-AV: E=Sophos;i="6.00,230,1681196400"; 
   d="scan'208";a="710444135"
Received: from black.fi.intel.com (HELO black.fi.intel.com.) ([10.237.72.28])
  by orsmga002.jf.intel.com with ESMTP; 09 Jun 2023 11:37:22 -0700
From:   Alexander Shishkin <alexander.shishkin@linux.intel.com>
To:     linux-kernel@vger.kernel.org, x86@kernel.org,
        Andy Lutomirski <luto@kernel.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Ravi Shankar <ravi.v.shankar@intel.com>,
        Tony Luck <tony.luck@intel.com>,
        Sohil Mehta <sohil.mehta@intel.com>
Cc:     Alexander Shishkin <alexander.shishkin@linux.intel.com>
Subject: [RFC v3 12/12] x86/efi: Disable LASS enforcement when switching to EFI MM
Date:   Fri,  9 Jun 2023 21:36:32 +0300
Message-Id: <20230609183632.48706-13-alexander.shishkin@linux.intel.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230609183632.48706-1-alexander.shishkin@linux.intel.com>
References: <20230609183632.48706-1-alexander.shishkin@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Sohil Mehta <sohil.mehta@intel.com>

[Code is experimental and not yet ready to be merged upstream]

PeterZ suggested that EFI memory can be mapped in user virtual address
space which would trigger LASS violation upon access. It isn't exactly
clear how and when these user address mapping happen. It may be possible
this is related to EFI mixed mode.
Link:https://lore.kernel.org/lkml/Y73S56t%2FwDIGEPlK@hirez.programming.kicks-ass.net/

stac()/clac() calls in the EFI MM enter and exit functions trigger
objtool warnings due to switch_mm() not being classified as
func_uaccess_safe. Refer Objtool warnings section #9 in the document
tools/objtool/Documentation/objtool.txt. This would need to be resolved
before even considering merging.

Signed-off-by: Sohil Mehta <sohil.mehta@intel.com>
Signed-off-by: Alexander Shishkin <alexander.shishkin@linux.intel.com>
---
 arch/x86/platform/efi/efi_64.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/arch/x86/platform/efi/efi_64.c b/arch/x86/platform/efi/efi_64.c
index 232acf418cfb..20966efcd87a 100644
--- a/arch/x86/platform/efi/efi_64.c
+++ b/arch/x86/platform/efi/efi_64.c
@@ -473,9 +473,14 @@ void __init efi_dump_pagetable(void)
  * while the EFI-mm is borrowed. mmgrab()/mmdrop() is not used because the mm
  * can not change under us.
  * It should be ensured that there are no concurrent calls to this function.
+ *
+ * Disable LASS enforcement temporarily when switching to EFI MM since it could
+ * be mapped into the low 64-bit virtual address space with address bit 63 set
+ * to 0.
  */
 void efi_enter_mm(void)
 {
+	stac();
 	efi_prev_mm = current->active_mm;
 	current->active_mm = &efi_mm;
 	switch_mm(efi_prev_mm, &efi_mm, NULL);
@@ -485,6 +490,7 @@ void efi_leave_mm(void)
 {
 	current->active_mm = efi_prev_mm;
 	switch_mm(&efi_mm, efi_prev_mm, NULL);
+	clac();
 }
 
 static DEFINE_SPINLOCK(efi_runtime_lock);
-- 
2.39.2

