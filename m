Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 59C9E5EC6D3
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Sep 2022 16:50:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233170AbiI0Otz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Sep 2022 10:49:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50890 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233020AbiI0OtZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Sep 2022 10:49:25 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C9C4BE55;
        Tue, 27 Sep 2022 07:47:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1664290030; x=1695826030;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=yhCoL4NMGpCkjP32gpd2ogKTy8YOiYwsmniOoIAILvY=;
  b=YfDiz34iCsVhtr0pegSTL7X6AqeD2R8yKTjz4sZOLUFS/HyIvNufeTeG
   l6gr+gW1md4LXPTc+mQGJN5qp/hAF7OZNPo+K1Ns+jR2uPCKf4mwwbvOm
   HBuNfxKJyBLbSxk5msTvUVSePHOPflffxyO8sgtmAZ/bVYSvOnC5oT5gv
   Sx+VY0+6AYgucr6tb39NVGgPluv8hKzNjzz7drR42m6rAFdLRcZwaHtOw
   bPs6/fRBzB4jiI5WZ2kstxxNz9gaWbiLy7EMKNC3ititLqlwcir7OID2m
   AfuCWxYWT8NZiq3af6nb1ROAk9at6W3TV/nGLia9YtAZQAyrEdY9LtI4E
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10483"; a="387621582"
X-IronPort-AV: E=Sophos;i="5.93,349,1654585200"; 
   d="scan'208";a="387621582"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Sep 2022 07:47:10 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10483"; a="684015492"
X-IronPort-AV: E=Sophos;i="5.93,349,1654585200"; 
   d="scan'208";a="684015492"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga008.fm.intel.com with ESMTP; 27 Sep 2022 07:47:08 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id A7FA7235; Tue, 27 Sep 2022 17:47:27 +0300 (EEST)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>,
        Hans de Goede <hdegoede@redhat.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-pwm@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Thierry Reding <thierry.reding@gmail.com>
Subject: [PATCH v3 4/8] pwm: lpss: Include headers we are direct user of
Date:   Tue, 27 Sep 2022 17:47:19 +0300
Message-Id: <20220927144723.9655-5-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220927144723.9655-1-andriy.shevchenko@linux.intel.com>
References: <20220927144723.9655-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

For the sake of integrity, include headers we are direct user of.

While at it, add missed struct pwm_lpss_boardinfo one and replace
device.h with a forward declaration. The latter improves compile
time due to reducing overhead of device.h parsing with entire train
of dependencies.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Reviewed-by: Hans de Goede <hdegoede@redhat.com>
---
 drivers/pwm/pwm-lpss.h | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/pwm/pwm-lpss.h b/drivers/pwm/pwm-lpss.h
index c344921b2cab..839622964b2a 100644
--- a/drivers/pwm/pwm-lpss.h
+++ b/drivers/pwm/pwm-lpss.h
@@ -10,11 +10,15 @@
 #ifndef __PWM_LPSS_H
 #define __PWM_LPSS_H
 
-#include <linux/device.h>
 #include <linux/pwm.h>
+#include <linux/types.h>
 
 #define MAX_PWMS			4
 
+struct device;
+
+struct pwm_lpss_boardinfo;
+
 struct pwm_lpss_chip {
 	struct pwm_chip chip;
 	void __iomem *regs;
-- 
2.35.1

