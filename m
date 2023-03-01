Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BB77E6A77C0
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Mar 2023 00:38:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229802AbjCAXiY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Mar 2023 18:38:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35024 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229708AbjCAXiE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Mar 2023 18:38:04 -0500
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C7BD86BB
        for <linux-kernel@vger.kernel.org>; Wed,  1 Mar 2023 15:38:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1677713883; x=1709249883;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references;
  bh=iAMY6btPT3LkFo8ii1+Ro1+SLEC/lk7JJlUCyqpnpJM=;
  b=BOpMBGGNMkAjry1BtH/w4hpprv1UV7IiYs5xh5/xYBHNcnFlprWhpev4
   4V6Okvb51GPCOGvqr+A3P0KGlUutzb/EVsPlFG9WwXsN7Rst2ULJm9V3m
   KLn/O3gZFM3xtLRfeDWwQMds8xgWlJ3VfJUunOiE6DSeLAKcas8efieHd
   xIkL6ngwbxZckEkS3ehGQrkV9MQJ8BlWxUnH0KuJpkMJsVQUA6UdSnm+V
   YeUURNkBC+hmkqY5dgBZOdKEHBiCMSARUgGzP/5tzwj3jFwDQbQ8N4eq6
   SOFkyW/XAoHDOjq19SAh7sVOGImC84rPPO5LlAwOQXhlUz7CjjwOsMt5s
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10636"; a="420818714"
X-IronPort-AV: E=Sophos;i="5.98,225,1673942400"; 
   d="scan'208";a="420818714"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Mar 2023 15:37:57 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10636"; a="738826817"
X-IronPort-AV: E=Sophos;i="5.98,225,1673942400"; 
   d="scan'208";a="738826817"
Received: from ranerica-svr.sc.intel.com ([172.25.110.23])
  by fmsmga008.fm.intel.com with ESMTP; 01 Mar 2023 15:37:57 -0800
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
        Ricardo Neri <ricardo.neri-calderon@linux.intel.com>,
        David Woodhouse <dwmw2@infradead.org>,
        Lu Baolu <baolu.lu@linux.intel.com>
Subject: [PATCH v7 08/24] iommu/vt-d: Set the IRTE delivery mode individually for each interrupt
Date:   Wed,  1 Mar 2023 15:47:37 -0800
Message-Id: <20230301234753.28582-9-ricardo.neri-calderon@linux.intel.com>
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

Use the mode specified in the provided interrupt hardware configuration
data to set the delivery mode.

Since most interrupts are configured to use the delivery mode of the APIC
driver, there are no functional changes. The only exception are interrupts
that do specify a different delivery mode.

Cc: Andi Kleen <ak@linux.intel.com>
Cc: David Woodhouse <dwmw2@infradead.org>
Cc: "Ravi V. Shankar" <ravi.v.shankar@intel.com>
Cc: Lu Baolu <baolu.lu@linux.intel.com>
Cc: Stephane Eranian <eranian@google.com>
Cc: iommu@lists.linux-foundation.org
Cc: linuxppc-dev@lists.ozlabs.org
Reviewed-by: Tony Luck <tony.luck@intel.com>
Reviewed-by: Lu Baolu <baolu.lu@linux.intel.com>
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
 drivers/iommu/intel/irq_remapping.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iommu/intel/irq_remapping.c b/drivers/iommu/intel/irq_remapping.c
index 1fe30c31fcbe..7b58406ea8d2 100644
--- a/drivers/iommu/intel/irq_remapping.c
+++ b/drivers/iommu/intel/irq_remapping.c
@@ -1120,7 +1120,7 @@ static void prepare_irte(struct irte *irte, struct irq_cfg *irq_cfg)
 	 * irq migration in the presence of interrupt-remapping.
 	*/
 	irte->trigger_mode = 0;
-	irte->dlvry_mode = apic->delivery_mode;
+	irte->dlvry_mode = irq_cfg->delivery_mode;
 	irte->vector = irq_cfg->vector;
 	irte->dest_id = IRTE_DEST(irq_cfg->dest_apicid);
 
-- 
2.25.1

