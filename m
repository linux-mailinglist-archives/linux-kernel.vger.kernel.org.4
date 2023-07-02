Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5747474520E
	for <lists+linux-kernel@lfdr.de>; Sun,  2 Jul 2023 22:04:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232128AbjGBUD7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 2 Jul 2023 16:03:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49360 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233505AbjGBUDW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 2 Jul 2023 16:03:22 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F4FA10E6;
        Sun,  2 Jul 2023 13:00:07 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 88FF760C98;
        Sun,  2 Jul 2023 19:51:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 33DB4C433C7;
        Sun,  2 Jul 2023 19:51:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1688327490;
        bh=4pvMoacaA60G7V3hYy9YvZAexu4GvTj9gc943PFNtyg=;
        h=From:To:Cc:Subject:Date:From;
        b=ZirpLE4WPIERM+t5CfVUQaLZhQcO+ZqgHw/is6aXYEYMPaXs2q3MPYF79cN2ogDG1
         BV+8MjDgB4shCBMCMtRq3ueb63NFUbA9juKQ2851qleXIQqDZRZW6GHgQEiaw5t8P6
         bTuqHGmKqtd8EbkvS5R0UCZ1d/Le1kh1xPSewA0ivLdy4bpbWsCQWoFn+ZXfdJW+r9
         g3qsBcmHx68i/J+5AJnB9O42FdZdQLiRQPyYNTE7jH+h06JzJgNHhkGllvfCvM1lBN
         GU09GdpZzfeV5xUfrMbHOBF/ujlEZOpdtNR0bHNuAQLSvvK21CZA0Wb1fE7EYY5y7C
         +/urNp6rofqrg==
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Rob Barnes <robbarnes@google.com>,
        Prashant Malani <pmalani@chromium.org>,
        Tzung-Bi Shih <tzungbi@kernel.org>,
        Sasha Levin <sashal@kernel.org>, bleung@chromium.org,
        chrome-platform@lists.linux.dev
Subject: [PATCH AUTOSEL 6.3 01/11] platform/chrome: cros_ec: Report EC panic as uevent
Date:   Sun,  2 Jul 2023 15:51:17 -0400
Message-Id: <20230702195127.1787911-1-sashal@kernel.org>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.3.11
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Rob Barnes <robbarnes@google.com>

[ Upstream commit 2cbf475a04b2ae3d722bbe41742e5d874a027fc3 ]

Create a uevent when an EC panic is detected. This will allow udev rules
to trigger when a panic occurs. For example, a udev rule could be added to
capture an EC coredump. This approach avoids the need to stuff all the
processing into the driver.

Signed-off-by: Rob Barnes <robbarnes@google.com>
Reviewed-by: Prashant Malani <pmalani@chromium.org>
Signed-off-by: Tzung-Bi Shih <tzungbi@kernel.org>
Link: https://lore.kernel.org/r/20230509232624.3120347-1-robbarnes@google.com
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/platform/chrome/cros_ec_lpc.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/platform/chrome/cros_ec_lpc.c b/drivers/platform/chrome/cros_ec_lpc.c
index 68bba0fcafab3..2b1ce3e1abf2e 100644
--- a/drivers/platform/chrome/cros_ec_lpc.c
+++ b/drivers/platform/chrome/cros_ec_lpc.c
@@ -16,6 +16,7 @@
 #include <linux/delay.h>
 #include <linux/io.h>
 #include <linux/interrupt.h>
+#include <linux/kobject.h>
 #include <linux/module.h>
 #include <linux/platform_data/cros_ec_commands.h>
 #include <linux/platform_data/cros_ec_proto.h>
@@ -315,6 +316,7 @@ static int cros_ec_lpc_readmem(struct cros_ec_device *ec, unsigned int offset,
 
 static void cros_ec_lpc_acpi_notify(acpi_handle device, u32 value, void *data)
 {
+	static const char *env[] = { "ERROR=PANIC", NULL };
 	struct cros_ec_device *ec_dev = data;
 	bool ec_has_more_events;
 	int ret;
@@ -324,6 +326,7 @@ static void cros_ec_lpc_acpi_notify(acpi_handle device, u32 value, void *data)
 	if (value == ACPI_NOTIFY_CROS_EC_PANIC) {
 		dev_emerg(ec_dev->dev, "CrOS EC Panic Reported. Shutdown is imminent!");
 		blocking_notifier_call_chain(&ec_dev->panic_notifier, 0, ec_dev);
+		kobject_uevent_env(&ec_dev->dev->kobj, KOBJ_CHANGE, (char **)env);
 		/* Begin orderly shutdown. Force shutdown after 1 second. */
 		hw_protection_shutdown("CrOS EC Panic", 1000);
 		/* Do not query for other events after a panic is reported */
-- 
2.39.2

