Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9A4036C23C0
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Mar 2023 22:34:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230053AbjCTVeC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Mar 2023 17:34:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34736 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229843AbjCTVeB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Mar 2023 17:34:01 -0400
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 64F1C39BAC
        for <linux-kernel@vger.kernel.org>; Mon, 20 Mar 2023 14:33:20 -0700 (PDT)
Received: by mail-wr1-x42c.google.com with SMTP id v25so8332788wra.12
        for <linux-kernel@vger.kernel.org>; Mon, 20 Mar 2023 14:33:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679347967;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=bDzcrREkxsiZpZ0TLzQirhe35EprAUvJXNPwHt1OSyg=;
        b=VoHHIymktydEFSc4aPIysLUsv0OdQQ4t5wE79jmv2rbB3JFyQyUynRNYSI4eOPwWct
         0NaFy0gHZRSpFm3N5CO8DogCZYefXTzsXgxLbdAcSUHVEsMaF8Fi91nb+kEHI1WTHq42
         MGDxtDL+E/Rx5Mp+AnJRCXCl4A+FfCkSZp4a05DaNQHye+FyijS6BRnJscZ8ZuU5BiDB
         rR9+eJ8cxB/2VGIlqoZgpqB1AwwUGRHKVB1OQgYn0AVIFJlgVgOFz81uRq3Zf+PAyQQd
         lDtoc4p7eHeDcHojpwC0KLP+yRdVDIiafz4KDYfYxS6KGGEDc/iEV9ZzTVp/aJ8kRG6p
         GHZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679347967;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=bDzcrREkxsiZpZ0TLzQirhe35EprAUvJXNPwHt1OSyg=;
        b=Vp/rv9owV7cOonKRzYB47u4ljOPOUuakhoIonemMLKelTl+C7Q6YLvRK4thzeSTS0l
         UYIrFo5XlZOdRabsZTsB93glznb9vWhmPnEl2JFPeYuEDdUeZ3dzJIuVK3ye2PNkgmfH
         NXn6cPaA9irLBthnhYeBHXN6c5JWMIa/R0mLaxIKEQgzCFw3p/13WmM0ZLDxkSnAizJ4
         jQjMp1MOddUF3I6DMvu64z+6prALiOm5EcJoc3PYImjx4NhuDs//ORSO6eyc+Mm7+Tio
         Nc91WRb0rDfsyDN7rDI0vKErr8NCaTc2whvVpxx+UqsGbEGXqCGtTO2U6Ya8bRh3gfaL
         vCrw==
X-Gm-Message-State: AO0yUKUXnSpQWgkAGoqboBOBcEngXQiJbfxoIPT422c/zf1eZdPPq3cM
        P9XcZVmddUZLJLZpiqoR80g=
X-Google-Smtp-Source: AK7set/qiVQDbS6QVED9+q1rx1DgTGcBJjCu3ZaGSfTP8zVBCuciPegZoYMOegQQ2W4/of0xAgS2gQ==
X-Received: by 2002:a05:6000:1291:b0:2d8:6cb3:dfd3 with SMTP id f17-20020a056000129100b002d86cb3dfd3mr643491wrx.13.1679347967320;
        Mon, 20 Mar 2023 14:32:47 -0700 (PDT)
Received: from PCBABN.skidata.net ([91.230.2.244])
        by smtp.gmail.com with ESMTPSA id p17-20020adfcc91000000b002c71dd1109fsm9835293wrj.47.2023.03.20.14.32.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Mar 2023 14:32:46 -0700 (PDT)
From:   Benjamin Bara <bbara93@gmail.com>
To:     rafael.j.wysocki@intel.com, dmitry.osipenko@collabora.com,
        pmladek@suse.com
Cc:     mcgrof@kernel.org, paulmck@kernel.org, kai.heng.feng@canonical.com,
        tangmeng@uniontech.com, john.ogness@linutronix.de,
        yuehaibing@huawei.com, benjamin.bara@skidata.com,
        linux-kernel@vger.kernel.org
Subject: [PATCH] kernel/reboot: emergency_restart: set correct system_state
Date:   Mon, 20 Mar 2023 22:32:30 +0100
Message-Id: <20230320213230.1459532-1-bbara93@gmail.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Benjamin Bara <benjamin.bara@skidata.com>

As the emergency restart does not call kernel_restart_prepare(),
the system_state stays in SYSTEM_RUNNING.

This e.g. hinders i2c_in_atomic_xfer_mode() from becoming active,
and therefore might lead to avoidable warnings in the restart handlers,
e.g.:
[   12.667612] WARNING: CPU: 1 PID: 1 at kernel/rcu/tree_plugin.h:318 rcu_note_context_switch+0x33c/0x6b0
[   12.676926] Voluntary context switch within RCU read-side critical section!
...
[   12.742376]  schedule_timeout from wait_for_completion_timeout+0x90/0x114
[   12.749179]  wait_for_completion_timeout from tegra_i2c_wait_completion+0x40/0x70
...
[   12.994527]  atomic_notifier_call_chain from machine_restart+0x34/0x58
[   13.001050]  machine_restart from panic+0x2a8/0x32c

Avoid these by setting the correct system_state.

Signed-off-by: Benjamin Bara <benjamin.bara@skidata.com>
---
 kernel/reboot.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/kernel/reboot.c b/kernel/reboot.c
index 3bba88c7ffc6..6ebef11c8876 100644
--- a/kernel/reboot.c
+++ b/kernel/reboot.c
@@ -74,6 +74,7 @@ void __weak (*pm_power_off)(void);
 void emergency_restart(void)
 {
 	kmsg_dump(KMSG_DUMP_EMERG);
+	system_state = SYSTEM_RESTART;
 	machine_emergency_restart();
 }
 EXPORT_SYMBOL_GPL(emergency_restart);
-- 
2.34.1

