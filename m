Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7656D6352BA
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Nov 2022 09:33:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236596AbiKWIcX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Nov 2022 03:32:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39806 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236609AbiKWIcS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Nov 2022 03:32:18 -0500
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com [IPv6:2a00:1450:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F23F2FC1F;
        Wed, 23 Nov 2022 00:32:15 -0800 (PST)
Received: by mail-wm1-x32c.google.com with SMTP id a11-20020a05600c2d4b00b003cf6f5fd9f1so763116wmg.2;
        Wed, 23 Nov 2022 00:32:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tiVq12etDEqpSPghR2pHAXWqLMT5ZsuO549677H8yKw=;
        b=MyEV25w3LrvWhMxVEvRvLa3evdPIH+e40Svg0wHs/feDnitL6BmGPaIAd+kTt0evP9
         /rfcjapSmugozwxRxFv1ndCofOBaP6LWVVa2Nao8xFHhbJkaW8f5tdXUyK0F11CksELZ
         bkzKGeCRi8xAchSva0GRTTokYQ+8SOvV/9VwYi/PIefA90Owulxhb93hIxPAqMgubX6E
         oACKfHhoU3tfLhGnX+eQLhr/4wnY8Dh/NRO2hlZIOJdNMd13KiVXEOgM2PeBkZxes+jM
         /9kO+MFB8wpR/Z3A8aEFRAMUnZa6LPwxNx10rcrXNawVdxLBLLIpZH1etTDtys2042tj
         5Nbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tiVq12etDEqpSPghR2pHAXWqLMT5ZsuO549677H8yKw=;
        b=tXrhpjRjzTJVkFgJMcvfKuEqzepWLH20HsHqgNu/D/lsVPAmvSlJl2DOfcS7i63vTL
         06AeHK19ZG+NRM97rT9AWly+WuH7Pl1VNELeqjSyr5uKZ6sDAJU04O8ryUaOs0rqix48
         KPaqL0KyGIy1eHAXUy24TvfiH8k1wkY7LteQDHK44AfaHYY+LAwQhInrf+BkL6AUZxPV
         Zw+pcX+EZ4iDazfDCHmVAriddrPIaOQrmZOA8JbeUUvOh3JoHBTlvPJNnLyRMbSV7GPY
         3ZRe2cwoLCcqHrsyr/4gQ9VoHRp97NKqa8iLJn7XoY7KTF/Q3RVuVZv8uy+t6FrU9Y1S
         a7Ug==
X-Gm-Message-State: ANoB5plv+YIuMrTmon53IF3hUar6JHlPQN5mW11bUs88x6OhF/CJTKcs
        xtDpdCIhP882gXxWD0RuR8o=
X-Google-Smtp-Source: AA0mqf58n/JCu3Qxs0fcYSBCRxypmvGsJMgBKbGX+NLdLniHernMYaeW19FVmoPaIQ5ZA+oKOo5eWQ==
X-Received: by 2002:a05:600c:314f:b0:3cf:9efc:a9b7 with SMTP id h15-20020a05600c314f00b003cf9efca9b7mr19406962wmo.10.1669192333854;
        Wed, 23 Nov 2022 00:32:13 -0800 (PST)
Received: from felia.fritz.box (200116b826997500d517ac74edd630a9.dip.versatel-1u1.de. [2001:16b8:2699:7500:d517:ac74:edd6:30a9])
        by smtp.gmail.com with ESMTPSA id l8-20020adfa388000000b002417f35767asm16276487wrb.40.2022.11.23.00.32.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Nov 2022 00:32:13 -0800 (PST)
From:   Lukas Bulwahn <lukas.bulwahn@gmail.com>
To:     Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Paul Cercueil <paul@crapouillou.net>,
        Maarten ter Huurne <maarten@treewalker.org>
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org,
        Lukas Bulwahn <lukas.bulwahn@gmail.com>
Subject: [PATCH v2] clocksource: ingenic-ost: define pm functions properly in platform_driver struct
Date:   Wed, 23 Nov 2022 09:31:59 +0100
Message-Id: <20221123083159.22821-1-lukas.bulwahn@gmail.com>
X-Mailer: git-send-email 2.17.1
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

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
---
v1: https://lore.kernel.org/all/20221122141434.30498-1-lukas.bulwahn@gmail.com/

v1 -> v2:
  - incorporated Paul Cercueil's feedback:
    - changed to pm_sleep_ptr
    - dropped Fixes: tag

 drivers/clocksource/ingenic-ost.c | 10 ++++------
 1 file changed, 4 insertions(+), 6 deletions(-)

diff --git a/drivers/clocksource/ingenic-ost.c b/drivers/clocksource/ingenic-ost.c
index 06d25754e606..9f7c280a1336 100644
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
-- 
2.17.1

