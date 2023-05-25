Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CA3897113CD
	for <lists+linux-kernel@lfdr.de>; Thu, 25 May 2023 20:33:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241309AbjEYSdX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 May 2023 14:33:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51990 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241299AbjEYSdJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 May 2023 14:33:09 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD0B1E6A;
        Thu, 25 May 2023 11:32:49 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 65DD56488B;
        Thu, 25 May 2023 18:32:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CDB85C433EF;
        Thu, 25 May 2023 18:32:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1685039568;
        bh=wQH+bHDKIaIv8BJZfoN3z8fGy9rKt8U+rcC4iVrJx0Q=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=k7IdcY84RD2nROsAowCuXFaXb9gfpF6LlxJyCB17CRiHCzHWCuDGUzm7EUoQqbsdi
         USCoIbDZX7whvVq8nmudYSOltRQjcgG+PxEJbiHdlMxaqHdHNZJ7TwzRepduPHXLya
         u/BlN9kIYQQMgPxqkjAGNFHVwHEFqOdgPwbWAaOz3xe8PKXqxH9rCM/++wbCGG88aj
         yUl6MyiTYqsZJSXgjZUwOjiStsjG+POsbIH80CbB9Izy4vwUWEKX15whRYNn1smd4k
         mCi5L51QO8iSh9OPD7Ewx8EuHcRgc3hXqX/Eck3okvj+Vad6is4KuY1g4JFQOnjbHI
         fZnSryfVLT3pA==
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Johannes Berg <johannes.berg@intel.com>,
        kernel test robot <lkp@intel.com>,
        Richard Weinberger <richard@nod.at>,
        Sasha Levin <sashal@kernel.org>,
        anton.ivanov@cambridgegreys.com, johannes@sipsolutions.net,
        masahiroy@kernel.org, linux-um@lists.infradead.org
Subject: [PATCH AUTOSEL 6.3 09/67] um: harddog: fix modular build
Date:   Thu, 25 May 2023 14:30:46 -0400
Message-Id: <20230525183144.1717540-9-sashal@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230525183144.1717540-1-sashal@kernel.org>
References: <20230525183144.1717540-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
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

From: Johannes Berg <johannes.berg@intel.com>

[ Upstream commit 73a23d7710331a530e972903318528b75e5a5f58 ]

Since we no longer (want to) export any libc symbols the
_user portions of any drivers need to be built into image
rather than the module. I missed this for the watchdog.
Fix the watchdog accordingly.

Reported-by: kernel test robot <lkp@intel.com>
Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Richard Weinberger <richard@nod.at>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/um/drivers/Makefile           | 4 +++-
 arch/um/drivers/harddog.h          | 9 +++++++++
 arch/um/drivers/harddog_kern.c     | 7 +------
 arch/um/drivers/harddog_user.c     | 1 +
 arch/um/drivers/harddog_user_exp.c | 9 +++++++++
 5 files changed, 23 insertions(+), 7 deletions(-)
 create mode 100644 arch/um/drivers/harddog.h
 create mode 100644 arch/um/drivers/harddog_user_exp.c

diff --git a/arch/um/drivers/Makefile b/arch/um/drivers/Makefile
index dee6f66353b33..a461a950f0518 100644
--- a/arch/um/drivers/Makefile
+++ b/arch/um/drivers/Makefile
@@ -16,7 +16,8 @@ mconsole-objs := mconsole_kern.o mconsole_user.o
 hostaudio-objs := hostaudio_kern.o
 ubd-objs := ubd_kern.o ubd_user.o
 port-objs := port_kern.o port_user.o
-harddog-objs := harddog_kern.o harddog_user.o
+harddog-objs := harddog_kern.o
+harddog-builtin-$(CONFIG_UML_WATCHDOG) := harddog_user.o harddog_user_exp.o
 rtc-objs := rtc_kern.o rtc_user.o
 
 LDFLAGS_pcap.o = $(shell $(CC) $(KBUILD_CFLAGS) -print-file-name=libpcap.a)
