Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4BCF268B238
	for <lists+linux-kernel@lfdr.de>; Sun,  5 Feb 2023 23:43:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229656AbjBEWnj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 5 Feb 2023 17:43:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49922 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229621AbjBEWng (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 5 Feb 2023 17:43:36 -0500
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com [IPv6:2a00:1450:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 50DDF1A97A
        for <linux-kernel@vger.kernel.org>; Sun,  5 Feb 2023 14:43:35 -0800 (PST)
Received: by mail-ej1-x633.google.com with SMTP id ud5so29496468ejc.4
        for <linux-kernel@vger.kernel.org>; Sun, 05 Feb 2023 14:43:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=layalina-io.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iqPeO/kNGQGc1U6cNoUfj1cL/02jGGj55jKIfeMBJNg=;
        b=apA3c6eDRcMeQ3Nve4KdAFI74pKWD9vJPKKZpCZ/HAILY0DgzjeQcRi8Zb9Zkf8TqJ
         4Rn8f9MDiKOJ0oeNkWy/rmJtbw7/VfoxMWzPnKw1PRj0r3v+ubz8dwRO/76dBhWn28cn
         WWELacMc7LuFipok14FAxsmsSLq0A2UrB4jgEetCe6fEITMmMtAeK9o2pyPjaTVt2QIh
         oDyRaNdUKF+AlM5v/lcZLFfd78jjKoFuFNT5P6Di66OQdl3Y1tG7swhrK/i3Kqrs8Urv
         rJR53AfbAQ2M4lH8HRSnBd21qh+viMQWXsIhp/3iTHPBzlV8QC0Eq+GELeuhGcGm4/a1
         9R5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=iqPeO/kNGQGc1U6cNoUfj1cL/02jGGj55jKIfeMBJNg=;
        b=BDQ1VUAw+hJfE37QpViYQVd6egoE/4pVM4BAOkWslmzJunkp38fFXLdIuolPKfSWft
         P9rbQzmqMzkS53kmDVRChfBTNjD+fvIcfkAISjZIAZT8eE2BbZlx1TVUxgaEGjlALC9g
         MaWm56gCQHnIVgYviVHoqy/SX1uLUObg8+3yXIcs8I7/CAwEF0INYQy+6OxK7MxDTCLQ
         WpyLef73BkjIKXfBx8thE3FlfVfOObvbgGark64h4sM7nrXPc0LHyMHkorh2h3Lr1AGw
         7EYRQS0sT73N1CZlWKu6Mej2qnrnzOxHncyGDv7PEAbZkt6/fcVPzBox37ekar2Y6pBP
         oqpQ==
X-Gm-Message-State: AO0yUKWX5aYV736TxPjD8+wBAZSsVMSUPFhKY5xmnXLF+GZ5i0BmDS+S
        +bcOzgB8JlWxPRKygeUWh/fCReKm/fpd1Ktz
X-Google-Smtp-Source: AK7set+65pkNQe/XnpAQI7bikzIj1Nwh1bGanSkPTNADGJbVb43oKSusNwotgp6TmYKgpjLB9QreMg==
X-Received: by 2002:a17:906:1291:b0:88a:73b7:6d5f with SMTP id k17-20020a170906129100b0088a73b76d5fmr14446059ejb.10.1675637013831;
        Sun, 05 Feb 2023 14:43:33 -0800 (PST)
Received: from localhost.localdomain (host86-163-35-10.range86-163.btcentralplus.com. [86.163.35.10])
        by smtp.gmail.com with ESMTPSA id m15-20020a1709061ecf00b0087bd2924e74sm4550779ejj.205.2023.02.05.14.43.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 05 Feb 2023 14:43:33 -0800 (PST)
From:   Qais Yousef <qyousef@layalina.io>
To:     Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>
Cc:     linux-kernel@vger.kernel.org, Lukasz Luba <lukasz.luba@arm.com>,
        Wei Wang <wvw@google.com>, Xuewen Yan <xuewen.yan94@gmail.com>,
        Hank <han.lin@mediatek.com>,
        Jonathan JMChen <Jonathan.JMChen@mediatek.com>,
        Qais Yousef <qyousef@layalina.io>
Subject: [PATCH v2 2/3] sched/uclamp: Ignore (util == 0) optimization in feec() when p_util_max = 0
Date:   Sun,  5 Feb 2023 22:43:17 +0000
Message-Id: <20230205224318.2035646-3-qyousef@layalina.io>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230205224318.2035646-1-qyousef@layalina.io>
References: <20230205224318.2035646-1-qyousef@layalina.io>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

find_energy_efficient_cpu() bails out early if effective util of the
task is 0. When uclamp is being used, this could lead to wrong decisions
when uclamp_max is set to 0. Cater for that.

Fixes: d81304bc6193 ("sched/uclamp: Cater for uclamp in find_energy_efficient_cpu()'s early exit condition")
Signed-off-by: Qais Yousef <qyousef@layalina.io>
---
 kernel/sched/fair.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 7a21ee74139f..a8c3d92ff3f6 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -7374,7 +7374,7 @@ static int find_energy_efficient_cpu(struct task_struct *p, int prev_cpu)
 	target = prev_cpu;
 
 	sync_entity_load_avg(&p->se);
-	if (!uclamp_task_util(p, p_util_min, p_util_max))
+	if (!uclamp_task_util(p, p_util_min, p_util_max) && p_util_max != 0)
 		goto unlock;
 
 	eenv_task_busy_time(&eenv, p, prev_cpu);
-- 
2.25.1

