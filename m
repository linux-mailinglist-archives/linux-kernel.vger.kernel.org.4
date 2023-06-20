Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5AC32736E56
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Jun 2023 16:10:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233083AbjFTOJx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Jun 2023 10:09:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59312 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233208AbjFTOJt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Jun 2023 10:09:49 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F0F87E58
        for <linux-kernel@vger.kernel.org>; Tue, 20 Jun 2023 07:09:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1687270146;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=+LliIS9GzKVY7r+2Pd1dAZaFc5KbOmlOofBoCL5VmAU=;
        b=dH1V7G9yu6Fu+jEJoph0v9aLbgGGIZSLK+oU8gwJ+rgqu8ghf7jnULKNWX76I0X3TQl3Gt
        ovLTVcrAzSAIdFsbDA16zuRDidtntKLmW25EzcOoKd6fDBLKTnrVcSuoehJ0JsEcUDYWJ3
        KDBKTR4FIi0pgynMCUhkNHvkK8HWndk=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-9-uWgs1p_OOFmaIFWneI7weA-1; Tue, 20 Jun 2023 10:08:56 -0400
X-MC-Unique: uWgs1p_OOFmaIFWneI7weA-1
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.rdu2.redhat.com [10.11.54.10])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id EC30F28EA71F;
        Tue, 20 Jun 2023 14:06:34 +0000 (UTC)
Received: from llong.com (unknown [10.22.34.46])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 2A712425356;
        Tue, 20 Jun 2023 14:06:34 +0000 (UTC)
From:   Waiman Long <longman@redhat.com>
To:     Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Josh Poimboeuf <jpoimboe@kernel.org>,
        Pawan Gupta <pawan.kumar.gupta@linux.intel.com>,
        Jacob Pan <jacob.jun.pan@linux.intel.com>,
        Len Brown <lenb@kernel.org>
Cc:     linux-kernel@vger.kernel.org, x86@kernel.org,
        linux-pm@vger.kernel.org, Robin Jarry <rjarry@redhat.com>,
        Joe Mario <jmario@redhat.com>, Waiman Long <longman@redhat.com>
Subject: [PATCH v2 4/5] intel_idle: Add no_ibrs module parameter to force disable IBRS
Date:   Tue, 20 Jun 2023 10:06:24 -0400
Message-Id: <20230620140625.1001886-5-longman@redhat.com>
In-Reply-To: <20230620140625.1001886-1-longman@redhat.com>
References: <20230620140625.1001886-1-longman@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.10
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit bf5835bcdb96 ("intel_idle: Disable IBRS during long idle")
disables IBRS when the cstate is 6 or lower. However, there are
some use cases where a customer may want to use max_cstate=1 to
lower latency. Such use cases will suffer from the performance
degradation caused by the enabling of IBRS in the sibling idle thread.
Add a "no_ibrs" module parameter to force disable IBRS and the
CPUIDLE_FLAG_IRQ_ENABLE flag if set.

In the case of a Skylake server with max_cstate=1, this new no_ibrs
option will increase the IRQ response latency as IRQ will now be
disabled.

Signed-off-by: Waiman Long <longman@redhat.com>
---
 drivers/idle/intel_idle.c | 14 ++++++++++++--
 1 file changed, 12 insertions(+), 2 deletions(-)

diff --git a/drivers/idle/intel_idle.c b/drivers/idle/intel_idle.c
index 07fa23707b3c..366dacccc971 100644
--- a/drivers/idle/intel_idle.c
+++ b/drivers/idle/intel_idle.c
@@ -69,6 +69,7 @@ static int max_cstate = CPUIDLE_STATE_MAX - 1;
 static unsigned int disabled_states_mask __read_mostly;
 static unsigned int preferred_states_mask __read_mostly;
 static bool force_irq_on __read_mostly;
+static bool no_ibrs __read_mostly;
 
 static struct cpuidle_device __percpu *intel_idle_cpuidle_devices;
 
@@ -1907,12 +1908,15 @@ static void __init intel_idle_init_cstates_icpu(struct cpuidle_driver *drv)
 			WARN_ON_ONCE(state->flags & CPUIDLE_FLAG_IRQ_ENABLE);
 			state->enter = intel_idle_xstate;
 		} else if (cpu_feature_enabled(X86_FEATURE_KERNEL_IBRS) &&
-			   state->flags & CPUIDLE_FLAG_IBRS) {
+			  ((state->flags & CPUIDLE_FLAG_IBRS) || no_ibrs)) {
 			/*
 			 * IBRS mitigation requires that C-states are entered
 			 * with interrupts disabled.
 			 */
-			WARN_ON_ONCE(state->flags & CPUIDLE_FLAG_IRQ_ENABLE);
+			if (no_ibrs && (state->flags & CPUIDLE_FLAG_IRQ_ENABLE))
+				state->flags &= ~CPUIDLE_FLAG_IRQ_ENABLE;
+			else
+				WARN_ON_ONCE(state->flags & CPUIDLE_FLAG_IRQ_ENABLE);
 			state->enter = intel_idle_ibrs;
 		} else if (state->flags & CPUIDLE_FLAG_IRQ_ENABLE) {
 			state->enter = intel_idle_irq;
@@ -2165,3 +2169,9 @@ MODULE_PARM_DESC(preferred_cstates, "Mask of preferred idle states");
  * 'CPUIDLE_FLAG_INIT_XSTATE' and 'CPUIDLE_FLAG_IBRS' flags.
  */
 module_param(force_irq_on, bool, 0444);
+/*
+ * Force the disabling of IBRS when X86_FEATURE_KERNEL_IBRS is on and
+ * CPUIDLE_FLAG_IRQ_ENABLE isn't set.
+ */
+module_param(no_ibrs, bool, 0444);
+MODULE_PARM_DESC(no_ibrs, "Disable IBRS when idle");
-- 
2.31.1

