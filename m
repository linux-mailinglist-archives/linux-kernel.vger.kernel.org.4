Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6E4706A77BB
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Mar 2023 00:38:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229750AbjCAXiJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Mar 2023 18:38:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34910 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229697AbjCAXiB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Mar 2023 18:38:01 -0500
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 88E5211660
        for <linux-kernel@vger.kernel.org>; Wed,  1 Mar 2023 15:38:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1677713880; x=1709249880;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references;
  bh=q1CqewxYyZYMIT/dLlB5/XAEQ5VVr9wg2syBU+4wkTk=;
  b=AG6EEcZNHyW7d9fdxBEK65rH7QHL6B45jtOPF5qIm8aNjHaJyakZ3r/g
   iOndMYjYiqhW0VhO9DLKqtFZZGa4AKTuU43q6GpMR/JEijq9Ir8FnGBK0
   No8c4Ys/hN5hn24uG8MYzP2asztUs34RjMcsX0T3N/eqWMRuwe3sShtRV
   L3NLwD+fSUBqBO8oOcAQERopZ7e89cmiCKanlIvwL4TCC+dtYSKEK9OXC
   2FD+uQlw6pnzMZLqncRRbB90rGU6HQq1ci+L3wWJFWLVcS8LSH7ZXtg++
   wcW0U22QQDSmlUSJitknQRbqfIhxqnfUhih/rBpzC7MV72brZmV0FInL2
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10636"; a="420818689"
X-IronPort-AV: E=Sophos;i="5.98,225,1673942400"; 
   d="scan'208";a="420818689"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Mar 2023 15:37:56 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10636"; a="738826795"
X-IronPort-AV: E=Sophos;i="5.98,225,1673942400"; 
   d="scan'208";a="738826795"
Received: from ranerica-svr.sc.intel.com ([172.25.110.23])
  by fmsmga008.fm.intel.com with ESMTP; 01 Mar 2023 15:37:55 -0800
From:   Ricardo Neri <ricardo.neri-calderon@linux.intel.com>
To:     Tony Luck <tony.luck@intel.com>,
        Dave Hansen <dave.hansen@intel.com>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Reinette Chatre <reinette.chatre@intel.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Len Brown <len.brown@intel.com>
Cc:     Andi Kleen <ak@linux.intel.com>,
        Stephane Eranian <eranian@google.com>,
        "Ravi V. Shankar" <ravi.v.shankar@intel.com>,
        Ricardo Neri <ricardo.neri@intel.com>,
        linuxppc-dev@lists.ozlabs.org, iommu@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org,
        Ricardo Neri <ricardo.neri-calderon@linux.intel.com>
Subject: [PATCH v7 03/24] x86/apic: Add the X86_IRQ_ALLOC_AS_NMI interrupt allocation flag
Date:   Wed,  1 Mar 2023 15:47:32 -0800
Message-Id: <20230301234753.28582-4-ricardo.neri-calderon@linux.intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20230301234753.28582-1-ricardo.neri-calderon@linux.intel.com>
References: <20230301234753.28582-1-ricardo.neri-calderon@linux.intel.com>
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There are cases in which it is necessary to set the delivery mode of an
interrupt as NMI. Add a new flag that callers can specify when allocating
an interrupt.

Cc: Andi Kleen <ak@linux.intel.com>
Cc: "Ravi V. Shankar" <ravi.v.shankar@intel.com>
Cc: Stephane Eranian <eranian@google.com>
Cc: iommu@lists.linux-foundation.org
Cc: linuxppc-dev@lists.ozlabs.org
Suggested-by: Thomas Gleixner <tglx@linutronix.de>
Reviewed-by: Tony Luck <tony.luck@intel.com>
Signed-off-by: Ricardo Neri <ricardo.neri-calderon@linux.intel.com>
---
Changes since v6:
 * None

Changes since v5:
 * Introduced this patch.

Changes since v4:
 * N/A

Changes since v3:
 * N/A

Changes since v2:
 * N/A

Changes since v1:
 * N/A
---
 arch/x86/include/asm/irqdomain.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/x86/include/asm/irqdomain.h b/arch/x86/include/asm/irqdomain.h
index 30c325c235c0..e13f02c6fe95 100644
--- a/arch/x86/include/asm/irqdomain.h
+++ b/arch/x86/include/asm/irqdomain.h
@@ -8,6 +8,7 @@
 #ifdef CONFIG_X86_LOCAL_APIC
 enum {
 	X86_IRQ_ALLOC_LEGACY				= 0x1,
+	X86_IRQ_ALLOC_AS_NMI				= 0x2,
 };
 
 extern int x86_fwspec_is_ioapic(struct irq_fwspec *fwspec);
-- 
2.25.1

