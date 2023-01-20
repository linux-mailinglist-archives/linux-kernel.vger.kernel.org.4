Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4FFC5675D54
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Jan 2023 20:02:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230001AbjATTCl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Jan 2023 14:02:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36966 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229991AbjATTCf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Jan 2023 14:02:35 -0500
Received: from mail-qv1-xf35.google.com (mail-qv1-xf35.google.com [IPv6:2607:f8b0:4864:20::f35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 36BC4CC5C9;
        Fri, 20 Jan 2023 11:02:32 -0800 (PST)
Received: by mail-qv1-xf35.google.com with SMTP id n2so4430181qvo.1;
        Fri, 20 Jan 2023 11:02:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=O/0h0heB6R7vr68pBP8mp0KNKIM3bG6DI1Vn2wipkYU=;
        b=kEqwe/PUsz08w5m0iF19xnZtx1fg80HTYcBEMVXbIWsvSG5mO6585xZiAizKMT98S7
         nY4ut/1oDiPiY8HqS40JbqcdJ+emuoXQwg6XmJKEwZOB60TGgGl3iydQ7fuoYn0SsS7k
         KY5DVucmMuoaWV5NrbFJuEvnqODTA0LxoFyZUoKhBmTu1TpEeyk7CXZ8TLzWRGTc3/rP
         fBjUrYxutoNlZPJfYgw26JOdoSB7aSWg6Rbx1DJpviuThuUFphoK5On5YNAeasguHYab
         xuC4aKsjyYQW3FfUI7NwsCCwyWGccRZorJpbnPbTmsu3vNm7bJJ13l0K2dJbkS0qjnEN
         KlaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=O/0h0heB6R7vr68pBP8mp0KNKIM3bG6DI1Vn2wipkYU=;
        b=s1eS99MrH/Khnsjme2cExFgv74bFn/O6Ct4Yody6JkzCAOy8m8ey9h852Ock4iBsLt
         kBwNQT2b9PvnL9nKT6pK0PtSK41KN11FPJgqUFI/okFKEDJO/HcxY4qsN8MVaF8ONn/M
         BWBUdrLPum2xNlE0StOgSVwYXwiK6gqpG05wd39PSNt2VVpbBJQLB3yuGoxLxdiFtv4b
         ivf4Wzvin/pf0l2u1zKclIBPqQ0tmwk6p4nbF0JsHqVRqxk+p2hKj3/NTrzmT+nuEKcQ
         7UCSWOzZyH52RYGwQ94XDdwwq9EYrhHnW8pWpuw5wDhRRw/zf3j/NmbIBOJZ99TPrtrs
         cGbA==
X-Gm-Message-State: AFqh2krLfruUgYeuVUmNlh0xz6i4qxHhQUR8tYVxiq6+FW9BPhuXJUlL
        lRzROWgc+JwfM7AKa2x9G+o=
X-Google-Smtp-Source: AMrXdXvGOJhrvjWOZszWDXp/4qWhkm8VfESaKs465MCmfTqIeKR8Xh8PfZedyemS+LkHGNAM4dSPBQ==
X-Received: by 2002:a0c:ea2c:0:b0:532:1fc2:9ad5 with SMTP id t12-20020a0cea2c000000b005321fc29ad5mr50095693qvp.0.1674241351099;
        Fri, 20 Jan 2023 11:02:31 -0800 (PST)
Received: from stbirv-lnx-3.igp.broadcom.net ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id y13-20020a37f60d000000b006fa2b1c3c1esm10379806qkj.58.2023.01.20.11.02.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Jan 2023 11:02:30 -0800 (PST)
From:   Doug Berger <opendmb@gmail.com>
To:     Alessandro Zummo <a.zummo@towertech.it>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>
Cc:     Brian Norris <computersforpeace@gmail.com>,
        Markus Mayer <mmayer@broadcom.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Broadcom internal kernel review list 
        <bcm-kernel-feedback-list@broadcom.com>, linux-rtc@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, Doug Berger <opendmb@gmail.com>
Subject: [PATCH 4/6] rtc: brcmstb-waketimer: rename irq to wake_irq
Date:   Fri, 20 Jan 2023 11:01:45 -0800
Message-Id: <20230120190147.718976-5-opendmb@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230120190147.718976-1-opendmb@gmail.com>
References: <20230120190147.718976-1-opendmb@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In preparation for adding a second interrupt to service RTC
interrupts, the existing interrupt is renamed from the generic
'irq' to 'wake_irq' to more clearly convey its role.

It is also converted to an unsigned int.

Finally, the driver message that outputs the IRQ number when
registered is removed since devm_rtc_register_device() already
provides a report of registration and the interrupts can be
found in /proc/interrupts.

Signed-off-by: Doug Berger <opendmb@gmail.com>
---
 drivers/rtc/rtc-brcmstb-waketimer.c | 15 +++++++--------
 1 file changed, 7 insertions(+), 8 deletions(-)

diff --git a/drivers/rtc/rtc-brcmstb-waketimer.c b/drivers/rtc/rtc-brcmstb-waketimer.c
index c791e92532b8..e25f9fcd6ed1 100644
--- a/drivers/rtc/rtc-brcmstb-waketimer.c
+++ b/drivers/rtc/rtc-brcmstb-waketimer.c
@@ -27,7 +27,7 @@ struct brcmstb_waketmr {
 	struct rtc_device *rtc;
 	struct device *dev;
 	void __iomem *base;
-	int irq;
+	unsigned int wake_irq;
 	struct notifier_block reboot_notifier;
 	struct clk *clk;
 	u32 rate;
@@ -117,7 +117,7 @@ static int brcmstb_waketmr_prepare_suspend(struct brcmstb_waketmr *timer)
 	int ret = 0;
 
 	if (device_may_wakeup(dev)) {
-		ret = enable_irq_wake(timer->irq);
+		ret = enable_irq_wake(timer->wake_irq);
 		if (ret) {
 			dev_err(dev, "failed to enable wake-up interrupt\n");
 			return ret;
@@ -246,9 +246,10 @@ static int brcmstb_waketmr_probe(struct platform_device *pdev)
 	 */
 	device_init_wakeup(dev, true);
 
-	timer->irq = platform_get_irq(pdev, 0);
-	if (timer->irq < 0)
+	ret = platform_get_irq(pdev, 0);
+	if (ret < 0)
 		return -ENODEV;
+	timer->wake_irq = (unsigned int)ret;
 
 	timer->clk = devm_clk_get(dev, NULL);
 	if (!IS_ERR(timer->clk)) {
@@ -263,7 +264,7 @@ static int brcmstb_waketmr_probe(struct platform_device *pdev)
 		timer->clk = NULL;
 	}
 
-	ret = devm_request_irq(dev, timer->irq, brcmstb_waketmr_irq, 0,
+	ret = devm_request_irq(dev, timer->wake_irq, brcmstb_waketmr_irq, 0,
 			       "brcmstb-waketimer", timer);
 	if (ret < 0)
 		goto err_clk;
@@ -278,8 +279,6 @@ static int brcmstb_waketmr_probe(struct platform_device *pdev)
 	if (ret)
 		goto err_notifier;
 
-	dev_info(dev, "registered, with irq %d\n", timer->irq);
-
 	return 0;
 
 err_notifier:
@@ -317,7 +316,7 @@ static int brcmstb_waketmr_resume(struct device *dev)
 	if (!device_may_wakeup(dev))
 		return 0;
 
-	ret = disable_irq_wake(timer->irq);
+	ret = disable_irq_wake(timer->wake_irq);
 
 	brcmstb_waketmr_clear_alarm(timer);
 
-- 
2.25.1

