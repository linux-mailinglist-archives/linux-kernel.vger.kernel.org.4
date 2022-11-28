Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C05E963ACB9
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Nov 2022 16:37:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230301AbiK1Pgt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Nov 2022 10:36:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45970 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231831AbiK1Pgk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Nov 2022 10:36:40 -0500
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com [IPv6:2a00:1450:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3FA956401;
        Mon, 28 Nov 2022 07:36:39 -0800 (PST)
Received: by mail-ej1-x634.google.com with SMTP id b2so10510254eja.7;
        Mon, 28 Nov 2022 07:36:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PYAf4AreYmBz18/KfqMmrHVf4hGjWL0YCDiLtGAMv0s=;
        b=mfDZ7ItZ68Bhn5AV8lrSCkJllKWouwxPIw6iNq2Wg/0TZ/2bHggLAeoGlAy17VBLRH
         VKXBRlw//0RShxjde2qbiVEcm7Uc/BJE5kD5ijRqSqtOutCplNRgE3hoLl4L/avhUvXZ
         jcLbJ1vzxt5sAyaRERPmtwCikp22ww7FU+OjtsU9PdGjYJMTSpr5SIJgSqvaJelZrO8e
         d+D81DQAcypKxtwfRZOSDEGybSIWg76umwmOF2SDGCOsTzEv1OEwKEztWOX9MXypUrtv
         uNaXLz5zU3nJqWA26AdNiZyCsmUzdEBQk5S6jjmeWCFdr0FO1U1pu7vxF4Dc8/0x9joo
         b04w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PYAf4AreYmBz18/KfqMmrHVf4hGjWL0YCDiLtGAMv0s=;
        b=KKhP41p2cwrGyyugscMEkesG5cI8u0GmDccLPp+3kIZ21HNfpopQfqBYWrnLF4tSvE
         VDLuFEFt3/TzSkHPTjMWUn/p+KLLCPDJsGPRmG5Csz2n6EQyRyZdUCRGFmln1eo7LCTB
         qELzA9kz4opmUIt/sbjRdMF1KmUqGZWlpwN3Sjlg8KeX+EjK0rraTdIfmdAWzKzxDht0
         ayMw/38+YZgVkun89A6tdfU0GqE5Y0SAVoiJnGPm83hooNo+sCHIY9YsY7Lm+ouHmBYJ
         gr3FHGks0EhAudMhNLlAj/xRsOXlvpD3mRL2VGYLXMFyU/NTthCcwQx1oa15OiiZVfyE
         0QlA==
X-Gm-Message-State: ANoB5pl5hx9icjV/f6/Nb5g03AeNCxLCQkLCET0MjWHh1TpEboyBCeFo
        RSkmiWqvkjUEnwiH0UMFUvAjrnFBLiE=
X-Google-Smtp-Source: AA0mqf7p1/h5TyUOHLoAIREZ4AyYDmPJmuPeIP6YBV/w1uwc8SF1hqN2z+fm2RfO5m9ZgiCf3ACSqA==
X-Received: by 2002:a17:907:b014:b0:7b4:86be:f3e3 with SMTP id fu20-20020a170907b01400b007b486bef3e3mr36893738ejc.741.1669649797675;
        Mon, 28 Nov 2022 07:36:37 -0800 (PST)
Received: from pc638.lan ([155.137.26.201])
        by smtp.gmail.com with ESMTPSA id m7-20020aa7d347000000b00459ad800bbcsm5303306edr.33.2022.11.28.07.36.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Nov 2022 07:36:37 -0800 (PST)
From:   "Uladzislau Rezki (Sony)" <urezki@gmail.com>
To:     LKML <linux-kernel@vger.kernel.org>, RCU <rcu@vger.kernel.org>,
        "Paul E . McKenney" <paulmck@kernel.org>
Cc:     Frederic Weisbecker <frederic@kernel.org>,
        Neeraj Upadhyay <neeraj.iitr10@gmail.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        Uladzislau Rezki <urezki@gmail.com>,
        Oleksiy Avramchenko <oleksiy.avramchenko@sony.com>
Subject: [PATCH 3/4] rcu/kvfree: Move need_offload_krc() out of krcp->lock
Date:   Mon, 28 Nov 2022 16:36:27 +0100
Message-Id: <20221128153628.541361-3-urezki@gmail.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20221128153628.541361-1-urezki@gmail.com>
References: <20221128153628.541361-1-urezki@gmail.com>
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
index 3b5f6036d884..f68ddbef2a33 100644
--- a/kernel/rcu/tree.c
+++ b/kernel/rcu/tree.c
@@ -3218,7 +3218,7 @@ static void kfree_rcu_monitor(struct work_struct *work)
 			// objects queued on the linked list.
 			if (!krwp->head_free) {
 				krwp->head_free = krcp->head;
-				krcp->head = NULL;
+				WRITE_ONCE(krcp->head, NULL);
 			}
 
 			WRITE_ONCE(krcp->count, 0);
@@ -3232,6 +3232,8 @@ static void kfree_rcu_monitor(struct work_struct *work)
 		}
 	}
 
+	raw_spin_unlock_irqrestore(&krcp->lock, flags);
+
 	// If there is nothing to detach, it means that our job is
 	// successfully done here. In case of having at least one
 	// of the channels that is still busy we should rearm the
@@ -3239,8 +3241,6 @@ static void kfree_rcu_monitor(struct work_struct *work)
 	// still in progress.
 	if (need_offload_krc(krcp))
 		schedule_delayed_monitor_work(krcp);
-
-	raw_spin_unlock_irqrestore(&krcp->lock, flags);
 }
 
 static enum hrtimer_restart
@@ -3415,7 +3415,7 @@ void kvfree_call_rcu(struct rcu_head *head, rcu_callback_t func)
 
 		head->func = func;
 		head->next = krcp->head;
-		krcp->head = head;
+		WRITE_ONCE(krcp->head, head);
 		success = true;
 	}
 
@@ -3492,15 +3492,12 @@ static struct shrinker kfree_rcu_shrinker = {
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

