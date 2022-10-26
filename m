Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C8C9060E2A0
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Oct 2022 15:53:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232528AbiJZNxB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Oct 2022 09:53:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43718 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234069AbiJZNwL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Oct 2022 09:52:11 -0400
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com [IPv6:2a00:1450:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7174110693B
        for <linux-kernel@vger.kernel.org>; Wed, 26 Oct 2022 06:52:08 -0700 (PDT)
Received: by mail-wm1-x32b.google.com with SMTP id fn7-20020a05600c688700b003b4fb113b86so1646987wmb.0
        for <linux-kernel@vger.kernel.org>; Wed, 26 Oct 2022 06:52:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=r6vbNsa2eLap4ns5f+FVzjJUNvmUKrnMf3TrYs7N5b8=;
        b=WO+G3icBGCRcaMhVI1/GdlooZ49H5FQYwsViSL3DAvFOS8vB5/wOWnZOqR7OhDo9zT
         PkdFY8vmyNGEqZInbZ9vPVhUIaWZkdY6WQFqyMRRtCzhPU95KGvuo8OGMsm6+1ty4BEs
         awbYncV8BOAmY0O772wKpZqBv6DdgHGU4IiunWLaGNUwFit6BT9uqTSGo+LWPjJ6Lgqf
         I4OtBkme9Mys08eQGD/w3JM6pjU87qyVEzRis1V1Wngjxk4KtO94dG63mxF+GjkDlZoT
         JT2VQsVrf8qhh7ABalixMLMG2Hjg+M1TuselYfEW7H8ELH6I+4VVowZmaPeHpmzWLgw+
         YQuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=r6vbNsa2eLap4ns5f+FVzjJUNvmUKrnMf3TrYs7N5b8=;
        b=WjP7PDvYogCA3dMTKLiws6OFVjNdtLrlewsSZRwlucetYgP64A4OjNnJfMVm7KcMSX
         h3Isg+jDAnx3dVwnXoS0R8rjohH+8+HNrI+rUS+tL4ifrcoDKEJGcbODhQAKs0V2a0Az
         HOaW88GNqVTeBCy+TScB7oRWMv1rH9/exnIyaAJG/2AEk+pmNPexhLYotx+iGQxzPayN
         qMsc6zNYXlymIpMioDRrueeuU9Q6OSU+HbfZhbqgL3XJJhN8cRNcgjuhdOnOVpw2mHUp
         4Jw/6Z9Qon5Hr1wfOwCrdEPtwHXsf2kOuagJpHLAg/YaylQJ8jEPSKIf0VNbVqe7Gkpj
         7oEQ==
X-Gm-Message-State: ACrzQf2aKJTU8C0I7RKL061ToH9Xya7iw075HBVzduXxkxwT98HHWyEb
        nXMXvAXXYE30+4e+8yQ/3RGIW6EbZPUPqA==
X-Google-Smtp-Source: AMsMyM5PI8dFGSbXQd/vYi9TfqFNTgrunruofUiIdTvGhqcuOOErFVL6bRBaf8Ox/Ovh+zKR3UYfIQ==
X-Received: by 2002:a05:600c:46ce:b0:3c6:f243:8d74 with SMTP id q14-20020a05600c46ce00b003c6f2438d74mr2600379wmo.166.1666792326702;
        Wed, 26 Oct 2022 06:52:06 -0700 (PDT)
Received: from usaari01.cust.communityfibre.co.uk ([2a02:6b6a:b4d7:0:e68:932d:8865:32dc])
        by smtp.gmail.com with ESMTPSA id h5-20020a05600c2ca500b003b435c41103sm2663346wmc.0.2022.10.26.06.52.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Oct 2022 06:52:06 -0700 (PDT)
From:   Usama Arif <usama.arif@bytedance.com>
To:     linux-kernel@vger.kernel.org, peterz@infradead.org,
        mingo@redhat.com, will@kernel.org, longman@redhat.com,
        yanfei.xu@windriver.com
Cc:     fam.zheng@bytedance.com, punit.agrawal@bytedance.com,
        Usama Arif <usama.arif@bytedance.com>
Subject: [PATCH] kernel/locking: Fix spelling mistake "task_strcut" -> "task_struct"
Date:   Wed, 26 Oct 2022 14:51:50 +0100
Message-Id: <20221026135150.2210119-1-usama.arif@bytedance.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

These are in mutex and rwsem code.

Signed-off-by: Usama Arif <usama.arif@bytedance.com>
---
 kernel/locking/mutex.c | 4 ++--
 kernel/locking/rwsem.c | 2 +-
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/kernel/locking/mutex.c b/kernel/locking/mutex.c
index d973fe6041bf..fe7335fb63d4 100644
--- a/kernel/locking/mutex.c
+++ b/kernel/locking/mutex.c
@@ -362,7 +362,7 @@ bool mutex_spin_on_owner(struct mutex *lock, struct task_struct *owner,
 		 * checking lock->owner still matches owner. And we already
 		 * disabled preemption which is equal to the RCU read-side
 		 * crital section in optimistic spinning code. Thus the
-		 * task_strcut structure won't go away during the spinning
+		 * task_struct structure won't go away during the spinning
 		 * period
 		 */
 		barrier();
@@ -401,7 +401,7 @@ static inline int mutex_can_spin_on_owner(struct mutex *lock)
 
 	/*
 	 * We already disabled preemption which is equal to the RCU read-side
-	 * crital section in optimistic spinning code. Thus the task_strcut
+	 * crital section in optimistic spinning code. Thus the task_struct
 	 * structure won't go away during the spinning period.
 	 */
 	owner = __mutex_owner(lock);
diff --git a/kernel/locking/rwsem.c b/kernel/locking/rwsem.c
index 44873594de03..bb87d28c011c 100644
--- a/kernel/locking/rwsem.c
+++ b/kernel/locking/rwsem.c
@@ -720,7 +720,7 @@ static inline bool rwsem_can_spin_on_owner(struct rw_semaphore *sem)
 	preempt_disable();
 	/*
 	 * Disable preemption is equal to the RCU read-side crital section,
-	 * thus the task_strcut structure won't go away.
+	 * thus the task_struct structure won't go away.
 	 */
 	owner = rwsem_owner_flags(sem, &flags);
 	/*
-- 
2.25.1

