Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B7CD16BA341
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Mar 2023 00:00:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230250AbjCNXAY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Mar 2023 19:00:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33802 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229545AbjCNXAW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Mar 2023 19:00:22 -0400
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 25D913CE26
        for <linux-kernel@vger.kernel.org>; Tue, 14 Mar 2023 16:00:08 -0700 (PDT)
Received: by mail-wr1-x429.google.com with SMTP id l1so15747220wry.12
        for <linux-kernel@vger.kernel.org>; Tue, 14 Mar 2023 16:00:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1678834806;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=EvWdU26pcixNjYJk8V08wnXrnavkdbeKcwOlvaPgiwM=;
        b=Wq0TtKkNdh4MOYWOh1hovfrTeYh7a2qsv+XmDsLoWRuGiMIHXz1Q10mynpfHTTw+Rf
         hrr49BH1krkDk6e+X3XySGIoBERRbssjmrTAlhQuCxm5EhgYghpdwQ/o++MxrLLleBHf
         TKFRs85jTLXF7Hogat/zrHL4hFWuYiVo9c97YXxnxCYp9q7kDGi04Smal8ZU5V6OU+Li
         VVNHVWDhND1SiHOUbA00CFuqqcne1+xj6Xnnriu2OnWbfX74bBDHYbcGumL4wNXSN5gg
         OLgeAbxa+OkuvywwkWOuobip2HAPsaGIQVdo0vgVBhhjd7rl4XA2dJXFxYY8EGpWwgIu
         YZ2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678834806;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=EvWdU26pcixNjYJk8V08wnXrnavkdbeKcwOlvaPgiwM=;
        b=FoRmZcdDsjCkNgoOgqQVwbCQTpB5Q+zAo0yds4bboux5ZsyQcmUiWGp9PAOrvLKpqq
         a00rpZFHXpRTP6/QRBO30jxSkBtvtpQryYBd0qT9J0p8T1/Fz4JN5kLJ50Tmibz0IVIb
         HxyDOb8rLl+8X7cMkay+E/wRL/Ajz+r5TimuuSsmvaPVgreDesVsEaPRqBqHlGa7Mevw
         XOF1F2FH5Z2PK5pOEoTS9AC5qGOgFblrXg2bSVXwCOP6qxPs7yLA/FWXuTMWl68oTlum
         67b35+xl4cN+FNUFqnO76SwOwzEV/49DEwcGuKq/8GcG2XKdBNvNxV0cZehCo0AqxTHx
         Tx8g==
X-Gm-Message-State: AO0yUKV5L5Hzz5Nv/phUcRy3V9MOnOcV9N2O8MOPEUvnWWZizZZTnRDT
        29wWk4yHE9ZqXVfREuDWChCU4A==
X-Google-Smtp-Source: AK7set9WezkB+N671WGV8euyGw6Ry5HCRMAgc+sK2TsVpK8oiQaicr9qFn3shfrULP2ppYIjDE1r3g==
X-Received: by 2002:a5d:595d:0:b0:2ce:9fd8:8e6d with SMTP id e29-20020a5d595d000000b002ce9fd88e6dmr469686wri.8.1678834806107;
        Tue, 14 Mar 2023 16:00:06 -0700 (PDT)
Received: from localhost.localdomain ([2a02:c7c:729e:1800:50c0:6cd:d3d0:ae9b])
        by smtp.gmail.com with ESMTPSA id y2-20020a5d4ac2000000b002cde25fba30sm3190530wrs.1.2023.03.14.16.00.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Mar 2023 16:00:05 -0700 (PDT)
From:   Alexey Klimov <alexey.klimov@linaro.org>
To:     peterz@infradead.org
Cc:     draszik@google.com, peter.griffin@linaro.org,
        willmcvicker@google.com, mingo@kernel.org, ulf.hansson@linaro.org,
        tony@atomide.com, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, axboe@kernel.dk,
        alim.akhtar@samsung.com, regressions@lists.linux.dev,
        avri.altman@wdc.com, bvanassche@acm.org, klimova@google.com
