Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CC4FC5BA5F4
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Sep 2022 06:33:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229695AbiIPEdg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Sep 2022 00:33:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57398 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229483AbiIPEdd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Sep 2022 00:33:33 -0400
Received: from smtp-relay-canonical-1.canonical.com (smtp-relay-canonical-1.canonical.com [185.125.188.121])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F45CA00C9
        for <linux-kernel@vger.kernel.org>; Thu, 15 Sep 2022 21:33:32 -0700 (PDT)
Received: from HP-EliteBook-840-G7.. (111-71-63-204.emome-ip.hinet.net [111.71.63.204])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-canonical-1.canonical.com (Postfix) with ESMTPSA id DDF373F03C;
        Fri, 16 Sep 2022 04:33:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1663302810;
        bh=EIO8RLHRUqUOMVMnjKNUomp/uVQ7oSnUxK82AjAnxrI=;
        h=From:To:Cc:Subject:Date:Message-Id:MIME-Version;
        b=Z57YsJ4myGGhL4EiNbeWh+6Lj67SY5idTjXJrOmN0HN0zFlE/bOJuvDmAYtLqcsz9
         8vBQSEjxhOVzhQGkYanRIblpWCKGXqlq51u0qfHfKWbiCHVoIXficTsY7gPOSxlegu
         +NaoqGEjj4MYI1h7Z1DBbyPY796GcZS5y0OVLOTOjumqCkCBNsjztJeznvGX3XjD2U
         Eoh7QfvPaSH031+UezGY+9xibvEucmP0UpxTdxofPCaT43oVuRmFG01KweAaB3aYTg
         MkLQvfA9dERFR2nxeJ4EuvtOA92rkLPWG9/re8V2je5gzL8F7oKJfUPh7VSGWObdPi
         ctGFFlTlTt52g==
From:   Kai-Heng Feng <kai.heng.feng@canonical.com>
To:     rafael.j.wysocki@intel.com, lenb@kernel.org
Cc:     Kai-Heng Feng <kai.heng.feng@canonical.com>,
        Dmitry Osipenko <dmitry.osipenko@collabora.com>,
        Luis Chamberlain <mcgrof@kernel.org>,
        tangmeng <tangmeng@uniontech.com>,
        Petr Mladek <pmladek@suse.com>,
        YueHaibing <yuehaibing@huawei.com>, linux-kernel@vger.kernel.org
Subject: [PATCH v4 1/2] kernel/reboot: Add SYS_OFF_MODE_RESTART_PREPARE mode
Date:   Fri, 16 Sep 2022 12:33:16 +0800
Message-Id: <20220916043319.119716-1-kai.heng.feng@canonical.com>
X-Mailer: git-send-email 2.37.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
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

