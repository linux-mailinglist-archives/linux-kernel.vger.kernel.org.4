Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4112F6F46A9
	for <lists+linux-kernel@lfdr.de>; Tue,  2 May 2023 17:05:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233523AbjEBPFt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 May 2023 11:05:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59394 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233271AbjEBPFr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 May 2023 11:05:47 -0400
Received: from smtp-relay-canonical-1.canonical.com (smtp-relay-canonical-1.canonical.com [185.125.188.121])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E7E03269F;
        Tue,  2 May 2023 08:05:35 -0700 (PDT)
Received: from localhost.localdomain (unknown [10.101.196.174])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-canonical-1.canonical.com (Postfix) with ESMTPSA id 981283F185;
        Tue,  2 May 2023 15:05:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1683039934;
        bh=VB9hMQWMzRLIIDW3WhppjAcEXDe8NJXeG8KQlrCIq40=;
        h=From:To:Cc:Subject:Date:Message-Id:MIME-Version;
        b=BD0BUxf2D4ry487a1QZvHKdnyMuQfV442Hd4DVuNK93stOWlN7zknjWzt5QFxWPbn
         iBYnJsaeDjwPqaruEVpDiOWshHVnA7GRMVg0ePzgNPHi+wiIP02LZTsf2nDC0elhfm
         sLJCD/w11dqMRcEXAUghJIevNrSm4nxbhHbEsOoAITwX87GmfMO+Sg66L5iqBIXtQS
         /BILWQLPd2aVgbFhWaz2liV+QWgwsgl+zSnmc0Z2IMgsOimWd5DpMkOKw3BQ+qIgXA
         2k0jYZengOylZLIaNguOZMmsZGQq8gV5cHPc1wmonCF08bKr53eTv9fofK/+XFx4St
         2gcyXaNVdWWDA==
From:   Kai-Heng Feng <kai.heng.feng@canonical.com>
To:     jejb@linux.ibm.com, martin.petersen@oracle.com
Cc:     bblock@linux.ibm.com, acelan.kao@canonical.com,
        Kai-Heng Feng <kai.heng.feng@canonical.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v4 1/2] PM: suspend: Define pm_suspend_target_state
Date:   Tue,  2 May 2023 17:04:34 +0200
Message-Id: <20230502150435.423770-1-kai.heng.feng@canonical.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Define pm_suspend_target_state so it can still be used when
CONFIG_SUSPEND is not set.

Signed-off-by: Kai-Heng Feng <kai.heng.feng@canonical.com>
---
v4:
 - Move pm_suspend_target_state to CONFIG_SUSPEND block.

v3:
 - New patch to resolve undefined pm_suspend_target_state.

 drivers/base/power/wakeup.c | 5 -----
 include/linux/suspend.h     | 4 +++-
 2 files changed, 3 insertions(+), 6 deletions(-)

diff --git a/drivers/base/power/wakeup.c b/drivers/base/power/wakeup.c
index 7cc0c0cf8eaa..a917219feea6 100644
--- a/drivers/base/power/wakeup.c
+++ b/drivers/base/power/wakeup.c
@@ -19,11 +19,6 @@
 
 #include "power.h"
 
-#ifndef CONFIG_SUSPEND
-suspend_state_t pm_suspend_target_state;
-#define pm_suspend_target_state	(PM_SUSPEND_ON)
-#endif
-
 #define list_for_each_entry_rcu_locked(pos, head, member) \
 	list_for_each_entry_rcu(pos, head, member, \
 		srcu_read_lock_held(&wakeup_srcu))
diff --git a/include/linux/suspend.h b/include/linux/suspend.h
index d0d4598a7b3f..474ecfbbaa62 100644
--- a/include/linux/suspend.h
+++ b/include/linux/suspend.h
@@ -202,6 +202,7 @@ struct platform_s2idle_ops {
 };
 
 #ifdef CONFIG_SUSPEND
+extern suspend_state_t pm_suspend_target_state;
 extern suspend_state_t mem_sleep_current;
 extern suspend_state_t mem_sleep_default;
 
@@ -337,6 +338,8 @@ extern bool sync_on_suspend_enabled;
 #else /* !CONFIG_SUSPEND */
 #define suspend_valid_only_mem	NULL
 
+#define pm_suspend_target_state	(PM_SUSPEND_ON)
+
 static inline void pm_suspend_clear_flags(void) {}
 static inline void pm_set_suspend_via_firmware(void) {}
 static inline void pm_set_resume_via_firmware(void) {}
@@ -503,7 +506,6 @@ extern void pm_report_max_hw_sleep(u64 t);
 
 /* drivers/base/power/wakeup.c */
 extern bool events_check_enabled;
-extern suspend_state_t pm_suspend_target_state;
 
 extern bool pm_wakeup_pending(void);
 extern void pm_system_wakeup(void);
-- 
2.34.1

