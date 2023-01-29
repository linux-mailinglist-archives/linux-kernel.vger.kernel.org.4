Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D376168002A
	for <lists+linux-kernel@lfdr.de>; Sun, 29 Jan 2023 17:15:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234490AbjA2QPF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 29 Jan 2023 11:15:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35626 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230247AbjA2QPB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 29 Jan 2023 11:15:01 -0500
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com [IPv6:2a00:1450:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 06EEB1E288
        for <linux-kernel@vger.kernel.org>; Sun, 29 Jan 2023 08:15:00 -0800 (PST)
Received: by mail-wm1-x32b.google.com with SMTP id f47-20020a05600c492f00b003dc584a7b7eso466208wmp.3
        for <linux-kernel@vger.kernel.org>; Sun, 29 Jan 2023 08:14:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=layalina-io.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2tncCBFLnp+WCJ93GE2FIpHlFqL/aCFCr4164wpLh+c=;
        b=Rm3CR5Bp75dXxPO7Wimt0aVzPrFuobnCYOmm0gvU7xQG4PFCM8yv/0xJuQd61I5+st
         3BjcYeQB+nd7XyANCGVkONGJg7S9vckAxLo1aXd4RCQ1tet8wFvroA2LwxUbOQWYOBkO
         shcoB3nIgDyhBgeZzYa5uwuj+UzJ2+IAkMwTp6FzzQOJ6Q4HVqDfJtw/3lXrgmGc9Qov
         AjVaJTfdsaubGLguAVMJtGg3TZEGztuzd+K48+t4aatkvO54cDFjqcCogxFBfKSl/UtM
         l4l9932ZYcGp/gDtD+JxfVsp/rZsT8jzbkImHxb3yFQiSgB5RvDGItyzdPZ1hXOtkMFB
         pNew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2tncCBFLnp+WCJ93GE2FIpHlFqL/aCFCr4164wpLh+c=;
        b=DXkPblU2gLXT9VBklFfLtMoTf93X9l52DB/QQ/u8uEpQsW4jX22hqv7/Mxh1oPgK2i
         8KLV1JnBrHWIh9SMpgsE88Gv8ZNvID98KPoNnXKGCMP/AlL2Sw8/yCDtkl9j7iiA3Fl2
         xCubnJEYkbnqoDd2A/97xe4roYoOdzYQDzUV4MaEwEX6aL1uiowQkIHomVgY3WNgbwn8
         A/c1A4wxsXoSHEuTYK1aIZDAnKT7zcqRE7lfZHImI0yurdvwDTD0F4kUYvxu8rsAbp8n
         rfg4qM/3CM7MwDbGiVqh9vrCTRUssvc35CRAiEMc5IbvggTzT0Prd0HchpFW40o4oAqo
         f8rA==
X-Gm-Message-State: AO0yUKWiLD5aoMQgGIBJ1MKJxVyV/eXUcxWNRP6843Pa7Djj+pulawKF
        rDYzRT+zKMRDixb/UYtdKWGkfQ==
X-Google-Smtp-Source: AK7set/uXlesv/ouQzRQQdFkvS+p2FaBgzyN+RFEohRBjkKByGbxoguBWI8MqobqsRCWKaelj72dVA==
X-Received: by 2002:a05:600c:25ca:b0:3dc:46f6:e602 with SMTP id 10-20020a05600c25ca00b003dc46f6e602mr5595238wml.5.1675008898675;
        Sun, 29 Jan 2023 08:14:58 -0800 (PST)
Received: from localhost.localdomain (host86-163-35-10.range86-163.btcentralplus.com. [86.163.35.10])
        by smtp.gmail.com with ESMTPSA id e5-20020a05600c254500b003dc47fb33dasm5324783wma.18.2023.01.29.08.14.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 29 Jan 2023 08:14:58 -0800 (PST)
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
Subject: [PATCH 2/3] sched/uclamp: Ignore (util == 0) optimization in feec() when p_util_max = 0
Date:   Sun, 29 Jan 2023 16:14:43 +0000
Message-Id: <20230129161444.1674958-3-qyousef@layalina.io>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230129161444.1674958-1-qyousef@layalina.io>
References: <20230129161444.1674958-1-qyousef@layalina.io>
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
Signed-off-by: Qais Yousef (Google) <qyousef@layalina.io>
---
 kernel/sched/fair.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index ca2c389d3180..3521aad67aa0 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -7382,7 +7382,7 @@ static int find_energy_efficient_cpu(struct task_struct *p, int prev_cpu)
 	target = prev_cpu;
 
 	sync_entity_load_avg(&p->se);
-	if (!uclamp_task_util(p, p_util_min, p_util_max))
+	if (!uclamp_task_util(p, p_util_min, p_util_max) && p_util_max != 0)
 		goto unlock;
 
 	eenv_task_busy_time(&eenv, p, prev_cpu);
-- 
2.25.1

