Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1A1DD73210D
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Jun 2023 22:43:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229978AbjFOUiF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Jun 2023 16:38:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48562 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229510AbjFOUiD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Jun 2023 16:38:03 -0400
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 634D2DF
        for <linux-kernel@vger.kernel.org>; Thu, 15 Jun 2023 13:38:02 -0700 (PDT)
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-1b505665e2fso9230455ad.0
        for <linux-kernel@vger.kernel.org>; Thu, 15 Jun 2023 13:38:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686861482; x=1689453482;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=xlt6XK9hN90RySb2MwOIg8snE8yI6VawU/byzCJpPMo=;
        b=i4WU4YaIuYXZ7AcYaqhOpHXqFIJM56oxddXNKiLMXXHR2oVeFWl4ERS8sTfm3EL/9w
         IkrMi+gkYrXNU5xYMjCbeXxsox6D6ONUgyh5qzcbCT0YLubJdPVIsFc5eRtSFJNFjQ4O
         uu4bhQfoaOggcGAsvK8kJ/8ArS2stpjLHx0OF0wPGhCJQQXDHzw2Ujp58POJllGiNtX4
         TaPSIgrSJx3CpZrilFEKcnh1NHZP8CGbduy26GoPXRimijq1TioxmqMnEqvjmVorHT/v
         oz4cXqXScEtO/CE0TFcXIRB8K6P+XBWqVMEwrxClXmZAY9Dn/zwxSYrxZBBRTgRIiN1J
         j6tw==
X-Gm-Message-State: AC+VfDza6qQUHEuoPXgfmYlCsphlVcglATsKYL/B9X1nwGjZi7fAI56a
        2Pcn/ujq5mNcKj6u8cY10tHTjx9bVaw=
X-Google-Smtp-Source: ACHHUZ7nzjF9yaxFmIg5s6AhUUkKKz1+LAuskrhhtBpTXTKNbyLqjvW7hUeZ44kWxXsE1xb2JVO1zg==
X-Received: by 2002:a17:902:c951:b0:1a2:a904:c42e with SMTP id i17-20020a170902c95100b001a2a904c42emr9208116pla.24.1686861481675;
        Thu, 15 Jun 2023 13:38:01 -0700 (PDT)
Received: from asus.hsd1.ca.comcast.net ([98.51.102.78])
        by smtp.gmail.com with ESMTPSA id y20-20020a170902b49400b001a980a23804sm14487233plr.4.2023.06.15.13.38.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Jun 2023 13:38:01 -0700 (PDT)
From:   Bart Van Assche <bvanassche@acm.org>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     linux-kernel@vger.kernel.org, Bart Van Assche <bvanassche@acm.org>,
        Ingo Molnar <mingo@redhat.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>
Subject: [PATCH] sched/cputime: Make IRQ time accounting configurable at boot time
Date:   Thu, 15 Jun 2023 13:37:26 -0700
Message-ID: <20230615203745.1259-1-bvanassche@acm.org>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Some producers of Android devices want IRQ time accounting enabled while
others want IRQ time accounting disabled. Hence, make IRQ time accounting
configurable at boot time.

Cc: Ingo Molnar <mingo@redhat.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Juri Lelli <juri.lelli@redhat.com>
Cc: Vincent Guittot <vincent.guittot@linaro.org>
Cc: Dietmar Eggemann <dietmar.eggemann@arm.com>
Cc: Steven Rostedt <rostedt@goodmis.org>
Signed-off-by: Bart Van Assche <bvanassche@acm.org>
---
 Documentation/admin-guide/kernel-parameters.txt |  4 ++++
 kernel/sched/cputime.c                          | 13 +++++++++++++
 2 files changed, 17 insertions(+)

diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
index 9e5bab29685f..67a2ad3af833 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -5611,6 +5611,10 @@
 			non-zero "wait" parameter.  See weight_single
 			and weight_many.
 
+	sched_clock_irqtime= [KNL]
+			Can be used to disable IRQ time accounting if
+			CONFIG_IRQ_TIME_ACCOUNTING=y.
+
 	skew_tick=	[KNL] Offset the periodic timer tick per cpu to mitigate
 			xtime_lock contention on larger systems, and/or RCU lock
 			contention on all systems with CONFIG_MAXSMP set.
diff --git a/kernel/sched/cputime.c b/kernel/sched/cputime.c
index af7952f12e6c..d9c65017024d 100644
--- a/kernel/sched/cputime.c
+++ b/kernel/sched/cputime.c
@@ -24,6 +24,19 @@ DEFINE_PER_CPU(struct irqtime, cpu_irqtime);
 
 static int sched_clock_irqtime;
 
+static int __init sched_clock_irqtime_setup(char *arg)
+{
+	bool enabled;
+
+	if (kstrtobool(arg, &enabled) < 0)
+		pr_err("Invalid sched_clock_irqtime value\n");
+	else
+		sched_clock_irqtime = enabled;
+	return 1;
+}
+
+__setup("sched_clock_irqtime=", sched_clock_irqtime_setup);
+
 void enable_sched_clock_irqtime(void)
 {
 	sched_clock_irqtime = 1;
