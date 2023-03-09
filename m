Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 230AE6B1E1A
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Mar 2023 09:31:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229965AbjCIIbN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Mar 2023 03:31:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60884 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229717AbjCIIau (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Mar 2023 03:30:50 -0500
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 40013DE1D0;
        Thu,  9 Mar 2023 00:29:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1678350544; x=1709886544;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=iL2MAYQRyw6sIBcex3hfg5K8mlbgbGU+jM45YnmCajs=;
  b=hfxLBceDTCK2vA9przOVw4LIrvCJNxOyo17uIpeFAMPDQ2rWPsMtWUoX
   NPxohEPsE/NvNhTgAt7ZqERoaK3GMlX+Jk63ymfdKdHczDn+E7DLFnl4n
   3NUB9ph3X70MuSgIjlS/dQXQRJP/VmJ7D/XAHi0+Mp+oWORnVDtrxDHgv
   JWZ7qBYB2nWDAi6dUX/Ivx/C7jBB194BgvIiTlfszG92X0NSNd9kJWzwf
   nxmAaoXI5Kxmp+oT1owfDAU94cvWUlH8+DUY7qafwMZ9+lLpOE3Ba0baJ
   0w8u4tBDYjJhio2YpYcErZmjs06OOskzRlMRClH4V+J7IgzkXyEafuHGv
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10643"; a="316046816"
X-IronPort-AV: E=Sophos;i="5.98,245,1673942400"; 
   d="scan'208";a="316046816"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Mar 2023 00:28:52 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10643"; a="741467479"
X-IronPort-AV: E=Sophos;i="5.98,245,1673942400"; 
   d="scan'208";a="741467479"
Received: from jnikula-mobl4.fi.intel.com (HELO localhost) ([10.237.66.145])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Mar 2023 00:28:49 -0800
From:   Jani Nikula <jani.nikula@intel.com>
To:     linux-kernel@vger.kernel.org
Cc:     Jani Nikula <jani.nikula@intel.com>,
        Jean Delvare <jdelvare@suse.com>,
        Guenter Roeck <linux@roeck-us.net>, linux-hwmon@vger.kernel.org
Subject: [PATCH] hwmon: constify struct hwmon_chip_info info member harder
Date:   Thu,  9 Mar 2023 10:28:41 +0200
Message-Id: <20230309082841.400118-1-jani.nikula@intel.com>
X-Mailer: git-send-email 2.39.1
MIME-Version: 1.0
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Let the struct hwmon_chip_info info member be a pointer to a const array
of const pointers, rather than mutable array of const pointers.

Cc: Jean Delvare <jdelvare@suse.com>
Cc: Guenter Roeck <linux@roeck-us.net>
Cc: linux-hwmon@vger.kernel.org
Signed-off-by: Jani Nikula <jani.nikula@intel.com>
---
 include/linux/hwmon.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/hwmon.h b/include/linux/hwmon.h
index c1b62384b6ee..492dd27a5dd8 100644
--- a/include/linux/hwmon.h
+++ b/include/linux/hwmon.h
@@ -430,7 +430,7 @@ struct hwmon_channel_info {
  */
 struct hwmon_chip_info {
 	const struct hwmon_ops *ops;
-	const struct hwmon_channel_info **info;
+	const struct hwmon_channel_info * const *info;
 };
 
 /* hwmon_device_register() is deprecated */
-- 
2.39.1

