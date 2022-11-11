Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C8B73625E9C
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Nov 2022 16:46:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234081AbiKKPqK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Nov 2022 10:46:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58104 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233923AbiKKPqE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Nov 2022 10:46:04 -0500
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A480625C4D;
        Fri, 11 Nov 2022 07:46:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1668181563; x=1699717563;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=DmQaptAdDzNbGCp3ivClJtgkBMbzP5Q4OG5xUGDVa0A=;
  b=Z4Gb+3im8KbmFkDdos4X2EHC1Z0os0MURDxlh+fdbYu3d9s8pftFMlza
   19gEUMMzdCtrCN+e7nZ/uC2VwPX+m2jNPtyeotHigFBbWpw43PD3EwHOE
   dgYRrlRVKuioppTm/QkozmNw1S85ejBqMBaU76jZgFlkyuJohZlV264gO
   V8irFa2lx0POvvHBOy+9bYbJD8tcezsF7dRId+kUxA+yVsPQEoMd7+959
   BI+WAjwSmXWN2nRo0MEbYhZrocWZjVjzTf8lGHIoaORnB4j1XVHuTX1tb
   pf0yhY9iVJsRp2N2hVCo6Z8NqbZVZMvp3jxDyoF/+FIGy7zAUzWOFUy9g
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10528"; a="309246132"
X-IronPort-AV: E=Sophos;i="5.96,156,1665471600"; 
   d="scan'208";a="309246132"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Nov 2022 07:46:02 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10528"; a="668843583"
X-IronPort-AV: E=Sophos;i="5.96,156,1665471600"; 
   d="scan'208";a="668843583"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga008.jf.intel.com with ESMTP; 11 Nov 2022 07:46:00 -0800
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 8376B155; Fri, 11 Nov 2022 17:46:24 +0200 (EET)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Daniel Scally <djrscally@gmail.com>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Sakari Ailus <sakari.ailus@linux.intel.com>
Subject: [PATCH v3 1/3] device property: Get rid of __PROPERTY_ENTRY_ARRAY_EL*SIZE*()
Date:   Fri, 11 Nov 2022 17:46:19 +0200
Message-Id: <20221111154621.15941-1-andriy.shevchenko@linux.intel.com>
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
---
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

