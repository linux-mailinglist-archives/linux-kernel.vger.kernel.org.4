Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1D85E6BEF77
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Mar 2023 18:19:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229900AbjCQRTx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Mar 2023 13:19:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42784 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230356AbjCQRTt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Mar 2023 13:19:49 -0400
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 33FEAC9C95
        for <linux-kernel@vger.kernel.org>; Fri, 17 Mar 2023 10:19:47 -0700 (PDT)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-5419fb7d6c7so52269237b3.11
        for <linux-kernel@vger.kernel.org>; Fri, 17 Mar 2023 10:19:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112; t=1679073586;
        h=cc:to:from:subject:mime-version:message-id:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=E+n21bp4YgPxtRl/BZ4TLFsQAgLgEAAfMmN9xDA3HIs=;
        b=IuGD1KOfTy2BIRkyZeJR6wekqPjMnucw+1ip8T686CtpnL7u2vALGSZ83xDwfIXPi3
         +8Y5bHvkor66zhblxCAdxSo4SLb6TJ9FOemXNRmRLnUkULEYVbpJOgugJtYbV4CyE0RH
         rBEUZuNZ/Ro1XL9UZCYdhD8xaQH5C0jVor/r+ntudtNTNdSmIdI3h1TbhVlTwN64ft4g
         sccDQKg4fewjrE/Yu6GDI1tQNbrP/VKAQZi1rb5Vz6YkcfJQC0q1ovvSTVl7wdHDeVYQ
         VoifGYj2wc6Ys4BZfc3W1J6JVuw3Lt8KI4yh0xq59qDZvFtkq3qag1wGl7yCTvXqDPeO
         BtIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679073586;
        h=cc:to:from:subject:mime-version:message-id:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=E+n21bp4YgPxtRl/BZ4TLFsQAgLgEAAfMmN9xDA3HIs=;
        b=a78yHeFJ54lUm1V8k9xS+Hs2GezwQhC63DBYx5XdjjXGbkFVvid3rW1PGgM/RyvI4Y
         XoF5b8cYkpoct7snkMNWW/qSpHov3kkJnUvOWt3AZrq0lBj/MAT/Fa/IydDaPZe20JOR
         krndo5GrXglQ6vsd1htfHJaPsl54ne7mBqN7/ywpEommyKkGvH1EZG4HUjsK3kpsiSYA
         qUo3BF7ax6AT0OZgFsLFW8i3ROWfV1DJgbT0PuFP+S8A6vkcfhRzx4zfTlPJnqlrPdk5
         bOhfxu87b2hA7+2ii/+jk9REQoYfaWccbyOg/uVffzYNbBYg9WSQMPhLGSmafh7W3IfI
         yggg==
X-Gm-Message-State: AO0yUKXDv6pE/j/qFHbCV/FinztAlt05IApd5ypFG5iqz45A8abj4pie
        xOxDazEA/UjJniQ65o6EZUsLUED66BSiza8=
X-Google-Smtp-Source: AK7set9M85IbI134c5js3If9Fu+Mq6mYqHX0HZs/jfquxZ2IUIZgY0EFk0gYvz8pwCNGbpdKuXlFfK7ftT8rqms=
X-Received: from saravanak.san.corp.google.com ([2620:15c:2d:3:8fa5:ab5f:d83a:1b71])
 (user=saravanak job=sendgmr) by 2002:a81:a908:0:b0:541:a17f:c77d with SMTP id
 g8-20020a81a908000000b00541a17fc77dmr4812954ywh.10.1679073586029; Fri, 17 Mar
 2023 10:19:46 -0700 (PDT)
Date:   Fri, 17 Mar 2023 10:19:42 -0700
Message-Id: <20230317171943.941539-1-saravanak@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.40.0.rc2.332.ga46443480c-goog
Subject: [PATCH v3] driver core: Add CONFIG_FW_DEVLINK_SYNC_STATE_TIMEOUT
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

