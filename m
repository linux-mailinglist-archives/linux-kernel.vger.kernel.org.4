Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B5E0F69B2E5
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Feb 2023 20:15:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229683AbjBQTPc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Feb 2023 14:15:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40014 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229463AbjBQTP2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Feb 2023 14:15:28 -0500
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB7E730B04;
        Fri, 17 Feb 2023 11:15:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1676661327; x=1708197327;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=A2PvL+yxEN/Fbl/SSQNN/A76TDvMtcYbNyxqPmKYjzM=;
  b=hmGDwXcsWQSizz/OaDNBpGAOerH4/CkuyZeNNzT12QCZ8H9zmvegZFYb
   jqxf/1QDG6Na59LfD/B5T/NFO7pW/qf5MJ6fyxlldvImqmWmo/J2szJY7
   oVkB0CvIRIjt+yyNtGcVNNjT/4e16pLXGrdfoopUH/mODJwGnilNBLXIl
   pAvHmvwd25xbcNNtB11Q/sSSo+dXaYtLDRwmXjPNTJ0YBv3x8s1s2eEzw
   CAltAVBbs15UdiSaEjxtOSshLNU4HW/g1mYcOf+FpLu168lObyIwS743U
   //K9HyHdtdrbYLyS8iSXMYTJTS+vpidN5n997EtdZP3AjjobpnsZUkkJp
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10624"; a="333426452"
X-IronPort-AV: E=Sophos;i="5.97,306,1669104000"; 
   d="scan'208";a="333426452"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Feb 2023 11:15:27 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10624"; a="648172211"
X-IronPort-AV: E=Sophos;i="5.97,306,1669104000"; 
   d="scan'208";a="648172211"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga006.jf.intel.com with ESMTP; 17 Feb 2023 11:15:25 -0800
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 156281A6; Fri, 17 Feb 2023 21:16:05 +0200 (EET)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Guenter Roeck <linux@roeck-us.net>,
        Zev Weiss <zev@bewilderbeest.net>, linux-hwmon@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Jean Delvare <jdelvare@suse.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v1 1/1] hwmon: (nct6775) Drop unneeded casting and conjunction
Date:   Fri, 17 Feb 2023 21:16:00 +0200
Message-Id: <20230217191600.24837-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.39.1
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

The 64-bit result will be cut to 32-bit automatically (by compiler)
due to the type of the destination value. No need to have an explicit
casting and especially additional conjunction which does the same.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/hwmon/nct6775-platform.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/hwmon/nct6775-platform.c b/drivers/hwmon/nct6775-platform.c
index 76c6b564d7fc..7576b8ffec67 100644
--- a/drivers/hwmon/nct6775-platform.c
+++ b/drivers/hwmon/nct6775-platform.c
@@ -149,7 +149,7 @@ static int nct6775_asuswmi_evaluate_method(u32 method_id, u8 bank, u8 reg, u8 va
 		return -EIO;
 
 	if (retval)
-		*retval = (u32)result & 0xFFFFFFFF;
+		*retval = result;
 
 	return 0;
 #else
-- 
2.39.1

