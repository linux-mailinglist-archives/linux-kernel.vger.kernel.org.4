Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4157463EF00
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Dec 2022 12:08:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231381AbiLALIi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Dec 2022 06:08:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44306 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231278AbiLALHz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Dec 2022 06:07:55 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 52218BA0BF;
        Thu,  1 Dec 2022 03:05:53 -0800 (PST)
Date:   Thu, 01 Dec 2022 11:05:50 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1669892751;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=kIeIeIcghzxVjqF1TjUsV9dokQhCubnFBxcDqd3Ie/w=;
        b=Pm6ocLMwtp3qIgXJ1pwRGI3C9DxbQ4wAS+ufsiAfXpb15dFLHrjTNvIWmyZR0n0OJMJwA1
        ZGYfx10fxTolfVpZ7JxRUveMe6ybzqlcoF2ESyQQNOKlCM0XVog85VnHh1t/VIMv8dSSAl
        LacSBGWCQOhAxr7fTOS0BluHgcMi8Vz6Mws0Dh/TwoX1tASsxzeDz70XWtFGUKdN6wIBPo
        DeOXN/9Lw3vh2RS4h7mUnAkPVfomHTdZzmemc+N1YKcV+CDIx+w1adQsR47fdSUMNiqxRn
        y2MZwUk1DhRuMn5TiNBCuQEvgqsqT4PGGRRQTXTc0TkV8EYR//5g8DrVz7uqIg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1669892751;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=kIeIeIcghzxVjqF1TjUsV9dokQhCubnFBxcDqd3Ie/w=;
        b=YRntC8ygUG7BUoLazW8JRUNFzq6IidLWqmjR1hO1UJ6uZBNxA4gk48QbQMHh8uhN4LE1Wx
        JsQf5O2dTB6XMVDQ==
From:   "tip-bot2 for Lukas Bulwahn" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: timers/core] clocksource/drivers/ingenic-ost: Define pm
 functions properly in platform_driver struct
Cc:     Paul Cercueil <paul@crapouillou.net>,
        Lukas Bulwahn <lukas.bulwahn@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20221123083159.22821-1-lukas.bulwahn@gmail.com>
References: <20221123083159.22821-1-lukas.bulwahn@gmail.com>
MIME-Version: 1.0
Message-ID: <166989275032.4906.6461931630043046760.tip-bot2@tip-bot2>
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

Commit-ID:     035629547999d0e9095886f248c2580dc56f36c6
Gitweb:        https://git.kernel.org/tip/035629547999d0e9095886f248c2580dc56f36c6
Author:        Lukas Bulwahn <lukas.bulwahn@gmail.com>
AuthorDate:    Wed, 23 Nov 2022 09:31:59 +01:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Thu, 01 Dec 2022 11:56:36 +01:00

clocksource/drivers/ingenic-ost: Define pm functions properly in platform_driver struct

Commit ca7b72b5a5f2 ("clocksource: Add driver for the Ingenic JZ47xx OST")
adds the struct platform_driver ingenic_ost_driver, with the definition of
pm functions under the non-existing config PM_SUSPEND, which means the
intended pm functions were never actually included in any build.

As the only callbacks are .suspend_noirq and .resume_noirq, we can assume
that it is intended to be CONFIG_PM_SLEEP.

Since commit 1a3c7bb08826 ("PM: core: Add new *_PM_OPS macros, deprecate
old ones"), the default pattern for platform_driver definitions
conditional for CONFIG_PM_SLEEP is to use pm_sleep_ptr().

As __maybe_unused annotations on the dev_pm_ops structure and its callbacks
are not needed anymore, remove these as well.

Suggested-by: Paul Cercueil <paul@crapouillou.net>
Signed-off-by: Lukas Bulwahn <lukas.bulwahn@gmail.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Reviewed-by: Paul Cercueil <paul@crapouillou.net>
Link: https://lore.kernel.org/r/20221123083159.22821-1-lukas.bulwahn@gmail.com
---
 drivers/clocksource/ingenic-ost.c | 10 ++++------
 1 file changed, 4 insertions(+), 6 deletions(-)

diff --git a/drivers/clocksource/ingenic-ost.c b/drivers/clocksource/ingenic-ost.c
index 06d2575..9f7c280 100644
--- a/drivers/clocksource/ingenic-ost.c
+++ b/drivers/clocksource/ingenic-ost.c
@@ -141,7 +141,7 @@ static int __init ingenic_ost_probe(struct platform_device *pdev)
 	return 0;
 }
 
-static int __maybe_unused ingenic_ost_suspend(struct device *dev)
+static int ingenic_ost_suspend(struct device *dev)
 {
 	struct ingenic_ost *ost = dev_get_drvdata(dev);
 
@@ -150,14 +150,14 @@ static int __maybe_unused ingenic_ost_suspend(struct device *dev)
 	return 0;
 }
 
-static int __maybe_unused ingenic_ost_resume(struct device *dev)
+static int ingenic_ost_resume(struct device *dev)
 {
 	struct ingenic_ost *ost = dev_get_drvdata(dev);
 
 	return clk_enable(ost->clk);
 }
 
-static const struct dev_pm_ops __maybe_unused ingenic_ost_pm_ops = {
+static const struct dev_pm_ops ingenic_ost_pm_ops = {
 	/* _noirq: We want the OST clock to be gated last / ungated first */
 	.suspend_noirq = ingenic_ost_suspend,
 	.resume_noirq  = ingenic_ost_resume,
@@ -181,9 +181,7 @@ static const struct of_device_id ingenic_ost_of_match[] = {
 static struct platform_driver ingenic_ost_driver = {
 	.driver = {
 		.name = "ingenic-ost",
-#ifdef CONFIG_PM_SUSPEND
-		.pm = &ingenic_ost_pm_ops,
-#endif
+		.pm = pm_sleep_ptr(&ingenic_ost_pm_ops),
 		.of_match_table = ingenic_ost_of_match,
 	},
 };
