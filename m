Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 456906971DE
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Feb 2023 00:34:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233057AbjBNXen (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Feb 2023 18:34:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55146 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233007AbjBNXek (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Feb 2023 18:34:40 -0500
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com [IPv6:2607:f8b0:4864:20::1031])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 00FC52B62F
        for <linux-kernel@vger.kernel.org>; Tue, 14 Feb 2023 15:34:36 -0800 (PST)
Received: by mail-pj1-x1031.google.com with SMTP id d2so16559458pjd.5
        for <linux-kernel@vger.kernel.org>; Tue, 14 Feb 2023 15:34:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BzzlaaQdOYO3fTmzqCVpPsOeF7R3YhY93EWeKNyYWH0=;
        b=IvW9sTrlPHiPPsZF8G2ve15uZyWaqOq/XVQXgfm/1diVn880slPNVRXM/r5KyifoEw
         PFZHYp5GVsGjLRZYEW+DZ8tZH8YeB80OJ1wJyo3pnyAlLFrkS6zQccV6L169volamnTO
         RNN/u6ka4ced0ycGXrHT0zf4251gNi5GQUYwFCtdoIE9KDp3glryKVq2NXHu0TlgR7eA
         j7jSF8fPFADaLnq8PCqbkHHBtPUP2EGf3fAIbP3CrH0ut0Vs4N6qEUqQcOCTPt+8GehG
         QMNatjojvfyUmBR0HHRiXIgZSDQBC1wbADkhzxPcSP8RBQPDVQIkS+bsXRBD1gHRg1nu
         mrXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BzzlaaQdOYO3fTmzqCVpPsOeF7R3YhY93EWeKNyYWH0=;
        b=rnGVdlBZ0mEqvJsBP57oJmkPmSuvx3hvsL5fSRdQFv6GDfoj7Ng2xhCqhqv2JTiIrq
         vbTfMY6/fABuD6L7uzZElCz9TyxiJ0AiJkS5H17z7RtMU1yjVGpTADE4O8AMl7xl5lQ5
         73wiI7Vkn7HEnG0+8YOtt/pfoTWUfF3lyjZAAiZe3Lr7X85vN+AGWhl0qMYSYmdxl5Nl
         ZLY2IKRpfJujCID6nNxEucA635hyHDz1Z46HS43K2o6YavzHPbfvpfYI+3cJIVdhR7Gv
         xLCcE+AGNSTl6vx7xuhPb7Q6FgRSBQ0wgk+F0yjYCflsiGamwYKn11Y5oY+o2l5LlDXV
         /HIQ==
X-Gm-Message-State: AO0yUKVYOA9hp26MiTLhlhkOZ5ptoa6spHICCjqyxLikyq7ebuTf1QPt
        gRYQty3rPJtlLoQ+C1zio+0=
X-Google-Smtp-Source: AK7set9BGTlGDBkqA2RV3+Mzj3CGt3c9d1uqr420mbrkrYo47vCblWNGUgNZOkPfJepFh/G4XgnSsA==
X-Received: by 2002:a17:902:e750:b0:199:1682:9175 with SMTP id p16-20020a170902e75000b0019916829175mr536755plf.8.1676417676473;
        Tue, 14 Feb 2023 15:34:36 -0800 (PST)
Received: from fainelli-desktop.igp.broadcom.net ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id f12-20020a170902684c00b001963a178dfcsm9434801pln.244.2023.02.14.15.34.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Feb 2023 15:34:35 -0800 (PST)
From:   Florian Fainelli <f.fainelli@gmail.com>
To:     linux-arm-kernel@lists.infradead.org
Cc:     Florian Fainelli <f.fainelli@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Marc Zyngier <maz@kernel.org>,
        Oliver Upton <oliver.upton@linux.dev>,
        linux-kernel@vger.kernel.org (open list:IRQCHIP DRIVERS),
        Sudeep Holla <sudeep.holla@arm.com>,
        Broadcom internal kernel review list 
        <bcm-kernel-feedback-list@broadcom.com>
Subject: [PATCH 2/3] irqchip/gic-v3: Propagate gic_cpu_pm_init() return code
Date:   Tue, 14 Feb 2023 15:34:25 -0800
Message-Id: <20230214233426.2994501-3-f.fainelli@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230214233426.2994501-1-f.fainelli@gmail.com>
References: <20230214233426.2994501-1-f.fainelli@gmail.com>
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

In preparation for allocating memory which may fail, propagate the
return code from gic_cpu_pm_init().

Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
---
 drivers/irqchip/irq-gic-v3.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/drivers/irqchip/irq-gic-v3.c b/drivers/irqchip/irq-gic-v3.c
index b60fadb7eb44..48b0e9aba27c 100644
--- a/drivers/irqchip/irq-gic-v3.c
+++ b/drivers/irqchip/irq-gic-v3.c
@@ -1395,9 +1395,11 @@ static struct notifier_block gic_cpu_pm_notifier_block = {
 	.notifier_call = gic_cpu_pm_notifier,
 };
 
-static void gic_cpu_pm_init(void)
+static int gic_cpu_pm_init(void)
 {
 	cpu_pm_register_notifier(&gic_cpu_pm_notifier_block);
+
+	return 0;
 }
 
 #else
@@ -1891,7 +1893,9 @@ static int __init gic_init_bases(void __iomem *dist_base,
 	gic_dist_init();
 	gic_cpu_init();
 	gic_smp_init();
-	gic_cpu_pm_init();
+	err = gic_cpu_pm_init();
+	if (err)
+		goto out_set_handle;
 
 	if (gic_dist_supports_lpis()) {
 		its_init(handle, &gic_data.rdists, gic_data.domain);
@@ -1906,6 +1910,8 @@ static int __init gic_init_bases(void __iomem *dist_base,
 
 	return 0;
 
+out_set_handle:
+	set_handle_irq(NULL);
 out_free:
 	if (gic_data.domain)
 		irq_domain_remove(gic_data.domain);
-- 
2.34.1

