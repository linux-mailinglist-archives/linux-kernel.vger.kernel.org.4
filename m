Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9C0017462DA
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jul 2023 20:52:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231497AbjGCSwu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Jul 2023 14:52:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33498 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231331AbjGCSwf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Jul 2023 14:52:35 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D962FE73;
        Mon,  3 Jul 2023 11:52:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1688410352; x=1719946352;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=v4C8UxsVUCeBkxMXFBixS/NWejTXhA8uVL1LjjkP2gU=;
  b=T4rsQjEyrI1fkl9P/+HgQU5+dpKBBEVcpZUVY1QEReSSDHiu6NEq2R4w
   i46jl0CPhAjLHIhnibDZgq+mCz9YI6cvoLdivPXUhTZ1vdkYAV1IHR3wG
   Rb6STXV9m+lxFnIvW9I0SXtw2vFkwv+U+FQS5QoAtLhsYgRuwA8gkiO6x
   +rOBBuR9tWbWO2qyaPHMrnXK/V/kc/ZgMyQnhVQX45Ie5lMOpCPUrH2Q2
   x25NXANe3ytRw74+bjexel2/FPUfmvl+gVyK/JCO/T1V/SSl7m6qng/TS
   BxXdbF0O4Bch7kRncsZMExUFCtTWWZM2KMCD/bJuCGvtfXxUGp8q/OiMl
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10760"; a="449322727"
X-IronPort-AV: E=Sophos;i="6.01,178,1684825200"; 
   d="scan'208";a="449322727"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Jul 2023 11:52:28 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10760"; a="831912484"
X-IronPort-AV: E=Sophos;i="6.01,178,1684825200"; 
   d="scan'208";a="831912484"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga002.fm.intel.com with ESMTP; 03 Jul 2023 11:52:26 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 8B0B5604; Mon,  3 Jul 2023 21:52:27 +0300 (EEST)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Jiri Kosina <jikos@kernel.org>,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        Andy Shevchenko <andy@kernel.org>
Subject: [PATCH v1 09/12] HID: cp2112: Use BIT() in GPIO setter and getter
Date:   Mon,  3 Jul 2023 21:52:19 +0300
Message-Id: <20230703185222.50554-10-andriy.shevchenko@linux.intel.com>
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

Use BIT() in GPIO setter and getter for the sake of consistency
with GENMASK() usage elsewhere in the driver.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/hid/hid-cp2112.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/hid/hid-cp2112.c b/drivers/hid/hid-cp2112.c
index 37ed7fc54770..2eebb2b19501 100644
--- a/drivers/hid/hid-cp2112.c
+++ b/drivers/hid/hid-cp2112.c
@@ -197,7 +197,7 @@ static int cp2112_gpio_direction_input(struct gpio_chip *chip, unsigned offset)
 		goto exit;
 	}
 
-	buf[1] &= ~(1 << offset);
+	buf[1] &= ~BIT(offset);
 	buf[2] = gpio_push_pull;
 
 	ret = hid_hw_raw_request(hdev, CP2112_GPIO_CONFIG, buf,
@@ -228,7 +228,7 @@ static void cp2112_gpio_set(struct gpio_chip *chip, unsigned offset, int value)
 
 	buf[0] = CP2112_GPIO_SET;
 	buf[1] = value ? CP2112_GPIO_ALL_GPIO_MASK : 0;
-	buf[2] = 1 << offset;
+	buf[2] = BIT(offset);
 
 	ret = hid_hw_raw_request(hdev, CP2112_GPIO_SET, buf,
 				 CP2112_GPIO_SET_LENGTH, HID_FEATURE_REPORT,
-- 
2.40.0.1.gaa8946217a0b

