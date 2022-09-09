Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 005ED5B3A59
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Sep 2022 16:09:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232246AbiIIOBz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Sep 2022 10:01:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59380 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232078AbiIIOAt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Sep 2022 10:00:49 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B30997F13B;
        Fri,  9 Sep 2022 07:00:32 -0700 (PDT)
Date:   Fri, 09 Sep 2022 14:00:29 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1662732031;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ZAvy1zrYwy9XTqh4ODG8ma1JhILysPikvRzldVe3EIw=;
        b=yj53lHF4ifqca4ewyc7V72N9qYpXrk7wGlYVr5ACnQRpE7imjnLV7rNiwPQzyZzsnfDNsl
        CDa5+dVaflJnmCWGUnoYYgzzdOqINPzmkkJ/XRT8UcS6Wlxc0ExJq5QtQNYAINsSI7+Xwc
        2peo9VP6ubXLheppAJejyKwvU/CgwRhXE7eBeN3gL5M8zj6D2kzIy+A9hPMeRzXDaj1y4o
        0i4/vfOVdJHZbCj/eq6gZ8is3FxG/9VMPTaiuo1FljblVl7GfeZnnGARVGbexbOnM9WpMU
        ivDSpX4LiyU3NORs9XDB9vyxyRKuUoW+4ZyGLJT4x/IuSY6C4kb/zlUqba03PQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1662732031;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ZAvy1zrYwy9XTqh4ODG8ma1JhILysPikvRzldVe3EIw=;
        b=FWmgdlcyvjfvFjzRj2ePr1x0lQgBIPvX2AaVAY82sXG1WB28XP7eQvlZs9oWaFvEBi0qEi
        n9cPA9S9zFBnLdAA==
From:   "tip-bot2 for Tejun Heo" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: sched/psi] kernfs: Improve kernfs_drain() and always call on removal
Cc:     Chengming Zhou <zhouchengming@bytedance.com>,
        Tejun Heo <tj@kernel.org>,
        "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20220828050440.734579-6-tj@kernel.org>
References: <20220828050440.734579-6-tj@kernel.org>
MIME-Version: 1.0
Message-ID: <166273202980.401.2949316254189258021.tip-bot2@tip-bot2>
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

Commit-ID:     2d7f9f8c1815707e9ddb454648a523efc67a04d3
Gitweb:        https://git.kernel.org/tip/2d7f9f8c1815707e9ddb454648a523efc67a04d3
Author:        Tejun Heo <tj@kernel.org>
AuthorDate:    Sat, 27 Aug 2022 19:04:36 -10:00
Committer:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
CommitterDate: Thu, 01 Sep 2022 18:08:44 +02:00

kernfs: Improve kernfs_drain() and always call on removal

__kernfs_remove() was skipping draining based on KERNFS_ACTIVATED - whether
the node has ever been activated since creation. Instead, update it to
always call kernfs_drain() which now drains or skips based on the precise
drain conditions. This ensures that the nodes will be deactivated and
drained regardless of their states.

This doesn't make meaningful difference now but will enable deactivating and
draining nodes dynamically by making removals safe when racing those
operations.

While at it, drop / update comments.

v2: Fix the inverted test on kernfs_should_drain_open_files() noted by
    Chengming. This was fixed by the next unrelated patch in the previous
    posting.

Cc: Chengming Zhou <zhouchengming@bytedance.com>
Tested-by: Chengming Zhou <zhouchengming@bytedance.com>
Reviewed-by: Chengming Zhou <zhouchengming@bytedance.com>
Signed-off-by: Tejun Heo <tj@kernel.org>
Link: https://lore.kernel.org/r/20220828050440.734579-6-tj@kernel.org
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 fs/kernfs/dir.c | 24 ++++++++++++------------
 1 file changed, 12 insertions(+), 12 deletions(-)

diff --git a/fs/kernfs/dir.c b/fs/kernfs/dir.c
index 8ae44db..b3d2018 100644
--- a/fs/kernfs/dir.c
+++ b/fs/kernfs/dir.c
@@ -472,6 +472,16 @@ static void kernfs_drain(struct kernfs_node *kn)
 	lockdep_assert_held_write(&root->kernfs_rwsem);
 	WARN_ON_ONCE(kernfs_active(kn));
 
+	/*
+	 * Skip draining if already fully drained. This avoids draining and its
+	 * lockdep annotations for nodes which have never been activated
+	 * allowing embedding kernfs_remove() in create error paths without
+	 * worrying about draining.
+	 */
+	if (atomic_read(&kn->active) == KN_DEACTIVATED_BIAS &&
+	    !kernfs_should_drain_open_files(kn))
+		return;
+
 	up_write(&root->kernfs_rwsem);
 
 	if (kernfs_lockdep(kn)) {
@@ -480,7 +490,6 @@ static void kernfs_drain(struct kernfs_node *kn)
 			lock_contended(&kn->dep_map, _RET_IP_);
 	}
 
-	/* but everyone should wait for draining */
 	wait_event(root->deactivate_waitq,
 		   atomic_read(&kn->active) == KN_DEACTIVATED_BIAS);
 
@@ -1370,23 +1379,14 @@ static void __kernfs_remove(struct kernfs_node *kn)
 		pos = kernfs_leftmost_descendant(kn);
 
 		/*
-		 * kernfs_drain() drops kernfs_rwsem temporarily and @pos's
+		 * kernfs_drain() may drop kernfs_rwsem temporarily and @pos's
 		 * base ref could have been put by someone else by the time
 		 * the function returns.  Make sure it doesn't go away
 		 * underneath us.
 		 */
 		kernfs_get(pos);
 
-		/*
-		 * Drain iff @kn was activated.  This avoids draining and
-		 * its lockdep annotations for nodes which have never been
-		 * activated and allows embedding kernfs_remove() in create
-		 * error paths without worrying about draining.
-		 */
-		if (kn->flags & KERNFS_ACTIVATED)
-			kernfs_drain(pos);
-		else
-			WARN_ON_ONCE(atomic_read(&kn->active) != KN_DEACTIVATED_BIAS);
+		kernfs_drain(pos);
 
 		/*
 		 * kernfs_unlink_sibling() succeeds once per node.  Use it
