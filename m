Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A754D657F83
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Dec 2022 17:05:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234335AbiL1QFi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Dec 2022 11:05:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52342 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234318AbiL1QFe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Dec 2022 11:05:34 -0500
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D54931903F
        for <linux-kernel@vger.kernel.org>; Wed, 28 Dec 2022 08:05:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1672243533; x=1703779533;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=gmmNpNznSkw/r6SrcdizqqIcuHajzhx0qiFsgSWa8gE=;
  b=IsSgNHMn+nE+B+c+K48c9CvzXZBAG+MUOMLkm/H0pIJsX3R2sqVrDXsu
   F+xKM8GVyBNhoGtWz7O/KG5MRJbQBJKg5RvaRndGTzXyVDxP4PqJ8Y9Ag
   PzAD+dsW56wmzgV1CBSXdDThdB2Tx3aZGqLR+SngVIX5AhvxLcLBpglTE
   M/axwM/9iuh8eJ1YSbiG+inoueQ8w10QGri5m+gBWH3sKIs7l7M/ih3+a
   nmUhyn0vFzSj3tFKLHB7uU2KMax1lS+nMh5WNnQeOZUon+Ceij797Wj4N
   6grMYyozPn/eSHxQsxFS4wbk27dlIKugeMH8Sz1AegXs3+hBs3fB0zJFP
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10574"; a="322874715"
X-IronPort-AV: E=Sophos;i="5.96,281,1665471600"; 
   d="scan'208";a="322874715"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Dec 2022 08:05:33 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10574"; a="683962391"
X-IronPort-AV: E=Sophos;i="5.96,281,1665471600"; 
   d="scan'208";a="683962391"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga008.jf.intel.com with ESMTP; 28 Dec 2022 08:05:31 -0800
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 80621F8; Wed, 28 Dec 2022 18:06:02 +0200 (EET)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Tomas Winkler <tomas.winkler@intel.com>,
        linux-kernel@vger.kernel.org
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Vitaly Lubart <vitaly.lubart@intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v1 1/1] mei: pxp: Use correct macros to initialize uuid_le
Date:   Wed, 28 Dec 2022 18:05:58 +0200
Message-Id: <20221228160558.21311-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.35.1
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

GUID_INIT() is for internal guid_t type and shouldn't be used
for the uuid_le. I.o.w. relying on the implementation details
is layering violation. Use correct macros to initialize uuid_le.

Fixes: c2004ce99ed7 ("mei: pxp: export pavp client to me client bus")
Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/misc/mei/pxp/mei_pxp.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/misc/mei/pxp/mei_pxp.c b/drivers/misc/mei/pxp/mei_pxp.c
index 8dd09b1722eb..7ee1fa7b1cb3 100644
--- a/drivers/misc/mei/pxp/mei_pxp.c
+++ b/drivers/misc/mei/pxp/mei_pxp.c
@@ -238,8 +238,8 @@ static void mei_pxp_remove(struct mei_cl_device *cldev)
 }
 
 /* fbf6fcf1-96cf-4e2e-a6a6-1bab8cbe36b1 : PAVP GUID*/
-#define MEI_GUID_PXP GUID_INIT(0xfbf6fcf1, 0x96cf, 0x4e2e, 0xA6, \
-			       0xa6, 0x1b, 0xab, 0x8c, 0xbe, 0x36, 0xb1)
+#define MEI_GUID_PXP UUID_LE(0xfbf6fcf1, 0x96cf, 0x4e2e, 0xA6, \
+			     0xa6, 0x1b, 0xab, 0x8c, 0xbe, 0x36, 0xb1)
 
 static struct mei_cl_device_id mei_pxp_tbl[] = {
 	{ .uuid = MEI_GUID_PXP, .version = MEI_CL_VERSION_ANY },
-- 
2.35.1

