Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D0D0B6A0CD0
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Feb 2023 16:24:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234373AbjBWPY1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Feb 2023 10:24:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35460 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233562AbjBWPYZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Feb 2023 10:24:25 -0500
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 1EB5827498
        for <linux-kernel@vger.kernel.org>; Thu, 23 Feb 2023 07:24:24 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id DA04FC14;
        Thu, 23 Feb 2023 07:25:06 -0800 (PST)
Received: from e120937-lin.. (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 28D5C3F587;
        Thu, 23 Feb 2023 07:24:23 -0800 (PST)
From:   Cristian Marussi <cristian.marussi@arm.com>
To:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc:     sudeep.holla@arm.com, Cristian Marussi <cristian.marussi@arm.com>
Subject: [PATCH] firmware: arm_scmi: Fix Raw coexistence mode behaviour on failure path
Date:   Thu, 23 Feb 2023 15:23:30 +0000
Message-Id: <20230223152330.2707260-1-cristian.marussi@arm.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When SCMI Raw coexistence mode is enabled make the core stack probe
successfully even when basic Base protocol exchanges with the platform
server failed.
This behaviour enables the system to boot with a broken regular SCMI stack
but with a fully functional and accessible SCMI Raw debugfs interface that
can be used to further debug the issue.

Signed-off-by: Cristian Marussi <cristian.marussi@arm.com>
---
 drivers/firmware/arm_scmi/driver.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/firmware/arm_scmi/driver.c b/drivers/firmware/arm_scmi/driver.c
index 9d97e44519d9..a75469727dd0 100644
--- a/drivers/firmware/arm_scmi/driver.c
+++ b/drivers/firmware/arm_scmi/driver.c
@@ -2700,6 +2700,7 @@ static int scmi_probe(struct platform_device *pdev)
 	struct scmi_handle *handle;
 	const struct scmi_desc *desc;
 	struct scmi_info *info;
+	bool coex = IS_ENABLED(CONFIG_ARM_SCMI_RAW_MODE_SUPPORT_COEX);
 	struct device *dev = &pdev->dev;
 	struct device_node *child, *np = dev->of_node;
 
@@ -2774,9 +2775,6 @@ static int scmi_probe(struct platform_device *pdev)
 			dev_warn(dev, "Failed to setup SCMI debugfs.\n");
 
 		if (IS_ENABLED(CONFIG_ARM_SCMI_RAW_MODE_SUPPORT)) {
-			bool coex =
-			      IS_ENABLED(CONFIG_ARM_SCMI_RAW_MODE_SUPPORT_COEX);
-
 			ret = scmi_debugfs_raw_mode_setup(info);
 			if (!coex) {
 				if (ret)
@@ -2807,6 +2805,8 @@ static int scmi_probe(struct platform_device *pdev)
 	ret = scmi_protocol_acquire(handle, SCMI_PROTOCOL_BASE);
 	if (ret) {
 		dev_err(dev, "unable to communicate with SCMI\n");
+		if (coex)
+			return 0;
 		goto notification_exit;
 	}
 
-- 
2.34.1

