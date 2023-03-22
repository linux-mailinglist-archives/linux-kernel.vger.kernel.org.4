Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 54A076C4DF5
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Mar 2023 15:39:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231604AbjCVOjc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Mar 2023 10:39:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40608 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231363AbjCVOjY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Mar 2023 10:39:24 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A5942A141
        for <linux-kernel@vger.kernel.org>; Wed, 22 Mar 2023 07:39:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1679495963; x=1711031963;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=23K7sqqOvhEB00PQYCJm2SbhNF+B/eu/uGmGRWsjPHU=;
  b=EB9yC3WMVLvQ/9aXmcV93naILOMzB4Qwh54VB3bmqf7hWgn7w1oV7IIP
   AdyAf09k03ur3jT7NVdINV5R8OVMXvUjr9IjKdiSbqyV5XzKinq5e61+r
   CCMgMllyT94xvQslWMbxsS+aMroCqUYnn3ViCkHNs6CExX7hA3zutjMxO
   e9Vs1xHfrVwiVfXkuu29LDFjpcyb9cb2M3oXoxf+4jWSnx6Px843rt4/Y
   m7K1QERUQtV50j/NRKexYJfvCeN1NsEtJ8ajlVk+TjGsOt6Kfp8sPt9pG
   NUJD2RFM8kI2Ce4s1ChHFz13Y4/DOJY7gTLovReh4yCyaCbEjiCt3zJAe
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10657"; a="327609289"
X-IronPort-AV: E=Sophos;i="5.98,282,1673942400"; 
   d="scan'208";a="327609289"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Mar 2023 07:39:22 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10657"; a="792579427"
X-IronPort-AV: E=Sophos;i="5.98,282,1673942400"; 
   d="scan'208";a="792579427"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga002.fm.intel.com with ESMTP; 22 Mar 2023 07:39:20 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id AB0C550A; Wed, 22 Mar 2023 16:40:06 +0200 (EET)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Bumwoo Lee <bw365.lee@samsung.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-kernel@vger.kernel.org
Cc:     MyungJoo Ham <myungjoo.ham@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>
Subject: [PATCH v1 03/14] extcon: Use DECLARE_BITMAP() to declare bit arrays
Date:   Wed, 22 Mar 2023 16:39:54 +0200
Message-Id: <20230322144005.40368-4-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.40.0.1.gaa8946217a0b
In-Reply-To: <20230322144005.40368-1-andriy.shevchenko@linux.intel.com>
References: <20230322144005.40368-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.4 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Bit arrays has a specific type helper for the declaration.
Use it instead of homegronw equivalent.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/extcon/extcon.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/extcon/extcon.c b/drivers/extcon/extcon.c
index 79006ab5334b..70e9755ba2bc 100644
--- a/drivers/extcon/extcon.c
+++ b/drivers/extcon/extcon.c
@@ -230,10 +230,10 @@ struct extcon_cable {
 	union extcon_property_value jack_propval[EXTCON_PROP_JACK_CNT];
 	union extcon_property_value disp_propval[EXTCON_PROP_DISP_CNT];
 
-	unsigned long usb_bits[BITS_TO_LONGS(EXTCON_PROP_USB_CNT)];
-	unsigned long chg_bits[BITS_TO_LONGS(EXTCON_PROP_CHG_CNT)];
-	unsigned long jack_bits[BITS_TO_LONGS(EXTCON_PROP_JACK_CNT)];
-	unsigned long disp_bits[BITS_TO_LONGS(EXTCON_PROP_DISP_CNT)];
+	DECLARE_BITMAP(usb_bits, EXTCON_PROP_USB_CNT);
+	DECLARE_BITMAP(chg_bits, EXTCON_PROP_CHG_CNT);
+	DECLARE_BITMAP(jack_bits, EXTCON_PROP_JACK_CNT);
+	DECLARE_BITMAP(disp_bits, EXTCON_PROP_DISP_CNT);
 };
 
 static struct class *extcon_class;
-- 
2.40.0.1.gaa8946217a0b

