Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 37D9574E8BC
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jul 2023 10:14:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231226AbjGKIOL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Jul 2023 04:14:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38458 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230187AbjGKIOF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jul 2023 04:14:05 -0400
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com [IPv6:2a00:1450:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 93B9EE4B
        for <linux-kernel@vger.kernel.org>; Tue, 11 Jul 2023 01:14:03 -0700 (PDT)
Received: by mail-wm1-x331.google.com with SMTP id 5b1f17b1804b1-3fbc59de009so56537425e9.3
        for <linux-kernel@vger.kernel.org>; Tue, 11 Jul 2023 01:14:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1689063242; x=1691655242;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=4S5VQld6DUPIPHyaiomd1pydQF9NTtq/i3Ejp02y1Iw=;
        b=eywoMGOxzSBQFd1hDBBI6K6LFUOjyfsXmJWfuZrGjGGoDM5BQk56onazWMoUQxOXKR
         Usz1OyXgfHVmm9vxkB+jBMHRO5oCTpMWrH76syCbuZ9oMZNuNfhQ8+KZKC0KWUmdt+y1
         mCF3wp4ulljLY2+KmlTluQvx1ObJKd8dRz4h863V445p1fVF5hLnVEp1Ete74RMoV0Sw
         wvCJub65l56SZFhKlGQ71fwchKQA5UdgvH29GdRsVJyiGcqpSSPEpNk3Y5/40OC93Dof
         rdGbDECXNaxIiom/dz68sWoIV2KtAXNeQ7YPJ5Xnuz1hqFLNUQkUSCFx/9qPz9lSGZbN
         aifg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689063242; x=1691655242;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=4S5VQld6DUPIPHyaiomd1pydQF9NTtq/i3Ejp02y1Iw=;
        b=btWgzv0Sv5JvXILnbUvXcfyKJuJI68n4ud7Hrd1zjViPv17+eBvRj9CaKRcxztyrln
         J77mmUaKgkJAFRr1a/VHIJfQQHixkQxp0wqYJs+vQrdX588VYpkd/re5wZVAhKbwU2WI
         ztxS7YrhXyIju+9mEls8Y2h2Sb+O4NHZPdnIl2KMglxqSWc2mV4vg9FbK/GmqDa7I09B
         P+iDebjwkzivFjhN3BBWkTULiABwd3uAZsK8kNmzpDNlj/Jbd9iGDIWIcBHgLwrg4tds
         6jUOPNO75+ZUFMjFrSxhv9amx7rTHVIOcr7HB/MmgrJaQdelpQLl5MCEUGtUIYIbFnv+
         sjmw==
X-Gm-Message-State: ABy/qLalHEaQH6dvBLWcD1kyADGby225UMt+gyQw/UZgL/QKaOjjh0Fh
        DmnZLVPAavwJDNksAHy6EgZ6U3kM0MRwR0Bcx9w=
X-Google-Smtp-Source: APBJJlFIF92eKTO5jqJkcsH4+paSoH0SQB1tCqNoyYZi/gjv/ApcSFGEkdkKJW9gP0ghpQutRy3imw==
X-Received: by 2002:a5d:48d2:0:b0:314:9b6:6362 with SMTP id p18-20020a5d48d2000000b0031409b66362mr13138619wrs.57.1689063241943;
        Tue, 11 Jul 2023 01:14:01 -0700 (PDT)
Received: from vingu-book.. ([2a01:e0a:f:6020:dee8:b15f:d20f:eee9])
        by smtp.gmail.com with ESMTPSA id h7-20020a5d5487000000b0030ae901bc54sm1531792wrv.62.2023.07.11.01.14.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Jul 2023 01:14:01 -0700 (PDT)
From:   Vincent Guittot <vincent.guittot@linaro.org>
To:     mingo@redhat.com, peterz@infradead.org, juri.lelli@redhat.com,
        dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
        mgorman@suse.de, bristot@redhat.com, vschneid@redhat.com,
        linux-kernel@vger.kernel.org, jiahao.os@bytedance.com
Cc:     Vincent Guittot <vincent.guittot@linaro.org>
Subject: [PATCH] sched/fair: stabilize asym cpu capacity system idle cpu selection
Date:   Tue, 11 Jul 2023 10:13:59 +0200
Message-Id: <20230711081359.868862-1-vincent.guittot@linaro.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

select_idle_capacity() not only looks for an idle cpu that fits for the
waking task but also for cpu with highest bandwidth when no cpu fits.
Start the loop with target cpu so it will be selected 1st when no cpu fits
but several cpus shared the same bandwidth. Starting with target cpu
prevents the task to migrate between cpus with same bandwidth at every
wakeup when no cpu fits.

Signed-off-by: Vincent Guittot <vincent.guittot@linaro.org>
---
 kernel/sched/fair.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index a80a73909dc2..0ee116f992f4 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -7065,7 +7065,7 @@ select_idle_capacity(struct task_struct *p, struct sched_domain *sd, int target)
 	util_min = uclamp_eff_value(p, UCLAMP_MIN);
 	util_max = uclamp_eff_value(p, UCLAMP_MAX);
 
-	for_each_cpu_wrap(cpu, cpus, target + 1) {
+	for_each_cpu_wrap(cpu, cpus, target) {
 		unsigned long cpu_cap = capacity_of(cpu);
 
 		if (!available_idle_cpu(cpu) && !sched_idle_cpu(cpu))
-- 
2.34.1

