Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B1392646076
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Dec 2022 18:40:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230055AbiLGRkh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Dec 2022 12:40:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46484 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229728AbiLGRk1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Dec 2022 12:40:27 -0500
Received: from mail-io1-xd29.google.com (mail-io1-xd29.google.com [IPv6:2607:f8b0:4864:20::d29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B176117F
        for <linux-kernel@vger.kernel.org>; Wed,  7 Dec 2022 09:40:26 -0800 (PST)
Received: by mail-io1-xd29.google.com with SMTP id n63so7778509iod.7
        for <linux-kernel@vger.kernel.org>; Wed, 07 Dec 2022 09:40:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7AOuwreGgWBZ48meXtIQ/os+4XBQo160kH7z5x79khw=;
        b=Dvdm7agXaDNguMbyo8u06WGXNm5xdcejs53tMqoSM1hVGgY7grIWQi8iVqYbnpaH+7
         WawsM41ZigZLSk6Z+KW1GuIaH+1xDAsRadTt7uHosDdvlL2IPXvRKnQA+XsOT9q5jSQ4
         dkJhrcv+qGK4bKW20aG9/0lcZdZUsi1kK+tCU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7AOuwreGgWBZ48meXtIQ/os+4XBQo160kH7z5x79khw=;
        b=TArpmhI8x6yoAgVIN/JKAhdOTwdoFlMh8W0GxQby/Fn3Bd+XF9fjhPrIk9jxZfrsGm
         zXNLBG/spmv1VRfQwFHm79bPV1Af4+B090TWIReUVFEKc3r3oIMFz0yYGdTMeKNpvK+Y
         IXhVvcqdyP4vT8eX3dMLGKx/0uCXuT/L9IMxMYY6N/8B3z0cAyx7xlxI5WnteIEcC1ac
         tdvehnVyQtfjx+N1yjGcqWAyzBq95WswMS6aDQ9vq4OvVj8i+8VI4zkkidOaGDv+eQVT
         7izSexKF86r/4YTooZc1mLFp2hjsDGgVmfZVIuInSYXifVytAtka3TUHqIJi2qkXecmY
         QnXA==
X-Gm-Message-State: ANoB5plhw1RQar06zWTQW/huoj4F48jVLp7WkbG54mq3KI9lf1wVOk45
        IvMeSiQoycPfXL98Q4nwKqD8w5KTw0vfITsM
X-Google-Smtp-Source: AA0mqf7RjJO0JDLfzyaLcRNRDdlrZ9OplkdryElY797AUvXkfvucIAxiTZco4PylZHXpRt6wtcglpg==
X-Received: by 2002:a05:6602:4145:b0:6e0:992:d816 with SMTP id bv5-20020a056602414500b006e00992d816mr7112996iob.77.1670434825527;
        Wed, 07 Dec 2022 09:40:25 -0800 (PST)
Received: from markhas1.roam.corp.google.com (63-225-246-100.hlrn.qwest.net. [63.225.246.100])
        by smtp.gmail.com with ESMTPSA id q18-20020a920512000000b0030341bffab8sm32782ile.31.2022.12.07.09.40.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Dec 2022 09:40:25 -0800 (PST)
From:   Mark Hasemeyer <markhas@chromium.org>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     Raul Rangel <rrangel@chromium.org>,
        Bhanu Prakash Maiya <bhanumaiya@chromium.org>,
        Mark Hasemeyer <markhas@chromium.org>,
        Benson Leung <bleung@chromium.org>,
        Guenter Roeck <groeck@chromium.org>,
        Tzung-Bi Shih <tzungbi@kernel.org>,
        chrome-platform@lists.linux.dev
Subject: [PATCH v10 3/3] platform/chrome: cros_ec_uart: Add DT enumeration support
Date:   Wed,  7 Dec 2022 10:40:13 -0700
Message-Id: <20221207104005.v10.3.Ie23c217d69ff25d7354db942613f143bbc8ef891@changeid>
X-Mailer: git-send-email 2.39.0.rc1.256.g54fd8350bd-goog
In-Reply-To: <20221207104005.v10.1.If7926fcbad397bc6990dd725690229bed403948c@changeid>
References: <20221207104005.v10.1.If7926fcbad397bc6990dd725690229bed403948c@changeid>
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
index 873aee4172bfd..70e337717508a 100644
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
@@ -332,6 +333,12 @@ static int __maybe_unused cros_ec_uart_resume(struct device *dev)
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
 	{ "GOOG0019", 0 }
@@ -344,6 +351,7 @@ static struct serdev_device_driver cros_ec_uart_driver = {
 	.driver	= {
 		.name	= "cros-ec-uart",
 		.acpi_match_table = ACPI_PTR(cros_ec_uart_acpi_id),
+		.of_match_table = cros_ec_uart_of_match,
 		.pm	= &cros_ec_uart_pm_ops,
 	},
 	.probe		= cros_ec_uart_probe,
-- 
2.39.0.rc1.256.g54fd8350bd-goog

