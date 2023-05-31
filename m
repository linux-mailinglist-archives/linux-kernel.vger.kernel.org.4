Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 21418718043
	for <lists+linux-kernel@lfdr.de>; Wed, 31 May 2023 14:49:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236030AbjEaMtM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 May 2023 08:49:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45510 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235981AbjEaMs6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 May 2023 08:48:58 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC5D1132
        for <linux-kernel@vger.kernel.org>; Wed, 31 May 2023 05:48:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=Content-Type:MIME-Version:References:
        Subject:Cc:To:From:Date:Message-ID:Sender:Reply-To:Content-Transfer-Encoding:
        Content-ID:Content-Description:In-Reply-To;
        bh=2nCdUjbTqHSXIpP/as6UIFPlbvoMHockVe8OM3H17xE=; b=rZ8TOYTmCeaU+TEpQ6AZQ3+lsI
        PlQqOUV9ONOXgCd8BOV1ztsvoVi1hi38iy2X9VT2YhjjNLgLdyPphoEWi+x/IMhaDxoV8t1yI2Wo4
        SUqnkZ5X9SoDyoE0Tm5qLJWpZBEDG2bezi0sdsI5ZZC85PwYqeF3HdS7sKSzGx2g7n4RTDg3Lz54E
        JOq0R4JufldyHPrwO1rkiFmqq93mhjRzSKeeAba/RMbkfWCKqVLNB9jjj/tMuLXgE1ASCNvu7cWw+
        f/+CKTxRgqq/STk2cx4wJ2Du0BL78eW+pM8XOF8QQ31SzH7Cw0bvU5QCtif8ljpzbCvSHElMTPPQi
        SvXl6rxg==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1q4LEo-00FSL3-2t;
        Wed, 31 May 2023 12:47:39 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 0E2DD30074B;
        Wed, 31 May 2023 14:47:34 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 0)
        id E4391214873C1; Wed, 31 May 2023 14:47:33 +0200 (CEST)
Message-ID: <20230531124603.862983648@infradead.org>
User-Agent: quilt/0.66
Date:   Wed, 31 May 2023 13:58:43 +0200
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
        joel@joelfernandes.org, efault@gmx.de, tglx@linutronix.de
Subject: [PATCH 04/15] rbtree: Add rb_add_augmented_cached() helper
References: <20230531115839.089944915@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
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


