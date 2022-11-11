Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 03295625E9D
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Nov 2022 16:46:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234103AbiKKPqP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Nov 2022 10:46:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58118 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234013AbiKKPqE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Nov 2022 10:46:04 -0500
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 558E22EF28;
        Fri, 11 Nov 2022 07:46:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1668181564; x=1699717564;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=NQU2xvwud4AEa804tDYfWy6tAxT1OjagKjYgyWpiMZQ=;
  b=Qow/qU7qyr5HAAw6fnAXp2/YgKbkVQ2hoW/n1GrhqFxB+K5vD+Spsy/7
   8b4a+9ObQKwpFBa2BgzQuNX/eblYCUScadt1UoAkXQG1Cym3j7eO6mvdW
   hkPzabS731IuOtrdhlfScX74WhK2/qocaNojVGuhMdjiH7n4xHr4vkPB4
   o2IEcW1mUYLgVETtYjRLAj+Nzc5DkbRrzxin6GhrbKgr7Q4rnNYQvC8aT
   tloi+HsXWip+oFwYv2Hj31+CVTJnPKlrYe2Lg3u6rQjFksf8mqbmyvL3+
   zlgNvTNXRww4IHZn70i+KIOdhspcgD07TgKW/xvursEKLiZh5IYw1JxTI
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10528"; a="309246133"
X-IronPort-AV: E=Sophos;i="5.96,156,1665471600"; 
   d="scan'208";a="309246133"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Nov 2022 07:46:03 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10528"; a="668843585"
X-IronPort-AV: E=Sophos;i="5.96,156,1665471600"; 
   d="scan'208";a="668843585"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga008.jf.intel.com with ESMTP; 11 Nov 2022 07:46:00 -0800
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 930AAB7; Fri, 11 Nov 2022 17:46:24 +0200 (EET)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Daniel Scally <djrscally@gmail.com>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Sakari Ailus <sakari.ailus@linux.intel.com>
Subject: [PATCH v3 2/3] device property: Move PROPERTY_ENTRY_BOOL() a bit down
Date:   Fri, 11 Nov 2022 17:46:20 +0200
Message-Id: <20221111154621.15941-2-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20221111154621.15941-1-andriy.shevchenko@linux.intel.com>
References: <20221111154621.15941-1-andriy.shevchenko@linux.intel.com>
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
v3: no changes
v2: rebased on latest Linux Next
 include/linux/property.h | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/include/linux/property.h b/include/linux/property.h
index 0eab13a5c7df..8b4d2d9deea5 100644
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

