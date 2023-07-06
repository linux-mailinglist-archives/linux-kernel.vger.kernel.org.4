Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 628FB749E29
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jul 2023 15:51:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232248AbjGFNvv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Jul 2023 09:51:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60314 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229996AbjGFNvt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Jul 2023 09:51:49 -0400
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A915D1995
        for <linux-kernel@vger.kernel.org>; Thu,  6 Jul 2023 06:51:48 -0700 (PDT)
Received: by mail-wr1-x435.google.com with SMTP id ffacd0b85a97d-314172bb818so655593f8f.1
        for <linux-kernel@vger.kernel.org>; Thu, 06 Jul 2023 06:51:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1688651507; x=1691243507;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=T9Wtp7GAQLlCzMIbELA47/ReR5Ash9IIBcZpTnUw0Po=;
        b=iv8tS7TrXbH666aYwVrLb+kZWTnPHQ1XIkv7whFD3SeRiVO9/n1fAcw0KZLQnhHf8w
         P1fRKDdhZ8K6PHzfbYKB7yABaV6LSZEQNFINl9RXhp3PyThmXtGt7Ip/QsJLG0oIdTsN
         +WyUwE8pI6KVQYj8It0EW1s15mR+fVm3Bw5ObyyaSJ6uQtHdxDNgUeiX484jydlPr7m1
         yGkFijf+bax/VjUjfOOs5eFeaF2cJXGXCqDEjlz319kJrjTWMSlDwGxyekTfzevTRBUB
         1vpCXVr3s2Zr3UEjGJsHb2sLQiiowyKArrEoA/Uvg170NfmujkqZFxqkFaGg3cb5I1Un
         K70g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688651507; x=1691243507;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=T9Wtp7GAQLlCzMIbELA47/ReR5Ash9IIBcZpTnUw0Po=;
        b=PrO8XQALbohpID2zl9eLplX+hJ+S1y4+hE7a314qTiQdAxSQTuSonLR2tacHqaVK5d
         CxWnr+zdQee2IJT7ZrO+9RHAA1avMDm6vW/zBnRKrRKFhqCO0qSiZhfiDLbpDq1XnH8B
         T1choNgIx7XLTt6XEPHHj19jlTTVtxDI0yqJ+O8CAz200Vgmj8kxlBxmghWB/sCHCCaK
         IpD7w1nZLH/xCsTT7P+rWg721vSdMsfOe1atjr47Adwgkr3Jk0Ut+cQ4v3lO6xNwu9XZ
         gjvL3Sn56bNMcWQbvMyEULkPlPgh6q7T7xGOcc7Wkd4oWVxMtgEBz64a0ps/kSBWEpGk
         QiSQ==
X-Gm-Message-State: ABy/qLYDCZPmMc5rPfxjMIC8mQYucp9d0DXoEplLcE9sBqBrkQQNFXp6
        90yZRVpLiGuXE9zJqbpnEeTTCA==
X-Google-Smtp-Source: APBJJlEqwGX25FFDFwvXmCDm9yuHdw5jMseWx4u/AL9JQyx3KSE67c7ASPYtBYhrI60TJVLMZ2BxIQ==
X-Received: by 2002:a5d:6e86:0:b0:314:f18:bc65 with SMTP id k6-20020a5d6e86000000b003140f18bc65mr1649419wrz.66.1688651507171;
        Thu, 06 Jul 2023 06:51:47 -0700 (PDT)
Received: from vingu-book.. ([2a01:e0a:f:6020:fd1d:a4f4:6cc:dcc])
        by smtp.gmail.com with ESMTPSA id b18-20020adfe312000000b0031455482d1fsm698033wrj.47.2023.07.06.06.51.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Jul 2023 06:51:46 -0700 (PDT)
From:   Vincent Guittot <vincent.guittot@linaro.org>
To:     mingo@redhat.com, peterz@infradead.org, juri.lelli@redhat.com,
        dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
        mgorman@suse.de, bristot@redhat.com, vschneid@redhat.com,
        linux-kernel@vger.kernel.org
Cc:     qyousef@layalina.io, Vincent Guittot <vincent.guittot@linaro.org>
Subject: [PATCH] sched/fair: remove util_est boosting
Date:   Thu,  6 Jul 2023 15:51:44 +0200
Message-Id: <20230706135144.324311-1-vincent.guittot@linaro.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There is no need to use runnable_avg when estimating util_est and that
even generates wrong behavior because one includes blocked tasks whereas
the other one doesn't. This can lead to accounting twice the waking task p,
once with the blocked runnable_avg and another one when adding its
util_est.

cpu's runnable_avg is already used when computing util_avg which is then
compared with util_est.

In some situation, feec will not select prev_cpu but another one on the
same performance domain because of higher max_util

Fixes: 7d0583cf9ec7 ("sched/fair, cpufreq: Introduce 'runnable boosting'")
Signed-off-by: Vincent Guittot <vincent.guittot@linaro.org>
---
 kernel/sched/fair.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index a80a73909dc2..77c9f5816c31 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -7289,9 +7289,6 @@ cpu_util(int cpu, struct task_struct *p, int dst_cpu, int boost)
 
 		util_est = READ_ONCE(cfs_rq->avg.util_est.enqueued);
 
-		if (boost)
-			util_est = max(util_est, runnable);
-
 		/*
 		 * During wake-up @p isn't enqueued yet and doesn't contribute
 		 * to any cpu_rq(cpu)->cfs.avg.util_est.enqueued.
-- 
2.34.1

