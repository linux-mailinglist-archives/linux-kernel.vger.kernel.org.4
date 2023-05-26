Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 39EFC71262A
	for <lists+linux-kernel@lfdr.de>; Fri, 26 May 2023 14:02:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237265AbjEZMCq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 May 2023 08:02:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45866 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236664AbjEZMCl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 May 2023 08:02:41 -0400
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED8C419A
        for <linux-kernel@vger.kernel.org>; Fri, 26 May 2023 05:02:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1685102559; x=1716638559;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=oo/dvf1ZlrvtcR59TYCugDRCyxgFSECoi5qSl2YCdyA=;
  b=h9/tEo95eqkQAtdJ7/8gKFrwWVCwn7HX8Zg4WO2pd3Uwl4HnNy3I9nmU
   obE3GMYy9im0KsbO1sOZ/axZFqWT2ORrr+X07FfJNmTPJCwEb+PfnKJLE
   J85wqn6wHp8OjbL97kVJFYmMECXJdq+vfO+TFger+n63nlIir4fDEe44X
   gwV2/EBXvcG6pReiASVrgQWijq1X6hMFjMV2zieOQFuHkbYZ/0kLznwB/
   q1dWIleJ9MW3hb7uDDtXkxpB+3zhel1QPyUc0Xs/ccMHt6jigvCnzm/+m
   WFnPmCWUE2Xetev99p1vkhVR3wgxagZ8k2YTwXvRsqo3CqUnBvTHlRsAu
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10721"; a="334538200"
X-IronPort-AV: E=Sophos;i="6.00,194,1681196400"; 
   d="scan'208";a="334538200"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 May 2023 05:02:39 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10721"; a="951854338"
X-IronPort-AV: E=Sophos;i="6.00,194,1681196400"; 
   d="scan'208";a="951854338"
Received: from fgarrona-mobl.ger.corp.intel.com (HELO box.shutemov.name) ([10.251.208.169])
  by fmsmga006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 May 2023 05:02:36 -0700
Received: by box.shutemov.name (Postfix, from userid 1000)
        id 5785F10DC18; Fri, 26 May 2023 15:02:33 +0300 (+03)
From:   "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
To:     dave.hansen@intel.com, tglx@linutronix.de, mingo@redhat.com,
        bp@alien8.de
Cc:     decui@microsoft.com, rick.p.edgecombe@intel.com,
        sathyanarayanan.kuppuswamy@linux.intel.com, seanjc@google.com,
        thomas.lendacky@amd.com, x86@kernel.org,
        linux-kernel@vger.kernel.org,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Subject: [PATCHv2 3/3] x86/mm: Fix enc_status_change_finish_noop()
Date:   Fri, 26 May 2023 15:02:25 +0300
Message-Id: <20230526120225.31936-4-kirill.shutemov@linux.intel.com>
X-Mailer: git-send-email 2.39.3
In-Reply-To: <20230526120225.31936-1-kirill.shutemov@linux.intel.com>
References: <20230526120225.31936-1-kirill.shutemov@linux.intel.com>
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

enc_status_change_finish_noop() defined as always-fail now which
doesn't make sense for noop.

The change doesn't have user-visible effect because it only gets
called if the platform has CC_ATTR_MEM_ENCRYPT. All platforms with
the attribute override the callback with own implementation.

Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
---
 arch/x86/kernel/x86_init.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/kernel/x86_init.c b/arch/x86/kernel/x86_init.c
index f230d4d7d8eb..64664311ac2b 100644
--- a/arch/x86/kernel/x86_init.c
+++ b/arch/x86/kernel/x86_init.c
@@ -131,7 +131,7 @@ struct x86_cpuinit_ops x86_cpuinit = {
 static void default_nmi_init(void) { };
 
 static bool enc_status_change_prepare_noop(unsigned long vaddr, int npages, bool enc) { return true; }
-static bool enc_status_change_finish_noop(unsigned long vaddr, int npages, bool enc) { return false; }
+static bool enc_status_change_finish_noop(unsigned long vaddr, int npages, bool enc) { return true; }
 static bool enc_tlb_flush_required_noop(bool enc) { return false; }
 static bool enc_cache_flush_required_noop(void) { return false; }
 static bool is_private_mmio_noop(u64 addr) {return false; }
-- 
2.39.3

