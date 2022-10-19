Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8C45160535F
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Oct 2022 00:47:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231150AbiJSWrV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Oct 2022 18:47:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36168 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230282AbiJSWrE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Oct 2022 18:47:04 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 91E0317C167;
        Wed, 19 Oct 2022 15:47:03 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 514B7B8261A;
        Wed, 19 Oct 2022 22:47:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EB837C433B5;
        Wed, 19 Oct 2022 22:47:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1666219621;
        bh=XdRd/D7YtnjF/VbtVQdPblQxfOL6jWA9yUi4elYsgMo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=CATtEuYG11NQ97X+dUT5iqaZitwvMN1GjLxxebL7NPDD4dxFA0yPhlkM/csd1ceU0
         5YpYWBZTlDcIDBhwd6d0OdN3MkPVI2tLW93lrNsg8w9aKtopPk/i42xNiXpnSQrikF
         9opL8UGvgpS2dC64Wl4SQKHNG9djEdMGQzGo5+nqC2ZAE0qEe7BEwQ9bVoEDpM1P1I
         zqxyAoxz6PzHlS9NsFx7aMOnhGD5niqY5M1NnljreFhSr0HeZEDtpzzYi5U1llCaEK
         2fsg1/4UBIGvOSBX7KbTKIxuiO9jPari1IRNCcENz39AozIrPniJi6mGm6EzuGUpMZ
         pDSXKJwdKXczw==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id A93345C0890; Wed, 19 Oct 2022 15:47:00 -0700 (PDT)
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, kernel-team@fb.com,
        rostedt@goodmis.org, Zeng Heng <zengheng4@huawei.com>,
        Mukesh Ojha <quic_mojha@quicinc.com>,
        "Paul E . McKenney" <paulmck@kernel.org>
Subject: [PATCH rcu 3/8] rcu: Remove unused 'cpu' in rcu_virt_note_context_switch()
Date:   Wed, 19 Oct 2022 15:46:54 -0700
Message-Id: <20221019224659.2499511-3-paulmck@kernel.org>
X-Mailer: git-send-email 2.31.1.189.g2e36527f23
In-Reply-To: <20221019224652.GA2499358@paulmck-ThinkPad-P17-Gen-1>
References: <20221019224652.GA2499358@paulmck-ThinkPad-P17-Gen-1>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Zeng Heng <zengheng4@huawei.com>

This commit removes the unused function argument 'cpu'.  This does not
change functionality, but might save a cycle or two.

Signed-off-by: Zeng Heng <zengheng4@huawei.com>
Acked-by: Mukesh Ojha <quic_mojha@quicinc.com>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 include/linux/kvm_host.h | 2 +-
 include/linux/rcutiny.h  | 2 +-
 include/linux/rcutree.h  | 2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/include/linux/kvm_host.h b/include/linux/kvm_host.h
index 32f259fa58013..381b92d146c71 100644
--- a/include/linux/kvm_host.h
+++ b/include/linux/kvm_host.h
@@ -416,7 +416,7 @@ static __always_inline void guest_context_enter_irqoff(void)
 	 */
 	if (!context_tracking_guest_enter()) {
 		instrumentation_begin();
-		rcu_virt_note_context_switch(smp_processor_id());
+		rcu_virt_note_context_switch();
 		instrumentation_end();
 	}
 }
diff --git a/include/linux/rcutiny.h b/include/linux/rcutiny.h
index 768196a5f39d6..9bc025aa79a30 100644
--- a/include/linux/rcutiny.h
+++ b/include/linux/rcutiny.h
@@ -142,7 +142,7 @@ static inline int rcu_needs_cpu(void)
  * Take advantage of the fact that there is only one CPU, which
  * allows us to ignore virtualization-based context switches.
  */
-static inline void rcu_virt_note_context_switch(int cpu) { }
+static inline void rcu_virt_note_context_switch(void) { }
 static inline void rcu_cpu_stall_reset(void) { }
 static inline int rcu_jiffies_till_stall_check(void) { return 21 * HZ; }
 static inline void rcu_irq_exit_check_preempt(void) { }
diff --git a/include/linux/rcutree.h b/include/linux/rcutree.h
index 5efb51486e8af..70795386b9ffa 100644
--- a/include/linux/rcutree.h
+++ b/include/linux/rcutree.h
@@ -27,7 +27,7 @@ void rcu_cpu_stall_reset(void);
  * wrapper around rcu_note_context_switch(), which allows TINY_RCU
  * to save a few bytes. The caller must have disabled interrupts.
  */
-static inline void rcu_virt_note_context_switch(int cpu)
+static inline void rcu_virt_note_context_switch(void)
 {
 	rcu_note_context_switch(false);
 }
-- 
2.31.1.189.g2e36527f23

