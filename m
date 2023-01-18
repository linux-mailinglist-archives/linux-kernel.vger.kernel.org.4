Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E1FA3671BAE
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Jan 2023 13:16:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229925AbjARMQb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Jan 2023 07:16:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47396 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230169AbjARMP6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Jan 2023 07:15:58 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 255AE84560;
        Wed, 18 Jan 2023 03:37:32 -0800 (PST)
Date:   Wed, 18 Jan 2023 11:37:28 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1674041849;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=63lJr1yEgRpYUaExnMPTyCaaSKYJEew65NbcNPhxgtk=;
        b=F5nuC2+jHSIaP1Ua4kXBqc1ZzNBalFODRlkbkW4PwQMLX9RPxfG/6nuYXkufAbIGBMYMVl
        qB0QyarO7yC+8fdCIQa1kjUSI/97sI6IclzKl/72kDkBfJoDri+S2gQvdDdYoSspnzNmuF
        ex/08fys6mywG+WVbi9qSpUJyiZ2pkvHbI7b2brTXOYSfAP48SsLgBWkuxmRnmCZI1Iz5A
        wKcC1bw5T/mHzk+v00mi/plLvKdvYKFMOXA499p2SAtpJiS6p5Yzfzc3EOWzVUqnUDjEaI
        nhOJHMq7ewqXCrwsL44yi1AZVYJuQYky+els9i4H4twA+AVwpLeDMzcAI809NA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1674041849;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=63lJr1yEgRpYUaExnMPTyCaaSKYJEew65NbcNPhxgtk=;
        b=uZlHXRxg6vFEVegnEnFWumBk8tAf5InAgmzxhIVeaAIiFnkGMC2+6sqNsPHg7W3rL2PbtW
        MsANffn9Bcr2MyAg==
From:   "tip-bot2 for Ingo Molnar" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: irq/core] genirq/affinity: Only build SMP-only helper functions
 on SMP kernels
Cc:     Ming Lei <ming.lei@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@kernel.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org, maz@kernel.org
In-Reply-To: <20221227022905.352674-6-ming.lei@redhat.com>
References: <20221227022905.352674-6-ming.lei@redhat.com>
MIME-Version: 1.0
Message-ID: <167404184855.4906.755799913850425834.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the irq/core branch of tip:

Commit-ID:     188a569658584e93930ab60334c5a1079c0330d8
Gitweb:        https://git.kernel.org/tip/188a569658584e93930ab60334c5a1079c0=
330d8
Author:        Ingo Molnar <mingo@kernel.org>
AuthorDate:    Wed, 18 Jan 2023 12:14:01 +01:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Wed, 18 Jan 2023 12:16:47 +01:00

genirq/affinity: Only build SMP-only helper functions on SMP kernels

allnoconfig grew these new build warnings in lib/group_cpus.c:

  lib/group_cpus.c:247:12: warning: =E2=80=98__group_cpus_evenly=E2=80=99 def=
ined but not used [-Wunused-function]
  lib/group_cpus.c:75:13: warning: =E2=80=98build_node_to_cpumask=E2=80=99 de=
fined but not used [-Wunused-function]
  lib/group_cpus.c:66:13: warning: =E2=80=98free_node_to_cpumask=E2=80=99 def=
ined but not used [-Wunused-function]
  lib/group_cpus.c:43:23: warning: =E2=80=98alloc_node_to_cpumask=E2=80=99 de=
fined but not used [-Wunused-function]

Widen the #ifdef CONFIG_SMP block to not expose unused helpers on
non-SMP builds.

Also annotate the preprocessor branches for better readability.

Fixes: f7b3ea8cf72f ("genirq/affinity: Move group_cpus_evenly() into lib/")
Cc: Ming Lei <ming.lei@redhat.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Link: https://lore.kernel.org/r/20221227022905.352674-6-ming.lei@redhat.com
Signed-off-by: Ingo Molnar <mingo@kernel.org>
---
 lib/group_cpus.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/lib/group_cpus.c b/lib/group_cpus.c
index 99f08c6..9c837a3 100644
--- a/lib/group_cpus.c
+++ b/lib/group_cpus.c
@@ -9,6 +9,8 @@
 #include <linux/sort.h>
 #include <linux/group_cpus.h>
=20
+#ifdef CONFIG_SMP
+
 static void grp_spread_init_one(struct cpumask *irqmsk, struct cpumask *nmsk,
 				unsigned int cpus_per_grp)
 {
@@ -327,7 +329,6 @@ static int __group_cpus_evenly(unsigned int startgrp, uns=
igned int numgrps,
 	return done;
 }
=20
-#ifdef CONFIG_SMP
 /**
  * group_cpus_evenly - Group all CPUs evenly per NUMA/CPU locality
  * @numgrps: number of groups
@@ -412,7 +413,7 @@ struct cpumask *group_cpus_evenly(unsigned int numgrps)
 	}
 	return masks;
 }
-#else
+#else /* CONFIG_SMP */
 struct cpumask *group_cpus_evenly(unsigned int numgrps)
 {
 	struct cpumask *masks =3D kcalloc(numgrps, sizeof(*masks), GFP_KERNEL);
@@ -424,4 +425,4 @@ struct cpumask *group_cpus_evenly(unsigned int numgrps)
 	cpumask_copy(&masks[0], cpu_possible_mask);
 	return masks;
 }
-#endif
+#endif /* CONFIG_SMP */
