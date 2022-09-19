Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D58DD5BCBFC
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Sep 2022 14:39:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229968AbiISMi3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Sep 2022 08:38:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42704 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229948AbiISMiA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Sep 2022 08:38:00 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C4902D1CF;
        Mon, 19 Sep 2022 05:37:59 -0700 (PDT)
Date:   Mon, 19 Sep 2022 12:37:56 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1663591078;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=eMToeqEHbC3f9iNYlvEMdszGCrWd7neeL0qX2Eba7fI=;
        b=FfHan4uHt3ERhu57OwRl5zlDPP3ExZ6LqZHA9OJdHHP6OGsAIP3v5rrTJEdmIqdQxsPgGT
        vx4eXSsJzlv4j8gF8r5YpI6AtwBuecFQ6h6jNBljxlUHAyYhc9SF7woLa7TufjZPfq1zCM
        dWrbqXEAjsvAdVslVnY6Ej7m190jrL1HrVg6Bc49WmWVUcrbFMkX3jo/ztu2b5TCm5eZRF
        0NToaVUCWJS+W8rw/baWShaxPs8gDxW9nloWFl/Ob/W37Vi1MS4hrlp6r5r0d3bQbe8i5S
        kU20q0eACVBf2MHSdygzqEOwZ6BZAwrMGl0X+t2QqeLrqZgNLYjU7uoBtFAeng==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1663591078;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=eMToeqEHbC3f9iNYlvEMdszGCrWd7neeL0qX2Eba7fI=;
        b=i5ed3GEj+Gls3NGNe2IJv2UORfFoa5gSz808BKcObPpK+1CHwWTjRNi0G+1L8KCAxZH7wv
        32iwTYabqEkreIAA==
From:   "tip-bot2 for Thomas Gleixner" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: sched/rt] mm/vmstat: Use preempt_[dis|en]able_nested()
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Michal Hocko <mhocko@suse.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20220825164131.402717-4-bigeasy@linutronix.de>
References: <20220825164131.402717-4-bigeasy@linutronix.de>
MIME-Version: 1.0
Message-ID: <166359107685.401.14914896289418637333.tip-bot2@tip-bot2>
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

Commit-ID:     7a025e91abd23effe869a05d037b26770ffa0309
Gitweb:        https://git.kernel.org/tip/7a025e91abd23effe869a05d037b26770ffa0309
Author:        Thomas Gleixner <tglx@linutronix.de>
AuthorDate:    Thu, 25 Aug 2022 18:41:26 +02:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Mon, 19 Sep 2022 14:35:08 +02:00

mm/vmstat: Use preempt_[dis|en]able_nested()

Replace the open coded CONFIG_PREEMPT_RT conditional
preempt_enable/disable() pairs with the new helper functions which hide
the underlying implementation details.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Acked-by: Michal Hocko <mhocko@suse.com>
Link: https://lore.kernel.org/r/20220825164131.402717-4-bigeasy@linutronix.de

---
 mm/vmstat.c | 36 ++++++++++++------------------------
 1 file changed, 12 insertions(+), 24 deletions(-)

diff --git a/mm/vmstat.c b/mm/vmstat.c
index 90af9a8..7a2d73f 100644
--- a/mm/vmstat.c
+++ b/mm/vmstat.c
@@ -355,8 +355,7 @@ void __mod_zone_page_state(struct zone *zone, enum zone_stat_item item,
 	 * CPU migrations and preemption potentially corrupts a counter so
 	 * disable preemption.
 	 */
-	if (IS_ENABLED(CONFIG_PREEMPT_RT))
-		preempt_disable();
+	preempt_disable_nested();
 
 	x = delta + __this_cpu_read(*p);
 
@@ -368,8 +367,7 @@ void __mod_zone_page_state(struct zone *zone, enum zone_stat_item item,
 	}
 	__this_cpu_write(*p, x);
 
-	if (IS_ENABLED(CONFIG_PREEMPT_RT))
-		preempt_enable();
+	preempt_enable_nested();
 }
 EXPORT_SYMBOL(__mod_zone_page_state);
 
@@ -393,8 +391,7 @@ void __mod_node_page_state(struct pglist_data *pgdat, enum node_stat_item item,
 	}
 
 	/* See __mod_node_page_state */
