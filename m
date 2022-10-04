Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 611B25F3F78
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Oct 2022 11:23:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231199AbiJDJXN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Oct 2022 05:23:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38356 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230268AbiJDJWL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Oct 2022 05:22:11 -0400
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E267FAD3;
        Tue,  4 Oct 2022 02:21:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1664875285; x=1696411285;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=4CAu2GstCf6HsCtJs5EBc2bCktiy0cOLGvIt9qTNey4=;
  b=BpXwzY+DJG8JYRaFK9ywOhk5w4xHxqRgGYcyvE2odU+eDG8PrB0SbF2c
   HmiDeLxujgohw1I/5rL31LLGM9dO1MUYadaPMtBu2CdnjSBzLUxdkeU5f
   7GeeQ0yDHcUUPnMIQkcvTim44IcPzWQmEEfTs2UeMMSpPY4U4XUYmj8d9
   SiLzgkQgVa+Ve05udwHRZkMSgf0IroqCp4dM41m2ooE1MDE8fPsIEkUGH
   r6+qTC+RKN+MkysD4ePSfvsIkdW0i7Ct3FoC+6r04yGMHW4Z0prvge7+p
   N8/jzVuXxcXWN4KYTvFyYvkc6Q5ey1sZDlKwvAnfbCLrGmd9SQGba8kmw
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10489"; a="301585209"
X-IronPort-AV: E=Sophos;i="5.93,367,1654585200"; 
   d="scan'208";a="301585209"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Oct 2022 02:21:15 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10489"; a="799050982"
X-IronPort-AV: E=Sophos;i="5.93,367,1654585200"; 
   d="scan'208";a="799050982"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga005.jf.intel.com with ESMTP; 04 Oct 2022 02:21:12 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id A455C235; Tue,  4 Oct 2022 12:21:31 +0300 (EEST)
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
Subject: [PATCH v3 3/5] device property: Constify parameter in fwnode_graph_is_endpoint()
Date:   Tue,  4 Oct 2022 12:21:27 +0300
Message-Id: <20221004092129.19412-4-andriy.shevchenko@linux.intel.com>
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

Constify parameter in fwnode_graph_is_endpoint() since it doesn't
alter anything related to it.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Acked-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>
Reviewed-by: Sakari Ailus <sakari.ailus@linux.intel.com>
---
 include/linux/property.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/property.h b/include/linux/property.h
index 8d82775a901a..7abb1792044f 100644
--- a/include/linux/property.h
+++ b/include/linux/property.h
@@ -410,7 +410,7 @@ struct fwnode_handle *fwnode_graph_get_remote_port(
 struct fwnode_handle *fwnode_graph_get_remote_endpoint(
 	const struct fwnode_handle *fwnode);
 
-static inline bool fwnode_graph_is_endpoint(struct fwnode_handle *fwnode)
+static inline bool fwnode_graph_is_endpoint(const struct fwnode_handle *fwnode)
 {
 	return fwnode_property_present(fwnode, "remote-endpoint");
 }
-- 
2.35.1

