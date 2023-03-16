Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7095D6BC7AA
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Mar 2023 08:49:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229870AbjCPHtP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Mar 2023 03:49:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43904 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230040AbjCPHtJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Mar 2023 03:49:09 -0400
Received: from mail-pf1-x42f.google.com (mail-pf1-x42f.google.com [IPv6:2607:f8b0:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 42CBAA8C62;
        Thu, 16 Mar 2023 00:49:03 -0700 (PDT)
Received: by mail-pf1-x42f.google.com with SMTP id b20so584562pfo.6;
        Thu, 16 Mar 2023 00:49:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678952943;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Cm9FeMy4GVQb6Y304/sdZ2D3L6nSGw+tgNkZCTPzffM=;
        b=h3a0FB3zEfWLChDCwDTq4NbtUzDTJqXLr2JguGJfZ3NC9rb4PXY++xqU1s/1JYq7IN
         N85hOfCEM6ikcoY+6Nd9OCwR6nLmZWxBu8uJkhPgpYAESla4/OZPMWBRLjwevEqtqbol
         LDe0mW/Dt4Z3sjX2k3sCIJccy3VLnjU9qqS3CtGzZqhyqx2iALqCGXMn23q7WQaqU54s
         mJPpsTkp6TlCGhI4JU5ACu2YQMY6+yUXHQRKASuhnIiJBgz6I++M4HfKd4zHCZxdiLqB
         bOdfZL18etGM01A2VnoHRUU/WIg7NUtcJLEoeLr5INmST6W4qTj1gGY5sT6UxLzaDiqF
         jApg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678952943;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Cm9FeMy4GVQb6Y304/sdZ2D3L6nSGw+tgNkZCTPzffM=;
        b=bfO3znq1RSvl6ZtnDpGGm/h8gniQ4DQiZQZdNdGHmgONdNeMdRyQ63eYFyvTbWFh7T
         3RJA1Lup9LTgrkuyZQRZz6KAB+bua5Lnas0liwU0+rTK0mEaIzdo5AvD/7o9JbKJYRTt
         VKTQ94fIEyj2mo4TomiHHqllXvPLEdN9lTn0XdF+BrmR+ELoz/EczSYvFRZ7P/3hYAPk
         VmWuiqmzMNcs4pZ3JY3bPD9rcVaaocV9AYgwYdGZJmJAscwgbPr3GVIOV+4L9nS1txrM
         Zhw6s036bSM7l3fqcXOA5HTGOQNNPHFtYcHBKEA7vVNEfoXhXE240ZtUxLRuNkXMUSCt
         QHOQ==
X-Gm-Message-State: AO0yUKURUbaKh1ymL1nsADxB3MxygyP5YCfMNmfe4fu0o7rfZWf18ZnY
        UNTpTA1aRm0nUUvWOADSv4+8vOzUZA0t1g==
X-Google-Smtp-Source: AK7set9S+liUpjEXZPhBGtpSyKtFRvrIwjQMZRQp0K4mxJBXR4Bgn583qDgrBaMLg2+agLChSRsGtg==
X-Received: by 2002:aa7:97a2:0:b0:625:d5b5:1e9d with SMTP id d2-20020aa797a2000000b00625d5b51e9dmr2283432pfq.1.1678952942815;
        Thu, 16 Mar 2023 00:49:02 -0700 (PDT)
Received: from kazuki-mac.lan ([2400:4051:ea3:5910::789])
        by smtp.gmail.com with ESMTPSA id 23-20020aa79217000000b005e099d7c30bsm4683618pfo.205.2023.03.16.00.48.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Mar 2023 00:49:02 -0700 (PDT)
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
Subject: [PATCH 2/3] cpuidle: Don't pass any values to cpuidle_not_available
Date:   Thu, 16 Mar 2023 16:47:49 +0900
Message-Id: <20230316074750.289025-2-kazukih0205@gmail.com>
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

There's no reason to pass any values to cpuidle_not_available() as the
function works standalone. Since we're planning to use the function in
other places, make it so to avoid code duplication.

Signed-off-by: Kazuki H <kazukih0205@gmail.com>
---
 drivers/cpuidle/cpuidle.c | 6 ++++--
 include/linux/cpuidle.h   | 6 ++----
 kernel/sched/idle.c       | 2 +-
 3 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/drivers/cpuidle/cpuidle.c b/drivers/cpuidle/cpuidle.c
index 6eceb1988243..cc05acf4d2a8 100644
--- a/drivers/cpuidle/cpuidle.c
+++ b/drivers/cpuidle/cpuidle.c
@@ -48,9 +48,11 @@ void disable_cpuidle(void)
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
index fce476275e16..11de17924910 100644
--- a/include/linux/cpuidle.h
+++ b/include/linux/cpuidle.h
@@ -139,8 +139,7 @@ struct cpuidle_driver {
 
 #ifdef CONFIG_CPU_IDLE
 extern void disable_cpuidle(void);
-extern bool cpuidle_not_available(struct cpuidle_driver *drv,
-				  struct cpuidle_device *dev);
+extern bool cpuidle_not_available(void);
 
 extern int cpuidle_select(struct cpuidle_driver *drv,
 			  struct cpuidle_device *dev,
@@ -174,8 +173,7 @@ static inline struct cpuidle_device *cpuidle_get_device(void)
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
index dbfc2eb5ccbd..558a5c987597 100644
--- a/kernel/sched/idle.c
+++ b/kernel/sched/idle.c
@@ -179,7 +179,7 @@ static void cpuidle_idle_call(void)
 		return;
 	}
 
-	if (cpuidle_not_available(drv, dev)) {
+	if (cpuidle_not_available()) {
 		tick_nohz_idle_stop_tick();
 
 		default_idle_call();
-- 
2.40.0

