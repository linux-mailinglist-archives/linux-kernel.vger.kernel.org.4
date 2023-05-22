Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0B95770C9AF
	for <lists+linux-kernel@lfdr.de>; Mon, 22 May 2023 21:51:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235416AbjEVTup (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 May 2023 15:50:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44774 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235402AbjEVTuj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 May 2023 15:50:39 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F93BCF
        for <linux-kernel@vger.kernel.org>; Mon, 22 May 2023 12:50:36 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0066962AF3
        for <linux-kernel@vger.kernel.org>; Mon, 22 May 2023 19:50:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D58A8C433EF;
        Mon, 22 May 2023 19:50:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1684785035;
        bh=n3hkm02LXOePQNQAyKjmIwhyEzCueusGC98dUMzLcs0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=crnD9m0k8IK17T1hRcrALDIZrL2EZaxdKR6l3kSP9Sc6qK6RjlP+rnDSjK8su+7gY
         qLQ39mynAkbAdU554KNuGFPS4gpTofqUIUje1UTpXRXzfZSh0/i38G9ukA6du0PVv4
         XtxmOpbdisIh/b5flVzP0OGOIbuUFMG9w8U+Hcpe+ZPymTX2XqqS6KcHVEnbEa8Lua
         3Wlcd335L0P/WFlSdcuCjRAu2LVLKD4xC8qZ6W0tz/+sprXb865bayP075BDmJmZaA
         FUWK+9471aAPy7W3pj5VAtG0aoZrIZwG3QsH4LoJaVfiqdRTB6B6BUijwqEx+qvL8n
         ub8rfSp9miAwA==
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
Subject: [PATCH 1/5] sched: hide unused sched_update_scaling()
Date:   Mon, 22 May 2023 21:50:17 +0200
Message-Id: <20230522195021.3456768-2-arnd@kernel.org>
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

This function is only used when CONFIG_SMP is enabled, without that there
is no caller and no prototype:

kernel/sched/fair.c:688:5: error: no previous prototype for 'sched_update_scaling' [-Werror=missing-prototypes

Hide the definition in the same #ifdef check as the declaration.

Fixes: 8a99b6833c88 ("sched: Move SCHED_DEBUG sysctl to debugfs")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 kernel/sched/fair.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 48b6f0ca13ac..2c1b345c3b8d 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -684,7 +684,7 @@ struct sched_entity *__pick_last_entity(struct cfs_rq *cfs_rq)
 /**************************************************************
  * Scheduling class statistics methods:
  */
-
+#ifdef CONFIG_SMP
 int sched_update_scaling(void)
 {
 	unsigned int factor = get_update_sysctl_factor();
@@ -702,6 +702,7 @@ int sched_update_scaling(void)
 	return 0;
 }
 #endif
+#endif
 
 /*
  * delta /= w
-- 
2.39.2

