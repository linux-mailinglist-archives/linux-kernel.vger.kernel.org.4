Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5C67C610D67
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Oct 2022 11:35:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230239AbiJ1Jft (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Oct 2022 05:35:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34216 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229718AbiJ1JfZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Oct 2022 05:35:25 -0400
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com [IPv6:2a00:1450:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 881F943634
        for <linux-kernel@vger.kernel.org>; Fri, 28 Oct 2022 02:35:11 -0700 (PDT)
Received: by mail-wm1-x32b.google.com with SMTP id v130-20020a1cac88000000b003bcde03bd44so6126323wme.5
        for <linux-kernel@vger.kernel.org>; Fri, 28 Oct 2022 02:35:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=references:in-reply-to:message-id:date:subject:cc:to:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=BdpGOqqRR51x8v+WZgI/bsaGNfHn7spXAbo4XhwMNf4=;
        b=zOLOF5KQfiM3VAF/LTTlIf8z8DkvCp0vZw3Xhv8+DGP/9V1ubeRFEVrxRFSTlAAIas
         H6/qxTvcmy51vmuCSjzc47frBlLaP7cXK3mOYbNZlRi736Lxygf+gsC7oV3ksszee2qT
         yF5HufCTZ+C3hn0Xpo38rgkjNmx2GRm/HXEB2/KMnavuz+g8BWoaME8AUYbCaWcj8VHE
         nl0nDaEK10WClhWkd/qf9YShlfFrJo6D6KcvrTbfvRDtv5XokNJExHW5U4a07MQ2lcX2
         REYFI0sYsnZ8f2Kc3wm1XMWyy4qWQ5mhggw9D0W/j4jCaXPE7l3fA7xyrgZN9wE94+uj
         Hltg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=BdpGOqqRR51x8v+WZgI/bsaGNfHn7spXAbo4XhwMNf4=;
        b=hrMzEDfxKp/paQEAZVPiTYQHYkSuba8pyppyttir/zbTJ8YDjwy4Kz61/smu3w+J41
         9SVnHdZtsvCWEdkY8iMHJ9C8KyUGP0R3HbfEE7NA7uSe1A/RPfT+WAvkV66nQjvTuoMr
         h6IlI/H13R0r7QID57oSUHuLTo0DuiPFJVthuI15MR8b7naTXuvHlvn9w1VKOkfAwfMl
         UmP3R6pCvaKpxI2M75MO5UAY1QVOt2fZkrtbbvgMo7CrOWKXhfpBf8WhB3bqorEl9bpS
         fCwc76mhHCAxSmEzeFEPU2iU+bOrdt0gbU5xuBSYS1uPGW4Ar1K71gExKFG7bFCdqobO
         MoTg==
X-Gm-Message-State: ACrzQf37eXI2Y1gNEx5aSPLTsDsd3yxd2is24TPWFhvbAjEe9EDHUMiU
        OPJBCKufnDIs640eLSUDXGEqXw==
X-Google-Smtp-Source: AMsMyM4CU3U+RPFEHgAwQjydlwjNUidgvPB61PSCVCApAqQSDj3ft9Dh+Xuf4+/qi5dZD6xAuptTrw==
X-Received: by 2002:adf:e610:0:b0:236:737f:8e5d with SMTP id p16-20020adfe610000000b00236737f8e5dmr15974537wrm.316.1666949710093;
        Fri, 28 Oct 2022 02:35:10 -0700 (PDT)
Received: from localhost.localdomain ([2a01:e0a:f:6020:c12b:b448:f0a9:83ef])
        by smtp.gmail.com with ESMTPSA id k3-20020a05600c1c8300b003c6b7f5567csm10909426wms.0.2022.10.28.02.35.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Oct 2022 02:35:08 -0700 (PDT)
From:   Vincent Guittot <vincent.guittot@linaro.org>
To:     mingo@redhat.com, peterz@infradead.org, juri.lelli@redhat.com,
        dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
        mgorman@suse.de, bristot@redhat.com, vschneid@redhat.com,
        linux-kernel@vger.kernel.org, parth@linux.ibm.com
Cc:     qais.yousef@arm.com, chris.hyser@oracle.com,
        patrick.bellasi@matbug.net, David.Laight@aculab.com,
        pjt@google.com, pavel@ucw.cz, tj@kernel.org, qperret@google.com,
        tim.c.chen@linux.intel.com, joshdon@google.com, timj@gnu.org,
        kprateek.nayak@amd.com, yu.c.chen@intel.com,
        youssefesmat@chromium.org, joel@joelfernandes.org,
        Vincent Guittot <vincent.guittot@linaro.org>
Subject: [PATCH v7 7/9] sched/core: Support latency priority with sched core
Date:   Fri, 28 Oct 2022 11:34:01 +0200
Message-Id: <20221028093403.6673-8-vincent.guittot@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20221028093403.6673-1-vincent.guittot@linaro.org>
References: <20221028093403.6673-1-vincent.guittot@linaro.org>
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

