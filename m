Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7CFDA5EDACB
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Sep 2022 12:59:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233697AbiI1K7D (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Sep 2022 06:59:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42622 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234018AbiI1K6E (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Sep 2022 06:58:04 -0400
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 42CB7275CE;
        Wed, 28 Sep 2022 03:57:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1664362655; x=1695898655;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=o81USWJuR0ULJE6zRCKGJxkSDRJSTS9vmQtovzNmv88=;
  b=X5qhG+AAu79CPkaWPc0P3LZzqxoveutyFSjfGWpGDaFYgs0rn+ebOpra
   WFCWFasCxRUda6uvB0wi3k3YCI2wmkPvEPn9mkaX5YmSARQfz2APSFgNd
   l9iIlV4iT7Y7jOpPtu9Xesv7G3EQscIE9N+Dgwmf1S0OuHuFUCFVYulHc
   B3bahr6VHxEoAOencdL1943q/E9+yYllzj/8pyEBDlCYVWCK+E70zt79Y
   hNfcbqyTKC0O1RIWRi08qAbwkEkxYKpQUJceULOHlIrazLzIVJysDSdIX
   etr6TYK73YL2APK1DnCd03NCLBmcaZkcyaXadULgeE8nj5Lp+upPXM84G
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10483"; a="300288930"
X-IronPort-AV: E=Sophos;i="5.93,351,1654585200"; 
   d="scan'208";a="300288930"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Sep 2022 03:57:33 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10483"; a="572995040"
X-IronPort-AV: E=Sophos;i="5.93,351,1654585200"; 
   d="scan'208";a="572995040"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga003.jf.intel.com with ESMTP; 28 Sep 2022 03:57:30 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 09798235; Wed, 28 Sep 2022 13:57:49 +0300 (EEST)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Prashant Malani <pmalani@chromium.org>,
        linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-usb@vger.kernel.org
Cc:     Daniel Scally <djrscally@gmail.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>
Subject: [PATCH v2 3/5] device property: Constify parameter in fwnode_graph_is_endpoint()
Date:   Wed, 28 Sep 2022 13:57:44 +0300
Message-Id: <20220928105746.51208-4-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220928105746.51208-1-andriy.shevchenko@linux.intel.com>
References: <20220928105746.51208-1-andriy.shevchenko@linux.intel.com>
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
Acked-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>
Reviewed-by: Sakari Ailus <sakari.ailus@linux.intel.com>
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

