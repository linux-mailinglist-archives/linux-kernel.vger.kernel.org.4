Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DE5F66BC632
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Mar 2023 07:37:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229664AbjCPGht (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Mar 2023 02:37:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49624 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229716AbjCPGhm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Mar 2023 02:37:42 -0400
Received: from mail-pl1-x629.google.com (mail-pl1-x629.google.com [IPv6:2607:f8b0:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E771BA8E8D;
        Wed, 15 Mar 2023 23:37:30 -0700 (PDT)
Received: by mail-pl1-x629.google.com with SMTP id o11so712562ple.1;
        Wed, 15 Mar 2023 23:37:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678948647;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FqZfoUoxy8iXzcBbOibqnO/QMawNVpGzC8pVpMz5OXw=;
        b=JMs0rD4cQCx8cqdr/zvl+I5qPwmOLOYhVQJktHL7BfRkKgKvgf2mjkb+rst3GommLY
         7ba3P6m7tvq90zsLFklXbt2BbVQ/59mpFxkIXRxyrg4d2qh3e3H6Fo1glkVpV7sSyaqM
         7wzGs1mvQlhcDMmBAt+Xtqi7DzcnzWQabTNKjkVteP4RaZhG3SARwuRrodkVZGzl6Nvk
         IYyy1xzwhPiKluCtnUkcPuPDR1UUyrqFRhzrxiCPXx8M0YR00CK+EH6qnAyILjkNIoe9
         4effejcgLd9T6Eht3vkfCeW4Gi15esbycvKU3GrBg1gDNVJEJqqkkGqlifwEaGEMUElz
         9FZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678948647;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FqZfoUoxy8iXzcBbOibqnO/QMawNVpGzC8pVpMz5OXw=;
        b=vMHg4JahxYbDNxqdVimV1g8PN9LqQ4529XOp22MlM7N/lveqKb+0UftUf0PAQHqV6b
         m8LWtRaC1IQ/ZSv85UfNf6ggqbRBPbOUqNONSROcpuAEKxe81/SrQ6vEvRKeM1b46G/3
         nZBH+/9i3d4lH7/XUcQPmFlmzSP1O2wI0j6rrT9rpInKPWfSitM2W0MCsdNFkgQ9BhD4
         PWfr3it2ce6aSYsoUO33/gq7Eyy/Ni28+93O40N+8iIJ8yic5+I3hUkLZWN9eYkfzN6+
         2YzY8cB1JxaiPErLO8ap67JpHJ7bwDsyuJ0ZskCua1Ngtq3e9e/hWZaMOGpE0yMWGX1s
         VnkA==
X-Gm-Message-State: AO0yUKXZjG2p/qo21QLDj5TUdlItQzK9e8Ha1V3FpajypSKohECYLUfB
        OUDqVmetcLA4YdUbYc3YFMk=
X-Google-Smtp-Source: AK7set86vDn5PFD4QCBbSDdou2ZcPtqNUeIHL8m3SRx9pIlTF+LGd3uj+muSrq5EvS6Iy/rmYneSVQ==
X-Received: by 2002:a17:903:1d2:b0:1a0:7508:dae6 with SMTP id e18-20020a17090301d200b001a07508dae6mr2250006plh.63.1678948647498;
        Wed, 15 Mar 2023 23:37:27 -0700 (PDT)
Received: from kazuki-mac.lan ([2400:4051:ea3:5910::789])
        by smtp.gmail.com with ESMTPSA id kv3-20020a17090328c300b0019c919bccf8sm4736494plb.86.2023.03.15.23.37.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Mar 2023 23:37:27 -0700 (PDT)
From:   Kazuki H <kazukih0205@gmail.com>
Cc:     Hector Martin <marcan@marcan.st>, Sven Peter <sven@svenpeter.dev>,
        Kazuki H <kazukih0205@gmail.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Pavel Machek <pavel@ucw.cz>, Len Brown <len.brown@intel.com>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Valentin Schneider <vschneid@redhat.com>,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 2/2] PM: s2idle: Fully block the system from entering s2idle when cpuidle isn't supported
Date:   Thu, 16 Mar 2023 15:37:12 +0900
Message-Id: <20230316063712.33353-2-kazukih0205@gmail.com>
X-Mailer: git-send-email 2.40.0
In-Reply-To: <20230316063712.33353-1-kazukih0205@gmail.com>
References: <linux-pm@vger.kernel.org>
 <20230316063712.33353-1-kazukih0205@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

s2idle isn't supported on platforms that don't support cpuidle as of
31a3409065d1 ("cpuidle / sleep: Do sanity checks in cpuidle_enter_freeze()
too").

There is a check in the cpuidle subsystem which would prevent the
system from entering s2idle. However, there is nothing in the suspend
framework which prevents this, which can cause the suspend subsystem to
think that the machine is entering s2idle while the cpuidle subsystem is
not, which can completely break the system.

Block the machine from entering s2idle when cpuidle isn't supported in
the suspend subsystem as well.

Link: https://lore.kernel.org/all/20230204152747.drte4uitljzngdt6@kazuki-mac
Fixes: 31a3409065d1 ("cpuidle / sleep: Do sanity checks in cpuidle_enter_freeze() too")
Signed-off-by: Kazuki H <kazukih0205@gmail.com>
---
 kernel/power/main.c    | 12 +++++++++---
 kernel/power/suspend.c |  5 +++++
 2 files changed, 14 insertions(+), 3 deletions(-)

diff --git a/kernel/power/main.c b/kernel/power/main.c
index 31ec4a9b9d70..b14765447989 100644
--- a/kernel/power/main.c
+++ b/kernel/power/main.c
@@ -133,6 +133,8 @@ static ssize_t mem_sleep_show(struct kobject *kobj, struct kobj_attribute *attr,
 	for (i = PM_SUSPEND_MIN; i < PM_SUSPEND_MAX; i++) {
 		if (i >= PM_SUSPEND_MEM && cxl_mem_active())
 			continue;
+		if (i == PM_SUSPEND_TO_IDLE && cpuidle_not_available())
+			continue;
 		if (mem_sleep_states[i]) {
 			const char *label = mem_sleep_states[i];
 
@@ -185,11 +187,15 @@ static ssize_t mem_sleep_store(struct kobject *kobj, struct kobj_attribute *attr
 	}
 
 	state = decode_suspend_state(buf, n);
-	if (state < PM_SUSPEND_MAX && state > PM_SUSPEND_ON)
+	if (state == PM_SUSPEND_TO_IDLE && cpuidle_not_available())
+		goto einval;
+	if (state < PM_SUSPEND_MAX && state > PM_SUSPEND_ON) {
 		mem_sleep_current = state;
-	else
-		error = -EINVAL;
+		goto out;
+	}
 
+ einval:
+	error = -EINVAL;
  out:
 	pm_autosleep_unlock();
 	return error ? error : n;
diff --git a/kernel/power/suspend.c b/kernel/power/suspend.c
index 3f436282547c..55ddf525aaaf 100644
--- a/kernel/power/suspend.c
+++ b/kernel/power/suspend.c
@@ -556,6 +556,11 @@ static int enter_state(suspend_state_t state)
 
 	trace_suspend_resume(TPS("suspend_enter"), state, true);
 	if (state == PM_SUSPEND_TO_IDLE) {
+		if (cpuidle_not_available()) {
+			pr_warn("s2idle is unsupported when cpuidle is unavailable");
+			return -EINVAL;
+		}
+
 #ifdef CONFIG_PM_DEBUG
 		if (pm_test_level != TEST_NONE && pm_test_level <= TEST_CPUS) {
 			pr_warn("Unsupported test mode for suspend to idle, please choose none/freezer/devices/platform.\n");
-- 
2.40.0

