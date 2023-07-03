Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B9FE07462DC
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jul 2023 20:52:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231523AbjGCSwy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Jul 2023 14:52:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33506 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231341AbjGCSwf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Jul 2023 14:52:35 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DAA2FE7C;
        Mon,  3 Jul 2023 11:52:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1688410353; x=1719946353;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=LCgdVKzpcSaOUGJnyo5Kogm8rdwSx8t88vdpkdS1kM4=;
  b=dtjfJBOBx6zqL1e/DIRNxWjFlJpFgl/Gi4Hsfi0WysZWokYHGqTZuo2o
   4zohCAAYJbPzldziHBB8VUVece5TMCaOHSBSvFuRfVPbrfcEdDP5g6+14
   wv1WbdyK8ltBJIKAUW93d+HFJWgcLiLqp9fKAeTRNeYoHz6xCeMUgyTSj
   qikZ4+0jLOcKzuoVGBL3xZiBpgZeG+qsp9yg3oIS3RCe86AQuMzAflVx4
   AvuUUZxqsaUH+yxnbYu+dkOUQnEidyjmgQYfG8kcgCQ+g2X4GYnhA//AQ
   EwOCJx+9nHp2zBp1XVz21zwlH0HzCOSFphrqoaTiX7YT9Vj6PLXI8mRhe
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10760"; a="449322731"
X-IronPort-AV: E=Sophos;i="6.01,178,1684825200"; 
   d="scan'208";a="449322731"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Jul 2023 11:52:28 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10760"; a="831912485"
X-IronPort-AV: E=Sophos;i="6.01,178,1684825200"; 
   d="scan'208";a="831912485"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga002.fm.intel.com with ESMTP; 03 Jul 2023 11:52:26 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 8007D22B; Mon,  3 Jul 2023 21:52:27 +0300 (EEST)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Jiri Kosina <jikos@kernel.org>,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        Andy Shevchenko <andy@kernel.org>
Subject: [PATCH v1 08/12] HID: cp2112: Define all GPIO mask and use it
Date:   Mon,  3 Jul 2023 21:52:18 +0300
Message-Id: <20230703185222.50554-9-andriy.shevchenko@linux.intel.com>
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

Define all GPIO mask and use it in the driver.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/hid/hid-cp2112.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/hid/hid-cp2112.c b/drivers/hid/hid-cp2112.c
index c8c59d70500e..37ed7fc54770 100644
--- a/drivers/hid/hid-cp2112.c
+++ b/drivers/hid/hid-cp2112.c
@@ -32,6 +32,7 @@
 #define CP2112_GPIO_GET_LENGTH			2
 #define CP2112_GPIO_SET_LENGTH			3
 #define CP2112_GPIO_MAX_GPIO			8
+#define CP2112_GPIO_ALL_GPIO_MASK		GENMASK(7, 0)
 
 enum {
 	CP2112_GPIO_CONFIG		= 0x02,
@@ -173,7 +174,7 @@ struct cp2112_device {
 	u8 gpio_prev_state;
 };
 
-static int gpio_push_pull = 0xFF;
+static int gpio_push_pull = CP2112_GPIO_ALL_GPIO_MASK;
 module_param(gpio_push_pull, int, S_IRUGO | S_IWUSR);
 MODULE_PARM_DESC(gpio_push_pull, "GPIO push-pull configuration bitmask");
 
@@ -226,7 +227,7 @@ static void cp2112_gpio_set(struct gpio_chip *chip, unsigned offset, int value)
 	mutex_lock(&dev->lock);
 
 	buf[0] = CP2112_GPIO_SET;
-	buf[1] = value ? 0xff : 0;
+	buf[1] = value ? CP2112_GPIO_ALL_GPIO_MASK : 0;
 	buf[2] = 1 << offset;
 
 	ret = hid_hw_raw_request(hdev, CP2112_GPIO_SET, buf,
-- 
2.40.0.1.gaa8946217a0b

