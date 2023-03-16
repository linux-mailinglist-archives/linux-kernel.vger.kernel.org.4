Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A102D6BC630
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Mar 2023 07:37:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229770AbjCPGhg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Mar 2023 02:37:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49076 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229616AbjCPGhb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Mar 2023 02:37:31 -0400
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com [IPv6:2607:f8b0:4864:20::1031])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 36861A90BF;
        Wed, 15 Mar 2023 23:37:24 -0700 (PDT)
Received: by mail-pj1-x1031.google.com with SMTP id o6-20020a17090a9f8600b0023f32869993so389691pjp.1;
        Wed, 15 Mar 2023 23:37:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678948643;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Cm9FeMy4GVQb6Y304/sdZ2D3L6nSGw+tgNkZCTPzffM=;
        b=FllZhFiS4t3MU/LFOgYnLK3f+3xQnobC/Eje5B3tri7nYEBsh1EY04bivKL5e3GZs1
         OAltPEBoIuvjNsRPRPgN6TKdR0oDPyvKXJJwBoX8ycWivbCyNdrK15GzL9cjDKfBA34f
         003QB6/Uk7/MDReoNc0gvkv2C9s1Mdfg2bWw1+skr58TWJqhUIWeMIgtxM8DjX1TYhue
         iSEs4xONpTaajb8xcLDuZRMFA725/67/vzUYpYap32wFFimZ1Rp6IcEdYJxuSuMW0KI5
         8R9tn+7PtK8rbWV9Q40ZygxKF5w/pnHrCg4Q2NJm5Ekym1b9zZW3dbVWgNGC8w9aQRys
         BxSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678948643;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Cm9FeMy4GVQb6Y304/sdZ2D3L6nSGw+tgNkZCTPzffM=;
        b=lZLnrfKXPstiylmSUjNnLrObevR3p6OZuzfC2suHY6zmPsX0ruDV6T8JDCn+VxXBae
         QVa7/E4VAqdXOb0x8fLhYJNXe7/3iH+crW0lzusMbDpqZJqOS5TqASzopLQMerliUitl
         xfdCTZTphzpEMltxQsPSHSHetbSM4mP/6MFUJJCTUYugBOfeo07H3/HGmd8MoeZDKdWG
         FhV26tApJSVGXVS++TteNK9gq/aiKBQxVZMkyCDKwuzJZMO3WudcrT5QyO/2xm1dE+FB
         Co2D6/b1bWPXkuAfwALbQWzRT/KD+TQtiDxO3jJON81N4ZFiwjsbsiftGJSQsZV2bc72
         kJeg==
X-Gm-Message-State: AO0yUKWijUjgEBmrqOgDkCSKQLeACEtqL3uP9CCsddCImUgpPAzqHV5H
        aBRRM8A931R1NVJIQ3cmLwE=
X-Google-Smtp-Source: AK7set8HXSo1tjSwttQQccUjLlgII+DzrcUS0gP1YMizWzLAbhAWFhcFnq2bzWb0C4yfSms5cOiHMQ==
X-Received: by 2002:a17:90b:17d0:b0:23e:feef:38ef with SMTP id me16-20020a17090b17d000b0023efeef38efmr2662513pjb.41.1678948643027;
        Wed, 15 Mar 2023 23:37:23 -0700 (PDT)
Received: from kazuki-mac.lan ([2400:4051:ea3:5910::789])
        by smtp.gmail.com with ESMTPSA id kv3-20020a17090328c300b0019c919bccf8sm4736494plb.86.2023.03.15.23.37.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Mar 2023 23:37:22 -0700 (PDT)
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
Subject: [PATCH 1/2] cpuidle: Don't pass any values to cpuidle_not_available
Date:   Thu, 16 Mar 2023 15:37:11 +0900
Message-Id: <20230316063712.33353-1-kazukih0205@gmail.com>
X-Mailer: git-send-email 2.40.0
In-Reply-To: <linux-pm@vger.kernel.org>
References: <linux-pm@vger.kernel.org>
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

