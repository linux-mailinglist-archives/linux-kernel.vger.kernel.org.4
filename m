Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6C5C56BF319
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Mar 2023 21:51:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229987AbjCQUvk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Mar 2023 16:51:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41618 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229654AbjCQUvj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Mar 2023 16:51:39 -0400
Received: from mail-pf1-x44a.google.com (mail-pf1-x44a.google.com [IPv6:2607:f8b0:4864:20::44a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0729220D0E
        for <linux-kernel@vger.kernel.org>; Fri, 17 Mar 2023 13:51:37 -0700 (PDT)
Received: by mail-pf1-x44a.google.com with SMTP id j9-20020aa79289000000b00625894ca452so3217765pfa.22
        for <linux-kernel@vger.kernel.org>; Fri, 17 Mar 2023 13:51:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112; t=1679086296;
        h=cc:to:from:subject:mime-version:message-id:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=Yggrs7JW2XscQytYe7EBpJHNPpg8x3R96N64SOflxtY=;
        b=RAry5PXHsASD+K5+nH62ZqbHB7MFCUVzBcN5mY4qWmHbPDQ1f1zypiehbGI3Fy2dSe
         iX2pqs93kI8/3o/jaSqjFr5BBBKCgHip+qCPKPhcOI4Y6ut8fbiHXAiVgErNVtCnJcXm
         i9DmoeWwhpBn8Jk1zJ2hhWqwu1xle2yNWkjpzRFKBRaI6dVJT4pZTWAalnGEQB0vQ+AS
         49Pd9+WQ/Uk1BMhDrFU3vXnGiaW/GpkOzokYmmHczYWYudRYqIu2j2Rd+aqHakTWRHJe
         NF7FNpT7U6ePNJiMXRR93Yvri7zp48jiYPB4GKf+aUjr4lVJ9ROaR9oo7C+47wCsPD5a
         Enug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679086296;
        h=cc:to:from:subject:mime-version:message-id:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Yggrs7JW2XscQytYe7EBpJHNPpg8x3R96N64SOflxtY=;
        b=H7+wvNqjhjikqVV/9kM9kYVcxAdPmUq9mmBD2KataR/iI1iYa0rFyaGXYaSOjoNWU1
         z6s80STbg9geKwlys5SObumUDSmJcUAKBkrAsfOkWJpSwwmHG8+gPeRksOAWX+3Veijc
         K37C7ZeweBmxayO/NlPpnRGQxwWOXweI+azJ/SCi0xJP7s2W2cg3efM4Pkony3sKRJ2c
         /zAAQ1AJPPTUho9g9Zz05zMgZvUlgiIZue6onEAiGCZiCnZb/KzaDGkpus9/7Oaq0rAr
         jm88p+tPJdpAoWGjZpdkOCDYjoUkjK6YCRkjZIOtNy5aJKdW73Cex0WA9Ql+kAGSKkmX
         AW5A==
X-Gm-Message-State: AO0yUKUBBjpMh9YMgxIkEIf8Phf4D0IC6OhNnffd+ZS4s+eLc4avWGHS
        fpcf6splk+xa4RmgUaWC0TdjWKk4rZE9pfw=
X-Google-Smtp-Source: AK7set9ujWU8oOm1pDCp66YX98ebwfY3nfVdMyOciog+H+VQc+CT2GZ323ey6nIm6Cn0TshspgbSZ5bIwWRKM6k=
X-Received: from saravanak.san.corp.google.com ([2620:15c:2d:3:8fa5:ab5f:d83a:1b71])
 (user=saravanak job=sendgmr) by 2002:a05:6a00:999:b0:5a9:d579:6902 with SMTP
 id u25-20020a056a00099900b005a9d5796902mr2035696pfg.0.1679086296544; Fri, 17
 Mar 2023 13:51:36 -0700 (PDT)
Date:   Fri, 17 Mar 2023 13:51:33 -0700
Message-Id: <20230317205134.964098-1-saravanak@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.40.0.rc2.332.ga46443480c-goog
Subject: [PATCH v4] driver core: Add CONFIG_FW_DEVLINK_SYNC_STATE_TIMEOUT
From:   Saravana Kannan <saravanak@google.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Saravana Kannan <saravanak@google.com>,
        Doug Anderson <dianders@chromium.org>, kernel-team@android.com,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add a build time equivalent of fw_devlink.sync_state=timeout so that
board specific kernels could enable it and not have to deal with setting
or cluttering the kernel commandline.

Cc: Doug Anderson <dianders@chromium.org>
Signed-off-by: Saravana Kannan <saravanak@google.com>
Reviewed-by: Douglas Anderson <dianders@chromium.org>
---
v1 -> v2:
- Removed "default n" and expanded on the help text.
v2 -> v3:
- Added a description for the "bool" so the config can be enabled by the
  user.
v3 -> v4:
- Added this version change history.
- Added Doug's Reviewed-by.

 drivers/base/Kconfig | 12 ++++++++++++
 drivers/base/core.c  |  5 +++++
 2 files changed, 17 insertions(+)

diff --git a/drivers/base/Kconfig b/drivers/base/Kconfig
index 6f04b831a5c0..2b8fd6bb7da0 100644
--- a/drivers/base/Kconfig
+++ b/drivers/base/Kconfig
@@ -230,4 +230,16 @@ config GENERIC_ARCH_NUMA
 	  Enable support for generic NUMA implementation. Currently, RISC-V
 	  and ARM64 use it.
 
+config FW_DEVLINK_SYNC_STATE_TIMEOUT
+	bool "sync_state() behavior defaults to timeout instead of strict"
+	help
+	  This is build time equivalent of adding kernel command line parameter
+	  "fw_devlink.sync_state=timeout". Give up waiting on consumers and
+	  call sync_state() on any devices that haven't yet received their
+	  sync_state() calls after deferred_probe_timeout has expired or by
+	  late_initcall() if !CONFIG_MODULES. You should almost always want to
+	  select N here unless you have already successfully tested with the
+	  command line option on every system/board your kernel is expected to
+	  work on.
+
 endmenu
diff --git a/drivers/base/core.c b/drivers/base/core.c
index fe74a786e2c3..adc81871829f 100644
--- a/drivers/base/core.c
+++ b/drivers/base/core.c
@@ -1672,7 +1672,12 @@ early_param("fw_devlink.strict", fw_devlink_strict_setup);
 #define FW_DEVLINK_SYNC_STATE_STRICT	0
 #define FW_DEVLINK_SYNC_STATE_TIMEOUT	1
 
+#ifndef CONFIG_FW_DEVLINK_SYNC_STATE_TIMEOUT
 static int fw_devlink_sync_state;
+#else
+static int fw_devlink_sync_state = FW_DEVLINK_SYNC_STATE_TIMEOUT;
+#endif
+
 static int __init fw_devlink_sync_state_setup(char *arg)
 {
 	if (!arg)
-- 
2.40.0.rc2.332.ga46443480c-goog

