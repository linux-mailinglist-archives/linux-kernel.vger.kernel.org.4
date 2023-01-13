Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 06F1D6698E6
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Jan 2023 14:44:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241784AbjAMNn0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Jan 2023 08:43:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41190 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241754AbjAMNmO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Jan 2023 08:42:14 -0500
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com [IPv6:2a00:1450:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1029CB1E9
        for <linux-kernel@vger.kernel.org>; Fri, 13 Jan 2023 05:36:18 -0800 (PST)
Received: by mail-wm1-x330.google.com with SMTP id g19-20020a05600c4ed300b003d9eb1dbc0aso14404584wmq.3
        for <linux-kernel@vger.kernel.org>; Fri, 13 Jan 2023 05:36:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=no/No00/dUadTgkiqCjE1V7uzOtAh13kNBL63Zyd1c0=;
        b=DhEzzOKdo9LfA6gSAquygvXRjkhj9nQ922NqGep8Xbfc8XNBzPihRyc9TdA0EWhTie
         F76eyr/wtmgYKZ6XjdCJf5vvOthtGWZKWPx/mA7MSTBA3JjYexWThLDxZ7sJp2M8ZALS
         rISoTp8igr8je9DOIUgZUSqsFHiOSpniyKtpQOQJG6rKiCpAEqbYIeN/zN2hmwnvtbfE
         Sgr66vV7HeFWnbtilMGnvhWWfTFyjlgVeb0o1EKYUUADymnfI0u5ZT6r0GGmcFqU5EtM
         DaOcs1aj1uIzelutM4DzyysOUfAMQ1AXioetEYCdGXYfngQZaRiJapNXqR7BOB9IgS37
         FAcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=no/No00/dUadTgkiqCjE1V7uzOtAh13kNBL63Zyd1c0=;
        b=mx4GtYTBEzrXl68DX+rYA+vAU0Aem8mKoxAjkZlsrYUJ8o9d2AcA+4+23wS3pMeZgZ
         23GuYp3sb9mnTxlfy+fGQqvqDhAp2dawuqYgfOI5fkyyr6D6DlkA1Y6GE1sl4ZphtSzG
         R8ynfihXWdFK0KvZVab9PAza38k/U1qt6ajLE+a+9NfteUkZNI6nksLIJff0eHD7JzFv
         yvYsPHVX+Zpxr2j+oWRhsgcoYfObBI/H/WoNNxdnd1uvkUpe8IwNxlcKZY3kGpfaR9D7
         aKTonXVKOssupgvGnn/Fd6tww/ua0abjGEEWlBmaW0Fw7kbHZQcjpBK+r/IHTMuuCpA7
         y8PQ==
X-Gm-Message-State: AFqh2kog9lA68Z6vfi0eXKZhbHiV9sKLxArSdEBfLSo693Ygm+tvnSAp
        YEdWXG+JqrbPyPp0BhzWK9PNiA==
X-Google-Smtp-Source: AMrXdXtXICIa/h9q5hoEJ0F4W0PHTJ4838F/fZyqJPgglv65iNxCrnXS1zSuU5aqDheMs9b9yFLLDg==
X-Received: by 2002:a7b:c851:0:b0:3d9:f067:1c32 with SMTP id c17-20020a7bc851000000b003d9f0671c32mr13863320wml.29.1673616976552;
        Fri, 13 Jan 2023 05:36:16 -0800 (PST)
Received: from vingu-book.. ([2a01:e0a:f:6020:1563:65bf:c344:661e])
        by smtp.gmail.com with ESMTPSA id n23-20020a05600c3b9700b003cf71b1f66csm28900643wms.0.2023.01.13.05.36.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Jan 2023 05:36:15 -0800 (PST)
From:   Vincent Guittot <vincent.guittot@linaro.org>
To:     mingo@redhat.com, peterz@infradead.org, juri.lelli@redhat.com,
        dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
        mgorman@suse.de, bristot@redhat.com, vschneid@redhat.com,
        linux-kernel@vger.kernel.org
Cc:     zhangqiao22@huawei.com,
        Vincent Guittot <vincent.guittot@linaro.org>
Subject: [PATCH v4] sched/fair: limit sched slice duration
Date:   Fri, 13 Jan 2023 14:36:13 +0100
Message-Id: <20230113133613.257342-1-vincent.guittot@linaro.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In presence of a lot of small weight tasks like sched_idle tasks, normal
or high weight tasks can see their ideal runtime (sched_slice) to increase
to hundreds ms whereas it normally stays below sysctl_sched_latency.

2 normal tasks running on a CPU will have a max sched_slice of 12ms
(half of the sched_period). This means that they will make progress
every sysctl_sched_latency period.

If we now add 1000 idle tasks on the CPU, the sched_period becomes
3006 ms and the ideal runtime of the normal tasks becomes 609 ms.
It will even become 1500ms if the idle tasks belongs to an idle cgroup.
This means that the scheduler will look for picking another waiting task
after 609ms running time (1500ms respectively). The idle tasks change
significantly the way the 2 normal tasks interleave their running time
slot whereas they should have a small impact.

Such long sched_slice can delay significantly the release of resources
as the tasks can wait hundreds of ms before the next running slot just
because of idle tasks queued on the rq.

Cap the ideal_runtime to sysctl_sched_latency to make sure that tasks will
regularly make progress and will not be significantly impacted by
idle/background tasks queued on the rq.

Signed-off-by: Vincent Guittot <vincent.guittot@linaro.org>
Tested-By: Dietmar Eggemann <dietmar.eggemann@arm.com>
---

Change since v3:
- Rebased
- Added Tested tag

 kernel/sched/fair.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index e9d906a9bba9..d4db72f8f84e 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -4896,7 +4896,13 @@ check_preempt_tick(struct cfs_rq *cfs_rq, struct sched_entity *curr)
 	struct sched_entity *se;
 	s64 delta;
 
-	ideal_runtime = sched_slice(cfs_rq, curr);
+	/*
+	 * When many tasks blow up the sched_period; it is possible that
+	 * sched_slice() reports unusually large results (when many tasks are
+	 * very light for example). Therefore impose a maximum.
+	 */
+	ideal_runtime = min_t(u64, sched_slice(cfs_rq, curr), sysctl_sched_latency);
+
 	delta_exec = curr->sum_exec_runtime - curr->prev_sum_exec_runtime;
 	if (delta_exec > ideal_runtime) {
 		resched_curr(rq_of(cfs_rq));
-- 
2.34.1

