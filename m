Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6EB8D6A77C2
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Mar 2023 00:38:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229921AbjCAXib (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Mar 2023 18:38:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35050 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229716AbjCAXiE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Mar 2023 18:38:04 -0500
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 40436149BD
        for <linux-kernel@vger.kernel.org>; Wed,  1 Mar 2023 15:38:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1677713883; x=1709249883;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references;
  bh=mR16pLKgTuMhf9u2kE2UXUD7nzGYQyqB0h6xQLOZJvc=;
  b=fu1OLrmXZoJ2W/+fLXGkor+2ZLhG1v7yzjyD3EVx8fQE2PNe/E+IWJv+
   iAIfdAd6ckAOei93g6EDJ8E8y3OUgs0tSy9SkDKG16GTJLptYhaYnxWe6
   urR3wm1tdcjytBtZx4DQ99oEcksLQIWuS4dLeLiC+O83yHgTSZ+ZcwwS6
   eXC3PqXrKVeOdHrLy56MqrQzgsvksPC+P/X55jaffDB/ozDxCdLEzIsm/
   oByeCQ+zGgJcjO7H5vULRwMX/GdynocZ8lEdli1AxM7qpFg450/2y6jRE
   SZcPDyEsHHGUFzF3dIyctZkGK96Uu6XeBrAfe8/wZdlof08PoY5WC6tIN
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10636"; a="420818720"
X-IronPort-AV: E=Sophos;i="5.98,225,1673942400"; 
   d="scan'208";a="420818720"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Mar 2023 15:37:57 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10636"; a="738826821"
X-IronPort-AV: E=Sophos;i="5.98,225,1673942400"; 
   d="scan'208";a="738826821"
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
        Joerg Roedel <joro@8bytes.org>,
        Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
Subject: [PATCH v7 09/24] iommu/amd: Expose [set|get]_dev_entry_bit()
Date:   Wed,  1 Mar 2023 15:47:38 -0800
Message-Id: <20230301234753.28582-10-ricardo.neri-calderon@linux.intel.com>
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

If an interrupt is allocated with NMI as delivery mode, the Device Table
Entry needs to be modified accordingly in irq_remapping_alloc().

No functional changes.

Cc: Andi Kleen <ak@linux.intel.com>
Cc: "Ravi V. Shankar" <ravi.v.shankar@intel.com>
Cc: Joerg Roedel <joro@8bytes.org>
Cc: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
Cc: Stephane Eranian <eranian@google.com>
Cc: iommu@lists.linux-foundation.org
Cc: linuxppc-dev@lists.ozlabs.org
Signed-off-by: Ricardo Neri <ricardo.neri-calderon@linux.intel.com>
---
Changes since v6:
 * None

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
 drivers/iommu/amd/amd_iommu.h | 3 +++
 drivers/iommu/amd/init.c      | 4 ++--
 2 files changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/iommu/amd/amd_iommu.h b/drivers/iommu/amd/amd_iommu.h
index c160a332ce33..b9b87a8cd48e 100644
--- a/drivers/iommu/amd/amd_iommu.h
+++ b/drivers/iommu/amd/amd_iommu.h
@@ -141,4 +141,7 @@ extern u64 amd_iommu_efr;
 extern u64 amd_iommu_efr2;
 
 extern bool amd_iommu_snp_en;
+
+extern void set_dev_entry_bit(struct amd_iommu *iommu, u16 devid, u8 bit);
+extern int get_dev_entry_bit(struct amd_iommu *iommu, u16 devid, u8 bit);
 #endif
diff --git a/drivers/iommu/amd/init.c b/drivers/iommu/amd/init.c
index 19a46b9f7357..559a9ecb785f 100644
--- a/drivers/iommu/amd/init.c
+++ b/drivers/iommu/amd/init.c
@@ -999,7 +999,7 @@ static void __set_dev_entry_bit(struct dev_table_entry *dev_table,
 	dev_table[devid].data[i] |= (1UL << _bit);
 }
 
-static void set_dev_entry_bit(struct amd_iommu *iommu, u16 devid, u8 bit)
+void set_dev_entry_bit(struct amd_iommu *iommu, u16 devid, u8 bit)
 {
 	struct dev_table_entry *dev_table = get_dev_table(iommu);
 
@@ -1015,7 +1015,7 @@ static int __get_dev_entry_bit(struct dev_table_entry *dev_table,
 	return (dev_table[devid].data[i] & (1UL << _bit)) >> _bit;
 }
 
-static int get_dev_entry_bit(struct amd_iommu *iommu, u16 devid, u8 bit)
+int get_dev_entry_bit(struct amd_iommu *iommu, u16 devid, u8 bit)
 {
 	struct dev_table_entry *dev_table = get_dev_table(iommu);
 
-- 
2.25.1

