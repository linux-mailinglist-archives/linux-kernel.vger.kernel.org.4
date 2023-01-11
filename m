Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B962D6657D6
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Jan 2023 10:43:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232046AbjAKJmc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Jan 2023 04:42:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43328 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238622AbjAKJls (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Jan 2023 04:41:48 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 43B3065AA;
        Wed, 11 Jan 2023 01:38:17 -0800 (PST)
Date:   Wed, 11 Jan 2023 09:38:15 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1673429895;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=kehMZIHPNQwe/rgFXgkipzv6RmLxifL8oeDAjS4KObg=;
        b=umNlVrc1r7BR6PRC2/CPs7WH0THb9RSlmTdDDfbkwTSkmpObdoS0LKwHVtY2SionEIntmY
        aIWLvL705k25r0PoHDpcyTAkfpo2qR6Zoj2zs+Kjt9YuZ+v2RK1Mzn2COf1iS5lw+95ngC
        FA+X1LLaRBCz+2NkCWXar/lOPicRy992MwfGm9M8NCAcdgzl0L058Ps/OrGCRBy7h0Y3Jk
        Njm93lKmypTcuYKMOLPLS0ta6Yz1Cjm6yAjD9lPzRpp/tYCi9JbgWfFnZGCsMkNqnBdaEA
        AJRSiTPaJNAlqFa4EO4D+ZxTFZCmD1A+s1Kx09URGccPJlb/H1RGFNuDYnBAIg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1673429895;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=kehMZIHPNQwe/rgFXgkipzv6RmLxifL8oeDAjS4KObg=;
        b=x5/l5UspoS/rwDESewhE/c2mxgUE01eZxNJEWqo/VdHvqluPB1Re9TVxNh/ojDpy47Nzty
        c1jYV86gY2guBkCA==
From:   "tip-bot2 for Ingo Molnar" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: sched/core] sched/cputime: Fix IA64 build error of missing
 arch_vtime_task_switch() prototype
Cc:     kernel test robot <lkp@intel.com>, Ingo Molnar <mingo@kernel.org>,
        linux-kernel@vger.kernel.org, Nicholas Piggin <npiggin@gmail.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Alexander Gordeev <agordeev@linux.ibm.com>, x86@kernel.org
MIME-Version: 1.0
Message-ID: <167342989503.4906.9427028157205316404.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the sched/core branch of tip:

Commit-ID:     cd9f5c3d3096e26fa128ae747f66383002001398
Gitweb:        https://git.kernel.org/tip/cd9f5c3d3096e26fa128ae747f66383002001398
Author:        Ingo Molnar <mingo@kernel.org>
AuthorDate:    Wed, 11 Jan 2023 10:25:34 +01:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Wed, 11 Jan 2023 10:31:57 +01:00

sched/cputime: Fix IA64 build error of missing arch_vtime_task_switch() prototype

The following commit:

  c89970202a11 ("cputime: remove cputime_to_nsecs fallback")

Removed an <asm/cputime.h> inclusion from <linux/sched/cputime.h>, but this
broke the IA64 build:

    arch/ia64/kernel/time.c:110:6: warning: no previous prototype for 'arch_vtime_task_switch' [-Wmissing-prototypes]

Add in the missing <asm/cputime.h> header to fix it.

Fixes: c89970202a11 ("cputime: remove cputime_to_nsecs fallback")
Reported-by: kernel test robot <lkp@intel.com>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Cc: linux-kernel@vger.kernel.org
Cc: Nicholas Piggin <npiggin@gmail.com>
Cc: Peter Zijlstra (Intel) <peterz@infradead.org>
Cc: Alexander Gordeev <agordeev@linux.ibm.com>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
---
 arch/ia64/kernel/time.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/ia64/kernel/time.c b/arch/ia64/kernel/time.c
index fa9c0ab..83ef044 100644
--- a/arch/ia64/kernel/time.c
+++ b/arch/ia64/kernel/time.c
@@ -25,6 +25,7 @@
 #include <linux/platform_device.h>
 #include <linux/sched/cputime.h>
 
+#include <asm/cputime.h>
 #include <asm/delay.h>
 #include <asm/efi.h>
 #include <asm/hw_irq.h>
