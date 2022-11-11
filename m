Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0C20E62619B
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Nov 2022 19:43:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234590AbiKKSng (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Nov 2022 13:43:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46542 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234074AbiKKSnN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Nov 2022 13:43:13 -0500
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F9BF10DE;
        Fri, 11 Nov 2022 10:43:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1668192192; x=1699728192;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=/5ATWhqQrc1DZJ4f0j7ZyUNBHQXbdLiioN7qk5/mljI=;
  b=V2lHhM3/8IKWBNlb/uxz6te0myWl+2emBlPmpikg4MH3zdUUQ87d8Xud
   UsGUnYCj8veQhc8eyVCkis9H7V/F7EVbBvwyuuGAuU6H4w7QoRVBGtn7V
   QawpiKLP8pQrQDxW8+F6OnThKFRZJUO6XDuSJ04HCkdA3IHrtK8iXxiUX
   YhpkbDuUOIVebCJRSGEN5o/vE5m6j6dIC5FD6Veh8SdwVbxB6OYVQONtD
   CUMDkGT8DJS1+oF7Wmja92bnWoNGpQtSI9soNYNjRMKkM3OTTgfGZ4+4J
   p5eDb9+hcvO+z+fr+I4Z2dYTN9UEhKUA7Vb7JfL+HYH/Sq4YinGdybG2N
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10528"; a="299162181"
X-IronPort-AV: E=Sophos;i="5.96,157,1665471600"; 
   d="scan'208";a="299162181"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Nov 2022 10:43:10 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10528"; a="812517791"
X-IronPort-AV: E=Sophos;i="5.96,157,1665471600"; 
   d="scan'208";a="812517791"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga005.jf.intel.com with ESMTP; 11 Nov 2022 10:43:08 -0800
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 13900B7; Fri, 11 Nov 2022 20:43:32 +0200 (EET)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>,
        Hans de Goede <hdegoede@redhat.com>,
        linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org,
        linux-pwm@vger.kernel.org
Cc:     Andy Shevchenko <andy@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>
Subject: [PATCH v3 1/6] pwm: Add a stub for devm_pwmchip_add()
Date:   Fri, 11 Nov 2022 20:43:23 +0200
Message-Id: <20221111184328.58108-2-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20221111184328.58108-1-andriy.shevchenko@linux.intel.com>
References: <20221111184328.58108-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

The devm_pwmchip_add() can be called by a module that optionally
instantiates PWM chip. In the case of CONFIG_PWM=n, the compilation
can't be performed. Hence, add a necessary stub.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Acked-by: Thierry Reding <thierry.reding@gmail.com>
Reviewed-by: Mika Westerberg <mika.westerberg@linux.intel.com>
Acked-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
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

