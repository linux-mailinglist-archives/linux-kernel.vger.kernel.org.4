Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EF3EB5B3A4B
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Sep 2022 16:01:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232202AbiIIOBe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Sep 2022 10:01:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59382 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232010AbiIIOAd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Sep 2022 10:00:33 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 14418923CD;
        Fri,  9 Sep 2022 07:00:29 -0700 (PDT)
Date:   Fri, 09 Sep 2022 14:00:26 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1662732027;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=gvoq0aP5YpV3gsEemiWgVEd8RBLPpZGpxGyGMv2Y5J4=;
        b=1Csf1Rqvc7mAh9BPLznjxhSsoEgWpFcE3y3dBOtY0b5//iWIlLWMmzp5iiMEJsTxLGpMUY
        tYK8KeQX93SkWk8JTib8fdPXyxNeCAxLaPELan3vJpElhn2T28xUppB5eOEY40y7L3FCnI
        xEuwkNDNhPLtDd/8j/xq5VQy9Jfm7kuskfWXA326RhTaxWvXp9NaMYWsWei+5AX6hWIlfF
        RRDpPLoyX2P8DodZpp1BHU3S5DzmGYBGZXjop+ShApTOm739GUaQqB7DPgaG9/NRoIzL+T
        sIELN00qIU4Ug/KJ7cOlDTXBfVpJi88vQ+C2evDmyzNPDkz9arzPfjT0wk7iWA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1662732027;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=gvoq0aP5YpV3gsEemiWgVEd8RBLPpZGpxGyGMv2Y5J4=;
        b=xrVx2BOHaNIpa9Skth4bikgb3EyYDtdgzZ/mPkIBaIxBcY/bna1UM4ZL8Vf9R1uHZ2NhVK
        62pji0PxSrOAaBBQ==
From:   "tip-bot2 for Tejun Heo" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: sched/psi] kernfs: Implement kernfs_show()
Cc:     Chengming Zhou <zhouchengming@bytedance.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Tejun Heo <tj@kernel.org>,
        "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20220828050440.734579-9-tj@kernel.org>
References: <20220828050440.734579-9-tj@kernel.org>
MIME-Version: 1.0
Message-ID: <166273202640.401.14793882914219935256.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the sched/psi branch of tip:

Commit-ID:     783bd07d095b722108725af11113795ee046ed0e
Gitweb:        https://git.kernel.org/tip/783bd07d095b722108725af11113795ee046ed0e
Author:        Tejun Heo <tj@kernel.org>
AuthorDate:    Sat, 27 Aug 2022 19:04:39 -10:00
Committer:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
CommitterDate: Thu, 01 Sep 2022 18:08:44 +02:00

kernfs: Implement kernfs_show()

Currently, kernfs nodes can be created hidden and activated later by calling
kernfs_activate() to allow creation of multiple nodes to succeed or fail as
a unit. This is an one-way one-time-only transition. This patch introduces
kernfs_show() which can toggle visibility dynamically.

As the currently proposed use - toggling the cgroup pressure files - only
requires operating on leaf nodes, for the sake of simplicity, restrict it as
such for now.

Hiding uses the same mechanism as deactivation and likewise guarantees that
there are no in-flight operations on completion. KERNFS_ACTIVATED and
KERNFS_HIDDEN are used to manage the interactions between activations and
show/hide operations. A node is visible iff both activated & !hidden.

Cc: Chengming Zhou <zhouchengming@bytedance.com>
Cc: Johannes Weiner <hannes@cmpxchg.org>
Tested-by: Chengming Zhou <zhouchengming@bytedance.com>
Reviewed-by: Chengming Zhou <zhouchengming@bytedance.com>
Signed-off-by: Tejun Heo <tj@kernel.org>
Link: https://lore.kernel.org/r/20220828050440.734579-9-tj@kernel.org
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 fs/kernfs/dir.c        | 37 ++++++++++++++++++++++++++++++++++++-
 include/linux/kernfs.h |  2 ++
 2 files changed, 38 insertions(+), 1 deletion(-)

diff --git a/fs/kernfs/dir.c b/fs/kernfs/dir.c
index c932395..7fb5a72 100644
--- a/fs/kernfs/dir.c
+++ b/fs/kernfs/dir.c
@@ -1311,7 +1311,7 @@ static void kernfs_activate_one(struct kernfs_node *kn)
 
 	kn->flags |= KERNFS_ACTIVATED;
 
-	if (kernfs_active(kn) || (kn->flags & KERNFS_REMOVING))
+	if (kernfs_active(kn) || (kn->flags & (KERNFS_HIDDEN | KERNFS_REMOVING)))
 		return;
 
 	WARN_ON_ONCE(kn->parent && RB_EMPTY_NODE(&kn->rb));
@@ -1347,6 +1347,41 @@ void kernfs_activate(struct kernfs_node *kn)
 	up_write(&root->kernfs_rwsem);
 }
 
+/**
+ * kernfs_show - show or hide a node
+ * @kn: kernfs_node to show or hide
+ * @show: whether to show or hide
+ *
+ * If @show is %false, @kn is marked hidden and deactivated. A hidden node is
+ * ignored in future activaitons. If %true, the mark is removed and activation
+ * state is restored. This function won't implicitly activate a new node in a
+ * %KERNFS_ROOT_CREATE_DEACTIVATED root which hasn't been activated yet.
+ *
+ * To avoid recursion complexities, directories aren't supported for now.
+ */
+void kernfs_show(struct kernfs_node *kn, bool show)
+{
+	struct kernfs_root *root = kernfs_root(kn);
+
+	if (WARN_ON_ONCE(kernfs_type(kn) == KERNFS_DIR))
+		return;
+
+	down_write(&root->kernfs_rwsem);
+
+	if (show) {
+		kn->flags &= ~KERNFS_HIDDEN;
+		if (kn->flags & KERNFS_ACTIVATED)
+			kernfs_activate_one(kn);
+	} else {
+		kn->flags |= KERNFS_HIDDEN;
+		if (kernfs_active(kn))
+			atomic_add(KN_DEACTIVATED_BIAS, &kn->active);
+		kernfs_drain(kn);
+	}
+
+	up_write(&root->kernfs_rwsem);
+}
+
 static void __kernfs_remove(struct kernfs_node *kn)
 {
 	struct kernfs_node *pos;
diff --git a/include/linux/kernfs.h b/include/linux/kernfs.h
index b77d257..73f5c12 100644
--- a/include/linux/kernfs.h
+++ b/include/linux/kernfs.h
@@ -108,6 +108,7 @@ enum kernfs_node_flag {
 	KERNFS_HAS_SEQ_SHOW	= 0x0040,
 	KERNFS_HAS_MMAP		= 0x0080,
 	KERNFS_LOCKDEP		= 0x0100,
+	KERNFS_HIDDEN		= 0x0200,
 	KERNFS_SUICIDAL		= 0x0400,
 	KERNFS_SUICIDED		= 0x0800,
 	KERNFS_EMPTY_DIR	= 0x1000,
@@ -430,6 +431,7 @@ struct kernfs_node *kernfs_create_link(struct kernfs_node *parent,
 				       const char *name,
 				       struct kernfs_node *target);
 void kernfs_activate(struct kernfs_node *kn);
+void kernfs_show(struct kernfs_node *kn, bool show);
 void kernfs_remove(struct kernfs_node *kn);
 void kernfs_break_active_protection(struct kernfs_node *kn);
 void kernfs_unbreak_active_protection(struct kernfs_node *kn);