Subject: [REGRESSION] CPUIDLE_FLAG_RCU_IDLE, blk_mq_freeze_queue_wait() and slow-stuck reboots
Date:   Tue, 14 Mar 2023 23:00:04 +0000
Message-Id: <20230314230004.961993-1-alexey.klimov@linaro.org>
X-Mailer: git-send-email 2.40.0.rc1.284.g88254d51c5-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

#regzbot introduced: 0c5ffc3d7b15
#regzbot title: CPUIDLE_FLAG_RCU_IDLE, blk_mq_freeze_queue_wait() and slow-stuck reboots

The upstream changes are being merged into android-mainline repo and at some point we started to observe kernel panics on reboot or long reboot times.
The merge commit is 1f2d9ffc7a5f Merge tag 'sched-core-2023-02-20' of git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.
Before, the reboot usually took significantly less than 15 seconds and after merge the reboot time fall in the range of 60-100 seconds.
At some point watchdog-like functionality or softdog start to worry about the system stuck somewhere nd panic the system.

The delay is found to be in device's ->shutdown() methods called from kernel_restart():
void kernel_restart_prepare(char *cmd)
{
	blocking_notifier_call_chain(&reboot_notifier_list, SYS_RESTART, cmd);
	system_state = SYSTEM_RESTART;
	usermodehelper_disable();
	device_shutdown();	<---- here
}

The driver in question is ufshcd and its ufshcd_wl_shutdown() shutdown method. It often blocks on scsi_device_quiesce() and upon manual checking it seems that it sleeps on blk_mq_freeze_queue_wait()/wait_event() in blk_freeze_queue():

scsi_device_quiesce(struct scsi_device *sdev)
{
	...
	blk_mq_freeze_queue(q);
	...
}
	||
	V
void blk_freeze_queue(struct request_queue *q)
{
	/*
	 * In the !blk_mq case we are only calling this to kill the
	 * q_usage_counter, otherwise this increases the freeze depth
	 * and waits for it to return to zero.  For this reason there is
	 * no blk_unfreeze_queue(), and blk_freeze_queue() is not
	 * exported to drivers as the only user for unfreeze is blk_mq.
	 */
	blk_freeze_queue_start(q);
	blk_mq_freeze_queue_wait(q);	<--- sleeps on wait_event() here
}

Or in other words:

[   34.785050][    C4] sysrq: Show Blocked State
[   34.785132][    C4] task:init            state:D stack:9680  pid:1     ppid:0      flags:0x04000008
[   34.785301][    C4] Call trace:
[   34.785360][    C4]  __switch_to+0x180/0x308
[   34.785452][    C4]  __schedule+0x61c/0x9f0
[   34.785530][    C4]  schedule+0x84/0xf4
[   34.785602][    C4]  blk_mq_freeze_queue_wait+0x78/0xbc
[   34.785707][    C4]  blk_freeze_queue+0x74/0x8c
[   34.785850][    C4]  blk_mq_freeze_queue+0x18/0x2c
[   34.786033][    C4]  scsi_device_quiesce+0x54/0xec
[   34.786216][    C4]  ufshcd_wl_shutdown+0x98/0xc0
[   34.786396][    C4]  device_shutdown+0x1a8/0x264
[   34.786572][    C4]  kernel_restart+0x48/0x11c
[   34.786742][    C4]  __arm64_sys_reboot+0x1a8/0x27c
[   34.786927][    C4]  invoke_syscall+0x60/0x130
[   34.787096][    C4]  el0_svc_common+0xbc/0x100
[   34.787266][    C4]  do_el0_svc+0x38/0xc4
[   34.787420][    C4]  el0_svc+0x34/0xc4
[   34.787563][    C4]  el0t_64_sync_handler+0x8c/0xfc
[   34.787749][    C4]  el0t_64_sync+0x1a4/0x1a8


However, bisect pointed to 0c5ffc3d7b15 cpuidle, dt: Push RCU-idle into driver

