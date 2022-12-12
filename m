Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A993C6498E9
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Dec 2022 07:20:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231249AbiLLGT7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Dec 2022 01:19:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36334 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229726AbiLLGT5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Dec 2022 01:19:57 -0500
Received: from mail-pj1-x102c.google.com (mail-pj1-x102c.google.com [IPv6:2607:f8b0:4864:20::102c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A770B1EE
        for <linux-kernel@vger.kernel.org>; Sun, 11 Dec 2022 22:19:54 -0800 (PST)
Received: by mail-pj1-x102c.google.com with SMTP id w4-20020a17090ac98400b002186f5d7a4cso14590519pjt.0
        for <linux-kernel@vger.kernel.org>; Sun, 11 Dec 2022 22:19:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=zRiAhQfW9zEgSY0UOYSIwvqI1zEk4A5iqjfPvFfb03k=;
        b=JZfZNOLoPP63jKFM/KWRIKkVvvHmhX81gpBv4S2vAHF1EAM1RnSkYbeJhUdkF7CmOP
         hJnAIkvNuew5Mkrl05teoqY5+Wq+4Xu70ireh6T0IzKcYI9mCs0aFt5MPH96xJ9nPJti
         MCiVmD6yGnlkG9ZxJdtmvQegAgMr+0h1KnKufU5hyS2hZxmifPUpdtXrcKE4dC4Jlq5w
         kK5auMjenfWYMJvN+1g8jJ6DU0p0ukwyfNlj3ctITfmy6avwEFsq5o3ubevoYijtQ2lB
         hs7M7R69YvLFc9tvqvTSOiDvpWp++A3oWP+x9lIRsaagiPXhhqlc0yo8mlYQiBPbYk+s
         OaCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=zRiAhQfW9zEgSY0UOYSIwvqI1zEk4A5iqjfPvFfb03k=;
        b=32WInOE5SihbIk3vaHR11J/ceYnE+mLRQw8CDaDyqwN2ErMDnKw7uU7Q74jxOqlqMp
         TNj/sIDBQdnVlMVqBORoujgarDJwJ0IkuZTD3QlCC+T6/38B7LT2btT+nTkFVffY0aCG
         e5yednFAR5Kx7Zfmbw+KPjoBz4uEcmWlXf9V7V13xy2+doEs8Q2wbBTtT5nvlIgJc+8C
         iEXyyVgarCRRJlmWyMZIleKc9dj95yJS3IcsLyiDG1h5XKfnqazITeneOw63OuECU8QG
         yY2GZa2IBVqROeaVdWrblL3ozFy62iXl0gTTYe6Wz6pEpFBWjXRBaTLlrRBZgzfPpPlB
         H4iA==
X-Gm-Message-State: ANoB5pmVNZQYdEpZJ+6HvnMld6VHqRjrvfi6+s/GmQOG+OQs7xxICPT2
        Kb+18E+u0mT4Mh1QdJRtgGs=
X-Google-Smtp-Source: AA0mqf4rNnWPu0pi8oOC4xbRRoSzb9BdHCy7JKkL56kM72r/9Fkx0V6j6O9HFga7LQqWiGAiy7+HDg==
X-Received: by 2002:a17:903:2412:b0:188:82fc:e277 with SMTP id e18-20020a170903241200b0018882fce277mr16091283plo.12.1670825994012;
        Sun, 11 Dec 2022 22:19:54 -0800 (PST)
Received: from den-workstation.fareast.nevint.com ([140.206.46.75])
        by smtp.gmail.com with ESMTPSA id i2-20020a17090332c200b001892af9472esm5371089plr.261.2022.12.11.22.19.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 11 Dec 2022 22:19:53 -0800 (PST)
From:   Richard Clark <richard.xnu.clark@gmail.com>
To:     jiangshanlai@gmail.com
Cc:     tj@kernel.org, linux-kernel@vger.kernel.org,
        Richard Clark <richard.xnu.clark@gmail.com>
Subject: [PATCH] workqueue: Prevent a new work item from queueing into a destruction wq
Date:   Mon, 12 Dec 2022 14:18:36 +0800
Message-Id: <20221212061836.3620-1-richard.xnu.clark@gmail.com>
X-Mailer: git-send-email 2.37.2
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

Currently the __WQ_DRAINING is used to prevent a new work item from queueing
to a draining workqueue, but this flag will be cleared before the end of a
RCU grace period. Because the workqueue instance is actually freed after
the RCU grace period, this fact results in an opening window in which a new
work item can be queued into a destorying workqueue and be scheduled
consequently, for instance, the below code snippet demos this accident:

	static void work_func(struct work_struct *work)
	{
		pr_info("%s scheduled\n", __func__);
	}
	static DECLARE_WORK(w0, work_func);

	struct workqueue_struct * wq0 = alloc_workqueue("wq0", 0, 0);
	destroy_workqueue(wq0);
	queue_work_on(1, wq0, &w0);

The above work_func(...) can be scheduled by a destroying workqueue.

This patch will close that window by introducing a new flag __WQ_DESTROYING,
which will keep valid until the end of a RCU grace period. With this commit,
the above code will trigger a WARNING message and return directly from
__queue_work(...), like this:

WARNING: CPU: 7 PID: 3994 at kernel/workqueue.c:1438 __queue_work+0x3ec/0x580

Signed-off-by: Richard Clark <richard.xnu.clark@gmail.com>
---
 include/linux/workqueue.h |  1 +
 kernel/workqueue.c        | 11 ++++++++---
 2 files changed, 9 insertions(+), 3 deletions(-)

diff --git a/include/linux/workqueue.h b/include/linux/workqueue.h
index a0143dd24430..ac551b8ee7d9 100644
--- a/include/linux/workqueue.h
+++ b/include/linux/workqueue.h
@@ -335,6 +335,7 @@ enum {
 	 */
 	WQ_POWER_EFFICIENT	= 1 << 7,
 
+	__WQ_DESTROYING		= 1 << 15, /* internal: workqueue is destroying */
 	__WQ_DRAINING		= 1 << 16, /* internal: workqueue is draining */
 	__WQ_ORDERED		= 1 << 17, /* internal: workqueue is ordered */
 	__WQ_LEGACY		= 1 << 18, /* internal: create*_workqueue() */
diff --git a/kernel/workqueue.c b/kernel/workqueue.c
index 39060a5d0905..09527c9db9cb 100644
--- a/kernel/workqueue.c
+++ b/kernel/workqueue.c
@@ -1433,9 +1433,9 @@ static void __queue_work(int cpu, struct workqueue_struct *wq,
 	lockdep_assert_irqs_disabled();
 
 
-	/* if draining, only works from the same workqueue are allowed */
-	if (unlikely(wq->flags & __WQ_DRAINING) &&
-	    WARN_ON_ONCE(!is_chained_work(wq)))
+	/* if destroying or draining, only works from the same workqueue are allowed */
+	if (unlikely(wq->flags & (__WQ_DESTROYING | __WQ_DRAINING)
+		&& WARN_ON_ONCE(!is_chained_work(wq))))
 		return;
 	rcu_read_lock();
 retry:
@@ -4414,6 +4414,11 @@ void destroy_workqueue(struct workqueue_struct *wq)
 	 */
 	workqueue_sysfs_unregister(wq);
 
+	/* mark the workqueue destruction is in progress */
+	mutex_lock(&wq->mutex);
+	wq->flags |= __WQ_DESTROYING;
+	mutex_unlock(&wq->mutex);
+
 	/* drain it before proceeding with destruction */
 	drain_workqueue(wq);
 
-- 
2.37.2

