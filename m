Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 027416ACE97
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Mar 2023 20:56:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229653AbjCFTzz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Mar 2023 14:55:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57232 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230163AbjCFTzk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Mar 2023 14:55:40 -0500
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA65256522;
        Mon,  6 Mar 2023 11:55:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1678132539; x=1709668539;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=kqgmkF6/LXf8ZTPjacKEJCrkdjdR/gKDvDdM5DRJJDo=;
  b=M8oDdntv+9UpQtYk5qzoJH7JFWjdMGIAbklgz13ZXpmCoKTW7YSLPwcO
   jsEetOsNV35aA0aIoQTMSqX56fHK5j7AKKUvMZjoH/ji/30rUQUgtVexm
   l//OVMAuJIXLy2FdThuKuIvUH9GIwOGCOXVh2cX3ejQmkJfMJcaLiiBl3
   Pa6dEreOcBtPOGtl3UMg+VYjVhe7AsXTdnOI4CwEr7fELSXsiCZmh6bwM
   Dm1/vfULvwGHGnXvaybyq03aWecIGf8XnK6HDKl0qyymYy9ReUGwYNdvw
   aDny+kmEL+kPzCpYIKFxCxP6FM0VlixffyVQazILUVm7NSwh8H+I9wWKH
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10641"; a="398240771"
X-IronPort-AV: E=Sophos;i="5.98,238,1673942400"; 
   d="scan'208";a="398240771"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Mar 2023 11:55:35 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10641"; a="819423553"
X-IronPort-AV: E=Sophos;i="5.98,238,1673942400"; 
   d="scan'208";a="819423553"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga001.fm.intel.com with ESMTP; 06 Mar 2023 11:55:28 -0800
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 61EF6367; Mon,  6 Mar 2023 21:56:12 +0200 (EET)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Schspa Shi <schspa@gmail.com>, Marc Zyngier <maz@kernel.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-pwm@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        patches@opensource.cirrus.com
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Doug Berger <opendmb@gmail.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Broadcom internal kernel review list 
        <bcm-kernel-feedback-list@broadcom.com>,
        Andy Shevchenko <andy@kernel.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Kuppuswamy Sathyanarayanan 
        <sathyanarayanan.kuppuswamy@linux.intel.com>,
        Nandor Han <nandor.han@ge.com>,
        Semi Malinen <semi.malinen@ge.com>
Subject: [PATCH v1 03/16] lib/string_choices: Add str_high_low() helper
Date:   Mon,  6 Mar 2023 21:55:43 +0200
Message-Id: <20230306195556.55475-4-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20230306195556.55475-1-andriy.shevchenko@linux.intel.com>
References: <20230306195556.55475-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add str_high_low() helper to return 'high' or 'low' string literal.
Also add an inversed variant, i.e. str_low_high().

All the same for str_hi_low().

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 include/linux/string_choices.h | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/include/linux/string_choices.h b/include/linux/string_choices.h
index b7e7b9fd098c..48120222b9b2 100644
--- a/include/linux/string_choices.h
+++ b/include/linux/string_choices.h
@@ -14,6 +14,18 @@ static inline const char *str_enabled_disabled(bool v)
 	return v ? "enabled" : "disabled";
 }
 
+static inline const char *str_hi_lo(bool v)
+{
+	return v ? "hi" : "lo";
+}
+#define str_lo_hi(v)		str_hi_lo(!(v))
+
+static inline const char *str_high_low(bool v)
+{
+	return v ? "high" : "low";
+}
+#define str_low_high(v)		str_high_low(!(v))
+
 static inline const char *str_read_write(bool v)
 {
 	return v ? "read" : "write";
-- 
2.39.1

