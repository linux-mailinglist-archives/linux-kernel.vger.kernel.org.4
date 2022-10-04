Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 786B55F3FA2
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Oct 2022 11:30:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230492AbiJDJaD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Oct 2022 05:30:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55242 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229888AbiJDJ1z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Oct 2022 05:27:55 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 070AF63E0;
        Tue,  4 Oct 2022 02:27:21 -0700 (PDT)
Date:   Tue, 04 Oct 2022 09:27:18 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1664875639;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=wKfUZzfIrtjVXCIfq76XyIPzaIUD/jjuOiPYqwj0h0w=;
        b=yisaX2O5wqQlID2EjZPDTmt+uV/3VMmrAL0bxjkxecXDZS2wHo6eIX75semFff2c+BjDZE
        SwfKveT/gj4nfROqQNVZbPVw7b82p5YwPTqncM0h6CKO03jjIIvbjUtIZqev/AZpjy+jG/
        hSg1RlC2RgwFRjM02ZlKwseFKNbTg5COhYs5RiYKKW5eKbf0W73exfkUGxLd9GJNuuv0JN
        i/gsT9DuklywF2mHSSrTk++R9f9wTJQw49MQONQz5TmfyxcmlUev4KF+a2TuUd7dWrKZbq
        8ikudDSdh39Peb7D2gqHQ1Q9scwsSEt1ej5zf5mhJ1sRLvBC4Iqgz12+omEFHg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1664875639;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=wKfUZzfIrtjVXCIfq76XyIPzaIUD/jjuOiPYqwj0h0w=;
        b=tCdBNc8LBsv1PYhnI0K3kLqSgM3lgvF4yrA9Ao2NTuAZl3lmYdFacC6DdGMTMf877LS9Rz
        K7pmuvK/1WOFQ6Dw==
From:   "tip-bot2 for Lin Yujun" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: timers/core] clocksource/drivers/timer-gxp: Add missing error
 handling in gxp_timer_probe
Cc:     Lin Yujun <linyujun809@huawei.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20220914033018.97484-1-linyujun809@huawei.com>
References: <20220914033018.97484-1-linyujun809@huawei.com>
MIME-Version: 1.0
Message-ID: <166487563850.401.15793422697828294118.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the timers/core branch of tip:

Commit-ID:     0e2c8e6d769bcdc4f6634a02c545356282275e68
Gitweb:        https://git.kernel.org/tip/0e2c8e6d769bcdc4f6634a02c545356282275e68
Author:        Lin Yujun <linyujun809@huawei.com>
AuthorDate:    Wed, 14 Sep 2022 11:30:18 +08:00
Committer:     Daniel Lezcano <daniel.lezcano@linaro.org>
CommitterDate: Tue, 20 Sep 2022 10:49:45 +02:00

clocksource/drivers/timer-gxp: Add missing error handling in gxp_timer_probe

Add platform_device_put() to make sure to free the platform
device in the event platform_device_add() fails.

Fixes: 5184f4bf151b ("clocksource/drivers/timer-gxp: Add HPE GXP Timer")
Signed-off-by: Lin Yujun <linyujun809@huawei.com>
Link: https://lore.kernel.org/r/20220914033018.97484-1-linyujun809@huawei.com
Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
---
 drivers/clocksource/timer-gxp.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/clocksource/timer-gxp.c b/drivers/clocksource/timer-gxp.c
index 8b38b32..fe4fa8d 100644
--- a/drivers/clocksource/timer-gxp.c
+++ b/drivers/clocksource/timer-gxp.c
@@ -171,6 +171,7 @@ static int gxp_timer_probe(struct platform_device *pdev)
 {
 	struct platform_device *gxp_watchdog_device;
 	struct device *dev = &pdev->dev;
+	int ret;
 
 	if (!gxp_timer) {
 		pr_err("Gxp Timer not initialized, cannot create watchdog");
@@ -187,7 +188,11 @@ static int gxp_timer_probe(struct platform_device *pdev)
 	gxp_watchdog_device->dev.platform_data = gxp_timer->counter;
 	gxp_watchdog_device->dev.parent = dev;
 
-	return platform_device_add(gxp_watchdog_device);
+	ret = platform_device_add(gxp_watchdog_device);
+	if (ret)
+		platform_device_put(gxp_watchdog_device);
+
+	return ret;
 }
 
 static const struct of_device_id gxp_timer_of_match[] = {
