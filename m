Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A98E770C9B1
	for <lists+linux-kernel@lfdr.de>; Mon, 22 May 2023 21:51:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235460AbjEVTuv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 May 2023 15:50:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44774 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235422AbjEVTup (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 May 2023 15:50:45 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 97D44184
        for <linux-kernel@vger.kernel.org>; Mon, 22 May 2023 12:50:42 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 162C062B04
        for <linux-kernel@vger.kernel.org>; Mon, 22 May 2023 19:50:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E0258C433EF;
        Mon, 22 May 2023 19:50:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1684785041;
        bh=DfCIKMSnSbVddp/C9i9OSpp88I+LZk39yiHKdmQAty0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=PYEj2zOl4sr+IPXQ2IhzxhmUaEl68mRHT68KXDtpvG03OJsbvAgC5n6lsQ2UKyVqb
         YtWkwMdy73DW6kHmOJ2ZF+BajlBadfaHhEUz0kqYkOx9aPM0kgGM8xEps1mWqJCOwe
         8bvQFdtDtsar4Yuqhr1mnhAidLPWxM85+HVmq7bMCmCGK5ohb4rbZ5igCRn1TITVgJ
         C8EGEv+tf3AsEX3fI+eQ3XaBeMjCqMb1JXpDK+PwcX60ZJzwUTjD7YBldQWaS03jF2
         L6p74B5L3bAfBP/VrDwvQzxCHY9U9rifoc1zjWri3YqPBRTYAQo7sCDFw5GATkfLpv
         QhmQ9g+2h/Glw==
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
Subject: [PATCH 3/5] sched: fair: hide unused init_cfs_bandwidth() stub
Date:   Mon, 22 May 2023 21:50:19 +0200
Message-Id: <20230522195021.3456768-4-arnd@kernel.org>
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

init_cfs_bandwidth() is only used when CONFIG_FAIR_GROUP_SCHED is
enabled, and without this causes a W=1 warning for the missing prototype:

kernel/sched/fair.c:6131:6: error: no previous prototype for 'init_cfs_bandwidth'

The normal implementation is only defined for CONFIG_CFS_BANDWIDTH,
so the stub exists when CFS_BANDWIDTH is disabled but FAIR_GROUP_SCHED
is enabled.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 kernel/sched/fair.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 2c1b345c3b8d..a7a8ccde3bd7 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -6169,9 +6169,8 @@ static inline int throttled_lb_pair(struct task_group *tg,
 	return 0;
 }
 
-void init_cfs_bandwidth(struct cfs_bandwidth *cfs_b) {}
-
 #ifdef CONFIG_FAIR_GROUP_SCHED
+void init_cfs_bandwidth(struct cfs_bandwidth *cfs_b) {}
 static void init_cfs_rq_runtime(struct cfs_rq *cfs_rq) {}
 #endif
 
-- 
2.39.2

