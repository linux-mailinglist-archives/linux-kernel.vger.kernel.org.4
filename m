Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 41E756C7D60
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Mar 2023 12:41:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231718AbjCXLlP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Mar 2023 07:41:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46844 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231735AbjCXLlK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Mar 2023 07:41:10 -0400
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 638951D931;
        Fri, 24 Mar 2023 04:41:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1679658065; x=1711194065;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=YBqhQIVyMkXm+tDKkdwns6cbJW/akWTveT/HtiqwXGU=;
  b=hhxcXfpEAeFDTvAIJ06D0gmy2ylHNtAvO3Kk4KVo4488ACUNyxD3N3/t
   7L9+i284KeHT4tiD2j7ynWe5B3tyhtG6Gy0TpI0RLJlCSwVuLh33TsTPJ
   QnuVtSx7BW+1ClyiG1enT/NIboKd19PmHIa90BShGgYttFiaMe+2tfP2T
   altMiCkB7XDFbwWxdQ1MJq5tG1Ny8U8RnHml0t8vD1IfWi8UG2gULsmhF
   j+YhzAc9IzeGT7jBVZfMqNf2W2dJYBY+nigF68djbYn+3CcUga+jOJQv5
   qQAwbP8eLWGHTsz7aM+v42MyY/EZFCyNZRblk4tfF0lvB/gvvCA8ScoZL
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10658"; a="402343901"
X-IronPort-AV: E=Sophos;i="5.98,287,1673942400"; 
   d="scan'208";a="402343901"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Mar 2023 04:41:05 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10658"; a="715201455"
X-IronPort-AV: E=Sophos;i="5.98,287,1673942400"; 
   d="scan'208";a="715201455"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga001.jf.intel.com with ESMTP; 24 Mar 2023 04:41:03 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 7BD83176; Fri, 24 Mar 2023 13:41:49 +0200 (EET)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Len Brown <lenb@kernel.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v1 1/1] ACPI: property: Refactor acpi_data_prop_read_single()
Date:   Fri, 24 Mar 2023 13:41:46 +0200
Message-Id: <20230324114146.4037-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.40.0.1.gaa8946217a0b
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.4 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Refactor acpi_data_prop_read_single() for decreased indentation
and better structure. No functional changes intended.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/acpi/property.c | 80 ++++++++++++++++++-----------------------
 1 file changed, 34 insertions(+), 46 deletions(-)

diff --git a/drivers/acpi/property.c b/drivers/acpi/property.c
index b8d9eb9a433e..413e4fcadcaf 100644
--- a/drivers/acpi/property.c
+++ b/drivers/acpi/property.c
@@ -971,60 +971,48 @@ static int acpi_data_prop_read_single(const struct acpi_device_data *data,
 				      enum dev_prop_type proptype, void *val)
 {
 	const union acpi_object *obj;
-	int ret;
+	int ret = 0;
 
-	if (proptype >= DEV_PROP_U8 && proptype <= DEV_PROP_U64) {
+	if (proptype >= DEV_PROP_U8 && proptype <= DEV_PROP_U64)
 		ret = acpi_data_get_property(data, propname, ACPI_TYPE_INTEGER, &obj);
-		if (ret)
-			return ret;
-
-		switch (proptype) {
-		case DEV_PROP_U8:
-			if (obj->integer.value > U8_MAX)
-				return -EOVERFLOW;
-
-			if (val)
-				*(u8 *)val = obj->integer.value;
-
-			break;
-		case DEV_PROP_U16:
-			if (obj->integer.value > U16_MAX)
-				return -EOVERFLOW;
-
-			if (val)
-				*(u16 *)val = obj->integer.value;
-
-			break;
-		case DEV_PROP_U32:
-			if (obj->integer.value > U32_MAX)
-				return -EOVERFLOW;
-
-			if (val)
-				*(u32 *)val = obj->integer.value;
-
-			break;
-		default:
-			if (val)
-				*(u64 *)val = obj->integer.value;
-
-			break;
-		}
-
-		if (!val)
-			return 1;
-	} else if (proptype == DEV_PROP_STRING) {
+	else if (proptype == DEV_PROP_STRING)
 		ret = acpi_data_get_property(data, propname, ACPI_TYPE_STRING, &obj);
-		if (ret)
-			return ret;
+	if (ret)
+		return ret;
 
+	switch (proptype) {
+	case DEV_PROP_U8:
+		if (obj->integer.value > U8_MAX)
+			return -EOVERFLOW;
+		if (val)
+			*(u8 *)val = obj->integer.value;
+		break;
+	case DEV_PROP_U16:
+		if (obj->integer.value > U16_MAX)
+			return -EOVERFLOW;
+		if (val)
+			*(u16 *)val = obj->integer.value;
+		break;
+	case DEV_PROP_U32:
+		if (obj->integer.value > U32_MAX)
+			return -EOVERFLOW;
+		if (val)
+			*(u32 *)val = obj->integer.value;
+		break;
+	case DEV_PROP_U64:
+		if (val)
+			*(u64 *)val = obj->integer.value;
+		break;
+	case DEV_PROP_STRING:
 		if (val)
 			*(char **)val = obj->string.pointer;
-
 		return 1;
-	} else {
-		ret = -EINVAL;
+	default:
+		return -EINVAL;
 	}
-	return ret;
+
+	/* When no storage provided return number of available values */
+	return val ? 0 : 1;
 }
 
 #define acpi_copy_property_array_uint(items, val, nval)			\
-- 
2.40.0.1.gaa8946217a0b

