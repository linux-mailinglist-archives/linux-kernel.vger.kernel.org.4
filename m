Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B7EC969D70B
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Feb 2023 00:29:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232502AbjBTX3B (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Feb 2023 18:29:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45376 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229560AbjBTX27 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Feb 2023 18:28:59 -0500
Received: from todd.t-8ch.de (todd.t-8ch.de [IPv6:2a01:4f8:c010:41de::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 66ECC1ADD6;
        Mon, 20 Feb 2023 15:28:58 -0800 (PST)
From:   =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=weissschuh.net;
        s=mail; t=1676935736;
        bh=StkVh8EYn2M8lSWQkOZpzSnkaM6UG2ix3NA2mU1ujSY=;
        h=From:Date:Subject:To:Cc:From;
        b=iAJ6zGNs8mV19KPRE+LcbkGoLi/C3uTrb5mwgwn1mE2ss9N96hiHYx/pQuWHVNiuP
         xea0JougjV9GDyPqGyYpme8ENRZDkr4mUmvk0hlBUbOfulvlXanoSaSuKjUKf6vgoo
         TNxwEnXVwfe53qZgTfg92VQMDBZbrPUon15wLjMI=
Date:   Mon, 20 Feb 2023 23:28:54 +0000
Subject: [PATCH] cpufreq: schedutil: make kobj_type structure constant
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20230220-kobj_type-cpufreq-schedutil-v1-1-7d1c92293457@weissschuh.net>
X-B4-Tracking: v=1; b=H4sIADUC9GMC/x2NQQ7CIBAAv9Ls2U0oNdX4FWMM0EVWCaVLMZqmf
 5d4nDnMbFBImApcug2E3lx4Tg36QwcumPQg5KkxaKUHpbXC12yf9/WbCV2uXmjB4gJNdeWIp/P
 gRkuj9/0RWsGaQmjFJBdaI9UYm8xCnj//5fW27z+kgusTggAAAA==
To:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Valentin Schneider <vschneid@redhat.com>
Cc:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
X-Mailer: b4 0.12.1
X-Developer-Signature: v=1; a=ed25519-sha256; t=1676935734; l=1114;
 i=linux@weissschuh.net; s=20221212; h=from:subject:message-id;
 bh=StkVh8EYn2M8lSWQkOZpzSnkaM6UG2ix3NA2mU1ujSY=;
 b=kckNIChEMWfa+1fhtlh3HkKTqDhrOfjAkr8fg1Naezsig+rJQP5STOBUTzSsi5m0NxS8oS79P
 u3bTu15MMNeCvItOKt9O0EAlsBFlmSvr5XsryJnXGd6h4ya0NIEuS2l
X-Developer-Key: i=linux@weissschuh.net; a=ed25519;
 pk=KcycQgFPX2wGR5azS7RhpBqedglOZVgRPfdFSPB1LNw=
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since commit ee6d3dd4ed48 ("driver core: make kobj_type constant.")
the driver core allows the usage of const struct kobj_type.

Take advantage of this to constify the structure definition to prevent
modification at runtime.

Signed-off-by: Thomas Weißschuh <linux@weissschuh.net>
---
 kernel/sched/cpufreq_schedutil.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/sched/cpufreq_schedutil.c b/kernel/sched/cpufreq_schedutil.c
index 1207c78f85c1..4c073bd9b001 100644
--- a/kernel/sched/cpufreq_schedutil.c
+++ b/kernel/sched/cpufreq_schedutil.c
@@ -543,7 +543,7 @@ static void sugov_tunables_free(struct kobject *kobj)
 	kfree(to_sugov_tunables(attr_set));
 }
 
-static struct kobj_type sugov_tunables_ktype = {
+static const struct kobj_type sugov_tunables_ktype = {
 	.default_groups = sugov_groups,
 	.sysfs_ops = &governor_sysfs_ops,
 	.release = &sugov_tunables_free,

---
base-commit: 5b0ed5964928b0aaf0d644c17c886c7f5ea4bb3f
change-id: 20230220-kobj_type-cpufreq-schedutil-783c6be6ff14

Best regards,
-- 
Thomas Weißschuh <linux@weissschuh.net>

