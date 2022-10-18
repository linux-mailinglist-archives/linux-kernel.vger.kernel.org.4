Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4D631602786
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Oct 2022 10:50:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231182AbiJRIuH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Oct 2022 04:50:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57442 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231153AbiJRIt5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Oct 2022 04:49:57 -0400
Received: from mail-lj1-x236.google.com (mail-lj1-x236.google.com [IPv6:2a00:1450:4864:20::236])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 97AC5FAD4;
        Tue, 18 Oct 2022 01:49:29 -0700 (PDT)
Received: by mail-lj1-x236.google.com with SMTP id h8so17010569lja.11;
        Tue, 18 Oct 2022 01:49:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=S11K4vBoZGON508rytYjLm5ClL9jYcwO7synKUjPE5g=;
        b=f0NcEixTYGOiFkW5GEnnTneNS4jwWS4EYYcTionijTwvaum39D+rS7wbM6VENJOl61
         YNt/CM+RiaTh28efu7Y3tRH/YvJuseLjdBrutpYSwiSLbQRfcYdACpnL3jqKL6+XTcAO
         kV4DU83geA8e0ASM96bwoiRjGiXYH+LxJstVPLzkwgGAPIDDXPFJxMNtQ/BY4CF25Tab
         QrT26rabQ7maetDkzZUE4gjTfLgkDg7ru+61g0AD7wzVHI3XniaTG357bOh0QN/nukLo
         GQ/seikoPNOMWxq8AK2Mk9jKt399skq1703f64w/2Iih0ij9sA/WA8QK28vLWzzGO98k
         4etw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=S11K4vBoZGON508rytYjLm5ClL9jYcwO7synKUjPE5g=;
        b=OwlefIaBYMEW1MacG7wT95eYlYXhl+Dbg2c2pfBT25jCGQ+80vEGyMxggIDlEK5yoD
         ZpL9o+fJJf8MrTmHo9oqdQznw9Vx6u31GOVgqBfqyJxVw54EFNZKL4AcaiuW/02J62xH
         8lqH5myYrxbY8rZOovaNqjSUe8hdqHl2U+0G6HwcHlqkU61L+1iUa7GpvJw6kwHWc1yK
         qpKd/+n6eTuk3Dasr9APqfN4mkANivevfXg8Czzc+PyB2+7m5oAbvF3Qqzmfn0cRgLNJ
         6eKbkNsy6Bb/DyyNnq14a8Qjd/jmfvqTnSkIYo2GC7sbI9/+PqexbmP3MFFcn1LkbpUS
         SCHA==
X-Gm-Message-State: ACrzQf2t0HNJSH9XnOiZyZ2JwmfLTRw/nH1uat0vcrnk5pztVNZksUlS
        Dx7woRHRI7NKdOnRctjCMzY=
X-Google-Smtp-Source: AMsMyM5VHdezQI9YCEmTQc2Xace8MJV+87YsgDY7LckjQYPayvOv8vkl7HFCXjufgNehAuFnYeyh3g==
X-Received: by 2002:a2e:92d5:0:b0:26f:a674:94ac with SMTP id k21-20020a2e92d5000000b0026fa67494acmr704419ljh.470.1666082968143;
        Tue, 18 Oct 2022 01:49:28 -0700 (PDT)
Received: from localhost.localdomain ([188.163.112.49])
        by smtp.gmail.com with ESMTPSA id e10-20020a05651236ca00b004949f7cbb6esm1771890lfs.79.2022.10.18.01.49.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Oct 2022 01:49:27 -0700 (PDT)
From:   Svyatoslav Ryhel <clamor95@gmail.com>
To:     Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Dmitry Osipenko <digetx@gmail.com>
Cc:     linux-gpio@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v3 2/2] gpio: tegra: Switch to new *_PM_OPS macros
Date:   Tue, 18 Oct 2022 11:49:05 +0300
Message-Id: <20221018084905.21717-3-clamor95@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20221018084905.21717-1-clamor95@gmail.com>
References: <20221018084905.21717-1-clamor95@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since SET_*_PM_OPS() were deprecated, switch to new *_PM_OPS.

The callbacks that are only useful with CONFIG_PM_SLEEP is enabled,
are now wrapped with a pm_sleep_ptr().

Signed-off-by: Svyatoslav Ryhel <clamor95@gmail.com>
---
 drivers/gpio/gpio-tegra.c | 12 +++---------
 1 file changed, 3 insertions(+), 9 deletions(-)

diff --git a/drivers/gpio/gpio-tegra.c b/drivers/gpio/gpio-tegra.c
index 5b265a6fd3c1..ce17cc1a1cab 100644
--- a/drivers/gpio/gpio-tegra.c
+++ b/drivers/gpio/gpio-tegra.c
@@ -461,7 +461,6 @@ static int tegra_gpio_populate_parent_fwspec(struct gpio_chip *chip,
 	return 0;
 }
 
-#ifdef CONFIG_PM_SLEEP
 static int tegra_gpio_resume(struct device *dev)
 {
 	struct tegra_gpio_info *tgi = dev_get_drvdata(dev);
@@ -569,7 +568,6 @@ static int tegra_gpio_irq_set_wake(struct irq_data *d, unsigned int enable)
 
 	return 0;
 }
-#endif
 
 static int tegra_gpio_irq_set_affinity(struct irq_data *data,
 				       const struct cpumask *dest,
@@ -613,9 +611,7 @@ static const struct irq_chip tegra_gpio_irq_chip = {
 	.irq_mask		= tegra_gpio_irq_mask,
 	.irq_unmask		= tegra_gpio_irq_unmask,
 	.irq_set_type		= tegra_gpio_irq_set_type,
-#ifdef CONFIG_PM_SLEEP
-	.irq_set_wake		= tegra_gpio_irq_set_wake,
-#endif
+	.irq_set_wake		= pm_sleep_ptr(tegra_gpio_irq_set_wake),
 	.irq_print_chip		= tegra_gpio_irq_print_chip,
 	.irq_request_resources	= tegra_gpio_irq_request_resources,
 	.irq_release_resources	= tegra_gpio_irq_release_resources,
@@ -629,9 +625,7 @@ static const struct irq_chip tegra210_gpio_irq_chip = {
 	.irq_unmask		= tegra_gpio_irq_unmask,
 	.irq_set_affinity	= tegra_gpio_irq_set_affinity,
 	.irq_set_type		= tegra_gpio_irq_set_type,
-#ifdef CONFIG_PM_SLEEP
-	.irq_set_wake		= tegra_gpio_irq_set_wake,
-#endif
+	.irq_set_wake		= pm_sleep_ptr(tegra_gpio_irq_set_wake),
 	.irq_print_chip		= tegra_gpio_irq_print_chip,
 	.irq_request_resources	= tegra_gpio_irq_request_resources,
 	.irq_release_resources	= tegra_gpio_irq_release_resources,
@@ -681,7 +675,7 @@ static inline void tegra_gpio_debuginit(struct tegra_gpio_info *tgi)
 #endif
 
 static const struct dev_pm_ops tegra_gpio_pm_ops = {
-	SET_NOIRQ_SYSTEM_SLEEP_PM_OPS(tegra_gpio_suspend, tegra_gpio_resume)
+	NOIRQ_SYSTEM_SLEEP_PM_OPS(tegra_gpio_suspend, tegra_gpio_resume)
 };
 
 static const struct of_device_id tegra_pmc_of_match[] = {
-- 
2.34.1

