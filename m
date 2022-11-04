Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4169B6191EC
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Nov 2022 08:27:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231537AbiKDH1o (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Nov 2022 03:27:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54024 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231570AbiKDH1X (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Nov 2022 03:27:23 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D3172982D
        for <linux-kernel@vger.kernel.org>; Fri,  4 Nov 2022 00:27:22 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 0D699218EF;
        Fri,  4 Nov 2022 07:27:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1667546841; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ZIOvMf0VCiOOdx+pSynOR3iuEcnpBNHWVTTFgfhwJA0=;
        b=EnjxfVY16idoJh9IIy4JkGsUyUCXsUVwU0w51egCCLg5DyQj3J7jxrbkA4rfngpNO2Pwv9
        wov57FtNfpnF/SBFt652DKi5Xmswq2R3f0Y6Q5BJrjFYmZf8ZvCWawW+KwYgwKKIJlgZd1
        wTqlkt/BxLqs95Vk1s+327B34/LytLo=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id BE74F1346F;
        Fri,  4 Nov 2022 07:27:20 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id wt8nLdi+ZGP8QAAAMHmgww
        (envelope-from <jgross@suse.com>); Fri, 04 Nov 2022 07:27:20 +0000
From:   Juergen Gross <jgross@suse.com>
To:     linux-kernel@vger.kernel.org, xen-devel@lists.xenproject.org,
        x86@kernel.org
Cc:     Juergen Gross <jgross@suse.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>
Subject: [PATCH v2 3/5] x86: drop 32-bit Xen PV guest code in update_task_stack()
Date:   Fri,  4 Nov 2022 08:26:59 +0100
Message-Id: <20221104072701.20283-4-jgross@suse.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20221104072701.20283-1-jgross@suse.com>
References: <20221104072701.20283-1-jgross@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Testing for Xen PV guest mode in a 32-bit only code section can be
dropped, as Xen PV guests are supported in 64-bit mode only.

While at it switch from boot_cpu_has() to cpu_feature_enabled() in the
64-bit part of the code.

Signed-off-by: Juergen Gross <jgross@suse.com>
---
 arch/x86/include/asm/switch_to.h | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/arch/x86/include/asm/switch_to.h b/arch/x86/include/asm/switch_to.h
index c08eb0fdd11f..5c91305d09d2 100644
--- a/arch/x86/include/asm/switch_to.h
+++ b/arch/x86/include/asm/switch_to.h
@@ -66,13 +66,10 @@ static inline void update_task_stack(struct task_struct *task)
 {
 	/* sp0 always points to the entry trampoline stack, which is constant: */
 #ifdef CONFIG_X86_32
-	if (static_cpu_has(X86_FEATURE_XENPV))
-		load_sp0(task->thread.sp0);
-	else
-		this_cpu_write(cpu_tss_rw.x86_tss.sp1, task->thread.sp0);
+	this_cpu_write(cpu_tss_rw.x86_tss.sp1, task->thread.sp0);
 #else
 	/* Xen PV enters the kernel on the thread stack. */
-	if (static_cpu_has(X86_FEATURE_XENPV))
+	if (cpu_feature_enabled(X86_FEATURE_XENPV))
 		load_sp0(task_top_of_stack(task));
 #endif
 }
-- 
2.35.3

