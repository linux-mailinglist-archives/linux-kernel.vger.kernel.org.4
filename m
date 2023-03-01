Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2C65E6A77B9
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Mar 2023 00:38:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229705AbjCAXiD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Mar 2023 18:38:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34902 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229682AbjCAXiA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Mar 2023 18:38:00 -0500
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 190E586BB
        for <linux-kernel@vger.kernel.org>; Wed,  1 Mar 2023 15:37:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1677713878; x=1709249878;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references;
  bh=RjtAUFRJrzBKfA0+yFHKXNZopzCyfP9+J4w+QU7OMp8=;
  b=h4WGTIWryt8ou3SediisWNZIFP8Y0FmjDSooYtl6jzDYEImaAPhaW9Vn
   DKEMa/D3sgvFwcGyR+03MxXUtTOwf4Kzmarc08/d+3pUVLWQPw7wf0qJq
   NAL7uwP1m+YwCRoLYTkJ8VIsZ2VqompTlb8wZzgmPJzKjcuzerEf1+XdS
   ovcv2yuUWuqAhGV+yRfG8sLQ8Nj3ize7cFsyIrir04b9RqrqMpGWNG0wD
   /oslP2rT96ingkEVfMt9JD4W2u6TDpMxtlqNM6fGtxxPmPXpy69ZY0ZEB
   iTznCMT8RlALKjBZvZE74aV1jdVycT8g+eBmnj6NBOiyjE9DVlhhs5/5a
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10636"; a="420818683"
X-IronPort-AV: E=Sophos;i="5.98,225,1673942400"; 
   d="scan'208";a="420818683"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Mar 2023 15:37:55 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10636"; a="738826789"
X-IronPort-AV: E=Sophos;i="5.98,225,1673942400"; 
   d="scan'208";a="738826789"
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
Subject: [PATCH v7 02/24] x86/apic/msi: Use the delivery mode from irq_cfg for message composition
Date:   Wed,  1 Mar 2023 15:47:31 -0800
Message-Id: <20230301234753.28582-3-ricardo.neri-calderon@linux.intel.com>
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

irq_cfg provides a delivery mode for each interrupt. Use it instead
of the hardcoded APIC_DELIVERY_MODE_FIXED. This allows to compose
messages for NMI delivery mode which is required to implement a HPET-
based NMI watchdog.

No functional change as the default delivery mode is set to
APIC_DELIVERY_MODE_FIXED.

Cc: Andi Kleen <ak@linux.intel.com>
Cc: "Ravi V. Shankar" <ravi.v.shankar@intel.com>
Cc: Stephane Eranian <eranian@google.com>
Cc: iommu@lists.linux-foundation.org
Cc: linuxppc-dev@lists.ozlabs.org
Reviewed-by: Tony Luck <tony.luck@intel.com>
Signed-off-by: Ricardo Neri <ricardo.neri-calderon@linux.intel.com>
---
Changes since v6:
 * Reworded changelog as per suggestion from Thomas.

Changes since v5:
 * Introduced this patch

Changes since v4:
 * N/A

Changes since v3:
 * N/A

Changes since v2:
 * N/A

Changes since v1:
 * N/A
---
 arch/x86/kernel/apic/apic.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/kernel/apic/apic.c b/arch/x86/kernel/apic/apic.c
index 20d9a604da7c..352738238e52 100644
--- a/arch/x86/kernel/apic/apic.c
+++ b/arch/x86/kernel/apic/apic.c
@@ -2562,7 +2562,7 @@ void __irq_msi_compose_msg(struct irq_cfg *cfg, struct msi_msg *msg,
 	msg->arch_addr_lo.dest_mode_logical = apic->dest_mode_logical;
 	msg->arch_addr_lo.destid_0_7 = cfg->dest_apicid & 0xFF;
 
-	msg->arch_data.delivery_mode = APIC_DELIVERY_MODE_FIXED;
+	msg->arch_data.delivery_mode = cfg->delivery_mode;
 	msg->arch_data.vector = cfg->vector;
 
 	msg->address_hi = X86_MSI_BASE_ADDRESS_HIGH;
-- 
2.25.1

