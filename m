Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C97E56476B5
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Dec 2022 20:41:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229717AbiLHTkt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Dec 2022 14:40:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57378 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229985AbiLHTkU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Dec 2022 14:40:20 -0500
Received: from mail-io1-xd36.google.com (mail-io1-xd36.google.com [IPv6:2607:f8b0:4864:20::d36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 658C41AA2D
        for <linux-kernel@vger.kernel.org>; Thu,  8 Dec 2022 11:40:09 -0800 (PST)
Received: by mail-io1-xd36.google.com with SMTP id n188so863529iof.8
        for <linux-kernel@vger.kernel.org>; Thu, 08 Dec 2022 11:40:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MF2GnFpAR/trOfRUw0h2YfNoFU34O3eLGi2QsSIBLfs=;
        b=hPlE8zmRLYztt7X5yzlayM9VZwsGmPFHXExXLXy7fB6CDM3KMd0FfG+TXSCQFj3HQI
         TNA799Zga7eR+gEPSU81vnBcgAS9bocdV3qnLB0KCUJsJG1IECxqxdjcPEmKOhqwygkr
         g1X6EuXc6obBF3e0FSWaTG/04o23f5jkvWHCA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MF2GnFpAR/trOfRUw0h2YfNoFU34O3eLGi2QsSIBLfs=;
        b=mRVtyfJrj27B/KK+jrbvpqM4aM0Uu7n3VjOG7W9fWVS7h9pfWaHGikrthmzn4gGHyS
         v0h8AzFMNZF1SnvBp37e31Vii4KRi+GdRlZ6DHW2OPRA/0nGuJUR29r4nRwbmKY7YYSe
         PevR/lCt/FUEGENh6lP506q3wcJgx4u0LPqEGP4oNev03nPg2cW9zFipLE+NAsFn6xVq
         UGYScYixe1Op3zkUbOJ/Kk2xJmTXxNBLK7f9kcbLYSkwc8Syj2EnYTGAIG8AL9Bl2BGq
         7RPwQ4lIiLABWZ7HwoV/rEWXrbe4o4FFtUkoWCU2QYmq1hZIPN/7C2zdmFtwNn8PZXIJ
         OLEQ==
X-Gm-Message-State: ANoB5pkSlg3gq3QG88n3nAUg9C5UmEkNQ5BYyCPtz5vIJZhjEL/VhW+A
        woVBfc6/fExsHsW5kOhfxoDX3jWM6bSVf3pb
X-Google-Smtp-Source: AA0mqf4HUxa7I5h8YzHUdDeqvcqIxgkPjSTtyeHTtSnHiCQBhTKqlHCF2IR0+G+K5L9dbJgS0pVJ/g==
X-Received: by 2002:a05:6602:184f:b0:6e2:ca58:695 with SMTP id d15-20020a056602184f00b006e2ca580695mr2038236ioi.3.1670528399577;
        Thu, 08 Dec 2022 11:39:59 -0800 (PST)
Received: from markhas1.roam.corp.google.com (63-225-246-100.hlrn.qwest.net. [63.225.246.100])
        by smtp.gmail.com with ESMTPSA id b5-20020a05660214c500b006df13af1f16sm9245441iow.50.2022.12.08.11.39.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Dec 2022 11:39:59 -0800 (PST)
From:   Mark Hasemeyer <markhas@chromium.org>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     Raul Rangel <rrangel@chromium.org>,
        Bhanu Prakash Maiya <bhanumaiya@chromium.org>,
        Mark Hasemeyer <markhas@chromium.org>,
        Benson Leung <bleung@chromium.org>,
        Guenter Roeck <groeck@chromium.org>,
        Tzung-Bi Shih <tzungbi@kernel.org>,
        chrome-platform@lists.linux.dev
Subject: [PATCH v11 3/3] platform/chrome: cros_ec_uart: Add DT enumeration support
Date:   Thu,  8 Dec 2022 12:39:52 -0700
Message-Id: <20221208123944.v11.3.Ie23c217d69ff25d7354db942613f143bbc8ef891@changeid>
X-Mailer: git-send-email 2.39.0.rc1.256.g54fd8350bd-goog
In-Reply-To: <20221208123944.v11.1.If7926fcbad397bc6990dd725690229bed403948c@changeid>
References: <20221208123944.v11.1.If7926fcbad397bc6990dd725690229bed403948c@changeid>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Bhanu Prakash Maiya <bhanumaiya@chromium.org>

Existing firmware uses the "PRP0001" _HID and an associated compatible
string to enumerate the cros_ec_uart.

Add DT enumeration support for already shipped firmware.

Signed-off-by: Bhanu Prakash Maiya <bhanumaiya@chromium.org>
Co-developed-by: Mark Hasemeyer <markhas@chromium.org>
Signed-off-by: Mark Hasemeyer <markhas@chromium.org>

---

Changes in v11:
- No change

Changes in v10:
- No change

Changes in v9:
- Rebase onto for-next
- Update authorship

Changes in v8:
- No change

Changes in v7:
- Move PRP0001 enumeration support to its own commit

 drivers/platform/chrome/cros_ec_uart.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/platform/chrome/cros_ec_uart.c b/drivers/platform/chrome/cros_ec_uart.c
index 43a7493347a59..bf0c291914725 100644
--- a/drivers/platform/chrome/cros_ec_uart.c
+++ b/drivers/platform/chrome/cros_ec_uart.c
@@ -11,6 +11,7 @@
 #include <linux/init.h>
 #include <linux/kernel.h>
 #include <linux/module.h>
+#include <linux/of.h>
 #include <linux/platform_data/cros_ec_proto.h>
 #include <linux/serdev.h>
 #include <linux/slab.h>
@@ -326,6 +327,12 @@ static int __maybe_unused cros_ec_uart_resume(struct device *dev)
 static SIMPLE_DEV_PM_OPS(cros_ec_uart_pm_ops, cros_ec_uart_suspend,
 			 cros_ec_uart_resume);
 
+static const struct of_device_id cros_ec_uart_of_match[] = {
+	{ .compatible = "google,cros-ec-uart" },
+	{}
+};
+MODULE_DEVICE_TABLE(of, cros_ec_uart_of_match);
+
 #ifdef CONFIG_ACPI
 static const struct acpi_device_id cros_ec_uart_acpi_id[] = {
 	{ "GOOG0019", 0 },
@@ -339,6 +346,7 @@ static struct serdev_device_driver cros_ec_uart_driver = {
 	.driver	= {
 		.name	= "cros-ec-uart",
 		.acpi_match_table = ACPI_PTR(cros_ec_uart_acpi_id),
+		.of_match_table = cros_ec_uart_of_match,
 		.pm	= &cros_ec_uart_pm_ops,
 	},
 	.probe		= cros_ec_uart_probe,
-- 
2.39.0.rc1.256.g54fd8350bd-goog

