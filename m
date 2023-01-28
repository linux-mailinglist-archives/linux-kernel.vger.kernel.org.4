Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EC5E267F98F
	for <lists+linux-kernel@lfdr.de>; Sat, 28 Jan 2023 17:26:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234130AbjA1Q03 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 28 Jan 2023 11:26:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41910 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229643AbjA1Q01 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 28 Jan 2023 11:26:27 -0500
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com [IPv6:2a00:1450:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C1917A83
        for <linux-kernel@vger.kernel.org>; Sat, 28 Jan 2023 08:26:26 -0800 (PST)
Received: by mail-ed1-x52e.google.com with SMTP id x7so4059486edr.0
        for <linux-kernel@vger.kernel.org>; Sat, 28 Jan 2023 08:26:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=diag.uniroma1.it; s=google;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=2IUGAeGv9utebLnMRf4Q+O00/RPviVVY0BKqp6yL/kg=;
        b=nfJG2wJMrEc4NgewHwls60ixQn1FT0b0T38pU+teYxqbFR/TLi2H3BTQNZ9uz0F/CP
         EcQ4jYvE0nfcsnMn47TDk934IrgspZQSYaCIIyMdhYNxpTqIoUowNEwVsyd9R40vLPRa
         Hzh8UrDM1RQ1bx06CyIWkq20o/UHRe0dYlRWM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=2IUGAeGv9utebLnMRf4Q+O00/RPviVVY0BKqp6yL/kg=;
        b=gLIudCK0HGGV397DZcnf7CojNI/qgU0P+SxpxAJ5fePemxmCAKZt94GfrZeQySkbBy
         w02noJt7WRh1XeHJKdooG5IiWxh8pF+fVAqRntYs7zYPiiSYRAVMhUjRHiDXYTpbiyej
         krVZ3aj1/goUashl8MDQ3Yq0BS1oodh85cU9wKH2lQW+Cb9bt+wvxNIgFofDh8eZOvmV
         ++e2cKSqyB6qIw7AhjirpSbwsATGK88jmfj97ysU1PnK8ESQhEmRkZA7bUYuxJb1m7Xx
         Bda0tSEI3P3RwOQIKBWMMzXj/yMQn+SIN8eUlcSSziChbYymj2DEb5YAZTMgsGNFeU6h
         VCPw==
X-Gm-Message-State: AO0yUKXATquu6rUcnEg4AOZ089PdPt6G/z+iADB6uUdsFCix1lI+YnN5
        uyU+QulNB6SOuTw1i41AxLBfLeIb1UxPSpDeQu5K5g==
X-Google-Smtp-Source: AK7set/BwnV1aBe8Lyhyg38uG6a3j36i2IwKXXnSrFvVXClQgv1acWehBdGHARvWSYERF9//5ewoHw==
X-Received: by 2002:a05:6402:510d:b0:4a0:b601:4a74 with SMTP id m13-20020a056402510d00b004a0b6014a74mr17547667edd.28.1674923184890;
        Sat, 28 Jan 2023 08:26:24 -0800 (PST)
Received: from [192.168.17.2] (wolkje-127.labs.vu.nl. [130.37.198.127])
        by smtp.gmail.com with ESMTPSA id kv5-20020a17090778c500b0087c4f420af2sm2237576ejc.4.2023.01.28.08.26.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 28 Jan 2023 08:26:24 -0800 (PST)
From:   Pietro Borrello <borrello@diag.uniroma1.it>
Date:   Sat, 28 Jan 2023 16:26:15 +0000
Subject: [PATCH] sched: pick_next_rt_entity(): checked list_entry
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230128-list-entry-null-check-sched-v1-1-c93085ee0055@diag.uniroma1.it>
X-B4-Tracking: v=1; b=H4sIAKdM1WMC/x2NQQrCMBBFr1Jm7UCblFK8irhIk4kZjFFmoiild
 2/q6vP48N4KSsKkcO5WEPqw8rM0GE4d+OTKjZBDYzC9sf1gZsysFalU+WF554w+kb+jtgnobLQh
 himM0wzNsDglXMQVnw7Hw2klOY6XUOTvP3u5btsOEnGrSoYAAAA=
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1674923184; l=1366;
 i=borrello@diag.uniroma1.it; s=20221223; h=from:subject:message-id;
 bh=+TnFwqvslLCYg0C2K2P8kCuVHl8uIbNuMT200eU8tSw=;
 b=HpcO9b5Bwx8aIXJEbqqDtZ4aVEIDHzsx2KJ5xvruNYaMGJ/OojZjXrBT1YxEjIZqUC/P67bVDvFe
 +LQ1JpBtAXgkXtYHn7VXe1iToZc0IjGR0jPYgaUyp9xMKI+TtZAN
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
never happen, since list_entry() never returns NULL. Return
list_first_entry_or_null(queue, ...) to allow BUG to check the only
possible error condition here: the queue being empty which should
never happen.

Fixes: 326587b84078 ("sched: fix goto retry in pick_next_task_rt()")
Signed-off-by: Pietro Borrello <borrello@diag.uniroma1.it>
---
 kernel/sched/rt.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/sched/rt.c b/kernel/sched/rt.c
index ed2a47e4ddae..6088d5d83b75 100644
--- a/kernel/sched/rt.c
+++ b/kernel/sched/rt.c
@@ -1777,7 +1777,7 @@ static struct sched_rt_entity *pick_next_rt_entity(struct rt_rq *rt_rq)
 	BUG_ON(idx >= MAX_RT_PRIO);
 
 	queue = array->queue + idx;
-	next = list_entry(queue->next, struct sched_rt_entity, run_list);
+	next = list_first_entry_or_null(queue, struct sched_rt_entity, run_list);
 
 	return next;
 }

---
base-commit: 2241ab53cbb5cdb08a6b2d4688feb13971058f65
change-id: 20230128-list-entry-null-check-sched-a3f3dfd6d468

Best regards,
-- 
Pietro Borrello <borrello@diag.uniroma1.it>
