Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2536563AD5F
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Nov 2022 17:12:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232471AbiK1QMb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Nov 2022 11:12:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43962 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229850AbiK1QM3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Nov 2022 11:12:29 -0500
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB10D6479;
        Mon, 28 Nov 2022 08:12:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1669651948; x=1701187948;
  h=from:to:cc:subject:date:message-id;
  bh=PJooqv5lc87r6DlPqv7xPFz5j9kjskGlNeElh+S27Vc=;
  b=CQ10JDwAPAcqZh88cc3QRGn1F5Stap7X3Sa1PoPwAm25mbsdVE86lcoW
   OdzqYuxQUiGxbPPFhuLuOvfHQtVMaa9qKskArBLgY9LxbuUAl6cFhemXo
   UE8t0B3MWobUqQvIOQ2UzPMC4hppDQznFWBXOwXZ8G0V5wWC1hmpeqFIZ
   g1+PvVAN5L4QVDuSo8IlFzPsBRKiKc/+zLDNKj+PqaAQJljQopJ8+/akn
   AzlQQGRDdtaPH2dAp1CrQXjGE2hRgmg59vyeZUHkY7Wpqb5qOjHUYxHS3
   6tP3lhnb70Es3wpzVgQj69LvUr6s3tgoEILHO+SRmiHtxsfdcDIFV85Sg
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10545"; a="314909049"
X-IronPort-AV: E=Sophos;i="5.96,200,1665471600"; 
   d="scan'208";a="314909049"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Nov 2022 08:12:28 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10545"; a="749445230"
X-IronPort-AV: E=Sophos;i="5.96,200,1665471600"; 
   d="scan'208";a="749445230"
Received: from ranerica-svr.sc.intel.com ([172.25.110.23])
  by fmsmga002.fm.intel.com with ESMTP; 28 Nov 2022 08:12:27 -0800
From:   Ricardo Neri <ricardo.neri-calderon@linux.intel.com>
To:     "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
Cc:     Ricardo Neri <ricardo.neri-calderon@linux.intel.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Amit Kucheria <amitk@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>,
        Len Brown <len.brown@intel.com>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        Aubrey Li <aubrey.li@linux.intel.com>,
        Haowen Bai <baihaowen@meizu.com>, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] thermal: intel: hfi: Remove a pointless die_id check
Date:   Mon, 28 Nov 2022 08:20:01 -0800
Message-Id: <20221128162001.31227-1-ricardo.neri-calderon@linux.intel.com>
X-Mailer: git-send-email 2.17.1
X-Spam-Status: No, score=-7.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

die_id is an u16 quantity. On single-die systems the default value of
die_id is 0. No need to check for negative values.

Plus, removing this check makes Coverity happy.

Cc: Daniel Lezcano <daniel.lezcano@linaro.org>
Cc: Amit Kucheria <amitk@kernel.org>
Cc: Zhang Rui <rui.zhang@intel.com>
Cc: Len Brown <len.brown@intel.com>
Cc: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Cc: Aubrey Li <aubrey.li@linux.intel.com>
Cc: Haowen Bai <baihaowen@meizu.com>
Cc: linux-pm@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Signed-off-by: Ricardo Neri <ricardo.neri-calderon@linux.intel.com>
---
 drivers/thermal/intel/intel_hfi.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/thermal/intel/intel_hfi.c b/drivers/thermal/intel/intel_hfi.c
index 239afe02e518..d35287eb2f78 100644
--- a/drivers/thermal/intel/intel_hfi.c
+++ b/drivers/thermal/intel/intel_hfi.c
@@ -371,7 +371,7 @@ void intel_hfi_online(unsigned int cpu)
 	die_id = topology_logical_die_id(cpu);
 	hfi_instance = info->hfi_instance;
 	if (!hfi_instance) {
-		if (die_id < 0 || die_id >= max_hfi_instances)
+		if (die_id >= max_hfi_instances)
 			return;
 
 		hfi_instance = &hfi_instances[die_id];
-- 
2.25.1

