Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4F6C96F9582
	for <lists+linux-kernel@lfdr.de>; Sun,  7 May 2023 02:34:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231727AbjEGAe2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 6 May 2023 20:34:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57284 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231356AbjEGAdy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 6 May 2023 20:33:54 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B40B1F48A;
        Sat,  6 May 2023 17:33:41 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 17A25614D2;
        Sun,  7 May 2023 00:33:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7F39EC433D2;
        Sun,  7 May 2023 00:33:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1683419596;
        bh=x94HLNRbcLTPOqzvs73lGBziHJYvCWq2DfQX91kQl4k=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=u7o89mDRgvi4X8p+373zuB/BHEepceOaWyN0IoYUqCEZ/RgV7orLspTpW4OksA+CR
         R4GWN6VREw76ek6Z+IDXo/yU5pDQQdhxN6rnBgSfMQ6v8UdB2RZz2S27KB6w68MZpQ
         qNFCnGYNz3JkfOZJVZORVTmuc3MRrAIoP3rFdpC/von8t2CDdTVkny0Eg9c2Filkss
         gry/KFZKRbdpbct6j4uyz2YGv6GuAK4cJQPrQXpG31JCl65WGvdKoPlfEZL8DpbMOR
         F0pJAK0jT3z1aat/dxh1oL7Uv4wyuOj1FZv5ut3a8Tc2YZdjQ3kb2HSZQbYzsk7Aag
         aHFiF7As4CYJQ==
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     =?UTF-8?q?Samuel=20=C4=8Cavoj?= <samuel@cavoj.net>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Sasha Levin <sashal@kernel.org>, rafael.j.wysocki@intel.com,
        error27@gmail.com, hdegoede@redhat.com, linux-usb@vger.kernel.org
Subject: [PATCH AUTOSEL 6.2 11/20] usb: typec: ucsi: acpi: add quirk for ASUS Zenbook UM325
Date:   Sat,  6 May 2023 20:32:26 -0400
Message-Id: <20230507003237.4074305-11-sashal@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230507003237.4074305-1-sashal@kernel.org>
References: <20230507003237.4074305-1-sashal@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
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

