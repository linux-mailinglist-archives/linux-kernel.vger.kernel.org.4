Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 64E426699B5
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Jan 2023 15:14:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241495AbjAMOO1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Jan 2023 09:14:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39746 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241899AbjAMON2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Jan 2023 09:13:28 -0500
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 71E9F13F60;
        Fri, 13 Jan 2023 06:10:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1673619048; x=1705155048;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=VszPdD8fqxRqOd/HfrnPBU0fMr/COn8/DWm99ESmAlI=;
  b=nrN1IVsbcUKkJzuLK5JiGeNfKlxRLUmOAV8LOkeMBfpPK8Qd/wF7LfnZ
   QYEauomjSyOLGZLobkIbvwq+YZeLU1u2nRdsQwB/fW6JqiqVpHHHQLGDO
   Yu31zkCC4z9UY5F4L/fO/HDIdZy7RUkrufe+CGWg+31RoI3MMsXtB7OUM
   pgYq2v3SjNhKbFFR1eQi/hGpm2v0U6SS/ozdm4t1WawJcDv2Fa8IINrYz
   P/Y/NeszM/T1zj26bxIvdCXIfb0zkY+ym1+O9KU4frMQbLDWWYQK8Vu0T
   LsXGwNS9lHXeqeIe8MSlVXxxAOEzOwNLW9nayTwFBn/RbExnd/dTqW5YP
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10589"; a="325256017"
X-IronPort-AV: E=Sophos;i="5.97,214,1669104000"; 
   d="scan'208";a="325256017"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jan 2023 06:10:47 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10589"; a="800605098"
X-IronPort-AV: E=Sophos;i="5.97,214,1669104000"; 
   d="scan'208";a="800605098"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga001.fm.intel.com with ESMTP; 13 Jan 2023 06:10:45 -0800
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id D73D8130; Fri, 13 Jan 2023 16:11:18 +0200 (EET)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Tomasz Duszynski <tomasz.duszynski@octakon.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v1 1/1] iio: chemical: scd30_core: use sysfs_emit() to instead of scnprintf()
Date:   Fri, 13 Jan 2023 16:11:17 +0200
Message-Id: <20230113141117.23353-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.39.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Follow the advice of the Documentation/filesystems/sysfs.rst and show()
should only use sysfs_emit() or sysfs_emit_at() when formatting the
value to be returned to user space.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/iio/chemical/scd30_core.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/iio/chemical/scd30_core.c b/drivers/iio/chemical/scd30_core.c
index 682fca39d14d..e0bb1dd5e790 100644
--- a/drivers/iio/chemical/scd30_core.c
+++ b/drivers/iio/chemical/scd30_core.c
@@ -354,7 +354,7 @@ static ssize_t sampling_frequency_available_show(struct device *dev, struct devi
 	ssize_t len = 0;
 
 	do {
-		len += scnprintf(buf + len, PAGE_SIZE - len, "0.%09u ", 1000000000 / i);
+		len += sysfs_emit_at(buf, len, "0.%09u ", 1000000000 / i);
 		/*
 		 * Not all values fit PAGE_SIZE buffer hence print every 6th
 		 * (each frequency differs by 6s in time domain from the
@@ -380,7 +380,7 @@ static ssize_t calibration_auto_enable_show(struct device *dev, struct device_at
 	ret = scd30_command_read(state, CMD_ASC, &val);
 	mutex_unlock(&state->lock);
 
-	return ret ?: sprintf(buf, "%d\n", val);
+	return ret ?: sysfs_emit(buf, "%d\n", val);
 }
 
 static ssize_t calibration_auto_enable_store(struct device *dev, struct device_attribute *attr,
@@ -414,7 +414,7 @@ static ssize_t calibration_forced_value_show(struct device *dev, struct device_a
 	ret = scd30_command_read(state, CMD_FRC, &val);
 	mutex_unlock(&state->lock);
 
-	return ret ?: sprintf(buf, "%d\n", val);
+	return ret ?: sysfs_emit(buf, "%d\n", val);
 }
 
 static ssize_t calibration_forced_value_store(struct device *dev, struct device_attribute *attr,
-- 
2.39.0