->BAD 924aed1646bf cpuidle, cpu_pm: Remove RCU fiddling from cpu_pm_{enter,exit}()
->BAD a01353cf1896 cpuidle: Fix ct_idle_*() usage
->BAD (doesn't compile, needs one missing header file) 0c5ffc3d7b15 cpuidle, dt: Push RCU-idle into driver
->good c3d42418dca5 cpuidle, OMAP4: Push RCU-idle into driver

Looks like adding CPUIDLE_FLAG_RCU_IDLE flag to idle driver caused this behaviour.
The minimal change that is required for this system to avoid the regression would be one liner that removes the flag (below).

But if it is a real regression, then other idle drivers if used will likely cause this regression too withe same ufshcd driver. There is also a suspicion that CPUIDLE_FLAG_RCU_IDLE
just revealed or uncovered some other problem.

Any thoughts on this? Some missing __cpuidle or noinstr annotations?

Best regards,
Alexey


---
From: Alexey Klimov <alexey.klimov@linaro.org>
Date: Tue, 14 Mar 2023 17:04:06 +0000
Subject: [PATCH] cpuidle, dt: partially revert "0c5ffc3d7b15 cpuidle, dt: Push RCU-idle into driver"

This partially reverts commit 0c5ffc3d7b15978c6b184938cd6b8af06e436424
as pointed by bisect.

The introduced CPUIDLE_FLAG_RCU_IDLE flag causes much longer reboots:
60..100 seconds vs less than 15 seconds before this change.
The reboot flow seems to block in ufshcd driver ->shutdown() method:

[   34.785050][    C4] sysrq: Show Blocked State
[   34.785132][    C4] task:init            state:D stack:9680  pid:1     ppid:0      flags:0x04000008
[   34.785301][    C4] Call trace:
[   34.785360][    C4]  __switch_to+0x180/0x308
[   34.785452][    C4]  __schedule+0x61c/0x9f0
[   34.785530][    C4]  schedule+0x84/0xf4
[   34.785602][    C4]  blk_mq_freeze_queue_wait+0x78/0xbc
[   34.785707][    C4]  blk_freeze_queue+0x74/0x8c
[   34.785850][    C4]  blk_mq_freeze_queue+0x18/0x2c
[   34.786033][    C4]  scsi_device_quiesce+0x54/0xec
[   34.786216][    C4]  ufshcd_wl_shutdown+0x98/0xc0
[   34.786396][    C4]  device_shutdown+0x1a8/0x264
[   34.786572][    C4]  kernel_restart+0x48/0x11c
[   34.786742][    C4]  __arm64_sys_reboot+0x1a8/0x27c
[   34.786927][    C4]  invoke_syscall+0x60/0x130
[   34.787096][    C4]  el0_svc_common+0xbc/0x100
[   34.787266][    C4]  do_el0_svc+0x38/0xc4
[   34.787420][    C4]  el0_svc+0x34/0xc4
[   34.787563][    C4]  el0t_64_sync_handler+0x8c/0xfc
[   34.787749][    C4]  el0t_64_sync+0x1a4/0x1a8

Signed-off-by: Alexey Klimov <alexey.klimov@linaro.org>
---
 drivers/cpuidle/dt_idle_states.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/cpuidle/dt_idle_states.c b/drivers/cpuidle/dt_idle_states.c
index 02aa0b39af9d..7ca3d7d9b5ea 100644
--- a/drivers/cpuidle/dt_idle_states.c
+++ b/drivers/cpuidle/dt_idle_states.c
@@ -77,7 +77,7 @@ static int init_state_node(struct cpuidle_state *idle_state,
 	if (err)
 		desc = state_node->name;
 
-	idle_state->flags = CPUIDLE_FLAG_RCU_IDLE;
+	idle_state->flags = 0;
 	if (of_property_read_bool(state_node, "local-timer-stop"))
 		idle_state->flags |= CPUIDLE_FLAG_TIMER_STOP;
 	/*
-- 
2.40.0.rc1.284.g88254d51c5-goog

