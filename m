Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4CD94748082
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jul 2023 11:10:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231852AbjGEJKK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Jul 2023 05:10:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42302 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230157AbjGEJKH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Jul 2023 05:10:07 -0400
Received: from mail-oa1-x2b.google.com (mail-oa1-x2b.google.com [IPv6:2001:4860:4864:20::2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C7AC10D5;
        Wed,  5 Jul 2023 02:10:06 -0700 (PDT)
Received: by mail-oa1-x2b.google.com with SMTP id 586e51a60fabf-1b0249f1322so5311272fac.3;
        Wed, 05 Jul 2023 02:10:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1688548205; x=1691140205;
        h=message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KcsOeGLimul89G1ISXwaKkbEQdp5PaXxX2niuxY6rwo=;
        b=EcXaSlbOlR5e36VZentjv18TglOo4SR5IxwQuC62hO+13KuXYr6w0oJkkcSKXWNTh/
         xQd1w0d35T/52TOVUJJF+z0xu9D+snC54xOF+YOOrc0xHPBHnS8t1iQ3/rRdBo0Ba7Gy
         Vyp8gd4RvbUjm7l7+9m8ibGi/vWGfsqfpiaXE+z8gV1BQF6wYFfAwCifZuszxBIJ0M62
         kyGcXBrt75e9Hh4hyeTpjW0TfG1DsJEeThJw/Ltbqmh5038nXuhNdQbYF6rQnzJ4It8X
         tYAgt51CzVy3QzJ7mnbbMZucmyCO393GVNRbiWURxK0cah0ppF7CVyfu7y+V7I7ovNp+
         9BUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688548205; x=1691140205;
        h=message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KcsOeGLimul89G1ISXwaKkbEQdp5PaXxX2niuxY6rwo=;
        b=AIqC37EyEd9Jvn8etThUpNwdewnFKvnnhG24Tl5grCuIadHJqp+b0ahfBBraSlyJsn
         85szUBoJrUYHWXrETO+L0OAn91zi3mDTLN7DLdIZwZHiZ4FDJbRBSG06DbxolEYsXDGU
         JVekJmbkz4IjUNxi2I2QkdE1wkUVkbS3js//il+Gm9cQ1XSMBG4pRcQTTQDI5t5I/kYl
         AwBu9Oe5kZDJ8Iz2V0tuCP3GCak/ztWUmnuOeAuUK4TQKkNdLYdxCr/TVSArPI8rn3Ba
         jXlkl/4hBSVBpw8XrZqm4YKhUZCZZlbLGHcxQR5sHDufjhdhEyW+rivc+K1jDZXisXYO
         gdMQ==
X-Gm-Message-State: ABy/qLZH4YR09ndTGZU5z+izEvqTrLK5JEGlIlYWheftpud8P7zEH+lC
        /49kWhF6/CVrOABY5fIPmM0=
X-Google-Smtp-Source: ACHHUZ4ckVuETojQlbMs5VH38cwbmsi9JDfq/6TswQOECm+hW1eTRWtCjuU7c+baqOXg9aQBxcfdRw==
X-Received: by 2002:a05:6870:9d05:b0:19f:202b:513c with SMTP id pp5-20020a0568709d0500b0019f202b513cmr14517197oab.29.1688548205257;
        Wed, 05 Jul 2023 02:10:05 -0700 (PDT)
Received: from 377044c6c369.cse.ust.hk (191host097.mobilenet.cse.ust.hk. [143.89.191.97])
        by smtp.gmail.com with ESMTPSA id f39-20020a056871072700b001a69e7efd13sm15079978oap.5.2023.07.05.02.10.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Jul 2023 02:10:04 -0700 (PDT)
From:   Chengfeng Ye <dg573847474@gmail.com>
To:     krzysztof.kozlowski@linaro.org, alim.akhtar@samsung.com,
        wim@linux-watchdog.org, linux@roeck-us.net
Cc:     linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-watchdog@vger.kernel.org,
        linux-kernel@vger.kernel.org, Chengfeng Ye <dg573847474@gmail.com>
Subject: [PATCH v3] watchdog: s3c2410: Fix potential deadlock on &wdt->lock
Date:   Wed,  5 Jul 2023 09:09:51 +0000
Message-Id: <20230705090951.63762-1-dg573847474@gmail.com>
X-Mailer: git-send-email 2.17.1
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

As &wdt->lock is acquired by hard irq s3c2410wdt_irq(),
other acquisition of the same lock under process context should
disable irq, otherwise deadlock could happen if the
irq preempt the execution while the lock is held in process context
on the same CPU.

[Deadlock Scenario]
s3c2410wdt_suspend()
    -> s3c2410wdt_stop()
    -> spin_lock(&wdt->lock)
        <irq iterrupt>
        -> s3c2410wdt_irq()
        -> s3c2410wdt_keepalive()
        -> spin_lock(&wdt->lock) (deadlock here)

[Deadlock Scenario]
s3c2410wdt_probe()
    -> s3c2410wdt_start()
    -> spin_lock(&wdt->lock)
        <irq iterrupt>
        -> s3c2410wdt_irq()
        -> s3c2410wdt_keepalive()
        -> spin_lock(&wdt->lock) (deadlock here)

[Deadlock Scenario]
s3c2410wdt_keepalive()
    -> spin_lock(&wdt->lock)
        <irq iterrupt>
        -> s3c2410wdt_irq()
        -> s3c2410wdt_keepalive()
        -> spin_lock(&wdt->lock) (deadlock here)

This flaw was found by an experimental static analysis tool I am
developing for irq-related deadlock, which reported the above
warning when analyzing the linux kernel 6.4-rc7 release.

The tentative patch fix the potential deadlock by spin_lock_irqsave()
under process context.

Signed-off-by: Chengfeng Ye <dg573847474@gmail.com>
---
 drivers/watchdog/s3c2410_wdt.c | 15 +++++++++------
 1 file changed, 9 insertions(+), 6 deletions(-)

diff --git a/drivers/watchdog/s3c2410_wdt.c b/drivers/watchdog/s3c2410_wdt.c
index 95416a9bdd4b..e1dc71ece01e 100644
--- a/drivers/watchdog/s3c2410_wdt.c
+++ b/drivers/watchdog/s3c2410_wdt.c
@@ -379,10 +379,11 @@ static int s3c2410wdt_enable(struct s3c2410_wdt *wdt, bool en)
 static int s3c2410wdt_keepalive(struct watchdog_device *wdd)
 {
 	struct s3c2410_wdt *wdt = watchdog_get_drvdata(wdd);
+	unsigned long flags;
 
-	spin_lock(&wdt->lock);
+	spin_lock_irqsave(&wdt->lock, flags);
 	writel(wdt->count, wdt->reg_base + S3C2410_WTCNT);
-	spin_unlock(&wdt->lock);
+	spin_unlock_irqrestore(&wdt->lock, flags);
 
 	return 0;
 }
@@ -399,10 +400,11 @@ static void __s3c2410wdt_stop(struct s3c2410_wdt *wdt)
 static int s3c2410wdt_stop(struct watchdog_device *wdd)
 {
 	struct s3c2410_wdt *wdt = watchdog_get_drvdata(wdd);
+	unsigned long flags;
 
-	spin_lock(&wdt->lock);
+	spin_lock_irqsave(&wdt->lock, flags);
 	__s3c2410wdt_stop(wdt);
-	spin_unlock(&wdt->lock);
+	spin_unlock_irqrestore(&wdt->lock, flags);
 
 	return 0;
 }
@@ -411,8 +413,9 @@ static int s3c2410wdt_start(struct watchdog_device *wdd)
 {
 	unsigned long wtcon;
 	struct s3c2410_wdt *wdt = watchdog_get_drvdata(wdd);
+	unsigned long flags;
 
-	spin_lock(&wdt->lock);
+	spin_lock_irqsave(&wdt->lock, flags);
 
 	__s3c2410wdt_stop(wdt);
 
@@ -433,7 +436,7 @@ static int s3c2410wdt_start(struct watchdog_device *wdd)
 	writel(wdt->count, wdt->reg_base + S3C2410_WTDAT);
 	writel(wdt->count, wdt->reg_base + S3C2410_WTCNT);
 	writel(wtcon, wdt->reg_base + S3C2410_WTCON);
-	spin_unlock(&wdt->lock);
+	spin_unlock_irqrestore(&wdt->lock, flags);
 
 	return 0;
 }
-- 
2.17.1

