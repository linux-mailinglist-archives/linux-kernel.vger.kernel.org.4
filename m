Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 57D1F5FBED5
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Oct 2022 03:26:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229552AbiJLB0j (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Oct 2022 21:26:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41392 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229475AbiJLB0g (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Oct 2022 21:26:36 -0400
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com [IPv6:2607:f8b0:4864:20::102d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 74A537CA8A
        for <linux-kernel@vger.kernel.org>; Tue, 11 Oct 2022 18:26:35 -0700 (PDT)
Received: by mail-pj1-x102d.google.com with SMTP id l1-20020a17090a72c100b0020a6949a66aso616008pjk.1
        for <linux-kernel@vger.kernel.org>; Tue, 11 Oct 2022 18:26:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=gkd9XBHmDc8P5oMwLkkVjjvhRyTNJme+jUAZIXRgEJk=;
        b=pvEnxpQ93a1QfUyfCqNuYcf7pGe7vriOD2hfNWDfcxcfys9iElZne002jPTC9Upzbb
         gmI4IXs5gw+zT6EUaFdIE6qhD/z/aptcXcNqG+KACp+113Ylf7Oe5ry8bM2V65lgDt/i
         BhTZGhssmja83zmUy+WzF5+AsEE/vhicHou50icax9+5qyrqn87xZB5YOsJZGofXwtvz
         BbLeWPTXj4hb1oRyiWv+9HbRQbxUJqR6BONvnZu44IczNLVGtMFFlEQLPFNEJgV0wU2u
         BdZgxkpDJo8SiRb+wVv3oPklDncB9R3ctbGxDwulSOHnUPchxlJnZhShvRSD6I30fxhe
         eSNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=gkd9XBHmDc8P5oMwLkkVjjvhRyTNJme+jUAZIXRgEJk=;
        b=P0EnZR4Bb8jPAUr4XtghZzcnzh3kn+qP+ktXKtSAuJSIfZ2VGXRCTfPlzhQ03SpNlo
         uAiIWSUZN1NMRNlP1dcW8b014fd25xIF1/S1fr8e/0i5BEDV10YZzZwqK84PpQ1FUmQO
         XofcyGVkueaHgU9MnlKEEQo4nDFJ/eQnk25YpvlR0fYKTR4TMu7F7rq1lpyUXQ1+FptI
         7g5P8EkUfyQ18adbNAwa3OkYZtQX/PmrpbSkI4MJET8kxWO3oaHPnwP5YqPt74VH4DM8
         E1rwOjq8wAkqOlZXK4lL5ZTZOfNBKRjVs8H5sSTcQxzanEkificMyZFIid6XHOTMJWGW
         oUzA==
X-Gm-Message-State: ACrzQf3ylSuX0GPWzY9WOVYN7Qd036BaoZjcQL0PJOsIEm/Xn7nT3Fss
        cC+J8G83rLA37rjelMUwAo4=
X-Google-Smtp-Source: AMsMyM66JaVCcu0pBBInxzuZG9cTYwWG9ih6vCZesjhdJ9YsuzmM3c4lKa4xnm+0hHrzZffZnqD7AA==
X-Received: by 2002:a17:90b:3a88:b0:209:f35d:ad53 with SMTP id om8-20020a17090b3a8800b00209f35dad53mr2279060pjb.102.1665537994832;
        Tue, 11 Oct 2022 18:26:34 -0700 (PDT)
Received: from localhost.localdomain ([193.203.214.57])
        by smtp.gmail.com with ESMTPSA id t5-20020a170902d14500b00176e2fa216csm5433177plt.52.2022.10.11.18.26.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Oct 2022 18:26:34 -0700 (PDT)
From:   yexingchen116@gmail.com
X-Google-Original-From: ye.xingchen@zte.com.cn
To:     jstultz@google.com
Cc:     tglx@linutronix.de, sboyd@kernel.org, linux-kernel@vger.kernel.org,
        ye xingchen <ye.xingchen@zte.com.cn>
Subject: [PATCH linux-next v2] timers: replace in_irq() with
Date:   Wed, 12 Oct 2022 01:26:29 +0000
Message-Id: <20221012012629.334966-1-ye.xingchen@zte.com.cn>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: ye xingchen <ye.xingchen@zte.com.cn>

Replace the obsolete and ambiguos macro in_irq() with new
macro in_hardirq().

Signed-off-by: ye xingchen <ye.xingchen@zte.com.cn>
---
v1 -> v2
Replace both instances of in_irq() in the flie.
 kernel/time/timer.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/kernel/time/timer.c b/kernel/time/timer.c
index 717fcb9fb14a..8872670a285e 100644
--- a/kernel/time/timer.c
+++ b/kernel/time/timer.c
@@ -1422,7 +1422,7 @@ int del_timer_sync(struct timer_list *timer)
 	 * don't use it in hardirq context, because it
 	 * could lead to deadlock.
 	 */
-	WARN_ON(in_irq() && !(timer->flags & TIMER_IRQSAFE));
+	WARN_ON(in_hardirq() && !(timer->flags & TIMER_IRQSAFE));
 
 	/*
 	 * Must be able to sleep on PREEMPT_RT because of the slowpath
 	 * in
@@ -1838,7 +1838,7 @@ void update_process_times(int user_tick)
 	run_local_timers();
 	rcu_sched_clock_irq(user_tick);
 #ifdef CONFIG_IRQ_WORK
-	if (in_irq())
+	if (in_hardirq())
 		irq_work_tick();
 #endif
 	scheduler_tick();
-- 
2.25.1

