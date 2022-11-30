Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9E0A363D9FE
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Nov 2022 16:55:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230009AbiK3PzE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Nov 2022 10:55:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48602 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229566AbiK3PzC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Nov 2022 10:55:02 -0500
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E8212A72C;
        Wed, 30 Nov 2022 07:55:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1669823702; x=1701359702;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=zyte05y+upKDfse9Z8XVDo9E7nJa4Ll5iv0RvnzSuUM=;
  b=OyKgCM302H4QTJYDajAlaG+QHVr0ipZL2EbhntMfrqn4riMfXgY4jCpR
   JBQEWgj6Pj/t0nOCUaHeU0eyHVUW6Wxnpp4Wwssrx34UrfJbXuUvkbEvn
   XZFhX/dkLTnpLRQ8bFEwfB3h/1fxFlcwQKMa9dkYgXO8/e5H+eGJeEguW
   USMx79sKpiuorxJsuOC7u2tcoR2HJjosqO2Buglf2EBnkvaEXh1EYxyXl
   Ip0Fk7wmq15BAC5EhP2tNFlz3bBqYsD+fAkGCBrxbPS3r0VAjNix6lxSj
   lA/dRJsSupbEfsXULWiuil0Sx3N3SlkHU8n2r07Xv/YvfYGSr9dfZygIU
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10547"; a="295126520"
X-IronPort-AV: E=Sophos;i="5.96,206,1665471600"; 
   d="scan'208";a="295126520"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Nov 2022 07:55:01 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10547"; a="707693497"
X-IronPort-AV: E=Sophos;i="5.96,206,1665471600"; 
   d="scan'208";a="707693497"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga008.fm.intel.com with ESMTP; 30 Nov 2022 07:54:59 -0800
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 015CC6A; Wed, 30 Nov 2022 17:55:25 +0200 (EET)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Marc Zyngier <maz@kernel.org>, linux-gpio@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        Jonathan Corbet <corbet@lwn.net>,
        Hans de Goede <hdegoede@redhat.com>
Subject: [PATCH v1 2/3] Documentation: gpio: Add a section on what to return in ->get() callback
Date:   Wed, 30 Nov 2022 17:55:18 +0200
Message-Id: <20221130155519.20362-2-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20221130155519.20362-1-andriy.shevchenko@linux.intel.com>
References: <20221130155519.20362-1-andriy.shevchenko@linux.intel.com>
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

The ->get() callback depending on other settings and hardware support
may return different values, while the line outside the chip is kept
in the same state. Let's discuss that in the documentation.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 Documentation/driver-api/gpio/driver.rst | 24 ++++++++++++++++++++++++
 1 file changed, 24 insertions(+)

diff --git a/Documentation/driver-api/gpio/driver.rst b/Documentation/driver-api/gpio/driver.rst
index bf6319cc531b..3d2f36001a7a 100644
--- a/Documentation/driver-api/gpio/driver.rst
+++ b/Documentation/driver-api/gpio/driver.rst
@@ -251,6 +251,30 @@ supports more versatile control over electrical properties and can handle
 different pull-up or pull-down resistance values.
 
 
+Considerations of the ->get() returned value
+--------------------------------------------
+
+Due to different possible electrical configurations and software applications
+the value that ->get() callback returns may vary depending on the other settings.
+This will allow to use pins in the I2C emulation mode or other not so standard
+uses.
+
+The below table gathered the most used cases.
+
+==========  ==========  ===============  =======================
+  Input       Output         State        What value to return?
+==========  ==========  ===============  =======================
+ Disabled    Disabled    Hi-Z             input buffer
+ Disabled    OS/OD/etc   Single ended     [cached] output buffer
+    x        Push-Pull   Out              [cached] output buffer
+ Enabled     Disabled    In               input buffer
+ Enabled     OS/OD/etc   Bidirectional    input buffer
+==========  ==========  ===============  =======================
+
+The [cached] here is used in a broader sense: either pure software cache, or
+read back value from the GPIO output buffer (not all hardware support that).
+
+
 GPIO drivers providing IRQs
 ===========================
 
-- 
2.35.1

