Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EAA76634492
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Nov 2022 20:31:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234783AbiKVTbG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Nov 2022 14:31:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53018 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234490AbiKVTbD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Nov 2022 14:31:03 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 52F8191C20
        for <linux-kernel@vger.kernel.org>; Tue, 22 Nov 2022 11:30:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1669145407;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=3juG06G3YKqZVFnwZoo8pO4nzDVQkrUL6djcNIQJnew=;
        b=VfnByIqVcE/WN2vy495rsvv8O5A02XsAsNPBGNlvXUESLieZqxOfFMQkFESdgP/Ed+qwh1
        3+KWhxEzPxyAHB3Nxd2Pvrpr3RbsszoxBxM91jPkeR8PRUteFyjr/yumLkeQlTDvRhhYYi
        lzftUFFQoXVj+TMPTF1MQxHyZtv32IA=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-534-nIhQ87hwPV6XmiETeSv6uw-1; Tue, 22 Nov 2022 14:30:06 -0500
X-MC-Unique: nIhQ87hwPV6XmiETeSv6uw-1
Received: by mail-wm1-f71.google.com with SMTP id ay19-20020a05600c1e1300b003cf758f1617so11456094wmb.5
        for <linux-kernel@vger.kernel.org>; Tue, 22 Nov 2022 11:30:05 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3juG06G3YKqZVFnwZoo8pO4nzDVQkrUL6djcNIQJnew=;
        b=JO1kgryaAVE/7IDO0+lJUHZcA9KskOAYtkHgGUSbcjzw2FZ4SayaJpAKS617u6mjJz
         ZLnGbfN29qqYE/1XTgCExfNA7ead3dO4gUvkmHt8XlbcFGkBDFAM1Po6lsSzDukqQlzW
         YKDTCIhl7txqwH9MKPMKkHyQM7ob2aEivvW3dowLF3pIoQOVd2oh3KrYcK4Bb5Fjlt8a
         8wAzjnZGIJC1MvUFVEwxQ2NFPf1NobRaJb1HHAfcsTvcDYU/TMPj6XUZHwgdVFvFO7ot
         vT1A3iIVhkFzGr5G/qoZ2PnpLt+g3ZtfyRFql77VLWW0PHkdrkpnBzF/uUJkctuQfshV
         yeIQ==
X-Gm-Message-State: ANoB5plFeIots5jFwJ3/R2Zd/MRU0hPXGlsW/46JmtgykUHKucTR8OUn
        +WyLYCaedopyEEbFHans62pou8JYzkrHoyk4TK5s7+OMRdj9GegF7z507PQvT5tc2Vs1DmMaaY2
        tzHtPOscTxTphSxKeh/afLRtIuawjnSzkirw6YN/RVWKK7P1yGtSvUvtN2wZjk+FZkUo/nr6ePy
        ww
X-Received: by 2002:a05:600c:538b:b0:3b4:7e87:895f with SMTP id hg11-20020a05600c538b00b003b47e87895fmr17780388wmb.30.1669145404376;
        Tue, 22 Nov 2022 11:30:04 -0800 (PST)
X-Google-Smtp-Source: AA0mqf6c1XqNSZJhWUUBOgDKLXeJu/15yG14cyD0JOBLWk4GIDbWjRLmnl0GW3OPHi30c6KcXAIOYw==
X-Received: by 2002:a05:600c:538b:b0:3b4:7e87:895f with SMTP id hg11-20020a05600c538b00b003b47e87895fmr17780350wmb.30.1669145404034;
        Tue, 22 Nov 2022 11:30:04 -0800 (PST)
Received: from vschneid.remote.csb ([154.57.232.159])
        by smtp.gmail.com with ESMTPSA id r14-20020adff10e000000b002366553eca7sm4173682wro.83.2022.11.22.11.30.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Nov 2022 11:30:03 -0800 (PST)
From:   Valentin Schneider <vschneid@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     Lai Jiangshan <jiangshan.ljs@antgroup.com>,
        Tejun Heo <tj@kernel.org>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Frederic Weisbecker <frederic@kernel.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Phil Auld <pauld@redhat.com>,
        Marcelo Tosatti <mtosatti@redhat.com>
Subject: [PATCH v5 1/5] workqueue: Protects wq_unbound_cpumask with wq_pool_attach_mutex
Date:   Tue, 22 Nov 2022 19:29:33 +0000
Message-Id: <20221122192937.2386494-2-vschneid@redhat.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20221122192937.2386494-1-vschneid@redhat.com>
References: <20221122192937.2386494-1-vschneid@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Lai Jiangshan <jiangshan.ljs@antgroup.com>

When unbind_workers() reads wq_unbound_cpumask to set the affinity of
freshly-unbound kworkers, it only holds wq_pool_attach_mutex. This isn't
sufficient as wq_unbound_cpumask is only protected by wq_pool_mutex.

Make wq_unbound_cpumask protected with wq_pool_attach_mutex and also
remove the need of temporary saved_cpumask.

Fixes: 10a5a651e3af ("workqueue: Restrict kworker in the offline CPU pool running on housekeeping CPUs")
Reported-by: Valentin Schneider <vschneid@redhat.com>
Signed-off-by: Lai Jiangshan <jiangshan.ljs@antgroup.com>
---
 kernel/workqueue.c | 41 ++++++++++++++++-------------------------
 1 file changed, 16 insertions(+), 25 deletions(-)

