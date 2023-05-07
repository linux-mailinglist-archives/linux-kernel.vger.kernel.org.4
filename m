Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4C0EE6F9554
	for <lists+linux-kernel@lfdr.de>; Sun,  7 May 2023 02:32:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230494AbjEGAcZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 6 May 2023 20:32:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55956 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230502AbjEGAcQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 6 May 2023 20:32:16 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 169A221573;
        Sat,  6 May 2023 17:31:56 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 1C4666145A;
        Sun,  7 May 2023 00:31:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 66C9DC433D2;
        Sun,  7 May 2023 00:31:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1683419463;
        bh=x94HLNRbcLTPOqzvs73lGBziHJYvCWq2DfQX91kQl4k=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=X1Ftd9zhOZ3Gya2ar46L0VsWfVhDJsoJv+bzyCkzX7KHI+8BrnUhMcGS1/vTj0G3e
         7EnVpjusvdWJXCnXq0fO4GjPsuO+VFP3EG960NTDR/qjkthzj4bwmTmWEsikKf5liU
         mdRch6oQRUEpa9hxQNRYTXfW2HN6U6howCcgVzLAOnRnTsTYfbHzpJHjoJ7Hwx3GAg
         VXY3Mc0EVVyN0s9CplMBoXpfKcAp/Brqpk0pL+Mu3QEXLfDOw57A0A5wsCvzX+04+g
         c1qPqqddhhM0UwSO+qB6LBzRu0jhVRWCgWvSjhlpsEBCKhZBFeABvrMgrpDjcLicBU
         2r+ne+DJ7j6ZQ==
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     =?UTF-8?q?Samuel=20=C4=8Cavoj?= <samuel@cavoj.net>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Sasha Levin <sashal@kernel.org>, hdegoede@redhat.com,
        rafael.j.wysocki@intel.com, error27@gmail.com,
        linux-usb@vger.kernel.org
Subject: [PATCH AUTOSEL 6.3 14/24] usb: typec: ucsi: acpi: add quirk for ASUS Zenbook UM325
Date:   Sat,  6 May 2023 20:30:10 -0400
Message-Id: <20230507003022.4070535-14-sashal@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230507003022.4070535-1-sashal@kernel.org>
References: <20230507003022.4070535-1-sashal@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Samuel Čavoj <samuel@cavoj.net>

[ Upstream commit 326e1c208f3f24d14b93f910b8ae32c94923d22c ]

On some ACPI platforms (namely the ASUS Zenbook UM325) the _DSM method must
not be called after a notification is received but instead the mailbox
should be read immediately from RAM. This is because the ACPI interrupt
handler destroys the CCI in ERAM after copying to system memory, and when
_DSM is later called to perform a second copy, it retrieves a garbage
value.

Instead, the _DSM(read) method should only be called when necessary, i.e.
for polling the state after reset and for retrieving the version. Other
reads should not call _DSM and only peek into the RAM region.

This adds a separate read operation for the Zenbook that syncs the
ACPI mailbox only with polled commands.

Link: https://lore.kernel.org/linux-usb/20210823180626.tb6m7h5tp6adhvt2@fastboi.localdomain/
Signed-off-by: Samuel Čavoj <samuel@cavoj.net>
[ heikki : handling everything in ucsi_acpi.c with DMI quirk ]
Signed-off-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>
Link: https://lore.kernel.org/r/20230405134456.49607-1-heikki.krogerus@linux.intel.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/usb/typec/ucsi/ucsi_acpi.c | 44 ++++++++++++++++++++++++++++--
 1 file changed, 42 insertions(+), 2 deletions(-)

diff --git a/drivers/usb/typec/ucsi/ucsi_acpi.c b/drivers/usb/typec/ucsi/ucsi_acpi.c
index 62206a6b8ea75..217355f1f9b94 100644
--- a/drivers/usb/typec/ucsi/ucsi_acpi.c
+++ b/drivers/usb/typec/ucsi/ucsi_acpi.c
@@ -9,6 +9,7 @@
 #include <linux/platform_device.h>
 #include <linux/module.h>
 #include <linux/acpi.h>
