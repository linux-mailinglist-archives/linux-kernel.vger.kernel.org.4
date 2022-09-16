Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 87C855BA7BD
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Sep 2022 10:04:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229773AbiIPIE1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Sep 2022 04:04:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43480 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229877AbiIPIDX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Sep 2022 04:03:23 -0400
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com [IPv6:2a00:1450:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C73E5A2D95
        for <linux-kernel@vger.kernel.org>; Fri, 16 Sep 2022 01:03:21 -0700 (PDT)
Received: by mail-wm1-x32f.google.com with SMTP id r3-20020a05600c35c300b003b4b5f6c6bdso1895029wmq.2
        for <linux-kernel@vger.kernel.org>; Fri, 16 Sep 2022 01:03:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=references:in-reply-to:message-id:date:subject:cc:to:from:from:to
         :cc:subject:date;
        bh=rr8CydEOaNyM9xcBRy/GQAgJhU9JrzFylVpY+2UJlqc=;
        b=SO6hBAy2jSqFrTLGjKa6u8ikfVsyDBHVqkX5OiSKWGFdD5nO1231ycehUzPDkoGCgh
         iaS17+5VgVGv0GYRxVXkDseADbaic2d9snnqV5oL1F5pnIv9gmi6bdPhwcljr6mQJ7GA
         F0rI3JB4fqqyKD5LZTuYJusRfZAZdYyfjzOV4mgZqVYgsqM59IlG/SNcIjLu9ZQ42yk9
         PibGRKzaxDSDfMMu4BFDHEtLQ2BkmUEHAG33e26Jt/lqXNPWMqNLNbDQOgGNlRrlbx6g
         f0KgttndVs9t3sZ3p3IaiAS1ehbQ8UYfvBM8cYKw3NA11TCiKBbmMuOgJl/dLrJoz/x0
         Pk0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :x-gm-message-state:from:to:cc:subject:date;
        bh=rr8CydEOaNyM9xcBRy/GQAgJhU9JrzFylVpY+2UJlqc=;
        b=uKW/7uNaCedgoI+Xp4VGYGNXaKt/Ave7Z94JBIb4f2OMagmKN9XlNO82IsJ7KxcoUN
         HxsOz/n8h6NfnzyzuBP1SUsAxBWCG+v5BFWV8q3zKhcTUTiHrJdRamOcksrfI3Y6HbKG
         gLxoTjOsW1UBDjpBgIcIvUkpxWy0Br+mOzHXpT1Sk6Zdz7fNZyX3QhjArBy4+bQH3Kw9
         e4VBt2/Abqz7C3nXSb9I1OlicilEsefL5SnpXu7OeaBQaX8ov+EF05eRPj0pzIooPkUe
         457r7j+73XdJq1e422FZQPk9Y4/Jq6XGsBdiAa9YJdGxZTt5WjhdMKH6XKLtpjTMfpVK
         1cZA==
X-Gm-Message-State: ACrzQf3U4wixqNN8xqaMyIHCcIwCTnGK+AnnC/25ew1MOzToa/btoUwx
        wFqLU7cmRTiXj23VoSm4y7oRkA==
X-Google-Smtp-Source: AMsMyM41YE7jJwwkNHvG1nSEhfCWxwTLTe4MVDjDEh2oSypNyy9RunkD2eXuo3b4U0EdsMQu14Cscw==
X-Received: by 2002:a7b:ce99:0:b0:3b4:9031:fc02 with SMTP id q25-20020a7bce99000000b003b49031fc02mr2469023wmj.154.1663315400274;
        Fri, 16 Sep 2022 01:03:20 -0700 (PDT)
Received: from localhost.localdomain ([2a01:e0a:f:6020:9ab:1164:827a:1548])
        by smtp.gmail.com with ESMTPSA id c9-20020adffb49000000b00228dbf15072sm4418116wrs.62.2022.09.16.01.03.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Sep 2022 01:03:19 -0700 (PDT)
From:   Vincent Guittot <vincent.guittot@linaro.org>
To:     mingo@redhat.com, peterz@infradead.org, juri.lelli@redhat.com,
        dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
        mgorman@suse.de, bristot@redhat.com, vschneid@redhat.com,
        linux-kernel@vger.kernel.org, parth@linux.ibm.com
Cc:     qais.yousef@arm.com, chris.hyser@oracle.com,
        valentin.schneider@arm.com, patrick.bellasi@matbug.net,
        David.Laight@aculab.com, pjt@google.com, pavel@ucw.cz,
        tj@kernel.org, qperret@google.com, tim.c.chen@linux.intel.com,
        joshdon@google.com, Vincent Guittot <vincent.guittot@linaro.org>
Subject: [PATCH v4 4/8] sched/core: Add permission checks for setting the latency_nice value
Date:   Fri, 16 Sep 2022 10:03:01 +0200
Message-Id: <20220916080305.29574-5-vincent.guittot@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220916080305.29574-1-vincent.guittot@linaro.org>
References: <20220916080305.29574-1-vincent.guittot@linaro.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Parth Shah <parth@linux.ibm.com>

Since the latency_nice uses the similar infrastructure as NICE, use the
already existing CAP_SYS_NICE security checks for the latency_nice. This
should return -EPERM for the non-root user when trying to set the task
latency_nice value to any lower than the current value.

Signed-off-by: Parth Shah <parth@linux.ibm.com>
[rebase]
Signed-off-by: Vincent Guittot <vincent.guittot@linaro.org>
---
 kernel/sched/core.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 2015e7d1f8b2..3c79c5419d1b 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -7444,6 +7444,10 @@ static int __sched_setscheduler(struct task_struct *p,
 			return -EINVAL;
 		if (attr->sched_latency_nice < MIN_LATENCY_NICE)
 			return -EINVAL;
+		/* Use the same security checks as NICE */
+		if (attr->sched_latency_nice < p->latency_nice &&
+		    !capable(CAP_SYS_NICE))
+			return -EPERM;
 	}
 
 	if (pi)
-- 
2.17.1

