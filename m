Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A937174425E
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Jun 2023 20:35:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232622AbjF3Sfk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Jun 2023 14:35:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41940 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233255AbjF3SfC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Jun 2023 14:35:02 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C2F946B4;
        Fri, 30 Jun 2023 11:34:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1688150076; x=1719686076;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=K9mqNpqtx0jsUV9AUHZdlk1cbbq1gO+NmVFGsw3m+lE=;
  b=abf2TZZmqmZw87qm4ITpjUDFqbNMQR7m0+7Q+r989+9a68fUg8oTCJnL
   UepQIGfqJQ3FC/PmSOHlySgWokWSXZO0Rv/K2/MUFD4rdfn8WKx4hkK8n
   w+aUu9ENLhr7DtYzQE9AR81A30A8CCstrsaW7gZDUTdU2R4JblyIbSbLv
   WAvaJPh1ebbOsVIKNLoDq3FVypa4gBeGRWMEO5JK56VW9RJ+ERyeCAukL
   hO2ZaDOXl+lZrUq64bzyG9Yjf5x0YiZuHopKZ4YcriYBnbwyDBhLnwUew
   3P4A9tzJ/IMk6zQ/WA/jbUTpq+3mjWo1SVi20mGp2E045Riwhn61JPSML
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10757"; a="365950022"
X-IronPort-AV: E=Sophos;i="6.01,171,1684825200"; 
   d="scan'208";a="365950022"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Jun 2023 11:34:35 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10757"; a="717896476"
X-IronPort-AV: E=Sophos;i="6.01,171,1684825200"; 
   d="scan'208";a="717896476"
Received: from powerlab.fi.intel.com ([10.237.71.25])
  by orsmga002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Jun 2023 11:34:32 -0700
From:   Michal Wilczynski <michal.wilczynski@intel.com>
To:     linux-acpi@vger.kernel.org
Cc:     rafael@kernel.org, dan.j.williams@intel.com,
        vishal.l.verma@intel.com, lenb@kernel.org, dave.jiang@intel.com,
        ira.weiny@intel.com, rui.zhang@intel.com,
        linux-kernel@vger.kernel.org, nvdimm@lists.linux.dev,
        Michal Wilczynski <michal.wilczynski@intel.com>
Subject: [PATCH v6 8/9] acpi/nfit: Remove unnecessary .remove callback
Date:   Fri, 30 Jun 2023 21:33:43 +0300
Message-ID: <20230630183344.891077-9-michal.wilczynski@intel.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230630183344.891077-1-michal.wilczynski@intel.com>
References: <20230630183344.891077-1-michal.wilczynski@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Nfit driver doesn't use .remove() callback and provide an empty function
as it's .remove() callback. Remove empty acpi_nfit_remove() and
initialization of callback.

Suggested-by: Dan Williams <dan.j.williams@intel.com>
Signed-off-by: Michal Wilczynski <michal.wilczynski@intel.com>
---
 drivers/acpi/nfit/core.c | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/drivers/acpi/nfit/core.c b/drivers/acpi/nfit/core.c
index ee2365a80aa1..daaea23cacfd 100644
--- a/drivers/acpi/nfit/core.c
+++ b/drivers/acpi/nfit/core.c
@@ -3402,11 +3402,6 @@ static int acpi_nfit_add(struct acpi_device *adev)
 					adev);
 }
 
-static void acpi_nfit_remove(struct acpi_device *adev)
-{
-	/* see acpi_nfit_unregister */
-}
-
 static void acpi_nfit_update_notify(struct device *dev, acpi_handle handle)
 {
 	struct acpi_nfit_desc *acpi_desc = dev_get_drvdata(dev);
@@ -3488,7 +3483,6 @@ static struct acpi_driver acpi_nfit_driver = {
 	.ids = acpi_nfit_ids,
 	.ops = {
 		.add = acpi_nfit_add,
-		.remove = acpi_nfit_remove,
 	},
 };
 
-- 
2.41.0

