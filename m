Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A57186FF96D
	for <lists+linux-kernel@lfdr.de>; Thu, 11 May 2023 20:20:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239237AbjEKSUH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 May 2023 14:20:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44002 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239210AbjEKSTs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 May 2023 14:19:48 -0400
Received: from mail-pg1-x532.google.com (mail-pg1-x532.google.com [IPv6:2607:f8b0:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A0AF9EC8
        for <linux-kernel@vger.kernel.org>; Thu, 11 May 2023 11:19:47 -0700 (PDT)
Received: by mail-pg1-x532.google.com with SMTP id 41be03b00d2f7-52cb78647ecso5164941a12.1
        for <linux-kernel@vger.kernel.org>; Thu, 11 May 2023 11:19:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1683829186; x=1686421186;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QEMIUUrhmTXrgN4icuTRdubFtkqVCDLnAwLOvCI/lRk=;
        b=BLt5ctJ1/mYsPAopbjovnpqCSOrx7+cc+Lbw+7VmmGUEo+5zlzaj9lY/7hR76f3Kn9
         K4BENr45d+xLKIz1ccc0Hdci3olB+MqAJXPJ4Kw9/cqic567IFu5mcyLFDrGCGZE5PET
         3E7OQZ6/M+DRmSFcoKRMLydyC2bWh5aYIlGemZYC9daNdDoMtfQ3EoiwJUdic3WCBHbo
         J7WiKXBSeAVjpASjFN4jD/MGOpENryd6YSK+kn+J4bMlw9VI/jF0hll4yIgQ4aMqCu3L
         JO6Rix14pdCLccIDNrSsjFEJqGBS/+nAOruuP2ozwGhjQpydDHzvwadN1J9MM5jF2Lbf
         OjGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683829186; x=1686421186;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=QEMIUUrhmTXrgN4icuTRdubFtkqVCDLnAwLOvCI/lRk=;
        b=he36WBHWrywjci875O7DE/L8PVqc/gBqmCyuV7GxLqGqaIihRtAZvKbsmlLZfSWlWn
         HKKR0bO9t8/yhvJVIvs467LWoJCXNwzcR4hkA8rIoGMaqi8CqHwoWGQQdtVZ0VDtbxhQ
         ++WRtWkFVeoyeM6T0WN6mkghpYcDgpIJaCh/e14GTaEGfA2Yh/a57XvqYxnHx9FyzJ2Z
         kT0gkzzW7Mo/jbgXGjKCLvmAGGaTEUwhXQfPJ+KZ8K8YInKLgbS3DLxy0nudtBg6lFpJ
         vrrNAEIhvP8WP5FB03l7p7SDZS1YteAVmyTFbbOujKJCziOgPq2WuOW15SebSnZnM/xN
         mpqw==
X-Gm-Message-State: AC+VfDwgIUuZD82ci0TZMgYDZYC+yAPIPsmtE59ryldXQOL2VQK9uTGz
        elXzw58M+pImQdT/ODkqSSs=
X-Google-Smtp-Source: ACHHUZ6bCWU2vHfwCkLlr8Ww3fJ0xZBSshrwu6V5ONlnahzRt0YHl742kT0Qyt5gbwTbxFrD97rbQw==
X-Received: by 2002:a17:902:d2c4:b0:1ac:71a7:a1fb with SMTP id n4-20020a170902d2c400b001ac71a7a1fbmr21200516plc.18.1683829186432;
        Thu, 11 May 2023 11:19:46 -0700 (PDT)
Received: from localhost (2603-800c-1a02-1bae-a7fa-157f-969a-4cde.res6.spectrum.com. [2603:800c:1a02:1bae:a7fa:157f:969a:4cde])
        by smtp.gmail.com with ESMTPSA id p4-20020a170902e74400b001aafe56ea70sm6275199plf.5.2023.05.11.11.19.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 May 2023 11:19:45 -0700 (PDT)
Sender: Tejun Heo <htejun@gmail.com>
From:   Tejun Heo <tj@kernel.org>
To:     jiangshanlai@gmail.com
Cc:     torvalds@linux-foundation.org, peterz@infradead.org,
        linux-kernel@vger.kernel.org, kernel-team@meta.com,
        Tejun Heo <tj@kernel.org>
Subject: [PATCH 4/7] workqueue: Improve locking rule description for worker fields
Date:   Thu, 11 May 2023 08:19:28 -1000
Message-Id: <20230511181931.869812-5-tj@kernel.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230511181931.869812-1-tj@kernel.org>
References: <20230511181931.869812-1-tj@kernel.org>
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

* Some worker fields are modified only by the worker itself while holding
  pool->lock thus making them safe to read from self, IRQ context if the CPU
  is running the worker or while holding pool->lock. Add 'K' locking rule
  for them.

* worker->sleeping is currently marked "None" which isn't very descriptive.
  It's used only by the worker itself. Add 'S' locking rule for it.

A future patch will depend on the 'K' rule to access worker->current_* from
the scheduler ticks.

Signed-off-by: Tejun Heo <tj@kernel.org>
---
 kernel/workqueue.c          |  6 ++++++
 kernel/workqueue_internal.h | 15 ++++++++-------
 2 files changed, 14 insertions(+), 7 deletions(-)

diff --git a/kernel/workqueue.c b/kernel/workqueue.c
index 452bcb49192a..d6bfac871965 100644
--- a/kernel/workqueue.c
+++ b/kernel/workqueue.c
@@ -126,6 +126,12 @@ enum {
  *    cpu or grabbing pool->lock is enough for read access.  If
  *    POOL_DISASSOCIATED is set, it's identical to L.
  *
+ * K: Only modified by worker while holding pool->lock. Can be safely read by
+ *    self, while holding pool->lock or from IRQ context if %current is the
+ *    kworker.
+ *
+ * S: Only modified by worker self.
+ *
  * A: wq_pool_attach_mutex protected.
  *
  * PL: wq_pool_mutex protected.
diff --git a/kernel/workqueue_internal.h b/kernel/workqueue_internal.h
index 0600f04ceeb2..c2455be7b4c2 100644
--- a/kernel/workqueue_internal.h
+++ b/kernel/workqueue_internal.h
@@ -28,14 +28,15 @@ struct worker {
 		struct hlist_node	hentry;	/* L: while busy */
 	};
 
-	struct work_struct	*current_work;	/* L: work being processed */
-	work_func_t		current_func;	/* L: current_work's fn */
-	struct pool_workqueue	*current_pwq;	/* L: current_work's pwq */
-	unsigned int		current_color;	/* L: current_work's color */
-	int			sleeping;	/* None */
+	struct work_struct	*current_work;	/* K: work being processed and its */
+	work_func_t		current_func;	/* K: function */
+	struct pool_workqueue	*current_pwq;	/* K: pwq */
+	unsigned int		current_color;	/* K: color */
+
+	int			sleeping;	/* S: is worker sleeping? */
 
 	/* used by the scheduler to determine a worker's last known identity */
-	work_func_t		last_func;	/* L: last work's fn */
+	work_func_t		last_func;	/* K: last work's fn */
 
 	struct list_head	scheduled;	/* L: scheduled works */
 
@@ -45,7 +46,7 @@ struct worker {
 	struct list_head	node;		/* A: anchored at pool->workers */
 						/* A: runs through worker->node */
 
-	unsigned long		last_active;	/* L: last active timestamp */
+	unsigned long		last_active;	/* K: last active timestamp */
 	unsigned int		flags;		/* X: flags */
 	int			id;		/* I: worker id */
 
-- 
2.40.1

