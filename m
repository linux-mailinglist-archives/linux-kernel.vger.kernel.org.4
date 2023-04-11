Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AD6CA6DD63C
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Apr 2023 11:07:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229541AbjDKJH5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Apr 2023 05:07:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57396 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230143AbjDKJHf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Apr 2023 05:07:35 -0400
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com [IPv6:2a00:1450:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D5E85255
        for <linux-kernel@vger.kernel.org>; Tue, 11 Apr 2023 02:06:18 -0700 (PDT)
Received: by mail-wm1-x335.google.com with SMTP id he13so9077678wmb.2
        for <linux-kernel@vger.kernel.org>; Tue, 11 Apr 2023 02:06:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1681203975; x=1683795975;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=nBNGacbF07FZH7mdk0ao9ocLFdA1Ut7N82DEN5G+nVg=;
        b=fq6DJEl84HSE6qWfk5oPUTzDvkQxHI3FB+3cpMQYe2BfJ1s/UlpjyOX/zx4BKTqR0N
         jx3j4Zn33JW/H8vDhr8kB/n1tmuVIrZAmX1h4qC/g8XddpeQ1Yrvpqh4AxDX2781+5Ic
         SAIXf6EiFeSksH204iXgIVDn2HHum94SkRO0ny/cxGcOAAA15JzDf8z9PRonPbo0lIEn
         +ymkjjgnzm76xvumxaY+Ul26svyIuykLu4qoucocoUTSnCVdAGvgDQo6XsXIrcKjB9CB
         2GE6172xinBB1FqKLIVzSy2vjAXGVAhAiIOfNyms1Bgnqe/9RWvLoB/XGkwV9RWUMP0L
         5s0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1681203975; x=1683795975;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=nBNGacbF07FZH7mdk0ao9ocLFdA1Ut7N82DEN5G+nVg=;
        b=MOk5CQDAnzkQ5qFa49Sh/o1LQ1ORJvruSpxy43G5TyxZht2cYqTxQLcxsoTav/IAwN
         iOlLIRIbOz3Qxa2sg0daaTsfTW8oGWpcio9Npg6PGyNcJghtGZC4Pj354suDxKY5gqzC
         Xnvd6UeobVMhbiMtaKfzk8uiKzvA8F5eCSyLIWkOT1bGXqSw+vkpYSFgfu8PRg6ZkLTG
         iLND9Omzrecj6uZlaPlWAbsXcbW3btXBEec5MoKAYzTwQuOpGSedI4rll0gYzW7Bn7Ym
         heTo1bqGHSDWessi8vMg5zFGsTNE0b+31dKE/52VkKutdSbQsFXMp2kcSz4FDQvSMXlP
         7Ltg==
X-Gm-Message-State: AAQBX9e8r/wjQNgLJ1tJtUXUvWsP0IcloMoTmDWVs054oiRVzCPMbjz8
        zRx/kcnGp1f1H/htpxCQAv7eYg==
X-Google-Smtp-Source: AKy350Z2bTcgtKHJkj800dRlUzRKxNqGvXY3fSVjQtz4HV2B5pV8yypCCGIbS2SXW1H0/84/EA37+Q==
X-Received: by 2002:a1c:7712:0:b0:3ed:1fa1:73c5 with SMTP id t18-20020a1c7712000000b003ed1fa173c5mr9203955wmi.27.1681203975139;
        Tue, 11 Apr 2023 02:06:15 -0700 (PDT)
Received: from vingu-book.. ([2a01:e0a:f:6020:7e49:2f35:2c5:8b43])
        by smtp.gmail.com with ESMTPSA id s9-20020a7bc389000000b003ef64affec7sm16274526wmj.22.2023.04.11.02.06.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Apr 2023 02:06:14 -0700 (PDT)
From:   Vincent Guittot <vincent.guittot@linaro.org>
To:     mingo@redhat.com, peterz@infradead.org, juri.lelli@redhat.com,
        dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
        mgorman@suse.de, bristot@redhat.com, vschneid@redhat.com,
        linux-kernel@vger.kernel.org, tjcao980311@gmail.com
Cc:     Vincent Guittot <vincent.guittot@linaro.org>
Subject: [PATCH] sched/fair: fix imbalance overflow
Date:   Tue, 11 Apr 2023 11:06:11 +0200
Message-Id: <20230411090611.627225-1-vincent.guittot@linaro.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When local group is fully busy but its average load is above system load,
computing the imbalance will overflow and local group is not the best
target for pulling this load.

Fixes: 0b0695f2b34a ("sched/fair: Rework load_balance()")
Reported-by: Tingjia Cao <tjcao980311@gmail.com>
Link: https://lore.kernel.org/lkml/CABcWv9_DAhVBOq2=W=2ypKE9dKM5s2DvoV8-U0+GDwwuKZ89jQ@mail.gmail.com/T/
Signed-off-by: Vincent Guittot <vincent.guittot@linaro.org>
---

Hi Tingjia,

Thanks for the detailed bug report. I have been able to reproduce the problem and this
patch fixes it on my setup. Could you try it ?

Thanks,
Vincent

 kernel/sched/fair.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index f5da01a6b35a..184b0dbb2a69 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -10209,6 +10209,16 @@ static inline void calculate_imbalance(struct lb_env *env, struct sd_lb_stats *s
 
 		sds->avg_load = (sds->total_load * SCHED_CAPACITY_SCALE) /
 				sds->total_capacity;
+
+		/*
+		 * If the local group is more loaded than the average system
+		 * load, don't try to pull any tasks.
+		 */
+		if (local->avg_load >= sds->avg_load) {
+			env->imbalance = 0;
+			return;
+		}
+
 	}
 
 	/*
-- 
2.34.1

