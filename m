Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A51926FDF14
	for <lists+linux-kernel@lfdr.de>; Wed, 10 May 2023 15:49:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237290AbjEJNta (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 May 2023 09:49:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52034 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237232AbjEJNtT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 May 2023 09:49:19 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 727561BE3;
        Wed, 10 May 2023 06:49:11 -0700 (PDT)
Date:   Wed, 10 May 2023 13:49:09 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1683726550;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=46hdFH2kJFRmyUO0PSjD3oY8ttFy+HiOOIKvoMeo0qQ=;
        b=qs9W96am12/lcomWsGMR/LFhQdcq1JuYTuBHDiI63Q+rV2tns+C2NQ8lTP5qwb9cQ/k559
        Fg0ab1Rh8YHZJNQXxEqsVlNONkf8MqA5ziYyliYC+NJoQxniXPoU1NxvSLxQprthb1PMwC
        BUua1mkzYeqFJPoncOyAvBGK4LA/FW7/CTTxNnVGL356vo2ND8zQmq9Hs+tgVJIzNsrvjD
        uEGMqETmWE2I+mtq5T+5vxJpokmzti+uY+CBpLgZGuQpMm1366O9lhggb/Bq4J1YJrBHUN
        c8ISWIThtkEVH+lxeYer6EA9o1EORr88j19yh2mu3dCU6dr64uWJn4Pf2p612g==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1683726550;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=46hdFH2kJFRmyUO0PSjD3oY8ttFy+HiOOIKvoMeo0qQ=;
        b=dbvhjKMWRTUMnTMrvhPi+OykNqN08XBvfll58Dj+MgcFhNU8rDWJHI8lkDMNxH99iTrKzY
        Ultb1PgCqL1kM/BQ==
From:   "tip-bot2 for Suren Baghdasaryan" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: sched/core] psi: remove 500ms min window size limitation for triggers
Cc:     Sudarshan Rajagopalan <quic_sudaraja@quicinc.com>,
        Suren Baghdasaryan <surenb@google.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Michal Hocko <mhocko@suse.com>,
        Johannes Weiner <hannes@cmpxchg.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
MIME-Version: 1.0
Message-ID: <168372654968.404.2819009900502474821.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the sched/core branch of tip:

Commit-ID:     519fabc7aaba3f0847cf37d5f9a5740c370eb777
Gitweb:        https://git.kernel.org/tip/519fabc7aaba3f0847cf37d5f9a5740c370eb777
Author:        Suren Baghdasaryan <surenb@google.com>
AuthorDate:    Thu, 02 Mar 2023 17:13:46 -08:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Mon, 08 May 2023 10:58:38 +02:00

psi: remove 500ms min window size limitation for triggers

Current 500ms min window size for psi triggers limits polling interval
to 50ms to prevent polling threads from using too much cpu bandwidth by
polling too frequently. However the number of cgroups with triggers is
unlimited, so this protection can be defeated by creating multiple
cgroups with psi triggers (triggers in each cgroup are served by a single
"psimon" kernel thread).
Instead of limiting min polling period, which also limits the latency of
psi events, it's better to limit psi trigger creation to authorized users
only, like we do for system-wide psi triggers (/proc/pressure/* files can
be written only by processes with CAP_SYS_RESOURCE capability). This also
makes access rules for cgroup psi files consistent with system-wide ones.
Add a CAP_SYS_RESOURCE capability check for cgroup psi file writers and
remove the psi window min size limitation.

Suggested-by: Sudarshan Rajagopalan <quic_sudaraja@quicinc.com>
Signed-off-by: Suren Baghdasaryan <surenb@google.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Acked-by: Michal Hocko <mhocko@suse.com>
Acked-by: Johannes Weiner <hannes@cmpxchg.org>
Link: https://lore.kernel.org/all/cover.1676067791.git.quic_sudaraja@quicinc.com/
---
 kernel/cgroup/cgroup.c | 12 ++++++++++++
 kernel/sched/psi.c     |  4 +---
 2 files changed, 13 insertions(+), 3 deletions(-)

diff --git a/kernel/cgroup/cgroup.c b/kernel/cgroup/cgroup.c
index 625d748..b26ae20 100644
--- a/kernel/cgroup/cgroup.c
+++ b/kernel/cgroup/cgroup.c
@@ -3877,6 +3877,14 @@ static __poll_t cgroup_pressure_poll(struct kernfs_open_file *of,
 	return psi_trigger_poll(&ctx->psi.trigger, of->file, pt);
 }
 
+static int cgroup_pressure_open(struct kernfs_open_file *of)
+{
+	if (of->file->f_mode & FMODE_WRITE && !capable(CAP_SYS_RESOURCE))
+		return -EPERM;
+
+	return 0;
+}
+
 static void cgroup_pressure_release(struct kernfs_open_file *of)
 {
 	struct cgroup_file_ctx *ctx = of->priv;
@@ -5276,6 +5284,7 @@ static struct cftype cgroup_psi_files[] = {
 	{
 		.name = "io.pressure",
 		.file_offset = offsetof(struct cgroup, psi_files[PSI_IO]),
+		.open = cgroup_pressure_open,
 		.seq_show = cgroup_io_pressure_show,
 		.write = cgroup_io_pressure_write,
 		.poll = cgroup_pressure_poll,
@@ -5284,6 +5293,7 @@ static struct cftype cgroup_psi_files[] = {
 	{
 		.name = "memory.pressure",
 		.file_offset = offsetof(struct cgroup, psi_files[PSI_MEM]),
+		.open = cgroup_pressure_open,
 		.seq_show = cgroup_memory_pressure_show,
 		.write = cgroup_memory_pressure_write,
 		.poll = cgroup_pressure_poll,
@@ -5292,6 +5302,7 @@ static struct cftype cgroup_psi_files[] = {
 	{
 		.name = "cpu.pressure",
 		.file_offset = offsetof(struct cgroup, psi_files[PSI_CPU]),
+		.open = cgroup_pressure_open,
 		.seq_show = cgroup_cpu_pressure_show,
 		.write = cgroup_cpu_pressure_write,
 		.poll = cgroup_pressure_poll,
@@ -5301,6 +5312,7 @@ static struct cftype cgroup_psi_files[] = {
 	{
 		.name = "irq.pressure",
 		.file_offset = offsetof(struct cgroup, psi_files[PSI_IRQ]),
+		.open = cgroup_pressure_open,
 		.seq_show = cgroup_irq_pressure_show,
 		.write = cgroup_irq_pressure_write,
 		.poll = cgroup_pressure_poll,
diff --git a/kernel/sched/psi.c b/kernel/sched/psi.c
index e072f6b..b49af59 100644
--- a/kernel/sched/psi.c
+++ b/kernel/sched/psi.c
@@ -160,7 +160,6 @@ __setup("psi=", setup_psi);
 #define EXP_300s	2034		/* 1/exp(2s/300s) */
 
 /* PSI trigger definitions */
-#define WINDOW_MIN_US 500000	/* Min window size is 500ms */
 #define WINDOW_MAX_US 10000000	/* Max window size is 10s */
 #define UPDATES_PER_WINDOW 10	/* 10 updates per window */
 
@@ -1305,8 +1304,7 @@ struct psi_trigger *psi_trigger_create(struct psi_group *group,
 	if (state >= PSI_NONIDLE)
 		return ERR_PTR(-EINVAL);
 
-	if (window_us < WINDOW_MIN_US ||
-		window_us > WINDOW_MAX_US)
+	if (window_us == 0 || window_us > WINDOW_MAX_US)
 		return ERR_PTR(-EINVAL);
 
 	/*
