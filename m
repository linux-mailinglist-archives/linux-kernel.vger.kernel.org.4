Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C0E615ECAA5
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Sep 2022 19:19:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232288AbiI0RTP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Sep 2022 13:19:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37080 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232252AbiI0RTK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Sep 2022 13:19:10 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D0EBB1CEDF7;
        Tue, 27 Sep 2022 10:19:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1664299149; x=1695835149;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=aMgoRaBq0TVWiNPoZWHgQ65c42ADW1s3CpwVh5+pSQM=;
  b=Bf1V405jOYEon5Lcvlbq1PBerbHbboZH30Og1AA2Sme+XvseLY/ILCKY
   M/2b9VsYoX4v2P4h3dbZXDNQ+Ub3E+6x8JC2Lr+Rx0zq3r2P9S04NxbRc
   nN/tyXPXEDMItnBtP0U4Bmm9pquRHOFtXFzaIZf2uASOdJ72AJMft6Yog
   tR+y3dd8fQVSuXpYjF5GVeuIl0w94SvL1kmNBid6Rkbp3EkGFLAlb75DX
   86bcKxca9fu1AtlNH6DTXOAa3qEdvg9WjhvI4g29rUlwS4xln+67AWPoq
   i1r9zC/gWleDv6+Sbzh8O0n1f4T5UPvFyIl+IpVNzx0Kg/2Y6rnPUeeoE
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10483"; a="301354942"
X-IronPort-AV: E=Sophos;i="5.93,350,1654585200"; 
   d="scan'208";a="301354942"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Sep 2022 10:19:09 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10483"; a="690071539"
X-IronPort-AV: E=Sophos;i="5.93,350,1654585200"; 
   d="scan'208";a="690071539"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga004.fm.intel.com with ESMTP; 27 Sep 2022 10:19:07 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 421707C; Tue, 27 Sep 2022 20:19:25 +0300 (EEST)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Bjorn Andersson <andersson@kernel.org>,
        Prashant Malani <pmalani@chromium.org>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v1 1/1] usb: typec: Replace custom implementation of device_match_fwnode()
Date:   Tue, 27 Sep 2022 20:19:24 +0300
Message-Id: <20220927171924.61908-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Replace custom implementation of the device_match_fwnode().

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/usb/typec/mux.c     | 4 ++--
 drivers/usb/typec/retimer.c | 2 +-
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/usb/typec/mux.c b/drivers/usb/typec/mux.c
index f81ea26ab389..c7177ddd4f12 100644
--- a/drivers/usb/typec/mux.c
+++ b/drivers/usb/typec/mux.c
@@ -29,7 +29,7 @@ static int switch_fwnode_match(struct device *dev, const void *fwnode)
 	if (!is_typec_switch_dev(dev))
 		return 0;
 
-	return dev_fwnode(dev) == fwnode;
+	return device_match_fwnode(dev, fwnode);
 }
 
 static void *typec_switch_match(const struct fwnode_handle *fwnode,
@@ -259,7 +259,7 @@ static int mux_fwnode_match(struct device *dev, const void *fwnode)
 	if (!is_typec_mux_dev(dev))
 		return 0;
 
-	return dev_fwnode(dev) == fwnode;
+	return device_match_fwnode(dev, fwnode);
 }
 
 static void *typec_mux_match(const struct fwnode_handle *fwnode,
diff --git a/drivers/usb/typec/retimer.c b/drivers/usb/typec/retimer.c
index 8edfdc709a28..8e1055783fe2 100644
--- a/drivers/usb/typec/retimer.c
+++ b/drivers/usb/typec/retimer.c
@@ -31,7 +31,7 @@ static bool dev_name_ends_with(struct device *dev, const char *suffix)
 
 static int retimer_fwnode_match(struct device *dev, const void *fwnode)
 {
-	return dev_fwnode(dev) == fwnode && dev_name_ends_with(dev, "-retimer");
+	return device_match_fwnode(dev, fwnode) && dev_name_ends_with(dev, "-retimer");
 }
 
 static void *typec_retimer_match(const struct fwnode_handle *fwnode, const char *id, void *data)
-- 
2.35.1

