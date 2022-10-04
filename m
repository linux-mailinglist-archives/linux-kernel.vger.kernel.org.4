Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BDDE35F3F72
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Oct 2022 11:23:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231184AbiJDJW6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Oct 2022 05:22:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37846 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230497AbiJDJWK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Oct 2022 05:22:10 -0400
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2FA664D4E1;
        Tue,  4 Oct 2022 02:21:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1664875277; x=1696411277;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=pG2gl1Og7LZ39abQBQtAJEObltVt2vZiEmqulJUEwx0=;
  b=E1bSYM+YgriST5/FzYAHhFXO688CvDptWlXlPCScyJFb/4CFeOwk5GTz
   sOFRMrJks/FMtpGPgavji1xaVBuY89kEkUBZET81S2qlxhNEsjxprklru
   0bdDF4zcVhPUJno7IpuHgmqyYe6d0EjGhNsBrP2sICMT7fO69oK/I9RSk
   OwKYN7fohaYM3E88fbevnllmNmTg9lYcUcR1IL4c3RlWQ5d89HBWaBuUI
   7k+tEFqiDT1g3LrRZ+VHlCavKZ/lftuAxRw2toI2DLa5JHIHB8Flr1FjU
   8E2dhJmwSAOl0iZkU6zPFmKhx3lxP+hyJty8NGtzvQbZrJ7iBEh0rPy56
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10489"; a="301585206"
X-IronPort-AV: E=Sophos;i="5.93,367,1654585200"; 
   d="scan'208";a="301585206"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Oct 2022 02:21:15 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10489"; a="799050983"
X-IronPort-AV: E=Sophos;i="5.93,367,1654585200"; 
   d="scan'208";a="799050983"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga005.jf.intel.com with ESMTP; 04 Oct 2022 02:21:12 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 990DE118; Tue,  4 Oct 2022 12:21:31 +0300 (EEST)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Prashant Malani <pmalani@chromium.org>,
        linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-usb@vger.kernel.org
Cc:     Daniel Scally <djrscally@gmail.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>
Subject: [PATCH v3 2/5] device property: Constify fwnode connection match APIs
Date:   Tue,  4 Oct 2022 12:21:26 +0300
Message-Id: <20221004092129.19412-3-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20221004092129.19412-1-andriy.shevchenko@linux.intel.com>
References: <20221004092129.19412-1-andriy.shevchenko@linux.intel.com>
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

The fwnode and device parameters are not altered in the fwnode
connection match APIs, constify them.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Acked-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>
Reviewed-by: Sakari Ailus <sakari.ailus@linux.intel.com>
---
 drivers/base/property.c     | 8 ++++----
 drivers/usb/roles/class.c   | 2 +-
 drivers/usb/typec/mux.c     | 8 ++++----
 drivers/usb/typec/retimer.c | 2 +-
 include/linux/property.h    | 8 ++++----
 5 files changed, 14 insertions(+), 14 deletions(-)

diff --git a/drivers/base/property.c b/drivers/base/property.c
index d77302d28566..58b8158add5c 100644
--- a/drivers/base/property.c
+++ b/drivers/base/property.c
@@ -1213,7 +1213,7 @@ const void *device_get_match_data(const struct device *dev)
 }
 EXPORT_SYMBOL_GPL(device_get_match_data);
 
