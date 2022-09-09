Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 901305B3A4D
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Sep 2022 16:01:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229529AbiIIOBj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Sep 2022 10:01:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59394 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232022AbiIIOAe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Sep 2022 10:00:34 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 28EF79411C;
        Fri,  9 Sep 2022 07:00:30 -0700 (PDT)
Date:   Fri, 09 Sep 2022 14:00:27 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1662732028;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=XQYlL+/uPPur0eJBHooEGnxL1hR/WIyR0GHgF0y6biU=;
        b=P90C5OcyqH8APMj9x0I7lwpQojNcVm9KgtuQCjPbdctRduZvYL1DHyMGNkLLFcWaipuxdc
        QaBbIwC22ANPk9WH3iG754koEqO864xZW2MFIaZMCKx0+TsnsOV7vEKAbyOINfCXotSLBy
        USfpg9ZezJkn8ZXxEJR3WLw5D5/JHR0ohMyJ1IOhK3OmslKkJE7qdyOSZ4LX1IUefLyFOb
        6DLmZwlDJgx/WkqDArmsOzXcRADMdtYQEPGjPkCKOgUM/QE8gX+2jzY25zE75dHn0XLbsV
        84iw/g2hdq0DDM/PHU1RP7IPO+n5B/06A5vjFXvHmxJBCvLFr9kKEjsgcPl7yg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1662732028;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=XQYlL+/uPPur0eJBHooEGnxL1hR/WIyR0GHgF0y6biU=;
        b=2GtzHEwhbPTjpRv6b3Qz5fLHe3NB5OQlOe/S9fgtZSVNeRUcTJR8RCJxUgB+zP8vygRm90
        TxKXvBx75HWNZ1DA==
From:   "tip-bot2 for Tejun Heo" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: sched/psi] kernfs: Factor out kernfs_activate_one()
Cc:     Chengming Zhou <zhouchengming@bytedance.com>,
        Tejun Heo <tj@kernel.org>,
        "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20220828050440.734579-8-tj@kernel.org>
References: <20220828050440.734579-8-tj@kernel.org>
MIME-Version: 1.0
Message-ID: <166273202752.401.7893730819537619208.tip-bot2@tip-bot2>
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

Commit-ID:     f8eb145eb946d543e8c8df3d2db39fcd5c80dacb
Gitweb:        https://git.kernel.org/tip/f8eb145eb946d543e8c8df3d2db39fcd5c80dacb
Author:        Tejun Heo <tj@kernel.org>
AuthorDate:    Sat, 27 Aug 2022 19:04:38 -10:00
Committer:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
CommitterDate: Thu, 01 Sep 2022 18:08:44 +02:00

kernfs: Factor out kernfs_activate_one()

Factor out kernfs_activate_one() from kernfs_activate() and reorder
operations so that KERNFS_ACTIVATED now simply indicates whether activation
was attempted on the node ignoring whether activation took place. As the
flag doesn't have a reader, the refactoring and reordering shouldn't cause
any behavior difference.

Tested-by: Chengming Zhou <zhouchengming@bytedance.com>
Reviewed-by: Chengming Zhou <zhouchengming@bytedance.com>
Signed-off-by: Tejun Heo <tj@kernel.org>
Link: https://lore.kernel.org/r/20220828050440.734579-8-tj@kernel.org
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 fs/kernfs/dir.c | 27 +++++++++++++++++----------
 1 file changed, 17 insertions(+), 10 deletions(-)

diff --git a/fs/kernfs/dir.c b/fs/kernfs/dir.c
index f8cbd05..c932395 100644
--- a/fs/kernfs/dir.c
+++ b/fs/kernfs/dir.c
@@ -1305,6 +1305,21 @@ static struct kernfs_node *kernfs_next_descendant_post(struct kernfs_node *pos,
 	return pos->parent;
 }
 
+static void kernfs_activate_one(struct kernfs_node *kn)
+{
+	lockdep_assert_held_write(&kernfs_root(kn)->kernfs_rwsem);
+
+	kn->flags |= KERNFS_ACTIVATED;
+
+	if (kernfs_active(kn) || (kn->flags & KERNFS_REMOVING))
+		return;
+
+	WARN_ON_ONCE(kn->parent && RB_EMPTY_NODE(&kn->rb));
+	WARN_ON_ONCE(atomic_read(&kn->active) != KN_DEACTIVATED_BIAS);
+
+	atomic_sub(KN_DEACTIVATED_BIAS, &kn->active);
+}
+
 /**
  * kernfs_activate - activate a node which started deactivated
  * @kn: kernfs_node whose subtree is to be activated
@@ -1326,16 +1341,8 @@ void kernfs_activate(struct kernfs_node *kn)
 	down_write(&root->kernfs_rwsem);
 
 	pos = NULL;
-	while ((pos = kernfs_next_descendant_post(pos, kn))) {
-		if (kernfs_active(pos) || (pos->flags & KERNFS_REMOVING))
-			continue;
-
-		WARN_ON_ONCE(pos->parent && RB_EMPTY_NODE(&pos->rb));
-		WARN_ON_ONCE(atomic_read(&pos->active) != KN_DEACTIVATED_BIAS);
-
-		atomic_sub(KN_DEACTIVATED_BIAS, &pos->active);
-		pos->flags |= KERNFS_ACTIVATED;
-	}
+	while ((pos = kernfs_next_descendant_post(pos, kn)))
+		kernfs_activate_one(pos);
 
 	up_write(&root->kernfs_rwsem);
 }
