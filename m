Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 861B4650E70
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Dec 2022 16:15:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232473AbiLSPPd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Dec 2022 10:15:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43086 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232837AbiLSPPR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Dec 2022 10:15:17 -0500
Received: from mail-lf1-x133.google.com (mail-lf1-x133.google.com [IPv6:2a00:1450:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F28F110540
        for <linux-kernel@vger.kernel.org>; Mon, 19 Dec 2022 07:15:15 -0800 (PST)
Received: by mail-lf1-x133.google.com with SMTP id bf43so14113494lfb.6
        for <linux-kernel@vger.kernel.org>; Mon, 19 Dec 2022 07:15:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NLwTozcUqVuaex+an++z/NMr4xtzIfovpnza53ZqTDE=;
        b=Ph1MMT+VKo3WhiyGRG1FZKkXojebF95OOhoxbbAdyKuxvtcuJHNFcTz+GQryrGBEJH
         JgoEcPjmfRrTHRZ6gQrzc0a97FezxX/lSEA5WkJkWTxfOmkD7BWFipsPNylStoKPLclU
         4juNW9JRwUbpvvXYTgXaUp4kKivBGFRoR05rQgeYzBZ5+4gdktxjA3Mp7NsfrUCuZiAn
         271GvZZQJo0W+1njeKjlKWlG7nJIT4KFHgVz9W1wNIB5EsXZdM/BJwAYkkXEkioVughp
         VFbbXbXy939GC7TRbJxNCrsD7XBrkTuQQLbJyg0zNVx+iQq/cWbFGjEYLrgt05etQPnn
         gOkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NLwTozcUqVuaex+an++z/NMr4xtzIfovpnza53ZqTDE=;
        b=xNy30C73Rux6pUa5LkOFj9nR1Ccog7udwxmoZ46x+GgoC47gMetqPWjHaBP+5F57wY
         af+MW4tNnKRvz0+9qbHnh8FZZu6RDap/xglrY7opoSdAwh9A+Ky4uMgGju96jNyY5RbO
         xYtwa6DPmxWVaYfm+dvO7A2U71tzvBbJHBKAtVii133mB0x4pP6xWW9otwlHWT+7+B1M
         pmhXoCOMSPeECvtA7PvmqKKWvaR/TRhjywO8RSdxFMPL3upqJe6zNiVS5UpsOooR077b
         ZJ80eUuPTt5qm4RW4fsjFTXMfAuYtoUmIzjlLBEGj0BRollsDi3NjLIkqrk01eiSR2+h
         +B9g==
X-Gm-Message-State: AFqh2koAwnnPvh7n9yni0CZYhm03KAnU1f1V57qDyt+zZwOA5rLpVZL1
        gflz/vPnGxF990CIWNdHtrSg4TmxVSEc8o5k
X-Google-Smtp-Source: AMrXdXuGYlf+vpB46IweTHtie63ev7zPtyxOiEOJ2TTi6R+ghe6q6e1/IXIJXq9YScrmKCSb2fxeRg==
X-Received: by 2002:a05:6512:695:b0:4c3:3a78:eab6 with SMTP id t21-20020a056512069500b004c33a78eab6mr4004090lfe.65.1671462914357;
        Mon, 19 Dec 2022 07:15:14 -0800 (PST)
Received: from krzk-bin.NAT.warszawa.vectranet.pl (088156142067.dynamic-2-waw-k-3-2-0.vectranet.pl. [88.156.142.67])
        by smtp.gmail.com with ESMTPSA id e1-20020a05651236c100b004bd8534ebbcsm1109894lfs.37.2022.12.19.07.15.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Dec 2022 07:15:14 -0800 (PST)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Kevin Hilman <khilman@kernel.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Sudeep Holla <sudeep.holla@arm.com>, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Adrien Thierry <athierry@redhat.com>,
        Brian Masney <bmasney@redhat.com>,
        linux-rt-users@vger.kernel.org
Subject: [PATCH v2 3/5] cpuidle: psci: Do not suspend topology CPUs on PREEMPT_RT
Date:   Mon, 19 Dec 2022 16:15:01 +0100
Message-Id: <20221219151503.385816-4-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20221219151503.385816-1-krzysztof.kozlowski@linaro.org>
References: <20221219151503.385816-1-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Realtime kernels are not supposed to go into deep sleep modes (neither
system nor CPUs) because the latencies might become unpredictable.
Therefore actual power suspending of CPU topology is not that important.

On the other hand, this runtime PM of CPU topology is not compatible
with PREEMPT_RT:
1. Core cpuidle path disables IRQs.
2. Core cpuidle calls cpuidle-psci.
3. cpuidle-psci in __psci_enter_domain_idle_state() calls
   pm_runtime_put_sync_suspend() and pm_runtime_get_sync() which use
   spinlocks (which are sleeping on PREEMPT_RT):

  BUG: sleeping function called from invalid context at kernel/locking/spinlock_rt.c:46
  in_atomic(): 1, irqs_disabled(): 128, non_block: 0, pid: 0, name: swapper/0
  preempt_count: 1, expected: 0
  RCU nest depth: 0, expected: 0
  1 lock held by swapper/0/0:
   #0: ffff20524613c1a0 (&dev->power.lock){+.+.}-{3:3}, at: __pm_runtime_suspend+0x30/0xac
  irq event stamp: 18776
  hardirqs last  enabled at (18775): [<ffffa4853720ac80>] tick_nohz_idle_enter+0x7c/0x17c
  hardirqs last disabled at (18776): [<ffffa4853717ae00>] do_idle+0xe0/0x300
  softirqs last  enabled at (4310): [<ffffa48537126398>] __local_bh_enable_ip+0x98/0x280
  softirqs last disabled at (4288): [<ffffa4853721c250>] cgroup_idr_alloc.constprop.0+0x0/0xd0
  Preemption disabled at:
  [<ffffa485381e55a0>] schedule_preempt_disabled+0x20/0x30
  CPU: 0 PID: 0 Comm: swapper/0 Tainted: G        W          6.1.0-rt5-00322-gb49b67f1d8dc #1
  Hardware name: Qualcomm Technologies, Inc. Robotics RB5 (DT)
  Call trace:
   dump_backtrace.part.0+0xe0/0xf0
   show_stack+0x18/0x40
   dump_stack_lvl+0x8c/0xb8
   dump_stack+0x18/0x34
   __might_resched+0x17c/0x214
   rt_spin_lock+0x5c/0x100
   __pm_runtime_suspend+0x30/0xac
   __psci_enter_domain_idle_state.constprop.0+0x60/0x104
   psci_enter_domain_idle_state+0x18/0x2c
   cpuidle_enter_state+0x220/0x37c
   cpuidle_enter+0x38/0x50
   do_idle+0x258/0x300
   cpu_startup_entry+0x28/0x30
   rest_init+0x104/0x180
   arch_post_acpi_subsys_init+0x0/0x18
   start_kernel+0x6fc/0x73c
   __primary_switched+0xbc/0xc4

Cc: Adrien Thierry <athierry@redhat.com>
Cc: Brian Masney <bmasney@redhat.com>
Cc: linux-rt-users@vger.kernel.org
Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 drivers/cpuidle/cpuidle-psci.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/cpuidle/cpuidle-psci.c b/drivers/cpuidle/cpuidle-psci.c
index 57bc3e3ae391..9d971cc4b12b 100644
--- a/drivers/cpuidle/cpuidle-psci.c
+++ b/drivers/cpuidle/cpuidle-psci.c
@@ -72,7 +72,7 @@ static int __psci_enter_domain_idle_state(struct cpuidle_device *dev,
 	ct_irq_enter_irqson();
 	if (s2idle)
 		dev_pm_genpd_suspend(pd_dev);
-	else
+	else if (!IS_ENABLED(CONFIG_PREEMPT_RT))
 		pm_runtime_put_sync_suspend(pd_dev);
 	ct_irq_exit_irqson();
 
@@ -85,7 +85,7 @@ static int __psci_enter_domain_idle_state(struct cpuidle_device *dev,
 	ct_irq_enter_irqson();
 	if (s2idle)
 		dev_pm_genpd_resume(pd_dev);
-	else
+	else if (!IS_ENABLED(CONFIG_PREEMPT_RT))
 		pm_runtime_get_sync(pd_dev);
 	ct_irq_exit_irqson();
 
-- 
2.34.1

