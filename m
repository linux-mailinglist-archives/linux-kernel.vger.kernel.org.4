Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8E497603BAF
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Oct 2022 10:37:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230185AbiJSIhv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Oct 2022 04:37:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54106 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230123AbiJSIhd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Oct 2022 04:37:33 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E4EF65EDE4;
        Wed, 19 Oct 2022 01:37:28 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 073C320349;
        Wed, 19 Oct 2022 08:37:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1666168647; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Yd/Cz7xu7O0uYFSJIsi+cQi2wPBg7XoVTD7DAavgcck=;
        b=AJoW05FdOrhSCkvVGIYiJtEYpVuK2eUc789q3h5qhlHLBOZn/TPSp0Zxa9sygudLbNJrLq
        N3d/z9UtJLO+2PmCC7tPFBlf6XpLn2ZZ2KZv4u95foN8Fn9n5+z6ZaqalIRNwZ9Ne9kWpK
        azob9ET8tcbALqgeubaUkkDx2n9HszA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1666168647;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Yd/Cz7xu7O0uYFSJIsi+cQi2wPBg7XoVTD7DAavgcck=;
        b=SBs6kDwv+FFaNVPRqtc7mgWsTsKZSfAXcP/ImceBIh10ZdkTkzfti2G3K5VY0ig43Fmx08
        DEtnWK5+w4z1MFCQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id ECCAD13345;
        Wed, 19 Oct 2022 08:37:26 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id WICWOUa3T2NaZQAAMHmgww
        (envelope-from <nstange@suse.de>); Wed, 19 Oct 2022 08:37:26 +0000
From:   Nicolai Stange <nstange@suse.de>
To:     Steffen Klassert <steffen.klassert@secunet.com>,
        Daniel Jordan <daniel.m.jordan@oracle.com>
Cc:     Herbert Xu <herbert@gondor.apana.org.au>,
        Martin Doucha <mdoucha@suse.cz>, linux-crypto@vger.kernel.org,
        linux-kernel@vger.kernel.org, Nicolai Stange <nstange@suse.de>
Subject: [PATCH 4/5] padata: split out dequeue operation from padata_find_next()
Date:   Wed, 19 Oct 2022 10:37:07 +0200
Message-Id: <20221019083708.27138-5-nstange@suse.de>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <20221019083708.27138-1-nstange@suse.de>
References: <20221019083708.27138-1-nstange@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently, padata_find_next() takes a 'remove_object' argument for
specifying whether the caller wants the returned patada_priv, if any, to
get removed from the percpu reorder list it's been found on.

There are only two callsites, both from padata_reorder():
- one supposed to dequeue the padata_priv instances to be processed in a
  loop, i.e. it has the 'remove_object' set to true, and
- another one near the end of padata_reorder() with 'remove_object' set to
  false for checking whether the reorder work needs to get rescheduled.

In order to deal with lifetime issues, a future commit will need to move
this latter reorder work scheduling operation to under the reorder->lock,
where pd->ps is guaranteed to exist as long as there are any padata_privs
to process. However this lock is currently taken within padata_find_next().

In order to be able to extend the reorder->lock to beyond the call to
padata_find_next() from padata_reorder(), a variant where the caller may
grab it for the callee shall be provided.

Split padata_find_next() into two parts:
- __padata_find_next(), which expects the caller to hold the reorder->lock
  and only returns the found padata_priv, if any, without removing it
  from the queue.
- padata_dequeue_next(), with functionality equivalent to the former
  padata_find_next(pd, remove_object=true) and implemented by means of
  the factored out __padata_find_next().

Adapt the two callsites in padata_reorder() as appropriate.

There is no change in functionality.

Signed-off-by: Nicolai Stange <nstange@suse.de>
---
 kernel/padata.c | 57 ++++++++++++++++++++++++++++++++-----------------
 1 file changed, 37 insertions(+), 20 deletions(-)

