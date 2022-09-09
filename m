Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E836A5B3899
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Sep 2022 15:05:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231559AbiIINEs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Sep 2022 09:04:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37292 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230021AbiIINDa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Sep 2022 09:03:30 -0400
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CDA8F10C98D
        for <linux-kernel@vger.kernel.org>; Fri,  9 Sep 2022 06:03:28 -0700 (PDT)
Received: by mail-wm1-x32a.google.com with SMTP id n17-20020a05600c3b9100b003b3235574dbso1262933wms.2
        for <linux-kernel@vger.kernel.org>; Fri, 09 Sep 2022 06:03:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=references:in-reply-to:message-id:date:subject:cc:to:from:from:to
         :cc:subject:date;
        bh=ShOnvvH2vqswW8cX/k2qHv7+hfeakBkSeirHaU9mNjk=;
        b=d4M6oTQTnjBsjWhNKa70McX6AvVURQd47g1V12uRxNdComNhjCeVuEODh+nV76IVxr
         pOCD/PbU4wZ/mssNETspS/X+dFTTTSZ1cgmKNQXwuDNXiVzbb479GLFmTGQU5MMsHXmj
         a7p5p0vDtv9HTPB/SasjUowr1S9W0tHsXYg6hP/Jy9SC3XANx9Cj64CLMxCkpibdrLtq
         R2GLX7uF3qvv8//i93k6Q5zEeC+GDgJfIVFW69mC9xxMPYz2b6j9L9H+ENo7YkCARrLQ
         GHHDPSfwTJrzastBddKuvsgQ3uze27W77we/RYzhR1OkKtlu+68exg0eBXCxMyQh/QWZ
         srxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :x-gm-message-state:from:to:cc:subject:date;
        bh=ShOnvvH2vqswW8cX/k2qHv7+hfeakBkSeirHaU9mNjk=;
        b=ZGMzkY2qYRHc5/jtAthIGuF2hOtp9uhAmezktbYEpDSpCj1yDXr0mwXDBaXWQ8gRlK
         tNk2qAJf4V5MW2HHtpBymUQNIFf30g0rbZHcpdkoOJ1Ix3kGe20RtLmXR8eohmCgAQ7m
         O7wslBKOcQhaVWRMyKl8eUi/3V+rBUpV1bVDknnfTZx0G2Ve3kwZUy1qBt3/bodvcj06
         F8Pvdgpx13UDM+4SInRXz6qsrdT1bCla8xRdq6RBcBc/8EMEd2480pMVBLPsRHATlbnv
         JiMPRBTR9Vy2CuDCYMfhb1Fpb0zdj1C5ljrnknGf6i7EAqxg3JTg4vOdrc9ZShXoPqdK
         X0IA==
X-Gm-Message-State: ACgBeo1IuZrSzZU+2WlpkGClNGSh9jN8KUNn6f9Bia66KfhrLx2dQ6/3
        zXMb3BlD6d0HXh4TUjkqwY3R8g==
X-Google-Smtp-Source: AA6agR7hmyS9LSv3EJFIQ4+FDrc7/3egK7U8v+wC8ZsYhBP4S//sVJVQaoOWi5l1QMrqQ8pxzs1fmQ==
X-Received: by 2002:a05:600c:3d19:b0:3a5:c6ef:a875 with SMTP id bh25-20020a05600c3d1900b003a5c6efa875mr5277822wmb.66.1662728606799;
        Fri, 09 Sep 2022 06:03:26 -0700 (PDT)
Received: from localhost.localdomain ([2a01:e0a:f:6020:c6e:e86:ab92:92b7])
        by smtp.gmail.com with ESMTPSA id m10-20020a05600c3b0a00b003a5f4fccd4asm569909wms.35.2022.09.09.06.03.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Sep 2022 06:03:26 -0700 (PDT)
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
Subject: [PATCH v3 7/8] sched/core: support latency priority with sched core
Date:   Fri,  9 Sep 2022 15:03:08 +0200
Message-Id: <20220909130309.25458-8-vincent.guittot@linaro.org>
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

Take into account wakeup_latency_gran() when ordering the cfs threads.

Signed-off-by: Vincent Guittot <vincent.guittot@linaro.org>
---
 kernel/sched/fair.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 6cc4f2a9725d..7563fb16aba1 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -11444,6 +11444,10 @@ bool cfs_prio_less(struct task_struct *a, struct task_struct *b, bool in_fi)
 	delta = (s64)(sea->vruntime - seb->vruntime) +
 		(s64)(cfs_rqb->min_vruntime_fi - cfs_rqa->min_vruntime_fi);
 
+	/* Take into account latency prio */
+	delta -= wakeup_latency_gran(sea, seb);
+
+
 	return delta > 0;
 }
 #else
-- 
2.17.1

