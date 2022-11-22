Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 68453633DCA
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Nov 2022 14:35:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233802AbiKVNfy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Nov 2022 08:35:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34832 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232654AbiKVNfn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Nov 2022 08:35:43 -0500
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2444C64A3B;
        Tue, 22 Nov 2022 05:35:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1669124143; x=1700660143;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=fGu2hTzlLDo6mDb92nh0Ze6X0ZVQ7fgf0cePRRQXgwg=;
  b=gVgYLCTDurcUypLwCoQ8NXrBXSnNVPzckb8sqfN5FoFgNutxqRYHnbqT
   OVyWPN4H3Uun375USl2waKGCT3jeBijUMQWOd9yILEkt+uxt+18zJEEco
   xB8/qSFotthpVPpjKGQcom+01TBJHC6a56zjvSpQPI2zYK4inW42dtVdT
   bzbpenjeuQsZxAujYPf3Jr7dS+gU18VtweOi93LaMlMix/6lp36IkIjMM
   XfeMlIsBVUwhP66NJ0M9mQVruh09xnSlBATIYUqZscKpbT7jRjh4sU6yg
   IoBeqyzGIEvXAPcLqzY5A8LlCUK/SsXEDQ+DVlfKjQmjG+Xgi1tuNRkxz
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10538"; a="311442549"
X-IronPort-AV: E=Sophos;i="5.96,184,1665471600"; 
   d="scan'208";a="311442549"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Nov 2022 05:35:41 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10538"; a="672484474"
X-IronPort-AV: E=Sophos;i="5.96,184,1665471600"; 
   d="scan'208";a="672484474"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga008.jf.intel.com with ESMTP; 22 Nov 2022 05:35:38 -0800
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 6F32EF7; Tue, 22 Nov 2022 15:36:04 +0200 (EET)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Daniel Scally <djrscally@gmail.com>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>
Subject: [PATCH v4 2/4] device property: Move PROPERTY_ENTRY_BOOL() a bit down
Date:   Tue, 22 Nov 2022 15:35:58 +0200
Message-Id: <20221122133600.49897-2-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20221122133600.49897-1-andriy.shevchenko@linux.intel.com>
References: <20221122133600.49897-1-andriy.shevchenko@linux.intel.com>
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

Let's order ARRAY and non-ARRAY macros in the same way. The
PROPERTY_ENTRY_BOOL() is special, move it a bit down in the
code so it won't break ordering of the rest.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Acked-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>
---
v4: added tag (Heikki)
v3: no changes
v2: rebased on latest Linux Next
 include/linux/property.h | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/include/linux/property.h b/include/linux/property.h
index 0eab13a5c7df..37179e3abad5 100644
--- a/include/linux/property.h
+++ b/include/linux/property.h
@@ -330,6 +330,7 @@ struct property_entry {
 	__PROPERTY_ENTRY_ARRAY_LEN(_name_, u64_data, U64, _val_, _len_)
 #define PROPERTY_ENTRY_STRING_ARRAY_LEN(_name_, _val_, _len_)		\
 	__PROPERTY_ENTRY_ARRAY_LEN(_name_, str, STRING, _val_, _len_)
+
 #define PROPERTY_ENTRY_REF_ARRAY_LEN(_name_, _val_, _len_)		\
 (struct property_entry) {						\
 	.name = _name_,							\
@@ -348,7 +349,7 @@ struct property_entry {
 	PROPERTY_ENTRY_U64_ARRAY_LEN(_name_, _val_, ARRAY_SIZE(_val_))
 #define PROPERTY_ENTRY_STRING_ARRAY(_name_, _val_)			\
 	PROPERTY_ENTRY_STRING_ARRAY_LEN(_name_, _val_, ARRAY_SIZE(_val_))
-#define PROPERTY_ENTRY_REF_ARRAY(_name_, _val_)			\
+#define PROPERTY_ENTRY_REF_ARRAY(_name_, _val_)				\
 	PROPERTY_ENTRY_REF_ARRAY_LEN(_name_, _val_, ARRAY_SIZE(_val_))
 
 #define __PROPERTY_ENTRY_ELEMENT(_name_, _elem_, _Type_, _val_)		\
@@ -371,12 +372,6 @@ struct property_entry {
 #define PROPERTY_ENTRY_STRING(_name_, _val_)				\
 	__PROPERTY_ENTRY_ELEMENT(_name_, str, STRING, _val_)
 
-#define PROPERTY_ENTRY_BOOL(_name_)		\
-(struct property_entry) {			\
-	.name = _name_,				\
-	.is_inline = true,			\
-}
-
 #define PROPERTY_ENTRY_REF(_name_, _ref_, ...)				\
 (struct property_entry) {						\
 	.name = _name_,							\
@@ -385,9 +380,14 @@ struct property_entry {
 	{ .pointer = &SOFTWARE_NODE_REFERENCE(_ref_, ##__VA_ARGS__), },	\
 }
 
+#define PROPERTY_ENTRY_BOOL(_name_)		\
+(struct property_entry) {			\
+	.name = _name_,				\
+	.is_inline = true,			\
+}
+
 struct property_entry *
 property_entries_dup(const struct property_entry *properties);
-
 void property_entries_free(const struct property_entry *properties);
 
 bool device_dma_supported(const struct device *dev);
-- 
2.35.1

