Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9A434625A5B
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Nov 2022 13:15:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233814AbiKKMPE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Nov 2022 07:15:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43154 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232968AbiKKMO7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Nov 2022 07:14:59 -0500
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C9BD532C0;
        Fri, 11 Nov 2022 04:14:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1668168898; x=1699704898;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=4wRoo7N3PTMuyyFIGGkVMosd0G1YfaK6CY2wTW3dWT4=;
  b=lkRAXUfpN0lZBBtBTw3+AtfLYQiYCq8bQnGX6GKF574/EjTD2+5vsOO0
   x0k7a8xJvpae8GIDIKFJZQCCbgYDyrTOO7PGBK7H8Eu5hrj4cl7XsgR6f
   7VUDd5jJIllHDw4tQOi6SGqJvjCcWI6r7ee7XPFoVk/j2G0E0nbmHAE/4
   Z6uezAod5MoJJmaoyq44W3d++YJa90D6QqAExHhRGVzpyFKFD8SGxka0R
   Rsu8rfZgJdo9bA5W47lDCx6Aclc1zl5OGx1UMK+gxfH4HO232Re/u/+D0
   nGldqSZ1of7VXsaX2flva52UJkJ/ScHlZX6bIB6NHc9rdVbEW/IkqeSJl
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10527"; a="291990239"
X-IronPort-AV: E=Sophos;i="5.96,156,1665471600"; 
   d="scan'208";a="291990239"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Nov 2022 04:14:58 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10527"; a="639997733"
X-IronPort-AV: E=Sophos;i="5.96,156,1665471600"; 
   d="scan'208";a="639997733"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga007.fm.intel.com with ESMTP; 11 Nov 2022 04:14:56 -0800
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 6DC32155; Fri, 11 Nov 2022 14:15:20 +0200 (EET)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Daniel Scally <djrscally@gmail.com>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: [PATCH v2 1/2] device property: Get rid of __PROPERTY_ENTRY_ARRAY_EL*SIZE*()
Date:   Fri, 11 Nov 2022 14:15:17 +0200
Message-Id: <20221111121518.44145-1-andriy.shevchenko@linux.intel.com>
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

First of all, _ELEMENT_SIZE() repeats existing sizeof_field() macro.
Second, usage of _ARRAY_ELSIZE_LEN() adds unnecessary indirection
to the data layout. It's more understandable when the data structure
is placed explicitly. That said, get rid of those macros by replacing
them with the existing helper and explicit data structure layout.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
v2: rebased on latest Linux Next, fixed anon union assignment
 include/linux/property.h | 34 ++++++++++++++--------------------
 1 file changed, 14 insertions(+), 20 deletions(-)

diff --git a/include/linux/property.h b/include/linux/property.h
index 5d840299146d..aa58d4e8a21c 100644
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
+	.type = DEV_PROP_##_Type_,					\
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

