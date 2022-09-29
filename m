Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C3DAB5EEE66
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Sep 2022 09:06:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235109AbiI2HGU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Sep 2022 03:06:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36106 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234942AbiI2HFn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Sep 2022 03:05:43 -0400
Received: from smtp-relay-canonical-0.canonical.com (smtp-relay-canonical-0.canonical.com [185.125.188.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D09CE7A741;
        Thu, 29 Sep 2022 00:05:39 -0700 (PDT)
Received: from ubuntu.. (1-171-217-173.dynamic-ip.hinet.net [1.171.217.173])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-canonical-0.canonical.com (Postfix) with ESMTPSA id 7F7A33F13C;
        Thu, 29 Sep 2022 07:05:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1664435137;
        bh=EIO8RLHRUqUOMVMnjKNUomp/uVQ7oSnUxK82AjAnxrI=;
        h=From:To:Cc:Subject:Date:Message-Id:MIME-Version;
        b=AzFkMiPG+l36uw459ut5KyH8qgBbKG9/LRE7GD6LaRWambFndjiJuQuWvnij3PLIX
         2embg4g/3uz+Wq96VvpRJzSfgvouD6ldxqSBxmFKV/57/zusJiMyuN0H8miPslnfKl
         p9gEdQn2cvrfb5gAJybr0QNace5WW4lyQm+0tgq1ZhUSaCz05RhQ4W1TpJz18rZV7Z
         epqEtIsNZeZOhiJ2pcj88hW2G9YUPwb/b7gpfmfhqB17NRb7bTPUD3J80lbnv7uM1F
         STvrTVgYOpwLfj+5aycRlEGkv0/OhR/vobTAYXM3pndt7/iyUoma7NvpFIPpp3NS++
         m4+XisZ2YFLgw==
From:   Kai-Heng Feng <kai.heng.feng@canonical.com>
To:     rafael.j.wysocki@intel.com, lenb@kernel.org
Cc:     linux-acpi@vger.kernel.org,
        Kai-Heng Feng <kai.heng.feng@canonical.com>,
        Dmitry Osipenko <dmitry.osipenko@collabora.com>,
        tangmeng <tangmeng@uniontech.com>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Petr Mladek <pmladek@suse.com>,
        YueHaibing <yuehaibing@huawei.com>, linux-kernel@vger.kernel.org
Subject: [RESEND PATCH v4 1/2] kernel/reboot: Add SYS_OFF_MODE_RESTART_PREPARE mode
Date:   Thu, 29 Sep 2022 15:05:23 +0800
Message-Id: <20220929070526.143907-1-kai.heng.feng@canonical.com>
X-Mailer: git-send-email 2.37.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add SYS_OFF_MODE_RESTART_PREPARE callbacks can be invoked before system
restart.

This is a preparation for next patch.

Suggested-by: Dmitry Osipenko <dmitry.osipenko@collabora.com>
Reviewed-by: Dmitry Osipenko <dmitry.osipenko@collabora.com>
Signed-off-by: Kai-Heng Feng <kai.heng.feng@canonical.com>
---
v4:
 - Correct typo in comment.
v3:
 - New patch.

 include/linux/reboot.h |  8 ++++++++
 kernel/reboot.c        | 17 +++++++++++++++++
 2 files changed, 25 insertions(+)

diff --git a/include/linux/reboot.h b/include/linux/reboot.h
index e5d9ef886179c..2b6bb593be5b6 100644
--- a/include/linux/reboot.h
+++ b/include/linux/reboot.h
@@ -105,6 +105,14 @@ enum sys_off_mode {
 	 */
 	SYS_OFF_MODE_POWER_OFF,
 
+	/**
+	 * @SYS_OFF_MODE_RESTART_PREPARE:
+	 *
+	 * Handlers prepare system to be restarted. Handlers are
+	 * allowed to sleep.
+	 */
+	SYS_OFF_MODE_RESTART_PREPARE,
+
 	/**
 	 * @SYS_OFF_MODE_RESTART:
 	 *
diff --git a/kernel/reboot.c b/kernel/reboot.c
index 3c35445bf5ad3..3bba88c7ffc6b 100644
--- a/kernel/reboot.c
+++ b/kernel/reboot.c
@@ -243,6 +243,17 @@ void migrate_to_reboot_cpu(void)
 	set_cpus_allowed_ptr(current, cpumask_of(cpu));
 }
 
+/*
+ *	Notifier list for kernel code which wants to be called
+ *	to prepare system for restart.
+ */
+static BLOCKING_NOTIFIER_HEAD(restart_prep_handler_list);
+
+static void do_kernel_restart_prepare(void)
+{
+	blocking_notifier_call_chain(&restart_prep_handler_list, 0, NULL);
+}
+
 /**
  *	kernel_restart - reboot the system
  *	@cmd: pointer to buffer containing command to execute for restart
@@ -254,6 +265,7 @@ void migrate_to_reboot_cpu(void)
 void kernel_restart(char *cmd)
 {
 	kernel_restart_prepare(cmd);
+	do_kernel_restart_prepare();
 	migrate_to_reboot_cpu();
 	syscore_shutdown();
 	if (!cmd)
@@ -396,6 +408,11 @@ register_sys_off_handler(enum sys_off_mode mode,
 		handler->list = &power_off_handler_list;
 		break;
 
+	case SYS_OFF_MODE_RESTART_PREPARE:
+		handler->list = &restart_prep_handler_list;
+		handler->blocking = true;
+		break;
+
 	case SYS_OFF_MODE_RESTART:
 		handler->list = &restart_handler_list;
 		break;
-- 
2.37.2

