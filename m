Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 93B53603BA6
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Oct 2022 10:37:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230170AbiJSIhj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Oct 2022 04:37:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54104 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230071AbiJSIh3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Oct 2022 04:37:29 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B3C077D7BB;
        Wed, 19 Oct 2022 01:37:26 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 5F99F20382;
        Wed, 19 Oct 2022 08:37:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1666168645; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=nDl7gQ8N7tn2RB1Gh66JslmBkmAIPalxnvJSrXhYvqQ=;
        b=pgqxuoXE0xR8Djlfp+UWAPSVNOMcy8HcaYtM8psOj4cHlq7SEG9CFhupuWyAQ1AiXcXKq9
        Cih0uYHHzco9Ksw++jgPUG9a8zTD/Kq/QQlh6fZJKGqXKOCbCLkHsAG8CN163f+NNJQCHq
        e1YD0AW1OJUan0dCOj8wBcFvR0YaneU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1666168645;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=nDl7gQ8N7tn2RB1Gh66JslmBkmAIPalxnvJSrXhYvqQ=;
        b=xDK9iTx0RlIKR7s5AblRCrV1tEdBD4Z89I2aHzDYTpLHjuz2wLAP1vfMEFQbQUmo7K1CLi
        gVyC5su9vtvv7sBg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 4F83C13345;
        Wed, 19 Oct 2022 08:37:25 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id 7b/7EkW3T2NVZQAAMHmgww
        (envelope-from <nstange@suse.de>); Wed, 19 Oct 2022 08:37:25 +0000
From:   Nicolai Stange <nstange@suse.de>
To:     Steffen Klassert <steffen.klassert@secunet.com>,
        Daniel Jordan <daniel.m.jordan@oracle.com>
Cc:     Herbert Xu <herbert@gondor.apana.org.au>,
        Martin Doucha <mdoucha@suse.cz>, linux-crypto@vger.kernel.org,
        linux-kernel@vger.kernel.org, Nicolai Stange <nstange@suse.de>
Subject: [PATCH 3/5] padata: grab parallel_data refcnt for reorder
Date:   Wed, 19 Oct 2022 10:37:06 +0200
Message-Id: <20221019083708.27138-4-nstange@suse.de>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <20221019083708.27138-1-nstange@suse.de>
References: <20221019083708.27138-1-nstange@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On entry of padata_do_serial(), the in-flight padata_priv owns a reference
to the associated parallel_data instance.

However, as soon as the padata_priv got enqueued on the reorder list, it
can be completed from a different context, causing the reference to get
released in the course.

This would potentially cause UAFs from the subsequent padata_reorder()
operations invoked from the enqueueing padata_do_serial() or from the
reorder work.

Note that this is a purely theroretical concern, the problem has never been
actually observed -- it would require multiple pcrypt request submissions
racing against each other, ultimately a pcrypt instance destruction
(DELALG) short after request completions as well as unfortunate timing.

However, for the sake of correctness, it is still worth fixing.

Make padata_do_serial() grab a reference count on the parallel_data for
the subsequent reorder operation(s). As long as the padata_priv has not
been enqueued, this is safe, because as mentioned above, in-flight
pdata_privs own a reference already.

Note that padata_reorder() might schedule another padata_reorder() work
and thus, care must be taken to not prematurely release that "reorder
refcount" from padata_do_serial() again in case that has happened.
Make padata_reorder() return a bool for indicating whether or not a
reorder work has been scheduled. Let padata_do_serial() drop its refcount
only if this is not the case. Accordingly, make the reorder work handler,
invoke_padata_reorder(), drop it then as appropriate.

