Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B0C365FFE8C
	for <lists+linux-kernel@lfdr.de>; Sun, 16 Oct 2022 11:58:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229719AbiJPJ6q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 16 Oct 2022 05:58:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52662 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229727AbiJPJ6m (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 16 Oct 2022 05:58:42 -0400
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com [IPv6:2607:f8b0:4864:20::1031])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 84AC42F66B
        for <linux-kernel@vger.kernel.org>; Sun, 16 Oct 2022 02:58:40 -0700 (PDT)
Received: by mail-pj1-x1031.google.com with SMTP id o9-20020a17090a0a0900b0020ad4e758b3so8519944pjo.4
        for <linux-kernel@vger.kernel.org>; Sun, 16 Oct 2022 02:58:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dGtXWioNl23rW8/5PZCxfXNs96/lCBczDCDN08pJgeE=;
        b=gZoqZQA+VejqjudxyDRZRTdLGp7mPiU4gdY/9o/1PGcLZpSUxvYUJGs3xZzf8APrPA
         ZIOu0QsWCBUzknjQPaagSvSPQj3khFXtqGAGuOAOltolU6nxckCTH98DLhVX5FjM2ZOg
         y9UwjieMFvRH+0u9uyQhdzz9ZjciIG5iqqbUqQBvMVTQ+Y7RlFLLjM4HySBx1IIMtBRm
         d5OZ39n8ce/HTThh6z8BJvr112L5v4BGIW43hX6QC0hdfYRxhVBUk8agPNH7Iy2QP19X
         WYrxSK7rRrJSuuwDDwtT9c79VKBzloVRvzlpzG0BL19CeuSS4RVYOH1qqu1lT+WNcE9K
         h2TA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dGtXWioNl23rW8/5PZCxfXNs96/lCBczDCDN08pJgeE=;
        b=2zy91G05JvK11us2f8kK3UWKi18HSmECLQkNNUIfMZaVNOmZTV2yFEWlGQlc5nnGmK
         Fgb+cWfKaRBVH4NaRPiNaVQo5zkX4CwRFozX8P2ODp2O8NP62lNqyB3Nh9DFM5sDCf1J
         75Z7WZoV5FaYpqvuoeoMss2qPzTbsNpAGwPUh0tYxRwqN2J+mXaXaRkWkqM3sUHUrCwb
         KI+kOGZvx+R0iskbzxN+wCpGvYxsIJNFMQ5FL9aPZNrw2CVYc7NbYcK/Q8BqoUuoQrLu
         1J6tfVppDmlWULO0eKs8KHObFJPmfPnuWRBL05XH7MNhex/u2AgvDXMcF+parPCf9428
         G5Dw==
X-Gm-Message-State: ACrzQf1WMDxAVE6iQQ18v4wMu75kjkVkQ8jzDu2Ky+kdHuDriraTAeVl
        Xo/768v/kCiNYO+xp+sRj51AOQ==
X-Google-Smtp-Source: AMsMyM6ojMoUiIcg7QL4r+LLc0pcPfZjxl2ex/mtdiSuPBQKTtTD7up0m8auOOHFa5nT7sTX2zVs8w==
X-Received: by 2002:a17:903:30d4:b0:184:fadd:ec27 with SMTP id s20-20020a17090330d400b00184faddec27mr6367766plc.44.1665914319981;
        Sun, 16 Oct 2022 02:58:39 -0700 (PDT)
Received: from localhost.localdomain (80.251.214.228.16clouds.com. [80.251.214.228])
        by smtp.gmail.com with ESMTPSA id c18-20020a170902d49200b001745662d568sm4481838plg.278.2022.10.16.02.58.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 16 Oct 2022 02:58:39 -0700 (PDT)
From:   Shawn Guo <shawn.guo@linaro.org>
To:     "Rafael J . Wysocki" <rafael@kernel.org>
Cc:     Kevin Hilman <khilman@kernel.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Shawn Guo <shawn.guo@linaro.org>
Subject: [PATCH 2/3] PM: domains: Consolidate genpd_restore_noirq() and genpd_resume_noirq()
Date:   Sun, 16 Oct 2022 17:58:14 +0800
Message-Id: <20221016095815.2550034-3-shawn.guo@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20221016095815.2550034-1-shawn.guo@linaro.org>
References: <20221016095815.2550034-1-shawn.guo@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Most of the logic between genpd_restore_noirq() and genpd_resume_noirq()
are same except GENPD_STATE_OFF status reset for hibernation restore.
The suspended_count decrement for restore should be the right thing to do
anyway, considering there is an increment in genpd_finish_suspend() for
hibernation.

