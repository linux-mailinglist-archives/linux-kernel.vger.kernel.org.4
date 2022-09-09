Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 779275B3A50
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Sep 2022 16:01:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232240AbiIIOBo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Sep 2022 10:01:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59204 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231942AbiIIOAe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Sep 2022 10:00:34 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC058895C6;
        Fri,  9 Sep 2022 07:00:31 -0700 (PDT)
Date:   Fri, 09 Sep 2022 14:00:28 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1662732029;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=gcWh1TCgrHt56LhGM5/FqvCB9ztWauERAJTs/QzpBcc=;
        b=YwoI0Y/4CzLalDEi4qpQaKoUb1mOVGGPbQrfdUwfBy/OuP5VpWJv14i/wtSt3n2rRAxKQ3
        QJGoWZcnv9SPjxB+polKjgOnFmkTZ3ORRCISl0m5sZqUW6Pmegp0XGWQIJE6Opb9w87gwK
        Lr6oqRUy0rLqTIfyU+7ubiGrm1ynyPJaqVseS1rxHsCwhipILClDE+HqJ4qmLMggO0x9ct
        KOijXhGHAFnagquBnE8nUkQmY4cMQlodVccGZumMBGWXaKc47bwKwlggzHGjwtJrAU5MNI
        j+EqM5k8NSF9JXYch5mIhBsXh2ZpS13wLL+EjYcwDEfn5Si7jnpYEC4jW18mRA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1662732029;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=gcWh1TCgrHt56LhGM5/FqvCB9ztWauERAJTs/QzpBcc=;
        b=ARgeA3irjXUkC8yHlZLGMl6gIE7ruCiWL4P7e91DILDzGZmKL0Btyk4uaSq7miSFHKPXJ3
        2MGgf772bCJEfOCA==
From:   "tip-bot2 for Tejun Heo" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: sched/psi] kernfs: Add KERNFS_REMOVING flags
Cc:     Chengming Zhou <zhouchengming@bytedance.com>,
        Tejun Heo <tj@kernel.org>,
        "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20220828050440.734579-7-tj@kernel.org>
References: <20220828050440.734579-7-tj@kernel.org>
MIME-Version: 1.0
Message-ID: <166273202866.401.12020095971904286257.tip-bot2@tip-bot2>
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

Commit-ID:     c25491747b21536bd56dccb82a109754bbc8d52c
Gitweb:        https://git.kernel.org/tip/c25491747b21536bd56dccb82a109754bbc8d52c
Author:        Tejun Heo <tj@kernel.org>
AuthorDate:    Sat, 27 Aug 2022 19:04:37 -10:00
Committer:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
CommitterDate: Thu, 01 Sep 2022 18:08:44 +02:00

kernfs: Add KERNFS_REMOVING flags

KERNFS_ACTIVATED tracks whether a given node has ever been activated. As a
node was only deactivated on removal, this was used for

 1. Drain optimization (removed by the previous patch).
 2. To hide !activated nodes
 3. To avoid double activations
 4. Reject adding children to a node being removed
 5. Skip activaing a node which is being removed.

We want to decouple deactivation from removal so that nodes can be
deactivated and hidden dynamically, which makes KERNFS_ACTIVATED useless for
all of the above purposes.

#1 is already gone. #2 and #3 can instead test whether the node is currently
active. A new flag KERNFS_REMOVING is added to explicitly mark nodes which
are being removed for #4 and #5.

While this leaves KERNFS_ACTIVATED with no users, leave it be as it will be
used in a following patch.

Cc: Chengming Zhou <zhouchengming@bytedance.com>
Tested-by: Chengming Zhou <zhouchengming@bytedance.com>
Reviewed-by: Chengming Zhou <zhouchengming@bytedance.com>
Signed-off-by: Tejun Heo <tj@kernel.org>
Link: https://lore.kernel.org/r/20220828050440.734579-7-tj@kernel.org
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 fs/kernfs/dir.c        | 21 +++++++--------------
 include/linux/kernfs.h |  1 +
 2 files changed, 8 insertions(+), 14 deletions(-)

diff --git a/fs/kernfs/dir.c b/fs/kernfs/dir.c
index b3d2018..f8cbd05 100644
--- a/fs/kernfs/dir.c
+++ b/fs/kernfs/dir.c
@@ -705,13 +705,7 @@ struct kernfs_node *kernfs_find_and_get_node_by_id(struct kernfs_root *root,
 			goto err_unlock;
 	}
 
-	/*
-	 * ACTIVATED is protected with kernfs_mutex but it was clear when
-	 * @kn was added to idr and we just wanna see it set.  No need to
-	 * grab kernfs_mutex.
-	 */
-	if (unlikely(!(kn->flags & KERNFS_ACTIVATED) ||
-		     !atomic_inc_not_zero(&kn->count)))
+	if (unlikely(!kernfs_active(kn) || !atomic_inc_not_zero(&kn->count)))
 		goto err_unlock;
 
 	spin_unlock(&kernfs_idr_lock);
@@ -753,10 +747,7 @@ int kernfs_add_one(struct kernfs_node *kn)
 		goto out_unlock;
 
 	ret = -ENOENT;
-	if (parent->flags & KERNFS_EMPTY_DIR)
-		goto out_unlock;
-
-	if ((parent->flags & KERNFS_ACTIVATED) && !kernfs_active(parent))
+	if (parent->flags & (KERNFS_REMOVING | KERNFS_EMPTY_DIR))
 		goto out_unlock;
 
 	kn->hash = kernfs_name_hash(kn->name, kn->ns);
@@ -1336,7 +1327,7 @@ void kernfs_activate(struct kernfs_node *kn)
 
 	pos = NULL;
 	while ((pos = kernfs_next_descendant_post(pos, kn))) {
-		if (pos->flags & KERNFS_ACTIVATED)
+		if (kernfs_active(pos) || (pos->flags & KERNFS_REMOVING))
 			continue;
 
 		WARN_ON_ONCE(pos->parent && RB_EMPTY_NODE(&pos->rb));
@@ -1368,11 +1359,13 @@ static void __kernfs_remove(struct kernfs_node *kn)
 
 	pr_debug("kernfs %s: removing\n", kn->name);
 
-	/* prevent any new usage under @kn by deactivating all nodes */
+	/* prevent new usage by marking all nodes removing and deactivating */
 	pos = NULL;
-	while ((pos = kernfs_next_descendant_post(pos, kn)))
+	while ((pos = kernfs_next_descendant_post(pos, kn))) {
+		pos->flags |= KERNFS_REMOVING;
 		if (kernfs_active(pos))
 			atomic_add(KN_DEACTIVATED_BIAS, &pos->active);
+	}
 
 	/* deactivate and unlink the subtree node-by-node */
 	do {
diff --git a/include/linux/kernfs.h b/include/linux/kernfs.h
index 367044d..b77d257 100644
--- a/include/linux/kernfs.h
+++ b/include/linux/kernfs.h
@@ -112,6 +112,7 @@ enum kernfs_node_flag {
 	KERNFS_SUICIDED		= 0x0800,
 	KERNFS_EMPTY_DIR	= 0x1000,
 	KERNFS_HAS_RELEASE	= 0x2000,
+	KERNFS_REMOVING		= 0x4000,
 };
 
 /* @flags for kernfs_create_root() */
