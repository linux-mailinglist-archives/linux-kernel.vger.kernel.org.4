Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 40E97675C75
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Jan 2023 19:10:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229620AbjATSKF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Jan 2023 13:10:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58632 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229524AbjATSKE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Jan 2023 13:10:04 -0500
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E6A97B2D9;
        Fri, 20 Jan 2023 10:10:03 -0800 (PST)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id C8FCB5FBEC;
        Fri, 20 Jan 2023 18:10:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1674238201; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=hkN6PpdG4Lfy4P3q90hNQcwHa4prP8EZfXIbP4VPT1k=;
        b=0kWIhRlhN7HnSu+SxpjJGtYLQu4XcH6zs4to/NIdHtBXBculzP4PLNMAV5+yc4d71dJUaG
        oadi+rIkwbUZxynl0J1hzyIy902XaC9+Ri33hyLzl6K3hX/R36Pv7Q5Mvm2wRfdy2Y3xE+
        w77XGUvo5bAgyWquH5lxT++OBk4wtBQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1674238201;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=hkN6PpdG4Lfy4P3q90hNQcwHa4prP8EZfXIbP4VPT1k=;
        b=pMQoSUb2TTGqCwG6jJMv4mpI6i869ypvc5S+cATJNQF48NGzaXKIy5cpIl8JIQWeK4xXo0
        FcS8/7i4aLHJ0eCA==
Received: from kitsune.suse.cz (kitsune.suse.cz [10.100.12.127])
        by relay2.suse.de (Postfix) with ESMTP id 9E25A2C141;
        Fri, 20 Jan 2023 18:10:01 +0000 (UTC)
From:   Michal Suchanek <msuchanek@suse.de>
To:     Rob Herring <robh+dt@kernel.org>
Cc:     Michal Suchanek <msuchanek@suse.de>,
        "Erhard F." <erhard_f@mailbox.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE" 
        <devicetree@vger.kernel.org>,
        Frank Rowand <frowand.list@gmail.com>,
        open list <linux-kernel@vger.kernel.org>,
        Javier Martinez Canillas <javierm@redhat.com>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        linuxppc-dev@lists.ozlabs.org
Subject: [PATCH v3] of: Make of framebuffer devices unique
Date:   Fri, 20 Jan 2023 19:09:57 +0100
Message-Id: <20230120180958.30798-1-msuchanek@suse.de>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <CAL_JsqKo+mdjA485KDb1ZauJcbOU-FR1G-Z2sYYNu7+Zn32wSA@mail.gmail.com>
References: 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since Linux 5.19 this error is observed:

sysfs: cannot create duplicate filename '/devices/platform/of-display'

This is because multiple devices with the same name 'of-display' are
created on the same bus.

Update the code to create numbered device names for the non-boot
disaplay.

cc: linuxppc-dev@lists.ozlabs.org
References: https://bugzilla.kernel.org/show_bug.cgi?id=216095
Fixes: 52b1b46c39ae ("of: Create platform devices for OF framebuffers")
Reported-by: Erhard F. <erhard_f@mailbox.org>
Suggested-by: Thomas Zimmermann <tzimmermann@suse.de>
Signed-off-by: Michal Suchanek <msuchanek@suse.de>
---
v3:
- merge fix into original patch
- Update the device name format
- add missing const
- do not continue with iterating display devices when formatting device
  name fails
---
 drivers/of/platform.c | 13 +++++++++++--
 1 file changed, 11 insertions(+), 2 deletions(-)

diff --git a/drivers/of/platform.c b/drivers/of/platform.c
index 81c8c227ab6b..4d3a4d9f79f2 100644
--- a/drivers/of/platform.c
+++ b/drivers/of/platform.c
@@ -525,6 +525,9 @@ static int __init of_platform_default_populate_init(void)
 	if (IS_ENABLED(CONFIG_PPC)) {
 		struct device_node *boot_display = NULL;
 		struct platform_device *dev;
+		int display_number = 0;
+		char buf[14];
+		const char *of_display_format = "of-display.%d";
 		int ret;
 
 		/* Check if we have a MacOS display without a node spec */
@@ -555,7 +558,10 @@ static int __init of_platform_default_populate_init(void)
 			if (!of_get_property(node, "linux,opened", NULL) ||
 			    !of_get_property(node, "linux,boot-display", NULL))
 				continue;
-			dev = of_platform_device_create(node, "of-display", NULL);
+			ret = snprintf(buf, sizeof(buf), of_display_format, display_number++);
+			if (ret >= sizeof(buf))
+				return -EOVERFLOW;
+			dev = of_platform_device_create(node, buf, NULL);
 			if (WARN_ON(!dev))
 				return -ENOMEM;
 			boot_display = node;
@@ -564,7 +570,10 @@ static int __init of_platform_default_populate_init(void)
 		for_each_node_by_type(node, "display") {
 			if (!of_get_property(node, "linux,opened", NULL) || node == boot_display)
 				continue;
-			of_platform_device_create(node, "of-display", NULL);
+			ret = snprintf(buf, sizeof(buf), of_display_format, display_number++);
+			if (ret >= sizeof(buf))
+				break;
+			of_platform_device_create(node, buf, NULL);
 		}
 
 	} else {
-- 
2.35.3

