Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D9A5E614EB4
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Nov 2022 16:56:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231571AbiKAP4r (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Nov 2022 11:56:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36538 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229981AbiKAP4a (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Nov 2022 11:56:30 -0400
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F8FC381;
        Tue,  1 Nov 2022 08:56:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1667318189; x=1698854189;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=32rEyVNWT8FR+vish5GvE6UoII8LYbwmJ5c2195UtCk=;
  b=bdpLUrip82BJsF3anrXGwC8D1ZBmXmi7RpvMpHv89WkaopcdjBnnPppH
   MfqzuLKD8f2lSvHY2zAE454XvJgQ6zLNUNQQ5pXd4DCM6Q14vgmpISCEz
   gMwhyGAWYTJAFxyoz5+Hb4ema0EicsvyTMfFyntGQl9WAFBx1qbRn1s79
   5SLeNZMQzu/mtplADnNLBuk03+P3mg5CjQskeHbZTWJQ4A7SA2Dq9/oSi
   n9OnqaEFqD4Q6NUYuOWbQDNGbqWelPQF5uhLhvZ3LaSGFcMrR7q9+APqB
   4XC+SVtDszCmXYRW/VyQHO59s33qaCXX3zezvkOUHMxRmGwy/NaBTKcUE
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10518"; a="292474808"
X-IronPort-AV: E=Sophos;i="5.95,231,1661842800"; 
   d="scan'208";a="292474808"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Nov 2022 08:56:27 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10518"; a="776537915"
X-IronPort-AV: E=Sophos;i="5.95,231,1661842800"; 
   d="scan'208";a="776537915"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga001.fm.intel.com with ESMTP; 01 Nov 2022 08:56:24 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 6A44BD0; Tue,  1 Nov 2022 17:56:47 +0200 (EET)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Hans de Goede <hdegoede@redhat.com>,
        =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>,
        Thierry Reding <thierry.reding@gmail.com>,
        linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org,
        linux-pwm@vger.kernel.org
Cc:     Mika Westerberg <mika.westerberg@linux.intel.com>,
        Andy Shevchenko <andy@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>
Subject: [PATCH v1 1/6] pwm: Add a stub for devm_pwmchip_add()
Date:   Tue,  1 Nov 2022 17:56:37 +0200
Message-Id: <20221101155642.52575-2-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20221101155642.52575-1-andriy.shevchenko@linux.intel.com>
References: <20221101155642.52575-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

devm_pwmchip_add() can be called by a module that optionally
instantiates PWM chip. In case of CONFIG_PWM=n, the compilation
can't be performed. Hence, add a necessary stub.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 include/linux/pwm.h | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/include/linux/pwm.h b/include/linux/pwm.h
index d70c6e5a839d..bba492eea96c 100644
--- a/include/linux/pwm.h
+++ b/include/linux/pwm.h
@@ -478,6 +478,11 @@ static inline int pwmchip_remove(struct pwm_chip *chip)
 	return -EINVAL;
 }
 
+static inline int devm_pwmchip_add(struct device *dev, struct pwm_chip *chip)
+{
+	return -EINVAL;
+}
+
 static inline struct pwm_device *pwm_request_from_chip(struct pwm_chip *chip,
 						       unsigned int index,
 						       const char *label)
-- 
2.35.1

