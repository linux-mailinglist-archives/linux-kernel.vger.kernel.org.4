Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0657D627CBF
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Nov 2022 12:46:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236725AbiKNLqg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Nov 2022 06:46:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42322 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236332AbiKNLqC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Nov 2022 06:46:02 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B5D3DA473
        for <linux-kernel@vger.kernel.org>; Mon, 14 Nov 2022 03:44:59 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 53F4C6106E
        for <linux-kernel@vger.kernel.org>; Mon, 14 Nov 2022 11:44:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AAD94C43146;
        Mon, 14 Nov 2022 11:44:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1668426298;
        bh=s+opGJ7QoOGk4sclN8NLpDopS2NNvFfrwRO9izFas60=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=PJ6WVKuI/QgsSuRDFCKOvAO0uUM0gU8psBNgN+vVzgutS5/SEveoHFBC8sti98ChE
         21raGHbXdg1YvVHO1pwKMyCQ79tbvGbCsBATj5YZM6qdlZV07GqGvxGZAfw/B3kQsg
         MoY8iU5jOKJpwYVBSP2fgzkJWa3naU5SYi95ul/KKOTG3T2MMcmJbV/UetvmyFR4rO
         kyxdeQEndDY9ETWR1hlki3J3//BGzIO3tD1UvsGblsDOUbFQwl2QvsSt2BVK+tZpzQ
         Q+EvDa4orxePuIVGvDuJ9hFPzjoUk703JRBFaCQTbyKRTCU67lhK9dSnEcv9pb+Fo1
         UJ+XyfhxOgjRg==
From:   "Jiri Slaby (SUSE)" <jirislaby@kernel.org>
To:     linux-kernel@vger.kernel.org
Cc:     Andi Kleen <andi@firstfloor.org>, Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Valentin Schneider <vschneid@redhat.com>,
        Andi Kleen <ak@linux.intel.com>, Martin Liska <mliska@suse.cz>,
        Jiri Slaby <jslaby@suse.cz>
Subject: [PATCH 25/46] sched, lto: mark sched classes as __noreorder
Date:   Mon, 14 Nov 2022 12:43:23 +0100
Message-Id: <20221114114344.18650-26-jirislaby@kernel.org>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20221114114344.18650-1-jirislaby@kernel.org>
References: <20221114114344.18650-1-jirislaby@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Andi Kleen <andi@firstfloor.org>

The scheduler code assumes that the scheduler classes are in a
particular order in memory. gcc LTO can violate this. Specify
__noreorder to avoid a boot BUG().

Cc: Ingo Molnar <mingo@redhat.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Juri Lelli <juri.lelli@redhat.com>
Cc: Vincent Guittot <vincent.guittot@linaro.org>
Cc: Dietmar Eggemann <dietmar.eggemann@arm.com>
Cc: Steven Rostedt <rostedt@goodmis.org>
Cc: Ben Segall <bsegall@google.com>
Cc: Mel Gorman <mgorman@suse.de>
Cc: Daniel Bristot de Oliveira <bristot@redhat.com>
Cc: Valentin Schneider <vschneid@redhat.com>
Signed-off-by: Andi Kleen <ak@linux.intel.com>
Signed-off-by: Martin Liska <mliska@suse.cz>
Signed-off-by: Jiri Slaby <jslaby@suse.cz>
---
 kernel/sched/sched.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index a4a20046e586..fe2703528972 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -2230,6 +2230,7 @@ static inline void set_next_task(struct rq *rq, struct task_struct *next)
  */
 #define DEFINE_SCHED_CLASS(name) \
 const struct sched_class name##_sched_class \
+	__noreorder \
 	__aligned(__alignof__(struct sched_class)) \
 	__section("__" #name "_sched_class")
 
-- 
2.38.1

