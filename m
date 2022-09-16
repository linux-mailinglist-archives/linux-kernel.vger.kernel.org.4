Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7EC185BADEB
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Sep 2022 15:15:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229849AbiIPNPu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Sep 2022 09:15:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43192 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230164AbiIPNPr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Sep 2022 09:15:47 -0400
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0557BA3D3C
        for <linux-kernel@vger.kernel.org>; Fri, 16 Sep 2022 06:15:43 -0700 (PDT)
Received: by mail-wr1-x433.google.com with SMTP id g3so15081272wrq.13
        for <linux-kernel@vger.kernel.org>; Fri, 16 Sep 2022 06:15:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=QDusqnJjLrNj6QExRoOXa9qSBtiPcVsrqcCLp5ximBc=;
        b=aRzPCaXEpYhCvtyxT7qX0+8Ty4p2U64huAvWnJnsz5xQZLJKbi3OPNHZ0+qfSQ4z5V
         1SKmxUXKZEe+7Y8bz9MkYCoshZbQ67t8ed+HQV9u3iNvH0HSjQk/2z5FdNJNkFT/YkuC
         ESQsq5MP0TCPsjzaYgI1TLNqmWu1LF8mWAAHNvwW8RBhcIuk38Ubh0YLW6hBk7ns1UmZ
         xh0szLik4R8nKmrYM8bA63YaKiZQBUmwdvzixYdcZw47QGArFVv1mPAXVQG+EV6z3lmY
         iSVfcwYc/T20fZj/Lw6jXcTYUsDODxOOH61gzlJ4Xet28UA4zBO/7JusOZkGAs4yNcOt
         sCOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=QDusqnJjLrNj6QExRoOXa9qSBtiPcVsrqcCLp5ximBc=;
        b=jaEb2LTiB8t7/3PrYLPzRJAS74UTT9b3988RpC7Qc9J7F1PyPt4pzNvgemjyQLuazW
         Je5KPwWf01wMiJx3qq3FydIzzK9gQy9AiBQNAW9O1jBcHldL4FrnuUMeDjaf5AvoGEYn
         TkZsyuxBbfWr2VEVVnXtpQpg5gfriuAtv6ZizKyW8Gf4gNRZTxpZMTeIlMXFIBbvn3hF
         ZAkh9KC4LijnB95if3NFdlH+uLlw/MoZb+hxNPFMz4sm9IFnJTZL5jV46/3S3RglT9wi
         qJFd2RKX05N18p5o7qt4CbKDod/+a/OfzYJroTUs5SlGMHiompX66ws8uGtCtdQeqU2w
         qA7A==
X-Gm-Message-State: ACrzQf0sumBtWBVrfgYKkkPV5kwjb97uR6Q0DBUZqmVYyDlJVtpn0bO4
        UH5h3FFEPZn0/gMHa2UxwL0pL3sDoBA37/uK
X-Google-Smtp-Source: AMsMyM7nXGBM878kFPUD0D30tMPkqYuoBDf4cFwO1mEskDElV+yzix/lSLfjyG6IQcxU82LJDxiZjw==
X-Received: by 2002:a5d:598c:0:b0:22a:47d1:4fa with SMTP id n12-20020a5d598c000000b0022a47d104famr2918738wri.24.1663334141985;
        Fri, 16 Sep 2022 06:15:41 -0700 (PDT)
Received: from localhost.localdomain ([2a01:e0a:f:6020:9ab:1164:827a:1548])
        by smtp.gmail.com with ESMTPSA id x1-20020adfdd81000000b002205cbc1c74sm765180wrl.101.2022.09.16.06.15.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Sep 2022 06:15:40 -0700 (PDT)
From:   Vincent Guittot <vincent.guittot@linaro.org>
To:     mingo@redhat.com, peterz@infradead.org, juri.lelli@redhat.com,
        dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
        mgorman@suse.de, bristot@redhat.com, vschneid@redhat.com,
        linux-kernel@vger.kernel.org
Cc:     zhangqiao22@huawei.com,
        Vincent Guittot <vincent.guittot@linaro.org>
Subject: [PATCH v2] sched/fair: limit sched slice duration
Date:   Fri, 16 Sep 2022 15:15:38 +0200
Message-Id: <20220916131538.24706-1-vincent.guittot@linaro.org>
X-Mailer: git-send-email 2.17.1
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

Cap the ideal_runtime to the weighted version of sysctl_sched_latency when
comparing with the vruntime of the next waiting task to make sure that
tasks will regularly make progress and will not be significantly impacted
by idle/background tasks queued on the rq.

Signed-off-by: Vincent Guittot <vincent.guittot@linaro.org>
---

I have kept the test if (delta < 0) as calc_delta_fair() can't handle negative
value.

Change since v1:
  - the first 3 patches have been already queued
  - use the weight of curr to scale sysctl_sched_latency before capping
    the ideal_runtime so we can compare vruntime values.

 kernel/sched/fair.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 5ffec4370602..ba451bb25929 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -4610,6 +4610,8 @@ check_preempt_tick(struct cfs_rq *cfs_rq, struct sched_entity *curr)
 	if (delta < 0)
 		return;
 
+	ideal_runtime = min_t(u64, ideal_runtime,
+				   calc_delta_fair(sysctl_sched_latency, curr));
 	if (delta > ideal_runtime)
 		resched_curr(rq_of(cfs_rq));
 }
-- 
2.17.1

