Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0FD8D6A62D1
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Feb 2023 23:50:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229540AbjB1WuH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Feb 2023 17:50:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42996 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229566AbjB1WuF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Feb 2023 17:50:05 -0500
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com [IPv6:2607:f8b0:4864:20::102d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D0B8C360BD;
        Tue, 28 Feb 2023 14:49:48 -0800 (PST)
Received: by mail-pj1-x102d.google.com with SMTP id qa18-20020a17090b4fd200b0023750b675f5so15251580pjb.3;
        Tue, 28 Feb 2023 14:49:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1677624588;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=g+Zwi5NkQVNAd3Ci7xkK2t0DH7WVF3Tcbrz6/lTqUQc=;
        b=PIJGqEMH5yJKExdMBNeASHbvErvT9M8sHs0vvIKON96f1JEb72jtE3OvRye+bmAv+G
         t3n7Woh97W2teU7RAf+4O0rFLb1P5jRBHZFMnQegX4S4M4KYEaKAIHuN2N8EOp37LJfK
         YyiDYd8C56owyFC4jpxXWEyimSHP4t63Q81ONF21gT+EvldlrGMDa4ZK2gafcj1vJv2e
         I3SYUzMaJpamZdzlFU3mAKJE5bmZGZsLvMk7av0Ubl1wQjs+z4qc7Pu+rIuoBv0+eAki
         MuauQY4XogDMe7sS8ogKAgoJjdwIiqENBcxZqDmyaV9JPj1raeyllEj0Va1CFL1ZrGSv
         LcHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1677624588;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=g+Zwi5NkQVNAd3Ci7xkK2t0DH7WVF3Tcbrz6/lTqUQc=;
        b=dYwPyi/1AQeMsIAwvHB36CZBQKCuTTorqxSl2eIkT4qCwn7ZYAyqQfOiJNhLzAnwSH
         EuAPv9B7s2ZHTjpQKeZdDRM2VDW7lOiWehQTnO8261ZJ1qow16ObobYESmzt0SzgCB6+
         MmSlh9tUBfCR0C0WdUVdaE3Q0ZzJe1yc5AYEq/81RG9uKIG0vy4Ef8UEvsZiztI7WWQ3
         UNywcUXCNVy9t8u3hoocyuGh2BRjS3+umRV7NtaY5P9E88MWgIl7I3fQu9j8lndijVH/
         0ej28L9bc8DAfXrkUEihUOVvSXXv8gEdECvdtOWUuEsV1fNvBjdNrMpQ8+VSRitTMIWW
         koaA==
X-Gm-Message-State: AO0yUKVeLymwLhC77ganoW8ZFdLuoSMuvMjmVst1PN+BcTxvU7i4brNb
        u4d6jnj6EKmkeewoCQ+VqswDrqeH24k=
X-Google-Smtp-Source: AK7set/QFb/pyopNhpRDre6NapurODnHUQ3B1m/bqmjC+Ng5sck2PGs5G1PBU7hrmQDUEL1FdU+JNQ==
X-Received: by 2002:a05:6a21:6da1:b0:cc:c69b:f7e5 with SMTP id wl33-20020a056a216da100b000ccc69bf7e5mr5558797pzb.9.1677624588092;
        Tue, 28 Feb 2023 14:49:48 -0800 (PST)
Received: from blamoreauxMMD6M.vmware.com.com ([2601:600:8380:7f70:5855:8603:f7c2:a87f])
        by smtp.gmail.com with ESMTPSA id d137-20020a63368f000000b00478c48cf73csm6130915pga.82.2023.02.28.14.49.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Feb 2023 14:49:47 -0800 (PST)
From:   "Brennan Lamoreaux (VMware)" <brennanlamoreaux@gmail.com>
To:     linux-rt-users@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     blamoreaux@vmware.com, frederic.martinsons@gmail.com,
        srivatsa@csail.mit.edu, vsirnapalli@vmware.com,
        amakhalov@vmware.com, keerthanak@vmware.com, ankitja@vmware.com,
        bordoloih@vmware.com, srivatsab@vmware.com,
        "Brennan Lamoreaux (VMware)" <brennanlamoreaux@gmail.com>,
        Daniel Wagner <wagi@monom.org>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Tejun Heo <tj@kernel.org>
Subject: [PATCH 4.19-rt] workqueue: Fix deadlock due to recursive locking of pool->lock
Date:   Tue, 28 Feb 2023 14:49:38 -0800
Message-Id: <20230228224938.88035-1-brennanlamoreaux@gmail.com>
X-Mailer: git-send-email 2.32.1 (Apple Git-133)
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Upstream commit d8bb65ab70f7 ("workqueue: Use rcuwait for wq_manager_wait")
replaced the waitqueue with rcuwait in the workqueue code. This change
involved removing the acquisition of pool->lock in put_unbound_pool(),
as it also adds the function wq_manager_inactive() which acquires this same
lock and is called one line later as a parameter to rcu_wait_event().

However, the backport of this commit in the PREEMPT_RT patchset
4.19.255-rt114 (patch 347) missed the removal of the acquisition of
pool->lock in put_unbound_pool(). This leads to a deadlock due to
recursive locking of pool->lock, as shown below in lockdep:

[  252.083713] WARNING: possible recursive locking detected
[  252.083718] 4.19.269-3.ph3-rt #1-photon Not tainted
[  252.083721] --------------------------------------------
[  252.083733] kworker/2:0/33 is trying to acquire lock:
[  252.083747] 000000000b7b1ceb (&pool->lock/1){....}, at:
put_unbound_pool+0x10d/0x260

[  252.083857]
               but task is already holding lock:
[  252.083860] 000000000b7b1ceb (&pool->lock/1){....}, at:
put_unbound_pool+0xbd/0x260

[  252.083876]
               other info that might help us debug this:
[  252.083897]  Possible unsafe locking scenario:

[  252.083900]        CPU0
[  252.083903]        ----
[  252.083904]   lock(&pool->lock/1);
[  252.083911]   lock(&pool->lock/1);
[  252.083919]
                *** DEADLOCK ***

[  252.083921]  May be due to missing lock nesting notation

Fix this deadlock by removing the pool->lock acquisition in
put_unbound_pool().

Signed-off-by: Brennan Lamoreaux (VMware) <brennanlamoreaux@gmail.com>
Cc: Daniel Wagner <wagi@monom.org>
Cc: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: Tejun Heo <tj@kernel.org>
---
 kernel/workqueue.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/kernel/workqueue.c b/kernel/workqueue.c
index a9f3cc02bdc1..55ebdd56a5de 100644
--- a/kernel/workqueue.c
+++ b/kernel/workqueue.c
@@ -3394,7 +3394,6 @@ static void put_unbound_pool(struct worker_pool *pool)
 	 * Because of how wq_manager_inactive() works, we will hold the
 	 * spinlock after a successful wait.
 	 */
-	raw_spin_lock_irq(&pool->lock);
 	rcuwait_wait_event(&manager_wait, wq_manager_inactive(pool),
 			   TASK_UNINTERRUPTIBLE);
 	pool->flags |= POOL_MANAGER_ACTIVE;
-- 
2.35.6

