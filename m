Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 429E463E1BB
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Nov 2022 21:18:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230194AbiK3USk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Nov 2022 15:18:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56708 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229551AbiK3USN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Nov 2022 15:18:13 -0500
Received: from mail-il1-x12a.google.com (mail-il1-x12a.google.com [IPv6:2607:f8b0:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D9DDA950EB
        for <linux-kernel@vger.kernel.org>; Wed, 30 Nov 2022 12:13:41 -0800 (PST)
Received: by mail-il1-x12a.google.com with SMTP id x12so5690838ilg.1
        for <linux-kernel@vger.kernel.org>; Wed, 30 Nov 2022 12:13:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=K4gs1nqhWEkh1q6oBgpXv2FkSjhvCSKGs/o2Pfz2jr8=;
        b=M/3A/m/rdnLCwq+N0mKcmdE9X0YNCiy+AKyIyVOzqAFNENc7fYG+WQp3vAo7AhXL3I
         /c99IHcFQIxBAKtKzz91w/vQs9yd0iVRHu0YI3a23Rk4+SO7U123BhA/BbYlNt3DyohU
         KKwz+K4DFd/l4UaDzw0Y0Qbq4Skp95Fid0TF8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=K4gs1nqhWEkh1q6oBgpXv2FkSjhvCSKGs/o2Pfz2jr8=;
        b=AjcBoZaUKZuYY1/OvB1WwE3aIKxqpY1XJ7IS3Cv4MmdO3Wib4g5hR7uJQtoZUusD/A
         qTEaC0uXvnc1RDLGBUCV0LVjrQxl2WVBoH6q+k3N6Em8EvKhKWzeWWo48eDmy24fBEo5
         cwTETVeHvQYYCybBX0XD/7IaFi2V3d/3IolcK2my3GfrwKL2BEJmu+FS44knDipYMXWn
         JZn8dM6AoDZWfd3fRUMCIONy8PfAPpfOBa9NOEAzlp9b2/m/qdebfyOBMmbsExUSzNXp
         OAEPv7bKiHS3sgNJE/UZGqbjvT9HbMrV6kCH/6ukTIbOz0nPpZbrfHATz/ILA9k8LSsX
         niNQ==
X-Gm-Message-State: ANoB5pliHmXXK8wN0ARaBEm1BAmerjEjKh2XB7Jbeg2ehrdmtoPU2rSi
        fx5IO6LjfyyEN3hblwWx0Am0vZMYzpnYEQ==
X-Google-Smtp-Source: AA0mqf6T5GN72ySu99K1kzD6N8MC7OS5wEzGjRwq1jjcy6Lq7g/+7JYtHedGalV19WPXMWRa1LRi2A==
X-Received: by 2002:a05:6e02:2197:b0:302:391a:f67b with SMTP id j23-20020a056e02219700b00302391af67bmr22128556ila.265.1669839220208;
        Wed, 30 Nov 2022 12:13:40 -0800 (PST)
Received: from markhas1.lan (184-96-172-159.hlrn.qwest.net. [184.96.172.159])
        by smtp.gmail.com with ESMTPSA id r2-20020a02b102000000b00363e61908bfsm902158jah.10.2022.11.30.12.13.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Nov 2022 12:13:40 -0800 (PST)
From:   Mark Hasemeyer <markhas@chromium.org>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     Raul Rangel <rrangel@chromium.org>,
        Mark Hasemeyer <markhas@chromium.org>,
        Bhanu Prakash Maiya <bhanumaiya@chromium.org>,
        Benson Leung <bleung@google.com>,
        Guenter Roeck <groeck@chromium.org>,
        Tzung-Bi Shih <tzungbi@kernel.org>,
        chrome-platform@lists.linux.dev
Subject: [PATCH v8 3/3] platform/chrome: cros_ec_uart: Add DT enumeration support
Date:   Wed, 30 Nov 2022 13:12:56 -0700
Message-Id: <20221130131245.v8.3.Ie23c217d69ff25d7354db942613f143bbc8ef891@changeid>
X-Mailer: git-send-email 2.38.1.584.g0f3c55d4c2-goog
In-Reply-To: <20221130131245.v8.1.If7926fcbad397bc6990dd725690229bed403948c@changeid>
References: <20221130131245.v8.1.If7926fcbad397bc6990dd725690229bed403948c@changeid>
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

Existing firmware uses the "PRP0001" _HID and an associated compatible
string to enumerate the cros_ec_uart.

Add DT enumeration support for already shipped firmware.

Signed-off-by: Bhanu Prakash Maiya <bhanumaiya@chromium.org>
Signed-off-by: Mark Hasemeyer <markhas@chromium.org>
---

Changes in v8:
- No change

Changes in v7:
- Move PRP0001 enumeration support to its own commit

 drivers/platform/chrome/cros_ec_uart.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/platform/chrome/cros_ec_uart.c b/drivers/platform/chrome/cros_ec_uart.c
index ef9ac7ace04b6..521a3ee6f60b3 100644
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
@@ -385,6 +386,12 @@ static int __maybe_unused cros_ec_uart_resume(struct device *dev)
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
@@ -398,6 +405,7 @@ static struct serdev_device_driver cros_ec_uart_driver = {
 	.driver	= {
 		.name	= "cros-ec-uart",
 		.acpi_match_table = ACPI_PTR(cros_ec_uart_acpi_id),
+		.of_match_table = cros_ec_uart_of_match,
 		.pm	= &cros_ec_uart_pm_ops,
 	},
 	.probe		= cros_ec_uart_probe,
-- 
2.38.1.584.g0f3c55d4c2-goog