@@ -60,6 +61,7 @@ obj-$(CONFIG_PTY_CHAN) += pty.o
 obj-$(CONFIG_TTY_CHAN) += tty.o 
 obj-$(CONFIG_XTERM_CHAN) += xterm.o xterm_kern.o
 obj-$(CONFIG_UML_WATCHDOG) += harddog.o
+obj-y += $(harddog-builtin-y) $(harddog-builtin-m)
 obj-$(CONFIG_BLK_DEV_COW_COMMON) += cow_user.o
 obj-$(CONFIG_UML_RANDOM) += random.o
 obj-$(CONFIG_VIRTIO_UML) += virtio_uml.o
diff --git a/arch/um/drivers/harddog.h b/arch/um/drivers/harddog.h
new file mode 100644
index 0000000000000..6d9ea60e7133e
--- /dev/null
+++ b/arch/um/drivers/harddog.h
@@ -0,0 +1,9 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef UM_WATCHDOG_H
+#define UM_WATCHDOG_H
+
+int start_watchdog(int *in_fd_ret, int *out_fd_ret, char *sock);
+void stop_watchdog(int in_fd, int out_fd);
+int ping_watchdog(int fd);
+
+#endif /* UM_WATCHDOG_H */
diff --git a/arch/um/drivers/harddog_kern.c b/arch/um/drivers/harddog_kern.c
index e6d4f43deba82..60d1c6cab8a95 100644
--- a/arch/um/drivers/harddog_kern.c
+++ b/arch/um/drivers/harddog_kern.c
@@ -47,6 +47,7 @@
 #include <linux/spinlock.h>
 #include <linux/uaccess.h>
 #include "mconsole.h"
+#include "harddog.h"
 
 MODULE_LICENSE("GPL");
 
@@ -60,8 +61,6 @@ static int harddog_out_fd = -1;
  *	Allow only one person to hold it open
  */
 
-extern int start_watchdog(int *in_fd_ret, int *out_fd_ret, char *sock);
-
 static int harddog_open(struct inode *inode, struct file *file)
 {
 	int err = -EBUSY;
@@ -92,8 +91,6 @@ static int harddog_open(struct inode *inode, struct file *file)
 	return err;
 }
 
-extern void stop_watchdog(int in_fd, int out_fd);
-
 static int harddog_release(struct inode *inode, struct file *file)
 {
 	/*
@@ -112,8 +109,6 @@ static int harddog_release(struct inode *inode, struct file *file)
 	return 0;
 }
 
-extern int ping_watchdog(int fd);
-
 static ssize_t harddog_write(struct file *file, const char __user *data, size_t len,
 			     loff_t *ppos)
 {
diff --git a/arch/um/drivers/harddog_user.c b/arch/um/drivers/harddog_user.c
index 070468d22e394..9ed89304975ed 100644
--- a/arch/um/drivers/harddog_user.c
+++ b/arch/um/drivers/harddog_user.c
@@ -7,6 +7,7 @@
 #include <unistd.h>
 #include <errno.h>
 #include <os.h>
+#include "harddog.h"
 
 struct dog_data {
 	int stdin_fd;
diff --git a/arch/um/drivers/harddog_user_exp.c b/arch/um/drivers/harddog_user_exp.c
new file mode 100644
index 0000000000000..c74d4b815d143
--- /dev/null
+++ b/arch/um/drivers/harddog_user_exp.c
@@ -0,0 +1,9 @@
+// SPDX-License-Identifier: GPL-2.0
+#include <linux/export.h>
+#include "harddog.h"
+
+#if IS_MODULE(CONFIG_UML_WATCHDOG)
+EXPORT_SYMBOL(start_watchdog);
+EXPORT_SYMBOL(stop_watchdog);
+EXPORT_SYMBOL(ping_watchdog);
+#endif
-- 
2.39.2

