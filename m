Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 31B03657F6B
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Dec 2022 17:04:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234282AbiL1QEl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Dec 2022 11:04:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51350 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234295AbiL1QEe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Dec 2022 11:04:34 -0500
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A54719026
        for <linux-kernel@vger.kernel.org>; Wed, 28 Dec 2022 08:04:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1672243474; x=1703779474;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=dEmMhtbExLjpySrpjFytGXz3rC5stTWIszgcrj9yf9c=;
  b=NLF52opCl6nK5cEOaVy6icpPatLs0bCgZcucsbpT2nMQnsR2hnRKWS1F
   EgaUqjnIc6B7Jw0VMa7MpTiSSx+lWMtByWAQEUHHeV74ZqBznP61tyRN4
   cQyoVewqInpIFWQR5XYV6cqOE8AoSGXn1jDyIIyUNZiAHHGKQMKinHXrl
   mKaLKvE5mukWPNB6lsuLTiOLiGL/jB/m+F7pHALhXvXstIn64HB1IhCY1
   72JO7APTnf4bbzVtIB1ogOMcoylY1z8GfujCmQYAJ6NmvPh1z45jj7Ci+
   LS+5o55zkPg1Jlrm50agp3lOfRDGbT4FVUped/qrALB0K6kqO87u6e3M2
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10574"; a="318572339"
X-IronPort-AV: E=Sophos;i="5.96,281,1665471600"; 
   d="scan'208";a="318572339"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Dec 2022 08:04:33 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10574"; a="827427099"
X-IronPort-AV: E=Sophos;i="5.96,281,1665471600"; 
   d="scan'208";a="827427099"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga005.jf.intel.com with ESMTP; 28 Dec 2022 08:04:31 -0800
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 78F97F8; Wed, 28 Dec 2022 18:05:02 +0200 (EET)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-kernel@vger.kernel.org
Cc:     Tomas Winkler <tomas.winkler@intel.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Ramalingam C <ramalingam.c@intel.com>,
        Daniel Vetter <daniel.vetter@ffwll.ch>
Subject: [PATCH v1 1/1] misc/mei/hdcp: Use correct macros to initialize uuid_le
Date:   Wed, 28 Dec 2022 18:05:00 +0200
Message-Id: <20221228160500.21220-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.35.1
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

GUID_INIT() is for internal guid_t type and shouldn't be used
for the uuid_le. I.o.w. relying on the implementation details
is layering violation. Use correct macros to initialize uuid_le.

Fixes: 64e9bbdd9588 ("misc/mei/hdcp: Client driver for HDCP application")
Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/misc/mei/hdcp/mei_hdcp.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/misc/mei/hdcp/mei_hdcp.c b/drivers/misc/mei/hdcp/mei_hdcp.c
index 5a1c93a2d2f1..cc7f1169206c 100644
--- a/drivers/misc/mei/hdcp/mei_hdcp.c
+++ b/drivers/misc/mei/hdcp/mei_hdcp.c
@@ -858,8 +858,8 @@ static void mei_hdcp_remove(struct mei_cl_device *cldev)
 		dev_warn(&cldev->dev, "mei_cldev_disable() failed\n");
 }
 
-#define MEI_UUID_HDCP GUID_INIT(0xB638AB7E, 0x94E2, 0x4EA2, 0xA5, \
-				0x52, 0xD1, 0xC5, 0x4B, 0x62, 0x7F, 0x04)
+#define MEI_UUID_HDCP UUID_LE(0xB638AB7E, 0x94E2, 0x4EA2, 0xA5, \
+			      0x52, 0xD1, 0xC5, 0x4B, 0x62, 0x7F, 0x04)
 
 static const struct mei_cl_device_id mei_hdcp_tbl[] = {
 	{ .uuid = MEI_UUID_HDCP, .version = MEI_CL_VERSION_ANY },
-- 
2.35.1

