Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 74101736E5A
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Jun 2023 16:10:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233125AbjFTOKk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Jun 2023 10:10:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59950 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233179AbjFTOK3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Jun 2023 10:10:29 -0400
Received: from mail-pg1-f181.google.com (mail-pg1-f181.google.com [209.85.215.181])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F47410D0
        for <linux-kernel@vger.kernel.org>; Tue, 20 Jun 2023 07:10:28 -0700 (PDT)
Received: by mail-pg1-f181.google.com with SMTP id 41be03b00d2f7-543c6a2aa07so2574574a12.0
        for <linux-kernel@vger.kernel.org>; Tue, 20 Jun 2023 07:10:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687270227; x=1689862227;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ap5IZH05ERagNKETj159A0RX6A3SJUXfdqaxkcgtg4A=;
        b=CL67ZwENOueh1dYN//C3qSlAnolEKfoKsSYWjDgoQ5VheQk8TBCfSlBK2Pfcmw7xMP
         9YU2yqa76RAcIjtpnMJu6124uYKpqxk8jsgzn4cQzpKr+b27S0HNtMwuVSZ9boGKRLZT
         N8+OKBw23tPd6oepjINnul5QKaCva5sazYG92TvRGnIIfSIarqkfnH4ipQlDyk6YTn97
         89tZS2talgNAXilTELE3hXfIeOC8J3zvseYP+Hw4TXK4wdbslyFiEs+p/nZ5DS6qHIXg
         AslBwXhK81waJnmEdFQdz+80EqgC9yBhrNUGq7tAAlQ0dMXO4Bx/t9Hm1RzanuNzpjYR
         lZTQ==
X-Gm-Message-State: AC+VfDwgMeCgIag5cIz2io2t3GmO9C9uyoFmrvua+xZOXYOIjWJhv9WI
        DiSaDnRDhcIGMmb//8sv32xqANCbLvI=
X-Google-Smtp-Source: ACHHUZ5V+S91GQCXfHVT+aEui7l6XpCKb5K2fIH1hlYia+i6tcWMj7r8kBKEnrj85BsjcDG5U0iazg==
X-Received: by 2002:a17:902:a3c7:b0:1b4:fd48:d734 with SMTP id q7-20020a170902a3c700b001b4fd48d734mr8288044plb.47.1687270227328;
        Tue, 20 Jun 2023 07:10:27 -0700 (PDT)
Received: from asus.hsd1.ca.comcast.net ([98.51.102.78])
        by smtp.gmail.com with ESMTPSA id p9-20020a1709028a8900b001afa7040a70sm1647536plo.276.2023.06.20.07.10.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Jun 2023 07:10:26 -0700 (PDT)
From:   Bart Van Assche <bvanassche@acm.org>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     linux-kernel@vger.kernel.org, Ingo Molnar <mingo@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Bart Van Assche <bvanassche@acm.org>,
        Juri Lelli <juri.lelli@redhat.com>
Subject: [PATCH v2] sched/cputime: Make IRQ time accounting configurable at boot time
Date:   Tue, 20 Jun 2023 07:10:02 -0700
Message-ID: <20230620141002.23914-1-bvanassche@acm.org>
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

IRQ time accounting reduces performance by 40% for some block storage
workloads on Android. Despite this some producers of Android devices
want to keep IRQ time accounting enabled.

Android devices share a single kernel binary across device vendors.
Make IRQ time accounting configurable at boot time such that Android
vendors can decide individually whether or not to enable IRQ time
accounting.

Cc: Ingo Molnar <mingo@redhat.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Juri Lelli <juri.lelli@redhat.com>
Cc: Vincent Guittot <vincent.guittot@linaro.org>
Cc: Dietmar Eggemann <dietmar.eggemann@arm.com>
Cc: Steven Rostedt <rostedt@goodmis.org>
Signed-off-by: Bart Van Assche <bvanassche@acm.org>
---

Changes between v1 and v2: improved patch description.

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
