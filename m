Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 582AF625A5A
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Nov 2022 13:15:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233803AbiKKMPB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Nov 2022 07:15:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43156 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233338AbiKKMO7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Nov 2022 07:14:59 -0500
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C7E7C5B5A9;
        Fri, 11 Nov 2022 04:14:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1668168898; x=1699704898;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=yWRgWmi8NjhGKKd/wqtAvGh6FPQuBCvnh+N8Hl3B3To=;
  b=mB5QFE2SYpIEg5wowOPOxSIvvJUzxiGDlIq1GATn66oXEFL3kgJqrwMK
   tNx5Dp+SYDgYsQVmo2SgTdRVL5+MXdT2xrxt2Jnchjs6LkUxNuCjEeFgC
   LplHCxX2ssH4MxZpnvy/g/KA71Q9PjN7ScneAtxM5OmlAU+3fe04kQN1I
   1zK12bNoORbap6azk5/R+vgIowxF9PeL9Dqp9WByRLc1RGxwrLKHqsCq4
   sswhQBsxNWF8+W/8smoyiXUdP2JYMLk4ztfMiQ2zgPiwp4qCm5z9FbcPA
   bRA4hgLPrxiBDmoNBbn8alhQm7veWLfZ5fSerRxtn8Pdk9w3fTc2kd/FS
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10527"; a="309212355"
X-IronPort-AV: E=Sophos;i="5.96,156,1665471600"; 
   d="scan'208";a="309212355"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Nov 2022 04:14:58 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10527"; a="670730485"
X-IronPort-AV: E=Sophos;i="5.96,156,1665471600"; 
   d="scan'208";a="670730485"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga001.jf.intel.com with ESMTP; 11 Nov 2022 04:14:56 -0800
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 7B5F7F7; Fri, 11 Nov 2022 14:15:20 +0200 (EET)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Daniel Scally <djrscally@gmail.com>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: [PATCH v2 2/2] device property: Move PROPERTY_ENTRY_BOOL() a bit down
Date:   Fri, 11 Nov 2022 14:15:18 +0200
Message-Id: <20221111121518.44145-2-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20221111121518.44145-1-andriy.shevchenko@linux.intel.com>
References: <20221111121518.44145-1-andriy.shevchenko@linux.intel.com>
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
---
v2: rebased on latest Linux Next
 include/linux/property.h | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/include/linux/property.h b/include/linux/property.h
index aa58d4e8a21c..b8357397242b 100644
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

