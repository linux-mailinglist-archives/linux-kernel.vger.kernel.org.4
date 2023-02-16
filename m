Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 285106996F1
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Feb 2023 15:16:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230046AbjBPOQi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Feb 2023 09:16:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52700 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230011AbjBPOQf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Feb 2023 09:16:35 -0500
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com [IPv6:2a00:1450:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 470984BE89
        for <linux-kernel@vger.kernel.org>; Thu, 16 Feb 2023 06:16:02 -0800 (PST)
Received: by mail-wm1-x32c.google.com with SMTP id o19-20020a05600c379300b003e21af96703so566946wmr.2
        for <linux-kernel@vger.kernel.org>; Thu, 16 Feb 2023 06:16:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=vHKzG8cIzUJ9myM1y/sRXdNYOKLlG72/XSqg8hiPzrk=;
        b=EVjVA7YMZHaFiNYnlJoUWGMytzMYXIm7RXAlNjSIpWz+U/QvgPJwVcXp4Qp/X0uKXJ
         aGGnxlBIZZo7cdpIe7nUcd6bjAEP7ppTulsIALxLn3I9vJsW6Zz7OUaOQ06kifl66anT
         MBYfDtditslrqNGrC0zBF5e7i29xsBkF5O8egKnjOIdOnj6/X2wrGAs4sqfGKqVU3Yur
         l08WOY80/F9G1non1mgY03KRfDNRqhmEuDAZe1OiVx7o/YiGdgAXQ7OaULvxI1OhbwGl
         ENYqqV+axebshLrScF2VXH6WagxZKWHo5kwL6ZPEOllv4l7HvsblrBfxAGd1JmFVN5XX
         SMlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=vHKzG8cIzUJ9myM1y/sRXdNYOKLlG72/XSqg8hiPzrk=;
        b=TfEUtqyIxIkW8PEeur6qgw0i7N1Us4dPhS5DbBMbXFsW0LTsmDhFXdm5yFiswCJB/E
         AeTrYZk9KtK1XXW+rq1LLzm+aIfCRDCyhKPd4sEvAKPp+uQSxSJdQ/Yg97PHEdBRl/Au
         +TndeOBHSFbXgSqtBGHr272XZ3s0U3cVAy1xFuM6tZzet2CS2zpHLnGZ2TU4ATJAWppf
         IVZHUo4AIBDqKtlWOuuOiLrick60dhDGL0V+4Ek2VVllhT0iBHgeWmlNKnOpuTy6UtNu
         KLdzYNDTOdiX+/KwAz5n6bkGQo/zJaS5eYgwS1mNCFTlKPQPldqfWaaTF1mfGh9l8mGx
         RbAg==
X-Gm-Message-State: AO0yUKX2/D95rnv+ar/CRRJrCmZuUVU34QaQKJE1W3t1cjiVg6cAzJmm
        +hWISSRmwic2h6V6jxcfM8qTFA==
X-Google-Smtp-Source: AK7set92kihlU6qNKa1VjqOLHo/pjktcTIUySDqK3GhCSdQYVUcOMF1rOj3dhVhA9RgV6sA1fXv5LQ==
X-Received: by 2002:a05:600c:4d92:b0:3e2:dba:7155 with SMTP id v18-20020a05600c4d9200b003e20dba7155mr2017884wmp.20.1676556960676;
        Thu, 16 Feb 2023 06:16:00 -0800 (PST)
Received: from brgl-uxlite.home ([2a01:cb1d:334:ac00:7c5b:1160:db5d:72da])
        by smtp.gmail.com with ESMTPSA id ay1-20020a05600c1e0100b003e1fee8baacsm5471478wmb.25.2023.02.16.06.15.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Feb 2023 06:15:59 -0800 (PST)
From:   Bartosz Golaszewski <brgl@bgdev.pl>
To:     Kent Gibson <warthog618@gmail.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Viresh Kumar <viresh.kumar@linaro.org>
Cc:     linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        Mirsad Goran Todorovac <mirsad.todorovac@alu.unizg.hr>
Subject: [PATCH] gpio: sim: fix a memory leak
Date:   Thu, 16 Feb 2023 15:15:55 +0100
Message-Id: <20230216141555.116219-1-brgl@bgdev.pl>
X-Mailer: git-send-email 2.37.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix an inverted logic bug in gpio_sim_remove_hogs() that leads to GPIO
hog structures never being freed.

Fixes: cb8c474e79be ("gpio: sim: new testing module")
Reported-by: Mirsad Goran Todorovac <mirsad.todorovac@alu.unizg.hr>
Signed-off-by: Bartosz Golaszewski <brgl@bgdev.pl>
---
 drivers/gpio/gpio-sim.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpio/gpio-sim.c b/drivers/gpio/gpio-sim.c
index 60514bc5454f..9e3893b19e4f 100644
--- a/drivers/gpio/gpio-sim.c
+++ b/drivers/gpio/gpio-sim.c
@@ -736,7 +736,7 @@ static void gpio_sim_remove_hogs(struct gpio_sim_device *dev)
 
 	gpiod_remove_hogs(dev->hogs);
 
-	for (hog = dev->hogs; !hog->chip_label; hog++) {
+	for (hog = dev->hogs; hog->chip_label; hog++) {
 		kfree(hog->chip_label);
 		kfree(hog->line_name);
 	}
-- 
2.37.2

