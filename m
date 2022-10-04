Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4C2915F42EB
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Oct 2022 14:26:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229732AbiJDM0Z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Oct 2022 08:26:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37024 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229530AbiJDM0V (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Oct 2022 08:26:21 -0400
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 30880275D0;
        Tue,  4 Oct 2022 05:26:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1664886381; x=1696422381;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=pJJqXUU15EAXOIfixn38k7280kKl8im8nLZUodGU5NI=;
  b=RiN+LtR2fyMJ0TnyLcdZ9Xxd7NByGB1SWwqtgAbkp4ATaVRnvmb6jqQ9
   +3F092MND3Udhl5rhOxVETuV/4JNwAPotBQ3MxWcbMOYsIpIU9MlUEkGx
   +wFEISaq3o5XdkjexdM1SvNJ5Ad+ZOd7+FBpgQhi0g4YmF/VSTVbjAkvk
   x/Ecj1JgzbKqSiQdX4R8p8071zaQtJnh1rHVemmZwXUXvTBucP2qcIO9+
   UVLtMlMFaSGxllffZAE/9aT7SnyWa7aVh2LvDJNjXlvqv/K6ZSllt205e
   xgujZ0JT2zH54eVdmdizFKQtu55p3mY0utndJqRUJY05EuPz7jUjDxjd/
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10489"; a="300497338"
X-IronPort-AV: E=Sophos;i="5.93,157,1654585200"; 
   d="scan'208";a="300497338"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Oct 2022 05:26:20 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10489"; a="749355160"
X-IronPort-AV: E=Sophos;i="5.93,157,1654585200"; 
   d="scan'208";a="749355160"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga004.jf.intel.com with ESMTP; 04 Oct 2022 05:26:18 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 7EDF7155; Tue,  4 Oct 2022 15:26:37 +0300 (EEST)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Hans de Goede <hdegoede@redhat.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Daniel Scally <djrscally@gmail.com>,
        Mark Gross <markgross@kernel.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>, linux-acpi@vger.kernel.org
Subject: [resend, PATCH v1 1/1] platform/x86: int3472: Don't leak reference on error
Date:   Tue,  4 Oct 2022 15:26:36 +0300
Message-Id: <20221004122636.61755-1-andriy.shevchenko@linux.intel.com>
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

The for_each_acpi_consumer_dev() takes a reference to the iterator
and if we break a loop we must drop that reference. This usually
happens when error handling is involved. However it's not the case
for skl_int3472_fill_clk_pdata().

Don't leak reference on error by dropping it properly.

Fixes: 43cf36974d76 ("platform/x86: int3472: Support multiple clock consumers")
Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---

resent to include Rafael and linux-acpi@ to the Cc list

 drivers/platform/x86/intel/int3472/tps68470.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/platform/x86/intel/int3472/tps68470.c b/drivers/platform/x86/intel/int3472/tps68470.c
index f83e9c393f31..5b8d1a9620a5 100644
--- a/drivers/platform/x86/intel/int3472/tps68470.c
+++ b/drivers/platform/x86/intel/int3472/tps68470.c
@@ -128,15 +128,15 @@ skl_int3472_fill_clk_pdata(struct device *dev, struct tps68470_clk_platform_data
 	for_each_acpi_consumer_dev(adev, consumer) {
 		sensor_name = devm_kasprintf(dev, GFP_KERNEL, I2C_DEV_NAME_FORMAT,
 					     acpi_dev_name(consumer));
-		if (!sensor_name)
+		if (!sensor_name) {
+			acpi_dev_put(consumer);
 			return -ENOMEM;
+		}
 
 		(*clk_pdata)->consumers[i].consumer_dev_name = sensor_name;
 		i++;
 	}
 
-	acpi_dev_put(consumer);
-
 	return n_consumers;
 }
 
-- 
2.35.1

