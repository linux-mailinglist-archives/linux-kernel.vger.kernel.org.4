Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 391405F5785
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Oct 2022 17:29:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230484AbiJEP3t (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Oct 2022 11:29:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40376 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230390AbiJEP3i (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Oct 2022 11:29:38 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 37AD8EA8;
        Wed,  5 Oct 2022 08:29:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1664983777; x=1696519777;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=kjLtd57mMK+EVcgFbt6pO20kW/y/VllWb3uvAku8dxQ=;
  b=dVzJjI+HdGFrrUFJkfa5BjPLeQNxV79ns2uhILfjPuNCSu3BosYWkWTv
   Zf8uiJmwxf8DE5dEa6U55LiRIECkGWreMgxCtRJt9eaOHurdNX+MVQYGL
   CIZU3A+A2wIzG2KifPmdccnk8TGC44J8rygzGl5uK4jgJyEDf+NRQl87l
   g4BGvWaGBt1ixVu02QsuaHniDhRAmNpqjlxf2jzodc5lbQAiueNY/C5Hl
   5CbyheWjxPAIu9l6XxfBDPHfE33db3yUjZ5qqHWbuGKMDtXy8Hxs4+VrM
   69wix7In/GNff/WBE0nNXYhi5DdQ+tn6P1QdF4LOS2ZjJwDCfQz22OU9S
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10491"; a="290432489"
X-IronPort-AV: E=Sophos;i="5.95,161,1661842800"; 
   d="scan'208";a="290432489"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Oct 2022 08:29:34 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10491"; a="626609384"
X-IronPort-AV: E=Sophos;i="5.95,161,1661842800"; 
   d="scan'208";a="626609384"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga007.fm.intel.com with ESMTP; 05 Oct 2022 08:29:31 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 0E7E97C; Wed,  5 Oct 2022 18:29:51 +0300 (EEST)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linuxppc-dev@lists.ozlabs.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-acpi@vger.kernel.org
Cc:     Qiang Zhao <qiang.zhao@nxp.com>, Li Yang <leoyang.li@nxp.com>,
        Daniel Scally <djrscally@gmail.com>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Sakari Ailus <sakari.ailus@linux.intel.com>
Subject: [PATCH v2 1/2] device property: Introduce fwnode_device_is_compatible() helper
Date:   Wed,  5 Oct 2022 18:29:46 +0300
Message-Id: <20221005152947.71696-2-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20221005152947.71696-1-andriy.shevchenko@linux.intel.com>
References: <20221005152947.71696-1-andriy.shevchenko@linux.intel.com>
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

The fwnode_device_is_compatible() helper searches for the
given string in the "compatible" string array property and,
if found, returns true.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 include/linux/property.h | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/include/linux/property.h b/include/linux/property.h
index 1c26d263d5e4..701570423943 100644
--- a/include/linux/property.h
+++ b/include/linux/property.h
@@ -55,7 +55,6 @@ int device_property_read_string(struct device *dev, const char *propname,
 int device_property_match_string(struct device *dev,
 				 const char *propname, const char *string);
 
-bool fwnode_device_is_available(const struct fwnode_handle *fwnode);
 bool fwnode_property_present(const struct fwnode_handle *fwnode,
 			     const char *propname);
 int fwnode_property_read_u8_array(const struct fwnode_handle *fwnode,
@@ -77,6 +76,15 @@ int fwnode_property_read_string(const struct fwnode_handle *fwnode,
 				const char *propname, const char **val);
 int fwnode_property_match_string(const struct fwnode_handle *fwnode,
 				 const char *propname, const char *string);
+
+bool fwnode_device_is_available(const struct fwnode_handle *fwnode);
+
+static inline
+bool fwnode_device_is_compatible(const struct fwnode_handle *fwnode, const char *compat)
+{
+	return fwnode_property_match_string(fwnode, "compatible", compat) >= 0;
+}
+
 int fwnode_property_get_reference_args(const struct fwnode_handle *fwnode,
 				       const char *prop, const char *nargs_prop,
 				       unsigned int nargs, unsigned int index,
-- 
2.35.1

