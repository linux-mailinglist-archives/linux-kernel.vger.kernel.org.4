Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 36CC4736E59
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Jun 2023 16:10:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233029AbjFTOKh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Jun 2023 10:10:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59628 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233171AbjFTOK2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Jun 2023 10:10:28 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8FF5410D5
        for <linux-kernel@vger.kernel.org>; Tue, 20 Jun 2023 07:09:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1687270186;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=VrByPcLlZJlbrBKqAsdOzQ0Sy0EOhnQ6P87fZxDadIk=;
        b=IWaZ+TXxG/E4UhYYb2Blw7BdEG8PL6+0owAFrie92GGbyL0ORfq7913PusoCCM+T257Jqx
        2jXek9uB1kgeoeeoRbUtIdSL0IaMpe99MMxArQbsOaPyHHzOjpFGaOVmi1PXVVDOy3OhQh
        1u2PoCgsazkq2xQmB90n9ncbxgOW+Ak=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-466-rhmpZFmgOz-Gw5i0hq2awQ-1; Tue, 20 Jun 2023 10:09:26 -0400
X-MC-Unique: rhmpZFmgOz-Gw5i0hq2awQ-1
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.rdu2.redhat.com [10.11.54.10])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id BC295104D984;
        Tue, 20 Jun 2023 14:06:35 +0000 (UTC)
Received: from llong.com (unknown [10.22.34.46])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 078BD425357;
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
Subject: [PATCH v2 5/5] x86/idle: Disable IBRS entering mwait idle and enable it on wakeup
Date:   Tue, 20 Jun 2023 10:06:25 -0400
Message-Id: <20230620140625.1001886-6-longman@redhat.com>
In-Reply-To: <20230620140625.1001886-1-longman@redhat.com>
References: <20230620140625.1001886-1-longman@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.10
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When a user sets "intel_idle.max_cstate=0", it will disable
intel_idle and fall back to acpi_idle instead. The acpi_idle code
will then call mwait_idle_with_hints() to enter idle state. So when
X86_FEATURE_KERNEL_IBRS is enabled, it is necessary to disable IBRS
within mwait_idle_with_hints() when IRQ was disabled to avoid performance
degradation on silbing thread running user workload.

Signed-off-by: Waiman Long <longman@redhat.com>
---
 arch/x86/include/asm/mwait.h | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/arch/x86/include/asm/mwait.h b/arch/x86/include/asm/mwait.h
index 778df05f8539..1e36cdc21661 100644
--- a/arch/x86/include/asm/mwait.h
+++ b/arch/x86/include/asm/mwait.h
@@ -108,15 +108,32 @@ static __always_inline void __sti_mwait(unsigned long eax, unsigned long ecx)
 static __always_inline void mwait_idle_with_hints(unsigned long eax, unsigned long ecx)
 {
 	if (static_cpu_has_bug(X86_BUG_MONITOR) || !current_set_polling_and_test()) {
+		bool ibrs_disabled = false;
+		u64 spec_ctrl;
+
 		if (static_cpu_has_bug(X86_BUG_CLFLUSH_MONITOR)) {
 			mb();
 			clflush((void *)&current_thread_info()->flags);
 			mb();
 		}
 
+		if (irqs_disabled() &&
+		    cpu_feature_enabled(X86_FEATURE_KERNEL_IBRS)) {
+			/* NMI always enable IBRS on exception entry */
+			ibrs_disabled = true;
+			spec_ctrl = spec_ctrl_current();
+			__this_cpu_write(x86_spec_ctrl_current, 0);
+			native_wrmsrl(MSR_IA32_SPEC_CTRL, 0);
+		}
+
 		__monitor((void *)&current_thread_info()->flags, 0, 0);
 		if (!need_resched())
 			__mwait(eax, ecx);
+
+		if (ibrs_disabled) {
+			native_wrmsrl(MSR_IA32_SPEC_CTRL, spec_ctrl);
+			__this_cpu_write(x86_spec_ctrl_current, spec_ctrl);
+		}
 	}
 	current_clr_polling();
 }
-- 
2.31.1

