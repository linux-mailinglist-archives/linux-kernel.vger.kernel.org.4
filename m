Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EFEE8660E1E
	for <lists+linux-kernel@lfdr.de>; Sat,  7 Jan 2023 11:53:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236987AbjAGKxc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 7 Jan 2023 05:53:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48048 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231422AbjAGKxF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 7 Jan 2023 05:53:05 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 450371ADA1;
        Sat,  7 Jan 2023 02:53:02 -0800 (PST)
Date:   Sat, 07 Jan 2023 10:52:59 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1673088780;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=4CGgJ1rYxp5gWV1k3jmjmtxudTH2vt/hm7sMo8ELBZI=;
        b=S1mEYF1+Cc1gtCWbsWD0CLtUflAUg0XeWkVAVhRYH2AZKYPaRIVLhfo+3ZL1yJ2tEXx/ys
        wFDaDHo7APO+7S+NGV05D4tmitbRB0542ee11DdikRt3oyUv2RYVVDl6me2KKYyNy9mTBK
        xdZkOX6/QUeG59w85ff9zOsf7ZuEGY2h5y4BxOzC+wiaj16NRRhz2tzDkuPHUJzaXTgccW
        juTodAuBvAeRfzpy/ABXvzy2ko6YdehFpauvwu0SXU+8iEaRglhZGkbJBGvclAQptio1I+
        PHVXMrHgd4oW4XZkIJQLN2rfS7CWHHsmJzjy99Gb9i3TuWiA+JgkUROmIV5tmw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1673088780;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=4CGgJ1rYxp5gWV1k3jmjmtxudTH2vt/hm7sMo8ELBZI=;
        b=ivZxHYWXoydUZaeybcIpUYLB327EJF5rnU3h1oWSJrfWpZvioYPx/MJ0gqoH1sEXZnxsgx
        0uSZTCRRk2hAVEBQ==
From:   "tip-bot2 for Michal Clapinski" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: sched/core] sched/membarrier: Introduce
 MEMBARRIER_CMD_GET_REGISTRATIONS
Cc:     Michal Clapinski <mclapinski@google.com>,
        Ingo Molnar <mingo@kernel.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        "Paul E. McKenney" <paulmck@kernel.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20221207164338.1535591-2-mclapinski@google.com>
References: <20221207164338.1535591-2-mclapinski@google.com>
MIME-Version: 1.0
Message-ID: <167308877997.4906.7970604659572963817.tip-bot2@tip-bot2>
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

Commit-ID:     544a4f2ecd45f9d6ed78d207583f39130ad40349
Gitweb:        https://git.kernel.org/tip/544a4f2ecd45f9d6ed78d207583f39130ad40349
Author:        Michal Clapinski <mclapinski@google.com>
AuthorDate:    Wed, 07 Dec 2022 17:43:37 +01:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Sat, 07 Jan 2023 11:29:29 +01:00

sched/membarrier: Introduce MEMBARRIER_CMD_GET_REGISTRATIONS

Provide a method to query previously issued registrations.

Signed-off-by: Michal Clapinski <mclapinski@google.com>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Acked-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Acked-by: Paul E. McKenney <paulmck@kernel.org>
Link: https://lore.kernel.org/r/20221207164338.1535591-2-mclapinski@google.com
---
 include/uapi/linux/membarrier.h |  4 +++-
 kernel/sched/membarrier.c       | 39 +++++++++++++++++++++++++++++++-
 2 files changed, 42 insertions(+), 1 deletion(-)

diff --git a/include/uapi/linux/membarrier.h b/include/uapi/linux/membarrier.h
index 7376058..5f3ad6d 100644
--- a/include/uapi/linux/membarrier.h
+++ b/include/uapi/linux/membarrier.h
@@ -137,6 +137,9 @@
  * @MEMBARRIER_CMD_SHARED:
  *                          Alias to MEMBARRIER_CMD_GLOBAL. Provided for
  *                          header backward compatibility.
+ * @MEMBARRIER_CMD_GET_REGISTRATIONS:
+ *                          Returns a bitmask of previously issued
+ *                          registration commands.
  *
  * Command to be passed to the membarrier system call. The commands need to
  * be a single bit each, except for MEMBARRIER_CMD_QUERY which is assigned to
