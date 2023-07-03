Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6D9947456CB
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jul 2023 10:04:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231244AbjGCID5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Jul 2023 04:03:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46522 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231182AbjGCIDd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Jul 2023 04:03:33 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E5F4010DC;
        Mon,  3 Jul 2023 01:03:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1688371402; x=1719907402;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=tVvPfhy1pq/F5VIaRT5AzqUsJQrfr238yG1EqHj9ZCg=;
  b=fL6uEe00hPv5NMYYsXwPE9EwnsHTD7TWB/2BawNGcT6a1GwpXBoMNcxl
   Pk4PB/ChcF4nTneZ7Jk6M64Ce1jBVdpw4EwaFvq2J+jW9LgsGhJ7PxuQa
   cNDJDEfsxyd9siEqmNEKF9M2O1DEofmeuJBP9ngDz4Zvh8mM8KxX8qvtT
   lwrkW7tMXEl5E/wOKgeTmM+TkyYcFF8jzlxdgHDJwj2+cqszPOjCTmkED
   WA0kxM3fdAOmrPmTGRyiLd9lygI2R4A523VCoR487wBKR62lPjaVb0IW7
   AcrOBZqHtDPRUaIXTL6yLIWaUhI45YlZkNlqmhf34j0xaXgr0rsycoarQ
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10759"; a="366304018"
X-IronPort-AV: E=Sophos;i="6.01,177,1684825200"; 
   d="scan'208";a="366304018"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Jul 2023 01:03:20 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10759"; a="862994525"
X-IronPort-AV: E=Sophos;i="6.01,177,1684825200"; 
   d="scan'208";a="862994525"
Received: from powerlab.fi.intel.com ([10.237.71.25])
  by fmsmga001-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Jul 2023 01:03:17 -0700
From:   Michal Wilczynski <michal.wilczynski@intel.com>
To:     linux-acpi@vger.kernel.org
Cc:     rafael@kernel.org, dan.j.williams@intel.com,
        vishal.l.verma@intel.com, lenb@kernel.org, dave.jiang@intel.com,
        ira.weiny@intel.com, rui.zhang@intel.com,
        linux-kernel@vger.kernel.org, nvdimm@lists.linux.dev,
        Michal Wilczynski <michal.wilczynski@intel.com>
Subject: [PATCH v7 2/9] acpi/bus: Set driver_data to NULL every time .add() fails
Date:   Mon,  3 Jul 2023 11:02:45 +0300
Message-ID: <20230703080252.2899090-3-michal.wilczynski@intel.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230703080252.2899090-1-michal.wilczynski@intel.com>
References: <20230703080252.2899090-1-michal.wilczynski@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Most drivers set driver_data during .add() callback, but usually
they don't set it back to NULL in case of a failure. Set driver_data to
NULL in acpi_device_probe() to avoid code duplication.

Signed-off-by: Michal Wilczynski <michal.wilczynski@intel.com>
---
 drivers/acpi/bus.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/acpi/bus.c b/drivers/acpi/bus.c
index 2d6f1f45d44e..c087fd6e8398 100644
--- a/drivers/acpi/bus.c
+++ b/drivers/acpi/bus.c
@@ -1014,8 +1014,10 @@ static int acpi_device_probe(struct device *dev)
 		return -ENOSYS;
 
 	ret = acpi_drv->ops.add(acpi_dev);
-	if (ret)
+	if (ret) {
+		acpi_dev->driver_data = NULL;
 		return ret;
+	}
 
 	pr_debug("Driver [%s] successfully bound to device [%s]\n",
 		 acpi_drv->name, acpi_dev->pnp.bus_id);
-- 
2.41.0