diff --git a/kernel/padata.c b/kernel/padata.c
index b79226727ef7..e9eab3e94cfc 100644
--- a/kernel/padata.c
+++ b/kernel/padata.c
@@ -230,29 +230,24 @@ int padata_do_parallel(struct padata_shell *ps,
 EXPORT_SYMBOL(padata_do_parallel);
 
 /*
- * padata_find_next - Find the next object that needs serialization.
+ * __padata_find_next - Find the next object that needs serialization.
  *
  * Return:
  * * A pointer to the control struct of the next object that needs
- *   serialization, if present in one of the percpu reorder queues.
+ *   serialization, if already present on the given percpu reorder queue.
  * * NULL, if the next object that needs serialization will
  *   be parallel processed by another cpu and is not yet present in
- *   the cpu's reorder queue.
+ *   the reorder queue.
  */
-static struct padata_priv *padata_find_next(struct parallel_data *pd,
-					    bool remove_object)
+static struct padata_priv *__padata_find_next(struct parallel_data *pd,
+					      struct padata_list *reorder)
 {
 	struct padata_priv *padata;
-	struct padata_list *reorder;
-	int cpu = pd->cpu;
 
-	reorder = per_cpu_ptr(pd->reorder_list, cpu);
+	lockdep_assert_held(&reorder->lock);
 
-	spin_lock(&reorder->lock);
-	if (list_empty(&reorder->list)) {
-		spin_unlock(&reorder->lock);
+	if (list_empty(&reorder->list))
 		return NULL;
-	}
 
 	padata = list_entry(reorder->list.next, struct padata_priv, list);
 
@@ -260,16 +255,30 @@ static struct padata_priv *padata_find_next(struct parallel_data *pd,
 	 * Checks the rare case where two or more parallel jobs have hashed to
 	 * the same CPU and one of the later ones finishes first.
 	 */
-	if (padata->seq_nr != pd->processed) {
+	if (padata->seq_nr != pd->processed)
+		return NULL;
+
+	return padata;
+}
+
+static struct padata_priv *padata_dequeue_next(struct parallel_data *pd)
+{
+	struct padata_priv *padata;
+	struct padata_list *reorder;
+	int cpu = pd->cpu;
+
+	reorder = per_cpu_ptr(pd->reorder_list, cpu);
+	spin_lock(&reorder->lock);
+
+	padata = __padata_find_next(pd, reorder);
+	if (!padata) {
 		spin_unlock(&reorder->lock);
 		return NULL;
 	}
 
-	if (remove_object) {
-		list_del_init(&padata->list);
-		++pd->processed;
-		pd->cpu = cpumask_next_wrap(cpu, pd->cpumask.pcpu, -1, false);
-	}
+	list_del_init(&padata->list);
+	++pd->processed;
+	pd->cpu = cpumask_next_wrap(cpu, pd->cpumask.pcpu, -1, false);
 
 	spin_unlock(&reorder->lock);
 	return padata;
@@ -297,7 +306,7 @@ static bool padata_reorder(struct parallel_data *pd)
 		return false;
 
 	while (1) {
-		padata = padata_find_next(pd, true);
+		padata = padata_dequeue_next(pd);
 
 		/*
 		 * If the next object that needs serialization is parallel
@@ -330,8 +339,16 @@ static bool padata_reorder(struct parallel_data *pd)
 	smp_mb();
 
 	reorder = per_cpu_ptr(pd->reorder_list, pd->cpu);
-	if (!list_empty(&reorder->list) && padata_find_next(pd, false))
+	if (!list_empty(&reorder->list)) {
+		spin_lock(&reorder->lock);
+		if (!__padata_find_next(pd, reorder)) {
+			spin_unlock(&reorder->lock);
+			return false;
+		}
+		spin_unlock(&reorder->lock);
+
 		return queue_work(pinst->serial_wq, &pd->reorder_work);
+	}
 
 	return false;
 }
-- 
2.37.3

