Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4D4B473072D
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Jun 2023 20:12:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241844AbjFNSMa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Jun 2023 14:12:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44512 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241824AbjFNSMI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Jun 2023 14:12:08 -0400
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 897FC2943;
        Wed, 14 Jun 2023 11:11:27 -0700 (PDT)
Received: by mail-wm1-x336.google.com with SMTP id 5b1f17b1804b1-3f7368126a6so8981135e9.0;
        Wed, 14 Jun 2023 11:11:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1686766286; x=1689358286;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=SSUCrY8q+S+CElWsLe8kdIUOHnbAQ0euqrSqcUAC+oI=;
        b=OV9ucZrn29tyM1vaBQ76N5ZdmisY5Ws2Olmh96cM1HdUTu9X8Mcsqy+eQJ3dfRJov3
         4VTP6RkUKvXN1P3482/K5xo5XqfPnqAc7qm1Z+cDuolLSTNSpgNc+mbmCiPd41aJ1uub
         ipmKa5O9tOxz5/EYMvGbWllhcGc9sCc3HGwh9QJ3jSz4V6vnCU3yREE1myhw/A7t6X1y
         Kl2G6QLZ4wTSs1sLgPGgz1K22cDApVDWhTE9junHkdkCnhaKZCG+477dn7m7hsGO501N
         MPEG7hOkAiWv3DCMSInbZUCATWQD/P+yvKSU9836CXlOwOizT2jZemak3epYu09Cc4Vx
         iXmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686766286; x=1689358286;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=SSUCrY8q+S+CElWsLe8kdIUOHnbAQ0euqrSqcUAC+oI=;
        b=Mx57A7rP7pwUnjOCll9M1IlL+4afHm4K2zMl4SGhrwAiAh2o/i3erUYg4QC7B4gm8b
         KEF2zzkatNJiIdFDBQ7HPrd5xUBbvVqjQ6+zZRnCHOCdxvBi/TcqNkjiix9Q3HM5wUMZ
         jflWBHiSKv4ItXbB4DF5cwos8PEflWfBIdE45JmxCcDrKl91QguRzQDM1ltGgYtlUKv5
         E/Ra09v9dpikl1/cpdSGzGeGKiyNlBYeRYntwFbd3d+Z4gyrSdvaUNu1W596M08zxxAl
         SnpUIgqxE5q8xL8tHlcR1cy9Cre1VvVb9Aynx3fRcfxR4JDwJAK0zbyweyT6sEw4lTWr
         6+Dg==
X-Gm-Message-State: AC+VfDycINA0CohQGOS4z8Lfv7oYAGo+4pj7QehPJm9pg0LKpqM7JDNF
        6YljIeEdTwCvqKWpWJLaumAQXdSb2fI=
X-Google-Smtp-Source: ACHHUZ671+erQD4aXmMMC/KmkyhEbbJCq7/WqyueXo8eYeFu2HwYHKpB5CZnWzduxq2ECV/ULocpSg==
X-Received: by 2002:a7b:c846:0:b0:3f5:1241:6cfa with SMTP id c6-20020a7bc846000000b003f512416cfamr11162488wml.37.1686766285651;
        Wed, 14 Jun 2023 11:11:25 -0700 (PDT)
Received: from [127.0.1.1] (2001-4dd6-393b-ff-f59e-4402-63f8-7ff5.ipv6dyn.netcologne.de. [2001:4dd6:393b:ff:f59e:4402:63f8:7ff5])
        by smtp.gmail.com with ESMTPSA id a4-20020a056000050400b0030ae3a6be4asm19064801wrf.72.2023.06.14.11.11.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Jun 2023 11:11:22 -0700 (PDT)
From:   Maximilian Weigand <mweigand2017@gmail.com>
Date:   Wed, 14 Jun 2023 20:10:43 +0200
Subject: [PATCH] power: supply: rk817: query battery properties right after
 resume
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230601-rk817_query_at_resume-v1-1-630b0adefbd9@mweigand.net>
X-B4-Tracking: v=1; b=H4sIAKMCimQC/x2NUQrCMBAFr1L220DSFlu8ikjYpE8bpFF3W1FK7
 27q5zAMs5JCEpRO1UqCd9L0yAXcoaI4cr7BpKEw1bZu7NE6I/fedf61QL6eZy/QZYJxbTNE7ju
 Elqm0gRUmCOc47vXEOkN28RRc0+c/PF+27QdwgxNwgAAAAA==
To:     Sebastian Reichel <sre@kernel.org>
Cc:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-rockchip@lists.infradead.org,
        Maximilian Weigand <mweigand@mweigand.net>
X-Mailer: b4 0.12.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1686766281; l=2084;
 i=mweigand@mweigand.net; s=20230601; h=from:subject:message-id;
 bh=dYYdF7YN086t+bI+bbTbtrWGleMgw5W9dZy0f46uHlE=;
 b=0050Ss6VUbL8czKz0Ni0Iq8OTxmawjKMuUQvJMEaTVunWLJNqshnUQEep8X6/b5DHkgp2NZoh
 ez+gUeqQ80IDNyAy0+SUFgK2VlORQzlZObIeRFmUIW2zElUpyG5KdZv
X-Developer-Key: i=mweigand@mweigand.net; a=ed25519;
 pk=Tjuj6PXmCCxzGTRw+9suZuZ41q/etgDHrIbPdkAaTpM=
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Maximilian Weigand <mweigand@mweigand.net>

The driver reads battery properties every 8 seconds. In order to prevent
problems with wrong property values right after resume, trigger an
update of those properties on resuming the system and restart the
8-second interval from there.

Signed-off-by: Maximilian Weigand <mweigand@mweigand.net>
---
An issue with wrongly reported battery charge was encountered on a
Pine64 PineNote right after resume. It turned out the the rk817 driver
queries the rk817 chip in fixed 8-second intervals, and thus in most
cases the reported battery charge right after resume will be wrong until
the driver gets to its next update cycle. For example, upowerd will
query the battery properties right after resume (getting the old
values), while the correct values will only be reported by upowerd after
its next update cycle, which can take 30+ seconds.

Therefore, trigger an update of battery properties right after resume in
the driver.
---
 drivers/power/supply/rk817_charger.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/drivers/power/supply/rk817_charger.c b/drivers/power/supply/rk817_charger.c
index 1a2143641e66..29ceee2f1905 100644
--- a/drivers/power/supply/rk817_charger.c
+++ b/drivers/power/supply/rk817_charger.c
@@ -1198,11 +1198,24 @@ static int rk817_charger_probe(struct platform_device *pdev)
 	return 0;
 }
 
+static int __maybe_unused rk817_resume(struct device *dev)
+{
+
+	struct rk817_charger *charger = dev_get_drvdata(dev);
+
+	/* force an immediate update */
+	mod_delayed_work(system_wq, &charger->work, 0);
+
+	return 0;
+}
+
+static SIMPLE_DEV_PM_OPS(rk817_charger_pm, NULL, rk817_resume);
 
 static struct platform_driver rk817_charger_driver = {
 	.probe    = rk817_charger_probe,
 	.driver   = {
 		.name  = "rk817-charger",
+		.pm		= &rk817_charger_pm,
 	},
 };
 module_platform_driver(rk817_charger_driver);

---
base-commit: 858fd168a95c5b9669aac8db6c14a9aeab446375
change-id: 20230601-rk817_query_at_resume-143dca87eb4a

Best regards,
-- 
Maximilian Weigand <mweigand@mweigand.net>

