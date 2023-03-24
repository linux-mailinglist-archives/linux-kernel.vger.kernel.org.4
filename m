Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 707FD6C7474
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Mar 2023 01:20:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231466AbjCXAUH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Mar 2023 20:20:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57834 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231206AbjCXATs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Mar 2023 20:19:48 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1AC922DE65;
        Thu, 23 Mar 2023 17:19:43 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 7AE6D62929;
        Fri, 24 Mar 2023 00:19:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7F2EDC433AC;
        Fri, 24 Mar 2023 00:19:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1679617181;
        bh=l0KonFEulcToOd8dBD5wwjfw4yz2wDL/Nm7i9FpxVDI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=g2MtUvviljmMLyxWmLKa7HWhACub3Fq+C+FCDyUL3exH403jVAko+RiNnT+MSoeSA
         hdgLtw8nTREUcp/jiVtKghd59cNElVIEuheqai2P/89fE+MKi/jkuRvRNTtvdc5uVG
         EDU1VrQ0WwAP47aALarNeAxnFSP3hb1IF5nlIC9kCcMyK62oYpo4Q5prVnJj/PXwqK
         jRxnd1oe2HX1jBe0UpNZlPWMDKnpvXum11E/j0yWOQTTCSSVeuko8ZzHpfuVuZItWM
         yhdOAzVsBDz34dPt18MRUFcppImxkTd2xcliH7x8Aum+dx4tAMSJiVmCybbkW1FtV0
         A5jZBKkwGbV/w==
Received: by paulmck-ThinkPad-P72.home (Postfix, from userid 1000)
        id B311615403A5; Thu, 23 Mar 2023 17:19:40 -0700 (PDT)
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, kernel-team@meta.com,
        rostedt@goodmis.org, hch@lst.de,
        "Paul E. McKenney" <paulmck@kernel.org>
Subject: [PATCH RFC rcu 12/19] srcu: Move ->sda_is_static from srcu_struct to srcu_usage
Date:   Thu, 23 Mar 2023 17:19:31 -0700
Message-Id: <20230324001938.3443499-12-paulmck@kernel.org>
X-Mailer: git-send-email 2.40.0.rc2
In-Reply-To: <3db82572-f156-4a5d-b711-841aa28bd996@paulmck-laptop>
References: <3db82572-f156-4a5d-b711-841aa28bd996@paulmck-laptop>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-5.2 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This commit moves the ->sda_is_static field from the srcu_struct structure
to the srcu_usage structure to reduce the size of the former in order
to improve cache locality.

Suggested-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 include/linux/srcutree.h | 2 +-
 kernel/rcu/srcutree.c    | 6 +++---
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/include/linux/srcutree.h b/include/linux/srcutree.h
index 82d07466da93..ca48b97d9f3b 100644
--- a/include/linux/srcutree.h
+++ b/include/linux/srcutree.h
@@ -76,6 +76,7 @@ struct srcu_usage {
 	unsigned long srcu_size_jiffies;	/* Current contention-measurement interval. */
 	unsigned long srcu_n_lock_retries;	/* Contention events in current interval. */
 	unsigned long srcu_n_exp_nodelay;	/* # expedited no-delays in current GP phase. */
+	bool sda_is_static;			/* May ->sda be passed to free_percpu()? */
 };
 
 /*
@@ -84,7 +85,6 @@ struct srcu_usage {
 struct srcu_struct {
 	unsigned int srcu_idx;			/* Current rdr array element. */
 	struct srcu_data __percpu *sda;		/* Per-CPU srcu_data array. */
-	bool sda_is_static;			/* May ->sda be passed to free_percpu()? */
 	unsigned long srcu_barrier_seq;		/* srcu_barrier seq #. */
 	struct mutex srcu_barrier_mutex;	/* Serialize barrier ops. */
 	struct completion srcu_barrier_completion;
diff --git a/kernel/rcu/srcutree.c b/kernel/rcu/srcutree.c
index 3f389b3a25aa..7c192f7fb559 100644
--- a/kernel/rcu/srcutree.c
+++ b/kernel/rcu/srcutree.c
@@ -252,7 +252,7 @@ static int init_srcu_struct_fields(struct srcu_struct *ssp, bool is_static)
 	mutex_init(&ssp->srcu_barrier_mutex);
 	atomic_set(&ssp->srcu_barrier_cpu_cnt, 0);
 	INIT_DELAYED_WORK(&ssp->work, process_srcu);
-	ssp->sda_is_static = is_static;
+	ssp->srcu_sup->sda_is_static = is_static;
 	if (!is_static)
 		ssp->sda = alloc_percpu(struct srcu_data);
 	if (!ssp->sda) {
@@ -265,7 +265,7 @@ static int init_srcu_struct_fields(struct srcu_struct *ssp, bool is_static)
 	ssp->srcu_sup->srcu_last_gp_end = ktime_get_mono_fast_ns();
 	if (READ_ONCE(ssp->srcu_sup->srcu_size_state) == SRCU_SIZE_SMALL && SRCU_SIZING_IS_INIT()) {
 		if (!init_srcu_struct_nodes(ssp, GFP_ATOMIC)) {
-			if (!ssp->sda_is_static) {
+			if (!ssp->srcu_sup->sda_is_static) {
 				free_percpu(ssp->sda);
 				ssp->sda = NULL;
 				kfree(ssp->srcu_sup);
@@ -667,7 +667,7 @@ void cleanup_srcu_struct(struct srcu_struct *ssp)
 	kfree(ssp->srcu_sup->node);
 	ssp->srcu_sup->node = NULL;
 	ssp->srcu_sup->srcu_size_state = SRCU_SIZE_SMALL;
-	if (!ssp->sda_is_static) {
+	if (!ssp->srcu_sup->sda_is_static) {
 		free_percpu(ssp->sda);
 		ssp->sda = NULL;
 		kfree(ssp->srcu_sup);
-- 
2.40.0.rc2

