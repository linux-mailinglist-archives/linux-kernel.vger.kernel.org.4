Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 691CD6D64F0
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Apr 2023 16:13:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234988AbjDDONm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Apr 2023 10:13:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37498 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235288AbjDDONe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Apr 2023 10:13:34 -0400
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com [IPv6:2a00:1450:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F5F959DD;
        Tue,  4 Apr 2023 07:13:07 -0700 (PDT)
Received: by mail-ed1-x52e.google.com with SMTP id ek18so131233760edb.6;
        Tue, 04 Apr 2023 07:13:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1680617582;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=VTf+eU3IRV+Sphtq82p4YOMBPIDqspmHlL+a/rS01rw=;
        b=FUyIIu1ehoMVwlmnUlZfefaB0NBjwxUqAhqcpAUmL9k72pAMdvyK4R1ibdsXWyEuKK
         emUcl/wUKJgQueLU1rUliinyFoegFy1HeG+3Wm6i9mMaXevjkA4s86HBjFjXA1XUa41k
         CJFZ5+uOh7DSj6K+mtYmqUrBq8z7+sFYay1XPXbJPJ7aZWusZ470+O6M8wjLy+z2Tva4
         Qz9k92Gg3btJ+rnJx/jfOMKldR2q02ciXv+DbTliGEx2eCOhHaOjQGsy2JIbnAGbVY6K
         EYV2XeNULwnyOHGgzrwaluafD5zAlnR68hXrHbscHO4f7uMXe6LLCk0ypuTQ83M7kUyj
         d5KA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680617582;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=VTf+eU3IRV+Sphtq82p4YOMBPIDqspmHlL+a/rS01rw=;
        b=Gat9C9IgfCR+0TGbe+dIIY2nIjNokQrUbXyO4CIdwlO7NAX8sftfm78/vg61OgU0KF
         2l5j8ZV8AYKem/WrqXZuG91O+NCzo41SOHzAaD+MHnReBYmmf8vtgSeT5zdtobGv6wne
         MmVFaT1PFN+wbNoxnvhmRfsOeKKVwDWCgWcM0NNYJ01Uc9A1FVripZWKwZpLXnTsA9Uj
         cZST+CG0gXymoe2t1p4wV9nkEhSZMB5OsvnbMptCjiKGH3uviYp82tPnxz3ESQk9xuww
         McT7ZVDdwIbfHUoH/2v1+6StnGriy3fdnulVB799/YQdtgnZTJ6QDbAKZg6++OjJIcoN
         j9vw==
X-Gm-Message-State: AAQBX9diM1455oAojtLyZ4cVppGOjtXlLTm/1X7ldQx0dfCN/fEhNmtN
        na+joojmnaLLy+vrzQ/EkSU=
X-Google-Smtp-Source: AKy350YSifQSYTSIMHqFtvM00FEIN9VOV4WlNCC18l29StGoVjUcCw4hF/CD/QanT8LmzeSO4BzWKA==
X-Received: by 2002:a17:906:1451:b0:931:8e8c:2db5 with SMTP id q17-20020a170906145100b009318e8c2db5mr2324856ejc.69.1680617582424;
        Tue, 04 Apr 2023 07:13:02 -0700 (PDT)
Received: from pc638.lan ([155.137.26.201])
        by smtp.gmail.com with ESMTPSA id um4-20020a170906cf8400b00928e0ea53e5sm5997607ejb.84.2023.04.04.07.13.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Apr 2023 07:13:02 -0700 (PDT)
From:   "Uladzislau Rezki (Sony)" <urezki@gmail.com>
To:     "Paul E . McKenney" <paulmck@kernel.org>
Cc:     RCU <rcu@vger.kernel.org>, quic_neeraju@quicinc.com,
        Boqun Feng <boqun.feng@gmail.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Uladzislau Rezki <urezki@gmail.com>,
        Oleksiy Avramchenko <oleksiy.avramchenko@sony.com>,
        Frederic Weisbecker <frederic@kernel.org>
Subject: [PATCH 1/1] rcu/kvfree: Add debug check of GP ready for ptrs in a list
Date:   Tue,  4 Apr 2023 16:13:00 +0200
Message-Id: <20230404141300.908202-1-urezki@gmail.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Triiger a warning if a grace period is not passed yet for
objects queued on a linked list via rcu_head structures.

Once detached, take a full snapsot of GP sequnces to check
later that a grace period is passed and it is safe to free
all pointers.

Based on latest 'dev' branch.

Signed-off-by: Uladzislau Rezki (Sony) <urezki@gmail.com>
---
 kernel/rcu/tree.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
index 4838a55da34f..35be35f8236b 100644
--- a/kernel/rcu/tree.c
+++ b/kernel/rcu/tree.c
@@ -2802,6 +2802,7 @@ struct kvfree_rcu_bulk_data {
 struct kfree_rcu_cpu_work {
 	struct rcu_work rcu_work;
 	struct rcu_head *head_free;
+	struct rcu_gp_oldstate head_free_gp_snap;
 	struct list_head bulk_head_free[FREE_N_CHANNELS];
 	struct kfree_rcu_cpu *krcp;
 };
@@ -3007,6 +3008,7 @@ static void kfree_rcu_work(struct work_struct *work)
 	struct rcu_head *head;
 	struct kfree_rcu_cpu *krcp;
 	struct kfree_rcu_cpu_work *krwp;
+	struct rcu_gp_oldstate head_gp_snap;
 	int i;
 
 	krwp = container_of(to_rcu_work(work),
@@ -3021,6 +3023,7 @@ static void kfree_rcu_work(struct work_struct *work)
 	// Channel 3.
 	head = krwp->head_free;
 	krwp->head_free = NULL;
+	head_gp_snap = krwp->head_free_gp_snap;
 	raw_spin_unlock_irqrestore(&krcp->lock, flags);
 
 	// Handle the first two channels.
@@ -3037,7 +3040,8 @@ static void kfree_rcu_work(struct work_struct *work)
 	 * queued on a linked list through their rcu_head structures.
 	 * This list is named "Channel 3".
 	 */
-	kvfree_rcu_list(head);
+	if (head && !WARN_ON_ONCE(!poll_state_synchronize_rcu_full(&head_gp_snap)))
+		kvfree_rcu_list(head);
 }
 
 static bool
@@ -3169,6 +3173,7 @@ static void kfree_rcu_monitor(struct work_struct *work)
 			// objects queued on the linked list.
 			if (!krwp->head_free) {
 				krwp->head_free = krcp->head;
+				get_state_synchronize_rcu_full(&krwp->head_free_gp_snap);
 				atomic_set(&krcp->head_count, 0);
 				WRITE_ONCE(krcp->head, NULL);
 			}
-- 
2.30.2

