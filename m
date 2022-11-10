Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 877D86248A3
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Nov 2022 18:50:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231657AbiKJRuy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Nov 2022 12:50:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34192 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231419AbiKJRuk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Nov 2022 12:50:40 -0500
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com [IPv6:2a00:1450:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B0E654B983
        for <linux-kernel@vger.kernel.org>; Thu, 10 Nov 2022 09:50:32 -0800 (PST)
Received: by mail-wm1-x329.google.com with SMTP id a11-20020a05600c2d4b00b003cf6f5fd9f1so1660477wmg.2
        for <linux-kernel@vger.kernel.org>; Thu, 10 Nov 2022 09:50:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=references:in-reply-to:message-id:date:subject:cc:to:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=BdpGOqqRR51x8v+WZgI/bsaGNfHn7spXAbo4XhwMNf4=;
        b=MfRrRFFNTQcZnBIPJiun3xx2yPDz6mhtY8iK0hjwh8shwr6WuAXyJAVwIZdhJhiy2/
         H6TalqqeWvAmhwv5EHslh2+56IV8ZXdFhOWtTT1mJAPuy7uoJq+ibsy2w1R0NWhhf3Ne
         uu8IxmNsOs/9ya2GlPxF+Rl+9hX/mshANAFmqihmGxQ8OQ9OEp5Uzt3gZC+MtYSKDrUa
         i40+tWAZoz1SXLvKA9+5soeZOMgz3ZA2x8iSjvENiKfjnycnSzKFKylJgVMXF3r/TjIz
         itA1GWBbSniDilCTj8N3iB5e8OYnj43RByhhcvaInKu9HwrfqEjDBBNaw4TACdWxI0go
         FYvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=BdpGOqqRR51x8v+WZgI/bsaGNfHn7spXAbo4XhwMNf4=;
        b=FY3bW4QOKuW1AUG7CEbyzaORlrgAbkLYIUD32MK575Nhrru4SrGO+mefq7obfFXhFS
         tw1zUjIrW4ufDSMUW/gfsKxiR+KavNnU8ApvwvB0oUP/ad+6cFOpD9r6QfMOz8GopDO0
         yHb/mOxrUPiFferNbNZTbw0QVOpZ3mL0nFYhyPZNeFv8t48zL8TIBg4TaFjwK3qF8pN0
         NkPIjN4B9OS5EEzuZJS99bZjqQ180sWFM1m1l8WnuNhuspNcAaNANjtOXRnzw/IXSzr9
         3y/FnXNLQtiD0KjgXNE7jnryuUGq9c56yyCskMZUt9I4X23IfOOrrebiEfwMsQaQyS7T
         bz0A==
X-Gm-Message-State: ACrzQf2jrYK3HZ66UrJQrYkWv4FUDioNuuqpviKvsnv4s1B8sftLroON
        6KN8Wy2STpCRgVtTixuC3d1jrA==
X-Google-Smtp-Source: AMsMyM5Vp9N1/lbYY5QxYxeBECzMuC5Kak5gUpFrSIzSV06hFB/MqbL9VWs/kXnKxRMiwHUsRvjNIg==
X-Received: by 2002:a05:600c:1508:b0:3cf:6cc1:c3b4 with SMTP id b8-20020a05600c150800b003cf6cc1c3b4mr41599484wmg.156.1668102631192;
        Thu, 10 Nov 2022 09:50:31 -0800 (PST)
Received: from localhost.localdomain ([2a01:e0a:f:6020:342a:468f:562a:9cc4])
        by smtp.gmail.com with ESMTPSA id f6-20020a05600c4e8600b003cfc02ab8basm6514677wmq.33.2022.11.10.09.50.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Nov 2022 09:50:30 -0800 (PST)
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
Subject: [PATCH v8 7/9] sched/core: Support latency priority with sched core
Date:   Thu, 10 Nov 2022 18:50:07 +0100
Message-Id: <20221110175009.18458-8-vincent.guittot@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20221110175009.18458-1-vincent.guittot@linaro.org>
References: <20221110175009.18458-1-vincent.guittot@linaro.org>
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
index 9583936ce30c..a7372f80b1ea 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -11439,6 +11439,9 @@ bool cfs_prio_less(struct task_struct *a, struct task_struct *b, bool in_fi)
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

