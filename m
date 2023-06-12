Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D7BD672B61F
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Jun 2023 05:35:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234015AbjFLDf0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 11 Jun 2023 23:35:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56546 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230215AbjFLDfX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 11 Jun 2023 23:35:23 -0400
Received: from mail-qk1-x72c.google.com (mail-qk1-x72c.google.com [IPv6:2607:f8b0:4864:20::72c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8AEA0F5
        for <linux-kernel@vger.kernel.org>; Sun, 11 Jun 2023 20:35:21 -0700 (PDT)
Received: by mail-qk1-x72c.google.com with SMTP id af79cd13be357-75d4dd6f012so393391085a.2
        for <linux-kernel@vger.kernel.org>; Sun, 11 Jun 2023 20:35:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1686540920; x=1689132920;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=13wsVNDxAZaF4hfb/peWxhJE5uamDpPrqEy4mn/h2BI=;
        b=KQnr5xGoMlKKSGmOAC6jhuNnwZxpoXkXmccClIm8F0EwQfjAc0w4ko8/yH0nCjbzXT
         cHk+393MMYOicZ3XlgPWk0krMighNb910/vwL+LJjLITAFWPY/PoZQr2Our7uFs015u/
         ySxDoItQnpen88LObdmevgGZm+00n6RVsMKLiQc6wZKIf6J9b2O/lCAl1lbpUdVuLQBd
         9CmXoOYv6Bw+O2rOHMvkFNm0ANPiteFYnV2c4vpejJMLRjrjhrxTOXUE/oZh2eS9Nv82
         //eloe0mz1w7QI+f4K8nRuQmPgMuPp2zt9qXmtCG0wMGEI2seCI1+16cMScbMCKaUMbE
         6KXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686540920; x=1689132920;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=13wsVNDxAZaF4hfb/peWxhJE5uamDpPrqEy4mn/h2BI=;
        b=Y58tYaMnHIh6gzDV6MUQ0pm33Z9HY5KmNfhh1SJDeyj5L9tIJd4Sy6xvExijxB3YD9
         WlVQsQZaNltAmGbgukf/8jya9brZQS/13j+COHjBazbNwsdscATuNoOlboMbEwpqLK1Y
         SwDYiuVBVlTbC7P/qc3nrPZYWjzPwCnXEAPFtL2FTdubZlC69WWYyN/Nux5jopoBGRYs
         khCJNYBfTgrk5hG2JtV6XPfW5sKkihrHz4Ar2/4iNvrSx9QD6iU0YOQoy8mfxIBNvj3j
         uxbgqcpMtCK/rSBEYgcibp7PeRwquUrB0izq3YtFYYNUsNAXDo80fjG/PrVCFGtZIJuD
         Z9UA==
X-Gm-Message-State: AC+VfDytm2V+GQfwsL/pxPxBya3Lmm7sPpsre+4D0NwjuRf1Iul1xktZ
        +rfkLzcwHHlCRn0+vB51ltI=
X-Google-Smtp-Source: ACHHUZ4IKkViKhJTGm0lMa0NO6oiRgewIL5/WI8E6t9BM6RE1Rx1ZQIkRZ7J+N4OTKt0E4jUIpMjyA==
X-Received: by 2002:a05:620a:871a:b0:75c:b919:b4e5 with SMTP id px26-20020a05620a871a00b0075cb919b4e5mr7828850qkn.32.1686540920564;
        Sun, 11 Jun 2023 20:35:20 -0700 (PDT)
Received: from localhost.localdomain ([203.205.141.10])
        by smtp.googlemail.com with ESMTPSA id jk14-20020a170903330e00b001b050df0a93sm7019107plb.93.2023.06.11.20.35.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 11 Jun 2023 20:35:20 -0700 (PDT)
From:   Ze Gao <zegao2021@gmail.com>
X-Google-Original-From: Ze Gao <zegao@tencent.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Ben Segall <bsegall@google.com>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Ingo Molnar <mingo@redhat.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Mel Gorman <mgorman@suse.de>,
        Steven Rostedt <rostedt@goodmis.org>,
        Valentin Schneider <vschneid@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        linux-kernel@vger.kernel.org, Ze Gao <zegao@tencent.com>
Subject: [PATCH] sched_fork: Use READ_ONCE() for lockless read of current->normal_prio
Date:   Mon, 12 Jun 2023 11:35:05 +0800
Message-Id: <20230612033505.8148-1-zegao@tencent.com>
X-Mailer: git-send-email 2.40.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The current->normal_prio is locklessly accessed from sched_fork and
child's scheduler related initialization procedures heavily rely on
the value loaded. Thus we mark this load as READ_ONCE in case of
possible load tearing due to concurrent access from other paths, for
example if changes of parent's normal_prio happens to be requested
via some syscall.

Signed-off-by: Ze Gao <zegao@tencent.com>
---
 kernel/sched/core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 944c3ae39861..37a13e4b734d 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -4699,7 +4699,7 @@ int sched_fork(unsigned long clone_flags, struct task_struct *p)
 	/*
 	 * Make sure we do not leak PI boosting priority to the child.
 	 */
-	p->prio = current->normal_prio;
+	p->prio = READ_ONCE(current->normal_prio);
 
 	uclamp_fork(p);
 
-- 
2.40.1

