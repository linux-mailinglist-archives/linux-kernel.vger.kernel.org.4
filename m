Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 74BF3605350
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Oct 2022 00:45:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230168AbiJSWps (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Oct 2022 18:45:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34128 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230023AbiJSWpn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Oct 2022 18:45:43 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F52E17C157;
        Wed, 19 Oct 2022 15:45:40 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id A35A7B82613;
        Wed, 19 Oct 2022 22:45:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3DDF9C4347C;
        Wed, 19 Oct 2022 22:45:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1666219537;
        bh=3OZxlVxAku7nI2DIuQUDXFOtdkRAOZrDoRs4Gtfz/Es=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=vOHLpaLqlSekCN8nXxTgEDCeOcjtPQ+c799RNM3rmdxFz/s5Lh/uCT2nRTUvNKQ0a
         rltR+Sdk/Si6Q3qIv77b99xOsmfyNhu/Rv/OVc9aR+7TztpcxMS1dOD3a77obu364A
         VJQ1mj8MMsDDesTdS0q7MZTN+OH5GAeg88SdwfTj0PIm9wlXcfj/OzIVfmI9aEMm8A
         72HcUVGLcVg90kGLKQVO6Hv+njoAou0aIGm/s7F9tBs1KfEtgCp6tATg5pTjmyoSXO
         wW68A2zx0VCyLokouPQMnZDwuf85H7iLobNJekYSw//bWs78rfNkEBbgwzbvnhLhX+
         ptAByjl66PFqQ==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id D87C45C06B4; Wed, 19 Oct 2022 15:45:36 -0700 (PDT)
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, kernel-team@fb.com,
        rostedt@goodmis.org, "Paul E. McKenney" <paulmck@kernel.org>
Subject: [PATCH rcu 1/4] doc: Remove arrayRCU.rst
Date:   Wed, 19 Oct 2022 15:45:32 -0700
Message-Id: <20221019224535.2499245-1-paulmck@kernel.org>
X-Mailer: git-send-email 2.31.1.189.g2e36527f23
In-Reply-To: <20221019224528.GA2499145@paulmck-ThinkPad-P17-Gen-1>
References: <20221019224528.GA2499145@paulmck-ThinkPad-P17-Gen-1>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Although RCU can in theory be used to protect array indexes in a manner
similar to the way it protects pointers, doing so is extremely risky
because of the huge number of optimizations that modern compilers can
apply to integral types.

For but one example, if your code can be configured such that your array
contains only a single element, then indexing that array with any integer
other than zero invokes undefined behavior, which in turn means that
the compiler is within its rights to assume (without checking!) that any
integer used as an index to that array has the value zero.  Therefore,
the compiler can index the array with the constant zero, which breaks
any dependencies that might have otherwise existed between the time the
actual value was loaded and the time that the array was indexed.

This commit therefore removes the arrayRCU.rst file that describes how
to go about carrying dependencies through array indexes.

Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 Documentation/RCU/arrayRCU.rst | 165 ---------------------------------
 Documentation/RCU/index.rst    |   1 -
 2 files changed, 166 deletions(-)
 delete mode 100644 Documentation/RCU/arrayRCU.rst

diff --git a/Documentation/RCU/arrayRCU.rst b/Documentation/RCU/arrayRCU.rst
deleted file mode 100644
index a5f2ff8fc54c2..0000000000000
--- a/Documentation/RCU/arrayRCU.rst
+++ /dev/null
@@ -1,165 +0,0 @@
-.. _array_rcu_doc:
-
-Using RCU to Protect Read-Mostly Arrays
-=======================================
-
-Although RCU is more commonly used to protect linked lists, it can
-also be used to protect arrays.  Three situations are as follows:
-
-1.  :ref:`Hash Tables <hash_tables>`
-
-2.  :ref:`Static Arrays <static_arrays>`
-
-3.  :ref:`Resizable Arrays <resizable_arrays>`
-
-Each of these three situations involves an RCU-protected pointer to an
-array that is separately indexed.  It might be tempting to consider use
-of RCU to instead protect the index into an array, however, this use
-case is **not** supported.  The problem with RCU-protected indexes into
-arrays is that compilers can play way too many optimization games with
-integers, which means that the rules governing handling of these indexes
-are far more trouble than they are worth.  If RCU-protected indexes into
-arrays prove to be particularly valuable (which they have not thus far),
-explicit cooperation from the compiler will be required to permit them
-to be safely used.
-
-That aside, each of the three RCU-protected pointer situations are
-described in the following sections.
-
-.. _hash_tables:
-
-Situation 1: Hash Tables
-------------------------
-
-Hash tables are often implemented as an array, where each array entry
-has a linked-list hash chain.  Each hash chain can be protected by RCU
-as described in listRCU.rst.  This approach also applies to other
-array-of-list situations, such as radix trees.
-
-.. _static_arrays:
-
-Situation 2: Static Arrays
---------------------------
-
-Static arrays, where the data (rather than a pointer to the data) is
-located in each array element, and where the array is never resized,
-have not been used with RCU.  Rik van Riel recommends using seqlock in
-this situation, which would also have minimal read-side overhead as long
-as updates are rare.
-
-Quick Quiz:
-		Why is it so important that updates be rare when using seqlock?
-
-:ref:`Answer to Quick Quiz <answer_quick_quiz_seqlock>`
-
-.. _resizable_arrays:
-
-Situation 3: Resizable Arrays
-------------------------------
-
-Use of RCU for resizable arrays is demonstrated by the grow_ary()
-function formerly used by the System V IPC code.  The array is used
-to map from semaphore, message-queue, and shared-memory IDs to the data
-structure that represents the corresponding IPC construct.  The grow_ary()
-function does not acquire any locks; instead its caller must hold the
-ids->sem semaphore.
-
-The grow_ary() function, shown below, does some limit checks, allocates a
-new ipc_id_ary, copies the old to the new portion of the new, initializes
-the remainder of the new, updates the ids->entries pointer to point to
-the new array, and invokes ipc_rcu_putref() to free up the old array.
-Note that rcu_assign_pointer() is used to update the ids->entries pointer,
-which includes any memory barriers required on whatever architecture
-you are running on::
-
-	static int grow_ary(struct ipc_ids* ids, int newsize)
-	{
-		struct ipc_id_ary* new;
-		struct ipc_id_ary* old;
-		int i;
-		int size = ids->entries->size;
-
-		if(newsize > IPCMNI)
-			newsize = IPCMNI;
-		if(newsize <= size)
-			return newsize;
-
-		new = ipc_rcu_alloc(sizeof(struct kern_ipc_perm *)*newsize +
-				    sizeof(struct ipc_id_ary));
-		if(new == NULL)
-			return size;
-		new->size = newsize;
-		memcpy(new->p, ids->entries->p,
-		       sizeof(struct kern_ipc_perm *)*size +
-		       sizeof(struct ipc_id_ary));
-		for(i=size;i<newsize;i++) {
-			new->p[i] = NULL;
-		}
-		old = ids->entries;
-
-		/*
-		 * Use rcu_assign_pointer() to make sure the memcpyed
-		 * contents of the new array are visible before the new
-		 * array becomes visible.
-		 */
-		rcu_assign_pointer(ids->entries, new);
-
-		ipc_rcu_putref(old);
-		return newsize;
-	}
-
-The ipc_rcu_putref() function decrements the array's reference count
-and then, if the reference count has dropped to zero, uses call_rcu()
-to free the array after a grace period has elapsed.
-
-The array is traversed by the ipc_lock() function.  This function
-indexes into the array under the protection of rcu_read_lock(),
-using rcu_dereference() to pick up the pointer to the array so
-that it may later safely be dereferenced -- memory barriers are
-required on the Alpha CPU.  Since the size of the array is stored
-with the array itself, there can be no array-size mismatches, so
-a simple check suffices.  The pointer to the structure corresponding
-to the desired IPC object is placed in "out", with NULL indicating
-a non-existent entry.  After acquiring "out->lock", the "out->deleted"
-flag indicates whether the IPC object is in the process of being
-deleted, and, if not, the pointer is returned::
-
-	struct kern_ipc_perm* ipc_lock(struct ipc_ids* ids, int id)
-	{
-		struct kern_ipc_perm* out;
-		int lid = id % SEQ_MULTIPLIER;
-		struct ipc_id_ary* entries;
-
-		rcu_read_lock();
-		entries = rcu_dereference(ids->entries);
-		if(lid >= entries->size) {
-			rcu_read_unlock();
-			return NULL;
-		}
-		out = entries->p[lid];
-		if(out == NULL) {
-			rcu_read_unlock();
-			return NULL;
-		}
-		spin_lock(&out->lock);
-
-		/* ipc_rmid() may have already freed the ID while ipc_lock
-		 * was spinning: here verify that the structure is still valid
-		 */
-		if (out->deleted) {
-			spin_unlock(&out->lock);
-			rcu_read_unlock();
-			return NULL;
-		}
-		return out;
-	}
-
-.. _answer_quick_quiz_seqlock:
-
-Answer to Quick Quiz:
-	Why is it so important that updates be rare when using seqlock?
-
-	The reason that it is important that updates be rare when
-	using seqlock is that frequent updates can livelock readers.
-	One way to avoid this problem is to assign a seqlock for
-	each array entry rather than to the entire array.
diff --git a/Documentation/RCU/index.rst b/Documentation/RCU/index.rst
index e703d3dbe60ce..84a79903f6a88 100644
--- a/Documentation/RCU/index.rst
+++ b/Documentation/RCU/index.rst
@@ -9,7 +9,6 @@ RCU concepts
 .. toctree::
    :maxdepth: 3
 
-   arrayRCU
    checklist
    lockdep
    lockdep-splat
-- 
2.31.1.189.g2e36527f23

