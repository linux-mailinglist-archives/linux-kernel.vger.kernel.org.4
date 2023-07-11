Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 71D1274E692
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jul 2023 07:54:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230344AbjGKFyg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Jul 2023 01:54:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37934 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229585AbjGKFya (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jul 2023 01:54:30 -0400
Received: from mail-pg1-x534.google.com (mail-pg1-x534.google.com [IPv6:2607:f8b0:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A9C0E195;
        Mon, 10 Jul 2023 22:54:29 -0700 (PDT)
Received: by mail-pg1-x534.google.com with SMTP id 41be03b00d2f7-55bac17b442so4041832a12.3;
        Mon, 10 Jul 2023 22:54:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1689054869; x=1691646869;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=pATxnRjw1kvbkvJOwnrnm5lR+PWjwDmKzZaehDZNMZU=;
        b=J2YdBxXTObGU48Mlg1QDs9/IFFLJTaAdZHwxFx67EdkgpuaTy9VzUan8q62OndaNBK
         krWqsHjhli9TJv4piybN/VGrEhfIg88Reqn1rorGP/xkRN3qVjSUuRs5/xNKkWIZn3dj
         D4+Xb1BnGbAWjxZAs6Qa9+wZpaSokuxonMC68/0c6MjqrBfq7MFXaWs9DKpBC3j3AlHH
         llHkjZtUkqehSGVHQup4Q4zmtrb/dBblnV28R/NMSZ19RbK13D74xVnHReSvwezEiGmt
         5mCFawl60m7HbTqkUeslWnHXAyeYUEqkK4FrxjbQuwBwORM1sExFmXoNQ0lQ3TbrjVfS
         mqcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689054869; x=1691646869;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pATxnRjw1kvbkvJOwnrnm5lR+PWjwDmKzZaehDZNMZU=;
        b=dhA0sz41J8QCCnuXiC/brncggNx6xXcBzsvxkCsZT9p4wrqgErnYsiWMJ+t6MerlkR
         pRAudO/sjDceXmaJMKsHGVKmBj3Co+9XwwvnGspHkdw6W4wp1DGZbfLyRYyo12k51iBx
         cuGykEssN2Pr0ZEyify2GitZ9rm/n0gGsEpOoRQ/Gvlbfn4D2qGI/kC1VBfb02v8oowx
         zZzzLSCDoSFI6jWEHICpstJPrF1UsZ4HlQ16BpYfe6tbPaFsknHZOt5OaIfdDRZpSL0t
         qdeVtp8ZneBd/xzyLHmPxRiiLSkxGVLk5gicathujKBERRd1jhKptiH7KOsNwsXDH7KH
         mdLA==
X-Gm-Message-State: ABy/qLaWeMGxgNT+6VYntoF4N23C4PfR6fP1sLihK+2a7uYp/OJD9pmp
        qNmNQsPXJJma98l/HLn1c+sRmrjjVm8=
X-Google-Smtp-Source: APBJJlFbC2r2TbKbAv2XntBUqFc4qfvmGXL0dlkqVhIHaiYtvBxuxn7DfaqhmSspLR2fLdd3xEO1Fg==
X-Received: by 2002:a05:6a20:1612:b0:125:87b1:a30d with SMTP id l18-20020a056a20161200b0012587b1a30dmr19359235pzj.1.1689054869144;
        Mon, 10 Jul 2023 22:54:29 -0700 (PDT)
Received: from j293.lan ([2400:4051:ea3:5910:5676:1078:8b85:c18f])
        by smtp.gmail.com with ESMTPSA id bd5-20020a170902830500b001b8761c739csm878053plb.271.2023.07.10.22.54.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Jul 2023 22:54:28 -0700 (PDT)
From:   Kazuki Hashimoto <kazukih0205@gmail.com>
Date:   Tue, 11 Jul 2023 14:54:21 +0900
Subject: [PATCH 1/2] cpuidle: Don't pass any values to
 cpuidle_not_available
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230711-cpuidle-v1-1-f391224b3140@gmail.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1689054863; l=2377;
 i=kazukih0205@gmail.com; s=20230709; h=from:subject:message-id;
 bh=KEMzFSoNpLPvIqVf3L5RPIfQHsabNi9qRgonhXVECcU=;
 b=YeQaYzdMq0SvFc5ST91wRuJNDDD5zIEm+g2+iXejUAUavkAROyVFrnoHun4n0BUc5Dj4GUPAp
 6alWWHJszE5D+XmnFhkpAv+C20AeVj21LgIN352NvjB8S8bhv9rfMvd
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

There's no reason to pass any values to cpuidle_not_available() as the
function works standalone. Since we're planning to use the function in
other places, make it so to avoid code duplication.

Signed-off-by: Kazuki Hashimoto <kazukih0205@gmail.com>
---
 drivers/cpuidle/cpuidle.c | 6 ++++--
 include/linux/cpuidle.h   | 6 ++----
 kernel/sched/idle.c       | 2 +-
 3 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/drivers/cpuidle/cpuidle.c b/drivers/cpuidle/cpuidle.c
index 737a026ef58a..c9ba51e0fa38 100644
--- a/drivers/cpuidle/cpuidle.c
+++ b/drivers/cpuidle/cpuidle.c
@@ -49,9 +49,11 @@ void disable_cpuidle(void)
 	off = 1;
 }
 
-bool cpuidle_not_available(struct cpuidle_driver *drv,
-			   struct cpuidle_device *dev)
+bool cpuidle_not_available(void)
 {
+	struct cpuidle_device *dev = cpuidle_get_device();
+	struct cpuidle_driver *drv = cpuidle_get_cpu_driver(dev);
+
 	return off || !initialized || !drv || !dev || !dev->enabled;
 }
 
diff --git a/include/linux/cpuidle.h b/include/linux/cpuidle.h
index 3183aeb7f5b4..a0ce9b6d16ce 100644
--- a/include/linux/cpuidle.h
+++ b/include/linux/cpuidle.h
@@ -169,8 +169,7 @@ struct cpuidle_driver {
 
 #ifdef CONFIG_CPU_IDLE
 extern void disable_cpuidle(void);
-extern bool cpuidle_not_available(struct cpuidle_driver *drv,
-				  struct cpuidle_device *dev);
+extern bool cpuidle_not_available(void);
 
 extern int cpuidle_select(struct cpuidle_driver *drv,
 			  struct cpuidle_device *dev,
@@ -204,8 +203,7 @@ static inline struct cpuidle_device *cpuidle_get_device(void)
 {return __this_cpu_read(cpuidle_devices); }
 #else
 static inline void disable_cpuidle(void) { }
-static inline bool cpuidle_not_available(struct cpuidle_driver *drv,
-					 struct cpuidle_device *dev)
+static inline bool cpuidle_not_available(void)
 {return true; }
 static inline int cpuidle_select(struct cpuidle_driver *drv,
 				 struct cpuidle_device *dev, bool *stop_tick)
diff --git a/kernel/sched/idle.c b/kernel/sched/idle.c
index 342f58a329f5..865674d2e420 100644
--- a/kernel/sched/idle.c
+++ b/kernel/sched/idle.c
@@ -164,7 +164,7 @@ static void cpuidle_idle_call(void)
 	 * step to the grace period
 	 */
 
-	if (cpuidle_not_available(drv, dev)) {
+	if (cpuidle_not_available()) {
 		tick_nohz_idle_stop_tick();
 
 		default_idle_call();

-- 
2.41.0

