Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ABD8D62A023
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Nov 2022 18:20:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238422AbiKORUH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Nov 2022 12:20:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50206 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231211AbiKORT1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Nov 2022 12:19:27 -0500
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 325312ED67
        for <linux-kernel@vger.kernel.org>; Tue, 15 Nov 2022 09:19:15 -0800 (PST)
Received: by mail-wr1-x429.google.com with SMTP id d9so20722382wrm.13
        for <linux-kernel@vger.kernel.org>; Tue, 15 Nov 2022 09:19:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=references:in-reply-to:message-id:date:subject:cc:to:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=CGMqXYjoYf/WCxKwtIkJoJC9zB/0I+t2qO/AqMAucT0=;
        b=I0/z0dlKkHFrFldEVa1E3JCFMbVQxwcWjYQU1Njus7Rg2rSLYlTEtI2S1xLqrfJMGM
         xFm/nOOtIU8k8dL5P4QXvCupx9GH2uGEGcVenhEYMSK07SrTrpBH1mTEKHCKcOSUeYuU
         leoh/DbNqm1sr15uKVVe459mKy1coCnTm0JWcZv8xeof6sVpOyzqH5XJqdsQyBXpWIhl
         f4PoIcWj+oVslNQe+tpGae3ZMePBDGAtlN6LazkLmPDKrfEuXyIgGNo3q0ZesSq1Xbuh
         W1ctsDeeMycFuFHCg5v0/kCUq1hE/pCYYNs3PHORwt0i9MOLtTKPOGwLNX9t1xqBJoyc
         ZXnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=CGMqXYjoYf/WCxKwtIkJoJC9zB/0I+t2qO/AqMAucT0=;
        b=Ue0a0jzfMctoYfM0p8eoQK1/14vO6Lvv6w4WFHvh5MGQ0TPvo3n5e/kuxkbmnTCGR1
         p7jIBHv3VyCocZCpSTCwh4XmIhMvmy+jeyWUhmyo4EHZRVhbemR54K7NtL56QCggbVAP
         0DaH6wYXsQKSZ30aYiXCLrzM7EhXHcWB0+rkUEfKBqB8k2c0xNBTn8gepURDVDSUICx8
         l3LsWzZLTXCbPJa4NY2IAqHyonTzBjjHO5XQvzMRTQ7dnv7fTJ7+A81JGkyTshSSnvBv
         UMRxWG0olgkOfI7cPmF3z6GAREjRUlMCb7IrG3WmHXzzcW1wrd73CoeQnBOJSo/KCH5r
         J6LA==
X-Gm-Message-State: ANoB5pnKKPc2N+YHsdEUB+pJmsodSsl7az5Pi1sAbweWkAmnStG6lF/t
        1zHhk6bTS0npcRiNcikMyrbOAw==
X-Google-Smtp-Source: AA0mqf5cP8PM0ZsYvKiMd4yC8wCbPBwflP59tAoQSOE0Kt/ujzaGvhH7QlIk+T4NmeTMCu0iQuM5pw==
X-Received: by 2002:a5d:6b46:0:b0:22e:2e22:6698 with SMTP id x6-20020a5d6b46000000b0022e2e226698mr12072367wrw.296.1668532753666;
        Tue, 15 Nov 2022 09:19:13 -0800 (PST)
Received: from localhost.localdomain ([2a01:e0a:f:6020:91c8:7496:8b73:811f])
        by smtp.gmail.com with ESMTPSA id bg40-20020a05600c3ca800b003cf78aafdd7sm16846461wmb.39.2022.11.15.09.19.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Nov 2022 09:19:12 -0800 (PST)
From:   Vincent Guittot <vincent.guittot@linaro.org>
To:     mingo@redhat.com, peterz@infradead.org, juri.lelli@redhat.com,
        dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
        mgorman@suse.de, bristot@redhat.com, vschneid@redhat.com,
        linux-kernel@vger.kernel.org, parth@linux.ibm.com
Cc:     qyousef@layalina.io, chris.hyser@oracle.com,
        patrick.bellasi@matbug.net, David.Laight@aculab.com,
        pjt@google.com, pavel@ucw.cz, tj@kernel.org, qperret@google.com,
        tim.c.chen@linux.intel.com, joshdon@google.com, timj@gnu.org,
        kprateek.nayak@amd.com, yu.c.chen@intel.com,
        youssefesmat@chromium.org, joel@joelfernandes.org,
        Vincent Guittot <vincent.guittot@linaro.org>
Subject: [PATCH v9 7/9] sched/core: Support latency priority with sched core
Date:   Tue, 15 Nov 2022 18:18:49 +0100
Message-Id: <20221115171851.835-8-vincent.guittot@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20221115171851.835-1-vincent.guittot@linaro.org>
References: <20221115171851.835-1-vincent.guittot@linaro.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Take into account wakeup_latency_gran() when ordering the cfs threads.

Signed-off-by: Vincent Guittot <vincent.guittot@linaro.org>
---
 kernel/sched/fair.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 75c0a8d203c3..be446dc58be7 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -11833,6 +11833,9 @@ bool cfs_prio_less(struct task_struct *a, struct task_struct *b, bool in_fi)
 	delta = (s64)(sea->vruntime - seb->vruntime) +
 		(s64)(cfs_rqb->min_vruntime_fi - cfs_rqa->min_vruntime_fi);
 
+	/* Take into account latency prio */
+	delta -= wakeup_latency_gran(sea, seb);
+
 	return delta > 0;
 }
 #else
-- 
2.17.1

