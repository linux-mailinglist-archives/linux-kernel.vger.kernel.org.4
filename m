Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AC5FE5B3A65
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Sep 2022 16:09:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232281AbiIIOCL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Sep 2022 10:02:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59394 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232008AbiIIOAu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Sep 2022 10:00:50 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0681E9C1F3;
        Fri,  9 Sep 2022 07:00:34 -0700 (PDT)
Date:   Fri, 09 Sep 2022 14:00:32 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1662732033;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=hEpyJ2r2amdD8/iRLSJ/2K1z7jt/4JkPUQg3wp/Hemc=;
        b=ycJQgQkvE/cN/sGzkFgJ30b+7MualZxD53+GOnrA9Im+AIItvUuGfy95MVX/9NnhI0N0EW
        Wa9SYS3woBCt1Q0IaeKPaeemd7Qb/qUiGSXELnkH0pBenMHaXJZGDuHy9M6nA8hTogx+Iv
        NoY0CZnn7+fOTzfWdO4oPrPksYk2Kh8h72VaunU3zdhBZwPaQda8bP8PZzFYTKA9sRILUX
        zR8Le/Zj1/LrMLpYKbef4ZuvhkH/ZcybOS9PoNxNcG1+1JmWLM2nFzuCGWDxtG8e7uGNjL
        v+/HmHH7ERiy4MdU+v/XBEo8bZDq0bcNs2QFUwlQsvGzfRiQ/vuan3OD96xUuQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1662732033;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=hEpyJ2r2amdD8/iRLSJ/2K1z7jt/4JkPUQg3wp/Hemc=;
        b=bqwYxIJ61E3gV50tVfh5R7SvT+3ptRNgC0NQBvu1a0taTw85vVXgS5xvqmjt+pxKdNVul8
        ft1gexTt3AA1GDAg==
From:   "tip-bot2 for Tejun Heo" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: sched/psi] kernfs: Refactor kernfs_get_open_node()
Cc:     Chengming Zhou <zhouchengming@bytedance.com>,
        Tejun Heo <tj@kernel.org>,
        "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20220828050440.734579-4-tj@kernel.org>
References: <20220828050440.734579-4-tj@kernel.org>
MIME-Version: 1.0
Message-ID: <166273203218.401.16764817230191009830.tip-bot2@tip-bot2>
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

Commit-ID:     cf2dc9db93704c24f3d6d87d3bd09ae970446d1f
Gitweb:        https://git.kernel.org/tip/cf2dc9db93704c24f3d6d87d3bd09ae970446d1f
Author:        Tejun Heo <tj@kernel.org>
AuthorDate:    Sat, 27 Aug 2022 19:04:34 -10:00
Committer:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
CommitterDate: Thu, 01 Sep 2022 18:08:44 +02:00

kernfs: Refactor kernfs_get_open_node()

Factor out commont part. This is cleaner and should help with future
changes. No functional changes.

Tested-by: Chengming Zhou <zhouchengming@bytedance.com>
Reviewed-by: Chengming Zhou <zhouchengming@bytedance.com>
Signed-off-by: Tejun Heo <tj@kernel.org>
Link: https://lore.kernel.org/r/20220828050440.734579-4-tj@kernel.org
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 fs/kernfs/file.c | 25 +++++++++++--------------
 1 file changed, 11 insertions(+), 14 deletions(-)

diff --git a/fs/kernfs/file.c b/fs/kernfs/file.c
index 6437f7c..7060a2a 100644
--- a/fs/kernfs/file.c
+++ b/fs/kernfs/file.c
@@ -554,31 +554,28 @@ out_unlock:
 static int kernfs_get_open_node(struct kernfs_node *kn,
 				struct kernfs_open_file *of)
 {
-	struct kernfs_open_node *on, *new_on = NULL;
+	struct kernfs_open_node *on;
 	struct mutex *mutex;
 
 	mutex = kernfs_open_file_mutex_lock(kn);
 	on = kernfs_deref_open_node_locked(kn);
 
-	if (on) {
-		list_add_tail(&of->list, &on->files);
-		mutex_unlock(mutex);
-		return 0;
-	} else {
+	if (!on) {
 		/* not there, initialize a new one */
-		new_on = kmalloc(sizeof(*new_on), GFP_KERNEL);
-		if (!new_on) {
+		on = kmalloc(sizeof(*on), GFP_KERNEL);
+		if (!on) {
 			mutex_unlock(mutex);
 			return -ENOMEM;
 		}
-		atomic_set(&new_on->event, 1);
-		init_waitqueue_head(&new_on->poll);
-		INIT_LIST_HEAD(&new_on->files);
-		list_add_tail(&of->list, &new_on->files);
-		rcu_assign_pointer(kn->attr.open, new_on);
+		atomic_set(&on->event, 1);
+		init_waitqueue_head(&on->poll);
+		INIT_LIST_HEAD(&on->files);
+		rcu_assign_pointer(kn->attr.open, on);
 	}
-	mutex_unlock(mutex);
 
+	list_add_tail(&of->list, &on->files);
+
+	mutex_unlock(mutex);
 	return 0;
 }
 
