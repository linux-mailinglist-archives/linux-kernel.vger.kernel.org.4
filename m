Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D821B733480
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Jun 2023 17:16:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345908AbjFPPQt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Jun 2023 11:16:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40166 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231695AbjFPPQp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Jun 2023 11:16:45 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC24C30FF;
        Fri, 16 Jun 2023 08:16:43 -0700 (PDT)
Date:   Fri, 16 Jun 2023 15:16:42 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1686928602;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=f91D0xmWauZGJUDw/aEInTSPCvvm5F7WQVK8OGO4AMU=;
        b=mWsjzbesIw6ijtKIY+z03FxLkxjejwaflhIsWVUPdCPgpHor+hEZQG33H1ejDAXUfBVgPI
        39crKvqzEVEn4lfSTGYyXEa2HL2R23GkOP2Ox7QkeEZGpgg836bDjomwn7t0JoSfy5DfTR
        nVc17Nzou5b6SVp/k1w/gjKMs6w+B4zb1ua6pHQiLb1hE8CxgnjJ1zPK8xKyH5NV6cLX0m
        dejk1qOkJ+95OhVClNmNFqr2dFfB4YfJ/0vS09BV0lQh9g/RhHGEL3Ja8uKlm/o1keEZem
        FoDqris0O3wRt/Ce3E4LMKkU1oSXQi0ocUjo9eRdPLiV1A8SbGr1znUrKOjVyw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1686928602;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=f91D0xmWauZGJUDw/aEInTSPCvvm5F7WQVK8OGO4AMU=;
        b=HR9NDpAzdQZrQPDwSjLulFytNTUq+yszAXG6CRh7IcEcLDVCnjtYzAxJNCK6QfvdWFtcpV
        GH1taWE11g0+utDg==
From:   "tip-bot2 for Miaohe Lin" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: sched/core] sched/topology: Mark set_sched_topology() __init
Cc:     Miaohe Lin <linmiaohe@huawei.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Valentin Schneider <vschneid@redhat.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20230603073645.1173332-1-linmiaohe@huawei.com>
References: <20230603073645.1173332-1-linmiaohe@huawei.com>
MIME-Version: 1.0
Message-ID: <168692860207.404.4144241334175555026.tip-bot2@tip-bot2>
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

Commit-ID:     0cce0fde499a92c726cd2e24f7763644f7c9f971
Gitweb:        https://git.kernel.org/tip/0cce0fde499a92c726cd2e24f7763644f7c9f971
Author:        Miaohe Lin <linmiaohe@huawei.com>
AuthorDate:    Sat, 03 Jun 2023 15:36:45 +08:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Fri, 16 Jun 2023 17:08:01 +02:00

sched/topology: Mark set_sched_topology() __init

All callers of set_sched_topology() are within __init section. Mark
it __init too.

Signed-off-by: Miaohe Lin <linmiaohe@huawei.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Reviewed-by: Valentin Schneider <vschneid@redhat.com>
Link: https://lore.kernel.org/r/20230603073645.1173332-1-linmiaohe@huawei.com
---
 include/linux/sched/topology.h | 2 +-
 kernel/sched/topology.c        | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/include/linux/sched/topology.h b/include/linux/sched/topology.h
index 816df6c..67b573d 100644
--- a/include/linux/sched/topology.h
+++ b/include/linux/sched/topology.h
@@ -203,7 +203,7 @@ struct sched_domain_topology_level {
 #endif
 };
 
-extern void set_sched_topology(struct sched_domain_topology_level *tl);
+extern void __init set_sched_topology(struct sched_domain_topology_level *tl);
 
 #ifdef CONFIG_SCHED_DEBUG
 # define SD_INIT_NAME(type)		.name = #type
diff --git a/kernel/sched/topology.c b/kernel/sched/topology.c
index ca44722..cb92dc5 100644
--- a/kernel/sched/topology.c
+++ b/kernel/sched/topology.c
@@ -1681,7 +1681,7 @@ static struct sched_domain_topology_level *sched_domain_topology_saved;
 #define for_each_sd_topology(tl)			\
 	for (tl = sched_domain_topology; tl->mask; tl++)
 
-void set_sched_topology(struct sched_domain_topology_level *tl)
+void __init set_sched_topology(struct sched_domain_topology_level *tl)
 {
 	if (WARN_ON_ONCE(sched_smp_initialized))
 		return;
