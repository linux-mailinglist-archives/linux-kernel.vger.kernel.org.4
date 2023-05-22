Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F396770C9B2
	for <lists+linux-kernel@lfdr.de>; Mon, 22 May 2023 21:51:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235415AbjEVTur (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 May 2023 15:50:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44790 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235430AbjEVTun (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 May 2023 15:50:43 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 87F18C1
        for <linux-kernel@vger.kernel.org>; Mon, 22 May 2023 12:50:39 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0705762AF9
        for <linux-kernel@vger.kernel.org>; Mon, 22 May 2023 19:50:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D7C3AC4339E;
        Mon, 22 May 2023 19:50:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1684785038;
        bh=xhwlEoX8rvC3pCtoLzeLS25zj8ad4FOpCspq2DY7aWI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=H0g6emV7k8lIQO10fs31Pa3A6GG17bxFC7XyWvUpir4bw6I6i/d70RJ1Pkgwtk/T1
         FbVMh9yvJ+ZnGTW0TwlGJr9rQes/RycjA8oq0E0NWL4GA1/rZ07QrLEgRCxpjlu5Ks
         +WLT2bZyHOmq2V466tVtudS5Czsf52q69hisuTaKSM6JWjhkqJMwXhiphxC1cxGmXx
         Wk2CEcBTsekqSWbUArAq7H6oZT3HazUU+6R7ayMt3zhQHy3zVJvMyd0XAbeBqdDqA1
         32UZAzdt4Xpq4PoGvivUzuU6rjwb1Gp9YblXAGUM/1gzKCNosw9js5KqhyX6WaZCYk
         4f7qhEqUJPocw==
From:   Arnd Bergmann <arnd@kernel.org>
To:     Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>
Cc:     Arnd Bergmann <arnd@arndb.de>, Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Valentin Schneider <vschneid@redhat.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 2/5] sched: add schedule_user() declaration
Date:   Mon, 22 May 2023 21:50:18 +0200
Message-Id: <20230522195021.3456768-3-arnd@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230522195021.3456768-1-arnd@kernel.org>
References: <20230522195021.3456768-1-arnd@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Arnd Bergmann <arnd@arndb.de>

The schedule_user() function is used on powerpc and sparc architectures, but
only ever called from assembler, so it has no prototype, causing a harmless W=1
warning:

kernel/sched/core.c:6730:35: error: no previous prototype for 'schedule_user' [-Werror=missing-prototypes]

Add a prototype in sched/sched.h to shut up the warning.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 kernel/sched/sched.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index 1704763897d0..44b34836bb60 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -2376,6 +2376,7 @@ static inline struct cpuidle_state *idle_get_state(struct rq *rq)
 #endif
 
 extern void schedule_idle(void);
+asmlinkage void schedule_user(void);
 
 extern void sysrq_sched_debug_show(void);
 extern void sched_init_granularity(void);
-- 
2.39.2

