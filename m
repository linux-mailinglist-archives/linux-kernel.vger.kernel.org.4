Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B296A6D128A
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Mar 2023 00:48:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231378AbjC3Wsn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Mar 2023 18:48:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44810 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231225AbjC3WsA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Mar 2023 18:48:00 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 79F781116F;
        Thu, 30 Mar 2023 15:47:51 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E29D6621E0;
        Thu, 30 Mar 2023 22:47:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 19758C433B4;
        Thu, 30 Mar 2023 22:47:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1680216449;
        bh=UnyqkVnuslXzekz9+1Gncw3m0zj5nMMiSQbwc+YIH6s=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=GKyEm7GcvRV/RG7Bioq1PMNWrDOMyvhK0n7tauJgoXIsVnAZ+oV4+tjrGIhQxcoSI
         hKM/Ani7w0WOHCiNaxeri9ChHGMUZ+3tuVBU97RkYgvs/SpO+KXuBMaUrGuK3isvCM
         KxxgJtIC9FPg40jG7M3dCFSpnfiDQQC6SarC52acH/SZkAkz9gHvDBibWn3WohLn47
         DG6gRVYvVT51mDhLFjJ3dRfkXVqFH698lgSxyUeLdeKWr9TLDnO1P2CH/FWPtTzPvs
         85QbyvOWl7zpK9ok9yNnnA/Q58ZviGk2u5cmzSLC8Q7ygKxvAgVCFv0hqv5ip3Nu4F
         5QE9Zu976Kl1w==
Received: by paulmck-ThinkPad-P72.home (Postfix, from userid 1000)
        id 33FD8154048C; Thu, 30 Mar 2023 15:47:28 -0700 (PDT)
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, kernel-team@meta.com,
        rostedt@goodmis.org, hch@lst.de,
        "Paul E. McKenney" <paulmck@kernel.org>
Subject: [PATCH rcu 16/20] srcu: Check for readers at module-exit time
Date:   Thu, 30 Mar 2023 15:47:22 -0700
Message-Id: <20230330224726.662344-16-paulmck@kernel.org>
X-Mailer: git-send-email 2.40.0.rc2
In-Reply-To: <f1b6cd5f-f0b7-4748-abd5-0dcfef0ce126@paulmck-laptop>
References: <f1b6cd5f-f0b7-4748-abd5-0dcfef0ce126@paulmck-laptop>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-5.2 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If a given statically allocated in-module srcu_struct structure was ever
used for updates, srcu_module_going() will invoke cleanup_srcu_struct()
at module-exit time.  This will check for the error case of SRCU readers
persisting past module-exit time.  On the other hand, if this srcu_struct
structure never went through a grace period, srcu_module_going() only
invokes free_percpu(), which would result in strange failures if SRCU
readers persisted past module-exit time.

This commit therefore adds a srcu_readers_active() check to
srcu_module_going(), splatting if readers have persisted and refraining
from invoking free_percpu() in that case.  Better to leak memory than
to suffer silent memory corruption!

[ paulmck: Apply Zhang, Qiang1 feedback on memory leak. ]

Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 kernel/rcu/srcutree.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/kernel/rcu/srcutree.c b/kernel/rcu/srcutree.c
index 169a6513b739..f9dd6ed5503e 100644
--- a/kernel/rcu/srcutree.c
+++ b/kernel/rcu/srcutree.c
@@ -1911,7 +1911,8 @@ static void srcu_module_going(struct module *mod)
 		if (!rcu_seq_state(smp_load_acquire(&ssp->srcu_sup->srcu_gp_seq_needed)) &&
 		    !WARN_ON_ONCE(!ssp->srcu_sup->sda_is_static))
 			cleanup_srcu_struct(ssp);
-		free_percpu(ssp->sda);
+		if (!WARN_ON(srcu_readers_active(ssp)))
+			free_percpu(ssp->sda);
 	}
 }
 
-- 
2.40.0.rc2

