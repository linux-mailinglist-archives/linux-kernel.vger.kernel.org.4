Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B1DA96FDF0F
	for <lists+linux-kernel@lfdr.de>; Wed, 10 May 2023 15:49:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237248AbjEJNt2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 May 2023 09:49:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51950 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237262AbjEJNtS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 May 2023 09:49:18 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 124A426A3;
        Wed, 10 May 2023 06:49:11 -0700 (PDT)
Date:   Wed, 10 May 2023 13:49:09 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1683726549;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=uaBMDeAOqEtMsjfmbiAxy4lKR2OqnajE5Ae9sex7JRk=;
        b=NRoFR3Yjj9esQtEabWcLvhUJZHrKbO9YmVM/diNCpLTYRJElj0/0Gk7B90WPQADIrhBKEY
        ZgpjlycgKVnQTDjqG5K+OguquoDdFRXMWj6dfqxItgdfIweYnujfwDlhWvKebAHjoStBbP
        QM+udsBTg9pWG1KlmHmwdO6Cc4RGRdKNJXaWHlhVFZW39BO2r6ziD3zwpso9BwVTE/Z0V1
        cnJbk3k6JZ/CJUXVLbspGa/jdWschofy0K6q/fm0Xkr0bpE8k5zz6eHywu84FM24Pq6U57
        fC2jB88t7Fc2R63ysnIziEI7RjAvUc2XC5VyOVZJPftNJ1O9KJoKBiXfQvFGlQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1683726549;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=uaBMDeAOqEtMsjfmbiAxy4lKR2OqnajE5Ae9sex7JRk=;
        b=WG5b8F82wbUxxfC4aAd8Rhw3yQH2ruZDxOyjyPmCQaulULYMVFpIC2RPtj8UTYoBr+2TQ+
        u6WfsURrhmR1ElCg==
From:   "tip-bot2 for Tim C Chen" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: sched/core] sched/topology: Propagate SMT flags when removing
 degenerate domain
Cc:     Tim Chen <tim.c.chen@linux.intel.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Ricardo Neri <ricardo.neri-calderon@linux.intel.com>,
        x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: =?utf-8?q?=3C73cf0959eafa53c02e7ef6bf805d751d9190e55d=2E16831?=
 =?utf-8?q?56492=2Egit=2Etim=2Ec=2Echen=40linux=2Eintel=2Ecom=3E?=
References: =?utf-8?q?=3C73cf0959eafa53c02e7ef6bf805d751d9190e55d=2E168315?=
 =?utf-8?q?6492=2Egit=2Etim=2Ec=2Echen=40linux=2Eintel=2Ecom=3E?=
MIME-Version: 1.0
Message-ID: <168372654916.404.6677242284447941021.tip-bot2@tip-bot2>
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

Commit-ID:     bf2dc42d6beb890c995b8b09f881ef1b37259107
Gitweb:        https://git.kernel.org/tip/bf2dc42d6beb890c995b8b09f881ef1b37259107
Author:        Tim C Chen <tim.c.chen@linux.intel.com>
AuthorDate:    Thu, 04 May 2023 09:09:51 -07:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Mon, 08 May 2023 10:58:39 +02:00

sched/topology: Propagate SMT flags when removing degenerate domain

When a degenerate cluster domain for core with SMT CPUs is removed,
the SD_SHARE_CPUCAPACITY flag in the local child sched group was not
propagated to the new parent.  We need this flag to properly determine
whether the local sched group is SMT.  Set the flag in the local
child sched group of the new parent sched domain.

Signed-off-by: Tim Chen <tim.c.chen@linux.intel.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Reviewed-by: Ricardo Neri <ricardo.neri-calderon@linux.intel.com>
Link: https://lkml.kernel.org/r/73cf0959eafa53c02e7ef6bf805d751d9190e55d.1683156492.git.tim.c.chen@linux.intel.com
---
 kernel/sched/topology.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/kernel/sched/topology.c b/kernel/sched/topology.c
index 6682535..ca44722 100644
--- a/kernel/sched/topology.c
+++ b/kernel/sched/topology.c
@@ -719,8 +719,13 @@ cpu_attach_domain(struct sched_domain *sd, struct root_domain *rd, int cpu)
 
 		if (sd_parent_degenerate(tmp, parent)) {
 			tmp->parent = parent->parent;
-			if (parent->parent)
+
+			if (parent->parent) {
 				parent->parent->child = tmp;
+				if (tmp->flags & SD_SHARE_CPUCAPACITY)
+					parent->parent->groups->flags |= SD_SHARE_CPUCAPACITY;
+			}
+
 			/*
 			 * Transfer SD_PREFER_SIBLING down in case of a
 			 * degenerate parent; the spans match for this
