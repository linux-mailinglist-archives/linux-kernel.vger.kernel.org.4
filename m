Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 09CF75F568A
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Oct 2022 16:38:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230046AbiJEOiF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Oct 2022 10:38:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47486 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229980AbiJEOiB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Oct 2022 10:38:01 -0400
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D6984F182;
        Wed,  5 Oct 2022 07:38:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1664980680; x=1696516680;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=2SPqUsjF5qBIF1pomEqZowlFagnMO4IU7LXTD0kTMtM=;
  b=HLGXsYxK+NvkObZb2TBHzQd9uyCFUFh075dM+Q4DZaZGq/0T0XsquJqK
   8cEu7sbyOcZn8HtutUUO0353BaQo6qi8c69A184XQL5l/I3/mZQLUh0pd
   WNwgHE8bF0pc1dN68XhvdUFiZU80MDAuFUaB3xlii6h+H9T/mmtCZwJuW
   G8bktIooqp31ozFNzAadNgMjSfFb2qCNQXbZ25YofIVLOyRBepzAk+GHD
   2+1ZoE1xbm+QlgaFZwaD97BtjUYqoZJJ0b7Uwx+lW3Pzu9uiZWVzlJraZ
   Ur5Y9dtA6rf35kQMJrQGWHtjUitYaKQ/NpPuUStgi9Liurkpprs+Emd03
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10491"; a="282889703"
X-IronPort-AV: E=Sophos;i="5.95,161,1661842800"; 
   d="scan'208";a="282889703"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Oct 2022 07:38:00 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10491"; a="869420640"
X-IronPort-AV: E=Sophos;i="5.95,161,1661842800"; 
   d="scan'208";a="869420640"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga006.fm.intel.com with ESMTP; 05 Oct 2022 07:37:57 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 585C0155; Wed,  5 Oct 2022 17:38:17 +0300 (EEST)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linuxppc-dev@lists.ozlabs.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-acpi@vger.kernel.org
Cc:     Qiang Zhao <qiang.zhao@nxp.com>, Li Yang <leoyang.li@nxp.com>,
        Daniel Scally <djrscally@gmail.com>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Sakari Ailus <sakari.ailus@linux.intel.com>
Subject: [PATCH v1 1/2] device property: Introduce fwnode_device_is_compatible() helper
Date:   Wed,  5 Oct 2022 17:38:11 +0300
Message-Id: <20221005143812.33503-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The fwnode_device_is_compatible() helper searches for the
given string in the "compatible" string array property and,
if found, returns true.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 include/linux/property.h | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/include/linux/property.h b/include/linux/property.h
index 1c26d263d5e4..4948a890b153 100644
--- a/include/linux/property.h
+++ b/include/linux/property.h
@@ -56,6 +56,11 @@ int device_property_match_string(struct device *dev,
 				 const char *propname, const char *string);
 
 bool fwnode_device_is_available(const struct fwnode_handle *fwnode);
+bool fwnode_device_is_compatible(const struct fwnode_handle *fwnode, const char *compat)
+{
+	return fwnode_property_match_string(fwnode, "compatible", compat) >= 0;
+}
+
 bool fwnode_property_present(const struct fwnode_handle *fwnode,
 			     const char *propname);
 int fwnode_property_read_u8_array(const struct fwnode_handle *fwnode,
-- 
2.35.1

