Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5E1E4686B75
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Feb 2023 17:23:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231364AbjBAQXG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Feb 2023 11:23:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57072 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230032AbjBAQXB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Feb 2023 11:23:01 -0500
Received: from mail-ot1-f50.google.com (mail-ot1-f50.google.com [209.85.210.50])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 796B87692;
        Wed,  1 Feb 2023 08:22:59 -0800 (PST)
Received: by mail-ot1-f50.google.com with SMTP id d21-20020a056830005500b0068bd2e0b25bso2674381otp.1;
        Wed, 01 Feb 2023 08:22:59 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=R40wPAUHV11BoLIxg3n5Gsakpb6u6fji29HG4MLTY4o=;
        b=ZvFFJCwwwAO5Fw1Nns7IPmazHQaJlzIN9/v1oCydo0HvK7kY0RFIwhQSjjgLZyuJUm
         MHDmgz5GNcbNktx5xPlpIu2l1f4NBkvb+URZ8qxz3Rvcepk2lTmCJ/WAhTLGmPsgHF7Q
         1IfjrzDjFi1pwHlZzpfJa01GFKX8/37Wr58d/8WVm6sAxnOrgHUDL9unIDpPXKwwn6uS
         80R03qbbTubUAhFTVirhAhrbuMTB2IYJo6oQDEHIQMHANXYfiXMr/iuux9Eh6jpQtcX2
         zoFLPbURJh/4obhdvufupXmM8lnkWY4UQMFiJYzqto4qbbzKwuQ2cD1upj3DXfAVDddu
         Z1XA==
X-Gm-Message-State: AO0yUKXxX/LsCcy/EpEGHYSaUpA5CSE+mbVcJVAxeuryhNXmJDYu4Px3
        uk999iDhSLi77v+oWvmhI7tKHEClTw==
X-Google-Smtp-Source: AK7set/UX1tfLsIgf/HC8D7E26Rttu7INRWLZgG9CGpFRsZtZJmjwG0t2Ty7lv8janpvOOJu5kq1nA==
X-Received: by 2002:a05:6830:2b1f:b0:68b:c04d:79ca with SMTP id l31-20020a0568302b1f00b0068bc04d79camr2413569otv.33.1675268578345;
        Wed, 01 Feb 2023 08:22:58 -0800 (PST)
Received: from robh_at_kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id c20-20020a9d6854000000b006864ccdb053sm5694860oto.26.2023.02.01.08.22.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Feb 2023 08:22:58 -0800 (PST)
Received: (nullmailer pid 3575712 invoked by uid 1000);
        Wed, 01 Feb 2023 16:22:57 -0000
From:   Rob Herring <robh@kernel.org>
To:     Frank Rowand <frowand.list@gmail.com>,
        Javier Martinez Canillas <javierm@redhat.com>,
        Thomas Zimmermann <tzimmermann@suse.de>
Cc:     Michal Suchanek <msuchanek@suse.de>, linuxppc-dev@lists.ozlabs.org,
        "Erhard F ." <erhard_f@mailbox.org>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v4] of: Make OF framebuffer device names unique
Date:   Wed,  1 Feb 2023 10:22:47 -0600
Message-Id: <20230201162247.3575506-1-robh@kernel.org>
X-Mailer: git-send-email 2.39.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Michal Suchanek <msuchanek@suse.de>

Since Linux 5.19 this error is observed:

sysfs: cannot create duplicate filename '/devices/platform/of-display'

This is because multiple devices with the same name 'of-display' are
created on the same bus. Update the code to create numbered device names
for the displays.

Also, fix a node refcounting issue when exiting the boot display loop.

cc: linuxppc-dev@lists.ozlabs.org
References: https://bugzilla.kernel.org/show_bug.cgi?id=216095
Fixes: 52b1b46c39ae ("of: Create platform devices for OF framebuffers")
Reported-by: Erhard F. <erhard_f@mailbox.org>
Suggested-by: Thomas Zimmermann <tzimmermann@suse.de>
Signed-off-by: Michal Suchanek <msuchanek@suse.de>
Link: https://lore.kernel.org/r/20230120180958.30798-1-msuchanek@suse.de
[robh: Rework to avoid node refcount leaks]
Signed-off-by: Rob Herring <robh@kernel.org>
---
 drivers/of/platform.c | 12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

diff --git a/drivers/of/platform.c b/drivers/of/platform.c
index 81c8c227ab6b..b3878a98d27f 100644
--- a/drivers/of/platform.c
+++ b/drivers/of/platform.c
@@ -525,6 +525,7 @@ static int __init of_platform_default_populate_init(void)
 	if (IS_ENABLED(CONFIG_PPC)) {
 		struct device_node *boot_display = NULL;
 		struct platform_device *dev;
+		int display_number = 0;
 		int ret;
 
 		/* Check if we have a MacOS display without a node spec */
@@ -555,16 +556,23 @@ static int __init of_platform_default_populate_init(void)
 			if (!of_get_property(node, "linux,opened", NULL) ||
 			    !of_get_property(node, "linux,boot-display", NULL))
 				continue;
-			dev = of_platform_device_create(node, "of-display", NULL);
+			dev = of_platform_device_create(node, "of-display.0", NULL);
+			of_node_put(node);
 			if (WARN_ON(!dev))
 				return -ENOMEM;
 			boot_display = node;
+			display_number++;
 			break;
 		}
 		for_each_node_by_type(node, "display") {
+			char buf[14];
+			const char *of_display_format = "of-display.%d";
+
 			if (!of_get_property(node, "linux,opened", NULL) || node == boot_display)
 				continue;
-			of_platform_device_create(node, "of-display", NULL);
+			ret = snprintf(buf, sizeof(buf), of_display_format, display_number++);
+			if (ret < sizeof(buf))
+				of_platform_device_create(node, buf, NULL);
 		}
 
 	} else {
-- 
2.39.0

