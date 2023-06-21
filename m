Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 142BE738B55
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Jun 2023 18:33:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232593AbjFUQcw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Jun 2023 12:32:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55766 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232569AbjFUQcm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Jun 2023 12:32:42 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8DD921FDE;
        Wed, 21 Jun 2023 09:32:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1687365136; x=1718901136;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=qEW30dA8vNljkBwgQRkbrY35GTPiA1yzYfQCe6lh49w=;
  b=BSkgChcp5DOYTBMx4kjiRp3F0X9FoUR3OaqCsA5kUjpgOY9f57Hc/4kG
   zgXQ7n1TwC57aHE0Byy5emocaS0qCOyRVq9cxJSCb0TJBd/8i8v6A7rZ0
   JzkbU+pAU18xH7IyI16KwxRCvjLlE05LrjVmRNWlfEE2akHiAApviaERG
   PSg60C7xpnG5RuLGou9N6RgaEy/OyJ6PeoJFRrYc9om1vgauL+851wmj9
   p6OP2nwqDZyKkNrkizw3JrRXGqmBw162L9/CTY+nr0eNTM1bUUDnX8dUn
   9rn2+tak+awNZxBX8aNYERdiw3FFQcFqSIaGVh7DnQbA/8hkWQz5Ry3z1
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10748"; a="360241879"
X-IronPort-AV: E=Sophos;i="6.00,261,1681196400"; 
   d="scan'208";a="360241879"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Jun 2023 09:31:16 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10748"; a="744232664"
X-IronPort-AV: E=Sophos;i="6.00,261,1681196400"; 
   d="scan'208";a="744232664"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga008.jf.intel.com with ESMTP; 21 Jun 2023 09:31:14 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 853711FD; Wed, 21 Jun 2023 19:31:24 +0300 (EEST)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Heikki Krogerus <heikki.krogerus@linux.intel.com>
Subject: [PATCH v1 1/1] usb: ulpi: Make container_of() no-op in to_ulpi_dev()
Date:   Wed, 21 Jun 2023 19:31:22 +0300
Message-Id: <20230621163122.5693-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.40.0.1.gaa8946217a0b
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Move embedded struct device member to make container_of() noop

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 include/linux/ulpi/driver.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/ulpi/driver.h b/include/linux/ulpi/driver.h
index c7a1810373e3..a8cb617a3028 100644
--- a/include/linux/ulpi/driver.h
+++ b/include/linux/ulpi/driver.h
@@ -15,9 +15,9 @@ struct ulpi_ops;
  * @dev: device interface
  */
 struct ulpi {
+	struct device dev;
 	struct ulpi_device_id id;
 	const struct ulpi_ops *ops;
-	struct device dev;
 };
 
 #define to_ulpi_dev(d) container_of(d, struct ulpi, dev)
-- 
2.40.0.1.gaa8946217a0b

