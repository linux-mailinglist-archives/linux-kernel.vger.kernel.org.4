Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7E8926191EE
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Nov 2022 08:28:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231420AbiKDH2H (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Nov 2022 03:28:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54244 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230382AbiKDH13 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Nov 2022 03:27:29 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 14CBC29C94
        for <linux-kernel@vger.kernel.org>; Fri,  4 Nov 2022 00:27:28 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id B9907218EE;
        Fri,  4 Nov 2022 07:27:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1667546846; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Ly27pQKB8zJ1EGsnrKjc1hdO+HpUmQnfYr1acXfsIKI=;
        b=pWWGyaE1jxFj4EjMVnygdiccjsW9T7hMUI/EjyWLk8AOcDK33Qd3GEW3K8SxWXeOgef95G
        4pBmTHfQ3c1oRljU9jKJyr7IKQEcy9YZVxjmPxb3hvDc/bi4jjizmVf1+YSdSVhgHNDng6
        z8vF1yxfGykjPIdwW/UFsd6/FHzWfwI=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 69AA81346F;
        Fri,  4 Nov 2022 07:27:26 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id RA1rGN6+ZGMMQQAAMHmgww
        (envelope-from <jgross@suse.com>); Fri, 04 Nov 2022 07:27:26 +0000
From:   Juergen Gross <jgross@suse.com>
To:     linux-kernel@vger.kernel.org, xen-devel@lists.xenproject.org,
        x86@kernel.org
Cc:     Juergen Gross <jgross@suse.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Andy Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>
Subject: [PATCH v2 4/5] x86: remove X86_FEATURE_XENPV usage in setup_cpu_entry_area()
Date:   Fri,  4 Nov 2022 08:27:00 +0100
Message-Id: <20221104072701.20283-5-jgross@suse.com>
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

Testing of X86_FEATURE_XENPV in setup_cpu_entry_area() can be removed,
as this code path is 32-bit only, and Xen PV guests are not supporting
32-bit mode.

Signed-off-by: Juergen Gross <jgross@suse.com>
---
V2:
- new patch
---
 arch/x86/mm/cpu_entry_area.c | 8 ++------
 1 file changed, 2 insertions(+), 6 deletions(-)

diff --git a/arch/x86/mm/cpu_entry_area.c b/arch/x86/mm/cpu_entry_area.c
index 6c2f1b76a0b6..42cd96e7d733 100644
--- a/arch/x86/mm/cpu_entry_area.c
+++ b/arch/x86/mm/cpu_entry_area.c
@@ -138,17 +138,13 @@ static void __init setup_cpu_entry_area(unsigned int cpu)
 	pgprot_t tss_prot = PAGE_KERNEL_RO;
 #else
 	/*
-	 * On native 32-bit systems, the GDT cannot be read-only because
+	 * On 32-bit systems, the GDT cannot be read-only because
 	 * our double fault handler uses a task gate, and entering through
 	 * a task gate needs to change an available TSS to busy.  If the
 	 * GDT is read-only, that will triple fault.  The TSS cannot be
 	 * read-only because the CPU writes to it on task switches.
-	 *
-	 * On Xen PV, the GDT must be read-only because the hypervisor
-	 * requires it.
 	 */
-	pgprot_t gdt_prot = boot_cpu_has(X86_FEATURE_XENPV) ?
-		PAGE_KERNEL_RO : PAGE_KERNEL;
+	pgprot_t gdt_prot = PAGE_KERNEL;
 	pgprot_t tss_prot = PAGE_KERNEL;
 #endif
 
-- 
2.35.3

