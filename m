Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9138E736E53
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Jun 2023 16:09:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232832AbjFTOJf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Jun 2023 10:09:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59266 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231528AbjFTOJd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Jun 2023 10:09:33 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 25A51B1
        for <linux-kernel@vger.kernel.org>; Tue, 20 Jun 2023 07:08:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1687270133;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=+DkmE6hETltBu3bPa+S3gxCm/8V55tvpJfZg0jQ8Gvw=;
        b=E7kQT7cLKuX9taJLlnGUXwiQHr9nrHKUW8X5S2HRmDgrl5Ms/UQyBAqb8URY4KRbGhzLlp
        +Qyk5X/2F4QPRmcEgT37msx0WIFboSIMrpNtu5lCCGI7RjHdnPrXavX5sSF2QZZLYrZVRS
        MAVKQhAhILSnJL6962oKRHw+2K4/z6U=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-37-2A_wpEtmMHKKyXq6jJXqlg-1; Tue, 20 Jun 2023 10:08:34 -0400
X-MC-Unique: 2A_wpEtmMHKKyXq6jJXqlg-1
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.rdu2.redhat.com [10.11.54.10])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 5130888711B;
        Tue, 20 Jun 2023 14:06:33 +0000 (UTC)
Received: from llong.com (unknown [10.22.34.46])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 91537425356;
        Tue, 20 Jun 2023 14:06:32 +0000 (UTC)
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
Subject: [PATCH v2 2/5] x86/idle: Disable IBRS when cpu is offline
Date:   Tue, 20 Jun 2023 10:06:22 -0400
Message-Id: <20230620140625.1001886-3-longman@redhat.com>
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
disables IBRS when the CPU enters long idle. However, when a CPU becomes
offline, the IBRS bit is still set when X86_FEATURE_KERNEL_IBRS is
enabled. That will impact the performance of a sibling CPU. Mitigate
this performance impact by clearing all the mitigation bits in SPEC_CTRL
MSR when offline and restoring the value of the MSR when it becomes
online again.

Signed-off-by: Waiman Long <longman@redhat.com>
---
 arch/x86/kernel/smpboot.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/arch/x86/kernel/smpboot.c b/arch/x86/kernel/smpboot.c
index 352f0ce1ece4..5ff82fef413c 100644
--- a/arch/x86/kernel/smpboot.c
+++ b/arch/x86/kernel/smpboot.c
@@ -84,6 +84,7 @@
 #include <asm/hw_irq.h>
 #include <asm/stackprotector.h>
 #include <asm/sev.h>
+#include <asm/nospec-branch.h>
 
 /* representing HT siblings of each logical CPU */
 DEFINE_PER_CPU_READ_MOSTLY(cpumask_var_t, cpu_sibling_map);
@@ -1838,12 +1839,24 @@ void __noreturn hlt_play_dead(void)
 
 void native_play_dead(void)
 {
+	u64 spec_ctrl = spec_ctrl_current();
+
+	if (cpu_feature_enabled(X86_FEATURE_KERNEL_IBRS)) {
+		this_cpu_write(x86_spec_ctrl_current, 0);
+		native_wrmsrl(MSR_IA32_SPEC_CTRL, 0);
+	}
+
 	play_dead_common();
 	tboot_shutdown(TB_SHUTDOWN_WFS);
 
 	mwait_play_dead();
 	if (cpuidle_play_dead())
 		hlt_play_dead();
+
+	if (cpu_feature_enabled(X86_FEATURE_KERNEL_IBRS)) {
+		native_wrmsrl(MSR_IA32_SPEC_CTRL, spec_ctrl);
+		this_cpu_write(x86_spec_ctrl_current, spec_ctrl);
+	}
 }
 
 #else /* ... !CONFIG_HOTPLUG_CPU */
-- 
2.31.1

