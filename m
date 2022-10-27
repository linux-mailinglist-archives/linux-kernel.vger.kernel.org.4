Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5425660F208
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Oct 2022 10:16:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234867AbiJ0IQo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Oct 2022 04:16:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58790 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233187AbiJ0IQm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Oct 2022 04:16:42 -0400
Received: from mail-pl1-x62e.google.com (mail-pl1-x62e.google.com [IPv6:2607:f8b0:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2AFEC31F9C
        for <linux-kernel@vger.kernel.org>; Thu, 27 Oct 2022 01:16:40 -0700 (PDT)
Received: by mail-pl1-x62e.google.com with SMTP id n7so698577plp.1
        for <linux-kernel@vger.kernel.org>; Thu, 27 Oct 2022 01:16:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=kGQVxG2SU95XA9M7f0IhXRn42lf+Qr3tm/YzKnG6hUc=;
        b=aiJWnRGbv2p+GLTzTdckX1EybobOwf4N9yfGhVZmM3o/rzjeyHxSQ8OfCCf2MlOb7Y
         ep1xtYsiIPSdK7nOW+W+JK4EQ5uhmxcXT7TblAfNN8oouZzqH8pvyCNNQhNolPM0yiZ9
         dqs3zMSoYB2hREDOFY5362dSTEBUsPcVAInkLe0PVnDz5JuGPLFvvmz7/gHDL+FRg9hi
         ErOZVE2XSjZx1BBpWJ+/nKCC6b5GohK28UbcbsffW0Qub85pGDEzji8Cx6OjvD/Am6kf
         ZqYaIbr/yzPxIAW53LtbdPmHJMjI7b3jPFBLSDHbPfLwhNERCU1gnrVmPwy5fVB/M6Uy
         sJPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=kGQVxG2SU95XA9M7f0IhXRn42lf+Qr3tm/YzKnG6hUc=;
        b=X4mx0Ov+CrWeE+wsqnII4KgfhnJ2/cwo3ehOiFkzZ+TqfugIQXEiZqyNmrFLs4xEOV
         hnsC1PY13JJAo0GoroZyZNSYND14XAOswizI7jzBO0N49AEt1mQknmkjND5NkcttIkH4
         uCkn0yZ+NUQ3xoXF9RnSeCC2MQgoybXJob2v87zIkRFoU4lW7Y4r5A2MZa8p6Y3QtVIV
         YUuNJhK+LgTWa5zEZiO632mPHH3+CUz1Sp1TrZwUvsQqon6PRiLOjC0NEkfZ1+eqYaSJ
         EOyvbWctCwVB0VquoRB9/2cjBEZbcraCFv8kVdkGwWKBcjEGWbAuPrqmg+jU8B1BsBF1
         oaAA==
X-Gm-Message-State: ACrzQf1rO7eooaqQMljGjYxuRYm9+y4H6HvuRph5C9AyWgGNRv8GPF1s
        JyyF9W+mpcXJwAcEjLS2RtGowQ==
X-Google-Smtp-Source: AMsMyM7At92WPZo/4KMNfDuck2RPQ94GOJyzQ7Yekm8aJYRbDk1PrhtLFWNol83rKPglpiXPDVrVQQ==
X-Received: by 2002:a17:902:e5c6:b0:185:4bbd:17ce with SMTP id u6-20020a170902e5c600b001854bbd17cemr49174140plf.132.1666858600265;
        Thu, 27 Oct 2022 01:16:40 -0700 (PDT)
Received: from YGFVJ29LDD.bytedance.net ([139.177.225.225])
        by smtp.gmail.com with ESMTPSA id w72-20020a62824b000000b00560e5da42d5sm632972pfd.201.2022.10.27.01.16.36
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Thu, 27 Oct 2022 01:16:39 -0700 (PDT)
From:   Chuyi Zhou <zhouchuyi@bytedance.com>
To:     peterz@infradead.org, juri.lelli@redhat.com, mingo@redhat.com,
        vincent.guittot@linaro.org
Cc:     linux-kernel@vger.kernel.org, joshdon@google.com,
        Chuyi Zhou <zhouchuyi@bytedance.com>
Subject: [PATCH] sched/fair: favor non-idle group in tick preemption
Date:   Thu, 27 Oct 2022 16:16:30 +0800
Message-Id: <20221027081630.34081-1-zhouchuyi@bytedance.com>
X-Mailer: git-send-email 2.37.0 (Apple Git-136)
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

The non-idle se dominates competition vs the idle se when they
are belong to the same group. We ensure that idle groups would not
preempt non-idle group in wakeup preemption(see check_preempt_wakeup()).
However, this can happen in tick preemption, since check_preempt_tick()
dose not check current/se is idle or not. This patch adds this check.

Signed-off-by: Chuyi Zhou <zhouchuyi@bytedance.com>
---
 kernel/sched/fair.c | 12 +++++++++++-
 1 file changed, 11 insertions(+), 1 deletion(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index e4a0b8bd941c..f3324b8753b3 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -4750,6 +4750,7 @@ static void
 check_preempt_tick(struct cfs_rq *cfs_rq, struct sched_entity *curr)
 {
 	unsigned long ideal_runtime, delta_exec;
+	int cse_is_idle, pse_is_idle;
 	struct sched_entity *se;
 	s64 delta;
 
@@ -4779,8 +4780,17 @@ check_preempt_tick(struct cfs_rq *cfs_rq, struct sched_entity *curr)
 	if (delta < 0)
 		return;
 
-	if (delta > ideal_runtime)
+	if (delta > ideal_runtime) {
+		/*
+		 * Favor non-idle group even in tick preemption
+		 */
+		cse_is_idle = se_is_idle(curr);
+		pse_is_idle = se_is_idle(se);
+		if (unlikely(!cse_is_idle && pse_is_idle))
+			return;
+
 		resched_curr(rq_of(cfs_rq));
+	}
 }
 
 static void
-- 
2.20.1

