Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 428166BCEDB
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Mar 2023 13:00:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230255AbjCPMA4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Mar 2023 08:00:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39710 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229543AbjCPMAy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Mar 2023 08:00:54 -0400
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 436FF59C1;
        Thu, 16 Mar 2023 05:00:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1678968053; x=1710504053;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=Ocsjhp370mXJgmzlds9QF9+bkkBao99B4P43WAeuJeU=;
  b=joS2Gp4DCS4gliVyu4TrpLyNV/KQKDmC9uMNDRW2OLLPfgeBFoaxolP7
   dTc6tzb0FwhduFVjIAxko7/J5clqK61/8aHQEtgefr4d2gidP9sj++RdL
   DjjoAzvb0mZHN9i8iUKk98sNl8jKVhcYx8AZ300sco3nFkz1+/ie/HiHx
   QDhRyk9zRkZEnRilRybPGiwfgOzjKkEThlJG+tCBNLjNtsfwQHcz33xcm
   tVLzh+aZ3VF4aL0YL9HgoRmsuQ3WaYOFfx8MRDSF48Jdz1Zo9QHIhqjLm
   M8/YbiV0Ylev4KtmezA/2rF2v8Pdge9cWa1NKONNH7mQm2RN8sZyJFSne
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10650"; a="317617755"
X-IronPort-AV: E=Sophos;i="5.98,265,1673942400"; 
   d="scan'208";a="317617755"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Mar 2023 05:00:49 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10650"; a="823212876"
X-IronPort-AV: E=Sophos;i="5.98,265,1673942400"; 
   d="scan'208";a="823212876"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga001.fm.intel.com with ESMTP; 16 Mar 2023 05:00:33 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id E64DB3DD; Thu, 16 Mar 2023 14:01:17 +0200 (EET)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Rob Herring <robh@kernel.org>, linux-kernel@vger.kernel.org,
        linux-samsung-soc@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v1 1/1] regulator: s5m8767: Replace of_gpio.h with what indeed is used
Date:   Thu, 16 Mar 2023 14:01:13 +0200
Message-Id: <20230316120113.86421-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.39.2
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

of_gpio.h in this driver is solely used as a proxy to other headers.
This is incorrect usage of the of_gpio.h. Replace it .h with what
indeed is used in the code.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/regulator/s5m8767.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/regulator/s5m8767.c b/drivers/regulator/s5m8767.c
index 3122ca7de8f5..b4a699701a81 100644
--- a/drivers/regulator/s5m8767.c
+++ b/drivers/regulator/s5m8767.c
@@ -4,9 +4,10 @@
 //              http://www.samsung.com
 
 #include <linux/err.h>
-#include <linux/of_gpio.h>
+#include <linux/gpio.h>
 #include <linux/gpio/consumer.h>
 #include <linux/module.h>
+#include <linux/of.h>
 #include <linux/platform_device.h>
 #include <linux/regulator/driver.h>
 #include <linux/regulator/machine.h>
-- 
2.39.2

