Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7BA39614E04
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Nov 2022 16:14:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231220AbiKAPOP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Nov 2022 11:14:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36728 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230442AbiKAPNz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Nov 2022 11:13:55 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B35A1F9FB;
        Tue,  1 Nov 2022 08:09:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1667315371; x=1698851371;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=ak/4T+4EA30gwIfd/EobbLy7FhELRXx6beNhV222/eY=;
  b=MjqRdx90Blmf/E8VlqBSK5+63Ko/vsPuSuOK8b07rhYzK7j4Sldql67u
   q9lzSxTJz7TEEMwyyoCO1ytVe4t93djNiV17mB7EtIZLQaq/2s2JJ/n6j
   9zXistURKbCoqyazR3vkat1bS5CCkBfD3AlbFRAjHsWzFVHqZz3yM5shL
   dyXMbvYzhesHdwD7cX8enBPsAXEauu+Sr/6k20p+P6NOU89lWRliXAtc8
   hvc1tf8J4DSx8KCGgBMlVX1ZITdu74+9ZHDNcA8xBJibS8REGF+c9q2iE
   vDXPIaX4Xn6niBaEjaScAHVZLjnLI70gEjzUvpyXSd1tkbMl7IWzbKGaa
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10518"; a="395468736"
X-IronPort-AV: E=Sophos;i="5.95,231,1661842800"; 
   d="scan'208";a="395468736"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Nov 2022 08:09:31 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10518"; a="667221091"
X-IronPort-AV: E=Sophos;i="5.95,231,1661842800"; 
   d="scan'208";a="667221091"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga001.jf.intel.com with ESMTP; 01 Nov 2022 08:09:29 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 61770D0; Tue,  1 Nov 2022 17:09:52 +0200 (EET)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Javier Martinez Canillas <javierm@redhat.com>,
        linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
Cc:     Helge Deller <deller@gmx.de>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v1 2/2] fbdev: ssd1307fb: Drop duplicate NULL checks for PWM APIs
Date:   Tue,  1 Nov 2022 17:09:47 +0200
Message-Id: <20221101150947.67377-2-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20221101150947.67377-1-andriy.shevchenko@linux.intel.com>
References: <20221101150947.67377-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-5.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

pwm_disable() and pwm_put() are NULL-aware, no need to
duplicate the check in the caller.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/video/fbdev/ssd1307fb.c | 12 ++++--------
 1 file changed, 4 insertions(+), 8 deletions(-)

diff --git a/drivers/video/fbdev/ssd1307fb.c b/drivers/video/fbdev/ssd1307fb.c
index 5c891aa00d59..046b9990d27c 100644
--- a/drivers/video/fbdev/ssd1307fb.c
+++ b/drivers/video/fbdev/ssd1307fb.c
@@ -803,10 +803,8 @@ static int ssd1307fb_probe(struct i2c_client *client)
 bl_init_error:
 	unregister_framebuffer(info);
 panel_init_error:
-	if (par->device_info->need_pwm) {
-		pwm_disable(par->pwm);
-		pwm_put(par->pwm);
-	}
+	pwm_disable(par->pwm);
+	pwm_put(par->pwm);
 regulator_enable_error:
 	if (par->vbat_reg)
 		regulator_disable(par->vbat_reg);
@@ -827,10 +825,8 @@ static void ssd1307fb_remove(struct i2c_client *client)
 	backlight_device_unregister(info->bl_dev);
 
 	unregister_framebuffer(info);
-	if (par->device_info->need_pwm) {
-		pwm_disable(par->pwm);
-		pwm_put(par->pwm);
-	}
+	pwm_disable(par->pwm);
+	pwm_put(par->pwm);
 	if (par->vbat_reg)
 		regulator_disable(par->vbat_reg);
 	fb_deferred_io_cleanup(info);
-- 
2.35.1

