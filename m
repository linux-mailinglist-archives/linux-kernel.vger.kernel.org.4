Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 583B565B71A
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Jan 2023 21:29:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234541AbjABU31 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Jan 2023 15:29:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50348 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233689AbjABU3H (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Jan 2023 15:29:07 -0500
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ADF45B7F2;
        Mon,  2 Jan 2023 12:29:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1672691346; x=1704227346;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=qEdpGg42v8ssTX3MFNxTT74JRBUnoi0KLVf3ao4NExY=;
  b=TJxhhaaz4noZgwe1woo6KjgACjOqhWo0Am454D35KhCDsDeJOrdRcFar
   HcB0JK39hUzWM0ua7if2VYG1+BkD1lJcX7iYCK+ZWdIq7nRylHsn9PQmP
   wx8pIYGWAFUWpqHP6ae6lcLOEUrVWd1SY+Gs/pnRD+Q+QzCoDWRe8LDsp
   PMlRNJzSIGqnNhSY1KRj398LJYmea3uGOIFwod4+lJ+wlUlEE4J07mB3h
   PEMqhSuNQJN+3MdkVdUn3Y0KgZqcXmP9S1g8rTLSJCW6N/Dml+gSnIugA
   WEgQzUomzExwE4r3CSy5zweVHZMF/XVmZxyJ8N6tsc3tdo/kn7CED8lEv
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10578"; a="407798342"
X-IronPort-AV: E=Sophos;i="5.96,295,1665471600"; 
   d="scan'208";a="407798342"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Jan 2023 12:29:06 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10578"; a="828649687"
X-IronPort-AV: E=Sophos;i="5.96,295,1665471600"; 
   d="scan'208";a="828649687"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga005.jf.intel.com with ESMTP; 02 Jan 2023 12:29:04 -0800
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id C8B0EF4; Mon,  2 Jan 2023 22:29:36 +0200 (EET)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v1 1/2] usb: typec: intel_pmc_mux: Don't leak the ACPI device reference count
Date:   Mon,  2 Jan 2023 22:29:32 +0200
Message-Id: <20230102202933.15968-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When acpi_dev_get_memory_resources() fails, the reference count is
left bumped. Drop it as it's done in the other error paths.

Fixes: 43d596e32276 ("usb: typec: intel_pmc_mux: Check the port status before connect")
Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/usb/typec/mux/intel_pmc_mux.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/usb/typec/mux/intel_pmc_mux.c b/drivers/usb/typec/mux/intel_pmc_mux.c
index fdbf3694e21f..87e2c9130607 100644
--- a/drivers/usb/typec/mux/intel_pmc_mux.c
+++ b/drivers/usb/typec/mux/intel_pmc_mux.c
@@ -614,8 +614,10 @@ static int pmc_usb_probe_iom(struct pmc_usb *pmc)
 
 	INIT_LIST_HEAD(&resource_list);
 	ret = acpi_dev_get_memory_resources(adev, &resource_list);
-	if (ret < 0)
+	if (ret < 0) {
+		acpi_dev_put(adev);
 		return ret;
+	}
 
 	rentry = list_first_entry_or_null(&resource_list, struct resource_entry, node);
 	if (rentry)
-- 
2.35.1

