Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7E1696F004A
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Apr 2023 07:07:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242714AbjD0FHA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Apr 2023 01:07:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43132 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229665AbjD0FG7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Apr 2023 01:06:59 -0400
Received: from smtp-relay-canonical-0.canonical.com (smtp-relay-canonical-0.canonical.com [185.125.188.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C5ED640F7;
        Wed, 26 Apr 2023 22:06:55 -0700 (PDT)
Received: from localhost.localdomain (unknown [10.101.196.174])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-canonical-0.canonical.com (Postfix) with ESMTPSA id BBA3A3F187;
        Thu, 27 Apr 2023 05:06:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1682572013;
        bh=Um4+OC4JDEVt05S+LCTCt99oXpjyoXPU9VkPlqtBcoA=;
        h=From:To:Cc:Subject:Date:Message-Id:MIME-Version;
        b=NUN/EeHzvK+qCID+EhVO+gHdODXIEcugevw+jxoFwr7SbkeAExVr3i/OYsWZyU3Yl
         CUSUHrVxasvjAmWPKes/wBuFVlhrESRCXazrhSNZ2VefnF0wSZV0NAkb8kO7C8FVqU
         v1t7NPNnC0ITru1IvjUOXyx2ttqMB7zCCfuFIs88iLc5BGR4Xt+QpEHH2FNa43BE6V
         PxAJEmyHK1ZnthO1xoZIsd2X9I/FI/EdUA2URxWphf7+TZrgi6E0ATjk2u4fuYdODg
         IGTfi9myYeUVGzNUYc2oIHw7siioI5+zfdkGtUfgrfy5cYoYkOvtEGISanX7sJDEOR
         1LN0y5pju8noA==
From:   Kai-Heng Feng <kai.heng.feng@canonical.com>
To:     jejb@linux.ibm.com, martin.petersen@oracle.com
Cc:     bblock@linux.ibm.com, acelan.kao@canonical.com,
        Kai-Heng Feng <kai.heng.feng@canonical.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Pavel Machek <pavel@ucw.cz>, Len Brown <len.brown@intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v3 1/2] PM: suspend: Define pm_suspend_target_state
Date:   Thu, 27 Apr 2023 13:06:02 +0800
Message-Id: <20230427050603.612145-1-kai.heng.feng@canonical.com>
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
CONFIG_SUSPEND or CONFIG_PM_SLEEP is not set.

Signed-off-by: Kai-Heng Feng <kai.heng.feng@canonical.com>
---
v3:
 - New patch to resolve undefined pm_suspend_target_state.

 drivers/base/power/wakeup.c | 5 -----
 include/linux/suspend.h     | 1 +
 2 files changed, 1 insertion(+), 5 deletions(-)

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
index cfe19a028918..ff64a596be4b 100644
--- a/include/linux/suspend.h
+++ b/include/linux/suspend.h
@@ -530,6 +530,7 @@ static inline void ksys_sync_helper(void) {}
 
 #define pm_notifier(fn, pri)	do { (void)(fn); } while (0)
 
+#define pm_suspend_target_state	(PM_SUSPEND_ON)
 static inline bool pm_wakeup_pending(void) { return false; }
 static inline void pm_system_wakeup(void) {}
 static inline void pm_wakeup_clear(bool reset) {}
-- 
2.34.1

