Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 090F4682D2E
	for <lists+linux-kernel@lfdr.de>; Tue, 31 Jan 2023 14:01:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231622AbjAaNBg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 Jan 2023 08:01:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36334 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231540AbjAaNBa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Jan 2023 08:01:30 -0500
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com [IPv6:2a00:1450:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5DA564E525
        for <linux-kernel@vger.kernel.org>; Tue, 31 Jan 2023 05:01:25 -0800 (PST)
Received: by mail-ej1-x630.google.com with SMTP id k4so35873865eje.1
        for <linux-kernel@vger.kernel.org>; Tue, 31 Jan 2023 05:01:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=diag.uniroma1.it; s=google;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=7gMYnSeHKqcsyPBImnOU5RDW7p64vR2ZolURuiV8JxA=;
        b=jFYcxiT7bOVUAkiqIk5UxJpSSOFPV6Ns78ObeD2X/lYdWLPg//4qValV9/JSKm9el9
         fiW9SzN2SfDFzBofAcfvZ7FRMEy6zP+/N/lX0QOWX50uE/r1oCVvgLukoug5DEX56GSY
         BWpeE0LvQVqyUJLW32XInshyTqReK1dTnIweg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=7gMYnSeHKqcsyPBImnOU5RDW7p64vR2ZolURuiV8JxA=;
        b=uEU4Rwrv8aIrAPhOkkaKFqjN9W32aSGBxKD2WjzG9i2Cv79Prr8iEX481nOjdsITNM
         fmh65ZyTLCCyNG+j4cYlSnHtjp1Gjtcfis+geVnHCl/FNXlZOq5tGuUSsCtCwm2imyaP
         9uDRu0wkUeI1cX7Yr7OmvZVgmKTxS29B+o0uaqSDL/+qZQrp8harGhUKuDv/TBrgVbG9
         Ict2+nLaF6Uj2zg4J+fRTfKqJySRh0UDBMWJEotwhzUH8ISlXq8gnfOqJVGhq9kt25tf
         v/oXVOkt/b4isBgRJ+lBRW1KTvgLrlhKmsG80mwUpqKEq8WBnNUumRU71vRxmPgK8ipI
         8Pcg==
X-Gm-Message-State: AFqh2kopYWOzOHOUnHADwBBQOS4kDV7TcPPKWxWB6qy3ojRBumpOYsuG
        9NZRIXT47pf3F5Ajc0P+pDVyOQ==
X-Google-Smtp-Source: AMrXdXv8Tl8EVS3s3so/8xhXlhWJn5A6/u1EiEI76SCc/7nRpcDN22oB/nVJQNm8T0sr3wMSoZMN+Q==
X-Received: by 2002:a17:906:25c5:b0:84d:47e3:fe49 with SMTP id n5-20020a17090625c500b0084d47e3fe49mr51991415ejb.39.1675170083763;
        Tue, 31 Jan 2023 05:01:23 -0800 (PST)
Received: from [192.168.17.2] (wolkje-127.labs.vu.nl. [130.37.198.127])
        by smtp.gmail.com with ESMTPSA id gv21-20020a170906f11500b0086dd8f20a6asm8422670ejb.77.2023.01.31.05.01.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 31 Jan 2023 05:01:23 -0800 (PST)
From:   Pietro Borrello <borrello@diag.uniroma1.it>
Date:   Tue, 31 Jan 2023 13:01:16 +0000
Subject: [PATCH v2] sched: pick_next_rt_entity(): checked list_entry
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230128-list-entry-null-check-sched-v2-1-d8e010cce91b@diag.uniroma1.it>
X-B4-Tracking: v=1; b=H4sIABwR2WMC/42OTQ6CMBCFr0K6dkh/hKAr72FYlHagE7GYthAJ4
 e4WTuDq5ZtJvvc2FjEQRnYvNhZwoUiTzyAvBTNO+wGBbGYmuVRcyAZGignQp7CCn8cRjEPzgpjD
 gla9sr2t7bVuWDZ0OiJ0QXvjDsdbx4TheHwC9vQ9a59tZpelU1jPFYs4rv8VLgIEmJviTYXIeVU
 9LOmhnD2F6a1FSYm1+77/ACQHovHmAAAA
To:     Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Valentin Schneider <vschneid@redhat.com>,
        Dmitry Adamushko <dmitry.adamushko@gmail.com>
Cc:     Cristiano Giuffrida <c.giuffrida@vu.nl>,
        "Bos, H.J." <h.j.bos@vu.nl>, Jakob Koschel <jkl820.git@gmail.com>,
        Ingo Molnar <mingo@elte.hu>, linux-kernel@vger.kernel.org,
        Pietro Borrello <borrello@diag.uniroma1.it>
X-Mailer: b4 0.11.1
X-Developer-Signature: v=1; a=ed25519-sha256; t=1675170083; l=1714;
 i=borrello@diag.uniroma1.it; s=20221223; h=from:subject:message-id;
 bh=JXMb4KYxycIr7yob7kbIo17I74pfdYCRvrPeZI4D6Is=;
 b=GlyICFn4R9dN1ziaNTtDtK0FhGOH1W3rrj9NJsYS0fC0S1h8/ZA36YyrNaC4LD+egslJGv3PuQSx
 23sClmDND7qRiDHJ58hYeFGOJke4b++EpTCqn1scckdWZWRHMxna
X-Developer-Key: i=borrello@diag.uniroma1.it; a=ed25519;
 pk=4xRQbiJKehl7dFvrG33o2HpveMrwQiUPKtIlObzKmdY=
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit 326587b84078 ("sched: fix goto retry in pick_next_task_rt()")
removed any path which could make pick_next_rt_entity() return NULL.
However, BUG_ON(!rt_se) in _pick_next_task_rt() (the only caller of
pick_next_rt_entity()) still checks the error condition, which can
never happen, since list_entry() never returns NULL.
Remove the BUG_ON check, and instead emit a warning in the only
possible error condition here: the queue being empty which should
never happen.

Fixes: 326587b84078 ("sched: fix goto retry in pick_next_task_rt()")
Signed-off-by: Pietro Borrello <borrello@diag.uniroma1.it>
---
Changes in v2:
- pick_next_rt_entity(): emit warning instead of crashing
- Link to v1: https://lore.kernel.org/r/20230128-list-entry-null-check-sched-v1-1-c93085ee0055@diag.uniroma1.it
---
 kernel/sched/rt.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/sched/rt.c b/kernel/sched/rt.c
index ed2a47e4ddae..c024529d8416 100644
--- a/kernel/sched/rt.c
+++ b/kernel/sched/rt.c
@@ -1777,6 +1777,7 @@ static struct sched_rt_entity *pick_next_rt_entity(struct rt_rq *rt_rq)
 	BUG_ON(idx >= MAX_RT_PRIO);
 
 	queue = array->queue + idx;
+	SCHED_WARN_ON(list_empty(queue));
 	next = list_entry(queue->next, struct sched_rt_entity, run_list);
 
 	return next;
@@ -1789,7 +1790,6 @@ static struct task_struct *_pick_next_task_rt(struct rq *rq)
 
 	do {
 		rt_se = pick_next_rt_entity(rt_rq);
-		BUG_ON(!rt_se);
 		rt_rq = group_rt_rq(rt_se);
 	} while (rt_rq);
 

---
base-commit: 2241ab53cbb5cdb08a6b2d4688feb13971058f65
change-id: 20230128-list-entry-null-check-sched-a3f3dfd6d468

Best regards,
-- 
Pietro Borrello <borrello@diag.uniroma1.it>