-static unsigned int fwnode_graph_devcon_matches(struct fwnode_handle *fwnode,
+static unsigned int fwnode_graph_devcon_matches(const struct fwnode_handle *fwnode,
 						const char *con_id, void *data,
 						devcon_match_fn_t match,
 						void **matches,
@@ -1247,7 +1247,7 @@ static unsigned int fwnode_graph_devcon_matches(struct fwnode_handle *fwnode,
 	return count;
 }
 
-static unsigned int fwnode_devcon_matches(struct fwnode_handle *fwnode,
+static unsigned int fwnode_devcon_matches(const struct fwnode_handle *fwnode,
 					  const char *con_id, void *data,
 					  devcon_match_fn_t match,
 					  void **matches,
@@ -1289,7 +1289,7 @@ static unsigned int fwnode_devcon_matches(struct fwnode_handle *fwnode,
  * device node. @match will be used to convert the connection description to
  * data the caller is expecting to be returned.
  */
-void *fwnode_connection_find_match(struct fwnode_handle *fwnode,
+void *fwnode_connection_find_match(const struct fwnode_handle *fwnode,
 				   const char *con_id, void *data,
 				   devcon_match_fn_t match)
 {
@@ -1326,7 +1326,7 @@ EXPORT_SYMBOL_GPL(fwnode_connection_find_match);
  *
  * Return: Number of matches resolved, or negative errno.
  */
-int fwnode_connection_find_matches(struct fwnode_handle *fwnode,
+int fwnode_connection_find_matches(const struct fwnode_handle *fwnode,
 				   const char *con_id, void *data,
 				   devcon_match_fn_t match,
 				   void **matches, unsigned int matches_len)
diff --git a/drivers/usb/roles/class.c b/drivers/usb/roles/class.c
index dfaed7eee94f..a3575a5a18ce 100644
--- a/drivers/usb/roles/class.c
+++ b/drivers/usb/roles/class.c
@@ -87,7 +87,7 @@ enum usb_role usb_role_switch_get_role(struct usb_role_switch *sw)
 }
 EXPORT_SYMBOL_GPL(usb_role_switch_get_role);
 
-static void *usb_role_switch_match(struct fwnode_handle *fwnode, const char *id,
+static void *usb_role_switch_match(const struct fwnode_handle *fwnode, const char *id,
 				   void *data)
 {
 	struct device *dev;
diff --git a/drivers/usb/typec/mux.c b/drivers/usb/typec/mux.c
index 464330776cd6..f81ea26ab389 100644
--- a/drivers/usb/typec/mux.c
+++ b/drivers/usb/typec/mux.c
@@ -32,8 +32,8 @@ static int switch_fwnode_match(struct device *dev, const void *fwnode)
 	return dev_fwnode(dev) == fwnode;
 }
 
-static void *typec_switch_match(struct fwnode_handle *fwnode, const char *id,
-				void *data)
+static void *typec_switch_match(const struct fwnode_handle *fwnode,
+				const char *id, void *data)
 {
 	struct device *dev;
 
@@ -262,8 +262,8 @@ static int mux_fwnode_match(struct device *dev, const void *fwnode)
 	return dev_fwnode(dev) == fwnode;
 }
 
-static void *typec_mux_match(struct fwnode_handle *fwnode, const char *id,
-			     void *data)
+static void *typec_mux_match(const struct fwnode_handle *fwnode,
+			     const char *id, void *data)
 {
 	const struct typec_altmode_desc *desc = data;
 	struct device *dev;
diff --git a/drivers/usb/typec/retimer.c b/drivers/usb/typec/retimer.c
index 2003731f1bee..8edfdc709a28 100644
--- a/drivers/usb/typec/retimer.c
+++ b/drivers/usb/typec/retimer.c
@@ -34,7 +34,7 @@ static int retimer_fwnode_match(struct device *dev, const void *fwnode)
 	return dev_fwnode(dev) == fwnode && dev_name_ends_with(dev, "-retimer");
 }
 
-static void *typec_retimer_match(struct fwnode_handle *fwnode, const char *id, void *data)
+static void *typec_retimer_match(const struct fwnode_handle *fwnode, const char *id, void *data)
 {
 	struct device *dev;
 
diff --git a/include/linux/property.h b/include/linux/property.h
index 587b5b666b5b..8d82775a901a 100644
--- a/include/linux/property.h
+++ b/include/linux/property.h
@@ -442,21 +442,21 @@ unsigned int fwnode_graph_get_endpoint_count(struct fwnode_handle *fwnode,
 int fwnode_graph_parse_endpoint(const struct fwnode_handle *fwnode,
 				struct fwnode_endpoint *endpoint);
 
-typedef void *(*devcon_match_fn_t)(struct fwnode_handle *fwnode, const char *id,
+typedef void *(*devcon_match_fn_t)(const struct fwnode_handle *fwnode, const char *id,
 				   void *data);
 
-void *fwnode_connection_find_match(struct fwnode_handle *fwnode,
+void *fwnode_connection_find_match(const struct fwnode_handle *fwnode,
 				   const char *con_id, void *data,
 				   devcon_match_fn_t match);
 
-static inline void *device_connection_find_match(struct device *dev,
+static inline void *device_connection_find_match(const struct device *dev,
 						 const char *con_id, void *data,
 						 devcon_match_fn_t match)
 {
 	return fwnode_connection_find_match(dev_fwnode(dev), con_id, data, match);
 }
 
-int fwnode_connection_find_matches(struct fwnode_handle *fwnode,
+int fwnode_connection_find_matches(const struct fwnode_handle *fwnode,
 				   const char *con_id, void *data,
 				   devcon_match_fn_t match,
 				   void **matches, unsigned int matches_len);
-- 
2.35.1

