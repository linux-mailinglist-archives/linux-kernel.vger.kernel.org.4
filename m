Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CB11B619C10
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Nov 2022 16:49:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232084AbiKDPs5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Nov 2022 11:48:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55212 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231913AbiKDPsp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Nov 2022 11:48:45 -0400
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 863733206F;
        Fri,  4 Nov 2022 08:48:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1667576915; x=1699112915;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=Xla2swd4QMnSDMynVbVtEHhVjw6ggpJidpVuDm6dIHA=;
  b=AjxD/W7YbChPmEHRcWjw2lE8aleEDi8yjnFFRINGuNxekTyQEBd546Rj
   Erc3wctdFXQ1mO8WeX7jnkQPav5Yckfu9/B0m7dJlfDFTp3QspBp7Lhpl
   eWBRkz5IboAPcHzu+65GrvLY9Pc7bnKjBuXHL8cj35sSX8f7CuxGWqkaA
   ql7lfjiVBTDh2Q9D/fEbs35IqCOCh0iSadt3YsI8R5B+znI6osUMUPQuU
   2yj/XBA5uWQl5bmpcJepbmmBsDd3Ur2aK8WIDiPEofyql4wZWkxr39gjQ
   0kmwX/F6NwzAL+v9j7CXvR1fbZ2vgpjBo04rh7soDxBeNpIpFHlkRqZbP
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10521"; a="293325440"
X-IronPort-AV: E=Sophos;i="5.96,137,1665471600"; 
   d="scan'208";a="293325440"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Nov 2022 08:48:31 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10521"; a="724394198"
X-IronPort-AV: E=Sophos;i="5.96,137,1665471600"; 
   d="scan'208";a="724394198"
Received: from black.fi.intel.com ([10.237.72.28])
  by FMSMGA003.fm.intel.com with ESMTP; 04 Nov 2022 08:48:28 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id D97E1F7; Fri,  4 Nov 2022 17:48:51 +0200 (EET)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Daniel Scally <djrscally@gmail.com>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>
Subject: [PATCH v1 1/2] device property: Get rid of __PROPERTY_ENTRY_ARRAY_EL*SIZE*()
Date:   Fri,  4 Nov 2022 17:48:48 +0200
Message-Id: <20221104154849.35177-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
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
---
 include/linux/property.h | 34 ++++++++++++++--------------------
 1 file changed, 14 insertions(+), 20 deletions(-)

diff --git a/include/linux/property.h b/include/linux/property.h
index ccc73399c9ea..df3f16d23d0c 100644
--- a/include/linux/property.h
+++ b/include/linux/property.h
@@ -12,6 +12,7 @@
 
 #include <linux/bits.h>
 #include <linux/fwnode.h>
+#include <linux/stddef.h>
 #include <linux/types.h>
 
 struct device;
@@ -310,24 +311,14 @@ struct property_entry {
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
@@ -339,9 +330,12 @@ struct property_entry {
 #define PROPERTY_ENTRY_STRING_ARRAY_LEN(_name_, _val_, _len_)		\
 	__PROPERTY_ENTRY_ARRAY_LEN(_name_, str, STRING, _val_, _len_)
 #define PROPERTY_ENTRY_REF_ARRAY_LEN(_name_, _val_, _len_)		\
-	__PROPERTY_ENTRY_ARRAY_ELSIZE_LEN(_name_,			\
-				sizeof(struct software_node_ref_args),	\
-				REF, _val_, _len_)
+(struct property_entry) {						\
+	.name = _name_,							\
+	.length = (_len_) * sizeof(struct software_node_ref_args),	\
+	.type = DEV_PROP_##_Type_,					\
+	.pointer = _val_,						\
+}
 
 #define PROPERTY_ENTRY_U8_ARRAY(_name_, _val_)				\
 	PROPERTY_ENTRY_U8_ARRAY_LEN(_name_, _val_, ARRAY_SIZE(_val_))
@@ -359,7 +353,7 @@ struct property_entry {
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

