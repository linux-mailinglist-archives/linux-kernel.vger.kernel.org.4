Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 015A96FBCC3
	for <lists+linux-kernel@lfdr.de>; Tue,  9 May 2023 03:52:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234169AbjEIBwL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 May 2023 21:52:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43844 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233895AbjEIBvc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 May 2023 21:51:32 -0400
Received: from mail-pg1-x52d.google.com (mail-pg1-x52d.google.com [IPv6:2607:f8b0:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AEF53D04B
        for <linux-kernel@vger.kernel.org>; Mon,  8 May 2023 18:51:02 -0700 (PDT)
Received: by mail-pg1-x52d.google.com with SMTP id 41be03b00d2f7-53033a0b473so770188a12.0
        for <linux-kernel@vger.kernel.org>; Mon, 08 May 2023 18:51:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1683597061; x=1686189061;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RA5k4x2cPapdL0imOMtMHgP2RzOlYcEcybwZg8p7ykM=;
        b=CzFT7Rvlg6QqOuYMkwmERLb6+Tuxhm+WYECV7SkXw2YgLIv1aZ147r2g0hsCbWCBDm
         64SiF3BFojY7zp4iE7hNIkj+CkF9AEjhUqkmqysA95EEwsYiPaYyqIMg2mvHPvm4BixO
         JxzGYwoZ8pNyKYJEZeq5SvjNqpVc+aPtkkA19xg27iEdXNjwbX0/1avdixuYMo0cenap
         InZ5gRGdfEolzfgBp8BJhFQXyVke8aDgGp0xioRwXPPQYz7veMGBuRz1mf3Y+/MKODro
         N6xh0urWC6ajZfI+O3BiWV/nwl7xhrKzZ/ZD/8WODKUpFYcisgssVMBXY1A0woVgtw1o
         OAuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683597061; x=1686189061;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=RA5k4x2cPapdL0imOMtMHgP2RzOlYcEcybwZg8p7ykM=;
        b=TNY14WQjzSrDPHyN/wAFKhOnaAc/Ww80apzG4AEBFwZn4H7vlOqQuvR3RpFW7QOY2F
         /RQW5zzP1rp7EHRYfrgKdINVYevw6r7d3MFZjhreQQqArMU2pfaZq2qisUgHLTXhlzlN
         2XPV4I+G+Zs/HWHHGgEoh+kCe7MLa8r+wup6Bty0bjg9kdTYr6CWcRUEJ7pMaPK+wMUt
         PM3OTXLEVNba1WLu6W4GbukrSMN4z7wUcmusOP/EedL0hBo38ro6i/32DQbCRbQudfVs
         yV8gf+v9CFpoiDnF+waSGQb+Suya/DkZY/hErckEi/BAeRpMnG5LSelOSJRVszQ4HGw6
         NEnQ==
X-Gm-Message-State: AC+VfDxDddKAbw7L4WXBGyKivyASIUbNeSuhzNgre8q2VJhnT3bhmQwL
        6pl9atTb9lO9TzVwH9+BVwI=
X-Google-Smtp-Source: ACHHUZ7SrBvdBfdBoe8l5fj6veGeS6NBNCyqUqaJI24TRN/OvmGqiWKn5xw8fc6JTkXAAj8lU3DEtg==
X-Received: by 2002:a17:90b:4ac8:b0:24e:507:7408 with SMTP id mh8-20020a17090b4ac800b0024e05077408mr12500681pjb.37.1683597060543;
        Mon, 08 May 2023 18:51:00 -0700 (PDT)
Received: from localhost (2603-800c-1a02-1bae-a7fa-157f-969a-4cde.res6.spectrum.com. [2603:800c:1a02:1bae:a7fa:157f:969a:4cde])
        by smtp.gmail.com with ESMTPSA id b19-20020a17090a8c9300b002509d988eaasm1370207pjo.52.2023.05.08.18.50.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 May 2023 18:51:00 -0700 (PDT)
Sender: Tejun Heo <htejun@gmail.com>
From:   Tejun Heo <tj@kernel.org>
To:     jiangshanlai@gmail.com
Cc:     linux-kernel@vger.kernel.org, kernel-team@meta.com,
        Tejun Heo <tj@kernel.org>,
        kernel test robot <oliver.sang@intel.com>
Subject: [PATCH 13/13] workqueue: Don't implicitly make UNBOUND workqueues w/ @max_active==1 ordered
Date:   Mon,  8 May 2023 15:50:32 -1000
Message-Id: <20230509015032.3768622-14-tj@kernel.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230509015032.3768622-1-tj@kernel.org>
References: <20230509015032.3768622-1-tj@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

5c0338c68706 ("workqueue: restore WQ_UNBOUND/max_active==1 to be ordered")
automoatically promoted UNBOUND workqueues w/ @max_active==1 to ordered
workqueues because UNBOUND workqueues w/ @max_active==1 used to be the way
to create ordered workqueues and the new NUMA support broke it. These
problems can be subtle and the fact that they can only trigger on NUMA
machines made them even more difficult to debug.

However, overloading the UNBOUND allocation interface this way creates other
issues. It's difficult to tell whether a given workqueue actually needs to
be ordered and users that legitimately want a min concurrency level wq
unexpectedly gets an ordered one instead. With planned UNBOUND workqueue
udpates to improve execution locality and more prevalence of chiplet designs
which can benefit from such improvements, this isn't a state we wanna be in
forever.

There aren't that many UNBOUND w/ @max_active==1 users in the tree and the
preceding patches audited all and converted them to
alloc_ordered_workqueue() as appropriate. This patch removes the implicit
promotion of UNBOUND w/ @max_active==1 workqueues to ordered ones.

Workqueue will also add a debug option to make all unordered UNBOUND
workqueues to use per-cpu pool_workqueues so that these problems can be
surfaced easier on most machines.

v2: v1 patch incorrectly dropped !list_empty(&wq->pwqs) condition in
    apply_workqueue_attrs_locked() which spuriously triggers WARNING and
    fails workqueue creation. Fix it.

Signed-off-by: Tejun Heo <tj@kernel.org>
Reported-by: kernel test robot <oliver.sang@intel.com>
Link: https://lore.kernel.org/oe-lkp/202304251050.45a5df1f-oliver.sang@intel.com
---
 include/linux/workqueue.h |  4 +---
 kernel/workqueue.c        | 23 ++++-------------------
 2 files changed, 5 insertions(+), 22 deletions(-)

diff --git a/include/linux/workqueue.h b/include/linux/workqueue.h
index 3992c994787f..79901dea932e 100644
--- a/include/linux/workqueue.h
+++ b/include/linux/workqueue.h
@@ -339,7 +339,6 @@ enum {
 	__WQ_DRAINING		= 1 << 16, /* internal: workqueue is draining */
 	__WQ_ORDERED		= 1 << 17, /* internal: workqueue is ordered */
 	__WQ_LEGACY		= 1 << 18, /* internal: create*_workqueue() */
-	__WQ_ORDERED_EXPLICIT	= 1 << 19, /* internal: alloc_ordered_workqueue() */
 
 	WQ_MAX_ACTIVE		= 512,	  /* I like 512, better ideas? */
 	WQ_MAX_UNBOUND_PER_CPU	= 4,	  /* 4 * #cpus for unbound wq */
@@ -417,8 +416,7 @@ alloc_workqueue(const char *fmt, unsigned int flags, int max_active, ...);
  * Pointer to the allocated workqueue on success, %NULL on failure.
  */
 #define alloc_ordered_workqueue(fmt, flags, args...)			\
-	alloc_workqueue(fmt, WQ_UNBOUND | __WQ_ORDERED |		\
-			__WQ_ORDERED_EXPLICIT | (flags), 1, ##args)
+	alloc_workqueue(fmt, WQ_UNBOUND | __WQ_ORDERED | (flags), 1, ##args)
 
 #define create_workqueue(name)						\
 	alloc_workqueue("%s", __WQ_LEGACY | WQ_MEM_RECLAIM, 1, (name))
diff --git a/kernel/workqueue.c b/kernel/workqueue.c
index 4666a1a92a31..34a91eee7332 100644
--- a/kernel/workqueue.c
+++ b/kernel/workqueue.c
@@ -4195,12 +4195,8 @@ static int apply_workqueue_attrs_locked(struct workqueue_struct *wq,
 		return -EINVAL;
 
 	/* creating multiple pwqs breaks ordering guarantee */
-	if (!list_empty(&wq->pwqs)) {
-		if (WARN_ON(wq->flags & __WQ_ORDERED_EXPLICIT))
-			return -EINVAL;
-
-		wq->flags &= ~__WQ_ORDERED;
-	}
+	if (!list_empty(&wq->pwqs) && WARN_ON(wq->flags & __WQ_ORDERED))
+		return -EINVAL;
 
 	ctx = apply_wqattrs_prepare(wq, attrs, wq_unbound_cpumask);
 	if (!ctx)
@@ -4428,16 +4424,6 @@ struct workqueue_struct *alloc_workqueue(const char *fmt,
 	struct workqueue_struct *wq;
 	struct pool_workqueue *pwq;
 
-	/*
-	 * Unbound && max_active == 1 used to imply ordered, which is no
-	 * longer the case on NUMA machines due to per-node pools.  While
-	 * alloc_ordered_workqueue() is the right way to create an ordered
-	 * workqueue, keep the previous behavior to avoid subtle breakages
-	 * on NUMA.
-	 */
-	if ((flags & WQ_UNBOUND) && max_active == 1)
-		flags |= __WQ_ORDERED;
-
 	/* see the comment above the definition of WQ_POWER_EFFICIENT */
 	if ((flags & WQ_POWER_EFFICIENT) && wq_power_efficient)
 		flags |= WQ_UNBOUND;
@@ -4645,14 +4631,13 @@ void workqueue_set_max_active(struct workqueue_struct *wq, int max_active)
 	struct pool_workqueue *pwq;
 
 	/* disallow meddling with max_active for ordered workqueues */
-	if (WARN_ON(wq->flags & __WQ_ORDERED_EXPLICIT))
+	if (WARN_ON(wq->flags & __WQ_ORDERED))
 		return;
 
 	max_active = wq_clamp_max_active(max_active, wq->flags, wq->name);
 
 	mutex_lock(&wq->mutex);
 
-	wq->flags &= ~__WQ_ORDERED;
 	wq->saved_max_active = max_active;
 
 	for_each_pwq(pwq, wq)
@@ -5920,7 +5905,7 @@ int workqueue_sysfs_register(struct workqueue_struct *wq)
 	 * attributes breaks ordering guarantee.  Disallow exposing ordered
 	 * workqueues.
 	 */
-	if (WARN_ON(wq->flags & __WQ_ORDERED_EXPLICIT))
+	if (WARN_ON(wq->flags & __WQ_ORDERED))
 		return -EINVAL;
 
 	wq->wq_dev = wq_dev = kzalloc(sizeof(*wq_dev), GFP_KERNEL);
-- 
2.40.1

