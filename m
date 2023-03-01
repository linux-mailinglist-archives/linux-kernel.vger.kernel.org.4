Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 242EF6A77BA
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Mar 2023 00:38:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229733AbjCAXiF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Mar 2023 18:38:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34886 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229668AbjCAXiA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Mar 2023 18:38:00 -0500
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2FB4583EA
        for <linux-kernel@vger.kernel.org>; Wed,  1 Mar 2023 15:37:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1677713877; x=1709249877;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references;
  bh=Lma7M0NQuejLahUyWUzCNBxEauMnVUBUBK0aoIXgw+I=;
  b=Rbp29A0LomMKJkyDvD7JdSEuL8Cq3xnbRUldelPxgwWyAo62+UmZT4kA
   tSFVsLkW5axnUJ5VSc94eRgDBamO8sLM4lkl4ihHqOo7eGS0nzI7lWl9k
   Oey860/m8I7pbJtLmzhwSf63jz3EnTWpq8qcN2C0cdY0KBKqvw9VaC2Nm
   Tg7irCmwNAh8H06XCTPCe8UIv4fnrIaUJtJ18FRwlJ9RTiGrSGixL4+qN
   /R2cv2akakWlOzfwTfJO/SuY0qRgnKZdmxTzESiaJmgRDOyMfhEA+tssb
   j9TMDOng5eKtDBDC+SaBjEbKSSbit2Bk0LCE3U5l96K16VSIg2u4+ye+g
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10636"; a="420818679"
X-IronPort-AV: E=Sophos;i="5.98,225,1673942400"; 
   d="scan'208";a="420818679"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Mar 2023 15:37:55 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10636"; a="738826785"
X-IronPort-AV: E=Sophos;i="5.98,225,1673942400"; 
   d="scan'208";a="738826785"
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
Subject: [PATCH v7 01/24] x86/apic: Add irq_cfg::delivery_mode
Date:   Wed,  1 Mar 2023 15:47:30 -0800
Message-Id: <20230301234753.28582-2-ricardo.neri-calderon@linux.intel.com>
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

There are no restrictions in hardware to configure the delivery mode of
each interrupt individually. Also, certain interrupts need to be
configured with a specific delivery mode (e.g., non-maskable interrupts).
Add a new member, delivery_mode, to struct irq_cfg to this effect.

To keep the current behavior, use the delivery mode of the APIC driver when
allocating a vector for an interrupt in the root domain (i.e.,
x86_vector_domain).

Cc: Andi Kleen <ak@linux.intel.com>
Cc: "Ravi V. Shankar" <ravi.v.shankar@intel.com>
Cc: Stephane Eranian <eranian@google.com>
Cc: iommu@lists.linux-foundation.org
Cc: linuxppc-dev@lists.ozlabs.org
Reviewed-by: Ashok Raj <ashok.raj@intel.com>
Reviewed-by: Tony Luck <tony.luck@intel.com>
Signed-off-by: Ricardo Neri <ricardo.neri-calderon@linux.intel.com>
---
Changes since v6:
 * Reworded the commit message to accurately state that the root domain
   allocates a vector for an interrupt, not an interrupt. (Thomas)
 * Removed stray newline. (Thomas)
 * Replaced 'irq' with 'interrupt' in the changelog and in the code.
  (Thomas).

Changes since v5:
 * Updated indentation of the existing members of struct irq_cfg.
 * Reworded the commit message.

Changes since v4:
 * Rebased to use new enumeration apic_delivery_modes.

Changes since v3:
 * None

Changes since v2:
 * Reduced scope to only add the interrupt delivery mode in
   struct irq_alloc_info.

Changes since v1:
 * Introduced this patch.
---
 arch/x86/include/asm/hw_irq.h | 5 +++--
 arch/x86/kernel/apic/vector.c | 6 ++++++
 2 files changed, 9 insertions(+), 2 deletions(-)

diff --git a/arch/x86/include/asm/hw_irq.h b/arch/x86/include/asm/hw_irq.h
index d465ece58151..5ac5e6c603ee 100644
--- a/arch/x86/include/asm/hw_irq.h
+++ b/arch/x86/include/asm/hw_irq.h
@@ -88,8 +88,9 @@ struct irq_alloc_info {
 };
 
 struct irq_cfg {
-	unsigned int		dest_apicid;
-	unsigned int		vector;
+	unsigned int			dest_apicid;
+	unsigned int			vector;
+	enum apic_delivery_modes	delivery_mode;
 };
 
 extern struct irq_cfg *irq_cfg(unsigned int irq);
diff --git a/arch/x86/kernel/apic/vector.c b/arch/x86/kernel/apic/vector.c
index c1efebd27e6c..633b442c8f84 100644
--- a/arch/x86/kernel/apic/vector.c
+++ b/arch/x86/kernel/apic/vector.c
@@ -573,6 +573,12 @@ static int x86_vector_alloc_irqs(struct irq_domain *domain, unsigned int virq,
 		/* Don't invoke affinity setter on deactivated interrupts */
 		irqd_set_affinity_on_activate(irqd);
 
+		/*
+		 * A delivery mode may be specified in the interrupt allocation
+		 * info. If not, use the delivery mode of the APIC.
+		 */
+		apicd->hw_irq_cfg.delivery_mode = apic->delivery_mode;
+
 		/*
 		 * Legacy vectors are already assigned when the IOAPIC
 		 * takes them over. They stay on the same vector. This is
-- 
2.25.1