+#include <linux/dmi.h>
 
 #include "ucsi.h"
 
@@ -23,6 +24,7 @@ struct ucsi_acpi {
 	struct completion complete;
 	unsigned long flags;
 	guid_t guid;
+	u64 cmd;
 };
 
 static int ucsi_acpi_dsm(struct ucsi_acpi *ua, int func)
@@ -62,6 +64,7 @@ static int ucsi_acpi_async_write(struct ucsi *ucsi, unsigned int offset,
 	struct ucsi_acpi *ua = ucsi_get_drvdata(ucsi);
 
 	memcpy(ua->base + offset, val, val_len);
+	ua->cmd = *(u64 *)val;
 
 	return ucsi_acpi_dsm(ua, UCSI_DSM_FUNC_WRITE);
 }
@@ -93,13 +96,46 @@ static const struct ucsi_operations ucsi_acpi_ops = {
 	.async_write = ucsi_acpi_async_write
 };
 
+static int
+ucsi_zenbook_read(struct ucsi *ucsi, unsigned int offset, void *val, size_t val_len)
+{
+	struct ucsi_acpi *ua = ucsi_get_drvdata(ucsi);
+	int ret;
+
+	if (offset == UCSI_VERSION || UCSI_COMMAND(ua->cmd) == UCSI_PPM_RESET) {
+		ret = ucsi_acpi_dsm(ua, UCSI_DSM_FUNC_READ);
+		if (ret)
+			return ret;
+	}
+
+	memcpy(val, ua->base + offset, val_len);
+
+	return 0;
+}
+
+static const struct ucsi_operations ucsi_zenbook_ops = {
+	.read = ucsi_zenbook_read,
+	.sync_write = ucsi_acpi_sync_write,
+	.async_write = ucsi_acpi_async_write
+};
+
+static const struct dmi_system_id zenbook_dmi_id[] = {
+	{
+		.matches = {
+			DMI_MATCH(DMI_SYS_VENDOR, "ASUSTeK COMPUTER INC."),
+			DMI_MATCH(DMI_PRODUCT_NAME, "ZenBook UX325UA_UM325UA"),
+		},
+	},
+	{ }
+};
+
 static void ucsi_acpi_notify(acpi_handle handle, u32 event, void *data)
 {
 	struct ucsi_acpi *ua = data;
 	u32 cci;
 	int ret;
 
-	ret = ucsi_acpi_read(ua->ucsi, UCSI_CCI, &cci, sizeof(cci));
+	ret = ua->ucsi->ops->read(ua->ucsi, UCSI_CCI, &cci, sizeof(cci));
 	if (ret)
 		return;
 
@@ -114,6 +150,7 @@ static void ucsi_acpi_notify(acpi_handle handle, u32 event, void *data)
 static int ucsi_acpi_probe(struct platform_device *pdev)
 {
 	struct acpi_device *adev = ACPI_COMPANION(&pdev->dev);
+	const struct ucsi_operations *ops = &ucsi_acpi_ops;
 	struct ucsi_acpi *ua;
 	struct resource *res;
 	acpi_status status;
@@ -143,7 +180,10 @@ static int ucsi_acpi_probe(struct platform_device *pdev)
 	init_completion(&ua->complete);
 	ua->dev = &pdev->dev;
 
-	ua->ucsi = ucsi_create(&pdev->dev, &ucsi_acpi_ops);
+	if (dmi_check_system(zenbook_dmi_id))
+		ops = &ucsi_zenbook_ops;
+
+	ua->ucsi = ucsi_create(&pdev->dev, ops);
 	if (IS_ERR(ua->ucsi))
 		return PTR_ERR(ua->ucsi);
 
-- 
2.39.2

