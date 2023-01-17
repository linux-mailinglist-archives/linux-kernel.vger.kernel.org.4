Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 90B8E66E1F8
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Jan 2023 16:21:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231249AbjAQPVF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Jan 2023 10:21:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56164 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229667AbjAQPUw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Jan 2023 10:20:52 -0500
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0739238B5C;
        Tue, 17 Jan 2023 07:20:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1673968851; x=1705504851;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=fb+JWaRsNaPsvs8byFrWAP3CvcWmfiGFTmjbdAEmXcs=;
  b=hriRGm090/+KkXHvlTsyZhi6TlhliVD5ko8pdMN/S8CCaDp+rtVLxi0E
   Oswg4hKC/uFZ3tVL1KWd82izqR3ipZ1I0aDXJcP/WTmqsygeFRNb3h0h1
   ez2L6DrmacUhdeyMpy1mSt8xW25Mr2VSOMPGHQMgbpJu7kCFv1WlDTALV
   j/9z3c9feCIFjKCoLbAqUnHa6ulDlcXJ+KrWXpySkxp/RshK74hQaWw4r
   0PNRriTYHCCbxeLFF3nCt4hRQkE20MhG2anGz+G4SI7PYEgdp+37ObWmZ
   pHlG4tz+KrGFeRQBN2xpM345QmvsT9HLkl4+9lX8l/GPimZdKnnfukCrq
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10592"; a="326788583"
X-IronPort-AV: E=Sophos;i="5.97,224,1669104000"; 
   d="scan'208";a="326788583"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Jan 2023 07:20:50 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10592"; a="652575089"
X-IronPort-AV: E=Sophos;i="5.97,224,1669104000"; 
   d="scan'208";a="652575089"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga007.jf.intel.com with ESMTP; 17 Jan 2023 07:20:48 -0800
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id B3B84E1; Tue, 17 Jan 2023 17:21:22 +0200 (EET)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Daniel Scally <djrscally@gmail.com>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Sakari Ailus <sakari.ailus@linux.intel.com>
Subject: [PATCH v1 1/1] device property: Make fwnode_graph_for_each_endpoint() consistent
Date:   Tue, 17 Jan 2023 17:21:20 +0200
Message-Id: <20230117152120.42531-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.39.0
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

Make fwnode_graph_for_each_endpoint() consistent with the rest of
for_each_*() definitions in the file, i.e. use the form of

	for (iter = func(NULL); iter; \
	     iter = func(iter))

as it's done in all the rest of the similar macro definitions.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 include/linux/property.h | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/include/linux/property.h b/include/linux/property.h
index 37179e3abad5..f090419818a2 100644
--- a/include/linux/property.h
+++ b/include/linux/property.h
@@ -436,9 +436,9 @@ fwnode_graph_get_endpoint_by_id(const struct fwnode_handle *fwnode,
 unsigned int fwnode_graph_get_endpoint_count(struct fwnode_handle *fwnode,
 					     unsigned long flags);
 
-#define fwnode_graph_for_each_endpoint(fwnode, child)			\
-	for (child = NULL;						\
-	     (child = fwnode_graph_get_next_endpoint(fwnode, child)); )
+#define fwnode_graph_for_each_endpoint(fwnode, child)				\
+	for (child = fwnode_graph_get_next_endpoint(fwnode, NULL); child;	\
+	     child = fwnode_graph_get_next_endpoint(fwnode, child))
 
 int fwnode_graph_parse_endpoint(const struct fwnode_handle *fwnode,
 				struct fwnode_endpoint *endpoint);
-- 
2.39.0

