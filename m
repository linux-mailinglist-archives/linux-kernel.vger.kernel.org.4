Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 513346734D1
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Jan 2023 10:53:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230198AbjASJxw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Jan 2023 04:53:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33706 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229515AbjASJxs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Jan 2023 04:53:48 -0500
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 315D15D106;
        Thu, 19 Jan 2023 01:53:47 -0800 (PST)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id D8E7E38562;
        Thu, 19 Jan 2023 09:53:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1674122025; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=K5Wjtf9hLzRkuQgSxBaDv2x2hWptBx8DnMTdLdxBFys=;
        b=JmeRmKIxA6LcTyfKL46wUKQQNW++j5YCwI2EWzrWqc5lJBCJIisF2fK988F9sSL9hOiPLb
        7VDN++/nwTj39/JeiH2rRbyjjJ3Lybm1hAjvfdiXu1dj6hmt2KO/8opk+B/kYdfQBKc4K1
        hK5CGO2UJtE0+0SnXEbldehQ/6TlDAY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1674122025;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=K5Wjtf9hLzRkuQgSxBaDv2x2hWptBx8DnMTdLdxBFys=;
        b=W4gz9+a1bRbUTmeUmj43HT5F78l511dttU0eg+3fYuLsqWanKN8UgFIovvKDV5LDR+eYhH
        +5jwqSM1gnnDzMDw==
Received: from kitsune.suse.cz (kitsune.suse.cz [10.100.12.127])
        by relay2.suse.de (Postfix) with ESMTP id A9E912C141;
        Thu, 19 Jan 2023 09:53:45 +0000 (UTC)
From:   Michal Suchanek <msuchanek@suse.de>
To:     "Erhard F." <erhard_f@mailbox.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Rob Herring <robh+dt@kernel.org>
Cc:     Michal Suchanek <msuchanek@suse.de>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE" 
        <devicetree@vger.kernel.org>, linuxppc-dev@lists.ozlabs.org,
        Javier Martinez Canillas <javierm@redhat.com>,
        open list <linux-kernel@vger.kernel.org>,
        Frank Rowand <frowand.list@gmail.com>
Subject: [PATCH v2] of: Fix of platform build on powerpc due to bad of disaply code
Date:   Thu, 19 Jan 2023 10:53:23 +0100
Message-Id: <20230119095323.4659-1-msuchanek@suse.de>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20230118215045.5551-1-msuchanek@suse.de>
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

The commit 2d681d6a23a1 ("of: Make of framebuffer devices unique")
breaks build because of wrong argument to snprintf. That certainly
avoids the runtime error but is not the intended outcome.

Also use standard device name format of-display.N for all created
devices.

Fixes: 2d681d6a23a1 ("of: Make of framebuffer devices unique")
Signed-off-by: Michal Suchanek <msuchanek@suse.de>
---
v2: Update the device name format
---
 drivers/of/platform.c | 12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

diff --git a/drivers/of/platform.c b/drivers/of/platform.c
index f2a5d679a324..8c1b1de22036 100644
--- a/drivers/of/platform.c
+++ b/drivers/of/platform.c
@@ -525,7 +525,9 @@ static int __init of_platform_default_populate_init(void)
 	if (IS_ENABLED(CONFIG_PPC)) {
 		struct device_node *boot_display = NULL;
 		struct platform_device *dev;
-		int display_number = 1;
+		int display_number = 0;
+		char buf[14];
+		char *of_display_format = "of-display.%d";
 		int ret;
 
 		/* Check if we have a MacOS display without a node spec */
@@ -556,7 +558,10 @@ static int __init of_platform_default_populate_init(void)
 			if (!of_get_property(node, "linux,opened", NULL) ||
 			    !of_get_property(node, "linux,boot-display", NULL))
 				continue;
-			dev = of_platform_device_create(node, "of-display", NULL);
+			ret = snprintf(buf, sizeof(buf), of_display_format, display_number++);
+			if (ret >= sizeof(buf))
+				continue;
+			dev = of_platform_device_create(node, buf, NULL);
 			if (WARN_ON(!dev))
 				return -ENOMEM;
 			boot_display = node;
@@ -564,10 +569,9 @@ static int __init of_platform_default_populate_init(void)
 		}
 
 		for_each_node_by_type(node, "display") {
-			char *buf[14];
 			if (!of_get_property(node, "linux,opened", NULL) || node == boot_display)
 				continue;
-			ret = snprintf(buf, "of-display-%d", display_number++);
+			ret = snprintf(buf, sizeof(buf), of_display_format, display_number++);
 			if (ret >= sizeof(buf))
 				continue;
 			of_platform_device_create(node, buf, NULL);
-- 
2.35.3

