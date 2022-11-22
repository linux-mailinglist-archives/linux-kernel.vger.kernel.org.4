Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2320F633DCD
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Nov 2022 14:36:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233831AbiKVNgC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Nov 2022 08:36:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34830 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232891AbiKVNfn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Nov 2022 08:35:43 -0500
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 10DD451C26;
        Tue, 22 Nov 2022 05:35:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1669124143; x=1700660143;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=buFbMo2ULium7j74ddZOqvKKRSi8X7Y7FsUFsVFRKHQ=;
  b=eXv/2YFrGUTpIdR3r0Aqpa44f8+e1uhNfvyDQGdOzE2Pr/5Sl35YrNvJ
   SkOuk6BlSQ5B/aHLl1F/HOQdAMStP0N3PyZa0oKjSBhdTZJ5gMzCAPD39
   0mqejyxzgr5A8x+SlI+NLyfVoDZ1OktonVQVeXXYHu2A8ym2mBT7Uu6OI
   p58jQ7WEvnpqXYd5FFhCm9M9vNGPy5gZjDrvhKd01XeZM7bqSerfaBYJb
   g7lkHKAh1LRuqYhVKxf1xKqgYvZcR60U3C3FWQ2DTic5fw/3psbA05N4w
   6ZHHHUZGTuXlMTpVQU6EV23CCEVwRNOtOqGt8RL3E2SJe7dJ/v6x5X1Yx
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10538"; a="311442548"
X-IronPort-AV: E=Sophos;i="5.96,184,1665471600"; 
   d="scan'208";a="311442548"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Nov 2022 05:35:41 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10538"; a="672484472"
X-IronPort-AV: E=Sophos;i="5.96,184,1665471600"; 
   d="scan'208";a="672484472"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga008.jf.intel.com with ESMTP; 22 Nov 2022 05:35:38 -0800
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 6364B128; Tue, 22 Nov 2022 15:36:04 +0200 (EET)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Daniel Scally <djrscally@gmail.com>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>
Subject: [PATCH v4 1/4] device property: Get rid of __PROPERTY_ENTRY_ARRAY_EL*SIZE*()
Date:   Tue, 22 Nov 2022 15:35:57 +0200
Message-Id: <20221122133600.49897-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

First of all, _ELEMENT_SIZE() repeats existing sizeof_field() macro.
Second, usage of _ARRAY_ELSIZE_LEN() adds unnecessary indirection
to the data layout. It's more understandable when the data structure
is placed explicitly. That said, get rid of those macros by replacing
them with the existing helper and explicit data structure layout.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Acked-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>
---
v4: added tag (Heikki)
v3: fixed typo in PROPERTY_ENTRY_REF_ARRAY_LEN() impl (LKP)
v2: rebased on latest Linux Next, fixed anon union assignment
 include/linux/property.h | 34 ++++++++++++++--------------------
 1 file changed, 14 insertions(+), 20 deletions(-)

diff --git a/include/linux/property.h b/include/linux/property.h
index 5d840299146d..0eab13a5c7df 100644
--- a/include/linux/property.h
+++ b/include/linux/property.h
@@ -12,6 +12,7 @@
 
 #include <linux/bits.h>
 #include <linux/fwnode.h>
+#include <linux/stddef.h>
 #include <linux/types.h>
 
 struct device;
@@ -311,24 +312,14 @@ struct property_entry {
  * crafted to avoid gcc-4.4.4's problems with initialization of anon unions
  * and structs.
  */
-
-#define __PROPERTY_ENTRY_ELEMENT_SIZE(_elem_)				\
-	sizeof(((struct property_entry *)NULL)->value._elem_[0])
-
-#define __PROPERTY_ENTRY_ARRAY_ELSIZE_LEN(_name_, _elsize_, _Type_,	\
-					  _val_, _len_)			\
-(struct property_entry) {						\
-	.name = _name_,							\
-	.length = (_len_) * (_elsize_),					\
-	.type = DEV_PROP_##_Type_,					\
-	{ .pointer = _val_ },						\
+#define __PROPERTY_ENTRY_ARRAY_LEN(_name_, _elem_, _Type_, _val_, _len_)		\
+(struct property_entry) {								\
+	.name = _name_,									\
+	.length = (_len_) * sizeof_field(struct property_entry, value._elem_[0]),	\
+	.type = DEV_PROP_##_Type_,							\
+	{ .pointer = _val_ },								\
 }
 
-#define __PROPERTY_ENTRY_ARRAY_LEN(_name_, _elem_, _Type_, _val_, _len_)\
-	__PROPERTY_ENTRY_ARRAY_ELSIZE_LEN(_name_,			\
-				__PROPERTY_ENTRY_ELEMENT_SIZE(_elem_),	\
-				_Type_, _val_, _len_)
-
 #define PROPERTY_ENTRY_U8_ARRAY_LEN(_name_, _val_, _len_)		\
 	__PROPERTY_ENTRY_ARRAY_LEN(_name_, u8_data, U8, _val_, _len_)
 #define PROPERTY_ENTRY_U16_ARRAY_LEN(_name_, _val_, _len_)		\
@@ -340,9 +331,12 @@ struct property_entry {
 #define PROPERTY_ENTRY_STRING_ARRAY_LEN(_name_, _val_, _len_)		\
 	__PROPERTY_ENTRY_ARRAY_LEN(_name_, str, STRING, _val_, _len_)
 #define PROPERTY_ENTRY_REF_ARRAY_LEN(_name_, _val_, _len_)		\
-	__PROPERTY_ENTRY_ARRAY_ELSIZE_LEN(_name_,			\
-				sizeof(struct software_node_ref_args),	\
-				REF, _val_, _len_)
+(struct property_entry) {						\
+	.name = _name_,							\
+	.length = (_len_) * sizeof(struct software_node_ref_args),	\
+	.type = DEV_PROP_REF,						\
+	{ .pointer = _val_ },						\
+}
 
 #define PROPERTY_ENTRY_U8_ARRAY(_name_, _val_)				\
 	PROPERTY_ENTRY_U8_ARRAY_LEN(_name_, _val_, ARRAY_SIZE(_val_))
@@ -360,7 +354,7 @@ struct property_entry {
 #define __PROPERTY_ENTRY_ELEMENT(_name_, _elem_, _Type_, _val_)		\
 (struct property_entry) {						\
 	.name = _name_,							\
-	.length = __PROPERTY_ENTRY_ELEMENT_SIZE(_elem_),		\
+	.length = sizeof_field(struct property_entry, value._elem_[0]),	\
 	.is_inline = true,						\
 	.type = DEV_PROP_##_Type_,					\
 	{ .value = { ._elem_[0] = _val_ } },				\
-- 
2.35.1

