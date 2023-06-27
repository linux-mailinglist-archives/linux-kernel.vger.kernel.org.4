Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9840373F486
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Jun 2023 08:29:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230365AbjF0G3D (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Jun 2023 02:29:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36400 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230360AbjF0G2r (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Jun 2023 02:28:47 -0400
Received: from mail-pl1-x636.google.com (mail-pl1-x636.google.com [IPv6:2607:f8b0:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2CB771FFF
        for <linux-kernel@vger.kernel.org>; Mon, 26 Jun 2023 23:28:46 -0700 (PDT)
Received: by mail-pl1-x636.google.com with SMTP id d9443c01a7336-1b8063aa2e1so10521835ad.1
        for <linux-kernel@vger.kernel.org>; Mon, 26 Jun 2023 23:28:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1687847325; x=1690439325;
        h=message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/No3uMDFRGop5NHj4Uit0dWC5kLwd6BWdmA86KFwVss=;
        b=oZ1dTy9QsTF25Vj6cN7VtiP6Zq/WmSPT0V+70JONVbv9m/5XkMZ6mjXPLJA8Z3sZyl
         U7VuKuAHoRDK6l3HNc6IEsi4azUzhglWwBfl9L7jcOMSJPeA//swS0DMK/ziwA+PO6Iu
         bWkHtAK4Vy+oxKBoqpv0h63cpA5OoPksTD1/012Wu/vrG0TVWk19xnpG27RUfzfykqvH
         ZXEa15Q6WNouQEltEV/Fvy408J6FbcpN4xtbE9MYjU9jw/2lSlpfy5R4AcJrijc+y5/J
         80er1QgK8sLvIe5PGtaqGTVORTk2avpGTDK6qqFV7Xc5/qMrw1Gqh+uvpyV+mPp+AC7W
         QBwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687847325; x=1690439325;
        h=message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/No3uMDFRGop5NHj4Uit0dWC5kLwd6BWdmA86KFwVss=;
        b=YPFJEjpKaI55Ib/uCwfJ6lNt/oEIJdEWEAQ1PIcIKgDy11mt0qlHoZiGUbfYnDVfs5
         iCHRMQe71QnsTLysEsCQV50QW91ZVeiiEQyng0YKWDlitsOvp//LPfrzFyIlAcob05cy
         v5PGpePe82CnZC+kciduTgCkXJgnnWFbDUOQ6/Pra1Bg6lhULdFfK+LEg4hXj7bq9Ola
         Y7OtxNUIl3wQx+GkAQe8Kyp9GqswcenZs3J2kqI7G8QoqB9c6Q1di8P5abkc3IuZyuzs
         BIivfP/PAQm3zSduH4OKW7VRFErY59s1onf9QQYPv5fKsgWyVt7k2yTFC/N/AhW/ZPbF
         Sh6w==
X-Gm-Message-State: AC+VfDx8CbvQ9fRWlLXW3QP1VCUSy7qymruP09uc6mGEBIxYDPaswNjt
        di+sdnWPiy1RematIrEwCxk=
X-Google-Smtp-Source: ACHHUZ7g637XMAtoJbXRB6S87o2VxjpHWmvVxxMrfQpBcMcRmEaLubMMSIpP32XzwyKQFk84A7x5VQ==
X-Received: by 2002:a17:902:c946:b0:1b6:7148:f65d with SMTP id i6-20020a170902c94600b001b67148f65dmr5128992pla.17.1687847325572;
        Mon, 26 Jun 2023 23:28:45 -0700 (PDT)
Received: from 377044c6c369.cse.ust.hk (191host097.mobilenet.cse.ust.hk. [143.89.191.97])
        by smtp.gmail.com with ESMTPSA id u6-20020a17090341c600b001b6a241b671sm5136610ple.271.2023.06.26.23.28.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Jun 2023 23:28:45 -0700 (PDT)
From:   Chengfeng Ye <dg573847474@gmail.com>
To:     mark@fasheh.com, jlbec@evilplan.org, joseph.qi@linux.alibaba.com
Cc:     ocfs2-devel@oss.oracle.com, linux-kernel@vger.kernel.org,
        Chengfeng Ye <dg573847474@gmail.com>
Subject: [PATCH] fs: ocfs: fix potential deadlock on &qs->qs_lock
Date:   Tue, 27 Jun 2023 06:28:31 +0000
Message-Id: <20230627062831.16553-1-dg573847474@gmail.com>
X-Mailer: git-send-email 2.17.1
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

As &qs->qs_lock is also acquired by the timer o2net_idle_timer()
which executes under softirq context, code executing under process
context should disable irq before acquiring the lock, otherwise
deadlock could happen if the process context hold the lock then
preempt by the timer.

Possible deadlock scenario:
o2quo_make_decision (workqueue)
    -> spin_lock(&qs->qs_lock);
        <timer interrupt>
        -> o2net_idle_timer
        -> o2quo_conn_err
        -> spin_lock(&qs->qs_lock); (deadlock here)

This flaw was found using an experimental static analysis tool we are
developing for irq-related deadlock.

The tentative patch fix the potential deadlock by spin_lock_irqsave().

Signed-off-by: Chengfeng Ye <dg573847474@gmail.com>
---
 fs/ocfs2/cluster/quorum.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/fs/ocfs2/cluster/quorum.c b/fs/ocfs2/cluster/quorum.c
index 189c111bc371..f14313c3e27e 100644
--- a/fs/ocfs2/cluster/quorum.c
+++ b/fs/ocfs2/cluster/quorum.c
@@ -92,8 +92,9 @@ static void o2quo_make_decision(struct work_struct *work)
 	int quorum;
 	int lowest_hb, lowest_reachable = 0, fence = 0;
 	struct o2quo_state *qs = &o2quo_state;
+	unsigned long flags;
 
-	spin_lock(&qs->qs_lock);
+	spin_lock_irqsave(&qs->qs_lock, flags);
 
 	lowest_hb = find_first_bit(qs->qs_hb_bm, O2NM_MAX_NODES);
 	if (lowest_hb != O2NM_MAX_NODES)
@@ -146,14 +147,14 @@ static void o2quo_make_decision(struct work_struct *work)
 
 out:
 	if (fence) {
-		spin_unlock(&qs->qs_lock);
+		spin_unlock_irqrestore(&qs->qs_lock, flags);
 		o2quo_fence_self();
 	} else {
 		mlog(ML_NOTICE, "not fencing this node, heartbeating: %d, "
 			"connected: %d, lowest: %d (%sreachable)\n",
 			qs->qs_heartbeating, qs->qs_connected, lowest_hb,
 			lowest_reachable ? "" : "un");
-		spin_unlock(&qs->qs_lock);
+		spin_unlock_irqrestore(&qs->qs_lock, flags);
 
 	}
 
-- 
2.17.1