@@ -153,6 +156,7 @@ enum membarrier_cmd {
 	MEMBARRIER_CMD_REGISTER_PRIVATE_EXPEDITED_SYNC_CORE	= (1 << 6),
 	MEMBARRIER_CMD_PRIVATE_EXPEDITED_RSEQ			= (1 << 7),
 	MEMBARRIER_CMD_REGISTER_PRIVATE_EXPEDITED_RSEQ		= (1 << 8),
+	MEMBARRIER_CMD_GET_REGISTRATIONS			= (1 << 9),
 
 	/* Alias for header backward compatibility. */
 	MEMBARRIER_CMD_SHARED			= MEMBARRIER_CMD_GLOBAL,
diff --git a/kernel/sched/membarrier.c b/kernel/sched/membarrier.c
index 0c5be7e..2ad881d 100644
--- a/kernel/sched/membarrier.c
+++ b/kernel/sched/membarrier.c
@@ -159,7 +159,8 @@
 	| MEMBARRIER_CMD_PRIVATE_EXPEDITED				\
 	| MEMBARRIER_CMD_REGISTER_PRIVATE_EXPEDITED			\
 	| MEMBARRIER_PRIVATE_EXPEDITED_SYNC_CORE_BITMASK		\
-	| MEMBARRIER_PRIVATE_EXPEDITED_RSEQ_BITMASK)
+	| MEMBARRIER_PRIVATE_EXPEDITED_RSEQ_BITMASK			\
+	| MEMBARRIER_CMD_GET_REGISTRATIONS)
 
 static void ipi_mb(void *info)
 {
@@ -540,6 +541,40 @@ static int membarrier_register_private_expedited(int flags)
 	return 0;
 }
 
+static int membarrier_get_registrations(void)
+{
+	struct task_struct *p = current;
+	struct mm_struct *mm = p->mm;
+	int registrations_mask = 0, membarrier_state, i;
+	static const int states[] = {
+		MEMBARRIER_STATE_GLOBAL_EXPEDITED |
+			MEMBARRIER_STATE_GLOBAL_EXPEDITED_READY,
+		MEMBARRIER_STATE_PRIVATE_EXPEDITED |
+			MEMBARRIER_STATE_PRIVATE_EXPEDITED_READY,
+		MEMBARRIER_STATE_PRIVATE_EXPEDITED_SYNC_CORE |
+			MEMBARRIER_STATE_PRIVATE_EXPEDITED_SYNC_CORE_READY,
+		MEMBARRIER_STATE_PRIVATE_EXPEDITED_RSEQ |
+			MEMBARRIER_STATE_PRIVATE_EXPEDITED_RSEQ_READY
+	};
+	static const int registration_cmds[] = {
+		MEMBARRIER_CMD_REGISTER_GLOBAL_EXPEDITED,
+		MEMBARRIER_CMD_REGISTER_PRIVATE_EXPEDITED,
+		MEMBARRIER_CMD_REGISTER_PRIVATE_EXPEDITED_SYNC_CORE,
+		MEMBARRIER_CMD_REGISTER_PRIVATE_EXPEDITED_RSEQ
+	};
+	BUILD_BUG_ON(ARRAY_SIZE(states) != ARRAY_SIZE(registration_cmds));
+
+	membarrier_state = atomic_read(&mm->membarrier_state);
+	for (i = 0; i < ARRAY_SIZE(states); ++i) {
+		if (membarrier_state & states[i]) {
+			registrations_mask |= registration_cmds[i];
+			membarrier_state &= ~states[i];
+		}
+	}
+	WARN_ON_ONCE(membarrier_state != 0);
+	return registrations_mask;
+}
+
 /**
  * sys_membarrier - issue memory barriers on a set of threads
  * @cmd:    Takes command values defined in enum membarrier_cmd.
@@ -623,6 +658,8 @@ SYSCALL_DEFINE3(membarrier, int, cmd, unsigned int, flags, int, cpu_id)
 		return membarrier_private_expedited(MEMBARRIER_FLAG_RSEQ, cpu_id);
 	case MEMBARRIER_CMD_REGISTER_PRIVATE_EXPEDITED_RSEQ:
 		return membarrier_register_private_expedited(MEMBARRIER_FLAG_RSEQ);
+	case MEMBARRIER_CMD_GET_REGISTRATIONS:
+		return membarrier_get_registrations();
 	default:
 		return -EINVAL;
 	}
