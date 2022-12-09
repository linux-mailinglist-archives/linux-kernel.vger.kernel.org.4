Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7735564867B
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Dec 2022 17:26:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229763AbiLIQ0j (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Dec 2022 11:26:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60780 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229556AbiLIQ0b (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Dec 2022 11:26:31 -0500
Received: from mail-il1-x136.google.com (mail-il1-x136.google.com [IPv6:2607:f8b0:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F32486F5A
        for <linux-kernel@vger.kernel.org>; Fri,  9 Dec 2022 08:26:30 -0800 (PST)
Received: by mail-il1-x136.google.com with SMTP id x12so147225ilg.1
        for <linux-kernel@vger.kernel.org>; Fri, 09 Dec 2022 08:26:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LET7+BVLD7u2mz2p/Z3V+N5nYBkLwsfyiST0eTO7hzc=;
        b=NDNMKLLDBAWf3MbF+6zPgovX77wTaVAyPMqg01VPkudPh14T1CwOao5Z19mx2+2xV7
         FTo99ZqyJQ83ny1hGx7ubIC4VplT5IlyRzD4g+UjgtMNKneXVSelvMsYF6GYqUyu48hU
         iJz/SJ0ywZgJyvxcUzTBEYtGf8wooFhu7IDSs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LET7+BVLD7u2mz2p/Z3V+N5nYBkLwsfyiST0eTO7hzc=;
        b=esXlpaABUe7RF1X83D+ElMxZtYkk/vvXYMo7VJebrTcKImzYVqsSGZ4Ao3YQZ3Bsw0
         BYWEWPCQlPZ46eTOh3F2NiDtChKy2Hc0sgEsMZPB5OtMM/t1fKhBB0tgMOouctBjFz0l
         h1/6j0/RrLhi63wVubwqngb7A/FwN5AlhMntztrnpYLNogzw9JYUFUkqp1KUHAFhcdt9
         w8KC5kWFCdNMBJecXFSOZWNQuLxRNUOQlh6rN0VhuzuJxGV++4op2livaos7P5I70rWU
         7tfuQo6qMPft4Pz4TDTBHbPvRKRj9hWw2JeYsj7CHdUfdrqNDu2EKAWm/M4rEganwsjp
         nkgA==
X-Gm-Message-State: ANoB5pneL7kHta1Y98UTF6k4b6h/5olPpw7aPx+BDsUVsa9k3Q1YHhiL
        ZM7u6jnwEqp1Pn1gqDJ56GUikgjPt5p19HhT
X-Google-Smtp-Source: AA0mqf7uI6aQYrVVsoULaPvpOL/5vXuK5Rne8e1xh4Y/XIf48fOnoV5sJ274O/1EpgGZjeFYKlMMtA==
X-Received: by 2002:a92:d9ce:0:b0:303:2f20:1a05 with SMTP id n14-20020a92d9ce000000b003032f201a05mr3535629ilq.24.1670603189613;
        Fri, 09 Dec 2022 08:26:29 -0800 (PST)
Received: from markhas1.roam.corp.google.com (63-225-246-100.hlrn.qwest.net. [63.225.246.100])
        by smtp.gmail.com with ESMTPSA id b2-20020a92dcc2000000b002e85e8b8d1dsm556531ilr.5.2022.12.09.08.26.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Dec 2022 08:26:29 -0800 (PST)
From:   Mark Hasemeyer <markhas@chromium.org>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     Raul Rangel <rrangel@chromium.org>,
        Bhanu Prakash Maiya <bhanumaiya@chromium.org>,
        Mark Hasemeyer <markhas@chromium.org>,
        Prashant Malani <pmalani@chromium.org>,
        Benson Leung <bleung@chromium.org>,
        Guenter Roeck <groeck@chromium.org>,
        Tzung-Bi Shih <tzungbi@kernel.org>,
        chrome-platform@lists.linux.dev
Subject: [PATCH v12 3/3] platform/chrome: cros_ec_uart: Add DT enumeration support
Date:   Fri,  9 Dec 2022 09:26:24 -0700
Message-Id: <20221209092619.v12.3.Ie23c217d69ff25d7354db942613f143bbc8ef891@changeid>
X-Mailer: git-send-email 2.39.0.rc1.256.g54fd8350bd-goog
In-Reply-To: <20221209092619.v12.1.If7926fcbad397bc6990dd725690229bed403948c@changeid>
References: <20221209092619.v12.1.If7926fcbad397bc6990dd725690229bed403948c@changeid>
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
Reviewed-by: Prashant Malani <pmalani@chromium.org>

---

Changes in v12:
- Add Reviewed-by: Prashant Malani <pmalani@chromium.org>

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

