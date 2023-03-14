Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 633A06BA04B
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Mar 2023 21:02:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230263AbjCNUCX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Mar 2023 16:02:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39620 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229841AbjCNUCU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Mar 2023 16:02:20 -0400
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 607781FC8
        for <linux-kernel@vger.kernel.org>; Tue, 14 Mar 2023 13:02:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
        s=20170329; h=Content-Transfer-Encoding:MIME-Version:Message-Id:Date:Subject:
        Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:Content-Description:
        Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
        In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=ScOePP8ptx3kVOMCN2OZHRA7zZmcuNjXDuuoTzcaq4c=; b=FdBBFcXcRU38XoS5fijRs2ca65
        Mn6Lg/PH2Atsa8AHOAn21foytDah9QOpYH8syw5IMdJ/ICmzNtcGdAU/bFfAWe3GQVXe3D3LHy/tL
        8enjFOB7dRGuTzox/V0wQaDLsMZmbnUmubhM6JmPw20xV/0Uvg/zFiFznQq9pO5grQR0VZsiMWMom
        qh9dSxGnYoZaH9OocuAPyN2UvYQikX49pe6ohsbIKoon5SxklO9nL6K0AIbMYYeI0J35mbxTZvngG
        mpOfTFmsvwxHiDvvwprbC4i3XDLXtcZRHBbR/PfRVFzjrFWPRByw5/YnSgErveWtjaE5itzd1K2WW
        Qo0fERMg==;
