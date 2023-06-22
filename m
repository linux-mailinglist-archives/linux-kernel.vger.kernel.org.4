Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3C4E47393E4
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Jun 2023 02:37:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229974AbjFVAhi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Jun 2023 20:37:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60378 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229798AbjFVAh2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Jun 2023 20:37:28 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0EFC6198B
        for <linux-kernel@vger.kernel.org>; Wed, 21 Jun 2023 17:36:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1687394207;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Y2K8vEOPDcz7x2LNRwFb2B2QKeE2WWX5WNiQAkU03hs=;
        b=gI/jtJe2eF1/nXGfpAG0TGcyKi4YoWcpu5k+zl9DpaTcyTfPB04VGrQeriyrS3+Gie3lE6
        FK37i8FeFUzqpCkL+jGdlncE+U4vuTvtlgfGd1SU/74MI6XcpEq3CKlHad2F+/z7384nmm
        Xx72ickvbYJzFwuV8vldGu9z+BwgoP8=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-225-bkmuxB6oP4CXjIe5kkZ_qw-1; Wed, 21 Jun 2023 20:36:44 -0400
X-MC-Unique: bkmuxB6oP4CXjIe5kkZ_qw-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com [10.11.54.3])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id BEC2D85A58A;
        Thu, 22 Jun 2023 00:36:42 +0000 (UTC)
Received: from llong.com (unknown [10.22.33.143])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 09587112132E;
        Thu, 22 Jun 2023 00:36:41 +0000 (UTC)
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
Subject: [PATCH v3 1/3] x86/idle: Disable IBRS when cpu is offline
Date:   Wed, 21 Jun 2023 20:36:01 -0400
Message-Id: <20230622003603.1188364-2-longman@redhat.com>
In-Reply-To: <20230622003603.1188364-1-longman@redhat.com>
References: <20230622003603.1188364-1-longman@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.3
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit bf5835bcdb96 ("intel_idle: Disable IBRS during long idle")
disables IBRS when the CPU enters long idle. However, when a CPU
becomes offline, the IBRS bit is still set when X86_FEATURE_KERNEL_IBRS
is enabled. That will impact the performance of a sibling CPU. Mitigate
this performance impact by clearing all the mitigation bits in SPEC_CTRL
MSR when offline. When the CPU is online again, it will be re-initialized
and so restoring the SPEC_CTRL value isn't needed.

Add a comment to say that native_play_dead() is a __noreturn function,
but it can't be marked as such to avoid confusion about the missing
MSR restoration code.

Signed-off-by: Waiman Long <longman@redhat.com>
---
 arch/x86/kernel/smpboot.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/arch/x86/kernel/smpboot.c b/arch/x86/kernel/smpboot.c
index 352f0ce1ece4..7bc33885518c 100644
--- a/arch/x86/kernel/smpboot.c
+++ b/arch/x86/kernel/smpboot.c
@@ -84,6 +84,7 @@
 #include <asm/hw_irq.h>
 #include <asm/stackprotector.h>
 #include <asm/sev.h>
+#include <asm/nospec-branch.h>
 
 /* representing HT siblings of each logical CPU */
 DEFINE_PER_CPU_READ_MOSTLY(cpumask_var_t, cpu_sibling_map);
@@ -1836,8 +1837,17 @@ void __noreturn hlt_play_dead(void)
 	}
 }
 
+/*
+ * naitve_play_dead() is essentially a __noreturn function, but it can't
+ * be marked as such as the compiler may complain about it.
+ */
 void native_play_dead(void)
 {
+	if (cpu_feature_enabled(X86_FEATURE_KERNEL_IBRS)) {
+		this_cpu_write(x86_spec_ctrl_current, 0);
+		native_wrmsrl(MSR_IA32_SPEC_CTRL, 0);
+	}
+
 	play_dead_common();
 	tboot_shutdown(TB_SHUTDOWN_WFS);
 
-- 
2.31.1