diff --git a/kernel/workqueue.c b/kernel/workqueue.c
index 7cd5f5e7e0a1b..8e21c352c1558 100644
--- a/kernel/workqueue.c
+++ b/kernel/workqueue.c
@@ -326,7 +326,7 @@ static struct rcuwait manager_wait = __RCUWAIT_INITIALIZER(manager_wait);
 static LIST_HEAD(workqueues);		/* PR: list of all workqueues */
 static bool workqueue_freezing;		/* PL: have wqs started freezing? */
 
-/* PL: allowable cpus for unbound wqs and work items */
+/* PL&A: allowable cpus for unbound wqs and work items */
 static cpumask_var_t wq_unbound_cpumask;
 
 /* CPU where unbound work was last round robin scheduled from this CPU */
@@ -3952,7 +3952,8 @@ static void apply_wqattrs_cleanup(struct apply_wqattrs_ctx *ctx)
 /* allocate the attrs and pwqs for later installation */
 static struct apply_wqattrs_ctx *
 apply_wqattrs_prepare(struct workqueue_struct *wq,
-		      const struct workqueue_attrs *attrs)
+		      const struct workqueue_attrs *attrs,
+		      const cpumask_var_t unbound_cpumask)
 {
 	struct apply_wqattrs_ctx *ctx;
 	struct workqueue_attrs *new_attrs, *tmp_attrs;
@@ -3968,14 +3969,15 @@ apply_wqattrs_prepare(struct workqueue_struct *wq,
 		goto out_free;
 
 	/*
-	 * Calculate the attrs of the default pwq.
+	 * Calculate the attrs of the default pwq with unbound_cpumask
+	 * which is wq_unbound_cpumask or to set to wq_unbound_cpumask.
 	 * If the user configured cpumask doesn't overlap with the
 	 * wq_unbound_cpumask, we fallback to the wq_unbound_cpumask.
 	 */
 	copy_workqueue_attrs(new_attrs, attrs);
-	cpumask_and(new_attrs->cpumask, new_attrs->cpumask, wq_unbound_cpumask);
+	cpumask_and(new_attrs->cpumask, new_attrs->cpumask, unbound_cpumask);
 	if (unlikely(cpumask_empty(new_attrs->cpumask)))
-		cpumask_copy(new_attrs->cpumask, wq_unbound_cpumask);
+		cpumask_copy(new_attrs->cpumask, unbound_cpumask);
 
 	/*
 	 * We may create multiple pwqs with differing cpumasks.  Make a
@@ -4072,7 +4074,7 @@ static int apply_workqueue_attrs_locked(struct workqueue_struct *wq,
 		wq->flags &= ~__WQ_ORDERED;
 	}
 
-	ctx = apply_wqattrs_prepare(wq, attrs);
+	ctx = apply_wqattrs_prepare(wq, attrs, wq_unbound_cpumask);
 	if (!ctx)
 		return -ENOMEM;
 
@@ -5334,7 +5336,7 @@ void thaw_workqueues(void)
 }
 #endif /* CONFIG_FREEZER */
 
-static int workqueue_apply_unbound_cpumask(void)
+static int workqueue_apply_unbound_cpumask(const cpumask_var_t unbound_cpumask)
 {
 	LIST_HEAD(ctxs);
 	int ret = 0;
@@ -5350,7 +5352,7 @@ static int workqueue_apply_unbound_cpumask(void)
 		if (wq->flags & __WQ_ORDERED)
 			continue;
 
-		ctx = apply_wqattrs_prepare(wq, wq->unbound_attrs);
+		ctx = apply_wqattrs_prepare(wq, wq->unbound_attrs, unbound_cpumask);
 		if (!ctx) {
 			ret = -ENOMEM;
 			break;
@@ -5365,6 +5367,11 @@ static int workqueue_apply_unbound_cpumask(void)
 		apply_wqattrs_cleanup(ctx);
 	}
 
+	if (!ret) {
+		mutex_lock(&wq_pool_attach_mutex);
+		cpumask_copy(wq_unbound_cpumask, unbound_cpumask);
+		mutex_unlock(&wq_pool_attach_mutex);
+	}
 	return ret;
 }
 
@@ -5383,7 +5390,6 @@ static int workqueue_apply_unbound_cpumask(void)
 int workqueue_set_unbound_cpumask(cpumask_var_t cpumask)
 {
 	int ret = -EINVAL;
-	cpumask_var_t saved_cpumask;
 
 	/*
 	 * Not excluding isolated cpus on purpose.
@@ -5397,23 +5403,8 @@ int workqueue_set_unbound_cpumask(cpumask_var_t cpumask)
 			goto out_unlock;
 		}
 
-		if (!zalloc_cpumask_var(&saved_cpumask, GFP_KERNEL)) {
-			ret = -ENOMEM;
-			goto out_unlock;
-		}
-
-		/* save the old wq_unbound_cpumask. */
-		cpumask_copy(saved_cpumask, wq_unbound_cpumask);
-
-		/* update wq_unbound_cpumask at first and apply it to wqs. */
-		cpumask_copy(wq_unbound_cpumask, cpumask);
-		ret = workqueue_apply_unbound_cpumask();
-
-		/* restore the wq_unbound_cpumask when failed. */
-		if (ret < 0)
-			cpumask_copy(wq_unbound_cpumask, saved_cpumask);
+		ret = workqueue_apply_unbound_cpumask(cpumask);
 
-		free_cpumask_var(saved_cpumask);
 out_unlock:
 		apply_wqattrs_unlock();
 	}
-- 
2.31.1

