Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 21B2B610B64
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Oct 2022 09:37:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230296AbiJ1Hh1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Oct 2022 03:37:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43200 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230232AbiJ1HhF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Oct 2022 03:37:05 -0400
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com [IPv6:2a00:1450:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 09C0D1BC157
        for <linux-kernel@vger.kernel.org>; Fri, 28 Oct 2022 00:37:03 -0700 (PDT)
Received: by mail-wm1-x32c.google.com with SMTP id l16-20020a05600c4f1000b003c6c0d2a445so2909270wmq.4
        for <linux-kernel@vger.kernel.org>; Fri, 28 Oct 2022 00:37:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=references:in-reply-to:message-id:date:subject:cc:to:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=BdpGOqqRR51x8v+WZgI/bsaGNfHn7spXAbo4XhwMNf4=;
        b=qe09/nTvE0G/K4zkvg/DsQq8oHH7SjmRLoGHceZha1Qm5MqWolIk7mFG0thT+nMLKF
         KmysZi86J4U/5hXr25vRhPcDCIKGkkN4zND+Y6vzOHSZIiS616i1X/GWi7nrmvq4ie7m
         lLtii7gv4j4T1PY82iCgfwruhI3BLqBkJDpGb11OxRWiYl3aCY0s/q0KJRN/tjm6C5gN
         3voZULnWa+hrVgtCi0+hNUcAckmglcRPmebAzm21WrSsNcHebeMwX3ob8HJ8XM7ubRLs
         DYzs111nItJbuSSoUYYd+orcq/2ILdjTkCxJlJ4xOlJan/kuxb/YNFDB6+OI2htyxuDZ
         1xXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=BdpGOqqRR51x8v+WZgI/bsaGNfHn7spXAbo4XhwMNf4=;
        b=7HEOvTEgpDQy4QZVWLSUyvaAbAjt7i2l39M5nLbnHFHuvVkm8LvZlrLaL6OS3q956b
         1RKPYrDsDPbYA8EFr8+6cvgRECPot0vA2eBER02MKlp3ZGedQmcZGwjJCynlT8y06sni
         T0h5CiSoRRzIUFfVeidn5Kb+mql/11NM4wblT6KzzUgxhMg/KraENseCJ/R6tb/hCeMQ
         +XXW7ztGBEbHbMDkRXnRpaq+B5BYEPQtf/KXqN1CzTsaFxk2TDU0vToBl7k4ooILZV12
         TJMHTndd5chHbzIeoSO7D3Y1Mo+cZ0AH5PWQu78HRhEFmohUXVCKhUGY5v9nc+XUpxsT
         HS2w==
X-Gm-Message-State: ACrzQf2LndxuOztrLoN+FQMrQpseIBaWLrqc7tzEyalpVgqox0cY2psj
        z0m5m9SD3Pe05bw/v8qIfmJVchcDNcujlg==
X-Google-Smtp-Source: AMsMyM6JMlQgI0KTQiec9Wb39ca3UObbnUGlBuNJ0fs2qELcDKMz0vkGhGjWCHUwn4aI2rYT92yAUQ==
X-Received: by 2002:a7b:c341:0:b0:3c4:552d:2ea7 with SMTP id l1-20020a7bc341000000b003c4552d2ea7mr8571521wmj.82.1666942622585;
        Fri, 28 Oct 2022 00:37:02 -0700 (PDT)
Received: from localhost.localdomain ([2a01:e0a:f:6020:c12b:b448:f0a9:83ef])
        by smtp.gmail.com with ESMTPSA id j8-20020a05600c190800b003b47e8a5d22sm7783129wmq.23.2022.10.28.00.37.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Oct 2022 00:37:01 -0700 (PDT)
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
Subject: [PATCH v6 7/9] sched/core: Support latency priority with sched core
Date:   Fri, 28 Oct 2022 09:36:35 +0200
Message-Id: <20221028073637.31195-8-vincent.guittot@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20221028073637.31195-1-vincent.guittot@linaro.org>
References: <20221028073637.31195-1-vincent.guittot@linaro.org>
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

