Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9D0876AC307
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Mar 2023 15:21:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231185AbjCFOVI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Mar 2023 09:21:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55910 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231613AbjCFOUV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Mar 2023 09:20:21 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C72E28862
        for <linux-kernel@vger.kernel.org>; Mon,  6 Mar 2023 06:19:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Type:MIME-Version:References:
        Subject:Cc:To:From:Date:Message-ID:Sender:Reply-To:Content-Transfer-Encoding:
        Content-ID:Content-Description:In-Reply-To;
        bh=2nCdUjbTqHSXIpP/as6UIFPlbvoMHockVe8OM3H17xE=; b=Mod0KOPpiSabgUHOLTx1sle+s2
        anx6IYYxBch+n485hQS8W7QsAh3wiEDutIbB1MmycwrsXES4TkHFXVNYRq2M9wDwN09aC020vrFlU
        lW7pv5pEZhnV7cxx+FJFWUXYP/VXMWB6k/o8zGFRkTNAsInxGRKzKJ/PGma5pjzyE7ieMmW1EQ6hv
        kiRINAsgZMgUqLhEtmzYJdfKHmvFog2n8oUJ6ojkUeJRb4ONUyLKGOanBZ5QuPVfqI9K93Ol4dGdR
        Ln3uKdLOA4vM25GKxYtrxmBUaSrvON2J1xvyBIKnIQRqe/6+0WWVLPiFHr41pBqIM2k77WyjlC+GV
        f3YXMk6Q==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1pZBe6-005P2a-8B; Mon, 06 Mar 2023 14:16:58 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 89030300328;
        Mon,  6 Mar 2023 15:16:56 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 0)
        id 18D5C23BC8E2F; Mon,  6 Mar 2023 15:16:55 +0100 (CET)
Message-ID: <20230306141502.750918974@infradead.org>
User-Agent: quilt/0.66
Date:   Mon, 06 Mar 2023 14:25:30 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     mingo@kernel.org, vincent.guittot@linaro.org
Cc:     linux-kernel@vger.kernel.org, peterz@infradead.org,
        juri.lelli@redhat.com, dietmar.eggemann@arm.com,
        rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
        bristot@redhat.com, corbet@lwn.net, qyousef@layalina.io,
        chris.hyser@oracle.com, patrick.bellasi@matbug.net, pjt@google.com,
        pavel@ucw.cz, qperret@google.com, tim.c.chen@linux.intel.com,
        joshdon@google.com, timj@gnu.org, kprateek.nayak@amd.com,
        yu.c.chen@intel.com, youssefesmat@chromium.org,
        joel@joelfernandes.org
Subject: [PATCH 09/10] rbtree: Add rb_add_augmented_cached() helper
References: <20230306132521.968182689@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

While slightly sub-optimal, updating the augmented data while going
down the tree during lookup would be faster -- alas the augment
interface does not currently allow for that, provide a generic helper
to add a node to an augmented cached tree.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 include/linux/rbtree_augmented.h |   26 ++++++++++++++++++++++++++
 1 file changed, 26 insertions(+)

--- a/include/linux/rbtree_augmented.h
+++ b/include/linux/rbtree_augmented.h
@@ -60,6 +60,32 @@ rb_insert_augmented_cached(struct rb_nod
 	rb_insert_augmented(node, &root->rb_root, augment);
 }
 
+static __always_inline struct rb_node *
+rb_add_augmented_cached(struct rb_node *node, struct rb_root_cached *tree,
+			bool (*less)(struct rb_node *, const struct rb_node *),
+			const struct rb_augment_callbacks *augment)
+{
+	struct rb_node **link = &tree->rb_root.rb_node;
+	struct rb_node *parent = NULL;
+	bool leftmost = true;
+
+	while (*link) {
+		parent = *link;
+		if (less(node, parent)) {
+			link = &parent->rb_left;
+		} else {
+			link = &parent->rb_right;
+			leftmost = false;
+		}
+	}
+
+	rb_link_node(node, parent, link);
+	augment->propagate(parent, NULL); /* suboptimal */
+	rb_insert_augmented_cached(node, tree, leftmost, augment);
+
+	return leftmost ? node : NULL;
+}
+
 /*
  * Template for declaring augmented rbtree callbacks (generic case)
  *


