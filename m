Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 80A625EC604
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Sep 2022 16:28:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232165AbiI0O2Z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Sep 2022 10:28:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47328 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232311AbiI0O2N (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Sep 2022 10:28:13 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 86A6518699F;
        Tue, 27 Sep 2022 07:28:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1664288891; x=1695824891;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=OpCYS+dBiHi5I1/btU2nR0TfLX5a+7mXaU5C2OHUqa4=;
  b=iB7MXCvg2KgzUsjiB5jlwjVeEL40xvByut4d3e2R1tQ4C7uIkyrnuFpB
   C5lwHd/ue7SYvz2pzaOvGyerq7cLdUsgip5pnltilHDmJPLR229/CrEdZ
   LJfU1hRafyUNAIwK3+RIpu0RAncYM8AnbxFUirDTxM6e5+NtUoGgonVRi
   HDs8cmsayRLL3SfA+u7ZjtSLEpSAaTF0GxpKwXmzEO9UCkMNO8fbIOQGi
   sBzIwXrnGB5nx5G/IqCtoegK02OnjfmRdQJ6ZSSJfF0ir1zBk1fKhUvfL
   AYsuzkZAylQJnY+YgFHR4RN4XHszl1p4lLJk9yGsHV9OA3YxSq1jCgXJD
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10483"; a="365370927"
X-IronPort-AV: E=Sophos;i="5.93,349,1654585200"; 
   d="scan'208";a="365370927"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Sep 2022 07:28:10 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10483"; a="616845985"
X-IronPort-AV: E=Sophos;i="5.93,349,1654585200"; 
   d="scan'208";a="616845985"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga007.jf.intel.com with ESMTP; 27 Sep 2022 07:28:08 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 00B41235; Tue, 27 Sep 2022 17:28:26 +0300 (EEST)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Prashant Malani <pmalani@chromium.org>,
        linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-usb@vger.kernel.org
Cc:     Daniel Scally <djrscally@gmail.com>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>
Subject: [PATCH v1 3/5] device property: Constify parameter in fwnode_graph_is_endpoint()
Date:   Tue, 27 Sep 2022 17:28:19 +0300
Message-Id: <20220927142822.4095-3-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220927142822.4095-1-andriy.shevchenko@linux.intel.com>
References: <20220927142822.4095-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
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
---
 include/linux/property.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/property.h b/include/linux/property.h
index 6f9d6604edc3..fe440211e529 100644
--- a/include/linux/property.h
+++ b/include/linux/property.h
@@ -406,7 +406,7 @@ struct fwnode_handle *fwnode_graph_get_remote_port(
 struct fwnode_handle *fwnode_graph_get_remote_endpoint(
 	const struct fwnode_handle *fwnode);
 
-static inline bool fwnode_graph_is_endpoint(struct fwnode_handle *fwnode)
+static inline bool fwnode_graph_is_endpoint(const struct fwnode_handle *fwnode)
 {
 	return fwnode_property_present(fwnode, "remote-endpoint");
 }
-- 
2.35.1

