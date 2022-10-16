Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F02F85FFE8E
	for <lists+linux-kernel@lfdr.de>; Sun, 16 Oct 2022 11:58:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229745AbiJPJ6z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 16 Oct 2022 05:58:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52666 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229712AbiJPJ6q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 16 Oct 2022 05:58:46 -0400
Received: from mail-pf1-x433.google.com (mail-pf1-x433.google.com [IPv6:2607:f8b0:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A77336DDA
        for <linux-kernel@vger.kernel.org>; Sun, 16 Oct 2022 02:58:44 -0700 (PDT)
Received: by mail-pf1-x433.google.com with SMTP id 67so8675740pfz.12
        for <linux-kernel@vger.kernel.org>; Sun, 16 Oct 2022 02:58:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=apttPogZPuWSTkpcshSvusTStupOpIbnisKrYu+q1ls=;
        b=qt8x47++WeLGlR1rL/oqJJ25Q0JgsCvq6siuhsG98podW+UGqu2ZlP2SzLF+MoEvct
         cOIUaa3Cninhl65CPH3oT/WsflP6LN63T7AnJE5ShFdAwYqvtHWmPUlWEqHH2q+QYMV2
         vW3ZO4+xBoEvxlEoB430Xi3X6ooC1tc3us3781R3vjBgIPSzP/1sZGQXK0iqCHOI+rkY
         H5fxh38aacsI2JbDQ+yCdTnr0QrepPiaTp2ZRdo7LKsUGQdU/dDGFZW/vnGKkpLftblx
         Pq1nFUsEPWQyfHxA49zQd5TqWnYiaT2rw3WdS+7tZZ7WPyFR+rIGsVWRInLqpdkqm3EW
         WW5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=apttPogZPuWSTkpcshSvusTStupOpIbnisKrYu+q1ls=;
        b=DcLoTQJ6E2pjrK6WHeqKNkuOYu27MQEZHyla8OlfFjWHFDNql1pWM3B5VmTHJxWBBV
         Vr7RxsxRGKwvtZWil9M3cg7CE+AhcnjD0qjXaupbkmV3BzlAAFrMP+ufSB3fO2Hu1/dd
         NHUvzlUO8k7zdEt6Q5AQkH643jKM/trjNPdsE5zV1LsnNpMs6Ve2zzl8uOI7yPsbynWj
         XsH0AFlF1NNRVLLDo+TCiOr9SeXdpwnsatrYlXHodVVHYcC7Yd937fosyTwKF5T798xs
         DFX5cvIHEnFtOkll2uzZFjAPuhlhT2y72LgsKPLjoNxAQkEzAqtPNDrqydnoy+sOf1ec
         +o7g==
X-Gm-Message-State: ACrzQf06KXh665fkAh8rUD+vDGqYaZ/dgh3dF6J1pM3gNbNdDJQKFd1Q
        S1QdXrUP63r+x8wPj99ci6v94Q==
X-Google-Smtp-Source: AMsMyM4gvisI7aGA7JEPGiecuP1jgx0ISyLNihnFwAA6f/3j8BPT9SWUt4f8UgD/ylogFU9RqmW0Vg==
X-Received: by 2002:a63:1e5a:0:b0:43c:b966:e2d6 with SMTP id p26-20020a631e5a000000b0043cb966e2d6mr5722678pgm.569.1665914323414;
        Sun, 16 Oct 2022 02:58:43 -0700 (PDT)
Received: from localhost.localdomain (80.251.214.228.16clouds.com. [80.251.214.228])
        by smtp.gmail.com with ESMTPSA id c18-20020a170902d49200b001745662d568sm4481838plg.278.2022.10.16.02.58.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 16 Oct 2022 02:58:42 -0700 (PDT)
From:   Shawn Guo <shawn.guo@linaro.org>
To:     "Rafael J . Wysocki" <rafael@kernel.org>
Cc:     Kevin Hilman <khilman@kernel.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Shawn Guo <shawn.guo@linaro.org>
Subject: [PATCH 3/3] PM: domains: Power off[on] domain in hibernate .freeze[thaw]_noirq hook
Date:   Sun, 16 Oct 2022 17:58:15 +0800
Message-Id: <20221016095815.2550034-4-shawn.guo@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20221016095815.2550034-1-shawn.guo@linaro.org>
References: <20221016095815.2550034-1-shawn.guo@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On platforms which use SHUTDOWN as hibernation mode, the genpd noirq
hooks will be called like below.

    genpd_freeze_noirq()         genpd_restore_noirq()
          ↓                            ↑
    Create snapshot image        Restore system
          ↓                            ↑
    genpd_thaw_noirq()           Read snapshot image
          ↓                            ↑
    Write snapshot image         Kernel boot
          ↓                            ↑
    power_down()                 Power on device

As of today suspend hooks genpd_suspend[resume]_noirq() manages domain
on/off state, but hibernate hooks genpd_freeze[thaw]_noirq() doesn't.
This results in a different behavior of domain power state between suspend
and hibernate freeze, i.e. domain is powered off for the former while on
for the later.  It causes a problem on platforms like i.MX where the
domain needs to be powered on/off by calling clock and regulator interface.
When the platform restores from hibernation, the domain is off in hardware
and genpd_restore_noirq() tries to power it on, but will never succeed
because software state of domain (clock and regulator) is left on from the
last hibernate freeze, so kernel thinks that clock and regulator are
enabled while they are actually not turned on in hardware.  The
consequence would be that devices in the power domain will access
registers without clock or power, and cause hardware lockup.

Power off[on] domain in hibernate .freeze[thaw]_noirq hook for reasons:

- Align the behavior between suspend and hibernate freeze.
- Have power state of domains stay in sync between hardware and software
  for hibernate freeze, and thus fix the lockup issue seen on i.MX power
  platform.

Signed-off-by: Shawn Guo <shawn.guo@linaro.org>
---
 drivers/base/power/domain.c | 35 ++++-------------------------------
 1 file changed, 4 insertions(+), 31 deletions(-)

diff --git a/drivers/base/power/domain.c b/drivers/base/power/domain.c
index fc0ac9e6050e..2497a43737e0 100644
--- a/drivers/base/power/domain.c
+++ b/drivers/base/power/domain.c
@@ -1323,24 +1323,11 @@ static int genpd_resume_noirq(struct device *dev)
  */
 static int genpd_freeze_noirq(struct device *dev)
 {
-	const struct generic_pm_domain *genpd;
-	int ret = 0;
-
 	dev_dbg(dev, "%s()\n", __func__);
 
-	genpd = dev_to_genpd(dev);
-	if (IS_ERR(genpd))
-		return -EINVAL;
-
-	ret = pm_generic_freeze_noirq(dev);
-	if (ret)
-		return ret;
-
-	if (genpd->dev_ops.stop && genpd->dev_ops.start &&
-	    !pm_runtime_status_suspended(dev))
-		ret = genpd_stop_dev(genpd, dev);
-
-	return ret;
+	return genpd_finish_suspend(dev,
+				    pm_generic_freeze_noirq,
+				    pm_generic_thaw_noirq);
 }
 
 /**
@@ -1352,23 +1339,9 @@ static int genpd_freeze_noirq(struct device *dev)
  */
 static int genpd_thaw_noirq(struct device *dev)
 {
-	const struct generic_pm_domain *genpd;
-	int ret = 0;
-
 	dev_dbg(dev, "%s()\n", __func__);
 
-	genpd = dev_to_genpd(dev);
-	if (IS_ERR(genpd))
-		return -EINVAL;
-
-	if (genpd->dev_ops.stop && genpd->dev_ops.start &&
-	    !pm_runtime_status_suspended(dev)) {
-		ret = genpd_start_dev(genpd, dev);
-		if (ret)
-			return ret;
-	}
-
-	return pm_generic_thaw_noirq(dev);
+	return genpd_finish_resume(dev, pm_generic_thaw_noirq);
 }
 
 /**
-- 
2.25.1

