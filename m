Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A4F52614365
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Nov 2022 03:48:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229952AbiKACsG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Oct 2022 22:48:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42354 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229934AbiKACr7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Oct 2022 22:47:59 -0400
Received: from mail-pf1-x42c.google.com (mail-pf1-x42c.google.com [IPv6:2607:f8b0:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD31517A98
        for <linux-kernel@vger.kernel.org>; Mon, 31 Oct 2022 19:47:58 -0700 (PDT)
Received: by mail-pf1-x42c.google.com with SMTP id i3so12291270pfc.11
        for <linux-kernel@vger.kernel.org>; Mon, 31 Oct 2022 19:47:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YzzxAfsdgRp0sBb+mu0K+QG/OOHcPzTsEjXihYPQFME=;
        b=nFJQRNfBcSfuRnyWTPD2PqIVAOVoYK8UwR3GpVyEu2Kt7VviKDzvwPmdC4oda5tXZ2
         bkA+kGHYv3NlC4q4ZHPDUbPSbh6JNnrUCT1mB2s6tZ9C8gFT7fd/oKUen8GU1TFH76ay
         VJzUmhUvN+OlpOq9PZ8uAuBZLra85nD1jHX5WwHREw4xSjw2bhs800mOw96m7m9xPfXH
         eC3AgwSdpr/3F65Q0U1FyNBpn5U/7gZLQr1zvjdB0JiEsOP4uDAL0Lgpt/yWfLt2M/BK
         jHrfqt42dh6i9vJ16+5GY+4I3AmKfe6glSRwh5Hs8sYpdNigMIdicFc2B75xzPHEcUxI
         fd/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YzzxAfsdgRp0sBb+mu0K+QG/OOHcPzTsEjXihYPQFME=;
        b=pH+oKN00BWRS1mcbgfjyi4B94eA87gmJBSUZzo+BO6ct/IUOhJlD2PCKamZHyK3Jac
         3jhdQ83vr14tXLqc9nrlvGmMKoDcoHdERB1G6zmr9uqRRcjxeVvCwCAwnDYVhH/qHCSG
         +Z95Qs7Nj6w2yuqEHnvfJr68TNzn348W5M8lORwErFE6pgnluNut0ANrbeouoGFe+FVw
         yfCu+vPBbxuQ0NJwKdVvaqrKpl/2NmefSPiqK9M+TO6DhC1w6YCX4m8xhe/WwwGhTz8N
         7edz7ZKGIqrB+SYKYaEtBQruyfLlGPYSiiJ6CAciBpZTjaraH3mqIO4YwStWSaAAixNw
         sIKQ==
X-Gm-Message-State: ACrzQf2kQlubohowKJwYRnBrko8WArxyHcItiBIbkShJRhwFNy7hs3dj
        XK/ryBHyzrS/1b8e3rDrfSbiug==
X-Google-Smtp-Source: AMsMyM4PXSRjkxnm+W5B8LwIYiLLmAdpnyzwAapzw27ah/2HWSIAR8kn1/hbuw7umU7fh8lP4gcwxg==
X-Received: by 2002:a63:100a:0:b0:46f:b030:877d with SMTP id f10-20020a63100a000000b0046fb030877dmr8939251pgl.333.1667270878330;
        Mon, 31 Oct 2022 19:47:58 -0700 (PDT)
Received: from localhost.localdomain (80.251.214.228.16clouds.com. [80.251.214.228])
        by smtp.gmail.com with ESMTPSA id y4-20020a170902ed4400b001714c36a6e7sm5079570plb.284.2022.10.31.19.47.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 31 Oct 2022 19:47:57 -0700 (PDT)
From:   Shawn Guo <shawn.guo@linaro.org>
To:     "Rafael J . Wysocki" <rafael@kernel.org>
Cc:     Kevin Hilman <khilman@kernel.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Shawn Guo <shawn.guo@linaro.org>
Subject: [PATCH v2 3/3] PM: domains: Power off[on] domain in hibernate .freeze[thaw]_noirq hook
Date:   Tue,  1 Nov 2022 10:47:36 +0800
Message-Id: <20221101024736.1509207-4-shawn.guo@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20221101024736.1509207-1-shawn.guo@linaro.org>
References: <20221101024736.1509207-1-shawn.guo@linaro.org>
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
  for hibernate freeze, and thus fix the lockup issue seen on i.MX
  platform.

Signed-off-by: Shawn Guo <shawn.guo@linaro.org>
---
 drivers/base/power/domain.c | 35 ++++-------------------------------
 1 file changed, 4 insertions(+), 31 deletions(-)

diff --git a/drivers/base/power/domain.c b/drivers/base/power/domain.c
index b81baeb38d81..28c9e04e3488 100644
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

