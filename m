Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2ADFA6BC7AC
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Mar 2023 08:49:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230258AbjCPHt0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Mar 2023 03:49:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44038 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230123AbjCPHtM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Mar 2023 03:49:12 -0400
Received: from mail-pl1-x62c.google.com (mail-pl1-x62c.google.com [IPv6:2607:f8b0:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 14ED2ACBB5;
        Thu, 16 Mar 2023 00:49:08 -0700 (PDT)
Received: by mail-pl1-x62c.google.com with SMTP id a2so845522plm.4;
        Thu, 16 Mar 2023 00:49:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678952947;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FqZfoUoxy8iXzcBbOibqnO/QMawNVpGzC8pVpMz5OXw=;
        b=XrakP6GBQtekN+sgg3bQqv9Ep1KiZK636rxYBHrDNRfSxKYnbN8Cthh35xM5RrFUDm
         xFJ2UFVsm1Q+b7nP/YVqdLhmNNwKhZb8DET900/eJBexkpozHqTrzo7htIM3wpBKjV/x
         mAZSMhFsdUtpsZBgVnKDUIe2MQqMSVyc1hUMVyYqJiwyov7trHFI5iA+FatMcMaUmeJJ
         eA3e4QcrU4yHQvsIopO3PINEORbtK+a5sXwH2TvW1dHF/Dszy69RoR/aiA7B9EMwG9E0
         /3FFpmnPHFhJnsFASME3zH+Jiw+7L/ggKZoY5hZ5NrXBWKMX9YKqdxbt9fhtcmfqsRkT
         iAog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678952947;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FqZfoUoxy8iXzcBbOibqnO/QMawNVpGzC8pVpMz5OXw=;
        b=nrtXH0cg+dg3UB8SJJa7BqQpkRR6WkewwZEcGol1cRpPyBUbTxblGgDCdzgZn+dRK7
         OBkQ+r7c7L5hfGb0h+W1g62Rl2i3//iFgdjsLBaY98fcE/dx8xOYuncdT1lKGue5Cb/1
         Zw+JoN1HpPks9vl93rQyjKJh0sjnBPk27b2/n6nwAaZNE0q1EX4NZtxfZX25+rwqOuE8
         FMVpfpLVtaHT2rWO2xPvS04shpExNL1+VBBKo+PrVWI3uTO1THIMAlWnO+fBYDymljT2
         I3zPLLCCcW+24Cw4dfGkpD5PFbv5UOgzgi/HQqpfdqAcpmSpOIlbtpLTRdQq8iIWHNdJ
         w6/A==
X-Gm-Message-State: AO0yUKULLEN+rCRzNgrqUOFXtPMOdnwZ9b81C+Z+1cE1MtiCbBPF6lcu
        BkxqG9cH4E4rzXG6ZAGhKLz4K6gfntsKRg==
X-Google-Smtp-Source: AK7set9uC6TxuZ+KP7W/oD56NUSmdRduZBGSJ23Hziptg0lvxtgTfF3oENH6ux6TKd+3TkqqBd/ZzQ==
X-Received: by 2002:a05:6a20:8413:b0:d5:c14c:1263 with SMTP id c19-20020a056a20841300b000d5c14c1263mr3123026pzd.53.1678952947327;
        Thu, 16 Mar 2023 00:49:07 -0700 (PDT)
Received: from kazuki-mac.lan ([2400:4051:ea3:5910::789])
        by smtp.gmail.com with ESMTPSA id 23-20020aa79217000000b005e099d7c30bsm4683618pfo.205.2023.03.16.00.49.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Mar 2023 00:49:07 -0700 (PDT)
From:   Kazuki H <kazukih0205@gmail.com>
To:     linux-pm@vger.kernel.org
Cc:     Hector Martin <marcan@marcan.st>, Sven Peter <sven@svenpeter.dev>,
        Kazuki H <kazukih0205@gmail.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Valentin Schneider <vschneid@redhat.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 3/3] PM: s2idle: Fully block the system from entering s2idle when cpuidle isn't supported
Date:   Thu, 16 Mar 2023 16:47:50 +0900
Message-Id: <20230316074750.289025-3-kazukih0205@gmail.com>
X-Mailer: git-send-email 2.40.0
In-Reply-To: <20230316074750.289025-1-kazukih0205@gmail.com>
References: <20230316074750.289025-1-kazukih0205@gmail.com>
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

