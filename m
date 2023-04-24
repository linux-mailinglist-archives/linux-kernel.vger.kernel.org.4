Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 47A6A6DC457
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Apr 2023 10:41:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229726AbjDJIlI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Apr 2023 04:41:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49306 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229600AbjDJIlD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Apr 2023 04:41:03 -0400
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4AD693AB1;
        Mon, 10 Apr 2023 01:41:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1681116063; x=1712652063;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=CJ5cn83oehVUqkHaIiQkGH139f3gJuf37y85qUnwXYY=;
  b=CINHGdc5pozpD9mjU9lrfw+0Q4CL1gs6hsYyZSzlyLvql2bTYESlR0wG
   /svBlAF/3xakfcJRwUU/Tud/QImrQxEAHMkGehWJg3JOoslBdHw4D7bo4
   msrOVEKc+qWvtkZuj2UZYLjJ6b+ucVUIRU/rp0sSbyExD2v/PqgOUdC/U
   bV2cbzxZKLKd/I+krss/mQIC0GXqLVCD8oCWNwAn/bebGbeCCMVsUVq6M
   LZ0dH0A9zvrYDIVXxFLKuE2Mqdm7NFX09Te9dLQa7RLipolrHrGtvhTkz
   3WZXkV0JNRwTMOUBRCxSbySDxCkcfVJfg6nTPy+Sx4BkBi/ygesYYwi8M
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10675"; a="342077871"
X-IronPort-AV: E=Sophos;i="5.98,333,1673942400"; 
   d="scan'208";a="342077871"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Apr 2023 01:41:01 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10675"; a="799436238"
X-IronPort-AV: E=Sophos;i="5.98,333,1673942400"; 
   d="scan'208";a="799436238"
Received: from unknown (HELO fred..) ([172.25.112.68])
  by fmsmga002.fm.intel.com with ESMTP; 10 Apr 2023 01:41:01 -0700
From:   Xin Li <xin3.li@intel.com>
To:     linux-kernel@vger.kernel.org, x86@kernel.org, kvm@vger.kernel.org
Cc:     tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
        dave.hansen@linux.intel.com, hpa@zytor.com, peterz@infradead.org,
        andrew.cooper3@citrix.com, seanjc@google.com, pbonzini@redhat.com,
        ravi.v.shankar@intel.com, jiangshanlai@gmail.com,
        shan.kang@intel.com
Subject: [PATCH v8 01/33] x86/traps: let common_interrupt() handle IRQ_MOVE_CLEANUP_VECTOR
Date:   Mon, 10 Apr 2023 01:14:06 -0700
Message-Id: <20230410081438.1750-2-xin3.li@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230410081438.1750-1-xin3.li@intel.com>
References: <20230410081438.1750-1-xin3.li@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=unavailable autolearn_force=no version=3.4.6
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

