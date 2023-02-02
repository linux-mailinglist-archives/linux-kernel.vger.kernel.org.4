Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3A1036880CA
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Feb 2023 15:57:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231907AbjBBO5K (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Feb 2023 09:57:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36680 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230456AbjBBO5I (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Feb 2023 09:57:08 -0500
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD3B9C150
        for <linux-kernel@vger.kernel.org>; Thu,  2 Feb 2023 06:56:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1675349801; x=1706885801;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=dGH+MnuXdnPeliogyF4d/7loFr8yDkivZc2cFA6iOrs=;
  b=A97lEMyFHSO1aOxlcGcU/Guln1a3f6Cdu9wYmD3TaL5Rrwto1EDUE8cF
   n3JxgeiqiG189PVmfj8rc+7IIXh1iRfMqcgHxRKrxndr9gvF7+wYbQdYs
   1OSr0vf33L+Ps+MQ5cnmBdToOsm8owvvfHf9hbcZt0J4QJZYP1eU62JfK
   l+5Hs2H3lJxicTrBuPLP9kjAqLgdH3ZgjUitbiYu41XyuRsnbHM8zTsFM
   u342JP11qoQeJKf93J36NQHKlBppzRYbd2hk3LAqX1Xcs9PW+8c6xMziO
   vp3FcvV97KiQDxftUk2wQ1gJaj0K1ESw4oicqtO8EpZDjjd8JrmOfbP1u
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10608"; a="308111371"
X-IronPort-AV: E=Sophos;i="5.97,267,1669104000"; 
   d="scan'208";a="308111371"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Feb 2023 06:53:50 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10608"; a="615305708"
X-IronPort-AV: E=Sophos;i="5.97,267,1669104000"; 
   d="scan'208";a="615305708"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga003.jf.intel.com with ESMTP; 02 Feb 2023 06:53:48 -0800
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 972FE337; Thu,  2 Feb 2023 16:54:25 +0200 (EET)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Daniele Ceraolo Spurio <daniele.ceraolospurio@intel.com>,
        Alexander Usyskin <alexander.usyskin@intel.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-kernel@vger.kernel.org
Cc:     Tomas Winkler <tomas.winkler@intel.com>,
        Arnd Bergmann <arnd@arndb.de>, Christoph Hellwig <hch@lst.de>
Subject: [PATCH v1 1/1] mei: Move uuid_le_cmp() to its only user
Date:   Thu,  2 Feb 2023 16:54:12 +0200
Message-Id: <20230202145412.87569-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.39.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There is only a single user of uuid_le_cmp() API, let's make it private
to that user.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/misc/mei/mei_dev.h | 5 +++++
 include/linux/uuid.h       | 5 -----
 2 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/misc/mei/mei_dev.h b/drivers/misc/mei/mei_dev.h
index 996b70a988be..895011b7a0bf 100644
--- a/drivers/misc/mei/mei_dev.h
+++ b/drivers/misc/mei/mei_dev.h
@@ -13,6 +13,11 @@
 #include <linux/mei.h>
 #include <linux/mei_cl_bus.h>
 
+static inline int uuid_le_cmp(const uuid_le u1, const uuid_le u2)
+{
+	return memcmp(&u1, &u2, sizeof(uuid_le));
+}
+
 #include "hw.h"
 #include "hbm.h"
 
diff --git a/include/linux/uuid.h b/include/linux/uuid.h
index 5be158a49e11..6b1a3efa1e0b 100644
--- a/include/linux/uuid.h
+++ b/include/linux/uuid.h
@@ -110,9 +110,4 @@ int uuid_parse(const char *uuid, uuid_t *u);
 /* MEI UUID type, don't use anywhere else */
 #include <uapi/linux/uuid.h>
 
-static inline int uuid_le_cmp(const uuid_le u1, const uuid_le u2)
-{
-	return memcmp(&u1, &u2, sizeof(uuid_le));
-}
-
 #endif
-- 
2.39.1