Consolidate genpd_restore_noirq() and genpd_resume_noirq() into
genpd_finish_resume() and handle GENPD_STATE_OFF status reset for
restore case specially.

Signed-off-by: Shawn Guo <shawn.guo@linaro.org>
---
 drivers/base/power/domain.c | 70 ++++++++++++++++++-------------------
 1 file changed, 35 insertions(+), 35 deletions(-)

diff --git a/drivers/base/power/domain.c b/drivers/base/power/domain.c
index 01f5644938e0..fc0ac9e6050e 100644
--- a/drivers/base/power/domain.c
+++ b/drivers/base/power/domain.c
@@ -1247,12 +1247,14 @@ static int genpd_suspend_noirq(struct device *dev)
 }
 
 /**
- * genpd_resume_noirq - Start of resume of device in an I/O PM domain.
+ * genpd_resume_noirq - Completion of resume of device in an I/O PM domain.
  * @dev: Device to resume.
+ * @resume_noirq: Generic resume_noirq callback.
  *
  * Restore power to the device's PM domain, if necessary, and start the device.
  */
-static int genpd_resume_noirq(struct device *dev)
+static int genpd_finish_resume(struct device *dev,
+			       int (*resume_noirq)(struct device *dev))
 {
 	struct generic_pm_domain *genpd;
 	int ret;
@@ -1264,9 +1266,25 @@ static int genpd_resume_noirq(struct device *dev)
 		return -EINVAL;
 
 	if (device_wakeup_path(dev) && genpd_is_active_wakeup(genpd))
-		return pm_generic_resume_noirq(dev);
+		return resume_noirq(dev);
 
 	genpd_lock(genpd);
+
+	/*
+	 * Special handling for hibernation restore:
+	 * At this point suspended_count == 0 means we are being run for the
+	 * first time for the given domain in the present cycle.
+	 */
+	if (resume_noirq == pm_generic_restore_noirq &&
+	    genpd->suspended_count++ == 0) {
+		/*
+		 * The boot kernel might put the domain into arbitrary state,
+		 * so make it appear as powered off to genpd_sync_power_on(),
+		 * so that it tries to power it on in case it was really off.
+		 */
+		genpd->status = GENPD_STATE_OFF;
+	}
+
 	genpd_sync_power_on(genpd, true, 0);
 	genpd->suspended_count--;
 	genpd_unlock(genpd);
@@ -1281,6 +1299,19 @@ static int genpd_resume_noirq(struct device *dev)
 	return pm_generic_resume_noirq(dev);
 }
 
+/**
+ * genpd_resume_noirq - Start of resume of device in an I/O PM domain.
+ * @dev: Device to resume.
+ *
+ * Restore power to the device's PM domain, if necessary, and start the device.
+ */
+static int genpd_resume_noirq(struct device *dev)
+{
+	dev_dbg(dev, "%s()\n", __func__);
+
+	return genpd_finish_resume(dev, pm_generic_resume_noirq);
+}
+
 /**
  * genpd_freeze_noirq - Completion of freezing a device in an I/O PM domain.
  * @dev: Device to freeze.
@@ -1366,40 +1397,9 @@ static int genpd_poweroff_noirq(struct device *dev)
  */
 static int genpd_restore_noirq(struct device *dev)
 {
-	struct generic_pm_domain *genpd;
-	int ret = 0;
-
 	dev_dbg(dev, "%s()\n", __func__);
 
-	genpd = dev_to_genpd(dev);
-	if (IS_ERR(genpd))
-		return -EINVAL;
-
-	/*
-	 * At this point suspended_count == 0 means we are being run for the
-	 * first time for the given domain in the present cycle.
-	 */
-	genpd_lock(genpd);
-	if (genpd->suspended_count++ == 0) {
-		/*
-		 * The boot kernel might put the domain into arbitrary state,
-		 * so make it appear as powered off to genpd_sync_power_on(),
-		 * so that it tries to power it on in case it was really off.
-		 */
-		genpd->status = GENPD_STATE_OFF;
-	}
-
-	genpd_sync_power_on(genpd, true, 0);
-	genpd_unlock(genpd);
-
-	if (genpd->dev_ops.stop && genpd->dev_ops.start &&
-	    !pm_runtime_status_suspended(dev)) {
-		ret = genpd_start_dev(genpd, dev);
-		if (ret)
-			return ret;
-	}
-
-	return pm_generic_restore_noirq(dev);
+	return genpd_finish_resume(dev, pm_generic_restore_noirq);
 }
 
 /**
-- 
2.25.1

