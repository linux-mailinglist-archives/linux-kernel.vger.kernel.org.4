Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8AE82717F7D
	for <lists+linux-kernel@lfdr.de>; Wed, 31 May 2023 14:05:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235825AbjEaMFP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 May 2023 08:05:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55062 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235811AbjEaMEy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 May 2023 08:04:54 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1517B10E;
        Wed, 31 May 2023 05:04:53 -0700 (PDT)
Date:   Wed, 31 May 2023 12:04:50 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1685534691;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=jAHu/ZeCNq2zA/+Hvbn6tZi8UxHRbFPIWy674Hkm38E=;
        b=VMC5CcQ3Jvl9m9h1W58szK4kJXB2WowZ1bghSlopHsV5Hs6WF/MOsmQODgsmg1JNTXdv+u
        mUG09EoZ9Yl91d5yZPnId1F4AY59sThwc0OyOqwSdvahVbHEOM7boBJi1GERCOmlElM7Ix
        YQuygTMB0fzsCe75wge6xdNDnEnYb6OzDWG41COlOg7KtpNFWLQXZIwWhpbkNrvOZgLchP
        OcMd5Edzl4viEBWgjoeSPiS8yG1uCMDkEADEQcCESxNDs97KE1Mg2DgCxzWw6hgLSfeu/2
        8AO0hSqxENCYhl4yXXpiInliexz/se8GlUhxfBnZQJ3RkMiE7yxNjsmye+N5Dw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1685534691;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=jAHu/ZeCNq2zA/+Hvbn6tZi8UxHRbFPIWy674Hkm38E=;
        b=7itMFfwrSUbIfyZdPqDaFOSYyOpvi73hTyuDwDIRcqj/aAYEQRjwqOnibtro1tP/jgDt5a
        9ZCQ2y1iL+qOBUAg==
From:   "tip-bot2 for Arnd Bergmann" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: sched/core] sched: Hide unused sched_update_scaling()
Cc:     Arnd Bergmann <arnd@arndb.de>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Vincent Guittot <vincent.guittot@linaro.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20230522195021.3456768-2-arnd@kernel.org>
References: <20230522195021.3456768-2-arnd@kernel.org>
MIME-Version: 1.0
Message-ID: <168553469099.404.5063205940562431875.tip-bot2@tip-bot2>
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

Commit-ID:     d55ebae3f3122b07689cc4c34043114e09ce904c
Gitweb:        https://git.kernel.org/tip/d55ebae3f3122b07689cc4c34043114e09ce904c
Author:        Arnd Bergmann <arnd@arndb.de>
AuthorDate:    Mon, 22 May 2023 21:50:17 +02:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Tue, 30 May 2023 22:46:24 +02:00

sched: Hide unused sched_update_scaling()

This function is only used when CONFIG_SMP is enabled, without that there
is no caller and no prototype:

kernel/sched/fair.c:688:5: error: no previous prototype for 'sched_update_scaling' [-Werror=missing-prototypes

Hide the definition in the same #ifdef check as the declaration.

Fixes: 8a99b6833c88 ("sched: Move SCHED_DEBUG sysctl to debugfs")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Reviewed-by: Vincent Guittot <vincent.guittot@linaro.org>
Link: https://lore.kernel.org/r/20230522195021.3456768-2-arnd@kernel.org
---
 kernel/sched/fair.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 48b6f0c..2c1b345 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -684,7 +684,7 @@ struct sched_entity *__pick_last_entity(struct cfs_rq *cfs_rq)
 /**************************************************************
  * Scheduling class statistics methods:
  */
-
+#ifdef CONFIG_SMP
 int sched_update_scaling(void)
 {
 	unsigned int factor = get_update_sysctl_factor();
@@ -702,6 +702,7 @@ int sched_update_scaling(void)
 	return 0;
 }
 #endif
+#endif
 
 /*
  * delta /= w
