Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7AC8B74E694
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jul 2023 07:54:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229585AbjGKFyj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Jul 2023 01:54:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37996 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230387AbjGKFyf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jul 2023 01:54:35 -0400
Received: from mail-pf1-x42e.google.com (mail-pf1-x42e.google.com [IPv6:2607:f8b0:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 92104E40;
        Mon, 10 Jul 2023 22:54:32 -0700 (PDT)
Received: by mail-pf1-x42e.google.com with SMTP id d2e1a72fcca58-666683eb028so2804971b3a.0;
        Mon, 10 Jul 2023 22:54:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1689054872; x=1691646872;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=nk4niLNV6K0/PBl1ZDWCwqAEI3u1h+Q4tTNLOBHoMWM=;
        b=kWPuKebr23fLuFvrI3MW4ogXI6dr/IRwsu/v40oN4sHO1B15ZKtejInkzcOS8BLsMS
         fhZIJ76/5TOOSuk+vi2y0XQIsK2m8hi7MDkVqr3jbkgYbBsmLRhJoC5X63gijFpNGFbN
         f01mVUks/HfHprmN16QR5elSbGKmQpGfpIjzzGSWHStCrRl7De6V8oOmqYXmvB2yLpuR
         i1ARofJ/hSDSj5BNou5oNgOAkTQMPze7ru4UQn1L62Eu6HpnI1sCqkW+bg73KgAhDCkZ
         4aL9MaFAbhZ1YsUsIbSdsUlKFWLvPjAbE8h/FIc46Xx93onlyxoEVynaDyEIeugwUgMU
         pm3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689054872; x=1691646872;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nk4niLNV6K0/PBl1ZDWCwqAEI3u1h+Q4tTNLOBHoMWM=;
        b=FAWYkeRkLx6h3aNIYKuf1cPaU2ezNP5AuapUvpPM0g0Echoj1c9YmCXaVEdkQAB1Lx
         DitnRqqPPsPoLlVob9c6ljDMLFDdS0wu84nQglQnuL0aTRoAI5KBkeDj+FEQbxxEqZy5
         iBRgtmo/NSfL1unfK0/48k6Ih2ItjLioKuIa+AUSfpERbs0iopL313uffRWPD+UjbCbO
         3dreCLm/wZ6jHvyUKOd9RjR0d5XHCPaIcZVROrDXuY2t7sMWZFPZ4JrzpIkl1rlIKAmE
         krd90RdDoyBQZA6rgjQ9vLl85LW/8NU0hFhYkt4g0QWoQggxaVpC9LsBpOXf+dvaiBai
         xTfA==
X-Gm-Message-State: ABy/qLYsS05a2+c/jWd++ovBRKzjSwCxV95fE5BsUiKgkGO+eYiqwtNy
        NEmAQJXAYcGTX4mza5b4bNDqr2quuCw=
X-Google-Smtp-Source: APBJJlEogGkNT4ZLN5vPivJF9MZxskDvW4C7eY2Gj7J+C8iQjwkmk1dh4d2I+BqDreEerwZ0ZeTRTw==
X-Received: by 2002:a05:6a21:6811:b0:131:1bbd:dc50 with SMTP id wr17-20020a056a21681100b001311bbddc50mr6236730pzb.6.1689054872037;
        Mon, 10 Jul 2023 22:54:32 -0700 (PDT)
Received: from j293.lan ([2400:4051:ea3:5910:5676:1078:8b85:c18f])
        by smtp.gmail.com with ESMTPSA id bd5-20020a170902830500b001b8761c739csm878053plb.271.2023.07.10.22.54.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Jul 2023 22:54:31 -0700 (PDT)
From:   Kazuki Hashimoto <kazukih0205@gmail.com>
Date:   Tue, 11 Jul 2023 14:54:22 +0900
Subject: [PATCH 2/2] PM: s2idle: Fully prevent the system from entering
 s2idle when cpuidle isn't supported
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230711-cpuidle-v1-2-f391224b3140@gmail.com>
References: <20230711-cpuidle-v1-0-f391224b3140@gmail.com>
In-Reply-To: <20230711-cpuidle-v1-0-f391224b3140@gmail.com>
To:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>
Cc:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Hector Martin <marcan@marcan.st>,
        Kazuki Hashimoto <kazukih0205@gmail.com>
X-Mailer: b4 0.12.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1689054863; l=2849;
 i=kazukih0205@gmail.com; s=20230709; h=from:subject:message-id;
 bh=M0tNL3ccyxkfW5oli7KYKognuqR974/5Z/sS00RLTpY=;
 b=+vtnn6cnlTZTyDy/DLEZFml0G2vgNaqFHTs6ssNRATlNAiax2uJaMsh5C/xmGlJkeKHtBogaV
 dZBlmMupN8cAw3FQS8Ek1VDKZkTlEKdBC/p9vYQA1hluzM5WyJFYx2t
X-Developer-Key: i=kazukih0205@gmail.com; a=ed25519;
 pk=r8m5wVK5lljix+hYnqXRT/GsxNkTADqXGmhdl7kykYY=
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In order for systems to properly enter s2idle, we need functions both in
the idle subsystem (such as call_cpuidle_s2idle()) and the suspend subsystem
to be executed.

s2idle got blocked in the idle subsystem on platforms without cpuidle after
commit ef2b22ac540c ("cpuidle / sleep: Use broadcast timer for states that stop
local timer"). However, the suspend subsystem doesn't have this, which can cause
the suspend subsystem to begin entering s2idle behind the idle subsystem's back,
which in turn can cause the system to enter s2idle even though all the functions
necessary for s2idle hasn't been executed, breaking the system
(e.g. ClOCK_MONOTONIC keeps ticking during suspend even though it's not supposed
to).

Prevent the system from entering s2idle when cpuidle isn't supported in the
suspend subsystem as well.

Fixes: ef2b22ac540c ("cpuidle / sleep: Use broadcast timer for states that stop local timer")
Signed-off-by: Kazuki Hashimoto <kazukih0205@gmail.com>
---
 kernel/power/main.c    | 12 +++++++++---
 kernel/power/suspend.c |  5 +++++
 2 files changed, 14 insertions(+), 3 deletions(-)

diff --git a/kernel/power/main.c b/kernel/power/main.c
index f6425ae3e8b0..82fedcf6032d 100644
--- a/kernel/power/main.c
+++ b/kernel/power/main.c
@@ -174,6 +174,8 @@ static ssize_t mem_sleep_show(struct kobject *kobj, struct kobj_attribute *attr,
 	for (i = PM_SUSPEND_MIN; i < PM_SUSPEND_MAX; i++) {
 		if (i >= PM_SUSPEND_MEM && cxl_mem_active())
 			continue;
+		if (i == PM_SUSPEND_TO_IDLE && cpuidle_not_available())
+			continue;
 		if (mem_sleep_states[i]) {
 			const char *label = mem_sleep_states[i];
 
@@ -226,11 +228,15 @@ static ssize_t mem_sleep_store(struct kobject *kobj, struct kobj_attribute *attr
 	}
 
 	state = decode_suspend_state(buf, n);
-	if (state < PM_SUSPEND_MAX && state > PM_SUSPEND_ON)
+	if (state == PM_SUSPEND_TO_IDLE && cpuidle_not_available())
+		goto err;
+	if (state < PM_SUSPEND_MAX && state > PM_SUSPEND_ON) {
 		mem_sleep_current = state;
-	else
-		error = -EINVAL;
+		goto out;
+	}
 
+ err:
+	error = -EINVAL;
  out:
 	pm_autosleep_unlock();
 	return error ? error : n;
diff --git a/kernel/power/suspend.c b/kernel/power/suspend.c
index fa3bf161d13f..02cc76c9109e 100644
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
2.41.0

