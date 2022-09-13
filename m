Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E7CFB5B67D1
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Sep 2022 08:22:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230287AbiIMGWF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Sep 2022 02:22:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34766 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230433AbiIMGVt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Sep 2022 02:21:49 -0400
Received: from smtp-relay-canonical-1.canonical.com (smtp-relay-canonical-1.canonical.com [185.125.188.121])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B8A5E1C909
        for <linux-kernel@vger.kernel.org>; Mon, 12 Sep 2022 23:21:14 -0700 (PDT)
Received: from HP-EliteBook-840-G7.. (1-171-215-55.dynamic-ip.hinet.net [1.171.215.55])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-canonical-1.canonical.com (Postfix) with ESMTPSA id 4DC633FD64;
        Tue, 13 Sep 2022 06:21:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1663050072;
        bh=jw+5+/XYJqR6bK3t0ETbgFhb+VolUMI8ZBD6QAqZjIk=;
        h=From:To:Cc:Subject:Date:Message-Id:MIME-Version;
        b=swI8mVzDHqhBSH39Jl73PNH773cM74QhMREcX1QyW8azaWoueTRQZoBHNJXu1vOFD
         tm753no7zviwSuZjK5+At3mAz70RPBe4OMUmi/UWDbQZ2C2Zt3B0lVkoL+BGF008GU
         5XhhQ/Vb+n4PFkma2H1wmzro/dQr2rUa8OLbgXFeSzIBeaLj9rfIpcndBlxxIerirA
         TN6MX1wr0iThoPLvOCJaAZcFNf0Ee6Bc0t//S9KDZGP3ipSKMI82XgBKqQD/8hqYps
         T8PdXK8XC5JXSHo6ly1/rtqNg8H9++ecu6PEtkuTDeqn1vUuWHlkf5H6Zx8Vvs503v
         GZwNEcSu4kHgw==
From:   Kai-Heng Feng <kai.heng.feng@canonical.com>
To:     rafael.j.wysocki@intel.com, lenb@kernel.org
Cc:     Kai-Heng Feng <kai.heng.feng@canonical.com>,
        Dmitry Osipenko <dmitry.osipenko@collabora.com>,
        tangmeng <tangmeng@uniontech.com>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Petr Mladek <pmladek@suse.com>,
        YueHaibing <yuehaibing@huawei.com>, linux-kernel@vger.kernel.org
Subject: [PATCH v3 1/2] kernel/reboot: Add SYS_OFF_MODE_RESTART_PREPARE mode
Date:   Tue, 13 Sep 2022 14:20:39 +0800
Message-Id: <20220913062042.1977790-1-kai.heng.feng@canonical.com>
X-Mailer: git-send-email 2.36.1
MIME-Version: 1.0
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

Add SYS_OFF_MODE_RESTART_PREPARE callbacks can be invoked before system
restart.

This is a preparation for next patch.

Suggested-by: Dmitry Osipenko <dmitry.osipenko@collabora.com>
Signed-off-by: Kai-Heng Feng <kai.heng.feng@canonical.com>
---
v3:
 - New patch.

 include/linux/reboot.h |  8 ++++++++
 kernel/reboot.c        | 17 +++++++++++++++++
 2 files changed, 25 insertions(+)

diff --git a/include/linux/reboot.h b/include/linux/reboot.h
index e5d9ef886179c..ba87cdef2335a 100644
--- a/include/linux/reboot.h
+++ b/include/linux/reboot.h
@@ -105,6 +105,14 @@ enum sys_off_mode {
 	 */
 	SYS_OFF_MODE_POWER_OFF,
 
+	/**
+	 * @SYS_OFF_MODE_RESTART_PREPARE:
+	 *
+	 * Handlers prepare system to be powered off. Handlers are
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
2.36.1

