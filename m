Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 22F735BCBF4
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Sep 2022 14:38:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229999AbiISMiI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Sep 2022 08:38:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42654 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229826AbiISMh5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Sep 2022 08:37:57 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 377C31C139;
        Mon, 19 Sep 2022 05:37:56 -0700 (PDT)
Date:   Mon, 19 Sep 2022 12:37:53 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1663591074;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=/pxhRf4j4/3Y7wBkxlhPyrNkwtdYbgevdP3VljRfyIk=;
        b=tXUv4ucGaj+/AW2TJ7+3t6OqV894fcRsmqZ/Njhw8Pb9B2oViDRYskaiI8EJsVKIim3VUH
        8W3petozHBHndd7n4jtRDx3uDAdS/ksDgO05nOEvLHjcX7Rfmk2AHfmyTZlAbpPizYbJId
        y94WP07c9WnLlzei0uM1oCMZKkttjvrPCHpjQJoCdYjswmH/ZCjcI7Ughi7bzm5ku26dAZ
        dCz6zRmyNT4I/7Z8xXqQp4YOJnLfmbFjwE4jFEFYV83U3nuc2h5ix5TzX0DJU5EN7gDWrn
        oITcwfDlxRDHRAW/R6MeQFbxGCTZBQ5PZXGjPJBvnTXRDfxvLWxliqrVaQ++1g==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1663591074;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=/pxhRf4j4/3Y7wBkxlhPyrNkwtdYbgevdP3VljRfyIk=;
        b=Cn62XzfzCl893QbAfJHoS8bLwVDTmEFuRMlcCzebyw4H83AVWbPF3OWrzeD8A4lVz2bwUq
        whsVU+wdgMA8lGDg==
From:   "tip-bot2 for Thomas Gleixner" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: sched/rt] mm/compaction: Get rid of RT ifdeffery
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20220825164131.402717-7-bigeasy@linutronix.de>
References: <20220825164131.402717-7-bigeasy@linutronix.de>
MIME-Version: 1.0
Message-ID: <166359107372.401.8061562063402421148.tip-bot2@tip-bot2>
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

The following commit has been merged into the sched/rt branch of tip:

Commit-ID:     c7e0b3d088717d148707cd6fcb12f97c6fd961c1
Gitweb:        https://git.kernel.org/tip/c7e0b3d088717d148707cd6fcb12f97c6fd961c1
Author:        Thomas Gleixner <tglx@linutronix.de>
AuthorDate:    Thu, 25 Aug 2022 18:41:29 +02:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Mon, 19 Sep 2022 14:35:08 +02:00

mm/compaction: Get rid of RT ifdeffery

Move the RT dependency for the initial value of
sysctl_compact_unevictable_allowed into Kconfig.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://lore.kernel.org/r/20220825164131.402717-7-bigeasy@linutronix.de

---
 mm/Kconfig      | 6 ++++++
 mm/compaction.c | 6 +-----
 2 files changed, 7 insertions(+), 5 deletions(-)

diff --git a/mm/Kconfig b/mm/Kconfig
index 0331f14..3897e92 100644
--- a/mm/Kconfig
+++ b/mm/Kconfig
@@ -579,6 +579,12 @@ config COMPACTION
 	  it and then we would be really interested to hear about that at
 	  linux-mm@kvack.org.
 
+config COMPACT_UNEVICTABLE_DEFAULT
+	int
+	depends on COMPACTION
+	default 0 if PREEMPT_RT
+	default 1
+
 #
 # support for free page reporting
 config PAGE_REPORTING
diff --git a/mm/compaction.c b/mm/compaction.c
index 640fa76..10561cb 100644
--- a/mm/compaction.c
+++ b/mm/compaction.c
@@ -1727,11 +1727,7 @@ typedef enum {
  * Allow userspace to control policy on scanning the unevictable LRU for
  * compactable pages.
  */
-#ifdef CONFIG_PREEMPT_RT
-int sysctl_compact_unevictable_allowed __read_mostly = 0;
-#else
-int sysctl_compact_unevictable_allowed __read_mostly = 1;
-#endif
+int sysctl_compact_unevictable_allowed __read_mostly = CONFIG_COMPACT_UNEVICTABLE_DEFAULT;
 
 static inline void
 update_fast_start_pfn(struct compact_control *cc, unsigned long pfn)
