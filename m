Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E81486B8613
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Mar 2023 00:27:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230125AbjCMX13 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Mar 2023 19:27:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35280 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229535AbjCMX11 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Mar 2023 19:27:27 -0400
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB5A484818
        for <linux-kernel@vger.kernel.org>; Mon, 13 Mar 2023 16:27:23 -0700 (PDT)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-5417f156cb9so67536847b3.8
        for <linux-kernel@vger.kernel.org>; Mon, 13 Mar 2023 16:27:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112; t=1678750043;
        h=cc:to:from:subject:mime-version:message-id:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=sijsIZUNL86l0HWUU15rUYt61UPf3fR89m0FcXWfwbg=;
        b=MoBjJT1bu+FDH0NOjzCmP1XfEbiTdwweANunLMwV+tI//sXqTn0C21ZXU9bnFXMY5/
         vw1Gmqcn70W6bTlyzg5sBlnFAdfLbb/yZ+1gkquvysKekmuZDGdI3smNnrT3ojk5iOrd
         nQccY2MFB9WLE5OppFm0gKn1gjEmYJFrqwrFUUeSaJc9e0E5LKP5Efc1z83oFs34EMVu
         +/GMBF5zqTQPGfTLMG1c7+DTkg9PpJVXtlHYQ6hOJnvSKVgOfF8BxVPHVD947FkXupRZ
         DpfPksQIixSWNznoftmpaSgSHqgyvXEjowLjmu19Ir2ztbW1FxNlF5a6VX9IkLQrXjsz
         3Stg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678750043;
        h=cc:to:from:subject:mime-version:message-id:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=sijsIZUNL86l0HWUU15rUYt61UPf3fR89m0FcXWfwbg=;
        b=KWEktXhF3s8ULDbCk038yNf2f3vfCA4qEgnhk9/VNcVERkZ8y1Icde7wfMy51OzNFT
         ko9eOtgDnAY67rbcGbfsyHzHv0Yl/no+JqLHAhh3poFd0UuPnvNV8kcwLJB+bBKLe8AG
         U1bzzvVOR67FqYPIS9GZ1uJ1rOzgMONfJSvXTjJyfxdI2FmKPlupiSnQldpu7sF4vYhM
         96OIv4bWeA1HJFPwuYgOWBvW8BYLpTdGWWQCrLViI0NZhGilGL3jsSuBBJAGoLRZ6MN3
         gfHQsZHSH6Y6LhOZsROQ2SzHoxxmvZN/a9o7A5gGnzgxAA7+7IzPYa2wVrmmCuxp7HmR
         rGuA==
X-Gm-Message-State: AO0yUKXCVEdN0aD3x/uWzc6a38E/xOiY9nnzilmliadbTolhbocpzaTE
        o9IhXL70NWm8wRfkQozWLJVVqjvi1oS2Ixg=
X-Google-Smtp-Source: AK7set8M0Oc29b+C+lUdY1PP7LDEM0x/Ynccn7t6fD5nAc22sPBoblUZxOh0jYzQwWo1jBJIMWSdF9FdUrDIguA=
X-Received: from saravanak.san.corp.google.com ([2620:15c:2d:3:1791:a834:c6c8:6586])
 (user=saravanak job=sendgmr) by 2002:a05:6902:185:b0:9fe:1493:8b9 with SMTP
 id t5-20020a056902018500b009fe149308b9mr17967322ybh.8.1678750043217; Mon, 13
 Mar 2023 16:27:23 -0700 (PDT)
Date:   Mon, 13 Mar 2023 16:27:19 -0700
Message-Id: <20230313232719.3565369-1-saravanak@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.40.0.rc1.284.g88254d51c5-goog
Subject: [PATCH v1] driver core: Add CONFIG_FW_DEVLINK_SYNC_STATE_TIMEOUT
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
---
 drivers/base/Kconfig | 10 ++++++++++
 drivers/base/core.c  |  5 +++++
 2 files changed, 15 insertions(+)

diff --git a/drivers/base/Kconfig b/drivers/base/Kconfig
index 6f04b831a5c0..da91b409482f 100644
--- a/drivers/base/Kconfig
+++ b/drivers/base/Kconfig
@@ -230,4 +230,14 @@ config GENERIC_ARCH_NUMA
 	  Enable support for generic NUMA implementation. Currently, RISC-V
 	  and ARM64 use it.
 
+config FW_DEVLINK_SYNC_STATE_TIMEOUT
+	bool
+	default n
+	help
+	  This is build time equivalent of adding kernel commandline parameter
+	  "fw_devlink.sync_state=timeout". Give up waiting on consumers and
+	  call sync_state() on any devices that haven't yet received their
+	  sync_state() calls after deferred_probe_timeout has expired or by
+	  late_initcall() if !CONFIG_MODULES.
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
2.40.0.rc1.284.g88254d51c5-goog

