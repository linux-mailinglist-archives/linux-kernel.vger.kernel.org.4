Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CD3E463C47A
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Nov 2022 17:00:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236098AbiK2QAa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Nov 2022 11:00:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56682 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236048AbiK2QAC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Nov 2022 11:00:02 -0500
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com [IPv6:2a00:1450:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC4006B382;
        Tue, 29 Nov 2022 07:58:34 -0800 (PST)
Received: by mail-ed1-x52c.google.com with SMTP id z18so20355705edb.9;
        Tue, 29 Nov 2022 07:58:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wwJd7Mk1dtDP8oA/uY5amNur5qX6Eol7WXl6WKlAauE=;
        b=k7RDxpOVxxxBPJk5dkKGuhSlo5tyM17cWxhDRGCU4C1nv6x2VtSEAFOh7fX1K4hCLT
         l00Um8+IvJAaXR9p74nItgVGO50H1//Ts0PgIX7x2k4lxh/BOozzmQor/EvSD1XgLdB2
         J7lGF8qFRK0ifGwxqi03WcZxR+kSCHnuGudnBwfp4O1++Iz5MX3KKQFcYfkKT3KOnUoe
         ZX5GOhj28nEzy8WT/tCSe53jTmR4SDG64Tdwing+Xg4JLzAtzpaeQ/FN8HHYhf3+XNWu
         xh5bHNUGi0N+Ay+ezM+adL6IpXD+IIi4DUs6A+cbaIflfBcL/j9BULh9dZs+/xWfHyq2
         ZwVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wwJd7Mk1dtDP8oA/uY5amNur5qX6Eol7WXl6WKlAauE=;
        b=mPBOMUsUFC6Mj7h3V9/d0DyKF1cDMEcPG7ITyDGarV/Z+oh88vh8yCsP0gw2WhSdS+
         h7M+EBCie4NNwl+d5wTqhEoJkEzrv06O3rHkE35R3d+sJ7av/ixehe3fHvA2iyfZmWvO
         Gdj1XxipP3Y3HChDlwf15Cx5/jFTi0ty1OzcHjSI76HQSNvyNW887G0R1QgdRmpl35i7
         Ih1eMv0PYE3fPe/M5iQjxUKrylp6MU3igOdtD0FmMWxo1aJ4DZ+tVGchUD0HLgTp9c5m
         9xSpRV3cTRAQzIMR8pY18it73kv53LiDor4wwgARPVDg4PgiGaJlOSPwerC1Fktdl52k
         V7Qg==
X-Gm-Message-State: ANoB5pmJDKlCt7s9f1s4f9/6v7S1nYish+p01jDT3laskwYlhGBKyIxZ
        W3w/bTYha7cWEvF6pTL1fSzYQ4cV1sM=
X-Google-Smtp-Source: AA0mqf4KQl8YIbCcZx4IUitW1+3MkDtFffsuSZAbcvafldGa6CRyYSeYLQuLMnQuqghBwO9y5RbkBQ==
X-Received: by 2002:a05:6402:401:b0:461:5b2f:2d8f with SMTP id q1-20020a056402040100b004615b2f2d8fmr39012524edv.348.1669737512927;
        Tue, 29 Nov 2022 07:58:32 -0800 (PST)
Received: from pc638.lan ([155.137.26.201])
        by smtp.gmail.com with ESMTPSA id u23-20020a056402065700b0046778ce5fdfsm6371059edx.10.2022.11.29.07.58.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Nov 2022 07:58:32 -0800 (PST)
From:   "Uladzislau Rezki (Sony)" <urezki@gmail.com>
To:     LKML <linux-kernel@vger.kernel.org>, RCU <rcu@vger.kernel.org>,
        "Paul E . McKenney" <paulmck@kernel.org>
Cc:     Frederic Weisbecker <frederic@kernel.org>,
        Neeraj Upadhyay <neeraj.iitr10@gmail.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        Uladzislau Rezki <urezki@gmail.com>,
        Oleksiy Avramchenko <oleksiy.avramchenko@sony.com>
Subject: [PATCH v2 3/4] rcu/kvfree: Move need_offload_krc() out of krcp->lock
Date:   Tue, 29 Nov 2022 16:58:21 +0100
Message-Id: <20221129155822.538434-4-urezki@gmail.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20221129155822.538434-1-urezki@gmail.com>
References: <20221129155822.538434-1-urezki@gmail.com>
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

Currently a need_offload_krc() function requires the krcp->lock
to be held because krcp->head can not be checked concurrently.

Fix it by updating the krcp->head using WRITE_ONCE() macro so
it becomes lock-free and safe for readers to see a valid data
without any locking.

Signed-off-by: Uladzislau Rezki (Sony) <urezki@gmail.com>
---
 kernel/rcu/tree.c | 11 ++++-------
 1 file changed, 4 insertions(+), 7 deletions(-)

diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
index 445f8c11a9a3..c94c17194299 100644
--- a/kernel/rcu/tree.c
+++ b/kernel/rcu/tree.c
@@ -3058,7 +3058,7 @@ static void kfree_rcu_monitor(struct work_struct *work)
 			// objects queued on the linked list.
 			if (!krwp->head_free) {
 				krwp->head_free = krcp->head;
-				krcp->head = NULL;
+				WRITE_ONCE(krcp->head, NULL);
 			}
 
 			WRITE_ONCE(krcp->count, 0);
@@ -3072,6 +3072,8 @@ static void kfree_rcu_monitor(struct work_struct *work)
 		}
 	}
 
+	raw_spin_unlock_irqrestore(&krcp->lock, flags);
+
 	// If there is nothing to detach, it means that our job is
 	// successfully done here. In case of having at least one
 	// of the channels that is still busy we should rearm the
@@ -3079,8 +3081,6 @@ static void kfree_rcu_monitor(struct work_struct *work)
 	// still in progress.
 	if (need_offload_krc(krcp))
 		schedule_delayed_monitor_work(krcp);
-
-	raw_spin_unlock_irqrestore(&krcp->lock, flags);
 }
 
 static enum hrtimer_restart
@@ -3250,7 +3250,7 @@ void kvfree_call_rcu(struct rcu_head *head, void *ptr)
 
 		head->func = ptr;
 		head->next = krcp->head;
-		krcp->head = head;
+		WRITE_ONCE(krcp->head, head);
 		success = true;
 	}
 
@@ -3327,15 +3327,12 @@ static struct shrinker kfree_rcu_shrinker = {
 void __init kfree_rcu_scheduler_running(void)
 {
 	int cpu;
-	unsigned long flags;
 
 	for_each_possible_cpu(cpu) {
 		struct kfree_rcu_cpu *krcp = per_cpu_ptr(&krc, cpu);
 
-		raw_spin_lock_irqsave(&krcp->lock, flags);
 		if (need_offload_krc(krcp))
 			schedule_delayed_monitor_work(krcp);
-		raw_spin_unlock_irqrestore(&krcp->lock, flags);
 	}
 }
 
-- 
2.30.2

