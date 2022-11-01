Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8CCC1614361
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Nov 2022 03:48:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229919AbiKACrz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Oct 2022 22:47:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42236 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229832AbiKACrw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Oct 2022 22:47:52 -0400
Received: from mail-pg1-x535.google.com (mail-pg1-x535.google.com [IPv6:2607:f8b0:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B6C1517894
        for <linux-kernel@vger.kernel.org>; Mon, 31 Oct 2022 19:47:51 -0700 (PDT)
Received: by mail-pg1-x535.google.com with SMTP id q1so12282069pgl.11
        for <linux-kernel@vger.kernel.org>; Mon, 31 Oct 2022 19:47:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XGwO4GhQFCnfEGWVPRq8FBqqasnQ0/oWKbkrBe1VfIA=;
        b=mTkPZRYDYhw7QQ4scrrL39McOrmqG4T2zdd9b1wJc1nA4b4vOHpdpe2kQIBil7+LLD
         2ZRTIHbgqZo1u2pX5NK3RY9NdieoqMYh3AxjH+xsnP+X5JoUdv7ApEWQdqDJz4DNzFa+
         RX0mx/sFa46oPS5LrNP+0FUWDUjDgei/9C7J4jMn6S8MnRfvipYU+Do7DzYSDJU4SdY2
         l5//Wj1X/eibK1Pg3kEj/kryDik3M4ZOjdyIqIskK+IE2rgOMevVRB2ZyFv/OhlZE97L
         h19CJ8DsgqfSkhUIRSTuFucLbA+2+L3ZTWUZVjx9v6I4QDLMEuHXB59VWI4Ep6PsaiXi
         fQoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XGwO4GhQFCnfEGWVPRq8FBqqasnQ0/oWKbkrBe1VfIA=;
        b=WsivHhmQyhqH3x3tOq61unjGCo6GvBrD1o3B/9wPCM6joWfaFRuVAg/gcAx6nGkTkR
         PMh5WgpmBZiLUu9g4iu+z20LWJsCI6jeOYzdNwZ6M1tpJsA4CoYtV7bc0T2HN/ml6KBh
         G6uFn/4z6LVfzVPa+0DWX86AH9GPkVS2MTg63KnNnynOqOTJR4ShbfCWPLrU5qnPt369
         9zkY7+7uC7L85suxpQXlgo1Si8d9vDm1SWkLakCxFvxhHbSPm+1aPZz/jwrOpQxHB32k
         WVFZB0gWp8R+B1LFttz2vGgX+nuDOGRQRGyjrPWcWs72xGjGOs0mf7mFky+I0o8VNLfZ
         Su8g==
X-Gm-Message-State: ACrzQf1e1k5FIxLSrqr4padZMO4AjHtUNhKaBrPCsdRHT6kmM9L5erUt
        d2AzeVt0T6rl5/RSc27+Mkx9wQ==
X-Google-Smtp-Source: AMsMyM4bSE21Et48MZZyhTXTYW43mn8i8pnopd2pfokIMPIlsGH1+7KrDx+RdzUA6tPxeJw2/pX3pw==
X-Received: by 2002:a62:4c6:0:b0:55f:c739:51e0 with SMTP id 189-20020a6204c6000000b0055fc73951e0mr17184994pfe.49.1667270871297;
        Mon, 31 Oct 2022 19:47:51 -0700 (PDT)
Received: from localhost.localdomain (80.251.214.228.16clouds.com. [80.251.214.228])
        by smtp.gmail.com with ESMTPSA id y4-20020a170902ed4400b001714c36a6e7sm5079570plb.284.2022.10.31.19.47.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 31 Oct 2022 19:47:50 -0700 (PDT)
From:   Shawn Guo <shawn.guo@linaro.org>
To:     "Rafael J . Wysocki" <rafael@kernel.org>
Cc:     Kevin Hilman <khilman@kernel.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Shawn Guo <shawn.guo@linaro.org>
Subject: [PATCH v2 1/3] PM: domains: Pass generic PM noirq hooks to genpd_finish_suspend()
Date:   Tue,  1 Nov 2022 10:47:34 +0800
Message-Id: <20221101024736.1509207-2-shawn.guo@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20221101024736.1509207-1-shawn.guo@linaro.org>
References: <20221101024736.1509207-1-shawn.guo@linaro.org>
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

While argument `poweroff` works fine for genpd_finish_suspend() to handle
distinction between suspend and poweroff, it won't scale if we want to
use it for freeze as well.  Pass generic PM noirq hooks as arguments
instead, so that the function can possibly cover freeze case too.

Signed-off-by: Shawn Guo <shawn.guo@linaro.org>
---
 drivers/base/power/domain.c | 25 +++++++++++++------------
 1 file changed, 13 insertions(+), 12 deletions(-)

diff --git a/drivers/base/power/domain.c b/drivers/base/power/domain.c
index 6471b559230e..54f6b0dd35fb 100644
--- a/drivers/base/power/domain.c
+++ b/drivers/base/power/domain.c
@@ -1189,12 +1189,15 @@ static int genpd_prepare(struct device *dev)
  * genpd_finish_suspend - Completion of suspend or hibernation of device in an
  *   I/O pm domain.
  * @dev: Device to suspend.
- * @poweroff: Specifies if this is a poweroff_noirq or suspend_noirq callback.
+ * @suspend_noirq: Generic suspend_noirq callback.
+ * @resume_noirq: Generic resume_noirq callback.
  *
  * Stop the device and remove power from the domain if all devices in it have
  * been stopped.
  */
-static int genpd_finish_suspend(struct device *dev, bool poweroff)
+static int genpd_finish_suspend(struct device *dev,
+				int (*suspend_noirq)(struct device *dev),
+				int (*resume_noirq)(struct device *dev))
 {
 	struct generic_pm_domain *genpd;
 	int ret = 0;
@@ -1203,10 +1206,7 @@ static int genpd_finish_suspend(struct device *dev, bool poweroff)
 	if (IS_ERR(genpd))
 		return -EINVAL;
 
-	if (poweroff)
-		ret = pm_generic_poweroff_noirq(dev);
-	else
-		ret = pm_generic_suspend_noirq(dev);
+	ret = suspend_noirq(dev);
 	if (ret)
 		return ret;
 
@@ -1217,10 +1217,7 @@ static int genpd_finish_suspend(struct device *dev, bool poweroff)
 	    !pm_runtime_status_suspended(dev)) {
 		ret = genpd_stop_dev(genpd, dev);
 		if (ret) {
-			if (poweroff)
-				pm_generic_restore_noirq(dev);
-			else
-				pm_generic_resume_noirq(dev);
+			resume_noirq(dev);
 			return ret;
 		}
 	}
@@ -1244,7 +1241,9 @@ static int genpd_suspend_noirq(struct device *dev)
 {
 	dev_dbg(dev, "%s()\n", __func__);
 
-	return genpd_finish_suspend(dev, false);
+	return genpd_finish_suspend(dev,
+				    pm_generic_suspend_noirq,
+				    pm_generic_resume_noirq);
 }
 
 /**
@@ -1353,7 +1352,9 @@ static int genpd_poweroff_noirq(struct device *dev)
 {
 	dev_dbg(dev, "%s()\n", __func__);
 
-	return genpd_finish_suspend(dev, true);
+	return genpd_finish_suspend(dev,
+				    pm_generic_poweroff_noirq,
+				    pm_generic_restore_noirq);
 }
 
 /**
-- 
2.25.1