-	if (IS_ENABLED(CONFIG_PREEMPT_RT))
-		preempt_disable();
+	preempt_disable_nested();
 
 	x = delta + __this_cpu_read(*p);
 
@@ -406,8 +403,7 @@ void __mod_node_page_state(struct pglist_data *pgdat, enum node_stat_item item,
 	}
 	__this_cpu_write(*p, x);
 
-	if (IS_ENABLED(CONFIG_PREEMPT_RT))
-		preempt_enable();
+	preempt_enable_nested();
 }
 EXPORT_SYMBOL(__mod_node_page_state);
 
@@ -441,8 +437,7 @@ void __inc_zone_state(struct zone *zone, enum zone_stat_item item)
 	s8 v, t;
 
 	/* See __mod_node_page_state */
-	if (IS_ENABLED(CONFIG_PREEMPT_RT))
-		preempt_disable();
+	preempt_disable_nested();
 
 	v = __this_cpu_inc_return(*p);
 	t = __this_cpu_read(pcp->stat_threshold);
@@ -453,8 +448,7 @@ void __inc_zone_state(struct zone *zone, enum zone_stat_item item)
 		__this_cpu_write(*p, -overstep);
 	}
 
-	if (IS_ENABLED(CONFIG_PREEMPT_RT))
-		preempt_enable();
+	preempt_enable_nested();
 }
 
 void __inc_node_state(struct pglist_data *pgdat, enum node_stat_item item)
@@ -466,8 +460,7 @@ void __inc_node_state(struct pglist_data *pgdat, enum node_stat_item item)
 	VM_WARN_ON_ONCE(vmstat_item_in_bytes(item));
 
 	/* See __mod_node_page_state */
-	if (IS_ENABLED(CONFIG_PREEMPT_RT))
-		preempt_disable();
+	preempt_disable_nested();
 
 	v = __this_cpu_inc_return(*p);
 	t = __this_cpu_read(pcp->stat_threshold);
@@ -478,8 +471,7 @@ void __inc_node_state(struct pglist_data *pgdat, enum node_stat_item item)
 		__this_cpu_write(*p, -overstep);
 	}
 
-	if (IS_ENABLED(CONFIG_PREEMPT_RT))
-		preempt_enable();
+	preempt_enable_nested();
 }
 
 void __inc_zone_page_state(struct page *page, enum zone_stat_item item)
@@ -501,8 +493,7 @@ void __dec_zone_state(struct zone *zone, enum zone_stat_item item)
 	s8 v, t;
 
 	/* See __mod_node_page_state */
-	if (IS_ENABLED(CONFIG_PREEMPT_RT))
-		preempt_disable();
+	preempt_disable_nested();
 
 	v = __this_cpu_dec_return(*p);
 	t = __this_cpu_read(pcp->stat_threshold);
@@ -513,8 +504,7 @@ void __dec_zone_state(struct zone *zone, enum zone_stat_item item)
 		__this_cpu_write(*p, overstep);
 	}
 
-	if (IS_ENABLED(CONFIG_PREEMPT_RT))
-		preempt_enable();
+	preempt_enable_nested();
 }
 
 void __dec_node_state(struct pglist_data *pgdat, enum node_stat_item item)
@@ -526,8 +516,7 @@ void __dec_node_state(struct pglist_data *pgdat, enum node_stat_item item)
 	VM_WARN_ON_ONCE(vmstat_item_in_bytes(item));
 
 	/* See __mod_node_page_state */
-	if (IS_ENABLED(CONFIG_PREEMPT_RT))
-		preempt_disable();
+	preempt_disable_nested();
 
 	v = __this_cpu_dec_return(*p);
 	t = __this_cpu_read(pcp->stat_threshold);
@@ -538,8 +527,7 @@ void __dec_node_state(struct pglist_data *pgdat, enum node_stat_item item)
 		__this_cpu_write(*p, overstep);
 	}
 
-	if (IS_ENABLED(CONFIG_PREEMPT_RT))
-		preempt_enable();
+	preempt_enable_nested();
 }
 
 void __dec_zone_page_state(struct page *page, enum zone_stat_item item)
