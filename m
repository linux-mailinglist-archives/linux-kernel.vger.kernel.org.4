Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 602E76D5E26
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Apr 2023 12:53:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234770AbjDDKxt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Apr 2023 06:53:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39424 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234744AbjDDKxE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Apr 2023 06:53:04 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C5013ABA;
        Tue,  4 Apr 2023 03:53:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1680605582; x=1712141582;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=CJ5cn83oehVUqkHaIiQkGH139f3gJuf37y85qUnwXYY=;
  b=CZVKUa7dZ4/lC+B6wPEkeWU2q+GeZu8p1wSIm1pi1WJGKdUpZRn6L/xU
   cEe9PKrZGyQOmjAI85njfufcviXGkGHeh7kSHxp3e+wy2mk3y3KVTDx29
   0mlJZhro+6PIlBeFg602qScn/hcnlWuq5ab0Q/blAZkkHL2ahmCjQqgBJ
   7fXE2W3ucy0ASl/mtz+zEGrW1/PL5M43mXFHyGp+Qxa9Wa1LKc1G8Cjig
   lYnS8nmBYVgZUjb/0sHgJWWAd8hgaIcLYLv5c2CkfqPtOJy3s+WrfY3pn
   6/NB/YR0GVR+e/T2KQeFTjn8UvfnSM0a6u3eBMWzSKILWVXuQJK4kOLfD
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10669"; a="330733922"
X-IronPort-AV: E=Sophos;i="5.98,317,1673942400"; 
   d="scan'208";a="330733922"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Apr 2023 03:52:59 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10669"; a="775597778"
X-IronPort-AV: E=Sophos;i="5.98,317,1673942400"; 
   d="scan'208";a="775597778"
Received: from unknown (HELO fred..) ([172.25.112.68])
  by FMSMGA003.fm.intel.com with ESMTP; 04 Apr 2023 03:52:59 -0700
From:   Xin Li <xin3.li@intel.com>
To:     linux-kernel@vger.kernel.org, x86@kernel.org, kvm@vger.kernel.org
Cc:     tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
        dave.hansen@linux.intel.com, hpa@zytor.com, peterz@infradead.org,
        andrew.cooper3@citrix.com, seanjc@google.com, pbonzini@redhat.com,
        ravi.v.shankar@intel.com, jiangshanlai@gmail.com,
        shan.kang@intel.com
Subject: [PATCH v7 01/33] x86/traps: let common_interrupt() handle IRQ_MOVE_CLEANUP_VECTOR
Date:   Tue,  4 Apr 2023 03:26:44 -0700
Message-Id: <20230404102716.1795-2-xin3.li@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230404102716.1795-1-xin3.li@intel.com>
References: <20230404102716.1795-1-xin3.li@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "H. Peter Anvin (Intel)" <hpa@zytor.com>

IRQ_MOVE_CLEANUP_VECTOR is the only one of the system IRQ vectors that
is *below* FIRST_SYSTEM_VECTOR. It is a slow path, so just push it
into common_interrupt() just before the spurious interrupt handling.

Signed-off-by: H. Peter Anvin (Intel) <hpa@zytor.com>
Tested-by: Shan Kang <shan.kang@intel.com>
Signed-off-by: Xin Li <xin3.li@intel.com>
---
 arch/x86/kernel/irq.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/x86/kernel/irq.c b/arch/x86/kernel/irq.c
index 766ffe3ba313..7e125fff45ab 100644
--- a/arch/x86/kernel/irq.c
+++ b/arch/x86/kernel/irq.c
@@ -248,6 +248,10 @@ DEFINE_IDTENTRY_IRQ(common_interrupt)
 	desc = __this_cpu_read(vector_irq[vector]);
 	if (likely(!IS_ERR_OR_NULL(desc))) {
 		handle_irq(desc, regs);
+#ifdef CONFIG_SMP
+	} else if (vector == IRQ_MOVE_CLEANUP_VECTOR) {
+		sysvec_irq_move_cleanup(regs);
+#endif
 	} else {
 		ack_APIC_irq();
 
-- 
2.34.1

