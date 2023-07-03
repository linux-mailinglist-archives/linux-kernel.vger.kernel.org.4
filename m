Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E71337462D9
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jul 2023 20:52:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231481AbjGCSwr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Jul 2023 14:52:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33470 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231319AbjGCSwd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Jul 2023 14:52:33 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 81C11E71;
        Mon,  3 Jul 2023 11:52:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1688410352; x=1719946352;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=6yEDgvxJlryYWI7k71QyO6QRP75T9Vue+ghIMACgdzE=;
  b=LZJRBeTgQ0RkPPIRnxdS/0G7zd2amHq7GfSWGahuitTFSRdLJat6C6T2
   1piknSPBttTqIhs1tncusrYQF9ntGQmMlQtZla99XDvjxWEmOdyrq71FM
   cphn99f9NvOiZSx0GJ8xkGJ/97gFxNN9eqzfJaFce1ruSJCJxFqI5JkC6
   tLlIT1/px54QS7llzstL+iqt5j6abcNrWHhxpY5ai4HOq6nIV+m9vxpUm
   6xgb1mSrPyt9+eOlPT8e5cdpS/m5l7wnZDmgTOOP+aitUL+8bGn6LaNiv
   4rj6AFR+f+7ZU6HEIe/98SkTgV+iubZm/WoZ8/upa3WigZnqoNitULpKq
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10760"; a="449322737"
X-IronPort-AV: E=Sophos;i="6.01,178,1684825200"; 
   d="scan'208";a="449322737"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Jul 2023 11:52:28 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10760"; a="831912486"
X-IronPort-AV: E=Sophos;i="6.01,178,1684825200"; 
   d="scan'208";a="831912486"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga002.fm.intel.com with ESMTP; 03 Jul 2023 11:52:26 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 7902C5FC; Mon,  3 Jul 2023 21:52:27 +0300 (EEST)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Jiri Kosina <jikos@kernel.org>,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        Andy Shevchenko <andy@kernel.org>
Subject: [PATCH v1 07/12] HID: cp2112: Define maximum GPIO constant and use it
Date:   Mon,  3 Jul 2023 21:52:17 +0300
Message-Id: <20230703185222.50554-8-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.40.0.1.gaa8946217a0b
In-Reply-To: <20230703185222.50554-1-andriy.shevchenko@linux.intel.com>
References: <20230703185222.50554-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Define maximum GPIO constant and use it in the driver.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/hid/hid-cp2112.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/hid/hid-cp2112.c b/drivers/hid/hid-cp2112.c
index 45cd0d2fd3fd..c8c59d70500e 100644
--- a/drivers/hid/hid-cp2112.c
+++ b/drivers/hid/hid-cp2112.c
@@ -31,6 +31,7 @@
 #define CP2112_GPIO_CONFIG_LENGTH		5
 #define CP2112_GPIO_GET_LENGTH			2
 #define CP2112_GPIO_SET_LENGTH			3
+#define CP2112_GPIO_MAX_GPIO			8
 
 enum {
 	CP2112_GPIO_CONFIG		= 0x02,
@@ -1108,7 +1109,7 @@ static void cp2112_gpio_poll_callback(struct work_struct *work)
 		goto exit;
 
 	gpio_mask = ret;
-	for_each_set_bit(virq, &dev->irq_mask, 8) {
+	for_each_set_bit(virq, &dev->irq_mask, CP2112_GPIO_MAX_GPIO) {
 		irq = irq_find_mapping(dev->gc.irq.domain, virq);
 		if (!irq)
 			continue;
@@ -1295,7 +1296,7 @@ static int cp2112_probe(struct hid_device *hdev, const struct hid_device_id *id)
 	dev->gc.set			= cp2112_gpio_set;
 	dev->gc.get			= cp2112_gpio_get;
 	dev->gc.base			= -1;
-	dev->gc.ngpio			= 8;
+	dev->gc.ngpio			= CP2112_GPIO_MAX_GPIO;
 	dev->gc.can_sleep		= 1;
 	dev->gc.parent			= &hdev->dev;
 
-- 
2.40.0.1.gaa8946217a0b

