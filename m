Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 189AF656E5A
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Dec 2022 20:33:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231775AbiL0TdV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Dec 2022 14:33:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50672 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231611AbiL0TdQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Dec 2022 14:33:16 -0500
Received: from mail-il1-x12f.google.com (mail-il1-x12f.google.com [IPv6:2607:f8b0:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F828B1D0
        for <linux-kernel@vger.kernel.org>; Tue, 27 Dec 2022 11:33:10 -0800 (PST)
Received: by mail-il1-x12f.google.com with SMTP id i25so7175559ila.8
        for <linux-kernel@vger.kernel.org>; Tue, 27 Dec 2022 11:33:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=t/vFqs9zTl4UAxKrKxsxms/5j3RJaU9FKMLZvOt0iQs=;
        b=oCDoLpOy+2jWXVLrcvUNlYTWaXjNhm5UxcC8EI6ZFW/yjDEZKrc2o5NKDuzvpelFvN
         nDnx4zEm28GxT3Bp91fsXJ23rf+N9gdP2rAr2J+FzcYns7h1SsiUmFZJDOxo1o+32gaf
         24wk8dKHiJE3Quldwf6ZWdMGR8YM/R7qZQaAg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=t/vFqs9zTl4UAxKrKxsxms/5j3RJaU9FKMLZvOt0iQs=;
        b=seLFgs04YZz9AHKtXzGA95Mmk17PVJe/sTOIWhwBWi4rYQHirJyA9s9s0vzjvDJyiy
         MHD7s5Q0fHpF/61gwQCeRlZDBYutU/2MGxxLSqMGFPVIzkOA/jM9+NDveU12h2ToDrgZ
         6cMDh2fWUOXcQLq3ODp7NdqZZCQLqZyB4zY8YT0mwqaGvFPfcYNmWCstI0sqo7MPlYak
         JVq4Sb7l4Y+kgp2XimTsDjVS8UzRmRkmVdkWBhRNF8R2zUvyOWDRBqSPun2Y2kE/ZhLK
         7Vr3j4uxf2HNv3Rkidgr/fnMIfinitxZzWVgDqmi/Rc5fzyyL6ykglu5SBdFI6ofkcAD
         BesQ==
X-Gm-Message-State: AFqh2kqHH5lspj1HStKm11VnLmU9XLpNeu+UY4vxQfXh8v1JZKuPN1PD
        xleOBNETeLdvHPcw+i1fDgKTQUvlnbhYkpTB
X-Google-Smtp-Source: AMrXdXtzTM1OkqtpgvC+HTQ30IXvgX12WHCehN4EDAO4nxLZcNIFYRDGEoSFyn+PgsHskYw6A+oxPA==
X-Received: by 2002:a05:6e02:1d99:b0:30b:d861:2c84 with SMTP id h25-20020a056e021d9900b0030bd8612c84mr20324642ila.0.1672169589390;
        Tue, 27 Dec 2022 11:33:09 -0800 (PST)
Received: from markhas1.corp.google.com ([100.107.108.223])
        by smtp.gmail.com with ESMTPSA id a10-20020a02ac0a000000b003755a721e98sm4504995jao.107.2022.12.27.11.33.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Dec 2022 11:33:09 -0800 (PST)
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
Subject: [PATCH v13 3/3] platform/chrome: cros_ec_uart: Add DT enumeration support
Date:   Tue, 27 Dec 2022 12:32:24 -0700
Message-Id: <20221227123212.v13.3.Ie23c217d69ff25d7354db942613f143bbc8ef891@changeid>
X-Mailer: git-send-email 2.39.0.314.g84b9a713c41-goog
In-Reply-To: <20221227123212.v13.1.If7926fcbad397bc6990dd725690229bed403948c@changeid>
References: <20221227123212.v13.1.If7926fcbad397bc6990dd725690229bed403948c@changeid>
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

Changes in v13:
- No change

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
index 971ea4bc2df80..0cef2888dffd0 100644
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
2.39.0.314.g84b9a713c41-goog