Received: from [152.254.169.34] (helo=localhost)
        by fanzine2.igalia.com with esmtpsa 
        (Cipher TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
        id 1pcAq4-00AOIk-KD; Tue, 14 Mar 2023 21:01:41 +0100
From:   "Guilherme G. Piccoli" <gpiccoli@igalia.com>
To:     akpm@linux-foundation.org, linux-kernel@vger.kernel.org
Cc:     kexec@lists.infradead.org, bhe@redhat.com, pmladek@suse.com,
        xiyou.wangcong@gmail.com, dmitry.osipenko@collabora.com,
        rafael.j.wysocki@intel.com, bigeasy@linutronix.de,
        valentin.schneider@arm.com, kernel-dev@igalia.com,
        kernel@gpiccoli.net, "Guilherme G. Piccoli" <gpiccoli@igalia.com>,
        Arjan van de Ven <arjan@linux.intel.com>,
        Michael Kelley <mikelley@microsoft.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Xiaoming Ni <nixiaoming@huawei.com>
Subject: [PATCH v4] notifiers: Add tracepoints to the notifiers infrastructure
Date:   Tue, 14 Mar 2023 17:00:58 -0300
Message-Id: <20230314200058.1326909-1-gpiccoli@igalia.com>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently there is no way to show the callback names for registered,
unregistered or executed notifiers. This is very useful for debug
purposes, hence add this functionality here in the form of notifiers'
tracepoints, one per operation.

Cc: Arjan van de Ven <arjan@linux.intel.com>
Cc: Michael Kelley <mikelley@microsoft.com>
Cc: Steven Rostedt <rostedt@goodmis.org>
Cc: Xiaoming Ni <nixiaoming@huawei.com>
Signed-off-by: Guilherme G. Piccoli <gpiccoli@igalia.com>
---

V4:
- Rebased and tested on top of v6.3-rc2.
- Sending as standalone patch, not part of any series.

V3:
- Yet another major change - thanks to Arjan's great suggestion,
refactored the code to make use of tracepoints instead of guarding
the output under a Kconfig debug setting.

V2:
- Major improvement thanks to the great idea from Xiaoming - changed
all the ksym wheel reinvention to printk %ps modifier;

- Instead of ifdefs, using IS_ENABLED() - thanks Steven.

- Removed an unlikely() hint on debug path.

V3: https://lore.kernel.org/lkml/20220819221731.480795-8-gpiccoli@igalia.com/
V2: https://lore.kernel.org/lkml/20220719195325.402745-10-gpiccoli@igalia.com/

Thanks in advance for reviews!
Cheers,

Guilherme


 include/trace/events/notifiers.h | 69 ++++++++++++++++++++++++++++++++
 kernel/notifier.c                |  6 +++
 2 files changed, 75 insertions(+)
 create mode 100644 include/trace/events/notifiers.h

diff --git a/include/trace/events/notifiers.h b/include/trace/events/notifiers.h
new file mode 100644
index 000000000000..e8f30631aef5
--- /dev/null
+++ b/include/trace/events/notifiers.h
@@ -0,0 +1,69 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#undef TRACE_SYSTEM
+#define TRACE_SYSTEM notifiers
+
+#if !defined(_TRACE_NOTIFIERS_H) || defined(TRACE_HEADER_MULTI_READ)
+#define _TRACE_NOTIFIERS_H
+
+#include <linux/tracepoint.h>
+
+DECLARE_EVENT_CLASS(notifiers_info,
+
+	TP_PROTO(void *cb),
+
+	TP_ARGS(cb),
+
+	TP_STRUCT__entry(
+		__field(void *, cb)
+	),
+
+	TP_fast_assign(
+		__entry->cb = cb;
+	),
+
+	TP_printk("%ps", __entry->cb)
+);
+
+/*
+ * notifiers_register - called upon notifier callback registration
+ *
+ * @cb:		callback pointer
+ *
+ */
+DEFINE_EVENT(notifiers_info, notifiers_register,
+
+	TP_PROTO(void *cb),
+
+	TP_ARGS(cb)
+);
+
+/*
+ * notifiers_unregister - called upon notifier callback unregistration
+ *
+ * @cb:		callback pointer
+ *
+ */
+DEFINE_EVENT(notifiers_info, notifiers_unregister,
+
+	TP_PROTO(void *cb),
+
+	TP_ARGS(cb)
+);
+
+/*
+ * notifiers_run - called upon notifier callback execution
+ *
+ * @cb:		callback pointer
+ *
+ */
+DEFINE_EVENT(notifiers_info, notifiers_run,
+
+	TP_PROTO(void *cb),
+
+	TP_ARGS(cb)
+);
+
+#endif /* _TRACE_NOTIFIERS_H */
+
+/* This part must be outside protection */
+#include <trace/define_trace.h>
diff --git a/kernel/notifier.c b/kernel/notifier.c
index d353e4b5402d..f57e54ddbb5f 100644
--- a/kernel/notifier.c
+++ b/kernel/notifier.c
@@ -7,6 +7,9 @@
 #include <linux/vmalloc.h>
 #include <linux/reboot.h>
 
+#define CREATE_TRACE_POINTS
+#include <trace/events/notifiers.h>
+
 /*
  *	Notifier list for kernel code which wants to be called
  *	at shutdown. This is used to stop any idling DMA operations
@@ -37,6 +40,7 @@ static int notifier_chain_register(struct notifier_block **nl,
 	}
 	n->next = *nl;
 	rcu_assign_pointer(*nl, n);
+	trace_notifiers_register((void*)n->notifier_call);
 	return 0;
 }
 
@@ -46,6 +50,7 @@ static int notifier_chain_unregister(struct notifier_block **nl,
 	while ((*nl) != NULL) {
 		if ((*nl) == n) {
 			rcu_assign_pointer(*nl, n->next);
+			trace_notifiers_unregister((void*)n->notifier_call);
 			return 0;
 		}
 		nl = &((*nl)->next);
@@ -84,6 +89,7 @@ static int notifier_call_chain(struct notifier_block **nl,
 			continue;
 		}
 #endif
+		trace_notifiers_run((void*)nb->notifier_call);
 		ret = nb->notifier_call(nb, val, v);
 
 		if (nr_calls)
-- 
2.39.2

