Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CFE3C65B719
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Jan 2023 21:29:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231361AbjABU3X (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Jan 2023 15:29:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50352 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233748AbjABU3H (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Jan 2023 15:29:07 -0500
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF8F0B7FB;
        Mon,  2 Jan 2023 12:29:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1672691346; x=1704227346;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=UhbpeqOPtdnvW1OoOYK7I6vcKWDvf7Orw5YO5zOikEU=;
  b=QmhryEHsAbrnVXZ6IcW5x/GBxWwyQeazHS2jIg+sG7jD2Sf+vAqPqXhy
   bUh0uUVgoyJWVP+UgaDr5a0B9An5km7OlVW3S5tesKmwX7BulS9xnvKFv
   aCoQlZ9EDRm748sTjzudmg1ColtEc5BzzzDkgKx+oftaLhjypuTHOORzM
   cR6PT8RLn4Dx9uzzZl4tb2aEvX+s31vcdUOGVsRx0/DPPar26ejZI7iwj
   qWPXs9KjBvZy+JTKzU1s/kiIp+YxMt8LOpE3gjiAt93khX2Ku4h3/Mke1
   hTSfxB7T8pqyM7QyT35NQLl6+mskd+5wJ1LAJMWsEAv5sLvSMPN0jF1NU
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10578"; a="322772140"
X-IronPort-AV: E=Sophos;i="5.96,295,1665471600"; 
   d="scan'208";a="322772140"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Jan 2023 12:29:06 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10578"; a="654577518"
X-IronPort-AV: E=Sophos;i="5.96,295,1665471600"; 
   d="scan'208";a="654577518"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga002.jf.intel.com with ESMTP; 02 Jan 2023 12:29:04 -0800
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id D614E84; Mon,  2 Jan 2023 22:29:36 +0200 (EET)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v1 2/2] usb: typec: intel_pmc_mux: Deduplicate ACPI matching in probe
Date:   Mon,  2 Jan 2023 22:29:33 +0200
Message-Id: <20230102202933.15968-2-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20230102202933.15968-1-andriy.shevchenko@linux.intel.com>
References: <20230102202933.15968-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There is no need to call acpi_dev_present() followed by
acpi_dev_get_first_match_dev() as they both do the same
with only difference in the returning value. Instead,
call the latter and check its result.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/usb/typec/mux/intel_pmc_mux.c | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/drivers/usb/typec/mux/intel_pmc_mux.c b/drivers/usb/typec/mux/intel_pmc_mux.c
index 87e2c9130607..34e4188a40ff 100644
--- a/drivers/usb/typec/mux/intel_pmc_mux.c
+++ b/drivers/usb/typec/mux/intel_pmc_mux.c
@@ -602,16 +602,15 @@ static int pmc_usb_probe_iom(struct pmc_usb *pmc)
 	int ret;
 
 	for (dev_id = &iom_acpi_ids[0]; dev_id->id[0]; dev_id++) {
-		if (acpi_dev_present(dev_id->id, NULL, -1)) {
-			pmc->iom_port_status_offset = (u32)dev_id->driver_data;
-			adev = acpi_dev_get_first_match_dev(dev_id->id, NULL, -1);
+		adev = acpi_dev_get_first_match_dev(dev_id->id, NULL, -1);
+		if (adev)
 			break;
-		}
 	}
-
 	if (!adev)
 		return -ENODEV;
 
+	pmc->iom_port_status_offset = (u32)dev_id->driver_data;
+
 	INIT_LIST_HEAD(&resource_list);
 	ret = acpi_dev_get_memory_resources(adev, &resource_list);
 	if (ret < 0) {
-- 
2.35.1

