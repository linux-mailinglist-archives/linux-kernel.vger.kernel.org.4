Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2059C642382
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Dec 2022 08:20:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231768AbiLEHUa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Dec 2022 02:20:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56016 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231680AbiLEHUY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Dec 2022 02:20:24 -0500
Received: from mail-il1-x129.google.com (mail-il1-x129.google.com [IPv6:2607:f8b0:4864:20::129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 81AE11004C
        for <linux-kernel@vger.kernel.org>; Sun,  4 Dec 2022 23:20:22 -0800 (PST)
Received: by mail-il1-x129.google.com with SMTP id d14so4725213ilq.11
        for <linux-kernel@vger.kernel.org>; Sun, 04 Dec 2022 23:20:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TFBuZgmPhW5LWntAwnJs0BrrqusNQIYCnHrYxYRlVks=;
        b=lkVVjG0Z8biqffn+OcAxsV1R0osXrCwi99bUnP2ndNZ3RweZZUHZ7VQyJmGuBmPjTI
         CpEgr1GsyGSbxYh2KToeaLCzobKs429ZafFNtxbE4nDlqdI8OA6fUQ1VfTjrL2AcziYA
         SYobP9ouwyxsQJalBeaFVZC8SWurgcVnPludY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TFBuZgmPhW5LWntAwnJs0BrrqusNQIYCnHrYxYRlVks=;
        b=TsCDlSfUYClt3UBxzyVTW15j/weUgRZYxjh51SGzqDZGurscX/vD1f5brAtKxDmL8S
         cY3/OUmXRrFUyPtl+enIH3tYiMn+kmutPLRuBPYiU5M2bxfNmqEHQ5KLNRAhRaBreZAn
         z7UoB7OwsiFdhB2jcCzZWJXiQLdVSd2vYaPETA5QcOODBnXDk3Px1MG/EDfjrWW0/rlb
         UW2LwrbNLzBms19F0TgfqBCENV47aZc9B9dhMrWNGhION1plYHAGsHYa5yMW/vEDOrLp
         jpY4bXAe43ovTkLZAR5biZ/JzH4zTBHty0ekyLV74Cwpc5llsFELBHMAze1UcPl3yR+M
         woOQ==
X-Gm-Message-State: ANoB5pl4wjwQUVMtd3G1K5uLPY4avP1fbjsvdda91Ot/YXplkOk2PUGK
        oEZEbxxlroG15UiBEd/zM3W0rS7hrs6OVnNC
X-Google-Smtp-Source: AA0mqf5UQ+K5oGoOgAf0qW6vHXRTW1JfVIl85uBn5614aWT7wRKgHIDraWpOGZLqOSOKx+zjm/JYaA==
X-Received: by 2002:a05:6e02:1785:b0:303:542:f2c5 with SMTP id y5-20020a056e02178500b003030542f2c5mr18835048ilu.176.1670224821754;
        Sun, 04 Dec 2022 23:20:21 -0800 (PST)
Received: from markhas1.roam.corp.google.com (63-225-246-100.hlrn.qwest.net. [63.225.246.100])
        by smtp.gmail.com with ESMTPSA id a8-20020a021608000000b003755aa71fffsm5581184jaa.105.2022.12.04.23.20.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 04 Dec 2022 23:20:21 -0800 (PST)
From:   Mark Hasemeyer <markhas@chromium.org>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     Raul Rangel <rrangel@chromium.org>,
        Bhanu Prakash Maiya <bhanumaiya@chromium.org>,
        Mark Hasemeyer <markhas@chromium.org>,
        Benson Leung <bleung@chromium.org>,
        Guenter Roeck <groeck@chromium.org>,
        Tzung-Bi Shih <tzungbi@kernel.org>,
        chrome-platform@lists.linux.dev
Subject: [PATCH v9 3/3] platform/chrome: cros_ec_uart: Add DT enumeration support
Date:   Mon,  5 Dec 2022 00:20:01 -0700
Message-Id: <20221205001932.v9.3.Ie23c217d69ff25d7354db942613f143bbc8ef891@changeid>
X-Mailer: git-send-email 2.39.0.rc0.267.gcb52ba06e7-goog
In-Reply-To: <20221205001932.v9.1.If7926fcbad397bc6990dd725690229bed403948c@changeid>
References: <20221205001932.v9.1.If7926fcbad397bc6990dd725690229bed403948c@changeid>
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
index 4b416441f973c..ea4922238eaae 100644
--- a/drivers/platform/chrome/cros_ec_uart.c
+++ b/drivers/platform/chrome/cros_ec_uart.c
@@ -11,6 +11,7 @@
 #include <linux/init.h>
 #include <linux/kernel.h>
 #include <linux/module.h>
+#include <linux/of.h>
 #include <linux/platform_data/cros_ec_commands.h>
 #include <linux/platform_data/cros_ec_proto.h>
 #include <linux/serdev.h>
@@ -347,6 +348,12 @@ static int __maybe_unused cros_ec_uart_resume(struct device *dev)
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
@@ -360,6 +367,7 @@ static struct serdev_device_driver cros_ec_uart_driver = {
 	.driver	= {
 		.name	= "cros-ec-uart",
 		.acpi_match_table = ACPI_PTR(cros_ec_uart_acpi_id),
+		.of_match_table = cros_ec_uart_of_match,
 		.pm	= &cros_ec_uart_pm_ops,
 	},
 	.probe		= cros_ec_uart_probe,
-- 
2.39.0.rc0.267.gcb52ba06e7-goog

