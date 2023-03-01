Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 16D3A6A77BE
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Mar 2023 00:38:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229835AbjCAXiS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Mar 2023 18:38:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34992 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229703AbjCAXiD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Mar 2023 18:38:03 -0500
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5272B1207D
        for <linux-kernel@vger.kernel.org>; Wed,  1 Mar 2023 15:38:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1677713881; x=1709249881;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references;
  bh=K9unSxI1ETIAj+1EQ34Lma1zVNuCMXNt2Vl73pS93As=;
  b=Gsiwbs/iM1V0RTKgIgrZpxjkV7Hup/QPLrqP3qN2VKtrRLnHDyGR2vag
   CNqS12YIU+97oCETG/baDt+9e5B1XPr6byMzIiOYxL01sOB6AMhNgzAe8
   VdNInO3Xyo6TJd2eZVWwHeHecxkWt8p3csF3zJg5djWQxvGcGkmS/6KCm
   HrWFmh/8zUzgGsXuZW1tREccWCxkxrRxRa+8LKKX477a4nw9CNpgiEGEW
   Nlhk8kl+BidXmlFYm5zzm+HHW9VeLYsXSUi6oeM9ULcjKbEGKvbbJdMAV
   ET8qNqXcz8YppXu6wLbuj0KXj0lvegwyee0Spt8l1pY+yvUtpsSJP68LT
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10636"; a="420818699"
X-IronPort-AV: E=Sophos;i="5.98,225,1673942400"; 
   d="scan'208";a="420818699"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Mar 2023 15:37:56 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10636"; a="738826802"
X-IronPort-AV: E=Sophos;i="5.98,225,1673942400"; 
   d="scan'208";a="738826802"
Received: from ranerica-svr.sc.intel.com ([172.25.110.23])
  by fmsmga008.fm.intel.com with ESMTP; 01 Mar 2023 15:37:56 -0800
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
Subject: [PATCH v7 05/24] x86/apic/vector: Skip cleanup for the NMI vector
Date:   Wed,  1 Mar 2023 15:47:34 -0800
Message-Id: <20230301234753.28582-6-ricardo.neri-calderon@linux.intel.com>
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

The NMI vector is fixed. No cleanup is needed after updating affinity.

Cc: Andi Kleen <ak@linux.intel.com>
Cc: "Ravi V. Shankar" <ravi.v.shankar@intel.com>
Cc: Stephane Eranian <eranian@google.com>
Cc: iommu@lists.linux-foundation.org
Cc: linuxppc-dev@lists.ozlabs.org
Signed-off-by: Ricardo Neri <ricardo.neri-calderon@linux.intel.com>

---
Changes since v6:
 * Introduced this patch.

Changes since v5:
 * N/A

Changes since v4:
 * N/A

Changes since v3:
 * N/A

Changes since v2:
 * N/A

Changes since v1:
 * N/A
---
 arch/x86/kernel/apic/vector.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/x86/kernel/apic/vector.c b/arch/x86/kernel/apic/vector.c
index a4cf041427cb..3045823ecc1b 100644
--- a/arch/x86/kernel/apic/vector.c
+++ b/arch/x86/kernel/apic/vector.c
@@ -1050,6 +1050,10 @@ void send_cleanup_vector(struct irq_cfg *cfg)
 {
 	struct apic_chip_data *apicd;
 
+	/* NMI has a fixed vector. No vector management required. */
+	if (cfg->delivery_mode == APIC_DELIVERY_MODE_NMI)
+		return;
+
 	apicd = container_of(cfg, struct apic_chip_data, hw_irq_cfg);
 	if (apicd->move_in_progress)
 		__send_cleanup_vector(apicd);
-- 
2.25.1

