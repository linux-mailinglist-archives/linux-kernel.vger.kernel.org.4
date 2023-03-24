Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B463E6C7D2C
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Mar 2023 12:26:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231681AbjCXL0n (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Mar 2023 07:26:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51848 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229830AbjCXL0l (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Mar 2023 07:26:41 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C0EA132C0;
        Fri, 24 Mar 2023 04:26:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1679657200; x=1711193200;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=aAHxWdgA6KNADXX0NKzDGmq9HK2lk7j3n4Q3pe8f6K8=;
  b=SzCKJSpMLPGl4xwboSPuApStC/sZm/n0oR19iP0Urpehh2kNfZgtdPBK
   QfZuiSAu56ducjVPInb1+eBw2f6w9H1OREGy8J6l0WlgjnnCq2iC7/1yv
   AMj9gUDHkoCcL+Tpo0lCL4Hw64fhLVnXnlNZfT6u4RDkOHqcHnmrdplBc
   mAAHT6FGvPKUfBfKCmtjI5N6x25KlYe4hOAEqpO1HZhAZapQ8v4LexKwk
   U6aqs11m0gut3VgaQoEA9Vpvq7MAqyLCSpH6WFh/Vi8lViheg3+H44HxO
   +BYbeYcBRheIoac7AE4gWKdTQKIL/a69yGGAIZeztXzORqW3+38lFRoRr
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10658"; a="342143989"
X-IronPort-AV: E=Sophos;i="5.98,287,1673942400"; 
   d="scan'208";a="342143989"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Mar 2023 04:26:39 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10658"; a="1012225742"
X-IronPort-AV: E=Sophos;i="5.98,287,1673942400"; 
   d="scan'208";a="1012225742"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga005.fm.intel.com with ESMTP; 24 Mar 2023 04:26:37 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id E427C176; Fri, 24 Mar 2023 13:27:23 +0200 (EET)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Daniel Scally <djrscally@gmail.com>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Russell King <rmk+kernel@armlinux.org.uk>
Subject: [PATCH v1 1/1] device property: Constify a few fwnode APIs
Date:   Fri, 24 Mar 2023 13:27:20 +0200
Message-Id: <20230324112720.71315-1-andriy.shevchenko@linux.intel.com>
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

The fwnode parameter is not altered in the following APIs:

- fwnode_get_next_parent_dev()
- fwnode_is_ancestor_of()
- fwnode_graph_get_endpoint_count()

so constify them.

Reported-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/base/property.c  | 6 +++---
 include/linux/property.h | 6 +++---
 2 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/base/property.c b/drivers/base/property.c
index 3fc25e568598..b19ca8f752a8 100644
--- a/drivers/base/property.c
+++ b/drivers/base/property.c
@@ -648,7 +648,7 @@ EXPORT_SYMBOL_GPL(fwnode_get_next_parent);
  *
  * Return: a pointer to the device of the @fwnode's closest ancestor.
  */
-struct device *fwnode_get_next_parent_dev(struct fwnode_handle *fwnode)
+struct device *fwnode_get_next_parent_dev(const struct fwnode_handle *fwnode)
 {
 	struct fwnode_handle *parent;
 	struct device *dev;
@@ -718,7 +718,7 @@ EXPORT_SYMBOL_GPL(fwnode_get_nth_parent);
  *
  * Return: true if @ancestor is an ancestor of @child. Otherwise, returns false.
  */
-bool fwnode_is_ancestor_of(struct fwnode_handle *ancestor, struct fwnode_handle *child)
+bool fwnode_is_ancestor_of(const struct fwnode_handle *ancestor, const struct fwnode_handle *child)
 {
 	struct fwnode_handle *parent;
 
@@ -1235,7 +1235,7 @@ EXPORT_SYMBOL_GPL(fwnode_graph_get_endpoint_by_id);
  * If FWNODE_GRAPH_DEVICE_DISABLED flag is specified, also unconnected endpoints
  * and endpoints connected to disabled devices are counted.
  */
-unsigned int fwnode_graph_get_endpoint_count(struct fwnode_handle *fwnode,
+unsigned int fwnode_graph_get_endpoint_count(const struct fwnode_handle *fwnode,
 					     unsigned long flags)
 {
 	struct fwnode_handle *ep;
diff --git a/include/linux/property.h b/include/linux/property.h
index 9c774b0fe5bd..8ba804721fdf 100644
--- a/include/linux/property.h
+++ b/include/linux/property.h
@@ -104,11 +104,11 @@ struct fwnode_handle *fwnode_get_next_parent(struct fwnode_handle *fwnode);
 	for (parent = fwnode_get_parent(fwnode); parent;	\
 	     parent = fwnode_get_next_parent(parent))
 
-struct device *fwnode_get_next_parent_dev(struct fwnode_handle *fwnode);
+struct device *fwnode_get_next_parent_dev(const struct fwnode_handle *fwnode);
 unsigned int fwnode_count_parents(const struct fwnode_handle *fwn);
 struct fwnode_handle *fwnode_get_nth_parent(struct fwnode_handle *fwn,
 					    unsigned int depth);
-bool fwnode_is_ancestor_of(struct fwnode_handle *ancestor, struct fwnode_handle *child);
+bool fwnode_is_ancestor_of(const struct fwnode_handle *ancestor, const struct fwnode_handle *child);
 struct fwnode_handle *fwnode_get_next_child_node(
 	const struct fwnode_handle *fwnode, struct fwnode_handle *child);
 struct fwnode_handle *fwnode_get_next_available_child_node(
@@ -432,7 +432,7 @@ static inline bool fwnode_graph_is_endpoint(const struct fwnode_handle *fwnode)
 struct fwnode_handle *
 fwnode_graph_get_endpoint_by_id(const struct fwnode_handle *fwnode,
 				u32 port, u32 endpoint, unsigned long flags);
-unsigned int fwnode_graph_get_endpoint_count(struct fwnode_handle *fwnode,
+unsigned int fwnode_graph_get_endpoint_count(const struct fwnode_handle *fwnode,
 					     unsigned long flags);
 
 #define fwnode_graph_for_each_endpoint(fwnode, child)				\
-- 
2.40.0.1.gaa8946217a0b

