Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 85CED619C0F
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Nov 2022 16:48:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230402AbiKDPsy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Nov 2022 11:48:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55194 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231852AbiKDPsp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Nov 2022 11:48:45 -0400
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 770B62EF7B;
        Fri,  4 Nov 2022 08:48:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1667576913; x=1699112913;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=A2gdfuPaRpBvqBCsNXkl/QJS5l+GX3I2znrraPGDPzI=;
  b=iLuyocZLWkUwVUQDdrNFTWyoYDH5nmRnj0LhmyLzzKR1YaHYefhF+Ihv
   nR6OrRTUpAJk5Xtw0x1fMYGJFq7vJsJsODWsLzW97asLNOFyG4nsPtSBf
   ZZkm44bAZmuft5C2zAIz0CQqPptJdF/BMMpTQyTL/+HC7eS1Hv3kGx6xP
   SBqbc7cJap2ouc/0nAviKbacRP19PtFo/Y9DlgQzgfxRvF3XTV/QFTiwv
   dj4soaZW584nTQjQgM62gUmhI2stjzjVTsoohD5Jx02geUEDr7WQrH7BU
   VXa9OVG9GaHWwKS0MbevwNroMVvbiv06AkoIy/hvXophPblWS3vo+6K1a
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10521"; a="293325439"
X-IronPort-AV: E=Sophos;i="5.96,137,1665471600"; 
   d="scan'208";a="293325439"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Nov 2022 08:48:31 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10521"; a="724394199"
X-IronPort-AV: E=Sophos;i="5.96,137,1665471600"; 
   d="scan'208";a="724394199"
Received: from black.fi.intel.com ([10.237.72.28])
  by FMSMGA003.fm.intel.com with ESMTP; 04 Nov 2022 08:48:28 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id EA6F8D0; Fri,  4 Nov 2022 17:48:51 +0200 (EET)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Daniel Scally <djrscally@gmail.com>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>
Subject: [PATCH v1 2/2] device property: Move PROPERTY_ENTRY_BOOL() a bit down
Date:   Fri,  4 Nov 2022 17:48:49 +0200
Message-Id: <20221104154849.35177-2-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20221104154849.35177-1-andriy.shevchenko@linux.intel.com>
References: <20221104154849.35177-1-andriy.shevchenko@linux.intel.com>
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

Let's order ARRAY and non-ARRAY macros in the same way. The
PROPERTY_ENTRY_BOOL() is special, move it a bit down in the
code so it won't break ordering of the rest.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 include/linux/property.h | 13 +++++++------
 1 file changed, 7 insertions(+), 6 deletions(-)

diff --git a/include/linux/property.h b/include/linux/property.h
index df3f16d23d0c..20b4a2edf28d 100644
--- a/include/linux/property.h
+++ b/include/linux/property.h
@@ -329,6 +329,7 @@ struct property_entry {
 	__PROPERTY_ENTRY_ARRAY_LEN(_name_, u64_data, U64, _val_, _len_)
 #define PROPERTY_ENTRY_STRING_ARRAY_LEN(_name_, _val_, _len_)		\
 	__PROPERTY_ENTRY_ARRAY_LEN(_name_, str, STRING, _val_, _len_)
+
 #define PROPERTY_ENTRY_REF_ARRAY_LEN(_name_, _val_, _len_)		\
 (struct property_entry) {						\
 	.name = _name_,							\
@@ -370,12 +371,6 @@ struct property_entry {
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
@@ -384,6 +379,12 @@ struct property_entry {
 	{ .pointer = &SOFTWARE_NODE_REFERENCE(_ref_, ##__VA_ARGS__), },	\
 }
 
+#define PROPERTY_ENTRY_BOOL(_name_)		\
+(struct property_entry) {			\
+	.name = _name_,				\
+	.is_inline = true,			\
+}
+
 struct property_entry *property_entries_dup(const struct property_entry *properties);
 void property_entries_free(const struct property_entry *properties);
 
-- 
2.35.1

