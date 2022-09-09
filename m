Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9DFA15B3881
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Sep 2022 15:04:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229494AbiIINE2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Sep 2022 09:04:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37286 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231360AbiIINDZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Sep 2022 09:03:25 -0400
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com [IPv6:2a00:1450:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 374C3B8F1E
        for <linux-kernel@vger.kernel.org>; Fri,  9 Sep 2022 06:03:23 -0700 (PDT)
Received: by mail-wm1-x329.google.com with SMTP id az24-20020a05600c601800b003a842e4983cso1292855wmb.0
        for <linux-kernel@vger.kernel.org>; Fri, 09 Sep 2022 06:03:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=references:in-reply-to:message-id:date:subject:cc:to:from:from:to
         :cc:subject:date;
        bh=rr8CydEOaNyM9xcBRy/GQAgJhU9JrzFylVpY+2UJlqc=;
        b=BXXDCATW8FCicXAPegf7TxK/MRjPGBirNYTBOaG35fj3fCN8rc6FFk5tKcl6Th0sJz
         ps5UTQvcA/JKck2+gbM6HjCSn0/UXLoromLA6q/eZun3MUYSx1nCM/a6aUwUX2cL7aMO
         mcN9hYt26Yk/nZqapJU6pu7sRxdP/He1+ssqQo6SyaY6FieHwKIhGbYFdAIgnenDeU+7
         Y14fqmxKQ9RKAxfJEz+wFKArSA5d4LXsgx3wUyawm7LvN4vfN9GmXpZhYNsdeuzY2yxR
         63elcw5igwnztGrnpld5Z3XcViNC3OUBy3N9O27eXn/JBrNCdksvM+6/Vh3H4fgG1T/i
         vMAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :x-gm-message-state:from:to:cc:subject:date;
        bh=rr8CydEOaNyM9xcBRy/GQAgJhU9JrzFylVpY+2UJlqc=;
        b=LkzrbGo9Ckux+1neAPeK2mZRhw1JCKI6D3cofhLpETS4RdMraBwIuvQgdwa5oXLFuV
         swARkG3Brb17jKHdZJtv+k6vAfKb0Oawy793+X6lfyPWwmCSE/e8lHA05zALAU2pVC50
         9NdooFh8vs5qwZmA2tW1I8a6RZyryn/J318gRA3uwuOhJ3H253zgtBy3hW2ACJOa6Opo
         mOrZV/5zO+eUM+6wunrasP2TjtbYsvVaqAIaDEdhzIOUl2JyD1JBTXTto5enOEnXEsRy
         6I8S4Ib6MKCaCcJZeSRoFiFEA2ZN7IRMQVJrBdtmfUt8OuOVBBo+9EOoeCcNtdQVVsm7
         C1BQ==
X-Gm-Message-State: ACgBeo02oicXN4JxPO/eE51RJzmaLC3L4Y/djzBhm0ZjHg84ODtyf1B3
        5uSZ6cYg71SUkEBJVUrUxsobdA==
X-Google-Smtp-Source: AA6agR6OusN4WtlOo4S+R5/9VVC4/hRibDeBfmZkGYX4GSDAsN0z53rBY2vYWeufhM6UyzriY6AH+w==
X-Received: by 2002:a1c:f217:0:b0:3a6:61f2:a9c2 with SMTP id s23-20020a1cf217000000b003a661f2a9c2mr5403171wmc.88.1662728601297;
        Fri, 09 Sep 2022 06:03:21 -0700 (PDT)
Received: from localhost.localdomain ([2a01:e0a:f:6020:c6e:e86:ab92:92b7])
        by smtp.gmail.com with ESMTPSA id m10-20020a05600c3b0a00b003a5f4fccd4asm569909wms.35.2022.09.09.06.03.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Sep 2022 06:03:20 -0700 (PDT)
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
Subject: [PATCH v3 4/8] sched/core: Add permission checks for setting the latency_nice value
Date:   Fri,  9 Sep 2022 15:03:05 +0200
Message-Id: <20220909130309.25458-5-vincent.guittot@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220909130309.25458-1-vincent.guittot@linaro.org>
References: <20220909130309.25458-1-vincent.guittot@linaro.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
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