A remark on the commit chosen for the Fixes tag reference below: before
commit bbefa1dd6a6d ("crypto: pcrypt - Avoid deadlock by using per-instance
padata queues"), the padata_parallel lifetime had been tied to the
padata_instance. The padata_free() resp. padata_stop() issued a
synchronize_rcu() before padata_free_pd() from the instance destruction
path, rendering UAFs from the padata_do_serial()=>padata_reorder()
invocations with BHs disabled impossible AFAICS. With that, the
padata_reorder() work remains to be considered. Before
commit b128a3040935 ("padata: allocate workqueue internally"), the
workqueue got destroyed (from pcrypt), hence drained, before the padata
instance destruction, but this change moved that to after the
padata_free_pd() invocation from __padata_free(). So, while the Fixes
reference from below is most likely technically correct, I would still like
to reiterate that this problem is probably hard to trigger in practice,
even more so before commit bbefa1dd6a6d ("crypto: pcrypt - Avoid deadlock
by using per-instance padata queues").

Fixes: b128a3040935 ("padata: allocate workqueue internally")
Signed-off-by: Nicolai Stange <nstange@suse.de>
---
 kernel/padata.c | 26 +++++++++++++++++++++-----
 1 file changed, 21 insertions(+), 5 deletions(-)

diff --git a/kernel/padata.c b/kernel/padata.c
index 0bf8c80dad5a..b79226727ef7 100644
--- a/kernel/padata.c
+++ b/kernel/padata.c
@@ -275,7 +275,7 @@ static struct padata_priv *padata_find_next(struct parallel_data *pd,
 	return padata;
 }
 
-static void padata_reorder(struct parallel_data *pd)
+static bool padata_reorder(struct parallel_data *pd)
 {
 	struct padata_instance *pinst = pd->ps->pinst;
 	int cb_cpu;
@@ -294,7 +294,7 @@ static void padata_reorder(struct parallel_data *pd)
 	 * care for all the objects enqueued during the holdtime of the lock.
 	 */
 	if (!spin_trylock_bh(&pd->lock))
-		return;
+		return false;
 
 	while (1) {
 		padata = padata_find_next(pd, true);
@@ -331,17 +331,23 @@ static void padata_reorder(struct parallel_data *pd)
 
 	reorder = per_cpu_ptr(pd->reorder_list, pd->cpu);
 	if (!list_empty(&reorder->list) && padata_find_next(pd, false))
-		queue_work(pinst->serial_wq, &pd->reorder_work);
+		return queue_work(pinst->serial_wq, &pd->reorder_work);
+
+	return false;
 }
 
 static void invoke_padata_reorder(struct work_struct *work)
 {
 	struct parallel_data *pd;
+	bool keep_refcnt;
 
 	local_bh_disable();
 	pd = container_of(work, struct parallel_data, reorder_work);
-	padata_reorder(pd);
+	keep_refcnt = padata_reorder(pd);
 	local_bh_enable();
+
+	if (!keep_refcnt)
+		padata_put_pd(pd);
 }
 
 static void padata_serial_worker(struct work_struct *serial_work)
@@ -392,6 +398,15 @@ void padata_do_serial(struct padata_priv *padata)
 	struct padata_list *reorder = per_cpu_ptr(pd->reorder_list, hashed_cpu);
 	struct padata_priv *cur;
 
+	/*
+	 * The in-flight padata owns a reference on pd. However, as
+	 * soon as it's been enqueued on the reorder list, another
+	 * task can dequeue and complete it, thereby dropping the
+	 * reference. Grab another reference here, it will eventually
+	 * be released from a reorder work, if any, or below.
+	 */
+	padata_get_pd(pd);
+
 	spin_lock(&reorder->lock);
 	/* Sort in ascending order of sequence number. */
 	list_for_each_entry_reverse(cur, &reorder->list, list)
@@ -407,7 +422,8 @@ void padata_do_serial(struct padata_priv *padata)
 	 */
 	smp_mb();
 
-	padata_reorder(pd);
+	if (!padata_reorder(pd))
+		padata_put_pd(pd);
 }
 EXPORT_SYMBOL(padata_do_serial);
 
-- 
2.37.3

