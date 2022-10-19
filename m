Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 621FB603BB1
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Oct 2022 10:38:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230206AbiJSIh7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Oct 2022 04:37:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54248 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230137AbiJSIhd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Oct 2022 04:37:33 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 851967E31B;
        Wed, 19 Oct 2022 01:37:30 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 8A774339DA;
        Wed, 19 Oct 2022 08:37:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1666168648; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=qPk+7KJG/hENNIRans/TaYIf8cB/olSwAdJS6bByusQ=;
        b=sbu5QmuD5hMfVso6xNbaey8BXdTICxX0QJIyj+zGamtTVZA3XrzfkmprCbaJCQof4QagCt
        UMDPeanrrGRLIoH6oVp4Wm/aY6XA/94xo7RFPyNdAasI9nOZvs+MBi/023hxnrAJ8WvuhK
        qG6MICJ2dw5PaqdZZTSnHE2IcOVc6Sc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1666168648;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=qPk+7KJG/hENNIRans/TaYIf8cB/olSwAdJS6bByusQ=;
        b=huKMRmkzkKOWK6c3+pNQ++3VFnwwWIJMujRYg2MGpRG6My0bGRwOBCLlxXYsfQnm008dSd
        UUpdKfJqF3WL6gAw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 76EF613345;
        Wed, 19 Oct 2022 08:37:28 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id lv4HHUi3T2NfZQAAMHmgww
        (envelope-from <nstange@suse.de>); Wed, 19 Oct 2022 08:37:28 +0000
From:   Nicolai Stange <nstange@suse.de>
To:     Steffen Klassert <steffen.klassert@secunet.com>,
        Daniel Jordan <daniel.m.jordan@oracle.com>
Cc:     Herbert Xu <herbert@gondor.apana.org.au>,
        Martin Doucha <mdoucha@suse.cz>, linux-crypto@vger.kernel.org,
        linux-kernel@vger.kernel.org, Nicolai Stange <nstange@suse.de>
Subject: [PATCH 5/5] padata: avoid potential UAFs to the padata_shell from padata_reorder()
Date:   Wed, 19 Oct 2022 10:37:08 +0200
Message-Id: <20221019083708.27138-6-nstange@suse.de>
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

Even though the parallel_data "pd" instance passed to padata_reorder() is
guaranteed to exist as per the reference held by its callers, the same is
not true for the associated padata_shell, pd->ps. More specifically, once
the last padata_priv request has been completed, either at entry from
padata_reorder() or concurrently to it, the padata API users are well
within their right to free the padata_shell instance.

Note that this is a purely theoretical issue, it has not been actually
observed. Yet it's worth fixing for the sake of robustness.

Exploit the fact that as long as there are any not yet completed
padata_priv's around on any of the percpu reorder queues, pd->ps is
guaranteed to exist. Make padata_reorder() to load from pd->ps only when
it's known that there is at least one in-flight padata_priv object to
reorder. Note that this involves moving pd->ps accesses to under the
reorder->lock as appropriate, so that the found padata_priv object won't
get dequeued and completed concurrently from a different context.

Fixes: bbefa1dd6a6d ("crypto: pcrypt - Avoid deadlock by using per-instance
                      padata queues")
Signed-off-by: Nicolai Stange <nstange@suse.de>
---
 kernel/padata.c | 18 +++++++++++++++---
 1 file changed, 15 insertions(+), 3 deletions(-)

diff --git a/kernel/padata.c b/kernel/padata.c
index e9eab3e94cfc..fa4818b81eca 100644
--- a/kernel/padata.c
+++ b/kernel/padata.c
@@ -286,7 +286,6 @@ static struct padata_priv *padata_dequeue_next(struct parallel_data *pd)
 
 static bool padata_reorder(struct parallel_data *pd)
 {
-	struct padata_instance *pinst = pd->ps->pinst;
 	int cb_cpu;
 	struct padata_priv *padata;
 	struct padata_serial_queue *squeue;
@@ -323,7 +322,11 @@ static bool padata_reorder(struct parallel_data *pd)
 		list_add_tail(&padata->list, &squeue->serial.list);
 		spin_unlock(&squeue->serial.lock);
 
-		queue_work_on(cb_cpu, pinst->serial_wq, &squeue->work);
+		/*
+		 * Note: as long as there are requests in-flight,
+		 * pd->ps is guaranteed to exist.
+		 */
+		queue_work_on(cb_cpu, pd->ps->pinst->serial_wq, &squeue->work);
 	}
 
 	spin_unlock_bh(&pd->lock);
@@ -340,14 +343,23 @@ static bool padata_reorder(struct parallel_data *pd)
 
 	reorder = per_cpu_ptr(pd->reorder_list, pd->cpu);
 	if (!list_empty(&reorder->list)) {
+		bool reenqueued;
+
 		spin_lock(&reorder->lock);
 		if (!__padata_find_next(pd, reorder)) {
 			spin_unlock(&reorder->lock);
 			return false;
 		}
+
+		/*
+		 * Note: as long as there are requests in-flight,
+		 * pd->ps is guaranteed to exist.
+		 */
+		reenqueued = queue_work(pd->ps->pinst->serial_wq,
+					&pd->reorder_work);
 		spin_unlock(&reorder->lock);
 
-		return queue_work(pinst->serial_wq, &pd->reorder_work);
+		return reenqueued;
 	}
 
 	return false;
-- 
2.37.3

